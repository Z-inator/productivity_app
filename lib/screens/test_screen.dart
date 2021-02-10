import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/components/task_page/task_list.dart';
import 'package:productivity_app/services/authentification.dart';
import 'package:productivity_app/services/database.dart';
import 'package:productivity_app/models/projects.dart';
import 'package:productivity_app/services/projects_data.dart';
import 'package:productivity_app/services/tasks_data.dart';
import 'package:productivity_app/services/timer.dart';
import 'package:productivity_app/services/times_data.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return RaisedButton(
          onPressed: () {
            AuthService().signInWithEmailAndPassword(
                'someone@gmail.com', 'testing123456');
          },
          child: Text('Sign In'));
    }
    return TestScreen();
  }
}

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Container(
        child: SafeArea(
            child: Scaffold(
      body: Column(
        children: [
          RaisedButton(
              onPressed: () {
                AuthService().signInWithEmailAndPassword(
                    'someone@gmail.com', 'testing123456');
              },
              child: Text('Sign In')),
          RaisedButton(
              onPressed: () {
                AuthService()
                    .signOut()
                    .then((value) => print(FirebaseAuth.instance.currentUser));
              },
              child: Text('Sign Out')),
          RaisedButton(
              onPressed: () {
                TaskService(user: user).addTask(
                    taskName: 'taskName$counter',
                    dueDate: DateTime.utc(2021, 02, 12),
                    projectName: 'testingProject4');
                counter += 1;
              },
              child: Text('Add Task')),
          RaisedButton(
              onPressed: () {
                print(user.uid);
                return showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return TasksStream(
                        user: user,
                      );
                    });
              },
              child: Text('Show Tasks')),
          RaisedButton(
              onPressed: () {
                print(user.uid);
                return showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return TimerWidget(
                        user: user,
                      );
                    });
              },
              child: Text('Show Timer')),
          RaisedButton(
              onPressed: () {
                print(user.uid);
                return showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return TimeEntryStream(user: user);
                    });
              },
              child: Text('Show Time Entries')),
        ],
      ),
    )));
  }
}
