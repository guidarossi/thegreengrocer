import 'package:flutter/material.dart';
import 'package:thegreengrocer/src/auth/pages/sign_in_screen.dart';
import 'package:thegreengrocer/src/auth/pages/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Greengrocer',
      theme: ThemeData(
   primarySwatch: Colors.green,
       scaffoldBackgroundColor: Colors.white.withAlpha(190),
      ),
      home: const SplashScreen(),
    );
  }
}

