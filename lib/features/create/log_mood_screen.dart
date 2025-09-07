import 'package:flutter/material.dart';

class LogMoodScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            // center the children
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Text("Log Mood Screen")],
          ),
        ),
      ),
    );
  }
}
