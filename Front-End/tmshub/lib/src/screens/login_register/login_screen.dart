// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, avoid_print, unnecessary_new

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmshub/src/models/pegawai_model.dart';
import 'package:tmshub/src/models/user_model.dart';
import 'package:tmshub/src/screens/dashboard_screen.dart';
import 'package:tmshub/src/screens/login_register/register_screen.dart';
import 'package:tmshub/src/services/pegawai_services.dart';
import 'package:tmshub/src/services/user_services.dart';
import 'package:tmshub/src/utils/globals.dart' as globals;
import 'package:tmshub/src/widgets/modal/custom_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // checkLoginStatus();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              topBackgroundLogin(),
              inputForm(),
              SizedBox(
                height: 5,
              ),
              buttonMasuk(),
              buttonDaftar()
            ],
          ),
        ),
      ),
    );
  }

  Widget topBackgroundLogin() {
    return Column(
      children: [
        Image.asset('assets/login_image.png'),
        SizedBox(
          height: 12,
        ),
        Text(
          "Selamat Datang Di Aplikasi HRIS TMS",
          style: TextStyle(
              color: HexColor("#5c5e61"),
              fontFamily: "Inter",
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget inputForm() {
    return Column(
      children: [
        SizedBox(
          height: 12,
        ),
        // email input
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Email",
              style: TextStyle(
                  color: HexColor("#0D0E0E"),
                  fontSize: 14,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: TextField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: 'Masukkan Email',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        SizedBox(height: 12),
        // password input
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Kata Sandi",
              style: TextStyle(
                  color: HexColor("#0D0E0E"),
                  fontSize: 14,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: TextField(
            controller: passwordController,
            decoration: InputDecoration(
              hintText: 'Masukkan Kata Sandi',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
        ),
      ],
    );
  }

  Widget buttonMasuk() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: ElevatedButton(
        style: ButtonStyle(
            fixedSize: MaterialStatePropertyAll(
                Size(MediaQuery.of(context).size.width, 0)),
            backgroundColor: MaterialStatePropertyAll(HexColor("#A0EEFF"))),
        onPressed: () {
          print("click");
          if (emailController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Kolom Email tidak boleh kosong!")));
          } else if (passwordController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Kolom Password tidak boleh kosong!")));
          } else {
            loginMethod();
          }
        },
        child: Text(
          ' Masuk ',
          style: TextStyle(color: HexColor("#0D0E0E")),
        ),
      ),
    );
  }

   void loginMethod() {
    Map<String, dynamic> request = {
      'email_user': emailController.text,
      'password_user': passwordController.text
    };
    loginAPI(request).then((value) {
      globals.isLogin = true;
      globals.userLogin = new UserModel(
          idUser: value['id_user'],
          namaUser: value['nama_user'],
          emailUser: value['email_user'],
          passwordUser: "*******",
          role: 1);
      print('Tipe data value id user: ${value['id_user'].runtimeType}');
      print('data value id user: ${value['id_user']}');
      getPegawaiAPI(value['id_user']).then((p) {
        print('Tipe data id_user: ${p['id_user'].runtimeType}');
        print('data id_user: ${p['id_user']}');
        if (p['statusCode'] == 404) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(p['message'])));
        } else if (p['statusCode'] == 200) {
          globals.pegawaiLogin = new PegawaiModel(
              idPegawai: p['id_pegawai'],
              idUser: value['id_user'],
              fotoProfil: p['foto_profil'],
              alamatPegawai: p['alamat_pegawai'],
              nohpPegawai: p['nohp_pegawai'],
              nip: p['nip'],
              idDivisi: p['id_divisi'],
              divisi: p['divisi']);
          updateSharredPreferencesLogin();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialog(
                  title: "Sukses Login",
                  message: "Berhasil login!",
                  type: "success");
            },
          );
          Future.delayed(Duration(seconds: 0), () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return DashboardScreen();
              }),
            );
          });
        }
      });
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
              title: "Gagal Login", message: error.toString(), type: "failed");
        },
      );
    });
  }


  Widget buttonDaftar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: ElevatedButton(
        style: ButtonStyle(
            fixedSize: MaterialStatePropertyAll(
                Size(MediaQuery.of(context).size.width, 0)),
            backgroundColor: MaterialStatePropertyAll(HexColor("#26ED5D"))),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return RegisterScreen();
            }),
          );
        },
        child: Text(
          ' Daftar ',
          style: TextStyle(color: HexColor("#0D0E0E")),
        ),
      ),
    );
  }

  void checkLoginStatus() {
    if (!globals.isLogin) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) {
          return DashboardScreen();
        }),
      );
    }
  }

  void updateSharredPreferencesLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(json.encode(globals.userLogin!.toJson()));
    prefs.setString("userLogin", json.encode(globals.userLogin!.toJson()));
    prefs.setString(
        "pegawaiLogin", json.encode(globals.pegawaiLogin!.toJson()));
    prefs.setBool("isLogin", true);
  }
}
