import 'package:flutter/material.dart';
import 'package:mechaku/pages/MainPage.dart';
import 'package:mechaku/pages/SplashPage.dart';
import 'package:mechaku/pages/login/SignInPage.dart';
import 'package:mechaku/pages/login/SignUpPage.dart';
import 'package:mechaku/providers/PageProvider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PageProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => SplashPage(),
          'sign-in': (context) => SignInPage(),
          'sign-up': (context) => SignUpPage(),
          'main-page': (context) => MainPage(),
        },
      ),
    );
  }
}
