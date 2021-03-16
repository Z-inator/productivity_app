import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/screens/tasks/components/task_project_future.dart';
import 'package:productivity_app/screens/tasks/components/task_status_future.dart';
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

  int selectedPage = 0;

  List<Function> pages = [
    (querySnapshot) => TaskStatusesFuture(querySnapshot: querySnapshot),    // TODO: fix this function call
    (querySnapshot) => TaskProjectsFuture(querySnapshot: querySnapshot),
  ];

  void setPage(int index) {
    setState(() {
      selectedPage = index;
      
    });
  }

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
          return Container(
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextButton.icon(
                              onPressed: () {
                                
                                setPage(0);
                              },
                              icon: Icon(Icons.label_rounded),
                              label: Text('Status'),
                              style: TextButton.styleFrom(
                                backgroundColor: selectedPage == 0
                                    ? Theme.of(context).primaryColor
                                    : null,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25))),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextButton.icon(
                              onPressed: () {
                                
                                setPage(1);
                              },
                              icon: Icon(Icons.notification_important_rounded),
                              label: Text('Due Date'),
                              style: TextButton.styleFrom(
                                backgroundColor: selectedPage == 1
                                    ? Theme.of(context).primaryColor
                                    : null,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25))),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextButton.icon(
                              onPressed: () {
                                
                                setPage(2);
                              },
                              icon: Icon(Icons.playlist_add_rounded),
                              label: Text('Create Date'),
                              style: TextButton.styleFrom(
                                backgroundColor: selectedPage == 2
                                    ? Theme.of(context).primaryColor
                                    : null,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25))),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextButton.icon(
                              onPressed: () {
                                
                                setPage(3);
                              },
                              icon: Icon(Icons.topic_rounded),
                              label: Text('Project'),
                              style: TextButton.styleFrom(
                                backgroundColor: selectedPage == 3
                                    ? Theme.of(context).primaryColor
                                    : null,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25))),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  Expanded(
                      child: pages[selectedPage](querySnapshot: snapshot),
                  )
                ],
              ),
          );
        });
  }
}
