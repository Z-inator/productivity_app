import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/models/tasks.dart';
import 'package:productivity_app/screens/home/home_screen.dart';
import 'package:productivity_app/screens/timeEntries/time_screen.dart';
import 'package:productivity_app/services/authentification_data.dart';
import 'package:productivity_app/services/database.dart';
import 'package:productivity_app/models/projects.dart';
import 'package:productivity_app/services/projects_data.dart';
import 'package:productivity_app/services/tasks_data.dart';
import 'package:productivity_app/services/timer.dart';
import 'package:productivity_app/services/times_data.dart';
import 'package:productivity_app/shared_components/base_framework.dart';
import 'package:productivity_app/shared_components/bottom_navigation_bar2.dart';
import 'package:productivity_app/shared_components/time_functions.dart';
import 'package:productivity_app/test_data/project_to_firebase.dart';
import 'package:productivity_app/test_data/task_to_firebase.dart';
import 'package:productivity_app/test_data/time_to_firebase.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class TestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Task> tasks = Provider.of<List<Task>>(context);
    // final Task task =
    //     tasks.firstWhere((task) => task.taskID == '2HzAhm2vMw9q0ZrBr1nJ');
    return FunctionalityButtonList();
  }
}

class FunctionalityButtonList extends StatefulWidget {
  
  @override
  _FunctionalityButtonListState createState() =>
      _FunctionalityButtonListState();
}

class _FunctionalityButtonListState extends State<FunctionalityButtonList> {
  Task newTask = Task();
  Project newProject;
  DateTime _dueDate;
  TimeOfDay _dueTime;
  Duration _addedTime;
  FocusNode minuteFocusNode;
  FocusNode hourFocusNode;

  @override
  void initState() {
    _dueDate = DateTime.now();
    _dueTime = TimeOfDay.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    List<Task> tasks = Provider.of<List<Task>>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
            onPressed: () {
              print(user.emailVerified);
            },
            child: Text('Print user\'s verification')),
        ElevatedButton(
            onPressed: () {
              AuthService()
                  .signOut()
                  .then((value) => print(FirebaseAuth.instance.currentUser));
            },
            child: Text('Sign Out')),

        // ElevatedButton(
        //   onPressed: () {
        //     return showModalBottomSheet(
        //         context: context,
        //         builder: (BuildContext context) {
        //           return TimeEntryStream(user: user,);
        //         });
        //   },
        //   child: Text('Time List ordered by end time'),
        // ),
        // ElevatedButton(
        //     onPressed: () {
        //       print(user.uid);
        //       return showModalBottomSheet(
        //           context: context,
        //           builder: (BuildContext context) {
        //             return TasksStream(
        //               user: user,
        //             );
        //           });
        //     },
        //     child: Text('Show Tasks')),
        // ElevatedButton(
        //     onPressed: () {
        //       print(user.uid);
        //       return showModalBottomSheet(
        //           context: context,
        //           builder: (BuildContext context) {
        //             return ProjectStream();
        //           });
        //     },
        //     child: Text('Show Projects')),
        // ElevatedButton(
        //     onPressed: () {
        //       print(user.uid);
        //       return showModalBottomSheet(
        //           context: context,
        //           builder: (BuildContext context) {
        //             return TimeEntryStream(user: user);
        //           });
        //     },
        //     child: Text('Show Time Entries')),
        // ElevatedButton(
        //     onPressed: () {
        //       print(user.uid);
        //       return showModalBottomSheet(
        //           context: context,
        //           builder: (BuildContext context) {
        //             return TimerWidget(
        //               user: user,
        //             );
        //           });
        //     },
        //     child: Text('Show Timer')),
        ElevatedButton(
            onPressed: () {
              TaskToFirebase(user: user).uploadExampleData();
            },
            child: Text('Add task data')),
        ElevatedButton(
            onPressed: () {
              TimeService(user: user).addTimeEntry2(
                  addToDate: '03-20-2021', addData: {'testing': 'testing'});
            },
            child: Text('Add time entry')),
        // ElevatedButton(
        //     onPressed: () {
        //       ProjectToFirebase(user: user).uploadExampleData();
        //     },
        //     child: Text('Add project data')),
        // ElevatedButton(
        //     onPressed: () {
        //       ProjectToFirebase(user: user).updateProjectData();
        //     },
        //     child: Text('Update project data')),
        ElevatedButton(
            onPressed: () {
              TimeToFirebase(user: user).uploadExampleData();
            },
            child: Text('Add time data')),
        ElevatedButton(
            onPressed: () {
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .update({
                'firstName': 'Butt',
                'lastName': 'Face',
              });
            },
            child: Text('Update user profile')),
        ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/projectscreen');
            },
            child: Text('show task page')),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(4294937216),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/projectscreen');
            },
            child: Text('testing color')),
        // ElevatedButton(
        //   onPressed: () {
        //     DateTime createDate = DateTime(2021, 03, 24);
        //     for (Task task in tasks) {
        //       FirebaseFirestore.instance
        //         .collection('users')
        //         .doc(user.uid)
        //         .collection('tasks')
        //         .doc(task.taskID)
        //         .update({'createDate': createDate})
        //         .then((value) {
        //           print('${task.taskID} updated with create date: $createDate');
        //           DateTime newDate =
        //               DateTime(createDate.year, createDate.month, createDate.day + 1);
        //           createDate = newDate;
        //           return print('new create date$createDate');
        //       });
        //     }
        //   },
        //   child: Text('Update tasks with create dates'),
        // )
        // ElevatedButton(
        //     onPressed: () {
        //       DateTime newDate = DateTime(2021, 3, 26);
        //       FirebaseFirestore.instance
        //           .collection('users')
        //           .doc(user.uid)
        //           .collection('tasks')
        //           .doc(widget.task.taskID)
        //           .update({'dueDate': newDate});
        //     },
        //     child: Text('update due date without time')),
        ElevatedButton(
            onPressed: () {
              print(tasks);
            },
            child: Text('print task stream')),
      ],
    );
  }
}
