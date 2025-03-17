class Config {
  static const String apiURL =
      'http://leap.crossnet.co.id:8080/api/administrasi';

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
    'tundaAntrian': (String id) => '$apiURL/kunjungan/tunda?id_antrian=$id', // PUT
    'putAntrian': (String idAntrian, String idPoli) =>
        '$apiURL/kunjungan/reschedule?id_antrian=$idAntrian&id_poli=$idPoli', // PUT

    // REGISTRASI
    'poliAktif': () => '$apiURL/poliklinik?status=aktif',
    'allPasien': (String nama, String page) => '$apiURL/pasien?nama=$nama&page=$page&limit=20',
    'registerPasien': () => '$apiURL/pasien/register', //POST
    'putPasien': () => '$apiURL/kunjungan', //PUT

    // BILLING
    'billingByPoli': (String id) => '$apiURL/billing?id_poli=$id',
    'billingByStatus': (String id) => '$apiURL/billing?status=$id',
    'billingByBoth': (String idPoli, String statusPoli) =>
        '$apiURL/billing?id_poli=$idPoli&status=$statusPoli',
    'allBilling': () => '$apiURL/billing'
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
