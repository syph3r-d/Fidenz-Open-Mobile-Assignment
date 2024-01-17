import 'package:flutter/material.dart';

class NumberpadButton extends StatelessWidget {
  const NumberpadButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.active});
  final String text;
  final void Function(String)? onPressed;
  final bool active;

  void onButtonPressed() {
    if (onPressed != null) {
      onPressed!(text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: onButtonPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              active ? Colors.green : const Color.fromARGB(255, 220, 220, 220),
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
          text,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
    );
  }
}
