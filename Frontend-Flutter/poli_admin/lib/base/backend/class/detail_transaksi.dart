class DetailTransaksi {
  final String namaPasien;
  final String idRm;
  final String namaPoli;
  final String namaDokter;
  final int biayaDokter;
  final String karyawanYangDitugaskan;
  final String namaAdministrasi;
  final List<Obat> obat;
  final List<Tindakan> tindakan;
  final DateTime? waktuDibayar;

  DetailTransaksi({
    required this.namaPasien,
    required this.idRm,
    required this.namaPoli,
    required this.namaDokter,
    required this.biayaDokter,
    required this.karyawanYangDitugaskan,
    required this.namaAdministrasi,
    required this.obat,
    required this.tindakan,
    required this.waktuDibayar,
  });

  factory DetailTransaksi.fromJson(Map<String, dynamic> json) {
    return DetailTransaksi(
      namaPasien: json['nama_pasien'],
      idRm: json['id_rm'],
      namaPoli: json['nama_poli'],
      namaDokter: json['nama_dokter'],
      biayaDokter: json['biaya_dokter'],
      karyawanYangDitugaskan: json['karyawan_yang_ditugaskan'],
      namaAdministrasi: json['nama_administrasi'],
      obat: (json['obat'] as List).map((e) => Obat.fromJson(e)).toList(),
      tindakan:
          (json['tindakan'] as List).map((e) => Tindakan.fromJson(e)).toList(),
      waktuDibayar: json['waktu_dibayar'] != null
          ? DateTime.tryParse(json['waktu_dibayar'])
          : null,
    );
  }
}

class Obat {
  final String namaObat;
  final String keterangan;
  final int jumlah;
  final String satuan;
  final int? hargaSatuan;
  final int hargaTotal;
  final String instruksi;
  final String? namaRacikan;
  final String? kemasan;
  final List<Komposisi>? komposisi;

  Obat({
    required this.namaObat,
    required this.keterangan,
    required this.jumlah,
    required this.satuan,
    this.hargaSatuan,
    required this.hargaTotal,
    required this.instruksi,
    this.namaRacikan,
    this.kemasan,
    this.komposisi,
  });

  factory Obat.fromJson(Map<String, dynamic> json) {
    return Obat(
      namaObat: json['nama_obat'],
      keterangan: json['keterangan'],
      jumlah: json['jumlah'],
      satuan: json['satuan'],
      hargaSatuan: json['harga_satuan'],
      hargaTotal: json['harga_total'],
      instruksi: json['instruksi'],
      namaRacikan: json['nama_racikan'],
      kemasan: json['kemasan'],
      komposisi: json['komposisi'] != null
          ? (json['komposisi'] as List)
              .map((e) => Komposisi.fromJson(e))
              .toList()
          : null,
    );
  }
}

class Komposisi {
  final String namaObat;
  final int dosis;
  final String satuan;
  final int hargaSatuan;

  Komposisi({
    required this.namaObat,
    required this.dosis,
    required this.satuan,
    required this.hargaSatuan,
  });

  factory Komposisi.fromJson(Map<String, dynamic> json) {
    return Komposisi(
      namaObat: json['nama_obat'],
      dosis: json['dosis'],
      satuan: json['satuan'],
      hargaSatuan: json['harga_satuan'],
    );
  }
}

class Tindakan {
  final String namaTindakan;
  final int jumlah;
  final int hargaTindakan;
  final int totalHargaTindakan;

  Tindakan({
    required this.namaTindakan,
    required this.jumlah,
    required this.hargaTindakan,
    required this.totalHargaTindakan,
  });

  factory Tindakan.fromJson(Map<String, dynamic> json) {
    return Tindakan(
      namaTindakan: json['nama_tindakan'],
      jumlah: json['jumlah'],
      hargaTindakan: json['harga_tindakan'],
      totalHargaTindakan: json['total_harga_tindakan'],
    );
  }
}
