import 'package:flutter/material.dart';
import 'package:flutter_front/view/splash.view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MAPPOSTING',
      home: const SplashView(),
    );
  }
}