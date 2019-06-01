import 'package:flutter/material.dart';
import 'package:flutter_connect/Screens/loginScreen.dart';
import 'package:flutter_connect/Screens/onboardingScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: OnboardingScreen(),
      routes: {'/login': (c) => LoginScreen()},
    );
  }
}
