import 'package:flutter/material.dart';
import 'package:moodtracker/core/home_screen.dart';
import 'package:moodtracker/db/database_helper.dart';
import 'package:moodtracker/core/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = await DatabaseHelper.instance.database;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      home: const HomePage(),
    );
  }
}
