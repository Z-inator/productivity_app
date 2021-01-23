import 'dart:collection';

import 'package:productivity_app/models/projects.dart';
import 'package:productivity_app/models/tasks.dart';

class TimeData {
  List<int> _timeLog = [];
  Projects project;
  Tasks task;

  UnmodifiableListView<int> get timeLog {
    return UnmodifiableListView(_timeLog);
  }

  int get timeLogCount {
    return _timeLog.length;
  }

  void addTime(int time) {
    if (project != null && task == null) {
      project.projectTime += time;
    } else if (project == null && task != null) {
      task.taskTime += time;
    } else {
      _timeLog.add(time);
    }
  }

  void updateTime(int time) {
    if (project != null && task == null) {
      project.projectTime += time;
    } else if (project == null && task != null) {
      task.taskTime += time;
    } else {
      _timeLog.add(time);
    }
  }

  void removeTime(int time) {
    if (project != null && task == null) {
      project.projectTime -= time;
    } else if (project == null && task != null) {
      task.taskTime -= time;
    } else {
      _timeLog.remove(time);
    }
  }
}
