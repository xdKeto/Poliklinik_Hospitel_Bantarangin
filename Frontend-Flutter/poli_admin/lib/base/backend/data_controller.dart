import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:poli_admin/base/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class DataController {
  static final DataController _instance = DataController._internal();

  factory DataController() {
    return _instance;
  }

  DataController._internal();

  //
  /* 
    LISTS
   */
  //
  List user = [];
  List antrianToday = [];
  List statusAntrian = [];
  List poliAktif = [];
  List allPasien = [];
  String? nama;

  //
  /* 
    MAIN API CALLERRRR 💪
   */
  //

  Future<ResponseRequestAPI> apiConnector(
      String url, String method, dynamic body) async {
    // print(body);
    try {
      http.Response response;
      if (method == "post") {
        response = await http.post(
          Uri.parse(url),
          body: json.encode(body),
          headers: {"Content-Type": "application/json"},
        );
        // print(jsonEncode(body));
      } else if (method == "get") {
        response = await http.get(Uri.parse(url));
      } else if (method == "put") {
        response = await http.put(Uri.parse(url),
            body: json.encode(body),
            headers: {"Content-Type": "application/json"});
      } else {
        response = await http.delete(Uri.parse(url),
            body: json.encode(body),
            headers: {"Content-Type": "application/json"});
      }
      // print(response.statusCode);
      print(response.body);

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

  //
  /* 
    FUNCTIONS
   */
  //

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

  // get nama (temporary)
  Future<void> namaAdming() async {
    String? token = await getToken();
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token!);

    nama = decodedToken["nama"];
    print(nama);
  }
  // ===== USER =====

  //
  /* 
    GETTERS, FETCHERS
   */
  //

  // ===== ANTRIAN =====
  Future<void> fetchListStatus() async {
    try {
      ResponseRequestAPI response =
          await apiConnector(Config.apiEndpoints['listStatus']!(), "get", "");
      print(response.status);
      if (response.status == 200) {
        print(response.data);
      } else if (response.status == 401) {
        print(response.message);
      } else {
        print(response.message);
      }
    } catch (e) {
      throw Exception('failed to fecth list status: $e');
    }
  }

  Future<void> fetchAntrianToday() async {
    try {
      ResponseRequestAPI response =
          await apiConnector(Config.apiEndpoints["antrianToday"]!(), "get", "");
      print(response.status);
      if (response.status == 200) {
        print(response.data);
      } else if (response.status == 401) {
        print(response.message);
      } else {
        print(response.message);
      }
    } catch (e) {
      throw Exception("failed to fetch antrian today: $e");
    }
  }

  Future<void> fetchStatusTunggu() async {
    try {
      ResponseRequestAPI response =
          await apiConnector(Config.apiEndpoints["tungguStatus"]!(), "get", "");
      print(response.status);
      if (response.status == 200) {
        print(response.data);
      } else if (response.status == 401) {
        print(response.message);
      } else {
        print(response.message);
      }
    } catch (e) {
      throw Exception("failed to fetch status tunda: $e");
    }
  }

  Future<void> fetchStatusTunda() async {
    try {
      ResponseRequestAPI response =
          await apiConnector(Config.apiEndpoints["tundaStatus"]!(), "get", "");
      print(response.status);
      if (response.status == 200) {
        print(response.data);
      } else if (response.status == 401) {
        print(response.message);
      } else {
        print(response.message);
      }
    } catch (e) {
      throw Exception("failed to fetch status tunda: $e");
    }
  }

  Future<void> fetchStatusKonsul() async {
    try {
      ResponseRequestAPI response = await apiConnector(
          Config.apiEndpoints["konsultasiStatus"]!(), "get", "");
      print(response.status);
      if (response.status == 200) {
        print(response.data);
      } else if (response.status == 401) {
        print(response.message);
      } else {
        print(response.message);
      }
    } catch (e) {
      throw Exception("failed to fetch status konsul: $e");
    }
  }

  Future<void> fetchStatusSelesai() async {
    try {
      ResponseRequestAPI response = await apiConnector(
          Config.apiEndpoints["selesaiStatus"]!(), "get", "");
      print(response.status);
      if (response.status == 200) {
        print(response.data);
      } else if (response.status == 401) {
        print(response.message);
      } else {
        print(response.message);
      }
    } catch (e) {
      throw Exception("failed to fetch status selesai: $e");
    }
  }

  Future<void> putTundaAntrian(String id) async {
    try {
      ResponseRequestAPI response = await apiConnector(
          Config.apiEndpoints["tundaAntrian"]!(id), "put", "");
      print(response.status);
      if (response.status == 200) {
        print(response.data);
      } else if (response.status == 401) {
        print(response.message);
      } else {
        print(response.message);
      }
    } catch (e) {
      throw Exception("failed to tunda antrian: $e");
    }
  }

  Future<void> putAntrian(String idAntrian, String idPoli) async {
    try {
      ResponseRequestAPI response = await apiConnector(
          Config.apiEndpoints["putAntrian"]!(idAntrian, idPoli), "put", "");
      print(response.status);
      if (response.status == 200) {
        print(response.data);
      } else if (response.status == 401) {
        print(response.message);
      } else {
        print(response.message);
      }
    } catch (e) {
      throw Exception("failed to masukin antrian: $e");
    }
  }

  // ===== REGISTRASI =====
  Future<void> fetchPoliAktif() async {
    try {
      ResponseRequestAPI response =
          await apiConnector(Config.apiEndpoints["poliAktif"]!(), "get", "");
      print(response.status);
      if (response.status == 200) {
        print(response.data);
      } else if (response.status == 401) {
        print(response.message);
      } else {
        print(response.message);
      }
    } catch (e) {
      throw Exception("failed to fetch poli aktif");
    }
  }

  Future<void> fetchAllPasien() async {
    try {
      ResponseRequestAPI response =
          await apiConnector(Config.apiEndpoints["allPasien"]!(), "get", "");
      print(response.status);
      if (response.status == 200) {
        print(response.data);
      } else if (response.status == 401) {
        print(response.message);
      } else {
        print(response.message);
      }
    } catch (e) {
      throw Exception("failed to fetch all pasien");
    }
  }

  Future<void> registerPasien() async {
    try {
      ResponseRequestAPI response =
          await apiConnector(Config.apiEndpoints["registerPasien"]!(), "post", "");
      print(response.status);
      if (response.status == 200) {
        print(response.data);
      } else if (response.status == 401) {
        print(response.message);
      } else {
        print(response.message);
      }
    } catch (e) {
      throw Exception("failed to fetch all pasien");
    }
  }



  Future<void> fetchAllAntrian() async {
    print('list status antrian fetched');
    fetchListStatus();
    print('antrian today fetched');
    fetchAntrianToday();
    print('status tunggu fetched');
    fetchStatusTunggu();
    print('status tunda fetched');
    fetchStatusTunda();
    print('status konsul fetched');
    fetchStatusKonsul();
    print('status selesai fetched');
    fetchStatusSelesai();
  }

  Future<void> fetchAllBilling() async {}

  Future<void> fetchAllData() async {
    print("nama fetched");
    namaAdming();
  }
}
