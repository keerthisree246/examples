abstract class DataState {}
class DataInitial extends DataState{}
class DataLoading extends DataState{}
class DataSuccess extends DataState{
  final List<dynamic> success;
  DataSuccess(this.success);
}
class DataError extends DataState{
  final String message;
  DataError(this.message);
}