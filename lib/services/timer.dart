import 'dart:async';
import 'package:flutter/material.dart';
import 'package:productivity_app/services/times_data.dart';

class Ticker {
  Stream<int> stopWatchStream() {
    StreamController<int> streamController;
    Timer timer;
    Duration timerInterval = Duration(seconds: 1);
    int counter = 0;

    void stopTimer() {
      if (timer != null) {
        timer.cancel();
        timer = null;
        TimeData(counter);
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
  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Stream<int> timerStream;
  StreamSubscription<int> timerSubscription;
  String hourStr = '00';
  String minuteStr = '00';
  String secondStr = '00';
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
  }

  void stopTimer() {
    timerSubscription.cancel();
    timerStream = null;
    setState(() {
      playStop = IconButton(
        icon: Icon(Icons.play_arrow_rounded),
        onPressed: () => startTimer(),
      );
      hourStr = '00';
      minuteStr = '00';
      secondStr = '00';
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

  void runningTimer(int tick) {
    List<String> timeList = [];
    timeList = TimerText(ticks: tick).getTimerText();
    setState(() {
      hourStr = timeList[0];
      minuteStr = timeList[1];
      secondStr = timeList[2];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: <Widget>[
        playStop,
        Text('$hourStr:$minuteStr:$secondStr'),
      ]),
    );
  }
}

class TimerText {
  final int ticks;

  TimerText({this.ticks});

  List<String> getTimerText() {
    String hourStr =
        ((ticks / (60 * 60)) % 60).floor().toString().padLeft(2, '0');
    String minutesStr = ((ticks / 60) % 60).floor().toString().padLeft(2, '0');
    String secondsStr = (ticks % 60).floor().toString().padLeft(2, '0');
    return [hourStr, minutesStr, secondsStr];
  }
}
