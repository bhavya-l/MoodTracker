import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MoodScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formatter = DateFormat("MMM, EEE d");
    final formattedDate = formatter.format(now);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with title and date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Mood",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        formattedDate,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.calendar_today, size: 20),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Week navigation cards
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _buildWeekDayCards(),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // How are you feeling card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "How are you feeling?",
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        height: 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.grey[300],
                        ),
                        child: FractionallySizedBox(
                          widthFactor: 0.7,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.orange,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Today's logs
              Text(
                "Today's Logs",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),

              Expanded(
                child: ListView(
                  children: [
                    // First log entry
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("Sept 22"),
                                const SizedBox(width: 8),
                                Text("11:51 AM"),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildLogItem("Mood", "8"),
                                _buildLogItem("Light", "9"),
                                _buildLogItem("Noise", "4"),
                                _buildLogItem("Steps", "5"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Second log entry
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("Sept 22"),
                                const SizedBox(width: 8),
                                Text("9:21 AM"),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildLogItem("Mood", "4"),
                                _buildLogItem("Light", "6"),
                                _buildLogItem("Noise", "8"),
                                _buildLogItem("Steps", "2"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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

  Widget _buildLogItem(String label, String value) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey[400]!, width: 4),
          ),
          child: Center(
            child: Text(
              value,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}
