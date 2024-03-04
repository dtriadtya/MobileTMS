import 'dart:convert';
import 'dart:math';
import 'package:tmshub/src/models/cuti_model.dart';
import 'package:tmshub/src/utils/globals.dart' as globals;

import 'package:http/http.dart' as http;

Future<List<CutiModel>> getCutiByUserAPI(int userId) async {
  final response = await http.get(Uri.parse('${globals.urlAPI}/cutis/$userId'));

  final List<dynamic> jsonResponse = json.decode(response.body);
  final List<Map<String, dynamic>> jsonMap =
      jsonResponse.cast<Map<String, dynamic>>();

  if (response.statusCode == 201) {
    return jsonMap.map((e) => CutiModel.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load Cuti');
  }
}

Future<List<CutiModel>> getCutiById(int cutiId) async {
  final response = await http.get(Uri.parse('${globals.urlAPI}/cuti/$cutiId'));

  final List<dynamic> jsonResponse = json.decode(response.body);
  final List<Map<String, dynamic>> jsonMap =
      jsonResponse.cast<Map<String, dynamic>>();

  if (response.statusCode == 201) {
    return jsonMap.map((e) => CutiModel.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load Cuti');
  }
}

Future<Map<String, dynamic>> getSisaCuti(int userId) async {
  final response =
      await http.get(Uri.parse('${globals.urlAPI}/cuti-sisa/$userId'));

  if (response.statusCode == 201) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse;
  } else {
    throw Exception('Failed to load Cuti');
  }
}

Future<Map<String, dynamic>> saveCutiAPI(Map<String, dynamic> request) async {
  final response = await http.post(
    Uri.parse('${globals.urlAPI}/cuti/add'),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(request),
  );

  if (response.statusCode == 201) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse;
  } else {
    throw Exception(response.statusCode);
  }
}
