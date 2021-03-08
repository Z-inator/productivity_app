import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/services/projects_data.dart';
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
    final User user = Provider.of<User>(context);
    return StreamBuilder(
        stream: TaskService(user: user).tasks.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text('Loading'));
          }
          return ListView(
              padding: EdgeInsets.only(bottom: 100),
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                final String docID = document.id;
                final String taskName = document.data()['taskName'].toString();
                final DateTime dueDate = DateTimeFunctions()
                    .timeStampToDateTime(date: document.data()['dueDate']);
                final String dueDateString =
                    DateTimeFunctions().dateToText(date: dueDate).toString();
                final String elapsedTime = TimeFunctions().timeToText(
                    seconds: int.parse(document.data()['taskTime'].toString()));
                final String status = document.data()['status'].toString();
                final String projectName =
                    document.data()['projectName'].toString();
                return ListTile(
                  leading: IconButton(
                    icon: Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.green,
                    ),
                    onPressed: () {},
                  ),
                  title: Text(taskName),
                  subtitle: ProjectColors()
                      .getProjectColoredText(context, projectName),
                  trailing: Text(dueDateString),
                  onTap: () {},
                );
              }).toList());
        });
  }
}
