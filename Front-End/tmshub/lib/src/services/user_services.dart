// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:tmshub/src/utils/globals.dart' as globals;

import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> loginAPI(Map<String, dynamic> request) async {
  final response = await http.post(
    Uri.parse(globals.urlAPI + '/login'),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(request),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse;
  } else {
    throw Exception('Gagal login');
  }
}

Future<Map<String, dynamic>> registerAPI(Map<String, dynamic> request) async {
  final response = await http.post(
    Uri.parse(globals.urlAPI + '/register'),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(request),
  );

  if (response.statusCode == 201 || response.statusCode == 422) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    jsonResponse['statusCode'] = response.statusCode;
    return jsonResponse;
  } else {
    throw Exception('Gagal register');
  }
}

Future<Map<String, dynamic>> changePasswordAPI(
    Map<String, dynamic> request) async {
  final response = await http.post(
    Uri.parse(globals.urlAPI + '/change-password'),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(request),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    jsonResponse['statusCode'] = response.statusCode;
    return jsonResponse;
  } else {
    throw Exception('Gagal mengubah password');
  }
}
