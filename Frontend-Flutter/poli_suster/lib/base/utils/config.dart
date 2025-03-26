class Config {
  static const String apiURL =
      'http://leap.crossnet.co.id:8080/api/screening';

      // API ENDPOINTS
      static final apiEndpoints = {
        'login': () => '$apiURL/suster/login',
        'dropdownPoli': () => '$apiURL/poliklinik',
        'inputScreening': (String id) => '$apiURL/input?id_antrian=$id',
        'riwayatScreening': (String id)=> '$apiURL?id_pasien=$id',
        'antrianNow': (int id) => '$apiURL/antrian/terlama?id_poli=$id',

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
