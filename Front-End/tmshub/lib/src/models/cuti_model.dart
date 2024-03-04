class CutiModel {
  final int idCuti;
  final String idUser;
  final String tglMulai;
  final String tglSelesai;
  final String jenisCuti;
  final String keterangan;
  final String? sisaCuti;
  final String statusCuti;
  final String? idAdmin;
  final String admin;

  CutiModel(
      {required this.idCuti,
      required this.idUser,
      required this.tglMulai,
      required this.tglSelesai,
      required this.jenisCuti,
      required this.keterangan,
      required this.sisaCuti,
      required this.statusCuti,
      required this.idAdmin,
      required this.admin});

  factory CutiModel.fromJson(Map<String, dynamic> json) {
    return CutiModel(
        idCuti: json['id_cuti'],
        idUser: json['id_user'],
        tglMulai: json['tgl_mulai'],
        tglSelesai: json['tgl_akhir'],
        jenisCuti: json['jenis_cuti'],
        keterangan: json['keterangan'],
        sisaCuti: json['sisa_cuti'],
        statusCuti: json['status_cuti'],
        idAdmin: json['id_admin'],
        admin: json['admin']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id_cuti': idCuti,
      'id_user': idUser,
      'tgl_mulai': tglMulai,
      'tgl_akhir': tglSelesai,
      'jenis_cuti': jenisCuti,
      'keterangan': keterangan,
      'sisa_cuti': sisaCuti,
      'status_cuti': statusCuti,
      'id_admin': idAdmin,
    };
  }
}

class CutiSisaModel {
  final String namaUser;
  final int sisaCuti;
  final bool enabled;

  CutiSisaModel(
      {required this.namaUser, required this.sisaCuti, required this.enabled});

  factory CutiSisaModel.fromJson(Map<String, dynamic> json) {
    return CutiSisaModel(
      namaUser: json['nama_user'],
      sisaCuti: json['sisa_cuti'],
      enabled: json['enabled'],
    );
  }
}
