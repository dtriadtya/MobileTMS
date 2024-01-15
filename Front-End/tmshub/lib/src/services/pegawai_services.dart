// ignore_for_file: unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:tmshub/src/utils/globals.dart' as globals;
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> getPegawaiAPI(int userId) async {
  final response =
      await http.get(Uri.parse(globals.urlAPI + '/pegawai/${userId}'));

  if (response.statusCode == 200 || response.statusCode == 404) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    jsonResponse['statusCode'] = response.statusCode;
    return jsonResponse;
  } else {
    throw Exception('Failed to load Pegawai');
  }
}

Future<String> changePictureAPI(
    Map<String, String> req, XFile? imageFile) async {
  var request = http.MultipartRequest(
      'POST', Uri.parse(globals.urlAPI + '/pegawai/update-profile-picture'));

  if (imageFile != null) {
    request.files
        .add(await http.MultipartFile.fromPath('image', imageFile.path));
  }

  request.fields.addAll(req);

  final response = await request.send();

  if (response.statusCode == 201) {
    return "Berhasil";
  } else {
    throw Exception('Gagal mengupload gambar');
  }
}

Future<Map<String, dynamic>> updateProfilAPI(
    Map<String, dynamic> request) async {
  final response = await http.post(
    Uri.parse(globals.urlAPI + '/pegawai/update-profile'),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(request),
  );
  print(json.decode(response.body).toString());

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse;
  } else {
    throw Exception('Gagal Mengubah Profil');
  }
}
