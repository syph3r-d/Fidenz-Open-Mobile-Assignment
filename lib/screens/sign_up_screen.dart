import 'package:flutter/material.dart';
import 'package:quiz_game/services/auth.dart';
import 'package:quiz_game/components/loading.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key, required this.switchScreen});

  final void Function(String) switchScreen;
  final AuthService _auth = AuthService();

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String email = '';
  String password = '';
  String confirmPassword = '';
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Signup ',
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
      ),
      body: Stack(children: [
        Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(children: [
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (val) =>
                      val!.isEmpty ? 'Enter an email address' : null,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 2.0),
                    ),
                  ),
                  onChanged: (value) => setState(() => email = value),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: true,
                  validator: (val) => val!.isEmpty ? 'Enter a password' : null,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 2.0),
                    ),
                  ),
                  onChanged: (value) => setState(() => password = value),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: true,
                  validator: (val) => val!.isEmpty ? 'Enter a password' : null,
                  decoration: const InputDecoration(
                    hintText: 'Confirm Password',
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 2.0),
                    ),
                  ),
                  onChanged: (value) => setState(() => confirmPassword = value),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (password != confirmPassword) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Passwords do not match'),
                            ),
                          );
                          return;
                        }
                        setState(() => loading = true);
                        dynamic results = await widget._auth
                            .registerWithEmailAndPassword(email, password);
                        if (results == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Register failed'),
                            ),
                          );
                          setState(() => loading = false);

                          return;
                        }
                        setState(() => loading = false);

                        widget.switchScreen('start');
                      }
                    },
                    child: const Text('Sign Up')),
              ]),
            )),
        loading ? const Loading() : const SizedBox.shrink(),
      ]),
    );
    ;
  }
}
