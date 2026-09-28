abstract class UserState{}
class UserInitial extends UserState{}
class UserLoading extends UserState{}
class UserSuccess extends UserState{
  final List<dynamic> success;
  UserSuccess(this.success);
}
class UserError extends UserState{
  final String msg;
  UserError(this.msg);
}