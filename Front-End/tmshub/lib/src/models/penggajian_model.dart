class PenggajianModel {
    final String? idPenggajian;
    final String? idUser;
    final String? gajiPokok;
    final String? transportasi;
    final String? statusGaji;
    final String? keterangan;
    final String? idAdmin;
    final String? bonus;
    final DateTime? tanggal;
    final String? namaAdmin;

    PenggajianModel({
        this.idPenggajian,
        this.idUser,
        this.gajiPokok,
        this.transportasi,
        this.statusGaji,
        this.keterangan,
        this.idAdmin,
        this.bonus,
        this.tanggal,
        this.namaAdmin,
    });

    factory PenggajianModel.fromJson(Map<String, dynamic> json) => PenggajianModel(
        idPenggajian: json["id_penggajian"],
        idUser: json["id_user"],
        gajiPokok: json["gaji_pokok"],
        transportasi: json["transportasi"],
        statusGaji: json["status_gaji"],
        keterangan: json["keterangan"],
        idAdmin: json["id_admin"],
        bonus: json["bonus"],
        tanggal: json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
        namaAdmin: json["nama_admin"],
    );

    Map<String, dynamic> toJson() => {
        "id_penggajian": idPenggajian,
        "id_user": idUser,
        "gaji_pokok": gajiPokok,
        "transportasi": transportasi,
        "status_gaji": statusGaji,
        "keterangan": keterangan,
        "id_admin": idAdmin,
        "bonus": bonus,
        "tanggal": tanggal?.toIso8601String(),
        "nama_admin": namaAdmin,
    };
}