// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print, sort_child_properties_last, unnecessary_string_interpolations, avoid_init_to_null, library_private_types_in_public_api, unnecessary_brace_in_string_interps

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tmshub/src/models/presensi_model.dart';
import 'package:tmshub/src/services/presensi_services.dart';
import 'package:tmshub/src/widgets/modal/custom_dialog.dart';
import 'package:tmshub/src/widgets/presensi_widgets/map_widget.dart';
import 'package:tmshub/src/widgets/top_navigation.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tmshub/src/utils/globals.dart' as globals;

class PresensiMapScreen extends StatefulWidget {
  const PresensiMapScreen(
      {Key? key, required this.latOffice, required this.longOffice})
      : super(key: key);
  final double latOffice;
  final double longOffice;

  @override
  _PresensiMapScreenState createState() => _PresensiMapScreenState();
}

class _PresensiMapScreenState extends State<PresensiMapScreen> {
  late PresensiModel? presensiData = null;

  DateTime currentTime = DateTime.now();

  @override
  void initState() {
    initializeDateFormatting();
    super.initState();
    fetchPresensiToday().then((value) {
      if (value.isEmpty) {
        print(value.toString());
      } else {
        setState(() {
          presensiData = PresensiModel.formJson(value);
        });
      }
      // print(value);
      // print(PresensiModel.formJson(value).toString());
    });
    print("========================================================");
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        currentTime = DateTime.now();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // print("=presensidata");
    // print(presensiData.toString());
    bool isInradius = calculateDistance(widget.latOffice, widget.longOffice,
                globals.latitudeNow, globals.longtitudeNow) <=
            30
        ? true
        : false;
    // print(isInradius);
    return Scaffold(
      body: Column(
        children: [
          TopNavigation(title: "presensi"),
          // MapWidget(),
          SizedBox(
            height: 10,
          ),
          Text("Silahkan lakukan presensi terlebih dahulu",
              style: TextStyle(
                  color: HexColor("#000"),
                  fontFamily: "Montserrat",
                  fontSize: 12,
                  fontWeight: FontWeight.w600)),
          SizedBox(
            height: 10,
          ),
          contentPresensi(isInradius),
          SizedBox(
            height: 13,
          ),
          if (isInradius) contentLogPresensi(),
          if (!isInradius) contentNotInRadius()
        ],
      ),
    );
  }

