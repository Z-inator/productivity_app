import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/components/task_page/task_list.dart';
import 'package:productivity_app/services/authentification.dart';
import 'package:productivity_app/services/database.dart';
import 'package:productivity_app/models/projects.dart';
import 'package:productivity_app/services/projects_data.dart';
import 'package:productivity_app/services/tasks_data.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:productivity_app/services/globals.dart';

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
  double _bodyHeight = 0.0;

  @override
  Widget build(BuildContext context) {
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
                TaskService().addTask(
                    taskName: 'taskName$counter',
                    dueDate: DateTime.now(),
                    projectName: 'testingProject4');
                counter += 1;
              },
              child: Text('Add Task')),
          RaisedButton(
              onPressed: () {
                return showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      // CollectionReference projects = FirebaseFirestore.instance
                      //     .collection('users')
                      //     .doc(user.uid)
                      //     .collection('projects');
                      return TasksStream();
                    });
              },
              child: Text('Show Tasks')),
          Card(
            child: new Container(
              height: 50.0,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new IconButton(
                    icon: new Icon(Icons.keyboard_arrow_down),
                    onPressed: () {
                      setState(() {
                        this._bodyHeight = 300.0;
                      });
                    },
                  )
                ],
              ),
            ),
          ),
          Card(
            child: new AnimatedContainer(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(children: [TasksTestStream()]),
                  new IconButton(
                    icon: new Icon(Icons.keyboard_arrow_up),
                    onPressed: () {
                      setState(() {
                        this._bodyHeight = 0.0;
                      });
                    },
                  ),
                ],
              ),
              curve: Curves.easeInOut,
              duration: const Duration(milliseconds: 500),
              height: _bodyHeight,
              // color: Colors.red,
            ),
          ),
        ],
      ),
    )));
  }
}
