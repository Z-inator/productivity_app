import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart'rt';
import 'package:productivity_app/Task_Feature/models/status.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:provider/provider.dart';

class TaskService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Collection reference
  CollectionReference _getTaskReference() {
    final User user = _auth.currentUser;
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

  // Snapshot Conversion to Task Model and Stream
  Stream<List<Task>> streamTasks(List<Project> projects, List<Status> statuses) {
    var ref = _getTaskReference();
    return ref.snapshots().map((querySnapshot) => querySnapshot.docs
        .map((queryDocument) => Task.fromFirestore(queryDocument, projects, statuses))
        .toList());
  }

  // Add Task
  Future<DocumentReference> addTask(
      {String taskName,
      String status = 'To Do',
      int taskTime = 0,
      DateTime dueDate,
      String projectName,
      DateTime createDate}) async {
    return _getTaskReference().add({
      'taskName': taskName,
      'status': status,
      'taskTime': taskTime,
      'dueDate': dueDate,
      'projectName': projectName,
      'createDate': createDate
    }).catchError((error) => print('Failed to add task: $error'));
    // .then((value) => print('Task Added'))   // TODO: look at returning the added document reference to insert as key into project update method's task
  }

  // Update Task
  Future<void> updateTask({String taskID, Map updateData}) async {
    return _getTaskReference()
        .doc(taskID)
        .update(Map<String, dynamic>.from(updateData))
        .then((value) => print('Task Updated'))
        .catchError((error) => print('Failed to update task: $error'));
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

// class TasksStream extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     final User user = Provider.of<User>(context);
//     return Scaffold(
//       bottomNavigationBar: AnimatedContainer(
//         duration: Duration(milliseconds: 600),
//         height: 60,
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: TaskService(user: user).tasks.snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasError) {
//             return Text('Something went wrong');
//           }
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Text('Loading');
//           }
//           return ListView(
//             children: snapshot.data.docs.map((DocumentSnapshot document) {
//               final String docID = document.id;
//               print(document.id);
//               return ListTile(
//                 leading: IconButton(icon: Icon(Icons.plus_one), onPressed: () {}),
//                 title: Text(document.data()['taskName'].toString()),
//                 subtitle: Text(document.data()['projectName'].toString()),
//                 trailing: IconButton(icon: Icon(Icons.delete), onPressed: () {}),
//               );
//             }).toList(),
//           );
//         },
//       ),
//     );
//   }
// }

// class TasksTestStream extends StatelessWidget {
//   final User user;
//   TasksTestStream({this.user});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: TaskService(user: user)
//           .tasks
//           .where('projectName', isEqualTo: 'testingProject4')
//           .snapshots(),
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Text('Something went wrong');
//         }
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Text('Loading');
//         }
//         return Container(
//           height: 300,
//           width: 300,
//           child: ListView(
//             shrinkWrap: true,
//             children: snapshot.data.docs.map((DocumentSnapshot document) {
//               final String docID = document.id;
//               print(document.id);
//               return ListTile(
//                 leading: IconButton(
//                     icon: Icon(Icons.plus_one),
//                     onPressed: () {
//                       TaskService().updateTask(updateData: {
//                         'taskID': docID,
//                         'taskName': 'NewTaskNameUpdate'
//                       });
//                     }),
//                 title: Text(document.data()['taskName'].toString()),
//                 subtitle: Text(document.data()['projectName'].toString()),
//                 trailing: IconButton(
//                     icon: Icon(Icons.delete),
//                     onPressed: () {
//                       TaskService().deleteTask(taskID: docID);
//                     }),
//               );
//             }).toList(),
//           ),
//         );
//       },
//     );
//   }
// }

// RaisedButton(
// onPressed: () {
//   TaskService(user: user).addTask(
//       taskName: 'taskName$counter',
//       dueDate: DateTime.utc(2021, 02, 12),
//       projectName: 'testingProject4');
//   counter += 1;
// },
// child: Text('Add Task')),
