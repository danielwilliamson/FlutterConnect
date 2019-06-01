import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'model/skill.dart';

class ProfileList extends StatefulWidget {
  final List<DocumentSnapshot> userSnapshots;

  const ProfileList({Key key, this.userSnapshots}) : super(key: key);

  @override
  _ProfileListState createState() => _ProfileListState();
}

class _ProfileListState extends State<ProfileList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        DocumentSnapshot user = widget.userSnapshots[index];

        return StreamBuilder<QuerySnapshot>(
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return new Text('Loading...');
              default:
                if (snapshot.hasData) {
                  List<DocumentSnapshot> skills = snapshot.data.documents;
                  DocumentSnapshot skillSnap = skills[0];

                  Skill userSkills = Skill.fromJson(skillSnap.data);
                  return ListTile(
                    title: Text(user["name"]),
                    subtitle: Text(
                        "Email: ${user["email"]}   City: ${user["city"]}  "
                            "Data Skill = ${userSkills.data}    "
                            "${userSkills.stateManagement}   "
                            "${userSkills.basicUIKnowledge} "),
                  );
                } else {
                  return Text("no skill data");
                }
            }
          },
          stream: user.reference.collection('skills').snapshots(),
        );
      },
      itemCount: widget.userSnapshots.length,
    );
  }
}
