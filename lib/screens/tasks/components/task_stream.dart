import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  List statuses;

  // Future<void> getStatusList(User user) async {
  //   final DocumentSnapshot document =
  //       await AuthService().getUserReference(user.uid).get();
  //   print('get document successful');
  //   print(document.data()['statuses']);
  //   document.data()['statuses'].map((status) => statuses.add(status));
  //   print(statuses);
  //   print('map document data successful');
  // }

  Future<void> getStatusList(User user) async {
    final QuerySnapshot snapshot =
        await StatusService(user: user).statuses.get();
    print('get statuses successful');
    snapshot.docs.map((DocumentSnapshot document) {
      print(document.data()['statusName']);
      statuses.add(document.data()['statusName']);
    });

    print(statuses);
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    getStatusList(user);
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
            children: statuses.map((status) {
              print('stream is building listview');
              final String statusName = status.toString();
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
                      Container(
                        padding: EdgeInsets.all(20),
                        child: ListTile(
                          leading: Icon(
                            Icons.circle,
                            color: Colors.blue,
                          ), // TODO: set color to status color
                          title: Text(statusName),
                          trailing: Text(
                              'Tasks: 10'), // TODO: set this to a dynamic number
                        ),
                      ),
                      Divider(),
                      GroupByStatus(snapshot: snapshot, status: statusName)
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
        print('building task list');
        return ExpansionTile(
          initiallyExpanded: false,
          leading: Icon(
            Icons.play_arrow_rounded,
            color: Colors.green,
          ),
          title: Text(
            task['taskName'].toString(),
            style: TextStyle(fontWeight: FontWeight.bold),
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

// return ListView(
//     padding: EdgeInsets.only(bottom: 100),
//     children: snapshot.data.docs.map((DocumentSnapshot document) {
//       final String docID = document.id;
//       final String taskName = document.data()['taskName'].toString();
//       final DateTime dueDate = DateTimeFunctions()
//           .timeStampToDateTime(date: document.data()['dueDate']);
//       final String dueDateString =
//           DateTimeFunctions().dateToText(date: dueDate).toString();
//       final String elapsedTime = TimeFunctions().timeToText(
//           seconds: int.parse(document.data()['taskTime'].toString()));
//       final String status = document.data()['status'].toString();
//       final String projectName =
//           document.data()['projectName'].toString();
//       return ListTile(
//         leading: IconButton(
//           icon: Icon(
//             Icons.play_arrow_rounded,
//             color: Colors.green,
//           ),
//           onPressed: () {},
//         ),
//         title: Text(taskName),
//         subtitle: ProjectColors()
//             .getProjectColoredText(context, projectName),
//         trailing: Text(dueDateString),
//         onTap: () {},
//       );
//     }).toList());
