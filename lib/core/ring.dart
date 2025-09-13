import 'package:flutter/material.dart';

class Ring extends StatelessWidget {
  final int value;
  final double size;
  final String? label;

  const Ring({Key? key, required this.value, this.size = 120.0, this.label})
    : super(key: key);

  Color _getRingColor() {
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

  Color _getBgRingColor() {
    if (value >= 1 && value <= 4) {
      return Color(0xffD28CA1);
    } else if (value >= 5 && value <= 7) {
      return Color(0xffF2DE91);
    } else if (value >= 8 && value <= 10) {
      return Color(0xffA8C686);
    } else {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final clampedValue = value.clamp(0, 10);
    final progress = clampedValue / 10.0; // Progress from 0 to 1
    final ringColor = _getRingColor();
    final bgRingColor = _getBgRingColor();
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
