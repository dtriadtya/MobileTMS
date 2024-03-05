// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unnecessary_string_interpolations, unnecessary_brace_in_string_interps

// import 'package:flutter/material.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:intl/intl.dart';
// import 'package:tmshub/src/models/reimburse_model.dart';
// import 'package:tmshub/src/widgets/top_navigation.dart';
// import 'package:tmshub/src/utils/globals.dart' as globals;

// class ReimburseDetailScreen extends StatelessWidget {
//   const ReimburseDetailScreen({super.key, required this.reimburse});
//   final ReimburseModel reimburse;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           TopNavigation(title: "Pengembalian Dana"),
//           SizedBox(
//             height: 10,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 11),
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
//               width: MediaQuery.of(context).size.width,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Center(
//                     child: Text(
//                       "Detail",
//                       style: TextStyle(
//                         color: HexColor("#3D3D3D"),
//                         fontFamily: "Montserrat",
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Divider(
//                     color: HexColor("#A8AAAE"),
//                     height: 1,
//                     thickness: 2,
//                   ),
//                   SizedBox(height: 20),
//                   namaWidget(),
//                   SizedBox(height: 14),
//                   tanggalWidget(reimburse.tanggalReimburse),
//                   SizedBox(height: 14),
//                   valueOfReimburseWidget(),
//                   SizedBox(height: 14),
//                   statusWidget(),
//                   SizedBox(height: 14),
//                   adminNameWidget(),
//                   SizedBox(height: 14),
//                   keteranganWidget()
//                 ],
//               ),
//               decoration: BoxDecoration(
//                   color: HexColor("#f1f7fb"),
//                   borderRadius: BorderRadius.circular(15)),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget tanggalWidget(DateTime dateTime) {
//     String formattedDate = DateFormat('d MMMM y').format(dateTime);
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Icon(
//           Icons.calendar_month,
//           size: 24,
//           color: HexColor("#A8AAAE"),
//         ),
//         SizedBox(
//           width: 10,
//         ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Tanggal",
//               style: TextStyle(
//                 color: HexColor("#3D3D3D"),
//                 fontFamily: "Montserrat",
//                 fontSize: 14,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Text(
//               "${formattedDate}",
//               style: TextStyle(
//                 color: HexColor("#6E6E6E"),
//                 fontFamily: "Montserrat",
//                 fontSize: 12,
//                 fontWeight: FontWeight.w500,
//               ),
//             )
//           ],
//         )
//       ],
//     );
//   }

//   Widget namaWidget() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Icon(
//           Icons.person,
//           size: 24,
//           color: HexColor("#A8AAAE"),
//         ),
//         SizedBox(
//           width: 10,
//         ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Nama",
//               style: TextStyle(
//                 color: HexColor("#3D3D3D"),
//                 fontFamily: "Montserrat",
//                 fontSize: 14,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Text(
//               globals.userLogin!.namaUser!,
//               style: TextStyle(
//                 color: HexColor("#6E6E6E"),
//                 fontFamily: "Montserrat",
//                 fontSize: 12,
//                 fontWeight: FontWeight.w500,
//               ),
//             )
//           ],
//         )
//       ],
//     );
//   }

//   Widget valueOfReimburseWidget() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Icon(
//           Icons.move_to_inbox,
//           size: 24,
//           color: HexColor("#A8AAAE"),
//         ),
//         SizedBox(
//           width: 10,
//         ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Reimburse",
//               style: TextStyle(
//                 color: HexColor("#3D3D3D"),
//                 fontFamily: "Montserrat",
//                 fontSize: 14,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Text(
//               "Rp. 200.00,00",
//               style: TextStyle(
//                 color: HexColor("#6E6E6E"),
//                 fontFamily: "Montserrat",
//                 fontSize: 12,
//                 fontWeight: FontWeight.w500,
//               ),
//             )
//           ],
//         )
//       ],
//     );
//   }

//   Widget statusWidget() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Icon(
//           Icons.assignment,
//           size: 24,
//           color: HexColor("#A8AAAE"),
//         ),
//         SizedBox(
//           width: 10,
//         ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Status",
//               style: TextStyle(
//                 color: HexColor("#3D3D3D"),
//                 fontFamily: "Montserrat",
//                 fontSize: 14,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Text(
//               reimburse.statusReimburse,
//               style: TextStyle(
//                 color: HexColor("#38D32A"),
//                 fontFamily: "Montserrat",
//                 fontSize: 12,
//                 fontWeight: FontWeight.w500,
//               ),
//             )
//           ],
//         )
//       ],
//     );
//   }

//   Widget adminNameWidget() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Icon(
//           Icons.approval,
//           size: 24,
//           color: HexColor("#A8AAAE"),
//         ),
//         SizedBox(
//           width: 10,
//         ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Disetujui Oleh",
//               style: TextStyle(
//                 color: HexColor("#3D3D3D"),
//                 fontFamily: "Montserrat",
//                 fontSize: 14,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Text(
//               reimburse.namaAdmin!,
//               style: TextStyle(
//                 color: HexColor("#6E6E6E"),
//                 fontFamily: "Montserrat",
//                 fontSize: 12,
//                 fontWeight: FontWeight.w500,
//               ),
//             )
//           ],
//         )
//       ],
//     );
//   }
// Widget keteranganWidget(){
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Icon(
//           Icons.format_align_justify,
//           size: 24,
//           color: HexColor("#A8AAAE"),
//         ),
//         SizedBox(
//           width: 10,
//         ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Keterangan",
//               style: TextStyle(
//                 color: HexColor("#3D3D3D"),
//                 fontFamily: "Montserrat",
//                 fontSize: 14,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//             SizedBox(
//               height: 5,
//             ),
//             Text(
//               reimburse.keterangan,
//               style: TextStyle(
//                 color: HexColor("#6E6E6E"),
//                 fontFamily: "Montserrat",
//                 fontSize: 12,
//                 fontWeight: FontWeight.w500,
//               ),
//             )
//           ],
//         )
//       ],
//     );
//   }

// }
