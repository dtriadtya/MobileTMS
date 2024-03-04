class UserModel {
    final int? idUser;
    final String? emailUser;
    final String? namaUser;
    final String? role;
    final String? message;

    UserModel({
        this.idUser,
        this.emailUser,
        this.namaUser,
        this.role,
        this.message,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        idUser: json["id_user"],
        emailUser: json["email_user"],
        namaUser: json["nama_user"],
        role: json["role"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "email_user": emailUser,
        "nama_user": namaUser,
        "role": role,
        "message": message,
    };
}
