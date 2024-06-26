// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors, unused_element

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tmshub/src/screens/profile/profile_screen.dart';
import 'package:tmshub/src/services/user_services.dart';
import 'package:tmshub/src/widgets/modal/custom_dialog.dart';
import 'package:tmshub/src/widgets/password_input.dart';
import 'package:tmshub/src/widgets/top_navigation.dart';
import 'package:tmshub/src/utils/globals.dart' as globals;

class EditPasswordScreen extends StatefulWidget {
  @override
  _EditPasswordState createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPasswordScreen> {
  final oldPasswordCont = TextEditingController();
  final newPasswordCont = TextEditingController();
  final newRePasswordCont = TextEditingController();
  bool oldVisibility = false;
  bool newVisibility = false;
  bool newReVisibility = false;

  @override
  void initState() {
    super.initState();
    oldPasswordCont.text = "";
    newPasswordCont.text = "";
    newRePasswordCont.text = "";
  }

  void toggleVisibility(bool currentVisibility) {
    setState(() {
      currentVisibility = !currentVisibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopNavigation(title: "GANTI KATA SANDI"),
              SizedBox(height: 15),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Jangan bagikan kepada siapapun kata sandi \nyang sudah anda ubah !!!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFA8AAAE),
                    fontSize: 12,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
              SizedBox(height: 30),
              PasswordInput(
                tittle: "Kata sandi sekarang",
                controller: oldPasswordCont,
                obscureText: oldVisibility,
              ),
              PasswordInput(
                tittle: "Kata sandi baru",
                controller: newPasswordCont,
                obscureText: newVisibility,
              ),
              PasswordInput(
                tittle: "Ulangi kata sandi baru",
                controller: newRePasswordCont,
                obscureText: newReVisibility,
              ),
              Container(
                margin: EdgeInsets.only(top: 80, left: 20, right: 20),
                width: MediaQuery.of(context).size.width - 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: HexColor("#537FE7")),
                  onPressed: () => storePassword(context),
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
              )
            ],
          ),
        ),
      ),
    );
  }

  storePassword(BuildContext context) {
    if (newPasswordCont.text == newRePasswordCont.text) {
      Map<String, dynamic> request = {
        'id_user': globals.userLogin!.idUser,
        'old_password': oldPasswordCont.text,
        'new_password': newPasswordCont.text,
      };
      changePasswordAPI(request).then((response) {
        if (response['statusCode'] == 200) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialog(
                title: "Sukses Menyimpan Password",
                message: "Berhasil menyimpan password!",
                type: "success",
              );
            },
          ).then((_) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            );
          });
        }
      }).onError((error, stackTrace) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialog(
              title: "Gagal Menyimpan Password",
              message: error.toString(),
              type: "failed",
            );
          },
        );
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            title: "Gagal Menyimpan Password",
            message: "password baru yang dimasukan berbeda",
            type: "failed",
          );
        },
      );
    }
  }
}
