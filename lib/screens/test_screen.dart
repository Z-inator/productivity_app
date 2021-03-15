import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
import 'package:productivity_app/test_data/project_to_firebase.dart';
import 'package:productivity_app/test_data/task_to_firebase.dart';
import 'package:productivity_app/test_data/time_to_firebase.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FunctionalityButtonList();
  }
}

class FunctionalityButtonList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
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
        ElevatedButton(
            onPressed: () {
              ProjectToFirebase(user: user).uploadExampleData();
            },
            child: Text('Add project data')),
        ElevatedButton(
            onPressed: () {
              ProjectToFirebase(user: user).updateProjectData();
            },
            child: Text('Update project data')),
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
            return showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return AddTask(
                    user: user,
                  );
                });
          },
          child: Text('Add Task'),
        ),
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
            
      ],
    );
  }
}

class AddTask extends StatefulWidget {
  final User user;
  AddTask({this.user});
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _formKey = GlobalKey<FormState>();
  String _taskName;
  DocumentReference addedTask;
  String _projectName;
  String _projectID;
  List<dynamic> projectNames;
  Map<String, String> taskID;
  DateTime _dueDate;
  TimeOfDay _dueTime;

  @override
  void initState() {
    super.initState();
    _dueDate = DateTime.now();
    _dueTime = TimeOfDay.now();
    getProjectNames();
  }

  Future<void> getProjectNames() async {
    projectNames = await ProjectService(user: widget.user).projects.get().then(
        (snapshot) =>
            snapshot.docs.map((doc) => doc.data()['projectName']).toList());
  }

  selectDate() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _dueDate = picked;
        // year = _dueDate.year.toString();
        // month = _dueDate.month.toString();
        // day = _dueDate.day.toString();
      });
    }
  }

  selectTime() async {
    final TimeOfDay pickedTime =
        await showTimePicker(context: context, initialTime: _dueTime);
    if (pickedTime != null) {
      setState(() {
        _dueTime = pickedTime;
        // hour = _dueTime.hour.toString();
        // minute = _dueTime.minute.toString();
        // _dueDate = DateTime.parse('$year-$month-$day $hour:$minute:00Z');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            validator: (value) =>
                value.isEmpty ? 'Please enter a task name' : null,
            onChanged: (value) => setState(() => _taskName = value),
            decoration: InputDecoration(
                border: OutlineInputBorder(), labelText: 'Task Name'),
          ),
          PopupMenuButton(
              onSelected: (value) {
                setState(() {
                  _projectName = value.toString();
                });
              },
              itemBuilder: (BuildContext context) {
                return projectNames
                    .map((name) => PopupMenuItem(
                        value: name, child: Text(name.toString())))
                    .toList();
              },
              child: Text(_projectName ?? 'Select Project')),
          TextButton(
              onPressed: selectDate,
              child: Text(
                  'Due Date: ${_dueDate.month}/${_dueDate.day}/${_dueDate.year}')),
          TextButton(
              onPressed: selectTime,
              child: Text(
                  'Due Time: ${_dueTime.hour.toString().padLeft(2, '0')}:${_dueTime.minute.toString().padLeft(2, '0')}')),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                _dueDate = DateTime(
                    _dueDate.year,
                    _dueDate.month,
                    _dueDate.day,
                    _dueTime.hour,
                    _dueTime.minute,
                    _dueDate.second,
                    _dueDate.millisecond,
                    _dueDate.microsecond);
                print('$_taskName : $_projectName : ${_dueDate.toString()}');
                addedTask = await TaskService(user: user).addTask(
                    taskName: _taskName,
                    projectName: _projectName,
                    dueDate: _dueDate);
                await ProjectService(user: user)
                    .projects
                    .where('projectName', isEqualTo: _projectName)
                    .get()
                    .then((QuerySnapshot projectSnapshot) => {
                          projectSnapshot.docs.forEach((element) {
                            _projectID = element.id;
                          })
                        });
                taskID = {addedTask.id.toString(): _taskName};
                ProjectService(user: user).updateProject(
                    projectID: _projectID,
                    updateData: {
                      'taskList': taskID
                    }); // TODO: add task to project array list
                Navigator.pop(
                    context); // TODO: change list of task for that project to pop up a modal rather than expansionList - expansion panel is for additional details not a hidden list
              }
            },
            child: Text('Submit'),
          )
        ],
      ),
    );
  }
}
