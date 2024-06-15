// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tmshub/src/screens/admin/cuti/cuti_screen_admin.dart';
import 'package:tmshub/src/screens/admin/payroll/payroll_admin_screen.dart';
import 'package:tmshub/src/screens/admin/pegawai/pegawai_screen_admin.dart';
import 'package:tmshub/src/screens/admin/presensi/presensi_admin.dart';
import 'package:tmshub/src/screens/admin/reimburse/reimburse_admin_screen.dart';

class DasboardNavigationAdminWidget extends StatelessWidget {
  const DasboardNavigationAdminWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 7, right: 7, top: 20),
      child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: HexColor("#E5F1F8"),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 10, right: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "beranda".toUpperCase(),
                  style: TextStyle(
                      color: HexColor("#5d5d5e"),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Montserrat"),
                ),
                SizedBox(height: 13),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // card fitur
                    Expanded(
                      child: buttonItem(
                          title: "Validasi\n Presensi",
                          imagePath: "assets/presensi_icon.png",
                          context: context,
                          destination: PresensiScreenAdmin()),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: buttonItem(
                          title: "Validasi\n Cuti",
                          imagePath: "assets/cuti_icon.png",
                          context: context,
                          destination: CutiScreenAdmin()),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: buttonItem(
                          title: "Validasi\n Penggajian",
                          imagePath: "assets/payroll_icon.png",
                          context: context,
                          destination: PayrollScreenAdmin()),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: buttonItem(
                          title: "Validasi Pengembalian Dana",
                          imagePath: "assets/reimburse_icon.png",
                          context: context,
                          destination: ReimburseScreenAdmin()),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                buttonItem(
                    title: "Manajemen\n Profile User",
                    imagePath: "assets/profile1.png",
                    context: context,
                    destination: PegawaiScreenAdmin())
              ],
            ),
          )),
    );
  }

  Widget buttonItem({
    String title = "",
    required String imagePath,
    required BuildContext context,
    required Widget destination,
  }) {
    final double sizeWidth = MediaQuery.of(context).size.width;
    double fontSize = sizeWidth / 35;
    double iconSize = sizeWidth / 10;
    double containerSize = sizeWidth / 4.5;

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 4,
      ), // Adding margin to prevent overflow
      width: containerSize,
      height: containerSize,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return destination;
            }));
          },
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: EdgeInsets.all(0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    imagePath,
                    width: iconSize,
                    height: iconSize,
                  ),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: HexColor('#F9F6F6'),
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
