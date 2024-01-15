// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_constructors_in_immutables, unnecessary_brace_in_string_interps, must_be_immutable

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String message;
  final String type;

  CustomDialog(
      {required this.title, required this.message, required this.type});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/${type}.png', width: 80),
            SizedBox(
              height: 15,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Text(
              message,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: HexColor("#8f8c99")),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                      Size(MediaQuery.of(context).size.width, 40))),
              onPressed: () {
                // Navigator.of(context).pop();
                Navigator.pop(context, true);
              },
              child: Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
