import 'package:flutter/material.dart';
import 'package:quiz_game/numberpad_button.dart';

class Numberpad extends StatefulWidget {
  const Numberpad(
      {super.key,
      required this.selectNumber,
      required this.submitAnswer,
      required this.selectedNumber});
  final void Function(String) selectNumber;
  final void Function() submitAnswer;
  final String selectedNumber;

  @override
  _NumberpadState createState() => _NumberpadState();
}

class _NumberpadState extends State<Numberpad> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black54,
      ),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NumberpadButton(
                text: '1',
                onPressed: () {
                  widget.selectNumber('1');
                },
                active: widget.selectedNumber == '1',
              ),
              NumberpadButton(
                  text: '2',
                  onPressed: () {
                    widget.selectNumber('2');
                  },
                  active: widget.selectedNumber == '2'),
              NumberpadButton(
                  text: '3',
                  onPressed: () {
                    widget.selectNumber('3');
                  },
                  active: widget.selectedNumber == '3'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NumberpadButton(
                  text: '4',
                  onPressed: () {
                    widget.selectNumber('4');
                  },
                  active: widget.selectedNumber == '4'),
              NumberpadButton(
                  text: '5',
                  onPressed: () {
                    widget.selectNumber('5');
                  },
                  active: widget.selectedNumber == '5'),
              NumberpadButton(
                  text: '6',
                  onPressed: () {
                    widget.selectNumber('6');
                  },
                  active: widget.selectedNumber == '6'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NumberpadButton(
                  text: '7',
                  onPressed: () {
                    widget.selectNumber('7');
                  },
                  active: widget.selectedNumber == '7'),
              NumberpadButton(
                  text: '8',
                  onPressed: () {
                    widget.selectNumber('8');
                  },
                  active: widget.selectedNumber == '8'),
              NumberpadButton(
                  text: '9',
                  onPressed: () {
                    widget.selectNumber('9');
                  },
                  active: widget.selectedNumber == '9'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NumberpadButton(
                  text: '0',
                  onPressed: () {
                    widget.selectNumber('0');
                  },
                  active: widget.selectedNumber == '0'),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  side: const BorderSide(width: 2, color: Colors.white),
                  minimumSize: const Size(150, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: widget.submitAnswer,
                child: Stack(children: [
                  Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 17,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 2
                        ..color = Colors.deepPurple,
                    ),
                  ),
                  const Text(
                    'Submit',
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  )
                ]),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
