import 'package:example/repo_based/data/practice_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PracticeCubit extends Cubit<PracticeState> {
  final PracticeRepo repo;
  PracticeCubit(this.repo): super(PracticeInitial());

  Future<void> getData()async{
    try{
      emit(PracticeLoading());
      final data = await repo.getData();
      emit(PracticeSuccess(data));
    }catch(e){
      throw Exception('failed to fetch the data $e');
    }
  }
  
}


abstract class PracticeState{}
class PracticeInitial extends PracticeState{}
class PracticeLoading extends PracticeState{}
class PracticeSuccess extends PracticeState{
  final List<dynamic> data ;
  PracticeSuccess(this.data);
}
class PracticeError extends PracticeState{
  final String message;
  PracticeError(this.message);
}