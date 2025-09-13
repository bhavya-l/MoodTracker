import 'package:flutter/material.dart';

class ColoredSlider extends StatelessWidget {
  final double value;
  final double min;
  final double max;
  final int? divisions;
  final String? label;
  final bool showLabel;
  final bool enabled;
  final ValueChanged<double>? onChanged;

  const ColoredSlider({
    Key? key,
    required this.value,
    this.min = 1,
    this.max = 10,
    this.divisions,
    this.label,
    this.showLabel = true,
    this.enabled = false,
    this.onChanged,
  }) : super(key: key);

  Color _getColor(double value) {
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

  Color _getBgColor(double value) {
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

  SliderThemeData _getSliderTheme(double value) {
    Color sliderColor = _getColor(value);
    Color bgColor = _getBgColor(value);

    return SliderThemeData(
      valueIndicatorColor: sliderColor,
      disabledActiveTrackColor: sliderColor,
      disabledInactiveTrackColor: bgColor,
      disabledThumbColor: sliderColor,
      activeTrackColor: sliderColor,
      inactiveTrackColor: bgColor,
      thumbColor: sliderColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: _getSliderTheme(value),
      child: Slider(
        value: value,
        min: min,
        max: max,
        divisions: divisions,
        label: showLabel ? (label ?? value.round().toString()) : null,
        onChanged: onChanged,
      ),
    );
  }
}
