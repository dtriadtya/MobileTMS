

class PegawaiModel {
  final int idPegawai;
  final int idUser;
  final String?  fotoProfil; // Menyesuaikan dengan tipe data yang sesuai
  final String? alamatPegawai;
  final String? nohpPegawai;
  final String? nip;
  final int? idDivisi;
  final String? divisi; 

  PegawaiModel({
    required this.idPegawai,
    required this.idUser,
    required this.fotoProfil,
    required this.alamatPegawai,
    required this.nohpPegawai,
    required this.nip,
    required this.idDivisi,
    required this.divisi
  });

  factory PegawaiModel.fromJson(Map<String, dynamic> json) {
    return PegawaiModel(
      idPegawai: json['id_pegawai'],
      idUser: json['id_user'],
      fotoProfil: json['foto_profil'], 
      alamatPegawai: json['alamat_pegawai'],
      nohpPegawai: json['nohp_pegawai'],
      nip: json['nip'],
      idDivisi: json['id_divisi'], 
      divisi: json['divisi']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_pegawai': idPegawai,
      'id_user': idUser,
      'foto_profil': fotoProfil, 
      'alamat_pegawai': alamatPegawai,
      'nohp_pegawai': nohpPegawai,
      'nip': nip,
      'id_divisi': idDivisi, 
      'divisi': divisi
    };
  }
}
