import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:productivity_app/shared_components/color_functions.dart';
import 'package:productivity_app/shared_components/time_functions.dart';
import 'package:productivity_app/services/projects_data.dart';
import 'package:productivity_app/services/tasks_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:productivity_app/shared_components/datetime_functions.dart';
import 'package:provider/provider.dart';

class ProjectContentPage extends StatefulWidget {
  @override
  _ProjectContentPageState createState() => _ProjectContentPageState();
}

class _ProjectContentPageState extends State<ProjectContentPage> {
  double yTransValue = 0;

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    return Container(
        child: SafeArea(
            child: NotificationListener<ScrollUpdateNotification>(
      onNotification: (notification) {
        if (notification.scrollDelta.sign == 1) {
          setState(() {
            yTransValue = 100;
          });
        } else if (notification.scrollDelta.sign == -1) {
          setState(() {
            yTransValue = 0;
          });
        }
      },
      child: Scaffold(
        bottomNavigationBar: AnimatedContainer(
          color: Colors.transparent,
          duration: Duration(milliseconds: 300),
          transform: Matrix4.translationValues(0, yTransValue, 0),
          child: SizedBox(
            height: 60,
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.home),
                  Icon(Icons.search),
                  Icon(Icons.favorite),
                  Icon(Icons.person)
                ],
              ),
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: ProjectService(user: user).projects.snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Something went wrong'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Text('Loading'));
              }
              return ListView(
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                final String docID = document.id;
                final String projectName =
                    document.data()['projectName'].toString();
                final Color projectColor = ProjectColors().getColor(
                    colorSelector:
                        int.parse(document.data()['projectColor'].toString()));
                final String elapsedTime = TimeFunctions().timeToText(
                    seconds:
                        int.parse(document.data()['projectTime'].toString()));
                return ListTile(
                    leading: Icon(
                      Icons.circle,
                      color: projectColor,
                    ),
                    title: Text(projectName),
                    subtitle: Text(elapsedTime),
                    trailing: IconButton(
                        icon: Icon(Icons.playlist_add_rounded),
                        onPressed: () {
                          Navigator.pushNamed(context, '/taskscreen',
                              arguments: projectName);
                        }));
              }).toList());
            }),
      ),
    )));
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
    return Scaffold(
      appBar: AppBar(),
          body: Container(
        child: StreamBuilder(
            stream: TaskService(user: user)
                .tasks
                .where('projectName', isEqualTo: widget.projectName)
                .orderBy('dueDate', descending: true)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Something went wrong'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Text('Loading'));
              }
              return ListView(
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                final String docID = document.id;
                final String taskName = document.data()['taskName'].toString();
                final DateTime dueDate = DateTimeFunctions()
                    .timeStampToDateTime(date: document.data()['dueDate']);
                final String dueDateString =
                    DateTimeFunctions().dateToText(date: dueDate).toString();
                final String elapsedTime = TimeFunctions().timeToText(
                    seconds: int.parse(document.data()['taskTime'].toString()));
                return Card(
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50))),
                    leading: IconButton(
                      icon: Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.green,
                      ),
                      onPressed: () {},
                    ),
                    title: Text(taskName),
                    subtitle: Text(dueDateString),
                    trailing: Text(elapsedTime),
                    onTap: () {},
                  ),
                );
              }).toList());
            }),
      ),
    );
  }
}
