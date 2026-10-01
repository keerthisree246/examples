import 'package:example/counter_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
   void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
          if(state is LoginSuccess){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Login Successful!')),
            );
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Example()));
          }
        },
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Login Screen'),
                const SizedBox(width: 10),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(hintText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  ),
                ),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  ),
                ),

                ElevatedButton(
                  child: Text('Login'),
                  onPressed: () {
                    context.read<LoginCubit>().loginUser(emailController.text.trim(), passwordController.text.trim());
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