  Widget contentLogPresensi() {
    final formattedDate =
        DateFormat('EEEE, d MMMM y', 'id_ID').format(DateTime.now());

    //saya ingin mengambil timenya saja pada checkin setelah diambil saya ingin mengubah formatnay ke am pm dan menampilakn hh:mm saja
    return presensiData == null
        ? Container(
            padding: EdgeInsets.all(80),
            width: MediaQuery.of(context).size.width,
            child: Align(
              alignment: Alignment.center,
              child: Text("Tidak ada data."),
            ),
          )
        : Container(
            padding: EdgeInsets.only(left: 24, right: 24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${formattedDate}",
                      style: TextStyle(
                          color: HexColor("#000"),
                          fontFamily: "Montserrat",
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Riwayat Presensi",
                      style: TextStyle(
                          color: HexColor("#B6B6B6"),
                          fontFamily: "Montserrat",
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),

                SizedBox(
                  height: 13,
                ),
                // log datanya
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${DateFormat('h:mm a').format(presensiData!.checkIn)}',
                      style: TextStyle(
                          color: HexColor("#000"),
                          fontFamily: "Montserrat",
                          fontSize: 24,
                          fontWeight: FontWeight.w600),
                    ),
                    Chip(
                      label: Text("In"),
                      backgroundColor: HexColor("#28C76F"),
                    )
                  ],
                ),
                SizedBox(
                  height: 13,
                ),
                if (presensiData!.checkOut != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${DateFormat('h:mm a').format(presensiData!.checkOut!)}',
                        style: TextStyle(
                            color: HexColor("#000"),
                            fontFamily: "Montserrat",
                            fontSize: 24,
                            fontWeight: FontWeight.w600),
                      ),
                      Chip(
                        label: Text("Out"),
                        backgroundColor: HexColor("#EA5455"),
                      )
                    ],
                  )
              ],
            ),
          );
  }

  Widget contentPresensi(bool isInradius) {
    final formattedTime = DateFormat('h:mm a').format(DateTime.now());
    final formattedDate =
        DateFormat('EEEE, d MMMM y', 'id_ID').format(DateTime.now());
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Container(
        padding: EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            mapContent(),
            SizedBox(
              height: 10,
            ),
            if (isInradius)
              Column(
                children: [
                  clockContent(formattedTime, formattedDate),
                  SizedBox(
                    height: 10,
                  ),
                  attendButtonContent(),
                ],
              ),
          ],
        ),
        decoration: BoxDecoration(
          color: HexColor("#E5F1F8"),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget clockContent(var formattedTime, var formattedDate) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(5),
      child: Container(
        padding: EdgeInsets.all(5),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Text(
              "Waktu Presensi",
              style: TextStyle(
                color: HexColor("#000"),
                fontFamily: "Montserrat",
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "$formattedTime",
              style: TextStyle(
                color: HexColor("#000"),
                fontFamily: "Montserrat",
                fontSize: 32,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "$formattedDate",
              style: TextStyle(
                color: HexColor("#000"),
                fontFamily: "Montserrat",
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: HexColor("#E5F1F8"),
            borderRadius: BorderRadius.circular(10)),
      ),
      decoration: BoxDecoration(
          color: HexColor("#C0EEF9"), borderRadius: BorderRadius.circular(10)),
    );
  }

  Widget mapContent() {
    return Container(
      width: 400,
      height: 200,
      child: MapWidget(
        latitudeOffice: "${widget.latOffice}",
        longtitudeOffice: "${widget.longOffice}",
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            offset: Offset(1, 2),
            blurRadius: 1,
            spreadRadius: -1,
          ),
        ],
      ),
    );
  }

  Widget attendButtonContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return HexColor("#87bb55");
                }
                return HexColor("#b2ec5d");
              },
            ),
          ),
          child: const Text(
            ' Masuk ',
          ),
          onPressed: presensiData != null
              ? null
              : () {
                  Map<String, dynamic> request = {
                    'id_user': globals.userLogin!.idUser,
                    'check_in': currentTime.toString(),
                    'check_out': currentTime.toString(),
                    'maps_checkin': globals.locationNow,
                    'maps_checkout': globals.locationNow
                  };
                  attendUser(request).then((value) {
                    if (value.isEmpty) {
                      print(value.toString());
                    } else {
                      setState(() {
                        presensiData = PresensiModel.formJson(value);
                      });
                    }
                    modalMasuk();
                  });
                },
        ),
        // SizedBox(width: 5,),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return HexColor("#d52323");
                }
                return HexColor("#F54141");
              },
            ),
          ),
          child: const Text(
            ' Keluar ',
          ),
          onPressed: (presensiData == null || presensiData!.checkOut != null)
              ? null
              : () {
                  Map<String, dynamic> request = {
                    'id_user': globals.userLogin!.idUser,
                    'check_in': currentTime.toString(),
                    'check_out': currentTime.toString(),
                    'maps_checkin': globals.locationNow,
                    'maps_checkout': globals.locationNow
                  };
                  attendUser(request).then((value) {
                    if (value.isEmpty) {
                      print(value.toString());
                    } else {
                      setState(() {
                        presensiData = PresensiModel.formJson(value);
                      });
                    }
                    modalMasuk();
                  });
                },
        ),
      ],
    );
  }

  Future modalMasuk() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          title: "SUKSES",
          message: "Permintaan Anda yang berhasil terkirim",
          type: "success",
        );
      },
    );
  }

  Future modalKeluar() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          title: "GAGAL",
          message: "Permintaan Anda yang gagal terkirim",
          type: "failed",
        );
      },
    );
  }

  Widget contentNotInRadius() {
    return Container(
      padding: EdgeInsets.only(left: 18, right: 18),
      child: Column(
        children: [
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
                "Anda berada di luar lokasi area kerja. Silahkan menuju lokasi area kerja untuk dapat menggunakan fitur live attendance",
                style: TextStyle(
                  color: HexColor("#FF9F43"),
                  fontFamily: "Montserrat",
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Image.asset('assets/not_range.png', width: 200),
          SizedBox(
            height: 10,
          ),
          Text(
            "Data Tidak Ditemukan",
            style: TextStyle(
                color: HexColor("#A8AAAE"),
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: "Montserrat"),
          )
        ],
      ),
    );
  }
}

double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  // print("${lat2} ${lon2}");
  const double earthRadius = 6371000; // Radius of the Earth in meters

  // Convert latitude and longitude from degrees to radians
  double lat1Rad = degToRad(lat1);
  double lat2Rad = degToRad(lat2);

  // Haversine formula
  double dLat = degToRad(lat2 - lat1);
  double dLon = degToRad(lon2 - lon1);
  double a = sin(dLat / 2) * sin(dLat / 2) +
      cos(lat1Rad) * cos(lat2Rad) * sin(dLon / 2) * sin(dLon / 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  double distance = earthRadius * c;

  return distance;
}

double degToRad(double deg) {
  return deg * (pi / 180);
}
