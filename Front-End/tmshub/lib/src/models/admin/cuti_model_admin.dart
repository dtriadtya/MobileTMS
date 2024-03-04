class CutiAdmin {
    int? idCuti;
    String? idUser;
    DateTime? tglMulai;
    DateTime? tglAkhir;
    String? jenisCuti;
    String? keterangan;
    String? sisaCuti;
    String? statusCuti;
    String? idAdmin;

    CutiAdmin({
        this.idCuti,
        this.idUser,
        this.tglMulai,
        this.tglAkhir,
        this.jenisCuti,
        this.keterangan,
        this.sisaCuti,
        this.statusCuti,
        this.idAdmin,
    });

    factory CutiAdmin.fromJson(Map<String, dynamic> json) => CutiAdmin(
        idCuti: json["id_cuti"],
        idUser: json["id_user"],
        tglMulai: json["tgl_mulai"] == null ? null : DateTime.parse(json["tgl_mulai"]),
        tglAkhir: json["tgl_akhir"] == null ? null : DateTime.parse(json["tgl_akhir"]),
        jenisCuti: json["jenis_cuti"],
        keterangan: json["keterangan"],
        sisaCuti: json["sisa_cuti"],
        statusCuti: json["status_cuti"],
        idAdmin: json["id_admin"],
    );

    Map<String, dynamic> toJson() => {
        "id_cuti": idCuti,
        "id_user": idUser,
        "tgl_mulai": "${tglMulai!.year.toString().padLeft(4, '0')}-${tglMulai!.month.toString().padLeft(2, '0')}-${tglMulai!.day.toString().padLeft(2, '0')}",
        "tgl_akhir": "${tglAkhir!.year.toString().padLeft(4, '0')}-${tglAkhir!.month.toString().padLeft(2, '0')}-${tglAkhir!.day.toString().padLeft(2, '0')}",
        "jenis_cuti": jenisCuti,
        "keterangan": keterangan,
        "sisa_cuti": sisaCuti,
        "status_cuti": statusCuti,
        "id_admin": idAdmin,
    };
}