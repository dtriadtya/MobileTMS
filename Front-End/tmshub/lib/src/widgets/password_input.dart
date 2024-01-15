// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class PasswordInput extends StatefulWidget {
  final bool obscureText;
  final String tittle;
  final TextEditingController controller;

  const PasswordInput(
      {Key? key,
      required this.obscureText,
      required this.tittle,
      required this.controller})
      : super(key: key);

  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              widget.tittle,
              style: const TextStyle(
                color: Color(0xFF4D4848),
                fontSize: 12,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                height: 0.05,
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: widget.controller,
              obscureText: !_obscureText,
              style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: HexColor("#565656"),
              ),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(_obscureText
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8), gapPadding: 16),
                contentPadding:
                    const EdgeInsetsDirectional.symmetric(horizontal: 20),
              ),
            ),
          ],
        ));
  }
}
