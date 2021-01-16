import 'dart:async';
import 'package:flutter/material.dart';

class Ticker {
  final Stopwatch stopwatch = new Stopwatch();
  Timer timer;
  final int timerRefreshRate = 1;

  void startStopButtonPressed() {
    if (stopwatch.isRunning) {
      stopwatch.stop();
    } else {
      stopwatch.start();
    }
  }

  Widget buildPlayStopButton(Icon icon, VoidCallback callback) {
    return new IconButton(icon: icon, onPressed: callback);
  }

  String getTimerText() {
    int seconds = (stopwatch.elapsedMilliseconds / 1000).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();
    String hourStr = (hours).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    return '$hourStr:$minutesStr:$secondsStr';
  }
}
