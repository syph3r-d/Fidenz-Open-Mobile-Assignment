import 'package:flutter/material.dart';
import 'package:quiz_game/screens/leaderboard_screen.dart';
import 'package:quiz_game/screens/quiz/quiz_screen.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key, required this.score, required this.count});

  final int score;
  final int count;

  @override
  Widget build(BuildContext context) {
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
              Text(
                'Your score is $score/$count',
                style: const TextStyle(fontSize: 25, color: Colors.white),
              ),
              const SizedBox(height: 50.0),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const QuizScreen()));
                  },
                  child: const Text('Play Again')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>const LeaderboardScreen()));
                    ;
                  },
                  child: const Text('Leaderboard'))
            ],
          ),
        ),
      ),
    );
  }
}
