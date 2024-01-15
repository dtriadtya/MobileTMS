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
            const SizedBox(
              height: 15,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              message,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: HexColor("#8f8c99")),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                      Size(MediaQuery.of(context).size.width, 40))),
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
