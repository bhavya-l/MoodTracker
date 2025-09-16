import 'dart:async';
import 'package:light/light.dart';

Future<int?> getLuxValue() async {
  try {
    final luxValue = await Light().lightSensorStream.first;
    print('Got lux value: $luxValue');
    return luxValue;
  } catch (exception) {
    print('Error getting lux value: $exception');
    return null;
  }
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
