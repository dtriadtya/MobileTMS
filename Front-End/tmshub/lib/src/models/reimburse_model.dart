class ReimburseModel {
  final int idReimburse;
  final int idUser;
  final DateTime tanggalReimburse;
  final String keterangan;
  final String? lampiran;
  final String statusReimburse;
  final int? idAdmin;
  final String? namaAdmin;
  final String amount;

  ReimburseModel({
    required this.idReimburse,
    required this.idUser,
    required this.tanggalReimburse,
    required this.keterangan,
    required this.lampiran,
    required this.statusReimburse,
    required this.idAdmin,
    required this.namaAdmin,
    required this.amount
  });

  factory ReimburseModel.fromJson(Map<String, dynamic> json) {
    return ReimburseModel(
      idReimburse: json['id_reimburse'],
      idUser: json['id_user'],
      tanggalReimburse: DateTime.parse(json['tanggal_reimburse']),
      keterangan: json['keterangan'],
      lampiran: json['lampiran'],
      statusReimburse: json['status_reimburse'],
      idAdmin: json['id_admin'],
      namaAdmin: json['nama_admin'],
      amount: json['amount']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_reimburse': idReimburse,
      'id_user': idUser,
      'tanggal_reimburse': tanggalReimburse.toIso8601String(),
      'keterangan': keterangan,
      'lampiran': lampiran,
      'status_reimburse': statusReimburse,
      'id_admin': idAdmin,
      'amount': amount
    };
  }
}
