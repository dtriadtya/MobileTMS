class PenggajianModel {
  final int idPenggajian;
  final int idUser;
  final String gajiPokok;
  final String transportasi;
  final String statusGaji;
  final String keterangan;
  final int idAdmin;
  final String namaAdmin;
  final String bonus;
  final DateTime tanggal;

  PenggajianModel({
    required this.idPenggajian,
    required this.idUser,
    required this.gajiPokok,
    required this.transportasi,
    required this.statusGaji,
    required this.keterangan,
    required this.idAdmin,
    required this.namaAdmin,
    required this.bonus,
    required this.tanggal
  });

  factory PenggajianModel.fromJson(Map<String, dynamic> json) {
    return PenggajianModel(
      idPenggajian: json['id_penggajian'],
      idUser: json['id_user'],
      gajiPokok: json['gaji_pokok'],
      transportasi: json['transportasi'],
      statusGaji: json['status_gaji'],
      keterangan: json['keterangan'],
      idAdmin: json['id_admin'],
      namaAdmin: json['nama_admin'],
      bonus: json['bonus'],
      tanggal: DateTime.parse(json['tanggal'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_penggajian': idPenggajian,
      'id_user': idUser,
      'gaji_pokok': gajiPokok,
      'transportasi': transportasi,
      'status_gaji': statusGaji,
      'keterangan': keterangan,
      'nama_admin': namaAdmin,
      'bonus': bonus,
      'tanggal': tanggal,
    };
  }
}
