class   Billing {
  int idKunjungan;
  int idPasien;
  String idRm;
  String namaPasien;
  String namaPoli;
  String status;
  String? tanggalPembayaran;

  Billing(
      {required this.idKunjungan,
      required this.idPasien,
      required this.idRm,
      required this.namaPasien,
      required this.namaPoli,
      required this.status,
      this.tanggalPembayaran});

  factory Billing.fromJson(Map<String, dynamic> json) {
    return Billing(
        idKunjungan: json['id_kunjungan'],
        idPasien: json['id_pasien'],
        idRm: json['id_rm'],
        namaPasien: json['nama_pasien'],
        namaPoli: json['nama_poli'],
        status: json['status'],
        tanggalPembayaran: json['tanggal_pembayaran']);
  }

  Map<String, dynamic> toJson() {
    final data = {
      'id_kunjungan': idKunjungan,
      'id_pasien': idPasien,
      'id_rm': idRm,
      'nama_pasien': namaPasien,
      'nama_poli': namaPoli,
      'status': status,
    };

    if (tanggalPembayaran != null) {
      data['tanggal_pembayaran'] = tanggalPembayaran as String;
    }

    return data;
  }
}
