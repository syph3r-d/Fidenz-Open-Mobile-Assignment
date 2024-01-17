import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_game/assets/constants.dart';
import 'package:quiz_game/models/QuizUser.dart';

class DatabaseService {
  DatabaseService();

  final CollectionReference scoreCollection =
      FirebaseFirestore.instance.collection('scores');

  Future updateUserScore(
      String uid, int score, int questions, String name) async {
    Map<String, dynamic>? userScore = await getScoreUser(uid);
    if (userScore == null) {
      await scoreCollection.doc(uid).set({
        USER_DISPLAY_NAME: name,
        HIGHSCORE_FIELD: score,
      });
    } else if (userScore[HIGHSCORE_FIELD] < score) {
      await scoreCollection.doc(uid).update({
        USER_DISPLAY_NAME: name,
        HIGHSCORE_FIELD: score,
      });
    }
    scoreCollection.doc(uid).collection('history').add({
      HISTORY_SCORE: score,
      HISTORY_QUESTIONS: questions,
      HISTORY_TIMESTAMP: DateTime.now(),
    });
    return null;
  }

  Future<Map<String, dynamic>?> getScoreUser(String uid) async {
    return await scoreCollection.doc(uid).get().then(
        (DocumentSnapshot value) => value.data() as Map<String, dynamic>?);
  }

  Future<List<Map<String, dynamic>>> getScores() async {
    return await scoreCollection.get().then((value) => value.docs.map((e) {
          Map<String, dynamic> data = e.data() as Map<String, dynamic>;
          data[USER_UID] = e.id;
          return data;
        }).toList());
  }

  Future<List<Map<String, dynamic>>> getHistory(String uid) async {
    return await scoreCollection
        .doc(uid)
        .collection('history')
        .get()
        .then((value) => value.docs.map((e) {
              Map<String, dynamic> data = e.data() as Map<String, dynamic>;
              data[USER_UID] = e.id;
              return data;
            }).toList());
  }
}
