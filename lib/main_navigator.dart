import 'package:flutter/material.dart';
import 'package:quiz_game/screens/leaderboard_screen.dart';
import 'package:quiz_game/screens/quiz/quiz_screen.dart';
import 'package:quiz_game/screens/sign_in_screen.dart';
import 'package:quiz_game/screens/sign_up_screen.dart';
import 'package:quiz_game/screens/start_screen.dart';
import 'package:quiz_game/screens/results_screen.dart';
import 'package:quiz_game/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:quiz_game/models/QuizUser.dart';

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  _MainNavigatorState createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  Widget? activeScreen;

  void initState() {
    super.initState();
    activeScreen = StartScreen();
  }


  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuizUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        title: 'The Smile Game',
        home: activeScreen,
      ),
    );
  }
}
