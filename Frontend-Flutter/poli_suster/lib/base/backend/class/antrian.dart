import 'dart:convert';

class Antrian {
  final int idAntrian;
  final int nomorAntrian;

  Antrian({
    required this.idAntrian,
    required this.nomorAntrian,
  });

  factory Antrian.fromJson(Map<String, dynamic> json) {
    return Antrian(
      idAntrian: json['id_antrian'],
      nomorAntrian: json['nomor_antrian'],
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
