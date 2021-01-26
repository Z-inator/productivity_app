import 'dart:collection';

import 'package:productivity_app/models/projects.dart';
import 'package:productivity_app/models/tasks.dart';

class TimeData {
  List<int> timeLog = [];
  Projects project;
  Tasks task;

  // UnmodifiableListView<int> get timeLog {
  //   return UnmodifiableListView(timeLog);
  // }

  List get timeLogList {
    return timeLog;
  }

  int get timeLogCount {
    return timeLog.length;
  }

  void addTime(int time) {
    timeLog.add(time);
    // if (project != null && task == null) {
    //   project.projectTime += time;
    // } else if (project == null && task != null) {
    //   task.taskTime += time;
    // } else {
    //   timeLog.add(time);
    // }
  }

  void updateTime(int time) {
    if (project != null && task == null) {
      project.projectTime += time;
    } else if (project == null && task != null) {
      task.taskTime += time;
    } else {
      timeLog.add(time);
    }
  }

  void removeTime(int time) {
    if (project != null && task == null) {
      project.projectTime -= time;
    } else if (project == null && task != null) {
      task.taskTime -= time;
    } else {
      timeLog.remove(time);
    }
  }
}
