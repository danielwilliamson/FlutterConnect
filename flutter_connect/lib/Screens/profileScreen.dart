import 'package:flutter/material.dart';
import 'package:flutter_connect/API/GithubAPI.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  int _numberOfRepos = 0;

  @override
  void initState() {
    super.initState();

    GithubAPI.getUserRepositories("maherksantina").then((repositories) => {
      setState(() {
        _numberOfRepos = repositories.length;
    })
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Text('${_numberOfRepos}')
      ]),
      appBar: AppBar(title: Text('LoginScreen')),
    );
  }

}
