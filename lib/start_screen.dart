import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key, required this.switchScreen}) : super(key: key);

  final void Function(String) switchScreen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'The Smile Game',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.purpleAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/smiley-face-png-from-pngfre-9.png',
                  width: 100),
              const SizedBox(height: 50.0),
              ElevatedButton(
                  onPressed: () {
                    switchScreen('quiz');
                  },
                  child: const Text('Start Game'))
            ],
          ),
        ),
      ),
    );
  }
}
