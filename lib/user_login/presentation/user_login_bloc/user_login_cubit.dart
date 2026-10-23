import 'package:example/user_login/data/user_login_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserLoginCubit extends Cubit<UserLoginState>{
  final UserLoginRepo userrepo;
  UserLoginCubit(this.userrepo): super(UserLoginInitial());

  Future<String> auth(String usr,String pwd)async{
    try{
      emit(UserLoginLoading());
       final data = await userrepo.auth(usr, pwd);
       emit(UserLoginSucces(data));
       return data;
       }catch(e){
      throw Exception('User Not found');
    }
    }
  }
abstract class UserLoginState{}
class UserLoginInitial extends UserLoginState{}
class UserLoginLoading extends UserLoginState{}
class UserLoginSucces extends UserLoginState{
  final String data;
  UserLoginSucces(this.data);
}
class UserLoginError extends UserLoginState{}
