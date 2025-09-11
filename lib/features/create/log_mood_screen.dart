import 'package:flutter/material.dart';
import 'package:moodtracker/db/database_helper.dart';
import 'package:moodtracker/models/reading.dart';
import 'package:intl/intl.dart';

class LogMoodScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            // center the children
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () async {
                  await _createReading();
                },
                child: const Text("Log a Mood"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<int> _createReading() async {
  final reading = Reading(
    id: null, // let SQLite auto-generate
    timestamp: DateTime.now().toIso8601String(), // store as ISO8601 string
    mood_score: 1,
    context_light: 2,
    context_noise: 3,
    context_activity: 1,
  );
  return await DatabaseHelper.instance.insertReading(reading);
}
