import 'dart:async';
import 'package:flutter/material.dart';
import 'package:productivity_app/services/times_data.dart';
import 'package:productivity_app/components/time_to_text.dart';

class Ticker {
  int count;

  Stream<int> stopWatchStream() {
    StreamController<int> streamController;
    Timer timer;
    Duration timerInterval = Duration(seconds: 1);
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
  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Stream<int> timerStream;
  StreamSubscription<int> timerSubscription;
  String hourStr = '00';
  String minuteStr = '00';
  String secondStr = '00';
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
  }

  void stopTimer() {
    timerSubscription.cancel();
    timerStream = null;
    // print(TimeData().timeLogCount);
    // TimeData().addTime(count);
    // for (var item in TimeData().timeLog) {
    //   print(TimeData().timeLog[item]);

    // }
    setState(() {
      playStop = IconButton(
        icon: Icon(Icons.play_arrow_rounded),
        onPressed: () => startTimer(),
      );
      hourStr = '00';
      minuteStr = '00';
      secondStr = '00';
    });
    print(count);
  }

  void runningTimer(int tick) {
    count = tick;
    print(count);
    List<String> timerTextList = [];
    timerTextList = TimerText(ticks: tick).getTimerText();
    setState(() {
      hourStr = timerTextList[0];
      minuteStr = timerTextList[1];
      secondStr = timerTextList[2];
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
        Text('$hourStr:$minuteStr:$secondStr'),
      ]),
    );
  }
}
