import 'dart:convert';

import 'package:example/data/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class DataCubit extends Cubit<DataState>{
  DataCubit(): super(DataInitial());
  Future<void> dataUsers()async {
    try{
    final uri = Uri.parse('https://jsonplaceholder.typicode.com/users');
    final response = await http.get(uri);
    if(response.statusCode == 200){
    final List<dynamic> data = jsonDecode(response.body);
    emit(DataSuccess(data));
    }
  }catch(e){
    emit(DataError('failed to fetch the data'));
  }
  }
  }