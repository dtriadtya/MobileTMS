class ReimburseModel {
    final int? idReimburse;
    final String? idUser;
    final DateTime? tanggalReimburse;
    final String? keterangan;
     String? statusReimburse;
    final String? idAdmin;
    final String? amount;
    String? lampiran;
    final String? namaAdmin;

    ReimburseModel({
        this.idReimburse,
        this.idUser,
        this.tanggalReimburse,
        this.keterangan,
        this.statusReimburse,
        this.idAdmin,
        this.amount,
        this.lampiran,
        this.namaAdmin,
    });

    factory ReimburseModel.fromJson(Map<String, dynamic> json) => ReimburseModel(
        idReimburse: json["id_reimburse"],
        idUser: json["id_user"],
        tanggalReimburse: json["tanggal_reimburse"] == null ? null : DateTime.parse(json["tanggal_reimburse"]),
        keterangan: json["keterangan"],
        statusReimburse: json["status_reimburse"],
        idAdmin: json["id_admin"],
        amount: json["amount"],
        lampiran: json["lampiran"],
        namaAdmin: json["nama_admin"],
    );

    Map<String, dynamic> toJson() => {
        "id_reimburse": idReimburse,
        "id_user": idUser,
        "tanggal_reimburse": tanggalReimburse?.toIso8601String(),
        "keterangan": keterangan,
        "status_reimburse": statusReimburse,
        "id_admin": idAdmin,
        "amount": amount,
        "lampiran": lampiran,
        "nama_admin": namaAdmin,
    };
}
