class Pasien {
  final String alamat;
  final int idPasien;
  final String jenisKelamin;
  final String kecamatan;
  final String kelurahan;
  final String kotaTinggal;
  final String nik;
  final String nama;
  final String noTelp;
  final DateTime tanggalLahir;
  final DateTime tanggalRegist;
  final String tempatLahir;
  final String statusKawin;
  final String agama;
  final String pekerjaan;

  Pasien({
    required this.alamat,
    required this.idPasien,
    required this.jenisKelamin,
    required this.kecamatan,
    required this.kelurahan,
    required this.kotaTinggal,
    required this.nik,
    required this.nama,
    required this.noTelp,
    required this.tanggalLahir,
    required this.tanggalRegist,
    required this.tempatLahir,
    required this.statusKawin,
    required this.agama,
    required this.pekerjaan
  });

  factory Pasien.fromJson(Map<String, dynamic> json) {
    return Pasien(
      alamat: json['Alamat'],
      idPasien: json['ID_Pasien'],
      jenisKelamin: json['Jenis_Kelamin'],
      kecamatan: json['Kecamatan'],
      kelurahan: json['Kelurahan'],
      kotaTinggal: json['Kota_Tinggal'],
      nik: json['NIK'],
      nama: json['Nama'],
      noTelp: json['No_Telp'],
      tanggalLahir: DateTime.parse(json['Tanggal_Lahir']),
      tanggalRegist: DateTime.parse(json['Tanggal_Regist']),
      tempatLahir: json['Tempat_Lahir'],
      agama: json['Agama'],
      statusKawin: json['Status_Perkawinan'],
      pekerjaan: json['Pekerjaan']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Alamat': alamat,
      'ID_Pasien': idPasien,
      'Jenis_Kelamin': jenisKelamin,
      'Kecamatan': kecamatan,
      'Kelurahan': kelurahan,
      'Kota_Tinggal': kotaTinggal,
      'NIK': nik,
      'Nama': nama,
      'No_Telp': noTelp,
      'Tanggal_Lahir': tanggalLahir.toIso8601String(),
      'Tanggal_Regist': tanggalRegist.toIso8601String(),
      'Tempat_Lahir': tempatLahir,
      'Agama': agama,
      'Status_Perkawinan': statusKawin,
      'Pekerjaan': pekerjaan
    };
  }
}
