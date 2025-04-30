class AntrianPasien {
  int idAntrian;
  int idPasien;
  int idPoli;
  String idRm;
  int idStatus;
  String nama;
  String namaPoli;
  int nomorAntrian;
  int priorityOrder;
  String status;

  AntrianPasien({
    required this.idAntrian,
    required this.idPasien,
    required this.idPoli,
    required this.idRm,
    required this.idStatus,
    required this.nama,
    required this.namaPoli,
    required this.nomorAntrian,
    required this.priorityOrder,
    required this.status,
  });

  factory AntrianPasien.fromJson(Map<String, dynamic> json) {
    return AntrianPasien(
      idAntrian: json['id_antrian'],
      idPasien: json['id_pasien'],
      idPoli: json['id_poli'],
      idRm: json['id_rm'],
      idStatus: json['id_status'],
      nama: json['nama'],
      namaPoli: json['nama_poli'],
      nomorAntrian: json['nomor_antrian'],
      priorityOrder: json['priority_order'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_antrian': idAntrian,
      'id_pasien': idPasien,
      'id_poli': idPoli,
      'id_rm': idRm,
      'id_status': idStatus,
      'nama': nama,
      'nama_poli': namaPoli,
      'nomor_antrian': nomorAntrian,
      'priority_order': priorityOrder,
      'status': status,
    };
  }

  static List<AntrianPasien> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => AntrianPasien.fromJson(json)).toList();
  }
}
