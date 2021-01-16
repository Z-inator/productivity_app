// Credit: https://github.com/bizz84/stopwatch-flutter 

import 'package:flutter/material.dart';
import 'dart:async';

class ElapsedTime {
  final int seconds;
  final int minutes;
  final int hours;

  ElapsedTime({this.seconds, this.minutes, this.hours});
}

class Dependencies {
  final List<ValueChanged<ElapsedTime>> timerListeners =
      <ValueChanged<ElapsedTime>>[];
  final Stopwatch stopwatch = new Stopwatch();
  final int timerRefreshRate = 1;
}

class TimerButton extends StatefulWidget {
  @override
  _TimerButtonState createState() => _TimerButtonState();
}

class _TimerButtonState extends State<TimerButton> {
  final Dependencies dependencies = new Dependencies();


  void startStopButtonPressed() {
    setState(() {
      if (dependencies.stopwatch.isRunning) {
        dependencies.stopwatch.stop();
      } else {
        dependencies.stopwatch.start();
      }
    });
  }

  Widget buildPlayStopButton(Icon icon, VoidCallback callback) {
    return new IconButton(icon: icon, onPressed: callback);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        buildPlayStopButton(
            dependencies.stopwatch.isRunning
                ? Icon(Icons.stop_rounded)
                : Icon(Icons.play_arrow_rounded),
            startStopButtonPressed),
        new TimerText(
          dependencies: dependencies,
        )
      ],
    );
  }
}

class TimerText extends StatefulWidget {
  TimerText({this.dependencies});

  final Dependencies dependencies;

  TimerTextState createState() =>
      new TimerTextState(dependencies: dependencies);
}

class TimerTextState extends State<TimerText> {
  TimerTextState({this.dependencies});

  final Dependencies dependencies;
  Timer timer;
  int milliseconds;

  @override
  void initState() {
    timer = new Timer.periodic(
        new Duration(seconds: dependencies.timerRefreshRate), callback);
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    timer = null;
    super.dispose();
  }

  void callback(Timer timer) {
    if (milliseconds != dependencies.stopwatch.elapsedMilliseconds) {
      milliseconds = dependencies.stopwatch.elapsedMilliseconds;
      final int seconds = (milliseconds / 1000).truncate();
      final int minutes = (seconds / 60).truncate();
      final int hours = (minutes / 60).truncate();
      final ElapsedTime elapsedTime = new ElapsedTime(
        seconds: seconds,
        minutes: minutes,
        hours: hours,
      );
      for (final listener in dependencies.timerListeners) {
        listener(elapsedTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new MinutesSecondsHours(dependencies: dependencies),
    );
  }
}

class MinutesSecondsHours extends StatefulWidget {
  MinutesSecondsHours({this.dependencies});

  final Dependencies dependencies;

  MinutesSecondsHoursState createState() =>
      new MinutesSecondsHoursState(dependencies: dependencies);
}

class MinutesSecondsHoursState extends State<MinutesSecondsHours> {
  MinutesSecondsHoursState({this.dependencies});

  final Dependencies dependencies;

  int hours = 0;
  int minutes = 0;
  int seconds = 0;

  @override
  void initState() {
    dependencies.timerListeners.add(onTick);
    super.initState();
  }

  void onTick(ElapsedTime elapsed) {
    if (elapsed.hours != hours ||
        elapsed.minutes != minutes ||
        elapsed.seconds != seconds) {
      setState(() {
        hours = elapsed.hours;
        minutes = elapsed.minutes;
        seconds = elapsed.seconds;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String hourStr = (hours).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    return new Text('$hourStr:$minutesStr:$secondsStr');
  }
}

// // Credit: https://github.com/fayeed

// import 'dart:async';

// class TimerButton {
//   Stopwatch _watch;
//   Timer _timer;

//   StreamController<Duration> currentDuration = StreamController<Duration>();
//   Duration startTime;

//   TimerButton({this.startTime = Duration.zero}) {
//     _watch = Stopwatch();
//   }

//   void _onTick(Timer timer) {
//     final tempHour = startTime.inHours + _watch.elapsed.inHours;
//     final tempMinutes = startTime.inMinutes.remainder(60) +
//         _watch.elapsed.inMinutes.remainder(60);
//     final tempSeconds = startTime.inSeconds.remainder(60) +
//         _watch.elapsed.inSeconds.remainder(60);

//     final duration = Duration(
//       hours: tempHour,
//       minutes: tempMinutes,
//       seconds: tempSeconds,
//     );

//     currentDuration.add(duration);
//   }

//   void start() {
//     if (_timer != null) return;

//     _timer = Timer.periodic(Duration(seconds: 1), _onTick);
//     _watch.start();
//   }

//   void stop() {
//     _timer?.cancel();
//     _timer = null;
//     _watch.stop();
//     currentDuration.add(_watch.elapsed);
//   }

//   void reset() {
//     stop();
//     _watch.reset();
//     currentDuration.add(Duration.zero);
//   }
// }
