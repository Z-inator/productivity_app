import 'dart:async';
import 'package:flutter/material.dart';

class Ticker {
  final Stopwatch stopwatch = new Stopwatch();
  Timer timer;
  Duration timerRefreshRate = Duration(seconds: 1);
  StreamSubscription<String> timerSubscription;

  Stream<String> stopWatchStream() {
    StreamController<String> streamController;

    void tick(_) {
      String stopWatchText = getTimerText();
      streamController.add(stopWatchText);
    }

    void startTimer() {
      timer = Timer.periodic(timerRefreshRate, tick);
    }

    void stopTimer() {}

    streamController = StreamController<String>(
      onListen: startTimer,
      onCancel: stopTimer,
    );

    return streamController.stream;
  }

  

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

class TimerWidget extends StatefulWidget {
  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Timer timer;
  StreamController<String> streamController = StreamController();
  Stream<String> timerStream;
  StreamSubscription<String> timerSubscription;

  @override
  void initState() {
    
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void callback() {}

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
