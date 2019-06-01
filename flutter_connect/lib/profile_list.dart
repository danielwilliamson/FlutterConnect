import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfileList extends StatefulWidget {
  @override
  _ProfileListState createState() => _ProfileListState();
}

class _ProfileListState extends State<ProfileList> {


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('users').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Text('Loading...');
          default:
            List<DocumentSnapshot> users = snapshot.data.documents;
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot user = users[index];

                return StreamBuilder<QuerySnapshot>(
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return new Text('Loading...');
                      default:
                        if (snapshot.hasData) {
                          List<DocumentSnapshot> skills =
                              snapshot.data.documents;
                          DocumentSnapshot skill = skills[0];
                          return ListTile(
                            title: Text(user["name"]),
                            subtitle: Text(
                                "Email: ${user["email"]}   City: ${user["city"]}  Data Skill = ${skill["Data"]}"),
                          );
                        } else {
                          return Text("no skill data");
                        }
                    }
                  },
                  stream: user.reference.collection('skills').snapshots(),
                );
              },
              itemCount: users.length,
            );
        }
      },
    );
  }
}
