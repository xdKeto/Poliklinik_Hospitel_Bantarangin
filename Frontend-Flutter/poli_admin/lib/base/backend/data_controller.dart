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

  DataController._internal(){
    _initWebSocket();
  }

/* 
    WEBSOCKET STUFF
  */

  void _initWebSocket() {
    webSocketManager.connect();
    webSocketManager.messageStream.listen((message) {
      print('received message: $message');
    });
  }


  /* 
    LISTS
  */
  List user = [];
  List<AntrianPasien> antrianToday = [];
  List<AntrianPasien> antrianTunggu = [];
  List<AntrianPasien> antrianTunda = [];
  List<AntrianPasien> antrianKonsul = [];
  List<AntrianPasien> antrianSelesai = [];
  List<StatusAntrian> statusAntrian = [];
  List<Poliklinik> poliAktif = [];
  List<Pasien> allPasien = [];
  String? nama;
  List<Billing> billing = [];
  List<Billing> billingStatusBelum = [];
  List<Billing> billingStatusProses = [];
  List<Billing> billingStatusSelesai = [];

  
  /* 
    MAIN API CALLERRRR 💪
  */
  Future<ResponseRequestAPI> apiConnector(
      String url, String method, dynamic body) async {
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
        response = await http.put(Uri.parse(url),
            body: json.encode(body), headers: headers);
      } else {
        response = await http.delete(Uri.parse(url),
            body: json.encode(body), headers: headers);
      }

      if (response.body.isEmpty) {
        return ResponseRequestAPI(
            status: response.statusCode, message: "Empty response", data: []);
      }

      Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      return ResponseRequestAPI(
        status: response.statusCode,
        message: jsonResponse.containsKey('message')
            ? jsonResponse['message']
            : "No message",
        data: jsonResponse.containsKey('data') ? jsonResponse['data'] : "",
      );
    } catch (e) {
      print(e);
      return ResponseRequestAPI(
          status: 500, message: "Error: ${e.toString()}", data: []);
    }
  }

  /* 
    FUNCTIONS
   */

  // ===== USER =====
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
  // ===== USER =====

  /* 
    FETCHERS
   */

  // ===== ANTRIAN =====
  Future<List<StatusAntrian>> fetchListStatus() async {
    try {
      ResponseRequestAPI response =
          await apiConnector(Config.apiEndpoints['listStatus']!(), "get", "");
      print('list status: ${response.status}');
      if (response.data != null) {
        statusAntrian = (response.data as List)
            .map((item) => StatusAntrian.fromJson(item))
            .toList();
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
      print('antrian today: ${response.status}');
      if (response.data != null) {
        antrianToday = (response.data as List)
            .map((item) => AntrianPasien.fromJson(item))
            .toList();
        // print(antrianToday);
      }
    } catch (e) {
      throw Exception("failed to fetch antrian today: $e");
    }

    return antrianToday;
  }

  Future<List<AntrianPasien>> fetchStatusTunggu() async {
    try {
      ResponseRequestAPI response =
          await apiConnector(Config.apiEndpoints["tungguStatus"]!(), "get", "");
      print('status tunggu: ${response.status}');
      if (response.data != null) {
        antrianTunggu = (response.data as List)
            .map((item) => AntrianPasien.fromJson(item))
            .toList();
        // print(antrianTunggu);
      }
    } catch (e) {
      throw Exception("failed to fetch status tunda: $e");
    }

    return antrianTunggu;
  }

  Future<List<AntrianPasien>> fetchStatusTunda() async {
    try {
      ResponseRequestAPI response =
          await apiConnector(Config.apiEndpoints["tundaStatus"]!(), "get", "");
      print('status tunda: ${response.status}');
      if (response.data != null) {
        antrianTunda = (response.data as List)
            .map((item) => AntrianPasien.fromJson(item))
            .toList();
        // print(antrianTunda);
      }
    } catch (e) {
      throw Exception("failed to fetch status tunda: $e");
    }

    return antrianTunda;
  }

  Future<List<AntrianPasien>> fetchStatusKonsul() async {
    try {
      ResponseRequestAPI response = await apiConnector(
          Config.apiEndpoints["konsultasiStatus"]!(), "get", "");
      print('status konsul: ${response.status}');
      if (response.data != null) {
        antrianKonsul = (response.data as List)
            .map((item) => AntrianPasien.fromJson(item))
            .toList();
        // print(antrianKonsul);
      }
    } catch (e) {
      throw Exception("failed to fetch status konsul: $e");
    }

    return antrianKonsul;
  }

  Future<List<AntrianPasien>> fetchStatusSelesai() async {
    try {
      ResponseRequestAPI response = await apiConnector(
          Config.apiEndpoints["selesaiStatus"]!(), "get", "");
      print('status selesai: ${response.status}');
      if (response.data != null) {
        antrianSelesai = (response.data as List)
            .map((item) => AntrianPasien.fromJson(item))
            .toList();
        // print(antrianSelesai);
      }
    } catch (e) {
      throw Exception("failed to fetch status selesai: $e");
    }

    return antrianSelesai;
  }

  Future<List<Poliklinik>> fetchPoliAktif() async {
    try {
      ResponseRequestAPI response =
          await apiConnector(Config.apiEndpoints["poliAktif"]!(), "get", "");
      print('poli aktif: ${response.status}');
      if (response.data != null) {
        poliAktif = (response.data as List)
            .map((item) => Poliklinik.fromJson(item))
            .toList();
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
      ResponseRequestAPI response = await apiConnector(
          Config.apiEndpoints["allPasien"]!(nama, page), "get", "");
      print("all pasien: ${response.status}");
      if (response.data != null) {
        allPasien = (response.data as List)
            .map((item) => Pasien.fromJson(item))
            .toList();

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
      print('billing: ${response.status}');
      if (response.data != null) {
        billing = (response.data as List)
            .map((item) => Billing.fromJson(item))
            .toList();
        // print("billing: $billing");
      }
    } catch (e) {
      throw Exception(e);
    }

    return billing;
  }

  Future<List<Billing>> fetchBillingBelum() async {
    try {
      ResponseRequestAPI response = await apiConnector(
          Config.apiEndpoints["billingStatusBelum"]!(), "get", "");
      print('billing by status: ${response.status}');
      if (response.data != null) {
        billingStatusBelum = (response.data as List)
            .map((item) => Billing.fromJson(item))
            .toList();
      }
    } catch (e) {
      throw Exception(e);
    }

    return billingStatusBelum;
  }

  Future<List<Billing>> fetchBillingProses() async {
    try {
      ResponseRequestAPI response = await apiConnector(
          Config.apiEndpoints["billingStatusProses"]!(), "get", "");
      print('billing by status: ${response.status}');
      if (response.data != null) {
        billingStatusProses = (response.data as List)
            .map((item) => Billing.fromJson(item))
            .toList();
      }
    } catch (e) {
      throw Exception(e);
    }

    return billingStatusProses;
  }

  Future<List<Billing>> fetchBillingSelesai() async {
    try {
      ResponseRequestAPI response = await apiConnector(
          Config.apiEndpoints["billingStatusSudah"]!(), "get", "");
      print('billing by status: ${response.status}');
      if (response.data != null) {
        billingStatusSelesai = (response.data as List)
            .map((item) => Billing.fromJson(item))
            .toList();
      }
    } catch (e) {
      throw Exception(e);
    }

    return billingStatusSelesai;
  }

  Future<void> fetchAllAntrian() async {
    fetchAntrianToday();
    fetchStatusTunggu();
    fetchStatusTunda();
    fetchStatusKonsul();
    fetchStatusSelesai();
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
