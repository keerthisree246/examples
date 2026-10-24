import 'dart:convert';

import 'package:example/repo_based/data/practice_repo.dart';
import 'package:http/http.dart' as http;

class PracticeRepoImpl  extends PracticeRepo{
  PracticeRepoImpl();
  @override
  Future<List<dynamic>> getData()async{
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
     final response = await http.get(url);

     if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      return data;
     }else{
      throw Exception('failed to fetch the data');
     }
  }
}