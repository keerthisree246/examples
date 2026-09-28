import 'dart:convert';
import 'package:example/user/data/user_repo.dart';
import 'package:example/user/model/user_model.dart';
import 'package:http/http.dart' as http;

class UserRepoImpl extends UserRepo {
  UserRepoImpl();

  @override
  Future<List<User>> getUser() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/users');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final  List<dynamic> data = jsonDecode(response.body) ;
      return data
          .map((item) => User.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to fetch the data');
    }
  }
}