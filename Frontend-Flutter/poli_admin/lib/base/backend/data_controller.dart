import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:poli_admin/base/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class DataController {
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
        data: jsonResponse.containsKey('data') ? jsonResponse['data'] : [],
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
  Future<String> namaAdming() async {
    String? token = await getToken();
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token!);

    return decodedToken["username"];
  }

  late String nama;
  // ===== USER =====


  //
  /* 
    GETTERS, FETCHERS
   */
  //
}
