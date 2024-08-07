// ignore_for_file: unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:tmshub/src/models/penggajian_model.dart';
import 'package:tmshub/src/utils/globals.dart' as globals;

import 'package:http/http.dart' as http;

Future<List<PenggajianModel>> getPenggajianByUserAPI(int userId) async {
  final response =
      await http.get(Uri.parse(globals.urlAPI + '/penggajian/${userId}'));

  final List<dynamic> jsonResponse = json.decode(response.body);
  print("respon gaji ${response.body}");
  final List<Map<String, dynamic>> jsonMap =
      jsonResponse.cast<Map<String, dynamic>>();

  if (response.statusCode == 200) {
    return jsonMap.map((e) => PenggajianModel.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load Penggajian');
  }
}

Future<Map<String, dynamic>> addPenggajianAPI(
    Map<String, dynamic> request) async {
  final response = await http.post(
    Uri.parse('${globals.urlAPI}/admin/penggajian/add'),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(request),
  );
  print("hasil response add gaji : ${response.body}");
  print("code add gaji : ${response.statusCode}");
  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse;
  } else {
    throw Exception(response.statusCode);
  }
}

Future<String> storeLampiranPenggajianAPI(
    Map<String, String> req, XFile? imageFile) async {
  var request = http.MultipartRequest(
      'POST', Uri.parse(globals.urlAPI + '/penggajian/lampiran'));

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
