import 'package:example/api_call.dart';
import 'package:example/to_do.dart';
import 'package:example/firebase_options.dart';
import 'package:example/login/login_cubit.dart';
import 'package:example/login/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async{
 WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform
 );
 FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
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
    //     create: (context) => LoginCubit(),
    //     child: const LoginScreen()),
    // );
    //  home: BlocProvider(
    //     create: (context) => BlocPractice(BlocRepoImpl())..add(GetPostData()),
    //     child: const PracticeBlocScreen()),
    //   );
    home: CounterAppExample(),
    );
  }
}
