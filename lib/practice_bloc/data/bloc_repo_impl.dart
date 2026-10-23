import 'dart:convert';

import 'package:example/practice_bloc/data/bloc_repo.dart';
import 'package:http/http.dart' as http;

class BlocRepoImpl extends BlocRepo{
  BlocRepoImpl();
  @override
  Future<List<dynamic>> getPost() async{
    final uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final response = await http.get(uri);
    if(response.statusCode == 200){
      final List<dynamic> data = jsonDecode(response.body);
      return data;
      }
    throw Exception('failed to fetch the data');
  }
}