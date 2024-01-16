import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_game/components/loading.dart';
import 'package:quiz_game/models/QuizUser.dart';
import 'package:quiz_game/screens/quiz/quiz.dart';
import 'package:quiz_game/screens/results_screen.dart';
import 'package:quiz_game/services/database.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  // final void Function(String, {int score, int count}) switchScreen;
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int quizCount = 0;
  int score = 0;
  bool loading = false;

  void incrementQuizCount() {
    setState(() {
      quizCount++;
    });
  }

  void incrementScore() {
    setState(() {
      score++;
    });
  }

  void exitQuiz(BuildContext context, uid, name) async {
    setState(() {
      loading = true;
    });
    if (uid != null) {
      await DatabaseService().updateUserScore(uid, score, name);
    }
    setState(() {
      loading = false;
    });
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ResultsScreen(score: score, count: quizCount)));

    // widget.switchScreen('results', score: score, count: quizCount);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<QuizUser?>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text.rich(TextSpan(
          text: 'Welcome ',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  blurRadius: 10.0,
                  color: Color.fromARGB(79, 0, 0, 0),
                  offset: Offset(5.0, 5.0),
                ),
              ]),
          children: <InlineSpan>[
            TextSpan(
                text: 'Chalana',
                style: TextStyle(fontWeight: FontWeight.normal)),
          ],
        )),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              exitQuiz(context, user?.uid, user?.displayName);
            },
            icon: const Icon(Icons.logout),
            style: IconButton.styleFrom(
                shape: const CircleBorder(), backgroundColor: Colors.white54),
          )
        ],
        backgroundColor: Colors.purple,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple, Colors.purpleAccent],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Container(
              margin: const EdgeInsets.only(top: 50),
              height: double.infinity,
              child: Column(children: [
                Quiz(
                    scoreIncrement: incrementScore,
                    quizCountIncrement: incrementQuizCount,
                    exitQuiz: exitQuiz)
              ]),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              color: Colors.purple,
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(82, 0, 0, 0),
                  blurRadius: 10.0,
                  spreadRadius: 5.0,
                  offset: Offset(5.0, 5.0),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              child: Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(TextSpan(
                      text: 'Quiz No : ',
                      style: const TextStyle(color: Colors.white),
                      children: <InlineSpan>[
                        TextSpan(
                            text: '$quizCount',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.greenAccent[400])),
                      ],
                    )),
                    Text.rich(TextSpan(
                      text: 'Score : ',
                      style: const TextStyle(color: Colors.white),
                      children: <InlineSpan>[
                        TextSpan(
                            text: '$score',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.greenAccent[400])),
                      ],
                    ))
                  ],
                ),
              ),
            ),
          ),
          loading ? const Loading() : const SizedBox.shrink()
        ],
      ),
    );
  }
}
