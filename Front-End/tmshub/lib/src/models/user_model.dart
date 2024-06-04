class UserModel {
    final int? idUser;
    final String? namaUser;
    final String? emailUser;
    final String? passwordUser;
    final String? role;
    final Pegawai? pegawai;

    UserModel({
        this.idUser,
        this.namaUser,
        this.emailUser,
        this.passwordUser,
        this.role,
        this.pegawai,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        idUser: json["id_user"],
        namaUser: json["nama_user"],
        emailUser: json["email_user"],
        passwordUser: json["password_user"],
        role: json["role"],
        pegawai: json["pegawai"] == null ? null : Pegawai.fromJson(json["pegawai"]),
    );

    Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "nama_user": namaUser,
        "email_user": emailUser,
        "password_user": passwordUser,
        "role": role,
        "pegawai": pegawai?.toJson(),
    };
}

class Pegawai {
    final int? idPegawai;
    final String? idUser;
    final String? fotoProfil;
    final String? alamatPegawai;
    final String? nohpPegawai;
    final String? nip;

    Pegawai({
        this.idPegawai,
        this.idUser,
        this.fotoProfil,
        this.alamatPegawai,
        this.nohpPegawai,
        this.nip,
    });

    factory Pegawai.fromJson(Map<String, dynamic> json) => Pegawai(
        idPegawai: json["id_pegawai"],
        idUser: json["id_user"],
        fotoProfil: json["foto_profil"],
        alamatPegawai: json["alamat_pegawai"],
        nohpPegawai: json["nohp_pegawai"],
        nip: json["nip"],
    );

    Map<String, dynamic> toJson() => {
        "id_pegawai": idPegawai,
        "id_user": idUser,
        "foto_profil": fotoProfil,
        "alamat_pegawai": alamatPegawai,
        "nohp_pegawai": nohpPegawai,
        "nip": nip,
    };
}