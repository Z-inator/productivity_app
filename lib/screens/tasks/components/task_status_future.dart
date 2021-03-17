import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/screens/tasks/components/status_edit_bottomsheet.dart';
import 'package:productivity_app/services/statuses_data.dart';

import 'package:provider/provider.dart';

class TaskStatusesFuture extends StatelessWidget {
  AsyncSnapshot<QuerySnapshot> querySnapshot;
  TaskStatusesFuture({this.querySnapshot});

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return FutureBuilder(
        future: StatusService(user: user).statuses.orderBy('statusOrder').get(),
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
              String statusID = document.id;
              String statusName = document.data()['statusName'].toString();
              Color statusColor = Color(document.data()['statusColor']);
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
                          accentColor: Theme.of(context).unselectedWidgetColor,
                        ),
                        child: ExpansionTile(
                          initiallyExpanded: false,
                          leading: Icon(
                            Icons.circle,
                            color: statusColor,
                          ),
                          title: Text(
                            statusName,
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
                                      return StatusEditBottomSheet(
                                          statusName: statusName,
                                          statusColor: statusColor,
                                          statusID: statusID);
                                    });
                              }),
                          expandedCrossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                  margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
                                  child: Text('Tasks: 10',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
                              child: Text(
                                          'Description\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Donec vel.',
                                          overflow: TextOverflow.fade,
                                          maxLines: 3,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1
                              )
                            )                                      
                          ]
                        ),
                      ),
                      Divider(),
                      GroupByStatus(
                        snapshot: querySnapshot,
                        status: statusName,
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

class GroupByStatus extends StatelessWidget {
  final String status;
  final AsyncSnapshot<QuerySnapshot> snapshot;
  GroupByStatus({this.snapshot, this.status});

  // Map<String, Iterable<dynamic>> groupByStatus(AsyncSnapshot<QuerySnapshot> snapshot, List statuses) {
  //   Map<String, Iterable> status = {};
  //   for (final item in statuses) {
  //     String temporary = statuses.elementAt(item).toString();
  //     status[temporary] = filterByStatus(snapshot, temporary);
  //   }
  //   return status;
  // }

  List filterByStatus(AsyncSnapshot<QuerySnapshot> snapshot, String status) {
    return snapshot.data.docs
        .where((document) => document.data()['status'] == status)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return ListBody(
      children: filterByStatus(snapshot, status).map((task) {
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
