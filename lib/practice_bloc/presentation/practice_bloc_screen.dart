import 'package:example/practice_bloc/presentation/practice_bloc.dart';
import 'package:example/practice_bloc/presentation/practice_event.dart';
import 'package:example/practice_bloc/presentation/practice_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PracticeBlocScreen extends StatelessWidget {
  const PracticeBlocScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: BlocBuilder<BlocPractice, BlocPracticeState>(
        builder: (context, state) {
          // Loading
          if (state is BlocPracticeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
    
          // Error
          if (state is BlocPracticeError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.msg,
                    textAlign: TextAlign.center,
                  ),
    
                  const SizedBox(height: 10),
    
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<BlocPractice>()
                          .add(GetPostData());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
    
          // Success
          if (state is BlocPracticeSuccess) {
            return ListView.builder(
              itemCount: state.success.length,
              itemBuilder: (context, index) {
                final post = state.success[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        post['id'].toString(),
                      ),
                    ),
                    title: Text(
                      post['title'].toString(),
                    ),
                    subtitle: Text(
                      post['body'].toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: Text('No data'),
          );
        },
      ),
    );
  }
}