import 'dart:async';
import 'package:flutter/material.dart';
import 'package:productivity_app/Time_Feature/services/times_data.dart';
import 'package:productivity_app/Shared/time_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Ticker {
  int count;

  Stream<int> stopWatchStream() {
    StreamController<int> streamController;
    Timer timer;
    const Duration timerInterval = Duration(seconds: 1);
    int counter = 0;

    void stopTimer() {
      if (timer != null) {
        timer.cancel();
        timer = null;
        counter = 0;
        streamController.close();
      }
    }

    void tick(_) {
      counter++;
      streamController.add(counter);
    }

    void startTimer() {
      timer = Timer.periodic(timerInterval, tick);
    }

    streamController = StreamController<int>(
      onListen: startTimer,
      onCancel: stopTimer,
      onResume: startTimer,
      onPause: stopTimer,
    );

    return streamController.stream;
  }
}

class TimerWidget extends StatefulWidget {
  final User user;
  TimerWidget({this.user});
  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Stream<int> timerStream;
  StreamSubscription<int> timerSubscription;
  String time;
  DateTime startTime;
  DateTime endTime;
  int count;
  IconButton playStop;

  void startTimer() {
    timerStream = Ticker().stopWatchStream();
    timerSubscription = timerStream.listen((int newTick) {
      runningTimer(newTick);
    });
    setState(() {
      playStop = IconButton(
        icon: Icon(Icons.stop_rounded),
        onPressed: () => stopTimer(),
      );
    });
    startTime = DateTime.now();
  }

  void stopTimer() {
    timerSubscription.cancel();
    timerStream = null;
    setState(() {
      playStop = IconButton(
        icon: Icon(Icons.play_arrow_rounded),
        onPressed: () => startTimer(),
      );
      time = '00:00:00';
    });
    endTime = DateTime.now();
    TimeService().addTimeEntry();
  }

  void runningTimer(int tick) {
    count = tick;
    print(count);
    String timerText;
    timerText = TimeFunctions().timeToText(seconds: tick);
    setState(() {
      time = timerText;
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timerSubscription.cancel();
    timerStream = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: <Widget>[
        playStop,
        Text(time),
      ]),
    );
  }
}
