import 'package:flutter/material.dart';
import 'package:quiz_game/quiz_screen.dart';
import 'package:quiz_game/start_screen.dart';
import 'package:quiz_game/results_screen.dart';

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  _MainNavigatorState createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  Widget? activeScreen;

  void initState() {
    super.initState();
    activeScreen = StartScreen(switchScreen: switchScreen);
  }

  void switchScreen(String screen, {int score = 0, int count=0}) {
    setState(() {
      if (screen == 'start') {
        activeScreen = StartScreen(switchScreen: switchScreen);
      }
      if (screen == 'quiz') {
        activeScreen = QuizScreen(switchScreen: switchScreen);
      }
      if (screen == 'results') {
        activeScreen = ResultsScreen(score: score,count: count, switchScreen: switchScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Smile Game',
      home: activeScreen,
    );
  }
}
