class PegawaiModel {
  final int? idPegawai;
  final String? idUser;
  final String? alamatPegawai;
  final String? nohpPegawai;
  final String? nip;
  final String? idDivisi;
  final String? fotoProfil;

  PegawaiModel({
    this.idPegawai,
    this.idUser,
    this.alamatPegawai,
    this.nohpPegawai,
    this.nip,
    this.idDivisi,
    this.fotoProfil,
  });

  factory PegawaiModel.fromJson(Map<String, dynamic> json) => PegawaiModel(
        idPegawai: json["id_pegawai"],
        idUser: json["id_user"],
        alamatPegawai: json["alamat_pegawai"],
        nohpPegawai: json["nohp_pegawai"],
        nip: json["nip"],
        idDivisi: json["id_divisi"],
        fotoProfil: json["foto_profil"],
      );

  Map<String, dynamic> toJson() => {
        "id_pegawai": idPegawai,
        "id_user": idUser,
        "alamat_pegawai": alamatPegawai,
        "nohp_pegawai": nohpPegawai,
        "nip": nip,
        "id_divisi": idDivisi,
        "foto_profil": fotoProfil,
      };
}
