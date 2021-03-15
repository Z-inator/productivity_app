import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/services/projects_data.dart';
import 'package:productivity_app/services/tasks_data.dart';
import 'package:productivity_app/shared_components/color_functions.dart';
import 'package:productivity_app/shared_components/datetime_functions.dart';
import 'package:productivity_app/shared_components/time_functions.dart';
import 'package:provider/provider.dart';

class AssociatedTaskStream extends StatelessWidget {
  final String projectName;
  AssociatedTaskStream({this.projectName});

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: FutureBuilder(
            future: TaskService(user: user)
                .tasks
                .where('projectName', isEqualTo: projectName)
                .get(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Something went wrong'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Text('Loading'));
              }
              return Scrollbar(
                child: ListView(
                    children:
                        snapshot.data.docs.map((DocumentSnapshot document) {
                  final String docID = document.id;
                  final String taskName =
                      document.data()['taskName'].toString();
                  final DateTime dueDate = DateTimeFunctions()
                      .timeStampToDateTime(date: document.data()['dueDate']);
                  final String dueDateString =
                      DateTimeFunctions().dateToText(date: dueDate).toString();
                  final String elapsedTime = TimeFunctions().timeToText(
                      seconds:
                          int.parse(document.data()['taskTime'].toString()));
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
                }).toList()),
              );
            }),
      ),
    );
  }
}
