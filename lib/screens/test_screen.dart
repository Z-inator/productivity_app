import 'dart:math';

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
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);

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
          //   getProjectNames();
          //   print(projectNames);
          //   return showDialog(
          //       context: context,
          //       builder: (BuildContext context) {
          //         return AlertDialog(
          //           title: Text('Add Task'),
          //           content: Form(
          //             key: _formKey,
          //             child: Column(
          //               children: <Widget>[
          //                 TextFormField(
          //                   validator: (value) => value.isEmpty
          //                       ? 'Please enter a task name'
          //                       : null,
          //                   onChanged: (value) =>
          //                       setState(() => _taskName = value),
          //                   decoration: InputDecoration(
          //                       border: OutlineInputBorder(),
          //                       labelText: 'Task Name'),
          //                 ),
          //                 PopupMenuButton(onSelected: (value) {
          //                   setState(() {
          //                     _projectName = value;
          //                   });
          //                 }, itemBuilder: (BuildContext context) {
          //                   return projectNames
          //                       .map((name) => PopupMenuItem(
          //                           value: name, child: Text(name)))
          //                       .toList();
          //                 }),
          //                 // DropdownButtonFormField(
          //                 //   value: _projectName,
          //                 //   decoration: InputDecoration(
          //                 //     border: OutlineInputBorder(),
          //                 //     labelText: 'Project'
          //                 //   ),
          //                 //   items: projectNames.forEach((name) {
          //                 //     return DropdownMenuItem(
          //                 //       value: name,
          //                 //       child: Text(name),
          //                 //     );
          //                 //   }),
          //                 //   onChanged: (value) => setState(() => _projectName = value),
          //                 // ),
          //                 TextButton(
          //                     onPressed: selectDate,
          //                     child: Text(
          //                         'Due Date: ${_dueDate.month}/${_dueDate.day}/${_dueDate.year}')),
          //                 ListTile(
          //                   title: Text(
          //                       'Due Date: ${_dueDate.month}/${_dueDate.day}/${_dueDate.year}'),
          //                   trailing: Icon(Icons.keyboard_arrow_down),
          //                   onTap: selectDate,
          //                 ),
          //                 TextButton(
          //                     onPressed: selectTime,
          //                     child: Text(
          //                         'Due Time: ${_dueDate.hour}:${_dueDate.minute}')),
          //                 ListTile(
          //                   title: Text(
          //                       'Due Time: ${_dueDate.hour}:${_dueDate.minute}'),
          //                   trailing: Icon(Icons.keyboard_arrow_down),
          //                   onTap: selectTime,
          //                 ),
          //               ],
          //             ),
          //           ),
          //           actions: [
          //             TextButton(
          //                 onPressed: () {
          //                   Navigator.pop(context);
          //                 },
          //                 child: Text('close')),
          //             TextButton(
          //                 onPressed: () => print(_dueDate.toString()),
          //                 // onPressed: () => TaskService(user: user).addTask(
          //                 //     taskName: _taskName,
          //                 //     projectName: _projectName,
          //                 //     dueDate: _dueDate),
          //                 child: Text('Submit'))
          //           ],
          //         );
          //       });
          // },
          // child: Text('Add Task')),
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

class AddTask extends StatefulWidget {
  final User user;
  AddTask({this.user});
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _formKey = GlobalKey<FormState>();
  String _taskName;
  String _projectName;
  List<dynamic> projectNames;
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
    print(projectNames);
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
                .map(
                    (name) => PopupMenuItem(value: name, child: Text(name.toString())))
                .toList();
            },
            child: Text(_projectName ?? 'Select Project')
          ),
          TextButton(
              onPressed: selectDate,
              child: Text(
                  'Due Date: ${_dueDate.month}/${_dueDate.day}/${_dueDate.year}')),
          TextButton(
              onPressed: selectTime,
              child: Text('Due Time: ${_dueTime.hour.toString().padLeft(2, '0')}:${_dueTime.minute.toString().padLeft(2, '0')}')),
          RaisedButton(
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
                print(
                    '$_taskName : $_projectName : ${_dueDate.toString()}');
                Navigator.pop(context);
              }
            },
            child: Text('Submit'),
          )
        ],
      ),
    );
  }
}
