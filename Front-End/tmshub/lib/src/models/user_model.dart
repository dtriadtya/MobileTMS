class UserModel {
  final int idUser;
  final String namaUser;
  final String emailUser;
  final String passwordUser;
  final int role;

  UserModel({
    required this.idUser,
    required this.namaUser,
    required this.emailUser,
    required this.passwordUser,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        idUser: json['id_user'],
        namaUser: json['nama_user'],
        emailUser: json['email_user'],
        passwordUser: json['password_user'],
        role: json['role']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id_user': idUser,
      'nama_user': namaUser,
      'email_user': emailUser,
      'password_user': passwordUser,
      'role': role
    };
  }
}
