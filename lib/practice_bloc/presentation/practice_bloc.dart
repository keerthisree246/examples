import 'package:example/practice_bloc/data/bloc_repo.dart';
import 'package:example/practice_bloc/presentation/practice_event.dart';
import 'package:example/practice_bloc/presentation/practice_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocPractice extends Bloc<BlocPracticeEvent, BlocPracticeState>{
  final BlocRepo blocRepo;
  BlocPractice(this.blocRepo): super(BlocPracticeInitial()){
  on<GetPostData> ((event, emit)async {
    try{
    emit(BlocPracticeLoading());
    final data = await blocRepo.getPost();
    emit(BlocPracticeSuccess(data));
    }catch(e){
      emit(BlocPracticeError('failed$e'));
    }
}
);
}
}