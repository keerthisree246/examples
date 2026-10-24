import 'package:example/firebase_options.dart';
import 'package:example/to_do.dart';
import 'package:example/user_cubit/user_cubit.dart';
import 'package:example/user_login/data/user_login_repo_impl.dart';
import 'package:example/user_login/presentation/ui/gate_entry_screen.dart';
import 'package:example/user_login/presentation/ui/user_login_screen.dart';
import 'package:example/user_login/presentation/user_login_bloc/user_login_cubit.dart';
import 'package:example/user_screen.dart';
import 'package:example/value_notifier_example.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      //   home: BlocProvider(
      //     create: (context) => UserLoginCubit(UserLoginRepoImpl()),
      //     child: const UserLoginScreen()),
      // // );
      //  home: BlocProvider(
      //     create: (context) => BlocPractice(BlocRepoImpl())..add(GetPostData()),
      //     child: const PracticeBlocScreen()),
      //   );
      home: GateEntryScreen()
    );
  }
}
