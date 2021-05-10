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
import 'package:provider/provider.dart';

class TaskBodyState extends ChangeNotifier {
  int _page = 0;
  Widget widget = TasksByStatus();
  List<Widget> widgets = [
    TasksByStatus(),
    TasksByProject(),
    TaskByDueDate(),
    TaskByCreateDate()
  ];
  List<dynamic> currentList = [];
  // String currentType = 'status';
  // Function getTasks;

  // List<Task> tasks;
  // List<Project> projects;
  // List<Status> statuses;
  // List<DateTime> dueDates;
  // List<DateTime> createDates;

  int get page {
    return _page;
  }

  // Widget byStatus(Status status) {
  //   return StatusExpansionTile(status: status);
  // }

  void changePage(int newPage) {
    // switch (newType) {
    //   case 'status':
    //     currentList = statuses;

    //     break;
    //   case 'project':
    //     currentList = projects;
    //     break;
    //   case 'dueDate':
    //     currentList = dueDates;
    //     break;
    //   case 'createDate':
    //     currentList = createDates;
    //     break;
    //   default:
    // }
    widget = widgets[newPage];
    _page = newPage;
    notifyListeners();
  }
}

class DayTile extends StatelessWidget {
  final DateTime day;
  final int numberOfTasks;
  const DayTile({Key key, this.day, this.numberOfTasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(DateTimeFunctions().dateTimeToTextDate(date: day)),
          Text(numberOfTasks.toString())
        ],
      ),
    );
  }
}
