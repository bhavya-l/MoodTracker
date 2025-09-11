import 'package:flutter/material.dart';
import 'package:moodtracker/features/landing/mood_screen.dart';
import 'package:moodtracker/features/insights/insights_screen.dart';
import 'package:moodtracker/features/create/log_mood_screen.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.title});
  final String? title;

  @override
  State<HomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formatter = DateFormat("MMM, EEE d");
    final formattedDate = formatter.format(now);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
        actions: [
          Row(
            children: [
              Text(
                formattedDate,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              SizedBox(width: 10),
              Icon(Icons.calendar_today, size: 18),
              SizedBox(width: 10),
            ],
          ),
        ],
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[MoodScreen(), LogMoodScreen(), InsightsScreen()],
      ),
      bottomNavigationBar: Material(
        child: TabBar(
          tabs: <Tab>[
            Tab(text: "Mood"),
            Tab(text: "Log Mood"),
            Tab(text: "Insights"),
          ],

          controller: controller,
        ),
      ),
    );
  }
}
