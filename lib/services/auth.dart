import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_game/models/QuizUser.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  QuizUser? _userFromFirebaseUser(User? user) {
    return user != null
        ? QuizUser(uid: user.uid, displayName: user.displayName ?? 'No Name')
        : null;
  }

  // Auth change user stream
  Stream<QuizUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // Sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Register with email and password
  Future registerWithEmailAndPassword(
      String email, String password, String displayName) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      User? user = result.user;

      await user!.updateDisplayName(displayName);
      await signOut();
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign out
  Future signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
