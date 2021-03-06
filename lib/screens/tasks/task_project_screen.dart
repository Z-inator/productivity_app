import 'package:flutter/material.dart';
import 'package:productivity_app/screens/tasks/components/project_stream.dart';
import 'package:productivity_app/screens/tasks/components/task_stream.dart';
// import 'package:productivity_app/screens/tasks/test.dart';


class TaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Column(
        children: [
        TabBar(
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.black,
          labelPadding: EdgeInsets.fromLTRB(5, 20, 5, 10),
            tabs: [
              Text('Projects'),
              Text('Tasks')
            ]
          ),
        Expanded(
          child: TabBarView(
          children: [
            ProjectStream(),
            TaskStream()
          ]
          ),
        ),
        ]
      )
    );
  }
}