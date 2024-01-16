import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_game/models/QuizUser.dart';
import 'package:quiz_game/services/auth.dart';

class StartScreen extends StatelessWidget {
  StartScreen({Key? key, required this.switchScreen}) : super(key: key);

  final void Function(String) switchScreen;
  final AuthService _auth = AuthService();

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
                    switchScreen('quiz');
                  },
                  child: const Text('Start Game')),
              ElevatedButton(
                  onPressed: () {
                    switchScreen('leaderboard');
                  },
                  child: const Text('Leaderboard')),
              ElevatedButton(
                  onPressed: () {
                    if (user == null) {
                      switchScreen('login');
                    } else {
                      _auth.signOut();
                    }
                  },
                  child: Text(user == null ? 'Login' : 'Logout')),
              user == null
                  ? ElevatedButton(
                      onPressed: () {
                        switchScreen('signup');
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
