import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_game/models/QuizUser.dart';

void answerStatusPopup(BuildContext context, String answer, String correct,
    Function submitAnswer, Function exitQuiz, bool timeout) {
  bool isCorrect = answer == correct;
  final user = Provider.of<QuizUser?>(context, listen: false);
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          child: Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black54,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isCorrect
                          ? 'Your Answer is Correct'
                          : 'Your Answer is Wrong',
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      timeout
                          ? 'Time Out'
                          : answer == '10'
                              ? "Select an answer next time"
                              : answer != correct
                                  ? 'Correct answer is $correct '
                                  : '',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red[600]),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    !timeout
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    submitAnswer();
                                  },
                                  child: const Text('Next')),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    exitQuiz(user?.uid, user?.displayName);
                                  },
                                  child: const Text('Exit'))
                            ],
                          )
                        : ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              exitQuiz(user?.uid, user?.displayName);
                            },
                            child: const Text('Exit'))
                  ],
                ),
              )),
        );
      });
}
