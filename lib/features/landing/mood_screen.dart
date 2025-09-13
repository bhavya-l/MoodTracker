import 'package:flutter/material.dart';
import 'package:moodtracker/db/database_helper.dart';
import 'package:moodtracker/core/ring.dart';
import 'package:intl/intl.dart';

class MoodScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _buildWeekDayCards(),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "Summary",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(),
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "Logs",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),

              Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: _fetchReadings(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text("No readings logged yet."),
                      );
                    }

                    final readings = snapshot.data!;

                    return ListView.builder(
                      itemCount: readings.length,
                      itemBuilder: (context, index) {
                        final reading = readings[index];

                        final timestamp = DateTime.tryParse(
                          reading['timestamp'],
                        );
                        final time = timestamp != null
                            ? "${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}"
                            : "Unknown Time";

                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      new DateFormat.jm().format(
                                        DateTime.parse(reading['timestamp']),
                                      ),
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Color(0xffF2F2F2),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildLogItem(
                                      "Mood",
                                      reading['mood_score'],
                                    ),
                                    _buildLogItem(
                                      "Light",
                                      reading['context_light'] ?? "-",
                                    ),
                                    _buildLogItem(
                                      "Noise",
                                      reading['context_noise'] ?? "-",
                                    ),
                                    _buildLogItem(
                                      "Steps",
                                      reading['context_activity'] ?? "-",
                                    ),
                                  ],
                                ),

                                SizedBox(height: 16),
                                reading['mood_summary'] != null &&
                                        reading['mood_summary']
                                            .toString()
                                            .trim()
                                            .isNotEmpty
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(reading['mood_summary']),
                                        ],
                                      )
                                    : Text("No Summary Provided."),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildWeekDayCards() {
    final now = DateTime.now();
    final List<String> dayNames = [
      'Mon',
      'Tue',
      'Wed',
      'Thu',
      'Fri',
      'Sat',
      'Sun',
    ];
    List<Widget> cards = [];

    for (int i = -2; i <= 2; i++) {
      final date = now.add(Duration(days: i));
      final dayName = dayNames[date.weekday - 1];
      final dayNumber = date.day.toString();
      final isToday = i == 0;

      cards.add(_buildDayCard(dayName, dayNumber, isSelected: isToday));
    }

    return cards;
  }

  Widget _buildDayCard(String day, String date, {bool isSelected = false}) {
    return Container(
      width: 55,
      height: 75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isSelected ? Color(0xff9A8CFF) : Color(0xff404040),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(day),
          Text(date, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildLogItem(String label, int value) {
    return Column(
      children: [
        Ring(value: value, size: 60), // No label passed to Ring
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 14)),
      ],
    );
  }
}

Future<List<Map<String, dynamic>>> _fetchReadings() async {
  return DatabaseHelper.instance.getReading();
}
