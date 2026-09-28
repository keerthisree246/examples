import 'package:example/user/model/user_model.dart';

abstract class UserRepo {
  Future<List<User>> getUser();
}