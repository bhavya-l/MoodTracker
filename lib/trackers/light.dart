import 'dart:async';
import 'package:light/light.dart';
import 'package:moodtracker/db/database_helper.dart';

class LightTracker {
  Future<int> getLuxValue() async {
    final mostRecentLog = await DatabaseHelper.instance.getMostRecentReading();
    final countOfLogs = await DatabaseHelper.instance.getTodaysReadingCount();

    int luxValue = await Light().lightSensorStream.first;

    print('Got raw lux value: $luxValue');
    print('Count of Logs: $countOfLogs');
    print('PRevious Average: $mostRecentLog["context_light"]');
    if (countOfLogs != 0) {
      luxValue =
          ((mostRecentLog?['context_light'] * countOfLogs + luxValue) /
                  (countOfLogs + 1))
              .round();
    }
    print('Got new lux value: $luxValue');
    return luxValue;
  }

  Future<void> getLuxAndPushToDB() async {
    final luxValue = await getLuxValue();

    if (luxValue != null) {
      await pushLuxToDB(luxValue);
    } else {
      print('Failed to get lux value, skipping DB push');
    }
  }

  Future<void> pushLuxToDB(int luxValue) async {
    print('Pushing lux value $luxValue to database...');
  }
}
