import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_game/assets/constants.dart';
import 'package:quiz_game/components/loading.dart';
import 'package:quiz_game/models/QuizUser.dart';
import 'package:quiz_game/services/database.dart';
import 'package:intl/intl.dart';

class ResultHistory extends StatefulWidget {
  const ResultHistory({Key? key}) : super(key: key);

  @override
  _ResultHistoryState createState() => _ResultHistoryState();
}

class _ResultHistoryState extends State<ResultHistory> {
  List<Map<String, dynamic>> history = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    getUserHistory();
  }

  void getUserHistory() async {
    setState(() {
      loading = true;
    });
    final user = Provider.of<QuizUser?>(context, listen: false);
    history = await DatabaseService().getHistory(user!.uid);
    history
        .sort((a, b) => b[HISTORY_TIMESTAMP].compareTo(a[HISTORY_TIMESTAMP]));
    setState(() {
      loading = false;
    });
  }

  String getDateTimeFromTimestamp(int timestampInSeconds) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestampInSeconds * 1000);
    return DateFormat('dd/MM/yyyy hh:mm').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          APP_NAME,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Stack(children: [
        Center(
            child: Column(children: [
          const SizedBox(height: 20.0),
          const Text(
            ANSWERS_HISTORY,
            style: TextStyle(fontSize: 25, color: Color.fromARGB(255, 0, 0, 0)),
          ),
          const SizedBox(height: 20.0),
          Expanded(
            child: ListView.builder(
                itemCount: history.length,
                itemBuilder: (context, index) {
                  // var date = DateTime.fromMillisecondsSinceEpoch(
                  //     history[index][HISTORY_TIMESTAMP]);
                  return ListTile(
                    leading: Text(
                      '${index + 1}',
                      style:
                          const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    isThreeLine: true,
                    subtitle: Text(
                      'Total Questions Answered : ${history[index][HISTORY_QUESTIONS]}',
                      style:
                          const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    title: Text(
                      'Score : ${history[index][HISTORY_SCORE]}',
                      style:
                          const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    trailing: Text(
                      getDateTimeFromTimestamp(
                          history[index][HISTORY_TIMESTAMP].seconds),
                      style:
                          const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  );
                }),
          ),
        ])),
        loading ? const Loading() : const SizedBox()
      ]),
    );
  }
}
