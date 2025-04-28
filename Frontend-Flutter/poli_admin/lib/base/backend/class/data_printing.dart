class DataPrinting {
  final String alamat;
  final int idAntrian;
  final int idPasien;
  final String idRm;
  final String jenisKelamin;
  final String kecamatan;
  final String keluhanUtama;
  final String kelurahan;
  final String kota;
  final String? namaDokter;
  final String namaPasien;
  final String nik;
  final String noTelp;
  final int nomorAntrian;
  final String tanggalLahir;
  final String tempatLahir;
  final int umur;

  DataPrinting({
    required this.alamat,
    required this.idAntrian,
    required this.idPasien,
    required this.idRm,
    required this.jenisKelamin,
    required this.kecamatan,
    required this.keluhanUtama,
    required this.kelurahan,
    required this.kota,
    required this.namaDokter,
    required this.namaPasien,
    required this.nik,
    required this.noTelp,
    required this.nomorAntrian,
    required this.tanggalLahir,
    required this.tempatLahir,
    required this.umur,
  });

  factory DataPrinting.fromJson(Map<String, dynamic> json) {
    return DataPrinting(
      alamat: json['alamat'] ?? '',
      idAntrian: json['id_antrian'] ?? 0,
      idPasien: json['id_pasien'] ?? 0,
      idRm: json['id_rm'] ?? '',
      jenisKelamin: json['jenis_kelamin'] ?? '',
      kecamatan: json['kecamatan'] ?? '',
      keluhanUtama: json['keluhan_utama'] ?? '',
      kelurahan: json['kelurahan'] ?? '',
      kota: json['kota'] ?? '',
      namaDokter: json['nama_dokter'],
      namaPasien: json['nama_pasien'] ?? '',
      nik: json['nik'] ?? '',
      noTelp: json['no_telp'] ?? '',
      nomorAntrian: json['nomor_antrian'] ?? 0,
      tanggalLahir: json['tanggal_lahir'] ?? '',
      tempatLahir: json['tempat_lahir'] ?? '',
      umur: json['umur'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'alamat': alamat,
      'id_antrian': idAntrian,
      'id_pasien': idPasien,
      'id_rm': idRm,
      'jenis_kelamin': jenisKelamin,
      'kecamatan': kecamatan,
      'keluhan_utama': keluhanUtama,
      'kelurahan': kelurahan,
      'kota': kota,
      'nama_dokter': namaDokter,
      'nama_pasien': namaPasien,
      'nik': nik,
      'no_telp': noTelp,
      'nomor_antrian': nomorAntrian,
      'tanggal_lahir': tanggalLahir,
      'tempat_lahir': tempatLahir,
      'umur': umur,
    };
  }
}
