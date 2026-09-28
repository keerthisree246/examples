import 'dart:convert';
import 'package:example/user_bloc/user_event.dart';
import 'package:example/user_bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class UserBloc extends Bloc<UserDataEvent, UserDataState>{
  UserBloc(): super(UserDataInitial()){
    on<GetUserData>((event, emit) async{
      emit(UserDataLoading());
      try{
        final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
        if(response.statusCode == 200){
          final List<dynamic> data = jsonDecode(response.body);
          emit(UserDataSuccess(data));
        }
      }catch(e){
        emit(UserDataError(e.toString()));
      }
    });
  }
}