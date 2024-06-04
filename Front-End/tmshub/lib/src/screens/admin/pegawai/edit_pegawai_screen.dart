// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmshub/src/models/pegawai_model.dart';
import 'package:tmshub/src/models/user_model.dart';
import 'package:tmshub/src/services/pegawai_services.dart';
import 'package:tmshub/src/utils/globals.dart' as globals;
import 'package:tmshub/src/widgets/modal/custom_dialog.dart';
import 'package:tmshub/src/widgets/text_form_field.dart';
import 'package:tmshub/src/widgets/top_navigation.dart';

class EditPegawaiScreen extends StatefulWidget {
  final String userId;
  final String nama;
  final String email;
  const EditPegawaiScreen(
      {Key? key, required this.userId, required this.nama, required this.email})
      : super(key: key);

  @override
  State<EditPegawaiScreen> createState() => _EditPegawaiScreenState();
}

class _EditPegawaiScreenState extends State<EditPegawaiScreen> {
  String? selectedValue;
  List<String> options = ['Divisi Keuangan', 'Divisi Sumber Daya Manusia', 'Divisi Teknologi Informasi','Divisi Pemasaran'];
  Map<String, String> valueMapping = {
    'Divisi Keuangan': '1',
    'Divisi Sumber Daya Manusia': '2',
    'Divisi Teknologi Informasi': '3',
    'Divisi Pemasaran': '4',
  };
  // dynamic temp;
  TextEditingController alamatCont =
      TextEditingController(text: globals.pegawaiLogin?.alamatPegawai ?? "-");
  TextEditingController namaCont =
      TextEditingController();
  TextEditingController emailCont =
      TextEditingController();
  TextEditingController nohpCont =
      TextEditingController(text: globals.pegawaiLogin?.nohpPegawai ?? "-");
  TextEditingController divisiCont =
      TextEditingController(text: globals.pegawaiLogin?.divisi ?? "-");
  TextEditingController nipCont =
      TextEditingController(text: globals.pegawaiLogin?.nip ?? "-");
  int? id_pegawai;
  PegawaiModel? pegawaiData;

  void fetchPegawaiData() async {
    try {
      Map<String, dynamic> response =
          await getPegawaiAPI(int.parse(widget.userId));
      setState(() {
        alamatCont.text = response['alamat_pegawai'] ?? '';
        nohpCont.text = response['nohp_pegawai'] ?? '';
        nipCont.text = response['nip'] ?? '';
        selectedValue = response['divisi'] ?? '';
        id_pegawai = response['id_pegawai'] ?? 0;
        pegawaiData = PegawaiModel.fromJson(response);
      });
      log("isi dari respon : ${response['id_pegawai'].runtimeType}");
    } catch (e) {
      print('Error: $e');
      // Handle error
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPegawaiData();
    setState(() {
      namaCont.text = widget.nama;
      emailCont.text = widget.email;
    });
  }

  @override
  Widget build(BuildContext context) {
    log("isi dari pegawai data : ${pegawaiData?.alamatPegawai}");
    log("isi dari pegawai data : ${pegawaiData?.divisi}");
    log("isi dari pegawai data : ${pegawaiData?.fotoProfil}");
    log("isi dari pegawai data : ${pegawaiData?.idDivisi}");
    log("isi dari pegawai data : ${pegawaiData?.nip}");
    log("isi dari pegawai data : ${namaCont}");
    // log("isi dari widget id :${widget.userId}");
    // log("isi dari widget name :${widget.nama}");
    // log("isi dari widget email :${widget.email}");
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TopNavigation(title: "UBAH DATA"),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Silahkan lengkapi data dibawah ini !!!',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Color(0xFFA8AAAE),
                    fontSize: 12,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
              formMethod(context),
              Container(
                padding: EdgeInsets.only(top: 40, left: 20, right: 20),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () => savePegawai(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF537FE7),
                  ),
                  child: Text(
                    "SIMPAN",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  formMethod(context) {
    return Form(
      child: Container(
        // padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            CustomFormField(
              enable: true,
              obscureText: false,
              title: 'Nama Lengkap',
              controller: namaCont,
            ),
            CustomFormField(
              enable: true,
              obscureText: false,
              title: 'Alamat',
              controller: alamatCont,
            ),
            CustomFormField(
              enable: true,
              obscureText: false,
              title: 'Email',
              controller: emailCont,
            ),
            CustomFormField(
              enable: true,
              obscureText: false,
              title: 'No. Telepon',
              controller: nohpCont,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: DropdownButtonFormField<String>(
                value: selectedValue,
                items: options.map((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Divisi',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a division';
                  }
                  return null;
                },
              ),
            ),
            CustomFormField(
              enable: true,
              obscureText: false,
              title: 'Nomor Kepegawaian',
              controller: nipCont,
            ),
          ],
        ),
      ),
    );
  }

  savePegawai() {
    context.loaderOverlay.show();
    Map<String, dynamic> request = {
      'id_pegawai': id_pegawai.toString(),
      'nama_user': namaCont.text,
      'email_user': emailCont.text,
      'nip': nipCont.text,
      'alamat_pegawai': alamatCont.text,
      'nohp_pegawai': nohpCont.text,
      'id_divisi': valueMapping[selectedValue!] ?? '',
    };
    print(request);
    log("isi dari dropdown : ${valueMapping[selectedValue!]}");
    updateProfilAPI(request).then((value) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            title: "Berhasil",
            message: "Berhasil menyimpan perubahan!",
            type: "success",
          );
        },
      );
      context.loaderOverlay.hide();
    }).catchError((error) {
      context.loaderOverlay.hide();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            title: "Gagal Menyimpan",
            message: error.toString(),
            type: "failed",
          );
        },
      );
    });
  }
}
