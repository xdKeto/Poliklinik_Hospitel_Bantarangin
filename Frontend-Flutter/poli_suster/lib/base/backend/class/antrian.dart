import 'dart:convert';

class Antrian {
  final int idAntrian;
  final int nomorAntrian;
  final int idPasien;
  final String idRm;
  final String namaPasien;
  final String nik;
  final String jenisKelamin;
  final String tanggalLahir;
  final int umur;
  final String tempatLahir;
  final String alamat;
  final String kelurahan;
  final String kecamatan;
  final String kota;
  final String noTelp;

  Antrian({
    required this.idAntrian,
    required this.nomorAntrian,
    required this.idPasien,
    required this.idRm,
    required this.namaPasien,
    required this.nik,
    required this.jenisKelamin,
    required this.tanggalLahir,
    required this.umur,
    required this.tempatLahir,
    required this.alamat,
    required this.kelurahan,
    required this.kecamatan,
    required this.kota,
    required this.noTelp,
  });

  factory Antrian.fromJson(Map<String, dynamic> json) {
    return Antrian(
      idAntrian: json['id_antrian'],
      nomorAntrian: json['nomor_antrian'],
      idPasien: json['id_pasien'],
      idRm: json['id_rm'],
      namaPasien: json['nama_pasien'],
      nik: json['nik'],
      jenisKelamin: json['jenis_kelamin'],
      tanggalLahir: json['tanggal_lahir'],
      umur: json['umur'],
      tempatLahir: json['tempat_lahir'],
      alamat: json['alamat'],
      kelurahan: json['kelurahan'],
      kecamatan: json['kecamatan'],
      kota: json['kota'],
      noTelp: json['no_telp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_antrian': idAntrian,
      'nomor_antrian': nomorAntrian,
      'id_pasien': idPasien,
      'id_rm': idRm,
      'nama_pasien': namaPasien,
      'nik': nik,
      'jenis_kelamin': jenisKelamin,
      'tanggal_lahir': tanggalLahir,
      'umur': umur,
      'tempat_lahir': tempatLahir,
      'alamat': alamat,
      'kelurahan': kelurahan,
      'kecamatan': kecamatan,
      'kota': kota,
      'no_telp': noTelp,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
