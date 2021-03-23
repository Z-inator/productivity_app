import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/models/tasks.dart';
import 'package:productivity_app/screens/tasks/components/task_by_project_future.dart';
import 'package:productivity_app/screens/tasks/components/task_by_status_future.dart';
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
    var tasks = Provider.of<List<Task>>(context);
    final User user = Provider.of<User>(context);
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
              children: [
                FilterButtonRow(),
                Expanded(child: TaskProjectsFuture())
              ],
            ),
          );
        });
  }
}

class FilterButtonRow extends StatefulWidget {
  @override
  _FilterButtonRowState createState() => _FilterButtonRowState();
}

class _FilterButtonRowState extends State<FilterButtonRow> {
  int setBody = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.label_rounded),
              label: Text('Status'),
              style: TextButton.styleFrom(
                backgroundColor:
                    setBody == 0 ? Theme.of(context).primaryColor : null,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.notification_important_rounded),
              label: Text('Due Date'),
              style: TextButton.styleFrom(
                backgroundColor:
                    setBody == 1 ? Theme.of(context).primaryColor : null,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.playlist_add_rounded),
              label: Text('Create Date'),
              style: TextButton.styleFrom(
                backgroundColor:
                    setBody == 2 ? Theme.of(context).primaryColor : null,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.topic_rounded),
              label: Text('Project'),
              style: TextButton.styleFrom(
                backgroundColor:
                    setBody == 3 ? Theme.of(context).primaryColor : null,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TaskBodyWidget extends StatelessWidget {
  // void setPage(int index, AsyncSnapshot<QuerySnapshot> querySnapshot) {
  //   switch (index) {
  //     case 0:
  //       body = TaskStatusesFuture(querySnapshot: querySnapshot);
  //       break;
  //     case 1:
  //       body = TaskStatusesFuture(querySnapshot: querySnapshot);
  //       break;
  //     case 2:
  //       body = TaskStatusesFuture(querySnapshot: querySnapshot);
  //       break;
  //     case 3:
  //       body = TaskProjectsFuture(querySnapshot: querySnapshot);
  //       break;
  //     default:
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
