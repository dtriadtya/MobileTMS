// ignore_for_file: unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:tmshub/src/models/penggajian_model.dart';
import 'package:tmshub/src/utils/globals.dart' as globals;

import 'package:http/http.dart' as http;

Future<List<PenggajianModel>> getPenggajianByUserAPI(int userId) async {
  final response =
      await http.get(Uri.parse(globals.urlAPI + '/penggajian/${userId}'));

  final List<dynamic> jsonResponse = json.decode(response.body);
  final List<Map<String, dynamic>> jsonMap =
      jsonResponse.cast<Map<String, dynamic>>();

  if (response.statusCode == 200) {
    return jsonMap.map((e) => PenggajianModel.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load Penggajian');
  }
}
