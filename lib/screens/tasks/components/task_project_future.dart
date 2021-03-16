import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/screens/tasks/components/project_edit_bottomsheet.dart';
import 'package:productivity_app/services/projects_data.dart';
import 'package:productivity_app/services/projects_data.dart';
import 'package:productivity_app/services/times_data.dart';
import 'package:productivity_app/shared_components/color_functions.dart';
import 'package:productivity_app/shared_components/datetime_functions.dart';
import 'package:productivity_app/shared_components/time_functions.dart';
import 'package:provider/provider.dart';

class TaskProjectsFuture extends StatelessWidget {
  AsyncSnapshot<QuerySnapshot> querySnapshot;
  TaskProjectsFuture({this.querySnapshot});

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return FutureBuilder(
        future: ProjectService(user: user).projects.get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading');
          }
          return ListView(
            padding: EdgeInsets.only(bottom: 100),
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              String projectID = document.id;
              String projectName = document.data()['projectName'].toString();
              Color projectColor = Color(document.data()['projectColor']);
              String projectClient = document.data()['projectClient'].toString();
              final String elapsedTime = TimeFunctions().timeToText(
                    seconds:
                        int.parse(document.data()['projectTime'].toString()));
              return Container(
                padding: EdgeInsets.all(10),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  elevation: 5,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Theme(
                          data: Theme.of(context).copyWith(
                            dividerColor: Colors.transparent,
                            accentColor:
                                Theme.of(context).unselectedWidgetColor,
                          ),
                          child: ExpansionTile(
                            initiallyExpanded: false,
                            leading: Icon(
                              Icons.circle,
                              color: projectColor,
                            ),
                            title: Text(
                              projectName,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            trailing: IconButton(
                                icon: Icon(Icons.edit_rounded),
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      isScrollControlled:
                                          true, // Allows the modal to me dynamic and keeps the menu above the keyboard
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20))),
                                      builder: (BuildContext context) {
                                        return ProjectEditBottomSheet(
                                          projectName: projectName,
                                          projectColor: projectColor,
                                          projectClient: projectClient,
                                          projectID: projectID,
                                        );
                                      });
                                }),
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Client: ClientName',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1),
                                    Text('Tasks: 10',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Time: $elapsedTime',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1),
                                    OutlinedButton.icon(
                                      icon: Icon(
                                          Icons.playlist_add_check_rounded),
                                      label: Text(
                                          'Tasks\n10'), // TODO: make this a live number
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/taskscreen',
                                            arguments: projectName);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                      Divider(),
                      GroupByProject(
                        snapshot: querySnapshot,
                        projectName: projectName,
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        });
  }
}

class GroupByProject extends StatelessWidget {
  final String projectName;
  final AsyncSnapshot<QuerySnapshot> snapshot;
  GroupByProject({this.snapshot, this.projectName});

  // Map<String, Iterable<dynamic>> groupByproject(AsyncSnapshot<QuerySnapshot> snapshot, List projectes) {
  //   Map<String, Iterable> project = {};
  //   for (final item in projectes) {
  //     String temporary = projectes.elementAt(item).toString();
  //     project[temporary] = filterByproject(snapshot, temporary);
  //   }
  //   return project;
  // }

  List filterByProject(AsyncSnapshot<QuerySnapshot> snapshot, String projectName) {
    return snapshot.data.docs
        .where((document) => document.data()['projectName'] == projectName)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return ListBody(
      children: filterByProject(snapshot, projectName).map((task) {
        print('building task list');
        return ExpansionTile(
          initiallyExpanded: false,
          leading: Icon(
            Icons.play_arrow_rounded,
            color: Colors.green,
          ),
          title: Text(
            task['taskName'].toString(),
          ),
          trailing: IconButton(
              icon: Icon(Icons.edit_rounded),
              onPressed: () {
                // showModalBottomSheet(
                //     context: context,
                //     isScrollControlled:
                //         true, // Allows the modal to me dynamic and keeps the menu above the keyboard
                //     shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.only(
                //             topLeft: Radius.circular(20),
                //             topRight: Radius.circular(20))),
                //     builder: (BuildContext context) {
                //       return ProjectEditBottomSheet(
                //         projectName: projectName,
                //         projectColor: projectColor,
                //         projectClient: projectClient,
                //         projectID: docID,
                //       );
                //     });
              }),
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Client: ClientName',
                      style: Theme.of(context).textTheme.subtitle1),
                  Text('Tasks: 10',
                      style: Theme.of(context).textTheme.subtitle1),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Time: ', style: Theme.of(context).textTheme.subtitle1),
                  OutlinedButton.icon(
                    icon: Icon(Icons.playlist_add_check_rounded),
                    label: Text('Tasks\n10'),
                    onPressed: () {
                      // Navigator.pushNamed(context, '/taskscreen',
                      //     arguments: projectName);
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
