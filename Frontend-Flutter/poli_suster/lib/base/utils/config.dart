class Config {
  static const String apiURL =
      'http://leap.crossnet.co.id:8080/api/screening';

      // API ENDPOINTS
      static final apiEndpoints = {
        'login': () => '$apiURL/suster/login',
        // dropdown poli
        'dropdownPoli': () => '$apiURL/poliklinik',

        // INPUT
        'inputScreening': (String id) => '$apiURL/input?id_antrian=$id',

        // RIWAYAT
        'riwayatScreening': (String id)=> '$apiURL?id_pasien=$id'.codeUnits


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
