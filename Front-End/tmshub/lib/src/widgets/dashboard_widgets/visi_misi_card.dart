// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class VisiMisiCard extends StatelessWidget {
  const VisiMisiCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 7, right: 7, top: 20),
      child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: HexColor('#E5F1F8'),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Visi & Misi".toUpperCase(),
                  style: TextStyle(
                      color: HexColor("#5d5d5e"),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Montserrat"),
                ),
                SizedBox(height: 13),
                Container(
                  padding: EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(color: HexColor("#ABB3B4")),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                      "Menjadi penyedia solusi logistik terkemuka yang menghubungkan dunia dengan efisiensi, keandalan, dan inovasi."),
                ),
                SizedBox(height: 13),
                Container(
                    padding: EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border.all(color: HexColor("#ABB3B4")),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Text(
                            "1. Memberikan layanan logistik yang terintegrasi termasuk transportasi, pergudangan, distribusi untuk memenuhi kebutuhan pelanggan secara efesien dan   tepat waktu."),
                        Text(
                            "2. Menyediakan solusi logistik yang berkelanjutan dengan memprioritaskan praktik ramah lingkungan dan penggunaan sumber daya yang bijaksana."),
                        Text(
                            "3. Membangun kemitraan yang saling menguntungkan dengan pelanggan, pemasok, dan mitra bisnis lainnya untuk mencapai pertumbuhan bersama."),
                      ],
                    ))
              ],
            ),
          )),
    );
  }
}
