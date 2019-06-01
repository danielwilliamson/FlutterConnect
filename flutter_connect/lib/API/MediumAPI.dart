import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class MediumAPI {

  static String baseUrl = "https://medium.com";

  static Future<List<Post>> getUserPosts(String userName) async {
    String url = '$baseUrl/$userName/latest?format=json';
    final response = await http.get(url);
    String a = String.fromCharCodes(response.bodyBytes);

    (json.decode(a));
    List<Post> posts = new List();
//    List<dynamic> list = body["payload"]["references"]["Post"];
//    List<Post> posts = new List();
//    list.forEach((item) => {
//        posts.add(Post(item))
//  });
    return posts;
  }

}

class Post {
  String title;


  Post(Map<String, dynamic> json) {
    this.title = json["title"];
  }

}