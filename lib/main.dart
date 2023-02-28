import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:frontend/constants/routes.dart';
import 'package:frontend/screens/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trading Bot',
      debugShowCheckedModeBanner: false,
      scrollBehavior: const MaterialScrollBehavior().copyWith(dragDevices: {
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.touch,
        PointerDeviceKind.unknown,
      }),
      theme: ThemeData(
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  primary: Colors.black, padding: const EdgeInsets.all(0))),
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Montserrat',
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: MainPage(),
      routes: routes,
    );
  }
}
