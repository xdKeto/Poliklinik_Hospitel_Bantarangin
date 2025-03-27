class Billing {
  final int idKunjungan;
  final int idPasien;
  final String idRm;
  final String namaPasien;
  final String namaPoli;
  final String status;

  Billing({
    required this.idKunjungan,
    required this.idPasien,
    required this.idRm,
    required this.namaPasien,
    required this.namaPoli,
    required this.status,
  });

  factory Billing.fromJson(Map<String, dynamic> json) {
    return Billing(
      idKunjungan: json['id_kunjungan'],
      idPasien: json['id_pasien'],
      idRm: json['id_rm'],
      namaPasien: json['nama_pasien'],
      namaPoli: json['nama_poli'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_kunjungan': idKunjungan,
      'id_pasien': idPasien,
      'id_rm': idRm,
      'nama_pasien': namaPasien,
      'nama_poli': namaPoli,
      'status': status,
    };
  }
}
