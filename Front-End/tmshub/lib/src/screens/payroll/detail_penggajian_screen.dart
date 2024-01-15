// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, sort_child_properties_last, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:tmshub/src/models/penggajian_model.dart';
import 'package:tmshub/src/widgets/top_navigation.dart';

class DetailPenggajianScreen extends StatelessWidget {
  const DetailPenggajianScreen({super.key, required this.penggajianModel});
  final PenggajianModel penggajianModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopNavigation(title: "Penggajian"),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Detail",
                      style: TextStyle(
                        color: HexColor("#3D3D3D"),
                        fontFamily: "Montserrat",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Divider(
                    color: HexColor("#A8AAAE"),
                    height: 1,
                    thickness: 2,
                  ),
                  SizedBox(height: 11),
                  tanggalWidget(),
                  SizedBox(height: 14),
                  gajiPokokWidget(),
                  SizedBox(height: 14),
                  statusWidget(),
                  SizedBox(height: 14),
                  disetujuiWidget(),
                  SizedBox(height: 14),
                  keteranganWidget()

                ],
              ),
              decoration: BoxDecoration(
                  color: HexColor("#f1f7fb"),
                  borderRadius: BorderRadius.circular(15)),
            ),
          )
        ],
      ),
    );
  }

  Widget tanggalWidget() {
    String formattedDate = DateFormat('d MMMM y').format(penggajianModel.tanggal);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.calendar_month,
          size: 24,
          color: HexColor("#A8AAAE"),
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tanggal",
              style: TextStyle(
                color: HexColor("#3D3D3D"),
                fontFamily: "Montserrat",
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              formattedDate,
              style: TextStyle(
                color: HexColor("#6E6E6E"),
                fontFamily: "Montserrat",
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        )
      ],
    );
  }

  Widget gajiPokokWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.payments,
          size: 24,
          color: HexColor("#A8AAAE"),
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Gaji Pokok",
              style: TextStyle(
                color: HexColor("#3D3D3D"),
                fontFamily: "Montserrat",
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Rp. ${penggajianModel.gajiPokok}",
              style: TextStyle(
                color: HexColor("#6E6E6E"),
                fontFamily: "Montserrat",
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 14,
            ),
            Text(
              "Transportasi",
              style: TextStyle(
                color: HexColor("#3D3D3D"),
                fontFamily: "Montserrat",
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Rp. ${penggajianModel.transportasi}",
              style: TextStyle(
                color: HexColor("#6E6E6E"),
                fontFamily: "Montserrat",
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            //========================
            SizedBox(
              height: 14,
            ),
            Text(
              "Bonus",
              style: TextStyle(
                color: HexColor("#3D3D3D"),
                fontFamily: "Montserrat",
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Rp. ${penggajianModel.bonus}",
              style: TextStyle(
                color: HexColor("#6E6E6E"),
                fontFamily: "Montserrat",
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget statusWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.assignment,
          size: 24,
          color: HexColor("#A8AAAE"),
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Status",
              style: TextStyle(
                color: HexColor("#3D3D3D"),
                fontFamily: "Montserrat",
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              penggajianModel.statusGaji,
              style: TextStyle(
                color: HexColor("#38D32A"),
                fontFamily: "Montserrat",
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        )
      ],
    );
  }

  Widget disetujuiWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.person,
          size: 24,
          color: HexColor("#A8AAAE"),
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Disetujui Oleh",
              style: TextStyle(
                color: HexColor("#3D3D3D"),
                fontFamily: "Montserrat",
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              penggajianModel.namaAdmin,
              style: TextStyle(
                color: HexColor("#6E6E6E"),
                fontFamily: "Montserrat",
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        )
      ],
    );
  }

  Widget keteranganWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.format_align_justify,
          size: 24,
          color: HexColor("#A8AAAE"),
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Keterangan",
              style: TextStyle(
                color: HexColor("#3D3D3D"),
                fontFamily: "Montserrat",
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              penggajianModel.keterangan,
              style: TextStyle(
                color: HexColor("#6E6E6E"),
                fontFamily: "Montserrat",
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        )
      ],
    );
  }

}
