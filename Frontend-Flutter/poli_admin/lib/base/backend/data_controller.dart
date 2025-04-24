import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:poli_admin/base/backend/class/antrian_pasien.dart';
import 'package:poli_admin/base/backend/class/billing.dart';
import 'package:poli_admin/base/backend/class/pasien.dart';
import 'package:poli_admin/base/backend/class/poliklinik.dart';
import 'package:poli_admin/base/backend/class/status_antrian.dart';
import 'package:poli_admin/base/backend/web_socket_manager.dart';
import 'package:poli_admin/base/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class DataController {
  static final DataController _instance = DataController._internal();
  final WebSocketManager webSocketManager = WebSocketManager();

  // notify listeners
  final StreamController<List<AntrianPasien>> _antrianController =
      StreamController<List<AntrianPasien>>.broadcast();
  final StreamController<List<Billing>> _billingController =
      StreamController<List<Billing>>.broadcast();

  Stream<List<AntrianPasien>> get antrianStream => _antrianController.stream;
  Stream<List<Billing>> get billingStream => _billingController.stream;

  factory DataController() {
    return _instance;
  }

  DataController._internal() {
    _initWebSocket();
  }

/* 
    WEBSOCKET STUFF
  */

  void _initWebSocket() {
    webSocketManager.connect();
    webSocketManager.messageStream.listen((message) {
      if (message.containsKey('type')) {
        if (message['type'] == 'antrian_update') {
          _handleAntrianUpdate(message);
        } else if (message['type'] == 'billing_update') {
          _handleBillingUpdate(message);
        }
      } else if (message.containsKey('status') && message.containsKey('id_antrian')) {
        _handleAntrianStatusUpdate(message);
      }
    });
  }

  void _handleAntrianUpdate(Map<String, dynamic> message) {
    AntrianPasien antrian = AntrianPasien.fromJson(message['data']);

    int index = antrianToday.indexWhere((a) => a.idAntrian == antrian.idAntrian);
    if (index != -1) {
      antrianToday[index] = antrian;
    } else {
      antrianToday.add(antrian);
    }

    _antrianController.add(antrianToday);
  }

  void _handleAntrianStatusUpdate(Map<String, dynamic> message) {
    int idAntrian = message['id_antrian'];
    String status = message['status'];

    var statusNew = statusAntrian.firstWhere((s) => s.status == status,
        orElse: () => StatusAntrian(idStatus: 0, status: ""));

    int index = antrianToday.indexWhere((a) => a.idAntrian == idAntrian);
    if (index != -1) {
      AntrianPasien updated = AntrianPasien(
          idAntrian: antrianToday[index].idAntrian,
          idPasien: antrianToday[index].idPasien,
          idPoli: antrianToday[index].idPoli,
          idRm: antrianToday[index].idRm,
          idStatus: statusNew.idStatus,
          nama: antrianToday[index].nama,
          namaPoli: antrianToday[index].namaPoli,
          nomorAntrian: antrianToday[index].nomorAntrian,
          priorityOrder: antrianToday[index].priorityOrder,
          status: status);
      antrianToday[index] = updated;

      _antrianController.add(antrianToday);
    }
  }

  void _handleBillingUpdate(Map<String, dynamic> message) {
    Billing billingUpdate = Billing.fromJson(message['data']);

    int index = billing.indexWhere((a) => a.idKunjungan == billingUpdate.idKunjungan);

    if (index != -1) {
      billing[index] = billingUpdate;
    } else {
      billing.add(billingUpdate);
    }

    _updateListStatusBilling();
    _billingController.add(billing);
  }

  void _updateListStatusBilling() {
    billingStatusBelum = billing.where((b) => b.status == "Belum").toList();
    billingStatusProses = billing.where((b) => b.status == "Proses").toList();
    billingStatusSelesai = billing.where((b) => b.status == "Sudah").toList();
  }

  /* 
    LISTS
  */
  List user = [];
  List<AntrianPasien> antrianToday = [];
  List<StatusAntrian> statusAntrian = [];
  List<Poliklinik> poliAktif = [];
  List<Pasien> allPasien = [];
  String? nama;
  List<Billing> billing = [];
  List<Billing> billingStatusBelum = [];
  List<Billing> billingStatusProses = [];
  List<Billing> billingStatusSelesai = [];
  String? namaDokter;

  /* 
    MAIN API CALLERRRR 💪
  */
  Future<ResponseRequestAPI> apiConnector(String url, String method, dynamic body) async {
    try {
      http.Response response;
      String? token = await getToken();

      Map<String, String> headers = {
        "Content-Type": "application/json",
      };

      if (token != null && token.isNotEmpty) {
        headers["Authorization"] = "Bearer $token";
      }

      if (method == "post") {
        response = await http.post(
          Uri.parse(url),
          body: json.encode(body),
          headers: headers,
        );
        print(jsonEncode(body));
      } else if (method == "get") {
        response = await http.get(Uri.parse(url), headers: headers);
      } else if (method == "put") {
        response = await http.put(Uri.parse(url), body: json.encode(body), headers: headers);
      } else {
        response = await http.delete(Uri.parse(url), body: json.encode(body), headers: headers);
      }

      if (response.body.isEmpty) {
        return ResponseRequestAPI(status: response.statusCode, message: "Empty response", data: []);
      }

      Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      return ResponseRequestAPI(
        status: response.statusCode,
        message: jsonResponse.containsKey('message') ? jsonResponse['message'] : "No message",
        data: jsonResponse.containsKey('data') ? jsonResponse['data'] : "",
      );
    } catch (e) {
      print(e);
      return ResponseRequestAPI(status: 500, message: "Error: ${e.toString()}", data: []);
    }
  }

  /* 
    GENERAL FUNCTIONS
   */

  // logout
  Future<void> userLogout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('auth_token');
  }

  // get jwt token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString('auth_token');
  }

  // cek token masih ada? or expired
  Future<bool> cekToken() async {
    String? token = await getToken();
    print('token checked: $token');

    if (token == null) {
      return false;
    }

    bool expired = JwtDecoder.isExpired(token);

    if (expired) {
      print("Token is expired, logging out...");
      return false;
    }

    return true;
  }

  // decode jwt buat cek list privilege
  Future<bool> cekPriv(int priv) async {
    String? token = await getToken();
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token!);
    // print(decodedToken);

    if (decodedToken["privileges"] == null) {
      return false;
    }

    List privileges = decodedToken["privileges"];
    if (!privileges.contains(priv)) {
      return false;
    }

    return true;
  }

  // get nama (temporary)
  Future<void> namaAdming() async {
    String? token = await getToken();
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token!);

    nama = decodedToken["nama"];
    // print(nama);
  }

  // get nama dokter for printing
  Future<void> getNamaDokter(String id) async {
    try {
      ResponseRequestAPI response = await apiConnector(Config.apiEndpoints['detailAntrian']!(id), "get", "");

      if (response.data != null) {
        namaDokter = response.data['nama_dokter'];
      }
    } catch (e) {
      throw Exception("failed to get nama dokter: $e");
    }
  }

  /* 
    FETCHERS
   */

  // ===== ANTRIAN =====
  Future<List<StatusAntrian>> fetchListStatus() async {
    try {
      ResponseRequestAPI response =
          await apiConnector(Config.apiEndpoints['listStatus']!(), "get", "");
      // print('list status: ${response.status}');
      if (response.data != null) {
        statusAntrian =
            (response.data as List).map((item) => StatusAntrian.fromJson(item)).toList();
        // print(statusAntrian);
      }
    } catch (e) {
      throw Exception('failed to fecth list status: $e');
    }

    return statusAntrian;
  }

  Future<List<AntrianPasien>> fetchAntrianToday() async {
    try {
      ResponseRequestAPI response =
          await apiConnector(Config.apiEndpoints["antrianToday"]!(), "get", "");
      // print('antrian today: ${response.status}');
      if (response.data != null) {
        antrianToday = (response.data as List).map((item) => AntrianPasien.fromJson(item)).toList();
        // print(antrianToday);
      }
    } catch (e) {
      throw Exception("failed to fetch antrian today: $e");
    }

    return antrianToday;
  }

  Future<List<Poliklinik>> fetchPoliAktif() async {
    try {
      ResponseRequestAPI response =
          await apiConnector(Config.apiEndpoints["poliAktif"]!(), "get", "");
      // print('poli aktif: ${response.status}');
      if (response.data != null) {
        poliAktif = (response.data as List).map((item) => Poliklinik.fromJson(item)).toList();
        // print(poliAktif);
      }
    } catch (e) {
      throw Exception("failed to fetch poli aktif: $e");
    }

    return poliAktif;
  }

  Future<List<Pasien>> fetchAllPasien(String nama, String page) async {
    print("seraching for: $nama");
    try {
      ResponseRequestAPI response =
          await apiConnector(Config.apiEndpoints["allPasien"]!(nama, page), "get", "");
      print("all pasien: ${response.status}");
      if (response.data != null) {
        allPasien = (response.data as List).map((item) => Pasien.fromJson(item)).toList();

        // print(allPasien);
      } else {
        return [];
      }
    } catch (e) {
      throw Exception("failed to fetch all pasien: $e");
    }

    return allPasien;
  }

  // ===== BILLING =====
  Future<List<Billing>> fetchBilling() async {
    try {
      ResponseRequestAPI response =
          await apiConnector(Config.apiEndpoints["allBilling"]!(), "get", "");
      // print('billing: ${response.status}');
      if (response.data != null) {
        billing = (response.data as List).map((item) => Billing.fromJson(item)).toList();
        // print("billing: $billing");
      }
    } catch (e) {
      throw Exception(e);
    }

    return billing;
  }

  Future<List<Billing>> fetchBillingBelum() async {
    try {
      ResponseRequestAPI response =
          await apiConnector(Config.apiEndpoints["billingStatusBelum"]!(), "get", "");
      // print('billing by status: ${response.status}');
      if (response.data != null) {
        billingStatusBelum = (response.data as List).map((item) => Billing.fromJson(item)).toList();
      }
    } catch (e) {
      throw Exception(e);
    }

    return billingStatusBelum;
  }

  Future<List<Billing>> fetchBillingProses() async {
    try {
      ResponseRequestAPI response =
          await apiConnector(Config.apiEndpoints["billingStatusProses"]!(), "get", "");
      // print('billing by status: ${response.status}');
      if (response.data != null) {
        billingStatusProses =
            (response.data as List).map((item) => Billing.fromJson(item)).toList();
      }
    } catch (e) {
      throw Exception(e);
    }

    return billingStatusProses;
  }

  Future<List<Billing>> fetchBillingSelesai() async {
    try {
      ResponseRequestAPI response =
          await apiConnector(Config.apiEndpoints["billingStatusSudah"]!(), "get", "");
      // print('billing by status: ${response.status}');
      if (response.data != null) {
        billingStatusSelesai =
            (response.data as List).map((item) => Billing.fromJson(item)).toList();
      }
    } catch (e) {
      throw Exception(e);
    }

    return billingStatusSelesai;
  }

  Future<void> fetchAllAntrian() async {
    fetchAntrianToday();
  }

  Future<void> fetchAllBilling() async {
    fetchBilling();
    fetchBillingBelum();
    fetchBillingProses();
    fetchBillingSelesai();
  }

  Future<void> fetchFirstData() async {
    namaAdming();
  }
}
