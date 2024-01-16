import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_game/components/loading.dart';
import 'package:quiz_game/models/QuizUser.dart';
import 'package:quiz_game/services/database.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  _LeaderboardScreenState createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  bool loading = false;
  List<Map<String, dynamic>> leaderboard = [];

  @override
  void initState() {
    super.initState();
    getLeaderboard();
  }

  void getLeaderboard() async {
    setState(() {
      loading = true;
    });
    List<Map<String, dynamic>> scores = await DatabaseService().getScores();
    scores.sort((a, b) => b['score'].compareTo(a['score']));
    print(scores);
    setState(() {
      leaderboard = scores;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<QuizUser?>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'The Smile Game',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Stack(children: [
        Center(
            child: Column(children: [
          const SizedBox(height: 20.0),
          const Text(
            'Leaderboard',
            style: TextStyle(fontSize: 25, color: Color.fromARGB(255, 0, 0, 0)),
          ),
          const SizedBox(height: 20.0),
          Expanded(
            child: ListView.builder(
                itemCount: leaderboard.length,
                itemBuilder: (context, index) {
                  bool isCurrentUser = leaderboard[index]['uid'] == user?.uid;
                  return ListTile(
                    tileColor: isCurrentUser
                        ? Colors.purpleAccent
                        : Colors.transparent,
                    leading: Text(
                      '${index + 1}',
                      style:
                          const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    title: Text(
                      '${leaderboard[index]['displayName']}',
                      style:
                          const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    trailing: Text(
                      '${leaderboard[index]['score']}',
                      style:
                          const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  );
                }),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back'))
        ])),
        loading ? const Loading() : const SizedBox()
      ]),
    );
  }
}
