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
  final _formKey = GlobalKey<FormState>();
  String _taskName;
  String _projectName;
  DateTime _dueDate;
  String _setDate;
  String _setTime;
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  List<dynamic> projectNames;

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    Future<void> getProjectNames() async {
      projectNames = await ProjectService(user: user).projects.get().then(
          (snapshot) =>
              snapshot.docs.map((doc) => doc.data()['projectName']).toList());
    }

    Future<void> selectDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2020),
        lastDate: DateTime(2021),
      );
      if (picked != null) {
        setState(() {
          _setDate = picked.toString();
        });
      }
    }

    Future<void> selectTime(BuildContext context) async {
      final TimeOfDay picked =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());
      if (picked != null) {
        setState(() {
          _setTime = picked.toString();
        });
      }
    }

    return Container(
        child: SafeArea(
            child: Scaffold(
      body: Column(
        children: [
          RaisedButton(
              onPressed: () {
                AuthService()
                    .signOut()
                    .then((value) => print(FirebaseAuth.instance.currentUser));
              },
              child: Text('Sign Out')),
          RaisedButton(
              onPressed: () {
                getProjectNames();
                print(projectNames);
                return showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Add Task'),
                        content: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                validator: (value) => value.isEmpty
                                    ? 'Please enter a task name'
                                    : null,
                                onChanged: (value) =>
                                    setState(() => _taskName = value),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Task Name'),
                              ),
                              PopupMenuButton(onSelected: (value) {
                                setState(() {
                                  _projectName = value;
                                });
                              }, itemBuilder: (BuildContext context) {
                                return projectNames
                                    .map((name) => PopupMenuItem(
                                        value: name, child: Text(name)))
                                    .toList();
                              }),
                              // DropdownButtonFormField(
                              //   value: _projectName,
                              //   decoration: InputDecoration(
                              //     border: OutlineInputBorder(),
                              //     labelText: 'Project'
                              //   ),
                              //   items: projectNames.forEach((name) {
                              //     return DropdownMenuItem(
                              //       value: name,
                              //       child: Text(name),
                              //     );
                              //   }),
                              //   onChanged: (value) => setState(() => _projectName = value),
                              // ),
                              TextFormField(
                                onTap: () {
                                  selectDate(context);
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Due Date'),
                              ),
                              TextFormField(
                                onTap: () {
                                  selectTime(context);
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Due Time'),
                              )
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('close'))
                        ],
                      );
                    }
                );
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
                      return ProjectsStream(
                        user: user,
                      );
                    });
              },
              child: Text('Show Projects')),
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
        ],
      ),
    )));
  }
}
