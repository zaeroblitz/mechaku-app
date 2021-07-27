import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mechaku/ui/pages/pages.dart';
import 'package:mechaku/providers/providers.dart';

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
