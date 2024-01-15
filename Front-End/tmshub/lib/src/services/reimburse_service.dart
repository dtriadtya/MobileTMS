// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:tmshub/src/models/reimburse_model.dart';
import 'package:tmshub/src/utils/globals.dart' as globals;

import 'package:http/http.dart' as http;

Future<List<ReimburseModel>> getAllReimburseByUserAPI(int userId) async {
  final response =
      await http.get(Uri.parse(globals.urlAPI + '/reimburse/${userId}'));

  final List<dynamic> jsonResponse = json.decode(response.body);
  final List<Map<String, dynamic>> jsonMap =
      jsonResponse.cast<Map<String, dynamic>>();

  if (response.statusCode == 200) {
    return jsonMap.map((e) => ReimburseModel.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load Reimburse');
  }
}

Future<Map<String, dynamic>> createReimburseAPI(Map<String, dynamic> request) async {
  print(request.entries);
  final response = await http.post(
    Uri.parse(globals.urlAPI + '/reimburse/create'),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(request),
  );

  if (response.statusCode == 201) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse;
  } else {
    throw Exception('Gagal menambahkan Reimburse');
  }
}

Future<String> storeLampiranReimburseAPI(Map<String, String> req, XFile? imageFile) async {
  var request = http.MultipartRequest('POST', Uri.parse(globals.urlAPI + '/reimburse/lampiran'));

  if (imageFile != null) {
    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));
  }

  request.fields.addAll(req);

  final response = await request.send();

  if (response.statusCode == 201) {
    return "Berhasil";
  } else {
    throw Exception('Gagal mengupload gambar');
  }
}

