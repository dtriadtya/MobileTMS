// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:tmshub/src/utils/globals.dart' as globals;

import 'package:tmshub/src/models/presensi_model.dart';
import 'package:http/http.dart' as http;

Future<List<PresensiModel>> fetchPresensiByUser(int userId) async {
  final response =
      await http.get(Uri.parse(globals.urlAPI + '/presensi/user/$userId'));
  final List<dynamic> jsonResponse = json.decode(response.body);
  final List<Map<String, dynamic>> jsonMap =
      jsonResponse.cast<Map<String, dynamic>>();

  if (response.statusCode == 200) {
    return jsonMap.map((e) => PresensiModel.formJson(e)).toList();
  } else {
    throw Exception('Failed to load album');
  }
}

Future<Map<String, dynamic>> fetchPresensiToday() async {
  final response = await http
      .get(Uri.parse(globals.urlAPI + '/presensi-today/user/${globals.userLogin!.idUser}'));
  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);

      return jsonResponse;
  } else {
    throw Exception('Gagal memuat data presensi');
  }
}

Future<Map<String, dynamic>> attendUser(Map<String, dynamic> request) async {
  print(request.entries);
  final response = await http.post(
    Uri.parse(globals.urlAPI + '/presensi/attend'),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(request),
  );

  if (response.statusCode == 201) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse;
  } else {
    throw Exception('Gagal menambahkan presensi');
  }
}
