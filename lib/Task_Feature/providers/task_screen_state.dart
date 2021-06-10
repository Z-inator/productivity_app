import 'package:flutter/material.dart';

import '../../../Task_Feature/Task_Feature.dart';

// This is the issue. these tasks don't update when the stream does.
// Same applies to time entries

class TaskBodyState extends ChangeNotifier {
  int page = 0;

  List<String> options = ['Status', 'Project', 'Due Date', 'Create Date'];
  List<IconData> icons = [
    Icons.check_circle_rounded,
    Icons.topic_rounded,
    Icons.notification_important_rounded,
    Icons.playlist_add_rounded
  ];

  void changePage(int index) {
    page = index;
    notifyListeners();
  }

  Widget getWidget(dynamic item, int numberOfTasks) {
    switch (options[page]) {
      case 'Status':
        return StatusExpansionTile(
            status: item as Status);
      case 'Project':
        return ProjectExpansionTile(
            project: item as Project);
      case 'Due Date':
        return DayTile(day: item as String, numberOfTasks: numberOfTasks);
      case 'Create Date':
        return DayTile(day: item as String, numberOfTasks: numberOfTasks);
      default:
        return StatusExpansionTile(
            status: item as Status);
    }
  }
}