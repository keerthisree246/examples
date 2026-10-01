import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class LoginCubit extends Cubit<LoginState>{
  LoginCubit(): super(LoginInitial());


  Future<void> loginUser(String email, String password) async {
    emit(LoginLoading());

    try {
      final url = Uri.parse(
        'https://nuevosoluat.easycloud.co.in/api/method/nuevosol.gate_api.getUsers',
      );

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'usr': email,
          'pwd': password,
        }),
      );

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final message = data['message'];

        if (message == null) {
          emit(LoginError('Invalid API response'));
          return;
        }

        emit(LoginSuccess(message.toString()));
      } else {
        final error = data['message'] ??
            data['error'] ??
            'Login failed';

        emit(LoginError(error.toString()));
      }
    } catch (e) {
      emit(LoginError('Something went wrong: $e'));
    }
  }

}



abstract class LoginState {}
class LoginInitial extends LoginState {}
class LoginLoading extends LoginState{}
class LoginSuccess extends LoginState{
  final String token;
  LoginSuccess(this.token);
}
class LoginError extends LoginState{
  final String error;
  LoginError(this.error);
}
