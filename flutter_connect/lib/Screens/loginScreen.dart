import 'package:flutter/material.dart';
import 'package:flutter_connect/API/firebase.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        FlatButton(child: Text('Login'), onPressed: () => _loginUser())
      ]),
      appBar: AppBar(title: Text('LoginScreen')),
    );
  }

  _loginUser() async {
    await FirebaseAPI().handleSignIn();
  }
}
