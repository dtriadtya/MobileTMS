// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, avoid_unnecessary_containers, prefer_is_empty

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tmshub/src/models/reimburse_model.dart';
import 'package:tmshub/src/screens/reimburse/add_reimburse_screen.dart';
import 'package:tmshub/src/screens/reimburse/reimburse_detail_screen.dart';
import 'package:tmshub/src/services/reimburse_service.dart';
import 'package:tmshub/src/widgets/top_navigation.dart';
import 'package:tmshub/src/utils/globals.dart' as globals;
import 'package:intl/intl.dart';

class PengembalianDanaScreen extends StatefulWidget {
  const PengembalianDanaScreen({Key? key}) : super(key: key);

  @override
  State<PengembalianDanaScreen> createState() => _PengembalianDanaScreenState();
}

class _PengembalianDanaScreenState extends State<PengembalianDanaScreen> {
  List<ReimburseModel>? listReimburse;
  bool isExist = false;
  @override
  void initState() {
    super.initState();
    getAllReimburseByUserAPI(globals.userLogin!.idUser!).then((value) {
      setState(() {
        listReimburse = value;
        isExist = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [TopNavigation(title: "Pengembalian Dana"), content()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("object");
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return AddReimburseScreen();
          })).then((value) {
            setState(() {});
          });
        },
        tooltip: 'Add Reimburse',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget content() {
    if (isExist) {
      if (listReimburse!.length != 0) {
        return Expanded(child: SingleChildScrollView(child: screenExist()));
      } else {
        return noContent();
      }
    } else {
      return problemNetwork();
    }
  }

  Widget screenExist() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: listReimburse!.map((e) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    print("click");
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return ReimburseDetailScreen(
                        reimburse: e,
                      );
                    }));
                  },
                  child: Ink(
                    child: cardContent(
                        title: "PENGEMBALIAN DANA",
                        status: e.statusReimburse.toString(),
                        dateTime: e.tanggalReimburse),
                  ),
                )),
          );
        }).toList(),
      ),
    );
  }

  Widget cardContent(
      {required String title,
      required String status,
      required DateTime? dateTime}) {
    String formattedDate = dateTime != null ? DateFormat('d MMMM y').format(dateTime) : '-';
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          boxDollar(),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${title}",
                      style: TextStyle(
                          color: HexColor("#3D3D3D"),
                          fontFamily: "Montserrat",
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${status}",
                      style: TextStyle(
                          color: HexColor("#A8AAAE"),
                          fontFamily: "Montserrat",
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "${formattedDate}",
                      style: TextStyle(
                          color: HexColor("#565656"),
                          fontFamily: "Montserrat",
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: HexColor("#3D3D3D"),
            size: 25,
          )
        ],
      ),
    );
  }

  Widget boxDollar() {
    return Container(
      width: 48,
      height: 48,
      child: Icon(
        Icons.attach_money,
        color: HexColor("#FFFFFF"),
        size: 30,
      ),
      decoration: BoxDecoration(
          color: HexColor("#74CD93"), borderRadius: BorderRadius.circular(12)),
    );
  }

  Widget noContent() {
    return Expanded(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/no_content.png'),
          SizedBox(
            height: 15,
          ),
          Text(
            "Tidak ada data.",
            style: TextStyle(
                color: HexColor("#A09C9C"),
                fontFamily: "Montserrat",
                fontSize: 18,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    ));
  }

  Widget problemNetwork() {
    return Expanded(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/404.png'),
          SizedBox(
            height: 15,
          ),
          Text(
            "Tidak ada data.",
            style: TextStyle(
                color: HexColor("#A09C9C"),
                fontFamily: "Montserrat",
                fontSize: 18,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    ));
  }
}
