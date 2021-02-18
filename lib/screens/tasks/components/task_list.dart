import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:productivity_app/screens/tasks/components/due_task_list_builder.dart';
import 'package:productivity_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:productivity_app/models/projects.dart';
import 'package:productivity_app/services/projects_data.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    List projects = Provider.of<List<Projects>>(context);
    return ListView.builder(
      itemCount: projects.length,
      itemBuilder: (BuildContext context, index) {
        return ListTile(
          title: Text(''),
          subtitle: Text(''),
        );
      },
    );
  }
}

class TaskTest extends StatefulWidget {
  @override
  _TaskTestState createState() => _TaskTestState();
}

class _TaskTestState extends State<TaskTest> {
  @override
  Widget build(BuildContext context) {
    final List projects = [];
    return ListView.builder(
        itemCount: projects.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(''),
            subtitle: Text(''),
          );
        },
    );
  }
}
  // final List<String> projectList = [
  //   'project 1',
  //   'project 2',
  //   'project 3',
  //   'project 4',
  //   'project 5'
  // ];

  // @override
  // Widget build(BuildContext context) {
  //   return ListView.builder(
  //       itemCount: projectList.length,
  //       itemBuilder: (context, index) {
  //         return Container(
  //             padding: EdgeInsets.all(5),
  //             child: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                 crossAxisAlignment: CrossAxisAlignment.stretch,
  //                 children: <Widget>[
  //                   ExpansionTile(
  //                     title: Text(projectList[index]),
  //                     children: [TasksDueToday()],
  //                   ),
  //                 ]));
  //       });
  // }
