import 'package:flutter/material.dart';
import 'package:moodtracker/core/home_screen.dart';
import 'package:moodtracker/db/database_helper.dart';
import 'package:moodtracker/core/themes.dart';
import 'package:unlock_detector/unlock_detector.dart';
import 'package:moodtracker/trackers/light.dart';

final unlockStatus = ValueNotifier<UnlockDetectorStatus>(
  UnlockDetectorStatus.unknown,
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHelper.instance.deleteDatabaseFile();
  final db = await DatabaseHelper.instance.database;
  UnlockDetector.stream.listen((status) {
    unlockStatus.value = status;
    getLuxAndPushToDB();
  });
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
