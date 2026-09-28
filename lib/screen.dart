import 'package:example/user_bloc/user_bloc.dart';
import 'package:example/user_bloc/user_event.dart';
import 'package:example/user_bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Screen extends StatelessWidget {
  const Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return
    // BlocProvider(
    //   create: (context) => UserCubit()..fetchUsers(),
    //   child:
    Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: BlocBuilder<UserBloc, UserDataState>(
        builder: (context, state) {
          if (state is UserDataLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is UserDataSuccess) {
            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    itemCount: state.success.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,

                    ),
                    itemBuilder: (context, index) {
                      final user = state.success[index];
                      return Card(
                        child: ListTile( 
                          leading: CircleAvatar(child: Text(user['id'].toString())),
                          title: Text(user['title'],style: const TextStyle(fontSize: 14),),
                          // subtitle: Text(user['completed'] ? 'Completed' : 'Not Completed'),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => context.read<UserBloc>().add(GetUserData()),
                    child: const Text('Refresh'),
                  ),
                ),
              ],
            );
          }

          if (state is UserDataError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.msg,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    // onPressed: () => context.read<UserCubit>().fetchUsers(),
                    onPressed: ()=> context.read<UserBloc>().add(GetUserData()),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
      // ),
    );
  }
}
