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
                onPressed: widget.selectNumber,
                activeNumber: widget.selectedNumber,
              ),
              NumberpadButton(
                  text: '2',
                  onPressed: widget.selectNumber,
                  activeNumber: widget.selectedNumber),
              NumberpadButton(
                  text: '3',
                  onPressed: widget.selectNumber,
                  activeNumber: widget.selectedNumber),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NumberpadButton(
                  text: '4',
                  onPressed: widget.selectNumber,
                  activeNumber: widget.selectedNumber),
              NumberpadButton(
                  text: '5',
                  onPressed: widget.selectNumber,
                  activeNumber: widget.selectedNumber),
              NumberpadButton(
                  text: '6',
                  onPressed: widget.selectNumber,
                  activeNumber: widget.selectedNumber),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NumberpadButton(
                  text: '7',
                  onPressed: widget.selectNumber,
                  activeNumber: widget.selectedNumber),
              NumberpadButton(
                  text: '8',
                  onPressed: widget.selectNumber,
                  activeNumber: widget.selectedNumber),
              NumberpadButton(
                  text: '9',
                  onPressed: widget.selectNumber,
                  activeNumber: widget.selectedNumber),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NumberpadButton(
                  text: '0',
                  onPressed: widget.selectNumber,
                  activeNumber: widget.selectedNumber),
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
                      fontSize: 30,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 2
                        ..color = Colors.deepPurple,
                    ),
                  ),
                  const Text(
                    'Submit',
                    style: TextStyle(fontSize: 30, color: Colors.white),
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
