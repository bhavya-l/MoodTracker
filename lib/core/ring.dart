import 'package:flutter/material.dart';
import 'dart:math' as math;

class Ring extends StatefulWidget {
  final int initialValue;
  final ValueChanged<int>? onChanged;
  final double size;

  const Ring({
    Key? key,
    this.initialValue = 0,
    this.onChanged,
    this.size = 120.0,
  }) : super(key: key);

  @override
  State<Ring> createState() => _RingState();
}

class _RingState extends State<Ring> {
  late int _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue.clamp(1, 10);
  }

  void _updateValue(Offset localPosition) {
    final center = Offset(widget.size / 2, widget.size / 2);
    final angle = math.atan2(
      localPosition.dy - center.dy,
      localPosition.dx - center.dx,
    );

    double normalizedAngle = (angle + math.pi / 2) % (2 * math.pi);
    if (normalizedAngle < 0) normalizedAngle += 2 * math.pi;

    double progress = normalizedAngle / (2 * math.pi);

    int newValue = ((progress * 9) + 1).round().clamp(1, 10);

    if (newValue != _currentValue) {
      setState(() {
        _currentValue = newValue;
      });
      widget.onChanged?.call(_currentValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    double progress = (_currentValue - 1) / 9;

    return GestureDetector(
      onPanUpdate: (details) {
        _updateValue(details.localPosition);
      },
      onTapDown: (details) {
        _updateValue(details.localPosition);
      },
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: widget.size,
              height: widget.size,
              child: CircularProgressIndicator(
                strokeCap: StrokeCap.round,
                value: 1.0,
                strokeWidth: 8,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[700]!),
                backgroundColor: Colors.transparent,
              ),
            ),
            SizedBox(
              width: widget.size,
              height: widget.size,
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 8,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF4CAF50),
                ),
                backgroundColor: Colors.transparent,
              ),
            ),
            Text(
              _currentValue.toString(),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
