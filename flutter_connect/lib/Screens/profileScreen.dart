import 'package:flutter/material.dart';
import 'package:flutter_connect/API/GithubAPI.dart';
import 'package:flutter_connect/API/MediumAPI.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  int _numberOfRepos = 0;
  int _numberOfPosts = 0;

  @override
  void initState() {
    super.initState();

    handleGithubRepos();
    handleMediumPosts();
  }

  void handleGithubRepos() {
    GithubAPI.getUserRepositories("maherksantina").then((repositories) => {
        setState(() {
      _numberOfRepos = repositories.length;
    })
  });
  }

  void handleMediumPosts() {
    MediumAPI.getUserPosts("@maher.santina90").then((posts) => {
//        setState(()
//    {
//      _numberOfPosts = posts.length;
//    }
//    )
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Text('Number of Github Repos: $_numberOfRepos'),
        Text('Number of Medium Posts: $_numberOfPosts')
      ]),
      appBar: AppBar(title: Text('LoginScreen')),
    );
  }

}
