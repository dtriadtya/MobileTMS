// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tmshub/src/models/perusahaan_model.dart';
import 'package:tmshub/src/screens/presensi/presensi_map_screen.dart';
import 'package:tmshub/src/services/perusahaan_services.dart';

class LiveAttendPage1 extends StatefulWidget {
  const LiveAttendPage1({Key? key}) : super(key: key);

  @override
  State<LiveAttendPage1> createState() => _LiveAttendPage1State();
}

class _LiveAttendPage1State extends State<LiveAttendPage1> {
  List<PerusahaanModel>? companies;
  int? companySelectedIndex;

  @override
  void initState() {
    super.initState();
    getAllCompany().then((value) {
      setState(() {
        companies = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return companies?.isNotEmpty == true
        ? pageWidget()
        : Text("tidak ada data");
  }

  Widget buttonDropdownWidget() {
    return DropdownButtonFormField<int>(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(width: 5, color: Colors.blue),
        ),
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
      ),
      value: companySelectedIndex,
      items: companies
              ?.asMap()
              .entries
              .map((entry) => DropdownMenuItem<int>(
                    value: entry.key,
                    child: Text(
                      entry.value.namaPerusahaan,
                      style: TextStyle(fontSize: 24),
                    ),
                  ))
              .toList() ??
          [],
      onChanged: (selectedIndex) {
        setState(() {
          companySelectedIndex = selectedIndex;
        });

        if (companySelectedIndex != null) {
          int index = companySelectedIndex ?? 0;
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return PresensiMapScreen(
                latOffice: companies![index].lat,
                longOffice: companies![index].long,
              );
            }),
          );
        }
      },
      hint: Align(
        alignment: Alignment.center,
        child: Text(
          "Lokasi Kerja",
          style: TextStyle(
            fontSize: 14,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget pageWidget() {
    return Padding(
      padding: EdgeInsets.only(left: 24, right: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 8,
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Silahkan Pilih Lokasi Kerja",
              style: TextStyle(
                color: HexColor("#565656"),
                fontFamily: "Montserrat",
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          buttonDropdownWidget(),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: HexColor("#FF9F43"),
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: HexColor("#ffd1c7"),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 9, top: 5, bottom: 5, right: 9),
              child: Text(
                "Silahkan pilih lokasi kerja Anda, untuk dapat menggunakan fitur live attendance.",
                style: TextStyle(
                  color: HexColor("#FF9F43"),
                  fontFamily: "Montserrat",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
