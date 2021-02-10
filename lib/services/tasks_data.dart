import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TaskService {
  final user;
  TaskService({this.user});

  // Collection reference
  CollectionReference _getTaskReference() {
    if (user == null) {
      return null;
    } else {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('tasks');
    }
  }

  CollectionReference get tasks {
    return _getTaskReference();
  }

  // Add Task
  Future<void> addTask(
      {String taskName,
      String status = 'To Do',
      int taskTime = 0,
      DateTime dueDate,
      String projectName}) async {
    return await _getTaskReference()
        .add({
          'taskName': taskName,
          'status': status,
          'taskTime': taskTime,
          'dueDate': dueDate,
          'projectName': projectName
        })
        .then((value) => print('Task Added'))
        .catchError((error) => print('Failed to add task: $error'));
  }

  // Update Task
  Future<void> updateTask({Map updateData}) async {
    return await _getTaskReference()
        .doc(updateData['taskID'])
        .update(Map<String, dynamic>.from(updateData));
  }

  // Delete Task
  Future<void> deleteTask({String taskID}) async {
    return _getTaskReference()
        .doc(taskID)
        .delete()
        .then((value) => print('Task Deleted'))
        .catchError((error) => print('Failed to delete task: $error'));
  }
}

class TasksStream extends StatelessWidget {
  final user;
  TasksStream({this.user});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: TaskService(user: user).tasks.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading');
        }
        return ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            final String docID = document.id;
            print(document.id);
            return ListTile(
              leading: IconButton(
                  icon: Icon(Icons.plus_one),
                  onPressed: () {
                    TaskService(user: user).updateTask(
                        {'taskID': docID, 'taskName': 'NewTaskNameUpdate'});
                  }),
              title: Text(document.data()['taskName']),
              subtitle: Text(document.data()['projectName']),
              trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    TaskService(user: user).deleteTask(taskID: docID);
                  }),
            );
          }).toList(),
        );
      },
    );
  }
}

class TasksTestStream extends StatelessWidget {
  final user;
  TasksTestStream({this.user});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: TaskService(user: user)
          .tasks
          .where('projectName', isEqualTo: 'testingProject4')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading');
        }
        return Container(
          height: 300,
          width: 300,
          child: ListView(
            shrinkWrap: true,
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              final String docID = document.id;
              print(document.id);
              return ListTile(
                leading: IconButton(
                    icon: Icon(Icons.plus_one),
                    onPressed: () {
                      TaskService().updateTask(
                          taskID: docID, taskName: 'NewTaskNameUpdate');
                    }),
                title: Text(document.data()['taskName']),
                subtitle: Text(document.data()['projectName']),
                trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      TaskService().deleteTask(taskID: docID);
                    }),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

// RaisedButton(
// onPressed: () {
//   TaskService(user: user).addTask(
//       taskName: 'taskName$counter',
//       dueDate: DateTime.utc(2021, 02, 12),
//       projectName: 'testingProject4');
//   counter += 1;
// },
// child: Text('Add Task')),
