import 'dart:async';

import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Time_Feature/models/times.dart';

class StopwatchState extends ChangeNotifier {
  Stopwatch stopwatch = Stopwatch();
  Timer timer;
  int elapsedTicks = 0;
  TimeEntry timeEntry;

  StopwatchState() : timeEntry = TimeEntry();

  void updateEntryTask(Task task) {
    timeEntry.task = task;
    notifyListeners();
  }

  void updateEntryProject(Project project) {
    timeEntry.project = project;
    notifyListeners();
  }

  void startStopwatch() {
    timeEntry = TimeEntry();
    elapsedTicks = 0;
    stopwatch.start();
    timeEntry.startTime = DateTime.now();
    onTick();
    notifyListeners();
  }

  void stopStopwatch() {
    stopwatch.stop();
    stopwatch.reset();
    timer.cancel();
    timeEntry.endTime = DateTime.now();
    notifyListeners();
  }

  void getTicks() {
    elapsedTicks = stopwatch.elapsedTicks;
    notifyListeners();
  }

  void onTick() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      elapsedTicks = stopwatch.elapsed.inSeconds;
      notifyListeners();
    });
  }
}
