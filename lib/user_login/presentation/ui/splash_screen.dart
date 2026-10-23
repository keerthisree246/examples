import 'package:example/to_do.dart';
import 'package:example/user_login/data/user_login_repo.dart';
import 'package:example/user_login/data/user_login_repo_impl.dart';
import 'package:example/user_login/presentation/ui/user_login_screen.dart';
import 'package:example/user_login/presentation/user_login_bloc/user_login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future<void> checkLogin() async {
    final apiKey = await _storage.read(key: 'api_key');
    final apiSecret = await _storage.read(key: 'api_secret');

    if (!mounted) return;
    final isLoggedIn = apiKey != null && apiSecret != null;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => isLoggedIn
            ? const ToDoScreen()
            : BlocProvider(
                create: (context) => UserLoginCubit(UserLoginRepoImpl()),
                child: const UserLoginScreen(),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
