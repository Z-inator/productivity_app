import 'dart:async';

import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/Task_Feature.dart';

import '../../../Time_Feature/Time_Feature.dart';

class StopwatchState extends ChangeNotifier {
  Stopwatch stopwatch = Stopwatch();
  late Timer timer;
  int elapsedTicks = 0;
  late TimeEntry newEntry;

  void startStopwatch({TimeEntry? oldEntry}) {
    if (oldEntry != null) {
      newEntry = oldEntry.copyTimeEntry();
    } else {
      newEntry = TimeEntry(
          startTime: DateTime.now(),
          endTime: DateTime.now().add(Duration(hours: 1)));
    }
    elapsedTicks = 0;
    stopwatch.start();
    onTick();
    notifyListeners();
  }

  void stopStopwatch() {
    stopwatch.stop();
    stopwatch.reset();
    timer.cancel();
    newEntry.endTime = DateTime.now();
    notifyListeners();
  }

  void onTick() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      elapsedTicks = stopwatch.elapsed.inSeconds;
      notifyListeners();
    });
  }

  void updateEntryProject(Project? project) {
    newEntry.project = project;
    notifyListeners();
  }

  void updateEntryTask(Task? task) {
    newEntry.task = task;
    notifyListeners();
  }
}
