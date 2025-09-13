import 'package:flutter/material.dart';
import 'package:moodtracker/core/ring.dart';
import 'package:moodtracker/db/database_helper.dart';
import 'package:moodtracker/models/reading.dart';
import 'package:moodtracker/core/text_box.dart';
import 'package:moodtracker/core/slider.dart';

class LogMoodScreen extends StatefulWidget {
  @override
  State<LogMoodScreen> createState() => _LogMoodScreenState();
}

class _LogMoodScreenState extends State<LogMoodScreen> {
  String _journalText = '';
  int _selectedOption = 0;
  double _userInput = 1;
  final double _predictedMoodScore = 9;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Choose Mood Entry Method:",
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                      ),
                    ],
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () => setState(() => _selectedOption = 0),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              width: double.infinity,
                              padding: EdgeInsets.all(16.0),
                              margin: EdgeInsets.only(bottom: 8.0),
                              decoration: _selectedOption == 0
                                  ? BoxDecoration(
                                      color: Color(0xff2D2A32),
                                      borderRadius: BorderRadius.circular(10.0),
                                    )
                                  : null,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Manual Entry",
                                    style: TextStyle(
                                      color: _selectedOption == 0
                                          ? Colors.white
                                          : Color(0xffCCCCCC),
                                      fontWeight: _selectedOption == 0
                                          ? FontWeight.w500
                                          : FontWeight.normal,
                                    ),
                                  ),
                                  ColoredSlider(
                                    value: _userInput,
                                    divisions: 10,
                                    onChanged: (double value) {
                                      setState(() {
                                        _userInput = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(height: 1, color: Color(0xff404040)),
                          GestureDetector(
                            onTap: () => setState(() => _selectedOption = 1),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              width: double.infinity,
                              padding: EdgeInsets.all(16.0),
                              margin: EdgeInsets.only(top: 8.0),
                              decoration: _selectedOption == 1
                                  ? BoxDecoration(
                                      color: Color(0xff2D2A32),
                                      borderRadius: BorderRadius.circular(10.0),
                                    )
                                  : null,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Use Predicted Score",
                                    style: TextStyle(
                                      color: _selectedOption == 1
                                          ? Colors.white
                                          : Color(0xffCCCCCC),
                                      fontWeight: _selectedOption == 1
                                          ? FontWeight.w500
                                          : FontWeight.normal,
                                    ),
                                  ),

                                  ColoredSlider(value: _predictedMoodScore),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          Card(
                            color: Color(0xff2D2A32),
                            child: JournalBox(
                              onTextChanged: (text) {
                                setState(() {
                                  _journalText = text;
                                });
                              },
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              await _createReading(_journalText);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFff5847),
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 48),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            child: const Text("Log Mood"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<int> _createReading(String journalText) async {
    final reading = Reading(
      id: null,
      timestamp: DateTime.now().toIso8601String(),
      mood_score: _selectedOption == 0
          ? _userInput.round()
          : _predictedMoodScore.round(),
      context_light: 2,
      context_noise: 3,
      context_activity: 1,
      mood_summary: journalText,
    );
    return await DatabaseHelper.instance.insertReading(reading);
  }
}
