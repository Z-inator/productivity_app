import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/status.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Time_Feature/services/times_data.dart';
import 'package:provider/provider.dart';

class TaskEditState extends ChangeNotifier {
  Task newTask;

  TaskEditState({newTask}) : newTask = newTask as Task ?? Task();

  void updateTaskName(String taskName) {
    newTask.taskName = taskName;
    notifyListeners();
  }

  void updateTaskProject(Project project) {
    newTask.project = project;
    notifyListeners();
  }

  void updateTaskStatus(Status status) {
    newTask.status = status;
    notifyListeners();
  }

  void updateTaskDueDate(DateTime dueDate) {
    if (newTask.dueDate.microsecond == 555) {
      newTask.dueDate = dueDate;
    } else {
      final DateTime temp = newTask.dueDate;
      newTask.dueDate = DateTime(
          dueDate.year, dueDate.month, dueDate.day, temp.hour, temp.minute);
    }
    notifyListeners();
  }

  void updateTaskDueTime(TimeOfDay dueTime) {
    if (newTask.dueDate.year == 0) {
      newTask.dueDate = DateTime(0, 0, 0, dueTime.hour, dueTime.minute);
    } else {
      final DateTime temp = newTask.dueDate;
      newTask.dueDate = DateTime(
          temp.year, temp.month, temp.day, dueTime.hour, dueTime.minute);
    }
    notifyListeners();
  }

  void addTaskCreateDate(DateTime createDate) {
    newTask.createDate = createDate;
  }

  void disposeOfState() {
    super.dispose();
  }
}
