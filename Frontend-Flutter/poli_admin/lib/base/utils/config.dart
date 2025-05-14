class Config {
  static const String apiURL = 'http://leap.crossnet.co.id:8080/api/administrasi';

  // API ENDPOINTS

  static final apiEndpoints = {
    'login': () => '$apiURL/login',

    // ANTRIAN
    'listStatus': () => '$apiURL/status_antrian',
    'antrianToday': () => '$apiURL/antrian/today',
    'tungguStatus': () => '$apiURL/antrian/today?status=Menunggu',
    'tundaStatus': () => '$apiURL/antrian/today?status=Ditunda',
    'konsultasiStatus': () => '$apiURL/antrian/today?status=Konsultasi',
    'selesaiStatus': () => '$apiURL/antrian/today?status=Selesai',
    'tundaAntrian': (String id) => '$apiURL/antrian/tunda?id_antrian=$id', // PUT
    'putAntrian': (String id) => '$apiURL/antrian/reschedule?id_antrian=$id', // PUT
    'batalAntrian': (String id) => '$apiURL/antrian/batalkan?id_antrian=$id', // PUT
    'detailAntrian': (String id) => '$apiURL/detail-antrian?id_antrian=$id',

    // REGISTRASI
    'poliAktif': () => '$apiURL/poliklinik?status=aktif',
    'allPasien': (String nama, String page) => '$apiURL/pasien?nama=$nama&page=$page&limit=20',
    'registerPasien': () => '$apiURL/pasien/register', //POST
    'putPasien': () => '$apiURL/kunjungan', //PUT

    // BILLING
    'allBilling': () => '$apiURL/billing',
    'detailBilling': (String id) => '$apiURL/billing/detail?id_kunjungan=$id',

    // RIWAYAT
    'allRiwayat': () => '$apiURL/billing?status=2',
    // detail riwayat pake detail billing
    

    // WEBSOCKET
    'wsUrl': () => 'ws://leap.crossnet.co.id:8080/api/ws'
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
