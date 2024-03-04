import 'dart:convert';

import 'package:tmshub/src/models/admin/cuti_model_admin.dart';
import 'package:tmshub/src/utils/globals.dart' as globals;

import 'package:http/http.dart' as http;

Future<List<CutiAdmin>> getCutiAdminData() async {
  final response = await http.get(Uri.parse('${globals.urlAPI}/admin/cuti'));
  print("hasil dari respon cuti : \n ${response}");
  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);

    List<CutiAdmin> cutiAdminList = [];
    for (var item in jsonData) {
      CutiAdmin cutiAdmin = CutiAdmin.fromJson(item);
      cutiAdminList.add(cutiAdmin);
    }

    return cutiAdminList;
  } else {
    throw Exception('Failed to load cuti admin data');
  }
}

Future<Map<String, dynamic>> updateCutiStatus(
    Map<String, dynamic> request) async {
  final url = '${globals.urlAPI}/admin/cuti/update';

  final response = await http.put(Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(request));
  print('hasil dari respon update cuti: \n$response');

  if (response.statusCode == 200) {
    print('Status cuti berhasil diperbarui');
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse;
  } else {
    print(response.statusCode);
    throw Exception('Gagal memperbarui status cuti');
  }
}
