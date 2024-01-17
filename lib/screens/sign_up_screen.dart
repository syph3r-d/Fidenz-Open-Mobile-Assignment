import 'package:flutter/material.dart';
import 'package:quiz_game/assets/constants.dart';
import 'package:quiz_game/services/auth.dart';
import 'package:quiz_game/components/loading.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  final AuthService _auth = AuthService();

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String email = '';
  String password = '';
  String confirmPassword = '';
  String name = '';
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          MENU_SIGN_UP,
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
              Navigator.pop(context);
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
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(children: [
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (val) => val!.isEmpty ? 'Enter a name' : null,
                  decoration: const InputDecoration(
                    hintText: 'Name',
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 2.0),
                    ),
                  ),
                  onChanged: (value) => setState(() => name = value),
                ),
                const SizedBox(
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
                const SizedBox(
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
                const SizedBox(
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
                const SizedBox(
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
                            .registerWithEmailAndPassword(
                                email, password, name);
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

                        Navigator.pop(context);
                      }
                    },
                    child: const Text(MENU_SIGN_UP)),
              ]),
            )),
        loading ? const Loading() : const SizedBox.shrink(),
      ]),
    );
  }
}
