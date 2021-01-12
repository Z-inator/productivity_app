import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:productivity_app/widgets/task_page/due_task_list_builder.dart';



class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final List<String> projectList = ['project 1', 'project 2', 'project 3', 'project 4', 'project 5'];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: projectList.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(5),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ExpansionTile(
                  title: Text(projectList[index]),
                  children: [
                    TasksDueToday()
                  ],  
                ),
              ]
            )
          );
        }
      ),
    );
  }
}
