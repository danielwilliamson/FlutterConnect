import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_connect/profile_list.dart';

import 'model/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
//    getFirestoreInfo();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

Future getFirestoreInfo() async {
  Query query = Firestore.instance.collection("users");

  QuerySnapshot querySnapshot = await query.getDocuments();
  print("query gotten  ${querySnapshot.documents.length}");

  querySnapshot.documents.forEach((doc) {
    print("Doc");
    Map<String, dynamic> data = doc.data;
    print("name = ${data["name"]}");
  });
  print("end");
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<User> users;

  @override
  void initState() {
    users = List<User>();
    // TODO: implement initState
    super.initState();
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () => showSearch(
                    context: context,
                    delegate: UserSearch(
                      users: users,
//                      onUserSelected:,
                    ),
                  ),
            ),
          ]),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('users').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return new Text('Loading...');
                default:
                  if(snapshot.hasData) {
                    List<User> newListOfUsers = List<User>();
                    List<DocumentSnapshot> userSnapshots = snapshot.data
                        .documents;
                    userSnapshots.forEach((DocumentSnapshot documentSnapshot) {

                      User user = User.fromJson(documentSnapshot.data);
                      if(user != null) {
                        newListOfUsers.add(user);
                      }
                    });
                    users = newListOfUsers;
                    return ProfileList(userSnapshots: userSnapshots);
                  } else {
                    return Container();
                  }
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), //
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class UserSearch extends SearchDelegate<User> {
  final List<User> users;
//  final ValueSetter onUserSelected;

  UserSearch({
    this.users,
//    this.onUserSelected,
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
