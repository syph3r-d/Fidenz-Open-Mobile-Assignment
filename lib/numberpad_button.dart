import 'package:flutter/material.dart';

class NumberpadButton extends StatefulWidget {
  NumberpadButton(
      {required this.text,
      required this.onPressed,
      required this.active});
  final String text;
  final void Function(String) onPressed;
  final bool active;

  @override
  _NumberpadButtonState createState() => _NumberpadButtonState();
}

class _NumberpadButtonState extends State<NumberpadButton> {


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
          backgroundColor: widget.active
              ? Colors.green
              : const Color.fromARGB(255, 220, 220, 220),
          foregroundColor: widget.active ? Colors.white : Colors.black,
          side: widget.active
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
