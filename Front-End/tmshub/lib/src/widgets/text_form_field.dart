import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomFormField extends StatefulWidget {
  final bool obscureText;
  final IconData? suffixIcon;
  final String? initialValue;
  final String title;
  final bool enable;
  final TextEditingController? controller;
  final String? hint;
  final TextInputType? keyboardType; // Tambahkan required keyboard type

  const CustomFormField({
    Key? key,
    this.suffixIcon,
    this.initialValue,
    required this.obscureText,
    required this.title,
    required this.enable,
    this.hint,
    this.controller,
    this.keyboardType, // Tambahkan required keyboard type
  }) : super(key: key);

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.title,
                style: TextStyle(
                  color: HexColor("#0D0E0E"),
                  fontSize: 14,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextFormField(
              controller: widget.controller,
              initialValue: widget.initialValue,
              obscureText: _obscureText,
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14,
                color: Color(0xFF4D4848),
              ),
              keyboardType:
                  widget.keyboardType, // Tambahkan required keyboard type
              decoration: InputDecoration(
                enabled: widget.enable,
                hintText: widget.hint,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                filled: true,
                fillColor:
                    !widget.enable ? HexColor("#80A8AAAE") : Color(0xFFF5F5F5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xff26ED5D),
                  ),
                ),
                suffixIcon: widget.obscureText
                    ? IconButton(
                        icon: Icon(_obscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      )
                    : (widget.suffixIcon != null
                        ? Icon(widget.suffixIcon)
                        : null),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
