import 'dart:convert';

import 'package:tmshub/src/models/pegawai_model.dart';
import 'package:tmshub/src/utils/globals.dart' as globals;
import 'package:http/http.dart' as http;

Future<List<PegawaiModel>> getPegawaiData() async {
  final response = await http.get(Uri.parse('${globals.urlAPI}/admin/cuti'));
  print("hasil dari respon cuti : \n ${response}");
  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);

    List<PegawaiModel> pegawaiAdminList = [];
    for (var item in jsonData) {
      PegawaiModel pegawaiAdmin = PegawaiModel.fromJson(item);
      pegawaiAdminList.add(pegawaiAdmin);
    }

    return pegawaiAdminList;
  } else {
    throw Exception('Failed to load cuti admin data');
  }
}
