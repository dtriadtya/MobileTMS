// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unnecessary_brace_in_string_interps, prefer_is_empty, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tmshub/src/models/penggajian_model.dart';
import 'package:tmshub/src/screens/payroll/detail_penggajian_screen.dart';
import 'package:tmshub/src/services/penggajian_services.dart';
import 'package:tmshub/src/widgets/top_navigation.dart';
import 'package:tmshub/src/utils/globals.dart' as globals;
import 'package:tmshub/src/widgets/utility.dart';

class PenggajianScreen extends StatefulWidget {
  const PenggajianScreen({Key? key}) : super(key: key);

  @override
  State<PenggajianScreen> createState() => _PenggajianScreenState();
}

class _PenggajianScreenState extends State<PenggajianScreen> {
  List<PenggajianModel>? listPenggajian;
  bool isExist = false;

  @override
  void initState() {
    super.initState();
    getPenggajianByUserAPI(globals.userLogin!.idUser).then((value) {
      setState(() {
        listPenggajian = value;
        isExist = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopNavigation(title: "penggajian"),
          SizedBox(
            height: 10,
          ),
          contentPenggajian()
        ],
      ),
    );
  }

  Widget contentPenggajian() {
    if (isExist) {
      if (listPenggajian!.length != 0) {
        return Expanded(child: SingleChildScrollView(child: screenExist()));
      } else {
        return noContent();
      }
    } else {
      return problemNetwork();
    }
  }

  Widget screenExist() {
    return Column(
      children: listPenggajian!.map((penggajian) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: cardPayroll(pData: penggajian),
        );
      }).toList(),
    );
  }

  Widget cardPayroll({required PenggajianModel pData}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: () {
              // print("click");
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return DetailPenggajianScreen(penggajianModel: pData);
              }));
            },
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(11),
                  topRight: Radius.circular(11),
                  bottomLeft: Radius.circular(11),
                  bottomRight: Radius.circular(11),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 21),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pData.keterangan,
                      style: TextStyle(
                          color: HexColor("#3D3D3D"),
                          fontFamily: "Montserrat",
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Rp. ${pData.gajiPokok}",
                      style: TextStyle(
                          color: HexColor("#A8AAAE"),
                          fontFamily: "Montserrat",
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      pData.statusGaji,
                      style: TextStyle(
                          color: HexColor("#38D32A"),
                          fontFamily: "Montserrat",
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            )),
      ),
      decoration: BoxDecoration(
          color: HexColor("#f1f7fb"), borderRadius: BorderRadius.circular(15)),
    );
  }
}
