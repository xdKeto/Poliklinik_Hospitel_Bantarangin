import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:poli_suster/base/backend/class/antrian.dart';
import 'package:poli_suster/base/backend/class/poliklinik.dart';
import 'package:poli_suster/base/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  List<Poliklinik> poliAktif = [];
  Antrian antrianNow = Antrian(idAntrian: 0, nomorAntrian: 0);
  String nama = "";
  int? idPoli;

  //
  /* 
    MAIN API CALLERRRR 💪
   */
  //
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
      // print(response.statusCode);
      // print(response.body);

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
  //  ==== USER =====
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

  Future<int> getExpiration() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getInt('auth_token_expiration') ?? 0;
  }

   Future<int> getLoggedInPoli() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getInt('logged_in_idPoli') ?? 0;
  }

  Future<bool> cekPriv(int priv) async {
    String? token = await getToken();
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token!);

    if (decodedToken["privileges"] == null) {
      return false;
    }

    List privileges = decodedToken["privileges"];
    if (!privileges.contains(priv)) {
      return false;
    }

    return true;
  }

  Future<void> namaSuster() async {
    String? token = await getToken();
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token!);
    nama = decodedToken["nama"];

    List<String> namaL = nama.split(" ");

    nama = namaL.isNotEmpty ? namaL.first : "";
  }

  void setPoli(int id) {
    idPoli = id;
  }

 
  //  ==== USER =====

  //
  /* 
    FETCHERS
   */
  //
  Future<List<Poliklinik>> fetchPoli() async {
    try {
      ResponseRequestAPI response =
          await apiConnector(Config.apiEndpoints["dropdownPoli"]!(), "get", "");
      print("dropdown poli: ${response.status}");
      if (response.data != null) {
        poliAktif =
            (response.data as List).map((e) => Poliklinik.fromJson(e)).toList();
      }
    } catch (e) {
      throw Exception("failed to fetch poli aktif: $e");
    }

    return poliAktif;
  }

  Future<Antrian> fetchAntrian(int id) async {
    try {
      ResponseRequestAPI response =
          await apiConnector(Config.apiEndpoints["antrianNow"]!(id), "get", "");

      if (response.data != null) {
        antrianNow = Antrian.fromJson(response.data);
        print("antrian now: ${antrianNow.nomorAntrian}");
      }
    } catch (e) {
      throw Exception("failed to fetch antrian: $e");
    }

    return antrianNow;
  }

  Future<void> fetchFirstData(int id) async {
    await fetchAntrian(id);
    namaSuster();
  }
}
