// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:tmshub/src/models/perusahaan_model.dart';
import 'package:tmshub/src/utils/globals.dart' as globals;

import 'package:http/http.dart' as http;

Future<List<PerusahaanModel>> getAllCompany() async {
  final response =
      await http.get(Uri.parse(globals.urlAPI + '/perusahaan'));
  final List<dynamic> jsonResponse = json.decode(response.body);
  final List<Map<String, dynamic>> jsonMap = jsonResponse.cast<Map<String, dynamic>>();

  if (response.statusCode == 200) {
    return jsonMap.map((e) => PerusahaanModel.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load Company');
  }
}
