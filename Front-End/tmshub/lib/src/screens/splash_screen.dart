
// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'dart:async';
import 'package:tmshub/src/screens/dashboard_screen.dart';
import 'package:tmshub/src/screens/login_register/login_screen.dart';
import 'package:tmshub/src/utils/globals.dart' as globals;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    globals.initializeGlobalsFromSharedPreferences();
    print("berhasil");
    Timer(
        const Duration(seconds: 2),
        () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          if (globals.isLogin && globals.userLogin != null) {
            return DashboardScreen();
          } else {
            return LoginScreen();
          }
        }));
        });
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
     decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft, // Atur titik awal gradient
          end: Alignment.topRight,    // Atur titik akhir gradient
          colors: [
            Color(0xFF2193B0),        // Warna gradient pertama
            Color(0xFFFFFFFF),        // Warna gradient kedua
          ],
          stops: [0.0, 0.5],      // Lokasi stop gradient (sesuai dengan CSS Anda)
        ),
      ),
      child: Center(
        child: Image.asset(
          'assets/logoEdit1.png',
          width: 300,
          height: 300,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

