import 'package:example/user_login/data/user_login_repo_impl.dart';
import 'package:example/user_login/presentation/ui/user_login_screen.dart';
import 'package:example/user_login/presentation/user_login_bloc/user_login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  final TextEditingController _desc = TextEditingController();
  final List<String> task = [];
  int selectedIndex = 0;

  void addTask() {
    if (_desc.text.trim().isEmpty) return;
    setState(() {
      task.add(_desc.text.trim());
    });
    _desc.clear();
  }

  void delete(int index) {
    setState(() {
      task.removeAt(index);
    });
  }

  @override
  void dispose() {
    _desc.dispose();
    super.dispose();
  }

  Widget _homePage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _desc,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Your Task',
                  ),
                ),
              ),
              TextButton(onPressed: addTask, child: const Text('Add')),
            ],
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3.0,
              ),
              itemCount: task.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(task[index]),
                    trailing: IconButton(
                      onPressed: () => delete(index),
                      icon: const Icon(Icons.delete),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  Widget _profilePage() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
          const SizedBox(height: 12),
          const Text('Name', style: TextStyle(fontSize: 20)),
          const SizedBox(height: 8),
          Text('Total tasks: ${task.length}'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedIndex == 0 ? 'TO DO APP' : 'PROFILE'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await const FlutterSecureStorage().deleteAll();
              if (!context.mounted) return;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => UserLoginCubit(UserLoginRepoImpl()),
                    child: const UserLoginScreen(),
                  ),
                ),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: [_homePage(), _profilePage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
