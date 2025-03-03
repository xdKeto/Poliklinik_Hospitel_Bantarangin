import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:poli_admin/base/utils/config.dart';

class DataController {
  Future<ResponseRequestAPI> apiConnector(
      String url, String method, dynamic body) async {
    print(body);
    try {
      http.Response response;
      if (method == "post") {
        response = await http.post(
          Uri.parse(url),
          body: json.encode(body),
          headers: {"Content-Type": "application/json"},
        );
        print(jsonEncode(body));
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
      print(response.statusCode);
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
        data: jsonResponse.containsKey('data') ? jsonResponse['data'] : [],
      );
    } catch (e) {
      return ResponseRequestAPI(
          status: 500, message: "Error: ${e.toString()}", data: []);
    }
  }
}
