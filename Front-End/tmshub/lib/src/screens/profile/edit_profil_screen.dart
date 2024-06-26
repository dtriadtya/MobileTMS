// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmshub/src/models/pegawai_model.dart';
import 'package:tmshub/src/models/user_model.dart';
import 'package:tmshub/src/services/pegawai_services.dart';
import 'package:tmshub/src/utils/globals.dart' as globals;
import 'package:tmshub/src/widgets/modal/custom_dialog.dart';
import 'package:tmshub/src/widgets/text_form_field.dart';
import 'package:tmshub/src/widgets/top_navigation.dart';

class EditProfilScreen extends StatefulWidget {
  const EditProfilScreen({Key? key}) : super(key: key);

  @override
  State<EditProfilScreen> createState() => _EditProfilScreenState();
}

class _EditProfilScreenState extends State<EditProfilScreen> {
  // dynamic temp;
  var alamatCont =
      TextEditingController(text: globals.pegawaiLogin!.alamatPegawai ?? "-");
  var namaCont = TextEditingController(text: globals.userLogin!.namaUser);
  var emailCont = TextEditingController(text: globals.userLogin!.emailUser);
  var nohpCont =
      TextEditingController(text: globals.pegawaiLogin!.nohpPegawai ?? "-");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TopNavigation(title: "UBAH DATA"),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Silahkan lengkapi data dibawah ini !!!',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Color(0xFFA8AAAE),
                    fontSize: 12,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
              formMethod(context),
              Container(
                padding: EdgeInsets.only(top: 40, left: 20, right: 20),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () => saveProfile(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF537FE7),
                  ),
                  child: Text(
                    "SIMPAN",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  formMethod(context) {
    return Form(
      child: Container(
        // padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            CustomFormField(
              enable: false,
              obscureText: false,
              title: 'Nama Lengkap',
              controller: namaCont,
            ),
            CustomFormField(
              enable: true,
              obscureText: false,
              title: 'Alamat',
              controller: alamatCont,
            ),
            CustomFormField(
              enable: true,
              obscureText: false,
              title: 'Email',
              controller: emailCont,
            ),
            CustomFormField(
              enable: true,
              obscureText: false,
              title: 'No. Telepon',
              controller: nohpCont,
            ),
            CustomFormField(
              enable: false,
              obscureText: false,
              title: 'Divisi',
              initialValue: globals.pegawaiLogin!.divisi ?? "-",
            ),
            CustomFormField(
              enable: false,
              obscureText: false,
              title: 'Nomor Kepegawaian',
              initialValue: globals.pegawaiLogin!.nip ?? "-",
            ),
          ],
        ),
      ),
    );
  }

  saveProfile() {
    context.loaderOverlay.show();
    Map<String, String> request = {
      'id_pegawai': globals.pegawaiLogin!.idPegawai.toString(),
      'alamat_pegawai': alamatCont.text,
      'nama_user': namaCont.text,
      'email_user': emailCont.text,
      'nohp_pegawai': nohpCont.text,
    };
    print(request);
    updateProfilAPI(request).then((value) {
      _updateGlobalsVariable(namaCont.text,alamatCont.text, emailCont.text, nohpCont.text);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
              title: "Berhasil",
              message: "Berhasil menyimpan perubahan!",
              type: "success");
        },
      );
      context.loaderOverlay.hide();
    }).onError((error, stackTrace) {
      context.loaderOverlay.hide();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
              title: "Gagal Menyimpan",
              message: error.toString(),
              type: "failed");
        },
      );
    });
  }

  _updateGlobalsVariable(String nama,String alamat, String email, String nohp) async {
    UserModel user = UserModel(
        idUser: globals.userLogin!.idUser,
        namaUser: nama,
        emailUser: email,
        role: globals.userLogin!.role);

    PegawaiModel pegawai = PegawaiModel(
        idPegawai: globals.pegawaiLogin!.idPegawai,
        idUser: globals.pegawaiLogin!.idUser,
        fotoProfil: globals.pegawaiLogin!.fotoProfil,
        alamatPegawai: alamat,
        nohpPegawai: nohp,
        nip: globals.pegawaiLogin!.nip,
        idDivisi: globals.pegawaiLogin!.idDivisi,
        divisi: globals.pegawaiLogin!.divisi);

    globals.userLogin = user;
    globals.pegawaiLogin = pegawai;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userLogin", json.encode(user));
    prefs.setString("pegawaiLogin", json.encode(pegawai));
    prefs.setBool("isLogin", true);
  }

  _inputText(
      {required String tittle,
      required bool enabled,
      required String initialValue}) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Text(
            tittle,
            style: TextStyle(
              fontFamily: "Montserrat",
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: HexColor("#565656"),
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            initialValue: initialValue,
            style: TextStyle(
              fontFamily: "Montserrat",
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: HexColor("#565656"),
            ),
            decoration: InputDecoration(
              enabled: enabled,
              filled: true,
              fillColor:
                  !enabled ? HexColor("#80A8AAAE") : HexColor("#80FFFFFF"),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), gapPadding: 8),
              contentPadding: EdgeInsetsDirectional.symmetric(horizontal: 10),
            ),
          )
        ]);
  }

  _inputTextCont(
      {required String tittle,
      required bool enabled,
      required TextEditingController controller}) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Text(
            tittle,
            style: TextStyle(
              fontFamily: "Montserrat",
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: HexColor("#565656"),
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: controller,
            style: TextStyle(
              fontFamily: "Montserrat",
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: HexColor("#565656"),
            ),
            decoration: InputDecoration(
              enabled: enabled,
              filled: true,
              fillColor:
                  !enabled ? HexColor("#80A8AAAE") : HexColor("#80FFFFFF"),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), gapPadding: 8),
              contentPadding: EdgeInsetsDirectional.symmetric(horizontal: 10),
            ),
          )
        ]);
  }
}
