class StatusAntrian {
  final int idStatus;
  final String status;

  StatusAntrian({required this.idStatus, required this.status});

  factory StatusAntrian.fromJson(Map<String, dynamic> json) {
    return StatusAntrian(
      idStatus: json['id_status'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_status': idStatus,
      'status': status,
    };
  }

  static List<StatusAntrian> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => StatusAntrian.fromJson(json)).toList();
  }
}
