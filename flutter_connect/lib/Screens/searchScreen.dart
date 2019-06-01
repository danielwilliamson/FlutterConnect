import 'package:flutter/material.dart';
import 'package:flutter_connect/model/skill.dart';
import 'package:flutter_connect/model/user.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<User> dummyData() {
    return [
      User('9', 'David', 'david@gmail.com', 'Sydney', [Skill('Advanced UI', 5)],
          '222', '223', null, null),
      User('7', 'Andrew', 'andrew@gmail.com', 'Sydney',
          [Skill('Advanced Topics', 2)], '222', '223', null, null)
    ];
  }

  List<User> searchedData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchedData = dummyData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        TextField(
            onChanged: (newText) {
              setState(() {
                searchedData = dummyData().where((user) {
                  user.name.contains(newText);
                });
              });
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(), hasFloatingPlaceholder: true)),
        ListView.builder(
            itemCount: searchedData.length,
            itemBuilder: (c, index) {
              final user = searchedData[index];

              return Row(children: [Text(user.name)]);
            })
      ]),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return null;
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return null;
  }
}
