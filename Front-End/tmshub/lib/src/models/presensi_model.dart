// ignore_for_file: unnecessary_null_in_if_null_operators

class PresensiModel {
  final int idPresensi;
  final int idUser;
  final DateTime checkIn;
  final DateTime? checkOut;
  final String mapsCheckin;
  final String? mapsCheckout;

  const PresensiModel(
      {required this.idPresensi,
      required this.idUser,
      required this.checkIn,
      required this.checkOut,
      required this.mapsCheckin,
      required this.mapsCheckout});

  factory PresensiModel.formJson(Map<String, dynamic> json) {
    return PresensiModel(
        idPresensi: json['id_presensi'],
        idUser: json['id_user'],
        checkIn: DateTime.parse(json['check_in']),
        checkOut: json['check_out'] != null
          ? DateTime.parse(json['check_out'])
          : null,
        mapsCheckin: json['maps_checkin'],
        mapsCheckout: json['maps_checkout']??null);
  }

  @override
  String toString() {
    return 'PresensiModel{idPresensi: $idPresensi, idUser: $idUser, checkIn: $checkIn, checkOut: $checkOut, mapsCheckin: $mapsCheckin, mapsCheckout: $mapsCheckout}';
  }
}
