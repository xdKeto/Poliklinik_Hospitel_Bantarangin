class RiwayatPasien {
  final int idScreening;
  final int idPasien;
  final int idKaryawan;
  final int systolic;
  final int diastolic;
  final int beratBadan;
  final int suhuTubuh;
  final int tinggiBadan;
  final int gulaDarah;
  final int detakNadi;
  final int lajuRespirasi;
  final String keterangan;
  final DateTime createdAt;

  RiwayatPasien({
    required this.idScreening,
    required this.idPasien,
    required this.idKaryawan,
    required this.systolic,
    required this.diastolic,
    required this.beratBadan,
    required this.suhuTubuh,
    required this.tinggiBadan,
    required this.gulaDarah,
    required this.detakNadi,
    required this.lajuRespirasi,
    required this.keterangan,
    required this.createdAt,
  });

  factory RiwayatPasien.fromJson(Map<String, dynamic> json) {
    return RiwayatPasien(
      idScreening: json['id_screening'],
      idPasien: json['id_pasien'],
      idKaryawan: json['id_karyawan'],
      systolic: json['systolic'],
      diastolic: json['diastolic'],
      beratBadan: json['berat_badan'],
      suhuTubuh: json['suhu_tubuh'],
      tinggiBadan: json['tinggi_badan'],
      gulaDarah: json['gula_darah'],
      detakNadi: json['detak_nadi'],
      lajuRespirasi: json['laju_respirasi'],
      keterangan: json['keterangan'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_screening': idScreening,
      'id_pasien': idPasien,
      'id_karyawan': idKaryawan,
      'systolic': systolic,
      'diastolic': diastolic,
      'berat_badan': beratBadan,
      'suhu_tubuh': suhuTubuh,
      'tinggi_badan': tinggiBadan,
      'gula_darah': gulaDarah,
      'detak_nadi': detakNadi,
      'laju_respirasi': lajuRespirasi,
      'keterangan': keterangan,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
