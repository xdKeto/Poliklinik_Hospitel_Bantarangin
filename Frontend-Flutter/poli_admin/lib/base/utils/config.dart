class Config {
  static const String apiURL =
      'http://leap.crossnet.co.id:8080/api/administrasi';

  // API ENDPOINTS

  static final apiEndpoints = {
    'login': () => '$apiURL/login',
  };
}

class ResponseRequestAPI {
  int status = 0;
  String message = "";
  dynamic data = [];
  ResponseRequestAPI({
    required this.status,
    required this.message,
    required this.data,
  });
}
