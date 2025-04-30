import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:poli_suster/base/backend/class/antrian.dart';
import 'package:poli_suster/base/backend/class/detail_pasien.dart';
import 'package:poli_suster/base/backend/class/poliklinik.dart';
import 'package:poli_suster/base/backend/class/riwayat_pasien.dart';
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
  Antrian? antrianNow;
  DetailPasien? detailPasien;
  String nama = "";
  int? idPoli;
  List<RiwayatPasien> riwayatPasien = [];

  //
  /* 
    MAIN API CALLERRRR 💪
   */
  //
  Future<ResponseRequestAPI> apiConnector(
      String url, String method, dynamic body) async {
    if (!await isTokenValid() &&
        url != Config.apiEndpoints["login"]!() &&
        url != Config.apiEndpoints["dropdownPoli"]!() &&
        url != Config.apiEndpoints["antrianNow"]!()) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth_token');

      return ResponseRequestAPI(
        status: 401,
        message: "Session expired, please login again",
        data: [],
      );
    }

    // Proceed with normal API call
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
        // print(jsonEncode(body));
      } else if (method == "get") {
        // print("headers: $headers");
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
      print("API Error: $url - $e");

      String errorMessage = "Terjadi kesalahan";
      int statusCode = 500;

      if (e is SocketException) {
        errorMessage = "Tidak dapat terhubung ke server";
        statusCode = 503;
      } else if (e is TimeoutException) {
        errorMessage = "Koneksi timeout";
        statusCode = 504;
      } else if (e is FormatException) {
        errorMessage = "Format data tidak valid";
        statusCode = 422;
      }

      return ResponseRequestAPI(
          status: statusCode, message: errorMessage, data: []);
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

  Future<bool> isTokenValid() async {
    final token = await getToken();
    if (token == null) return false;

    try {
      final expiration = await getExpiration();
      if (expiration == 0) return false;

      final expirationDate = DateTime.fromMillisecondsSinceEpoch(expiration);
      // print("expired: $expirationDate");
      final now = DateTime.now();
      // print("now: $now");
      final buffer = const Duration(minutes: 1);
      return now.add(buffer).isBefore(expirationDate);
    } catch (e) {
      print("Error checking token validity: $e");
      return false;
    }
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
      // print("dropdown poli: ${response.status}");
      // print("dropdown poli: ${response.message}");
      if (response.data != null) {
        poliAktif =
            (response.data as List).map((e) => Poliklinik.fromJson(e)).toList();
      }
    } catch (e) {
      throw Exception("failed to fetch poli aktif: $e");
    }

    return poliAktif;
  }

  Future<List<RiwayatPasien>> fetchRiwayatScreening(int id) async {
    try {
      ResponseRequestAPI response = await apiConnector(
          Config.apiEndpoints["riwayatScreening"]!(id.toString()), "get", "");

      if (response.data != null) {
        riwayatPasien = (response.data as List)
            .map((e) => RiwayatPasien.fromJson(e))
            .toList();
      }
    } catch (e) {
      throw Exception("failed to fetch riwayat screening: $e");
    }

    return riwayatPasien;
  }

  Future<void> fetchFirstData(int id) async {
    try {
      await namaSuster();
    } catch (e) {
      throw Exception("failed to fetch first data: $e");
    }
  }

  Future<Antrian?> nextPatient(int id) async {
    try {
      // cek ada antrian screening atau ndak
      ResponseRequestAPI response1 = await apiConnector(
          Config.apiEndpoints["antrianScreening"]!(id), "get", "");

      if (response1.data != null) {
        // kalo ada fetch detail pake id paling atas
        ResponseRequestAPI response2 = await apiConnector(
            Config.apiEndpoints["detailScreening"]!(
                response1.data[0]["id_antrian"].toString()),
            "get",
            "");

        if (response2.data != null) {
          antrianNow = Antrian.fromJson(response2.data);
          if (antrianNow != null) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setInt('current_id_antrian', antrianNow!.idAntrian);

            // print(antrianNow!.idAntrian);
            await fetchDetailPasien(antrianNow!.idAntrian.toString());
            await fetchRiwayatScreening(antrianNow!.idPasien);
          }
          return antrianNow;
        }
      } else {
        // kalau ngga ada baru ambil dari status tunggu
        ResponseRequestAPI response3 = await apiConnector(
            Config.apiEndpoints["dataAntrian"]!(id.toString()), "put", "");

        if (response3.status == 401) {
          return null;
        }

        if (response3.data != null) {
          antrianNow = Antrian.fromJson(response3.data);

          if (antrianNow != null) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setInt('current_id_antrian', antrianNow!.idAntrian);

            await fetchDetailPasien(antrianNow!.idAntrian.toString());
            await fetchRiwayatScreening(antrianNow!.idPasien);
          }
          return antrianNow;
        } else {
          antrianNow = null;
          return null;
        }
      }
    } catch (e) {
      throw Exception("failed to fetch next patient: $e");
    }

    return antrianNow;
  }

  Future<DetailPasien?> fetchDetailPasien(String id) async {
    try {
      ResponseRequestAPI response = await apiConnector(
          Config.apiEndpoints["rincianAsesmen"]!(id), "get", "");

      if (response.data != null) {
        detailPasien = DetailPasien.fromJson(response.data);
      }
    } catch (e) {
      throw Exception("failed to fetch detail pasien: $e");
    }

    return detailPasien;
  }
}
