// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tmshub/src/models/cuti_model.dart';
import 'package:tmshub/src/utils/globals.dart' as globals;
import 'package:tmshub/src/widgets/top_navigation.dart';

class CutiDetailScreen extends StatelessWidget {
  final CutiModel cuti;

  const CutiDetailScreen({Key? key, required this.cuti}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(top: 14, left: 10, right: 10, bottom: 20),
                child: TopNavigation(title: "Detail Pengajuan Cuti"),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: HexColor("#8CE5F1F8"),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: HexColor("#BAA4FF"),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                              ),
                              child: Image(
                                image: AssetImage("assets/edit-100.png"),
                                filterQuality: FilterQuality.high,
                              ),
                            ),
                            SizedBox(width: 18),
                            Text(
                              "Cuti",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: HexColor("#565656"),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                        SizedBox(height: 12),
                        cutiDetailCard(
                            tittle: "Nama",
                            content: globals.userLogin!.namaUser!,
                            icon: Icons.person),
                        SizedBox(height: 18),
                        cutiDetailCard(
                            tittle: "Mulai Cuti",
                            content: cuti.tglMulai,
                            icon: Icons.calendar_month),
                        SizedBox(height: 18),
                        cutiDetailCard(
                            tittle: "Selesai Cuti",
                            content: cuti.tglSelesai,
                            icon: Icons.event_available),
                        SizedBox(height: 18),
                        cutiDetailCard(
                            tittle: "Status Cuti",
                            content: cuti.statusCuti,
                            icon: Icons.person),
                        SizedBox(height: 18),
                        cutiDetailCard(
                            tittle: "Disetujui Oleh",
                            content: cuti.admin,
                            icon: Icons.person),
                        SizedBox(height: 18),
                        cutiDetailCard(
                            tittle: "Jenis Cuti",
                            content: cuti.jenisCuti,
                            icon: Icons.beach_access),
                        SizedBox(height: 18),
                        cutiDetailCard(
                            tittle: "Keterangan",
                            content: cuti.keterangan,
                            icon: Icons.menu),
                        SizedBox(height: 18),
                        cutiDetailCard(
                            tittle: "Sisa Cuti",
                            content: cuti.sisaCuti == null ? "-" : cuti.sisaCuti!,
                            icon: Icons.calendar_today),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

Widget cutiDetailCard(
    {required String tittle, required String content, required var icon}) {
  return Row(
    children: [
      Icon(icon, size: 32),
      SizedBox(width: 18),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tittle,
            style: TextStyle(
              fontFamily: "Montserrat",
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: HexColor("#3D3D3D"),
            ),
          ),
          SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontFamily: "Montserrat",
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: HexColor("#6E6E6E"),
            ),
          ),
        ],
      )
    ],
  );
}
