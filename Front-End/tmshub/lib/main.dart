// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tmshub/src/screens/splash_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

 final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
    debug: true // Setel ke false di produksi
  );
  initializeDateFormatting('id_ID', null);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    ));
  }
}
