import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/models/tasks.dart';
import 'package:productivity_app/screens/tasks/components/task_by_project_future.dart';
import 'package:productivity_app/screens/tasks/components/task_by_status_future.dart';
import 'package:productivity_app/screens/tasks/components/task_filter_buttons.dart';
import 'package:productivity_app/services/authentification_data.dart';
import 'package:productivity_app/services/projects_data.dart';
import 'package:productivity_app/services/statuses_data.dart';
import 'package:productivity_app/services/tasks_data.dart';
import 'package:productivity_app/shared_components/color_functions.dart';
import 'package:productivity_app/shared_components/datetime_functions.dart';
import 'package:productivity_app/shared_components/time_functions.dart';
import 'package:provider/provider.dart';

class TaskStream extends StatefulWidget {
  @override
  _TaskStreamState createState() => _TaskStreamState();
}

class _TaskStreamState extends State<TaskStream>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Task>>(
        stream: TaskService().streamTasks(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text('Loading'));
          }
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [FilterButtonRow(), Expanded(child: TaskBody())],
            ),
          );
        });
  }
}

class TaskBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget body = Provider.of<TaskBodyState>(context).widget;
    return body;
  }
}

class TaskBodyState extends ChangeNotifier {
  int _page = 0;
  Widget _widget = TasksByStatus();

  List<Widget> taskBodyContent = [
    TasksByStatus(),
    TasksByProject(),
    TasksByProject(),
    TasksByProject(),
  ];

  Widget get widget {
    return _widget;
  }

  // int get page {
  //   return _page;
  // }

  // set page(int newPage) {
  //   page = newPage;
  //   notifyListeners();
  // }

  void changePage(int newPage) {
    _page = newPage;
    _widget = taskBodyContent[newPage];
    notifyListeners();
  }
}
