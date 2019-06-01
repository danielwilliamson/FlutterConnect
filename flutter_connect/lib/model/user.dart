import 'package:flutter_connect/model/skill.dart';

class User {
  String id;
  String name;
  String email;
  String city;
  String linkedInID;
  String githubID;
  Skill skills;
  List<User> friends;
  String photoUrl;

  User(
    this.id,
    this.name,
    this.email,
    this.city,
    this.skills,
    this.linkedInID,
    this.githubID,
    this.friends,
    this.photoUrl,
  ) : assert(name != null);

  User.fromJson(Map<String, dynamic> json) {
    this.name = json["name"];
    this.email = json["email"];
    this.city = json["city"];
  }


}
