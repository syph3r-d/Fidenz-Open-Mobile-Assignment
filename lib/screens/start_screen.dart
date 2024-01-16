import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_game/models/QuizUser.dart';
import 'package:quiz_game/screens/leaderboard_screen.dart';
import 'package:quiz_game/screens/quiz/quiz.dart';
import 'package:quiz_game/screens/quiz/quiz_screen.dart';
import 'package:quiz_game/screens/sign_in_screen.dart';
import 'package:quiz_game/screens/sign_up_screen.dart';
import 'package:quiz_game/services/auth.dart';

class StartScreen extends StatelessWidget {
  StartScreen({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();

  void dummyFunction(String screen, {int score = 0, int count = 0}) {}

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<QuizUser?>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'The Smile Game',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.purpleAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/smiley-face-png-from-pngfre-9.png',
                  width: 100),
              const SizedBox(height: 50.0),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => QuizScreen()));
                  },
                  child: const Text('Start Game')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LeaderboardScreen()));
                  },
                  child: const Text('Leaderboard')),
              ElevatedButton(
                  onPressed: () {
                    if (user == null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInScreen()));
                    } else {
                      _auth.signOut();
                    }
                  },
                  child: Text(user == null ? 'Login' : 'Logout')),
              user == null
                  ? ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()));
                      },
                      child: const Text('Sign Up'))
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
