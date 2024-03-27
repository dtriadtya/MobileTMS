// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmshub/src/models/pegawai_model.dart';
import 'package:tmshub/src/models/user_model.dart';
import 'package:tmshub/src/services/pegawai_services.dart';
import 'package:tmshub/src/utils/globals.dart' as globals;
import 'package:tmshub/src/widgets/modal/custom_dialog.dart';
import 'package:tmshub/src/widgets/text_form_field.dart';
import 'package:tmshub/src/widgets/top_navigation.dart';

class EditPegawaiScreen extends StatefulWidget {
  final String userId;
  final String nama;
  final String email;
  const EditPegawaiScreen(
      {Key? key, required this.userId, required this.nama, required this.email})
      : super(key: key);

  @override
  State<EditPegawaiScreen> createState() => _EditPegawaiScreenState();
}

class _EditPegawaiScreenState extends State<EditPegawaiScreen> {
  // dynamic temp;
  var alamatCont =
      TextEditingController(text: globals.pegawaiLogin?.alamatPegawai ?? "-");
  var emailCont =
      TextEditingController(text: globals.userLogin?.emailUser ?? "");
  var nohpCont =
      TextEditingController(text: globals.pegawaiLogin?.nohpPegawai ?? "-");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("isi dari widget id :${widget.userId}");
    log("isi dari widget name :${widget.nama}");
    log("isi dari widget email :${widget.email}");
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
                  onPressed: () => savePegawai(),
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF537FE7),
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
              initialValue: widget.nama,
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
              initialValue: widget.email,
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

  savePegawai() {
    context.loaderOverlay.show();
    Map<String, String> request = {
      'id_pegawai': "${1}",
      'nip': "123",
    };
    print(request);
    updatePegawaiAPI(request).then((value) {
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
}
