import 'dart:convert';

class AntrianTunggu {
  final int idAntrian;
  final int nomorAntrian;

  AntrianTunggu({
    this.idAntrian = 0,
    this.nomorAntrian = 0,
  });

  factory AntrianTunggu.fromJson(Map<String, dynamic> json) {
    return AntrianTunggu(
      idAntrian: json['id_antrian'] ?? 0,
      nomorAntrian: json['nomor_antrian'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_antrian': idAntrian,
      'nomor_antrian': nomorAntrian,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
