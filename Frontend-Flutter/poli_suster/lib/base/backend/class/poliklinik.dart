class Poliklinik {
  final int idPoli;
  final String namaPoli;

  Poliklinik({
    required this.idPoli,
    required this.namaPoli,
  });

  factory Poliklinik.fromJson(Map<String, dynamic> json) {
    return Poliklinik(
      idPoli: json['id_poli'],
      namaPoli: json['nama_poli'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_poli': idPoli,
      'nama_poli': namaPoli,
    };
  }
}
