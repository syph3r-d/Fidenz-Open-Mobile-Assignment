import 'package:flutter/material.dart';

class NumberpadButton extends StatefulWidget {
  NumberpadButton(
      {required this.text, required this.onPressed, required this.active});
  final String text;
  final void Function() onPressed;
  final bool active;

  @override
  _NumberpadButtonState createState() => _NumberpadButtonState();
}

class _NumberpadButtonState extends State<NumberpadButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        child: Text(widget.text),
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.active ? Colors.purple : Colors.white,
          foregroundColor: widget.active ? Colors.white : Colors.purple,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          minimumSize: const Size(60, 60),
        ),
      ),
    );
  }
}
