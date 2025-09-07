import 'package:flutter/material.dart';
import 'package:moodtracker/features/landing/mood_screen.dart';
import 'package:moodtracker/features/insights/insights_screen.dart';
import 'package:moodtracker/features/create/log_mood_screen.dart';

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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
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
