import 'package:example/user/presentation/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({super.key});

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();

  }
  Future<void> _requestLocationPermission() async {
  final status = await Permission.location.request();

  if (status.isGranted) {
    print('Location permission granted');
  } else if (status.isDenied) {
    print('Location permission denied');
  } else if (status.isPermanentlyDenied) {
    print('Location permission permanently denied');
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Data'),
      ),
      body: BlocBuilder<UserCubitData, UserStateData>(
        builder: (context, state) {
          // Loading
          if (state is UserLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

           else if (state is UserFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => context.read<UserCubitData>().getUser(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          // Success
          if (state is UserSuccess) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.user.length,
                    itemBuilder: (context, index) {
                      final user = state.user[index];
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(child: Text(user.id.toString())),
                          title: Text(user.name),
                          subtitle: Text(user.email),
                          // subtitle: Text(user['completed'] ? 'Completed' : 'Not Completed'),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => context.read<UserCubitData>()..getUser(),
                    child: const Text('Refresh'),
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: Text('No user data'),
          );
        },
      ),
    );
  }
}
