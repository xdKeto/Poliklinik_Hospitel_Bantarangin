class Config {
  static const String apiURL = 'http://leap.crossnet.co.id:8080/api/screening';

  // API ENDPOINTS
  static final apiEndpoints = {
    'login': () => '$apiURL/suster/login',
    'dropdownPoli': () => '$apiURL/poliklinik',
    'inputScreening': (String id) => '$apiURL/input?id_antrian=$id',
    'riwayatScreening': (String id) => '$apiURL?id_pasien=$id',
    'antrianScreening': (int id) => '$apiURL/antrian?id_poli=$id',
    'dataAntrian': (String id) => '$apiURL/masukkan?id_poli=$id',
    'alihkanScreening': (String id) => '$apiURL/alihkan-pasien?id_antrian=$id',
    'tundaAntrian': (String id) =>
        'http://leap.crossnet.co.id:8080/api/administrasi/antrian/tunda?id_antrian=$id',
    'detailScreening': (String id) => '$apiURL/detail-antrian?id_antrian=$id',
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
