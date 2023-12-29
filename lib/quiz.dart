import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quiz_game/numberpad.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_game/timer.dart';
import 'dart:async';

StreamController<String> streamController =
    StreamController<String>.broadcast();

class Quiz extends StatefulWidget {
  const Quiz(
      {Key? key,
      required this.scoreIncrement,
      required this.quizCountIncrement})
      : super(key: key);

  final void Function() scoreIncrement;
  final void Function() quizCountIncrement;

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

  void fetchQuestion() async {
    var response =
        await http.get(Uri.https('marcconrad.com', 'uob/smile/api.php'));
    setState(() {
      question = jsonDecode(response.body);
    });
  }

  void submitAnswer() {
    if (question['solution'].toString() == selectedNumber) {
      widget.scoreIncrement();
    }
    streamController.add('reset');
    widget.quizCountIncrement();
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
              submitAnswer: submitAnswer,
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
                child: question['question'] != null &&
                        question['question'] is String
                    ? Image.network(question['question'])
                    : Container(
                        width: double.infinity,
                        height: 100,
                        color: Colors.grey,
                      ),
              ),
            ),
            Numberpad(
                selectNumber: selectNumber,
                submitAnswer: submitAnswer,
                selectedNumber: selectedNumber)
          ]),
    );
  }
}
