abstract class BlocPracticeState{}
class BlocPracticeInitial extends BlocPracticeState{}
class BlocPracticeLoading extends BlocPracticeState{}
class BlocPracticeSuccess extends BlocPracticeState{
  final List<dynamic> success;
  BlocPracticeSuccess(this.success);
}
class BlocPracticeError extends BlocPracticeState{
  final String msg;
  BlocPracticeError(this.msg);
}