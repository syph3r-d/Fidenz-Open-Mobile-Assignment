import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key, required this.switchScreen});

  final void Function(String) switchScreen;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: const Text(
        'Login ',
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                blurRadius: 10.0,
                color: Color.fromARGB(79, 0, 0, 0),
                offset: Offset(5.0, 5.0),
              ),
            ]),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            widget.switchScreen('start');
          },
          icon: const Icon(Icons.arrow_back),
          style: IconButton.styleFrom(
              shape: const CircleBorder(), backgroundColor: Colors.white54),
        )
      ],
      backgroundColor: Colors.purple,
    ));
  }
}
