import 'package:flutter/material.dart';
import 'package:productivity_app/Shared/functions/datetime_functions.dart';
import 'package:productivity_app/Shared/widgets/stopwatch_widget.dart';
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
  TaskBodyState({this.tasks, this.statuses, this.projects}) {
    changePage(0);
  }

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
        return StatusExpansionTile(
            status: item as Status, numberOfTasks: numberOfTasks);
      case 'Project':
        return ProjectExpansionTile(
            project: item as Project, numberOfTasks: numberOfTasks);
      case 'Due Date':
        return DayTile(day: item as String, numberOfTasks: numberOfTasks);
      case 'Create Date':
        return DayTile(day: item as String, numberOfTasks: numberOfTasks);
      default:
        return StatusExpansionTile(
            status: item as Status, numberOfTasks: numberOfTasks);
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
      case 'Create Date':
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
    List<Task> noStatusTasks = [];
    for (Status status in statuses) {
      List<Task> tempTasks =
          tasks.where((task) => task.status.id == status.id).toList();
      statusMapList.add({status: tempTasks});
    }
    noStatusTasks.addAll(tasks.where((task) => task.project.id.isEmpty));
    statusMapList.add({Status(statusName: 'No Project'): noStatusTasks});
    return statusMapList;
  }

  List<Map<Project, List<Task>>> getTasksByProject(
      List<Task> tasks, List<Project> projects) {
    List<Map<Project, List<Task>>> projectMapList = [];
    List<Task> noProjectTasks = [];
    for (Project project in projects) {
      List<Task> tempTasks =
          tasks.where((task) => task.project.id == project.id).toList();
      projectMapList.add({project: tempTasks});
    }
    noProjectTasks.addAll(tasks.where((task) => task.project.id.isEmpty));
    projectMapList.add({Project(projectName: 'No Project'): noProjectTasks});
    return projectMapList;
  }

  List<Map<String, List<Task>>> getTasksByDueDate(List<Task> tasks) {
    List<Map<String, List<Task>>> dueDateMapList = [];
    List<Task> noDueDateTasks = [];
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
      List<Task> tempTasks = tasks
          .where((task) =>
              task.dueDate.year == day.year &&
              task.dueDate.month == day.month &&
              task.dueDate.day == day.day)
          .toList();
      dueDateMapList
          .add({DateTimeFunctions().dateTimeToTextDate(date: day): tempTasks});
    }
    noDueDateTasks
        .addAll(tasks.where((task) => task.dueDate.microsecond == 555));
    dueDateMapList.add({'No Due Date': noDueDateTasks});
    return dueDateMapList;
  }

  List<Map<String, List<Task>>> getTasksByCreateDate(List<Task> tasks) {
    List<Map<String, List<Task>>> createDateMapList = [];
    List<DateTime> days = [];
    for (Task task in tasks) {
      DateTime tempDate =
          DateTime(task.createDate.year, task.createDate.month, task.createDate.day);
      if (!days.contains(tempDate)) {
        days.add(tempDate);
      }
    }
    days.sort((a, b) => b.compareTo(a));
    for (DateTime day in days) {
      List<Task> tempTasks = tasks
          .where((task) =>
              task.createDate.year == day.year &&
              task.createDate.month == day.month &&
              task.createDate.day == day.day)
          .toList();
      createDateMapList
          .add({DateTimeFunctions().dateTimeToTextDate(date: day): tempTasks});
    }
    return createDateMapList;
  }
}
