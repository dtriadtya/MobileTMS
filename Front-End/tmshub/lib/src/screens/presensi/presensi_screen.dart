// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tmshub/src/screens/presensi/presensi_history.dart';
import 'package:tmshub/src/widgets/presensi_widgets/live_attend1.dart';
import 'package:tmshub/src/widgets/top_navigation.dart';
import 'package:tmshub/src/utils/globals.dart' as globals;

class PresensiScreen extends StatelessWidget {
  const PresensiScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TopNavigation(title: "presensi"),
            LiveAttendPage1(),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 0, 0),
                child: Text(
                  "Riwayat Presensi",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Montserrat",
                      color: HexColor("#565656")),
                ),
              ),
            ),
            Expanded(child: PresensiHistoryView()),
          ],
        ),
      ),
    );
  }
}
