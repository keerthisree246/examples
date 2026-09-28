abstract class UserDataState{}
class UserDataInitial extends UserDataState{}
class UserDataLoading extends UserDataState{}
class UserDataSuccess extends UserDataState{
  final List<dynamic> success;
  UserDataSuccess(this.success);
}
class UserDataError extends UserDataState{
  final String msg;
  UserDataError(this.msg);
}