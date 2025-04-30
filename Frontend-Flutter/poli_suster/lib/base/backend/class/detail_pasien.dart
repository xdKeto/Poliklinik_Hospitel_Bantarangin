class DetailPasien {
  final String keluhanUtama;
  final String riwayatPenyakit;
  final String alergi;
  final String jenisReaksi;
  final String keadaanUmumPasien;

  DetailPasien({
    required this.keluhanUtama,
    required this.riwayatPenyakit,
    required this.alergi,
    required this.jenisReaksi,
    required this.keadaanUmumPasien,
  });

  factory DetailPasien.fromJson(Map<String, dynamic> json) {
    return DetailPasien(
      keluhanUtama: json['keluhan_utama'] ?? '',
      riwayatPenyakit: json['riwayat_penyakit'] ?? '',
      alergi: json['alergi'] ?? '',
      jenisReaksi: json['jenis_reaksi'] ?? '',
      keadaanUmumPasien: json['keadaan_umum_pasien'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'keluhan_utama': keluhanUtama,
      'riwayat_penyakit': riwayatPenyakit,
      'alergi': alergi,
      'jenis_reaksi': jenisReaksi,
      'keadaan_umum_pasien': keadaanUmumPasien,
    };
  }
}
