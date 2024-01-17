import 'package:flutter/material.dart';
import 'package:quiz_game/assets/constants.dart';
import 'package:quiz_game/components/loading.dart';
import 'package:quiz_game/services/auth.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({super.key});

  final AuthService _auth = AuthService();

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String email = '';
  String password = '';
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          MENU_LOGIN,
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
                ElevatedButton(
                    onPressed: () async {
                      setState(() => loading = true);
                      if (_formKey.currentState!.validate()) {
                        dynamic results = await widget._auth
                            .signInWithEmailAndPassword(email, password);
                        if (results == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Invalid login')));
                          setState(() {
                            loading = false;
                          });
                          return;
                        }
                        setState(() {
                          loading = false;
                        });
                        Navigator.pop(context);
                      }
                    },
                    child: const Text(MENU_LOGIN)),
              ]),
            )),
        loading ? const Loading() : const SizedBox.shrink(),
      ]),
    );
  }
}
