// ignore_for_file: avoid_init_to_null

library globals;

import 'dart:convert';

import 'package:tmshub/src/models/pegawai_model.dart';
import 'package:tmshub/src/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

String urlAPI = 'https://tmshub.noerz.my.id/api';
// String urlAPI = 'http://10.10.10.71:8000/api';

// int userId = 0;

String locationNow = '';

double latitudeNow = 0.0;

double longtitudeNow = 0.0;

bool isLogin = false;

UserModel? userLogin = null;

PegawaiModel? pegawaiLogin = null;

Future<void> initializeGlobalsFromSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print("sharred preference active");
  isLogin = prefs.getBool('isLogin') ?? false;

  // Menginisialisasi userLogin dari SharedPreferences
  String? userLoginJson = prefs.getString('userLogin');
  userLogin = userLoginJson != null
      ? UserModel.fromJson(json.decode(userLoginJson))
      : null;

  // Menginisialisasi pegawaiLogin dari SharedPreferences
  String? pegawaiLoginJson = prefs.getString('pegawaiLogin');
  pegawaiLogin = pegawaiLoginJson != null
      ? PegawaiModel.fromJson(json.decode(pegawaiLoginJson))
      : null;
}
