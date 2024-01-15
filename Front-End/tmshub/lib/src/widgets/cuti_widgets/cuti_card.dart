// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tmshub/src/models/cuti_model.dart';
import 'package:tmshub/src/screens/cuti/cuti_detail_screen.dart';

class CutiCard extends StatelessWidget {
  final CutiModel cuti;

  const CutiCard({Key? key, required this.cuti}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: HexColor("#BAA4FF"),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Image(
                image: AssetImage("assets/edit-100.png"),
                filterQuality: FilterQuality.high,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 150,
              padding: EdgeInsets.only(left: 20),
              height: 60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cuti",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: HexColor("#3D3D3D"),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    cuti.statusCuti,
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: HexColor("#A8AAAE"),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    cuti.tglMulai.toString(),
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: HexColor("#565656"),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              alignment: Alignment.center,
              splashRadius: 30,
              iconSize: 20,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CutiDetailScreen(
                              cuti: cuti,
                            )));
              },
            )
          ],
        ));
  }
}
