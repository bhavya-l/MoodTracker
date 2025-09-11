import 'package:flutter/material.dart';
import 'package:moodtracker/core/home_screen.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:moodtracker/db/database_helper.dart';

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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xfff9f6f1)),
      ),
      home: const HomePage(),
    );
  }
}
