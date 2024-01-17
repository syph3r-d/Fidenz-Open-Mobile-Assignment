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
  final void Function() exitQuiz;

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  String selectedNumber = '10';
  var questionImage;
  Map<String, dynamic> question = {};
  bool loading = false;

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
    setState(() {
      loading = true;
    });
    var response = await http.get(Uri.https(API_BASE_URL, API_PATH));
    setState(() {
      question = jsonDecode(response.body);
      questionImage = Image.network(
        question[SMILE_API_QUESTION],
        height: 191,
        width: double.infinity,
      );
      questionImage.image
          .resolve(const ImageConfiguration())
          .addListener(ImageStreamListener((_, __) {
        if (mounted) {
          setState(() {
            loading = false;
          });
        }
      }));
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
                child: questionImage != null
                    ? questionImage
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
                selectedNumber: selectedNumber,
                loading: loading)
          ]),
    );
  }
}
