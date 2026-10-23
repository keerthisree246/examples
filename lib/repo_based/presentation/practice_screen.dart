import 'package:example/repo_based/presentation/practice_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Posts'),),
      body: BlocBuilder<PracticeCubit,PracticeState>(
        builder: (context,state){
          if(state is PracticeLoading){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if(state is PrcaticeError){
            return Center(
              child: Row(
                children: [
                  Text(state.message),
                  TextButton(onPressed: ()=> context.read<PracticeCubit>().getData(), 
                  child: Text('Retry'))
                ],
              ),
            );
          }
          else if(state is PracticeSuccess){
            return Column(
              children: [
                Expanded(
                  // child:  ListView.builder(
                  //   itemCount: state.success.length,
                  //   itemBuilder: (context,index){
                  //     final post = state.success[index];
                  //     return Card(
                  //       child: ListTile(title: Text(post['id']),
                  //       subtitle: Text(post['title']),
                  //       ),
                  //     );
                  //   }
                  //   )
                  child: GridView.builder(
                    itemCount: state.success.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                    ), 
                    itemBuilder: (context,index){
                      final post = state.success[index];
                        return Card(
                        child: ListTile(title: Text(post['id'].toString()),
                        subtitle: Text(post['title'].toString()),
                        ),
                      );
                      }),
                  )
              ],
            );
          }
          return  const SizedBox();
          }
      ),
      );
  }
}