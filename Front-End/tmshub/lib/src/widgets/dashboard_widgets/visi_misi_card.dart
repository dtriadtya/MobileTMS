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
                  padding:
                      EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
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
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer vel nulla vel est venenatis vehicula ac sit amet justo. Sed id libero id neque viverra scelerisque. Sed gravida massa vitae augue mattis auctor. Suspendisse potenti. Sed non metus a nibh bibendum consectetur. Sed auctor odio nec mauris feugiat bibendum. Nullam vehicula in tortor eget varius. Suspendisse tristique tortor at tortor efficitur varius. Praesent ac neque eu odio venenatis tincidunt. Morbi consequat metus at luctus vehicula. Nullam vel laoreet massa, id suscipit massa. In tincidunt enim vel metus ultricies, non posuere quam facilisis. Donec posuere cursus sem nec fermentum. Nunc sit amet arcu id orci fringilla volutpat. Quisque quis nunc tristique, tincidunt turpis in, vestibulum justo. Vivamus"),
                      ),
                      SizedBox(height: 13),
                      Container(
                        padding: EdgeInsets.all(5),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(color: HexColor("#ABB3B4")),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer vel nulla vel est venenatis vehicula ac sit amet justo. Sed id libero id neque viverra scelerisque. Sed gravida massa vitae augue mattis auctor. Suspendisse potenti. Sed non metus a nibh bibendum consectetur. Sed auctor odio nec mauris feugiat bibendum. Nullam vehicula in tortor eget varius. Suspendisse tristique tortor at tortor efficitur varius. Praesent ac neque eu odio venenatis tincidunt. Morbi consequat metus at luctus vehicula. Nullam vel laoreet massa, id suscipit massa. In tincidunt enim vel metus ultricies, non posuere quam facilisis. Donec posuere cursus sem nec fermentum. Nunc sit amet arcu id orci fringilla volutpat. Quisque quis nunc tristique, tincidunt turpis in, vestibulum justo. Vivamus"),
                      )
                    ],
                  ),
                )),
          );
  }
}