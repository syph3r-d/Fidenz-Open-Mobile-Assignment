import 'package:flutter/material.dart';

class Timer extends StatefulWidget {
  const Timer({Key? key, required this.submitAnswer, required this.stream})
      : super(key: key);

  final void Function() submitAnswer;
  final Stream<String> stream;

  @override
  _TimerState createState() => _TimerState();
}

// create progress bar timer animation

class _TimerState extends State<Timer> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? animation;
  double? animationValue;
  int? time;
  int? totalTime;
  bool? isFinished;

  @override
  void initState() {
    super.initState();
    time = 0;
    totalTime = 10;
    isFinished = false;
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: totalTime!),
    );
    animation = Tween<double>(begin: 0, end: 1).animate(controller!)
      ..addListener(() {
        setState(() {
          animationValue = animation!.value;
          time = (animationValue! * totalTime!).round();
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.submitAnswer();
        }
      });
    controller!.forward();
    widget.stream.listen((event) {
      if (event == 'reset') {
        resetTimer();
      }
    });
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  void resetTimer() {
    setState(() {
      time = 0;
      isFinished = false;
    });
    controller!.reset();
    controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.timer_sharp, color: Colors.white, size: 50),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: animationValue,
                    minHeight: 15,
                    backgroundColor: Colors.white,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              )
            ],
          ),
          Text(
            'Time Remaining: ${totalTime! - time!} Seconds',
            style: const TextStyle(color: Colors.white, fontSize: 15),
          )
        ],
      ),
    );
  }
}
