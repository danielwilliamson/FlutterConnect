import 'package:flutter/material.dart';

import 'model/user.dart';

class UserSearch extends SearchDelegate<User> {
  final List<User> users;
//  final ValueSetter onUserSelected;

  UserSearch({
    this.users,
  });

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () => query = "")];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back), onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (users == null) {
      return Center(child: Text("USERS = NULL!"));
    } else if (users.isEmpty) {
      return Center(child: Text("No USERS! ${users.length}"));
    }
    final results = query.isEmpty
        ? users
        : users.where(
            (user) => user.name.toLowerCase().contains(query.toLowerCase()));
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: ListView(
        shrinkWrap: true,
        children: results
            .map<Widget>(
              (user) => Card(
            child: ListTile(
              contentPadding: EdgeInsets.fromLTRB(32.0, 8.0, 8.0, 8.0),
              title: Text(
                user.name,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text("${user.email}"),
              leading: Icon(Icons.person),
              onTap: () {
//                        onUserSelected(null);
                close(context, null);
              },
            ),
          ),
        )
            .toList(),
      ),
    );
  }
}
