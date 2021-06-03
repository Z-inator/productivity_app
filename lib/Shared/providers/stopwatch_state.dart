import 'dart:async';

import 'package:flutter/material.dart';

import '../../../Time_Feature/Time_Feature.dart';

class StopwatchState extends ChangeNotifier {
  Stopwatch stopwatch = Stopwatch();
  late Timer timer;
  int elapsedTicks = 0;
  TimeEntry? newEntry;


  void startStopwatch({TimeEntry? oldEntry}) {
    if (oldEntry != null) {
      newEntry = oldEntry.copyTimeEntry();
    } else {
      newEntry = TimeEntry();
    }
    elapsedTicks = 0;
    stopwatch.start();
    newEntry!.startTime = DateTime.now();
    onTick();
    notifyListeners();
  }

  void stopStopwatch() {
    stopwatch.stop();
    stopwatch.reset();
    timer.cancel();
    newEntry!.endTime = DateTime.now();
    notifyListeners();
  }

  void onTick() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      elapsedTicks = stopwatch.elapsed.inSeconds;
      notifyListeners();
    });
  }
}
