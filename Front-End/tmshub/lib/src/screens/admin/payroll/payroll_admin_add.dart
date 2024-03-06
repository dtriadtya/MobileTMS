// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tmshub/src/models/penggajian_model.dart';
import 'package:tmshub/src/services/penggajian_services.dart';
import 'package:tmshub/src/utils/globals.dart' as globals;
import 'package:tmshub/src/widgets/modal/custom_dialog.dart';
import 'package:tmshub/src/widgets/top_navigation.dart';

class PenggajianAddScreen extends StatefulWidget {
  final String userId;

  const PenggajianAddScreen({super.key, required this.userId});
  @override
  _PenggajianAddState createState() => _PenggajianAddState();
}

class _PenggajianAddState extends State<PenggajianAddScreen> {
  List<PenggajianModel>? listPenggajian;
  TextEditingController startDateCont = TextEditingController();
  TextEditingController endDateCont = TextEditingController();
  TextEditingController keteranganCont = TextEditingController();

  bool isEnabled = false;

  @override
  void initState() {
    startDateCont.text = '';
    endDateCont.text = '';
    keteranganCont.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 50,
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: HexColor("#537FE7"),
              foregroundColor: Colors.white),
          onPressed: () {
            if (isEnabled) {
              saveGaji();
            }
          },
          child: Text("Kirim"),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 14, left: 10, right: 10),
              child: TopNavigation(title: "Permintaan Pengajuan Gaji"),
            ),
            Form(
              child: Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Gaji Pokok",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: HexColor("#565656"),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      initialValue: listPenggajian?[1].gajiPokok,
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: HexColor("#565656"),
                      ),
                      decoration: InputDecoration(
                        enabled: false,
                        filled: true,
                        fillColor: Color.fromRGBO(168, 170, 174, 0.5),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            gapPadding: 16),
                        contentPadding:
                            EdgeInsetsDirectional.symmetric(horizontal: 20),
                      ),
                    ),
                    SizedBox(height: 16),

                    //field awal cuti
                    Text(
                      "Tanggal Gaji",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: HexColor("#565656"),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: startDateCont,
                      onTap: () async {
                        var temp = await _pickDate(context);
                        if (temp == null) return;
                        setState(() {
                          startDateCont.text =
                              DateFormat("d MMMM y").format(temp);
                          endDateCont.text = "";
                        });
                      },
                      readOnly: true,
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: HexColor("#565656"),
                      ),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            gapPadding: 16,
                          ),
                          contentPadding: EdgeInsetsDirectional.symmetric(
                            horizontal: 20,
                          ),
                          suffixIcon: Icon(Icons.event_available_outlined)),
                    ),

                    SizedBox(height: 16),

                    Text(
                      "Transportasi",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: HexColor("#565656"),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      initialValue: 'Rp ${listPenggajian?[1].transportasi}',
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: HexColor("#565656"),
                      ),
                      decoration: InputDecoration(
                        enabled: false,
                        filled: true,
                        fillColor: Color.fromRGBO(168, 170, 174, 0.5),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            gapPadding: 16),
                        contentPadding:
                            EdgeInsetsDirectional.symmetric(horizontal: 20),
                      ),
                    ),
                    SizedBox(height: 16),

                    // field keterangan
                    Text(
                      "Keterangan",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: HexColor("#565656"),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: keteranganCont,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            gapPadding: 16),
                        contentPadding:
                            EdgeInsetsDirectional.symmetric(horizontal: 20),
                      ),
                    ),

                    //Note
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: HexColor("#4DFF9F43"),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      child: Text(
                        "Keterangan : Untuk teks keterangan mohon diisikan dengan alasan dari pengambilan cuti.",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: HexColor("#FFFF9F43"),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _pickDate(BuildContext context) {
    var now = DateTime.now();
    final newDate = showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 1),
    );
    return newDate;
  }

  int diffOfDate(String start, DateTime end) {
    // DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateTime from = DateFormat('d MMMM y').parse(start);
    DateTime to = end;
    return (to.difference(from).inHours / 24).round() + 1;
    // String _start =
    //     DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM y').parse(start));
    // String _end =
    //     DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM y').);
    // return int.parse(_start) - int.parse(_end);
  }

  String parseDateInput(String input) {
    return DateFormat('yyyy-MM-dd').format(DateFormat('d MMMM y').parse(input));
  }

  saveGaji() {
    context.loaderOverlay.show();
    Map<String, String> request = {
      "id_user": "25",
      "gaji_pokok": "50000000",
      "transportasi": "60000",
      "status_gaji": "Lunas",
      "keterangan": "Februari 2024",
      "bonus": "1000",
      "id_admin": "23",
      "tanggal": "2024-02-16 14:30:00"
    };
    addPenggajianAPI(request).then((response) {
      Navigator.pop(context, true);
      context.loaderOverlay.hide();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            title: "Sukses Menyimpan Gaji",
            message: "Berhasil menyimpan Gaji!",
            type: "success",
          );
        },
      );
    }).onError((error, stackTrace) {
      context.loaderOverlay.hide();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            title: "Gagal Menyimpan Cuti",
            message: error.toString(),
            type: "failed",
          );
        },
      );
    });
  }
}
