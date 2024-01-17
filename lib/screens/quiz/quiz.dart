import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quiz_game/assets/constants.dart';
import 'package:quiz_game/components/numberpad/numberpad.dart';
import 'package:quiz_game/popups/answer_status_popup.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_game/components/timer/timer.dart';
import 'dart:async';

StreamController<String> streamController =
    StreamController<String>.broadcast();

class Quiz extends StatefulWidget {
  const Quiz(
      {Key? key,
      required this.scoreIncrement,
      required this.quizCountIncrement,
      required this.exitQuiz})
      : super(key: key);

  final void Function() scoreIncrement;
  final void Function() quizCountIncrement;
  final void Function(String, String) exitQuiz;

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  String selectedNumber = '10';
  Map<String, dynamic> question = {};

  @override
  void initState() {
    super.initState();
    fetchQuestion();
  }

  void showResult({bool timeout = false}) {
    streamController.add(TIMER_PAUSE);
    if (question[SMILE_API_SOLUTION].toString() == selectedNumber) {
      widget.scoreIncrement();
    }
    widget.quizCountIncrement();
    answerStatusPopup(
        context,
        selectedNumber,
        question[SMILE_API_SOLUTION].toString(),
        submitAnswer,
        widget.exitQuiz,
        timeout);
  }

  void fetchQuestion() async {
    streamController.add(TIMER_PAUSE);
    var response = await http.get(Uri.https(API_BASE_URL, API_PATH));
    setState(() {
      question = jsonDecode(response.body);
    });
    streamController.add(TIMER_START);
  }

  void submitAnswer() {
    streamController.add(TIMER_RESET);

    selectedNumber = '10';
    fetchQuestion();
  }

  void selectNumber(String number) {
    setState(() {
      selectedNumber = number;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Timer(
              submitAnswer: showResult,
              stream: streamController.stream,
            ),
            Container(
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                  blurRadius: 10.0,
                  color: Color.fromARGB(79, 0, 0, 0),
                  offset: Offset(5.0, 5.0),
                ),
              ]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: question[SMILE_API_QUESTION] != null &&
                        question[SMILE_API_QUESTION] is String
                    ? Image.network(
                        question[SMILE_API_QUESTION],
                        height: 191,
                        width: double.infinity,
                      )
                    : Container(
                        width: double.infinity,
                        height: 191,
                        color: Colors.grey,
                      ),
              ),
            ),
            Numberpad(
                selectNumber: selectNumber,
                submitAnswer: showResult,
                selectedNumber: selectedNumber)
          ]),
    );
  }
}
