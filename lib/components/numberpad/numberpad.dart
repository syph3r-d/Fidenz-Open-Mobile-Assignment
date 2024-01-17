import 'package:flutter/material.dart';
import 'package:quiz_game/components/numberpad/numberpad_button.dart';

class Numberpad extends StatelessWidget {
  const Numberpad(
      {super.key,
      required this.selectNumber,
      required this.submitAnswer,
      required this.selectedNumber,
      required this.loading});
  final void Function(String) selectNumber;
  final void Function() submitAnswer;
  final String selectedNumber;
  final bool loading;

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
                onPressed: loading ? null : selectNumber,
                active: selectedNumber == '1',
              ),
              NumberpadButton(
                  text: '2',
                  onPressed: loading ? null : selectNumber,
                  active: selectedNumber == '2'),
              NumberpadButton(
                  text: '3',
                  onPressed: loading ? null : selectNumber,
                  active: selectedNumber == '3'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NumberpadButton(
                  text: '4',
                  onPressed: loading ? null : selectNumber,
                  active: selectedNumber == '4'),
              NumberpadButton(
                  text: '5',
                  onPressed: loading ? null : selectNumber,
                  active: selectedNumber == '5'),
              NumberpadButton(
                  text: '6',
                  onPressed: loading ? null : selectNumber,
                  active: selectedNumber == '6'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NumberpadButton(
                  text: '7',
                  onPressed: loading ? null : selectNumber,
                  active: selectedNumber == '7'),
              NumberpadButton(
                  text: '8',
                  onPressed: loading ? null : selectNumber,
                  active: selectedNumber == '8'),
              NumberpadButton(
                  text: '9',
                  onPressed: loading ? null : selectNumber,
                  active: selectedNumber == '9'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NumberpadButton(
                  text: '0',
                  onPressed: loading ? null : selectNumber,
                  active: selectedNumber == '0'),
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
                onPressed: loading ? null : submitAnswer,
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
