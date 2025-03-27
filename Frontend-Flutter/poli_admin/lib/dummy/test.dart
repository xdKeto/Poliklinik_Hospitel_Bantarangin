import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:poli_admin/base/backend/class/antrian_pasien.dart';
import 'package:poli_admin/base/backend/class/pasien.dart';
import 'package:poli_admin/base/backend/class/poliklinik.dart';
import 'package:poli_admin/base/backend/class/status_antrian.dart';
import 'package:poli_admin/base/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class DataController {
  static final DataController _instance = DataController._internal();

  factory DataController() {
    return _instance;
  }

  DataController._internal();

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
          headers: {"Content-Type": "application/json"},
        );
      } else if (method == "get") {
        response = await http.get(Uri.parse(url), headers: headers);
      } else if (method == "put") {
        response = await http.put(Uri.parse(url),
            body: json.encode(body),
            headers: {"Content-Type": "application/json"});
      } else {
        response = await http.delete(Uri.parse(url),
            body: json.encode(body),
            headers: {"Content-Type": "application/json"});
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

  Future<void> userLogout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('auth_token');
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString('auth_token');
  }

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

  Future<bool> cekPriv(int priv) async {
    String? token = await getToken();
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token!);
    print(decodedToken);

    if (decodedToken["privileges"] == null) {
      return false;
    }

    List privileges = decodedToken["privileges"];
    if (!privileges.contains(priv)) {
      return false;
    }

    return true;
  }

  Future<void> namaAdming() async {
    String? token = await getToken();
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token!);

    nama = decodedToken["nama"];
  }

  /* 
    GETTERS, FETCHERS
   */

  Future<List<StatusAntrian>> fetchListStatus() async {
    try {
      ResponseRequestAPI response =
          await apiConnector(Config.apiEndpoints['listStatus']!(), "get", "");
      print('list status: ${response.status}');
      if (response.data != null) {
        // Convert the raw data to StatusAntrian objects
        statusAntrian = (response.data as List)
            .map((item) => StatusAntrian.fromJson(item))
            .toList();
        print(statusAntrian);
      }
    } catch (e) {
      throw Exception('failed to fetch list status: $e');
    }

    return statusAntrian;
  }

  Future<List> fetchAntrianToday() async {
    try {
      ResponseRequestAPI response =
          await apiConnector(Config.apiEndpoints["antrianToday"]!(), "get", "");
      print('antrian today: ${response.status}');
      if (response.data != null) {
        antrianToday = response.data;
        print(antrianToday);
      }
    } catch (e) {
      throw Exception("failed to fetch antrian today: $e");
    }

    return antrianToday;
  }

  Future<List> fetchStatusTunggu() async {
    try {
      ResponseRequestAPI response =
          await apiConnector(Config.apiEndpoints["tungguStatus"]!(), "get", "");
      print('status tunggu: ${response.status}');
      if (response.data != null) {
        antrianTunggu = response.data;
        print(antrianTunggu);
      }
    } catch (e) {
      throw Exception("failed to fetch status tunda: $e");
    }

    return antrianTunggu;
  }

  Future<void> fetchStatusTunda() async {
    try {
      ResponseRequestAPI response =
          await apiConnector(Config.apiEndpoints["tundaStatus"]!(), "get", "");
      print('status tunda: ${response.status}');
      if (response.data != null) {
        antrianTunda = response.data;
        print(antrianTunda);
      }
    } catch (e) {
      throw Exception("failed to fetch status tunda: $e");
    }
  }

  Future<void> fetchStatusKonsul() async {
    try {
      ResponseRequestAPI response = await apiConnector(
          Config.apiEndpoints["konsultasiStatus"]!(), "get", "");
      print('status konsul: ${response.status}');
      if (response.data != null) {
        antrianKonsul = response.data;
        print(antrianKonsul);
      }
    } catch (e) {
      throw Exception("failed to fetch status konsul: $e");
    }
  }

  Future<void> fetchStatusSelesai() async {
    try {
      ResponseRequestAPI response = await apiConnector(
          Config.apiEndpoints["selesaiStatus"]!(), "get", "");
      print('status selesai: ${response.status}');
      if (response.data != null) {
        antrianSelesai = response.data;
        print(antrianSelesai);
      }
    } catch (e) {
      throw Exception("failed to fetch status selesai: $e");
    }
  }

  Future<void> fetchAllAntrian() async {
    fetchListStatus();
    fetchAntrianToday();
    fetchStatusTunggu();
    fetchStatusTunda();
    fetchStatusKonsul();
    fetchStatusSelesai();
  }

  Future<void> fetchAllData() async {
    namaAdming();
  }
}
