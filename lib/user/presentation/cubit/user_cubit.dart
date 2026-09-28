import 'package:example/user/data/user_repo.dart';
import 'package:example/user/model/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubitData extends Cubit<UserStateData> {
  final UserRepo userRepo;

  UserCubitData(this.userRepo) : super(UserInitial());

  Future<void> getUser() async {
    emit(UserLoading());
    try {
      final  data = await userRepo.getUser();
      emit(UserSuccess(data));
    } catch (e) {
      emit(UserFailure('Failed to load the data$e'));
    }
  }
}

abstract class UserStateData {}

class UserInitial extends UserStateData {}

class UserLoading extends UserStateData {}

class UserSuccess extends UserStateData {
  final List<User> user;

  UserSuccess(this.user);
}

class UserFailure extends UserStateData {
  final String message;

  UserFailure(this.message);
}
