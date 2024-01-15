class PerusahaanModel {
  final int idPerusahaan;
  final String namaPerusahaan;
  final double lat;
  final double long;

  PerusahaanModel({
    required this.idPerusahaan,
    required this.namaPerusahaan,
    required this.lat,
    required this.long,
  });

  factory PerusahaanModel.fromJson(Map<String, dynamic> json) {
    return PerusahaanModel(
      idPerusahaan: json['id_perusahaan'],
      namaPerusahaan: json['nama_perusahaan'],
      lat: double.parse(json['lat']),
      long: double.parse(json['long']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_perusahaan': idPerusahaan,
      'nama_perusahaan': namaPerusahaan,
      'lat': lat.toString(),
      'long': long.toString(),
    };
  }
}
