// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tmshub/src/screens/admin/cuti/cuti_admin_detail.dart';
import 'package:tmshub/src/screens/admin/cuti/cuti_screen_admin.dart';
import 'package:tmshub/src/screens/admin/reimburse/reimburse_admin_screen.dart';
import 'package:tmshub/src/screens/payroll/penggajian_screen.dart';
import 'package:tmshub/src/screens/presensi/presensi_screen.dart';
import 'package:tmshub/src/screens/reimburse/pengembaliandana_screen.dart';

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
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
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
                    buttonItem(
                        title: "Validasi\n Presensi",
                        icon: Icons.calendar_month,
                        context: context,
                        destination: PresensiScreen()),
                    buttonItem(
                        title: "Validasi\n Cuti",
                        icon: Icons.edit_calendar,
                        context: context,
                        destination: CutiScreenAdmin()),
                    buttonItem(
                        title: "Validasi\n Penggajian",
                        icon: Icons.payments,
                        context: context,
                        destination: PenggajianScreen()),
                    buttonItem(
                        title: "Validasi\n Pengembalian Dana",
                        icon: Icons.account_balance,
                        context: context,
                        destination: ReimburseScreenAdmin())
                  ],
                )
              ],
            ),
          )),
    );
  }

  Widget buttonItem(
      {String title = "",
      IconData icon = Icons.abc,
      required BuildContext context,
      required Widget destination}) {
    final double sizeWidth = MediaQuery.of(context).size.width;
    double fontSize = sizeWidth / 35;
    double iconSize = sizeWidth / 10;
    double containerSize = sizeWidth / 5.5;
    if (title.length > 10) {
      fontSize = sizeWidth / 38;
      iconSize = sizeWidth / 16;
      containerSize = sizeWidth / 4.5;
    } else if (title.length > 9) {
      fontSize = sizeWidth / 39;
    }
    return Container(
      width: 77,
      height: 77,
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
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    Icon(icon, size: iconSize),
                    Expanded(
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: fontSize),
                      ),
                    )
                  ],
                ),
              ),
            )),
      ),
      decoration: BoxDecoration(
        color: HexColor('#F9F6F6'),
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
