import 'package:flutter/material.dart';

class JournalBox extends StatefulWidget {
  const JournalBox({super.key});

  @override
  State<JournalBox> createState() => _JournalBoxState();
}

class _JournalBoxState extends State<JournalBox> {
  final TextEditingController _controller = TextEditingController();
  final int _maxLength = 200;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 202,
      child: Stack(
        children: [
          TextField(
            controller: _controller,
            maxLength: _maxLength,
            maxLines: null,
            expands: true,
            decoration: const InputDecoration(
              fillColor: const Color(0xff333333),
              hintText: "Write about your day...",
              hintStyle: const TextStyle(
                color: Colors.white54,
                fontStyle: FontStyle.italic,
              ),
              counterText: "",
            ),
          ),
          Positioned(
            bottom: 4,
            right: 8,
            child: ValueListenableBuilder<TextEditingValue>(
              valueListenable: _controller,
              builder: (context, value, child) {
                return Text(
                  "${value.text.length}/$_maxLength",
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
