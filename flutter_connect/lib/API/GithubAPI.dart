import 'package:http/http.dart' as http;
import 'dart:convert';

class GithubAPI {

  static String baseUrl = "https://api.github.com";

  static Future<List<Repository>> getUserRepositories(String userName) async {
    final response = await http.get('$baseUrl/users/$userName/repos');
    List<dynamic> list = json.decode(response.body);
    List<Repository> repos = new List();
    list.forEach((item) => {
      repos.add(Repository(item))
    });
    return repos;
  }

}

class Repository {
  String name;


  Repository(Map<String, dynamic> json) {
    this.name = json["name"];
  }

}