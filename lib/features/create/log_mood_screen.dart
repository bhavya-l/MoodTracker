import 'package:flutter/material.dart';
import 'package:moodtracker/db/database_helper.dart';
import 'package:moodtracker/models/reading.dart';
import 'package:intl/intl.dart';
import 'package:moodtracker/core/text_box.dart';
import 'package:moodtracker/core/ring.dart';

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
                      Row(
                        children: [
                          Ring(
                            initialValue: 0,
                            size: 60,
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Card(child: JournalBox()),
                      ElevatedButton(
                        onPressed: () async {
                          await _createReading();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFff5847),
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        child: const Text("Log Mood"),
                      ),
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
