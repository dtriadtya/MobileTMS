import 'package:flutter/services.dart';

Future<String> loadOfficeData() async{
  return await rootBundle.loadString('assets/json/office.json');
}