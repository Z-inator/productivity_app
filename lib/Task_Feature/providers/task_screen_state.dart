import 'package:flutter/material.dart';
import 'package:productivity_app/Shared/functions/datetime_functions.dart';
import 'package:productivity_app/Shared/widgets/stopwatch_widget.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/status.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Task_Feature/screens/components/project_expansion_tile.dart';
import 'package:productivity_app/Task_Feature/screens/components/status_expansion_tile.dart';
import 'package:productivity_app/Task_Feature/screens/task_screen.dart';
import 'package:productivity_app/Task_Feature/services/tasks_data.dart';
import 'package:provider/provider.dart';

class TaskBodyState extends ChangeNotifier {
  TaskBodyState({this.taskService, this.tasks, this.statuses, this.projects}) {
    changePage(0);
  }

  int page = 0;
  TaskService taskService;
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
        currentTaskList = taskService.getTasksByStatus(tasks, statuses);
        break;
      case 'Project':
        currentTaskList = taskService.getTasksByProject(tasks, projects);
        break;
      case 'Due Date':
        currentTaskList = taskService.getTasksByDueDate(tasks);
        break;
      case 'Create Date':
        currentTaskList = taskService.getTasksByCreateDate(tasks);
        break;
      default:
        currentTaskList = taskService.getTasksByStatus(tasks, statuses);
    }
    page = index;
    notifyListeners();
  }
}
