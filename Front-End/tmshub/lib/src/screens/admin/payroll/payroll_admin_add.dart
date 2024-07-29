// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tmshub/src/screens/admin/payroll/payroll_admin_screen.dart';
import 'package:tmshub/src/services/penggajian_services.dart';
import 'package:tmshub/src/widgets/modal/custom_dialog.dart';
import 'package:tmshub/src/widgets/text_form_field.dart';
import 'package:tmshub/src/widgets/top_navigation.dart';
import 'package:tmshub/src/utils/globals.dart' as globals;
import 'package:file_picker/file_picker.dart';

class PenggajianAddScreen extends StatefulWidget {
  final String userId;
  const PenggajianAddScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<PenggajianAddScreen> createState() => _PenggajianAddScreenState();
}

class _PenggajianAddScreenState extends State<PenggajianAddScreen> {
  final tanggalController = TextEditingController();
  final gajiPokokController = TextEditingController();
  final transportasiController = TextEditingController();
  final bonusController = TextEditingController();
  final statusController = TextEditingController();
  final applyByController = TextEditingController();
  final keteranganController = TextEditingController();
  String? attachmentPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            TopNavigation(title: 'Form Penggajian Admin'),
            inputDateColumn(
                title: "Tanggal",
                editController: tanggalController,
                inputPlaceholder: "Tanggal"),
            inputAmountColumn(
                title: "Gaji Pokok",
                editController: gajiPokokController,
                inputPlaceholder: "Amount"),
            inputAmountColumn(
                title: "Transportasi",
                editController: transportasiController,
                inputPlaceholder: "Amount"),
            inputAmountColumn(
                title: "Bonus",
                editController: bonusController,
                inputPlaceholder: "Amount"),
            CustomFormField(
              obscureText: false,
              title: 'Status',
              enable: true,
              controller: statusController,
            ),
            CustomFormField(
              obscureText: false,
              title: 'Disetujui Oleh',
              enable: false,
              initialValue: "${globals.userLogin!.namaUser}".toUpperCase(),
            ),
            CustomFormField(
              obscureText: false,
              title: 'Keterangan',
              enable: true,
              controller: keteranganController,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 6),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    print("${tanggalController.text}");
                    print("click!!!!");
                    if (checkInput()) {
                      Map<String, dynamic> request = {
                        'id_user': widget.userId,
                        'tanggal': tanggalController.text,
                        'gaji_pokok':
                            gajiPokokController.text.replaceAll(',', ''),
                        'transportasi':
                            transportasiController.text.replaceAll(',', ''),
                        'bonus': bonusController.text.replaceAll(',', ''),
                        'status_gaji': statusController.text,
                        'id_admin': globals.userLogin?.idUser,
                        'keterangan': keteranganController.text,
                      };

                      addPenggajianAPI(request).then((response) {
                        print("${request}");
                        context.loaderOverlay.hide();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomDialog(
                              title: "Sukses Menginput Gaji",
                              message: "Berhasil Menginput Gaji",
                              type: "success",
                            );
                          },
                        ).then((value) {
                          // Pindah ke halaman tertentu setelah dialog ditutup
                          Navigator.pop(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PayrollScreenAdmin()),
                          );
                        });
                      }).catchError((error) {
                        context.loaderOverlay.hide();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomDialog(
                              title: "Gagal Menginput Gaji",
                              message: error.toString(),
                              type: "failed",
                            );
                          },
                        );
                      });
                    }
                  },
                  child: Text("Submit Gaji Karyawan"),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }

  Widget inputAmountColumn(
      {required String title,
      required TextEditingController editController,
      required String inputPlaceholder}) {
    // Define an input formatter to allow only numeric input
    final currencyFormatter = FilteringTextInputFormatter.digitsOnly;

    // Define a function to format the input with commas every 3 digits
    String formatAmount(String value) {
      final numberFormat = NumberFormat.decimalPattern();
      final parsedValue = int.tryParse(value.replaceAll(',', '')) ?? 0;
      return numberFormat.format(parsedValue);
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "$title",
              style: TextStyle(
                color: HexColor("#565656"),
                fontSize: 14,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: TextField(
            controller: editController,
            decoration: InputDecoration(
              hintText: '$inputPlaceholder',
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 16,
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: HexColor("#C4C4C4"),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Color(0xff26ED5D),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: HexColor("#C4C4C4"),
                ),
              ),
              prefixText: "RP. ",
            ),
            inputFormatters: [currencyFormatter],
            onChanged: (value) {
              // Update the text with formatted input
              final formattedValue = formatAmount(value);
              if (value != formattedValue) {
                editController.value = editController.value.copyWith(
                  text: formattedValue,
                  selection:
                      TextSelection.collapsed(offset: formattedValue.length),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget inputDateColumn({
    required String title,
    required TextEditingController editController,
    required String inputPlaceholder,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "$title",
              style: TextStyle(
                color: Color(0xFF565656),
                fontSize: 14,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: TextField(
            controller: editController,
            decoration: InputDecoration(
              hintText: '$inputPlaceholder',
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 16,
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: HexColor("#C4C4C4"),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Color(0xff26ED5D),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: HexColor("#C4C4C4"),
                ),
              ),
            ),
            readOnly: true,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );

              if (pickedDate != null) {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (pickedTime != null) {
                  final dateTime = DateTime(
                    pickedDate.year,
                    pickedDate.month,
                    pickedDate.day,
                    pickedTime.hour,
                    pickedTime.minute,
                  );

                  String formattedDate =
                      DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
                  print(formattedDate);

                  setState(() {
                    editController.text = formattedDate;
                  });
                } else {
                  print("Time is not selected");
                }
              } else {
                print("Date is not selected");
              }
            },
          ),
        ),
      ],
    );
  }

  Future<void> _pickAttachment() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        attachmentPath = result.files.single.path;
      });
    } else {
      // User canceled the picker
      setState(() {
        attachmentPath = null;
      });
    }
  }

  bool checkInput() {
    bool isValid = true;
    if (tanggalController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Kolom Tanggal tidak boleh kosong!")));
      isValid = false;
    } else if (gajiPokokController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Kolom Gaji Pokok tidak boleh kosong!")));
      isValid = false;
    } else if (transportasiController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Kolom Transportasi tidak boleh kosong!")));
      isValid = false;
    } else if (bonusController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Kolom Bonus tidak boleh kosong!")));
      isValid = false;
    } else if (statusController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Kolom Status tidak boleh kosong!")));
      isValid = false;
    } else if (keteranganController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Kolom Keterangan tidak boleh kosong!")));
      isValid = false;
    }
    return isValid;
  }
}
