import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tmshub/src/models/admin/cuti_model_admin.dart';
import 'package:tmshub/src/models/penggajian_model.dart';
import 'package:tmshub/src/screens/admin/payroll/payroll_admin_add.dart';
import 'package:tmshub/src/services/admin/cuti_admin_service.dart';
import 'package:tmshub/src/services/penggajian_services.dart';
import 'package:tmshub/src/utils/globals.dart' as globals;
import 'package:tmshub/src/widgets/admin/list_data.dart';
import 'package:tmshub/src/widgets/modal/custom_dialog.dart';
import 'package:tmshub/src/widgets/top_navigation.dart';
import 'package:tmshub/src/widgets/utility.dart';

class PayrollListScreenAdmin extends StatefulWidget {
  final String userId;

  const PayrollListScreenAdmin({Key? key, required this.userId})
      : super(key: key);

  @override
  _PayrollListScreenAdminState createState() => _PayrollListScreenAdminState();
}

class _PayrollListScreenAdminState extends State<PayrollListScreenAdmin> {
  List<PenggajianModel>? listPenggajian;
  bool isExist = false;

  @override
  void initState() {
    super.initState();
    getPenggajianByUserAPI(int.parse(widget.userId)).then((value) {
      setState(() {
        listPenggajian = value;
        isExist = true;
      });
    });
  }

  void _navigateToNextPage(String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PenggajianAddScreen(userId: userId),
      ),
    );
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
          contentPenggajian(),
          ElevatedButton(
              onPressed: () {
                _navigateToNextPage(widget.userId);
              },
              child: Text("next")),
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
              // // print("click");
              // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              //   return DetailPenggajianScreen(penggajianModel: pData);
              // }));
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
                      pData.keterangan.toString(),
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
                      pData.statusGaji.toString(),
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
