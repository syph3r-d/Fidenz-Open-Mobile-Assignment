import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  DatabaseService();

  final CollectionReference scoreCollection =
      FirebaseFirestore.instance.collection('scores');

  Future updateUserScore(String uid, int score, String name) async {
    Map<String, dynamic>? userScore = await getScoreUser(uid);
    if (userScore == null) {
      return await scoreCollection.doc(uid).set({
        'displayName': name,
        'score': score,
      });
    }
    if (userScore['score'] < score) {
      return await scoreCollection.doc(uid).update({
        'displayName': name,
        'score': score,
      });
    }
    return null;
  }

  Future<Map<String, dynamic>?> getScoreUser(String uid) async {
    return await scoreCollection.doc(uid).get().then(
        (DocumentSnapshot value) => value.data() as Map<String, dynamic>?);
  }

  Future<List<Map<String, dynamic>>> getScores() async {
    return await scoreCollection.get().then((value) =>
        value.docs.map((e) {
          Map<String, dynamic> data = e.data() as Map<String, dynamic>;
          data['uid'] = e.id;
          return data;
        }).toList());
  }
}
