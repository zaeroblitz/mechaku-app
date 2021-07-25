import 'package:flutter/material.dart';
import 'package:mechaku/pages/SplashPage.dart';
import 'package:mechaku/pages/login/SignInPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => SplashPage(),
        'sign-in': (context) => SignInPage(),
      },
    );
  }
}
