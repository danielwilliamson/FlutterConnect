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
      User(
          '9',
          'David',
          'david@gmail.com',
          'Sydney',
          [Skill('Basic UI', 5), Skill('Data', 4), Skill('Advanced UI', 4)],
          '222',
          '223',
          null,
          null),
      User(
          '7',
          'Andrew',
          'andrew@gmail.com',
          'Sydney',
          [
            Skill('Advanced Topics', 5),
          ],
          '222',
          '223',
          null,
          null),
      User(
          '7',
          'Max',
          'andrew@gmail.com',
          'Sydney',
          [
            Skill('Advanced Topics', 4),
          ],
          '222',
          '223',
          null,
          null),
      User(
          '7',
          'Sarah',
          'andrew@gmail.com',
          'Belgium',
          [
            Skill('Advanced Topics', 4),
          ],
          '222',
          '223',
          null,
          null)
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
              print('TextChaned');
              setState(() {
                searchedData = dummyData().where((user) {
                  user.name.contains(newText);
                });

                print(searchedData);
              });
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(), hasFloatingPlaceholder: true)),
        ListView.builder(
            shrinkWrap: true,
            itemCount: searchedData.length,
            itemBuilder: (c, index) {
              final user = searchedData[index];

              return Card(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        height: 10,
                      ),
                      Text(
                        user.city,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Container(
                        height: 10,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: user.skills.map((s) {
                            return Text(s.name + '  -  ' + '${s.level}');
                          }).toList()),
                    ]),
              ));
            })
      ]),
    );
  }
}
