import 'dart:convert';

import 'package:example/repo_based/data/practice_repo.dart';
import 'package:http/http.dart' as http;

class PracticeRepoImpl extends PracticeRepo{
  PracticeRepoImpl();

  @override
  Future<List<dynamic>> getData() async {
    final uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final response = await http.get(uri);
    if(response.statusCode == 200){
      final List<dynamic> data = jsonDecode(response.body);
      return data ;
    }
    throw Exception('Failed to load data: ${response.body}');
  }
}