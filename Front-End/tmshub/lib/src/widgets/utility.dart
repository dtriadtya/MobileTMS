// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

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
          'Tidak Ada Data',
          style: GoogleFonts.kavoon(
            textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
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

showSuccessDialog({required context, required onPress}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: HexColor("#FFF8F3F3"),
          shadowColor: HexColor("#7AE5F1F8"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            constraints: BoxConstraints(maxHeight: 300),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 36),
                  Icon(
                    Icons.check_circle,
                    size: 100,
                    color: HexColor("#27C66E"),
                  ),
                  SizedBox(height: 22),
                  Text(
                    "SUKSES",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: HexColor("#3D3D3D"),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Permintaan Anda telah dikirim \nberhasil",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: HexColor("#994B465C"),
                    ),
                  ),
                  SizedBox(height: 40),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: onPress,
                        child: Text(
                          "OK",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: HexColor("#FFFFFF"),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
        );
      });
}

Widget loadingWidget(BuildContext context) {
  return Expanded(
      child: Dialog(
    backgroundColor: Colors.transparent,
    elevation: 0,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          CircularProgressIndicator(),
          SizedBox(width: 16),
          Text("Loading..."),
        ],
      ),
    ),
  ));
}
