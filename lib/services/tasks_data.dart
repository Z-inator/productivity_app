import 'dart:collection';

import 'package:productivity_app/models/projects.dart';
import 'package:productivity_app/models/subtasks.dart';
import 'package:productivity_app/models/tasks.dart';

class TaskData {
  List<Tasks> _tasks = [
    Tasks(taskName: 'test1'),
    Tasks(taskName: 'test2'),
    Tasks(taskName: 'test3')
  ];
  Projects project;

  UnmodifiableListView<Tasks> get tasks {
    return UnmodifiableListView(_tasks);
  }

  int get taskCount {
    return _tasks.length;
  }

  void addTask(String newTaskName) {
    final newTask = Tasks(taskName: newTaskName);
    if (project != null) {
      project.taskList.add(newTask);
    } else {
      _tasks.add(newTask);
    }
    print(taskCount);
    for (var task in tasks) {
      print(task.taskName);
    }
  }

  void updateTask(Tasks task, String updateTaskName) {
    task.taskName = updateTaskName;
  }

  void addTime(Tasks task, int time) {
    task.taskTime += time;
  }

  void deleteTask(Tasks task) {
    _tasks.remove(task);
  }
}
