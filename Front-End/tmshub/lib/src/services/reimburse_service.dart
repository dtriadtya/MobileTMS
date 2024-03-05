import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:tmshub/src/models/reimburse_model.dart';
import 'package:tmshub/src/utils/globals.dart' as globals;

Future<List<ReimburseModel>> getAllReimburseByUserAPI(int userId) async {
  final response =
      await http.get(Uri.parse(globals.urlAPI + '/reimburse/${userId}'));

  final List<dynamic> jsonResponse = json.decode(response.body);
  final List<Map<String, dynamic>> jsonMap =
      jsonResponse.cast<Map<String, dynamic>>();
  print(jsonResponse);

  if (response.statusCode == 200) {
    return jsonMap.map((e) => ReimburseModel.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load Reimburse');
  }
}

Future<Map<String, dynamic>> createReimburseAPI(
    Map<String, dynamic> request) async {
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

Future<Map<String, dynamic>> updateReimburseStatus(
    Map<String, dynamic> request) async {
  final url = '${globals.urlAPI}/admin/reimburse/update';

  final response = await http.put(Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(request));
  print('hasil dari respon update Reimburse: \n$response');

  if (response.statusCode == 200) {
    print('Status Reimburse berhasil diperbarui');
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse;
  } else {
    print(response.statusCode);
    throw Exception('Gagal memperbarui status Reimburse');
  }
}

Future<String> storeLampiranReimburseAPI(
    Map<String, String> req, XFile? imageFile) async {
  var request = http.MultipartRequest(
      'POST', Uri.parse(globals.urlAPI + '/reimburse/lampiran'));

  if (imageFile != null) {
    request.files.add(await http.MultipartFile.fromPath(
        'image', imageFile.path));
  }

  request.fields.addAll(req);

  final response = await request.send();

  if (response.statusCode == 201) {
    return "Berhasil";
  } else {
    throw Exception('Gagal mengupload gambar');
  }
}

Future<http.Response> openLampiranReimburseAPI(
    int reimburseId, String fileName) async {
  final url = '${globals.urlAPI}/reimburse/lampiran/$reimburseId/$fileName';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Gagal membuka lampiran');
  }
}