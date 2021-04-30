import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/status.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Time_Feature/services/times_data.dart';
import 'package:provider/provider.dart';

class TaskEditState extends ChangeNotifier {
  Task _newTask;

  TaskEditState({newTask}) : _newTask = newTask as Task ?? Task();


  Task get newTask {
    return _newTask;
  }

  set newTask(Task task) {
    _newTask = task;
  }

  void updateTaskName(String taskName) {
    _newTask.taskName = taskName;
    notifyListeners();
  }

  void updateTaskProject(Project project) {
    _newTask.project = project;
    notifyListeners();
  }

  void updateTaskStatus(Status status) {
    _newTask.status = status;
    notifyListeners();
  }

  void updateTaskDueDate(DateTime dueDate) {
    if (_newTask.dueDate.microsecond == 555) {
      _newTask.dueDate = dueDate;
    } else {
      final DateTime temp = _newTask.dueDate;
      _newTask.dueDate = DateTime(
          dueDate.year, dueDate.month, dueDate.day, temp.hour, temp.minute);
    }
    notifyListeners();
  }

  void updateTaskDueTime(TimeOfDay dueTime) {
    if (_newTask.dueDate.year == 0) {
      _newTask.dueDate = DateTime(0, 0, 0, dueTime.hour, dueTime.minute);
    } else {
      final DateTime temp = _newTask.dueDate;
      _newTask.dueDate = DateTime(
          temp.year, temp.month, temp.day, dueTime.hour, dueTime.minute);
    }
    notifyListeners();
  }

  void addTaskCreateDate(DateTime createDate) {
    _newTask.createDate = createDate;
  }

  void disposeOfState() {
    super.dispose();
  }
}
