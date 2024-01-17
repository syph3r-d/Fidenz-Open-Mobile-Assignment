import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quiz_game/assets/constants.dart';
import 'package:quiz_game/models/QuizUser.dart';
import 'package:quiz_game/screens/leaderboard_screen.dart';
import 'package:quiz_game/screens/quiz/quiz_screen.dart';
import 'package:quiz_game/screens/result_history.dart';
import 'package:quiz_game/screens/sign_in_screen.dart';
import 'package:quiz_game/screens/sign_up_screen.dart';
import 'package:quiz_game/services/auth.dart';

class StartScreen extends StatelessWidget {
  StartScreen({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();

  void dummyFunction(String screen, {int score = 0, int count = 0}) {}

  @override
  Widget build(BuildContext context) {
    var ctime;
    final user = Provider.of<QuizUser?>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          APP_NAME,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          DateTime now = DateTime.now();
          if (ctime == null || now.difference(ctime) > Duration(seconds: 1)) {
            ctime = now;
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text(EXIT_APP_MSG)));
            return;
          }
          SystemNavigator.pop();
        },
        child: Container(
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
                Image.asset(SMILEY_FACE_IMAGE, width: 100),
                const SizedBox(height: 50.0),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuizScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green,
                    ),
                    child: const Text(MENU_START_GAME)),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LeaderboardScreen()));
                    },
                    child: const Text(MENU_LEADERBOARD)),
                user != null
                    ? ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ResultHistory()));
                          ;
                        },
                        child: const Text(ANSWERS_HISTORY),
                      )
                    : const SizedBox.shrink(),
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
                    style: ElevatedButton.styleFrom(
                      foregroundColor:
                          user != null ? Colors.white : Colors.deepPurple,
                      backgroundColor: user != null ? Colors.red : Colors.white,
                    ),
                    child: Text(user == null ? MENU_LOGIN : MENU_LOGOUT)),
                user == null
                    ? ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()));
                        },
                        child: const Text(MENU_SIGN_UP))
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
