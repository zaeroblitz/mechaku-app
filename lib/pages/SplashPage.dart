import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mechaku/theme.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushNamedAndRemoveUntil(
            context, 'sign-in', (route) => false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Image.asset(
          'assets/logo_full.png',
          width: 350,
          height: 350,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
