// import 'package:example/user_bloc/user_state.dart';
import 'package:example/user_cubit/user_cubit.dart';
import 'package:example/user_cubit/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return
    // BlocProvider(
    //   create: (context) => UserCubit()..fetchUsers(),
    //   child:
    Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is UserSuccess) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.success.length,
                    itemBuilder: (context, index) {
                      final user = state.success[index];
                      return Dismissible(
                        key: ValueKey(user['id']),
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (direction) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${user['id']} deleted')),
                          );
                        },
                        child: Card(
                          child: ListTile(
                            leading: CircleAvatar(child: Text(user['id'].toString())),
                            title: Text(user['name']),
                            subtitle: Text(user['email']),
                            // subtitle: Text(user['completed'] ? 'Completed' : 'Not Completed'),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => context.read<UserCubit>()..fetchUsers(),
                    child: const Text('Refresh'),
                  ),
                ),
              ],
            );
          }

          if (state is UserError) {
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
                    onPressed: () => context.read<UserCubit>().fetchUsers(),
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
