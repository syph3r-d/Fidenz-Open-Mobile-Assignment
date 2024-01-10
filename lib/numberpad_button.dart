import 'package:flutter/material.dart';

class NumberpadButton extends StatefulWidget {
  NumberpadButton(
      {required this.text,
      required this.onPressed,
      required this.activeNumber});
  final String text;
  final void Function(String) onPressed;
  final String activeNumber;

  @override
  _NumberpadButtonState createState() => _NumberpadButtonState();
}

class _NumberpadButtonState extends State<NumberpadButton> {
  bool active = false;

  @override
  void initState() {
    super.initState();
    active = widget.activeNumber == widget.text;
  }

  void onPressed() {
    widget.onPressed(widget.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: active
              ? Colors.green
              : const Color.fromARGB(255, 220, 220, 220),
          foregroundColor: active ? Colors.white : Colors.black,
          side: active
              ? const BorderSide(width: 2, color: Colors.purple)
              : BorderSide.none,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          minimumSize: const Size(60, 60),
        ),
        child: Text(
          widget.text,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
    );
  }
}
