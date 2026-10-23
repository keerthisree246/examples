import 'dart:convert';
import 'package:example/user_cubit/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class UserCubit extends Cubit<UserState>{
  UserCubit() : super(UserInitial());
  Future<void> fetchUsers() async{
    emit(UserLoading());
    try{
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
      if(response.statusCode == 200){
        final List<dynamic> data = jsonDecode(response.body);
        emit(UserSuccess(data));
      }

    }catch(e){
      emit(UserError(e.toString()));
    }
  }
}