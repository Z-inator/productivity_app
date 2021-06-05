import 'package:flutter/material.dart';

import '../../../Task_Feature/Task_Feature.dart';

class TaskBodyState extends ChangeNotifier {
  int page = 0;

  List<Task>? tasks;
  List<Status>? statuses;
  List<Project>? projects;
  List<Map<dynamic, List<Task>>> currentTaskList = [];
  List<String> options = ['Status', 'Project', 'Due Date', 'Create Date'];
  List<IconData> icons = [
    Icons.check_circle_rounded,
    Icons.topic_rounded,
    Icons.notification_important_rounded,
    Icons.playlist_add_rounded
  ];
  TaskBodyState({this.tasks, this.statuses, this.projects}) {
    changePage(0);
  }

  void changePage(int index) {
    switch (options[index]) {
      case 'Status':
        currentTaskList = TaskService.getTasksByStatus(tasks!, statuses!);
        break;
      case 'Project':
        currentTaskList = TaskService.getTasksByProject(tasks!, projects!);
        break;
      case 'Due Date':
        currentTaskList = TaskService.getTasksByDueDate(tasks!);
        break;
      case 'Create Date':
        currentTaskList = TaskService.getTasksByCreateDate(tasks!);
        break;
      default:
        currentTaskList = TaskService.getTasksByStatus(tasks!, statuses!);
    }
    page = index;
    notifyListeners();
  }

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
}
