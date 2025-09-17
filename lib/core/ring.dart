import 'package:flutter/material.dart';

class Ring extends StatelessWidget {
  final int value;
  final double size;
  final String? label;

  const Ring({Key? key, required this.value, this.size = 120.0, this.label})
    : super(key: key);

  Color _getRingColor(int value) {
    if (value >= 1 && value < 4) {
      return Color(0xff941C49);
    } else if (value >= 4 && value < 7) {
      return Color(0xffE6C229);
    } else if (value >= 7 && value <= 10) {
      return Color(0xff66BC29);
    } else {
      return Colors.grey;
    }
  }

  Color _getBgRingColor(int value) {
    if (value >= 1 && value < 4) {
      return Color(0xffD28CA1);
    } else if (value >= 4 && value < 7) {
      return Color(0xffF2DE91);
    } else if (value >= 7 && value <= 10) {
      return Color(0xffA8C686);
    } else {
      return Colors.grey;
    }
  }

  static int luxToScale(int luxValue) {
    if (luxValue <= 5) return 1;
    if (luxValue <= 25) return 2;
    if (luxValue <= 100) return 3;
    if (luxValue <= 200) return 4;
    if (luxValue <= 500) return 5;
    if (luxValue <= 750) return 6;
    if (luxValue <= 1000) return 7; // Optimal start
    if (luxValue <= 2000) return 8; // Optimal end
    if (luxValue <= 10000) return 9;
    return 10; // 10000+ lux
  }

  @override
  Widget build(BuildContext context) {
    int clampedValue = value;
    if (label == "Light") {
      print("VALUE PRE DISPLAY: $value");
      clampedValue = luxToScale(value);
    }
    final progress = clampedValue / 10.0; // Progress from 0 to 1
    final ringColor = _getRingColor(clampedValue);
    final bgRingColor = _getBgRingColor(clampedValue);
    return Column(
      children: [
        SizedBox(
          width: size,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: size,
                height: size,
                child: CircularProgressIndicator(
                  strokeCap: StrokeCap.round,
                  value: progress,
                  strokeWidth: 6,
                  valueColor: AlwaysStoppedAnimation<Color>(ringColor),
                  backgroundColor: bgRingColor,
                ),
              ),
              Text(
                clampedValue.toString(),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
