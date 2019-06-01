import 'package:flutter_connect/model/skill.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String city;
  final String linkedInID;
  final String githubID;
  final List<Skill> skills;
  final List<User> friends;
  final String photoUrl;

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
  ) : assert(id != null, name != null);
}
