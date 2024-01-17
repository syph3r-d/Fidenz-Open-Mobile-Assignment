import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_game/assets/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quiz_game/models/QuizUser.dart';
import 'package:quiz_game/screens/start_screen.dart';
import 'package:quiz_game/services/auth.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(StreamProvider<QuizUser?>.value(
    value: AuthService().user,
    initialData: null,
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: APP_NAME,
      home: StartScreen(),
    ),
  ));
}
