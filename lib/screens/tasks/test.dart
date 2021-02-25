import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:productivity_app/models/colors.dart';
import 'package:productivity_app/shared_components/time_to_text.dart';
import 'package:productivity_app/services/projects_data.dart';
import 'package:productivity_app/services/tasks_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:productivity_app/shared_components/date_to_text.dart';
import 'package:provider/provider.dart';

class ProjectContentPage extends StatefulWidget {
  @override
  _ProjectContentPageState createState() => _ProjectContentPageState();
}

class _ProjectContentPageState extends State<ProjectContentPage> {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    return StreamBuilder<QuerySnapshot>(
        stream: ProjectService(user: user).projects.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Loading'),
                ]);
          }
          return ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
            final String docID = document.id;
            final String projectName =
                document.data()['projectName'].toString();
            // final Color projectColor = ProjectColors(
            //         colorSelector:
            //             int.parse(document.data()['projectColor'].toString()))
            //     .getColor();
            final String elapsedTime = TimerText(
                    ticks: int.parse(document.data()['elapsedTime'].toString()))
                .timeToText();
            return ListTile(
                leading: Icon(
                  Icons.circle,
                  // color: projectColor,
                ),
                title: Text(projectName),
                subtitle: Text(elapsedTime),
                trailing: IconButton(
                    icon: Icon(Icons.playlist_add_rounded),
                    onPressed: () {
                      return showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return TaskStream(projectName: projectName);
                          });
                    }));
          }).toList());
        });
  }
}

class TaskStream extends StatefulWidget {
  final String projectName;
  TaskStream({this.projectName});
  @override
  _TaskStreamState createState() => _TaskStreamState();
}

class _TaskStreamState extends State<TaskStream> {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    return Container(
      child: StreamBuilder(
          stream: TaskService(user: user)
              .tasks
              .where('projectName', isEqualTo: widget.projectName)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Loading');
            }
            return ListView(
                children: snapshot.data.docs.map((DocumentSnapshot document) {
              final String docID = document.id;
              final String taskName = document.data()['projectName'].toString();
              final String dueDate =
                  DateText(date: document.data()['dueDate']).dateToText();
              final String elapsedTime = TimerText(
                      ticks:
                          int.parse(document.data()['elapsedTime'].toString()))
                  .timeToText();
              return ListTile(
                leading: IconButton(
                  icon: Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.green,
                  ),
                  onPressed: () {},
                ),
                title: Text(taskName),
                subtitle: Text(elapsedTime),
                trailing: Text(dueDate),
                onTap: () {},
              );
            }).toList());
          }),
    );
  }
}
