import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/screens/task_by_create_date.dart';
import 'package:productivity_app/Task_Feature/screens/task_by_due_date.dart';
import 'package:productivity_app/Task_Feature/screens/task_by_project.dart';
import 'package:productivity_app/Task_Feature/screens/task_by_status.dart';
import 'package:provider/provider.dart';

class TaskBodyState extends ChangeNotifier {
  int _page = 0;
  Widget _widget = TasksByStatus();

  List<Widget> taskBodyContent = [
    TasksByStatus(),
    TasksByProject(),
    TaskByDueDate(),
    TaskByCreateDate()
  ];

  

  Widget get widget {
    return _widget;
  }

  int get page {
    return _page;
  }

  void changePage(int newPage) {
    _page = newPage;
    _widget = taskBodyContent[newPage];
    notifyListeners();
  }
}
