import 'package:flutter/material.dart';
import 'package:productivity_app/Shared/functions/datetime_functions.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/status.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Task_Feature/screens/components/project_expansion_tile.dart';
import 'package:productivity_app/Task_Feature/screens/components/status_expansion_tile.dart';
import 'package:productivity_app/Task_Feature/screens/task_by_create_date.dart';
import 'package:productivity_app/Task_Feature/screens/task_by_due_date.dart';
import 'package:productivity_app/Task_Feature/screens/task_by_project.dart';
import 'package:productivity_app/Task_Feature/screens/task_by_status.dart';
import 'package:productivity_app/Task_Feature/screens/task_screen.dart';
import 'package:provider/provider.dart';

class TaskBodyState extends ChangeNotifier {
  TaskBodyState({this.tasks, this.statuses, this.projects});
  int page = 0;
  List<Task> tasks;
  List<Status> statuses;
  List<Project> projects;
  List<Map<dynamic, List<Task>>> currentTaskList = [];
  List<String> options = ['Status', 'Project', 'Due Date', 'Create Date'];
  List<IconData> icons = [
    Icons.check_circle_rounded,
    Icons.topic_rounded,
    Icons.notification_important_rounded,
    Icons.playlist_add_rounded
  ];

  Widget getWidget(dynamic item, int numberOfTasks) {
    switch (options[page]) {
      case 'Status':
        return StatusExpansionTile(status: item as Status, numberOfTasks: numberOfTasks);
      case 'Project':
        return ProjectExpansionTile(project: item as Project, numberOfTasks: numberOfTasks);
      case 'Due Date':
        return DayTile(day: item as String, numberOfTasks: numberOfTasks);
      case ' Create Date':
        return DayTile(day: item as String, numberOfTasks: numberOfTasks);
      default:
        return StatusExpansionTile(status: item as Status, numberOfTasks: numberOfTasks);
    }
  }

  void changePage(int index) {
    switch (options[index]) {
      case 'Status':
        currentTaskList = getTasksByStatus(tasks, statuses);
        break;
      case 'Project':
        currentTaskList = getTasksByProject(tasks, projects);
        break;
      case 'Due Date':
        currentTaskList = getTasksByDueDate(tasks);
        break;
      case ' Create Date':
        currentTaskList = getTasksByCreateDate(tasks);
        break;
      default:
        currentTaskList = getTasksByStatus(tasks, statuses);
    }
    page = index;
    notifyListeners();
  }

  List<Map<Status, List<Task>>> getTasksByStatus(
      List<Task> tasks, List<Status> statuses) {
    List<Map<Status, List<Task>>> statusMapList = [];
    for (Status status in statuses) {
      List<Task> tempTasks = [];
      for (Task task in tasks) {
        if (task.status.id == status.id) {
          tempTasks.add(task);
          tasks.remove(task);
          tasks.join(', ');
        }
      }
      statusMapList.add({status: tempTasks});
    }
    if (tasks.isNotEmpty) {
      statusMapList.add({Status(statusName: 'No Status'): tasks});
    }
    return statusMapList;
  }

  List<Map<Project, List<Task>>> getTasksByProject(
      List<Task> tasks, List<Project> projects) {
    List<Map<Project, List<Task>>> projectMapList = [];
    for (Project project in projects) {
      List<Task> tempTasks = [];
      for (Task task in tasks) {
        if (task.project.id == project.id) {
          tempTasks.add(task);
          tasks.remove(task);
          tasks.join(', ');
        }
      }
      projectMapList.add({project: tempTasks});
    }
    if (tasks.isNotEmpty) {
      projectMapList.add({Project(projectName: 'No Project'): tasks});
    }
    return projectMapList;
  }

  List<Map<String, List<Task>>> getTasksByDueDate(List<Task> tasks) {
    List<Map<String, List<Task>>> dueDateMapList = [];
    List<DateTime> days = [];
    for (Task task in tasks) {
      DateTime tempDate =
          DateTime(task.dueDate.year, task.dueDate.month, task.dueDate.day);
      if (!days.contains(tempDate)) {
        days.add(tempDate);
      }
    }
    days.sort((a, b) => a.compareTo(b));
    for (DateTime day in days) {
      List<Task> tempTasks = [];
      for (Task task in tasks) {
        if (task.dueDate.year == day.year &&
            task.dueDate.month == day.month &&
            task.dueDate.day == day.day) {
          tempTasks.add(task);
          tasks.remove(task);
          tasks.join(', ');
        }
      }
      dueDateMapList
          .add({DateTimeFunctions().dateToText(date: day): tempTasks});
      if (tasks.isNotEmpty) {
        dueDateMapList.add({'No Due Date': tasks});
      }
    }
    return dueDateMapList;
  }

  List<Map<String, List<Task>>> getTasksByCreateDate(List<Task> tasks) {
    List<Map<String, List<Task>>> createDateMapList = [];
    List<DateTime> days = [];
    for (Task task in tasks) {
      DateTime tempDate =
          DateTime(task.dueDate.year, task.dueDate.month, task.dueDate.day);
      if (!days.contains(tempDate)) {
        days.add(tempDate);
      }
    }
    days.sort((a, b) => b.compareTo(a));
    for (DateTime day in days) {
      List<Task> tempTasks = [];
      for (Task task in tasks) {
        if (task.createDate.year == day.year &&
            task.createDate.month == day.month &&
            task.createDate.day == day.day) {
          tempTasks.add(task);
          tasks.remove(task);
          tasks.join(', ');
        }
      }
      createDateMapList
          .add({DateTimeFunctions().dateToText(date: day): tempTasks});
      if (tasks.isNotEmpty) {
        createDateMapList.add({'No Create Date': tasks});
      }
    }
    return createDateMapList;
  }
}
