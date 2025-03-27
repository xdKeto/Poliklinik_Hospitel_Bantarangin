class Poliklinik {
  final int idPoli;
  final int idStatus;
  final int jumlahTenkes;
  final String keterangan;
  final String? logoPoli;
  final String namaPoli;

  Poliklinik({
    required this.idPoli,
    required this.idStatus,
    required this.jumlahTenkes,
    required this.keterangan,
    this.logoPoli,
    required this.namaPoli,
  });

  factory Poliklinik.fromJson(Map<String, dynamic> json) {
    return Poliklinik(
      idPoli: json['id_poli'],
      idStatus: json['id_status'],
      jumlahTenkes: json['jumlah_tenkes'],
      keterangan: json['keterangan'],
      logoPoli: json['logo_poli'],
      namaPoli: json['nama_poli'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_poli': idPoli,
      'id_status': idStatus,
      'jumlah_tenkes': jumlahTenkes,
      'keterangan': keterangan,
      'logo_poli': logoPoli,
      'nama_poli': namaPoli,
    };
  }
}
