import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/services/globals.dart';

class TaskService {
  // Collection reference
  CollectionReference _getTaskReference() {
    if (Global().user == null) {
      return null;
    } else {
      return FirebaseFirestore.instance
          .collection(Global().userCollection.toString())
          .doc(Global().user.uid)
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
  Future<void> updateTask(
      {String taskID,
      String taskName,
      String status,
      DateTime dueDate,
      String projectName}) async {
    return await _getTaskReference().doc(taskID).update({
      'taskName': taskName,
      'status': status,
      'dueDate': dueDate,
      'projectName': projectName
    });
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
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: TaskService().tasks.snapshots(),
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
                    TaskService().updateTask(
                        taskID: docID, taskName: 'NewTaskNameUpdate');
                  }),
              title: Text(document.data()['taskName']),
              trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    TaskService().deleteTask(taskID: docID);
                  }),
            );
          }).toList(),
        );
      },
    );
  }
}

class TasksTestStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: TaskService().tasks.where('projectName', isEqualTo: 'testingProject').snapshots(),
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

// class AddTask extends StatelessWidget {
//   final String taskName;
//   final taskStatus;
//   final int taskTime = 0;

//   AddTask({this.taskName, this.taskStatus});

//   @override
//   Widget build(BuildContext context) {
//     CollectionReference task = FirebaseFirestore.instance.collection('tasks');

//     Future<void> addTask() {
//       return task
//           .add({
//             'taskName': taskName,
//             'taskStatus': taskStatus,
//             'taskTime': taskTime
//           })
//           .then((value) => print('Task Added'))
//           .catchError((error) => print('Failed to add task: $error'));
//     }

//     return FlatButton(onPressed: addTask, child: Text('Add Task'));
//   }
// }

// class UpdateTask extends StatelessWidget {
//   final String documentReference;
//   final String taskName;
//   final String taskStatus;
//   final int taskTime;

//   UpdateTask(
//       {this.documentReference, this.taskName, this.taskStatus, this.taskTime});

//   @override
//   Widget build(BuildContext context) {
//     CollectionReference task = FirebaseFirestore.instance.collection('tasks');

//     Future<void> updateTask() {
//       return task
//           .doc(documentReference)
//           .update({
//             'taskName': taskName,
//             'taskStatus': taskStatus,
//             'taskTime': taskTime
//           })
//           .then((value) => print('Task Updated'))
//           .catchError((error) => print("Failed to update task: $error"));
//     }

//     return FlatButton(onPressed: updateTask, child: Text('Update Task'));
//   }
// }

// class DeleteTask extends StatelessWidget {
//   final String documentReference;

//   DeleteTask({this.documentReference});

//   @override
//   Widget build(BuildContext context) {
//     CollectionReference task = FirebaseFirestore.instance.collection('tasks');

//     Future<void> deleteTask() {
//       return task
//           .doc(documentReference)
//           .delete()
//           .then((value) => print('Task Deleted'))
//           .catchError((error) => print('Failed to delete task: $error'));
//     }

//     // Future<void> deleteField() {
//     //   return task
//     //     .doc(documentReference)
//     //     .delete()
//     //     .then((value) => print('task Deleted'))
//     //     .catchError((error) => print('Failed to delete task: $error'));
//     // }

//     return FlatButton(onPressed: deleteTask, child: Text('Delete Task'));
//   }
// }

// class TaskStream extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');

//     return StreamBuilder<QuerySnapshot>(
//         stream: tasks.snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasError) {
//             return Text('Something went wrong');
//           }
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Text('Loading');
//           }
//           return new ListView(
//             children: snapshot.data.docs.map((DocumentSnapshot document) {
//               return new ListTile(
//                 title: new Text(document.data()['taskName']),
//                 subtitle: new Text(document.data()['taskTime'].toString()),
//               );
//             }).toList(),
//           );
//         });
//   }
// }
