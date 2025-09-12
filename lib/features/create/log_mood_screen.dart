import 'package:flutter/material.dart';
import 'package:moodtracker/db/database_helper.dart';
import 'package:moodtracker/models/reading.dart';
import 'package:intl/intl.dart';
import 'package:moodtracker/core/text_box.dart';

class LogMoodScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Choose Mood Entry Method:",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(children: [Text("Text")]),
                      const SizedBox(height: 16),
                      JournalBox(),
                    ],
                  ),
                ),
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
