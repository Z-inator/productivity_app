import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Time_Feature/models/times.dart';

class StopwatchState extends ChangeNotifier {
  Stopwatch stopwatch = Stopwatch();
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
    stopwatch.start();
    notifyListeners();
  }

  void stopStopwatch() {
    stopwatch.stop();
    notifyListeners();
  }

  void getTicks() {
    elapsedTicks = stopwatch.elapsedTicks;
    notifyListeners();
  }
}
