class HealthRecord {
  final String tanggal;
  final String tensiDarah;
  final double beratBadan;
  final int tinggiBadan;
  final double suhuTubuh;
  final int gulaDarah;
  final int detakNadi;
  final int respRate;
  final String catatan;

  HealthRecord({
    required this.tanggal,
    required this.tensiDarah,
    required this.beratBadan,
    required this.tinggiBadan,
    required this.suhuTubuh,
    required this.gulaDarah,
    required this.detakNadi,
    required this.respRate,
    required this.catatan,
  });

  factory HealthRecord.fromJson(Map<String, dynamic> json) {
    return HealthRecord(
      tanggal: json['tanggal'],
      tensiDarah: json['tensi_darah'],
      beratBadan: json['berat_badan'],
      tinggiBadan: json['tinggi_badan'],
      suhuTubuh: json['suhu_tubuh'],
      gulaDarah: json['gula_darah'],
      detakNadi: json['detak_nadi'],
      respRate: json['resp_rate'],
      catatan: json['catatan'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tanggal': tanggal,
      'tensi_darah': tensiDarah,
      'berat_badan': beratBadan,
      'tinggi_badan': tinggiBadan,
      'suhu_tubuh': suhuTubuh,
      'gula_darah': gulaDarah,
      'detak_nadi': detakNadi,
      'resp_rate': respRate,
      'catatan': catatan,
    };
  }
}
