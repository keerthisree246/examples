import 'package:example/firebase_options.dart';
import 'package:example/practice_bloc/data/bloc_repo_impl.dart';
import 'package:example/practice_bloc/presentation/practice_bloc.dart';
import 'package:example/practice_bloc/presentation/practice_bloc_screen.dart';
import 'package:example/practice_bloc/presentation/practice_event.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    //   home: BlocProvider(
    //     create: (context) => UserBloc()..add(GetUserData()),
    //     child: const Screen()),
    // );
     home: BlocProvider(
        create: (context) => BlocPractice(BlocRepoImpl())..add(GetPostData()),
        child: const PracticeBlocScreen()),
      );
  }
}
