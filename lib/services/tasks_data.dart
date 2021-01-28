import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/models/tasks.dart';
import 'package:productivity_app/models/subtasks.dart';
import 'package:productivity_app/models/tasks.dart';

// class TaskData {
//   List<Tasks> _tasks = [
//     Tasks(taskName: 'test1'),
//     Tasks(taskName: 'test2'),
//     Tasks(taskName: 'test3')
//   ];
//   tasks task;

//   UnmodifiableListView<Tasks> get tasks {
//     return UnmodifiableListView(_tasks);
//   }

//   int get taskCount {
//     return _tasks.length;
//   }

//   void addTask(String newTaskName) {
//     final newTask = Tasks(taskName: newTaskName);
//     if (task != null) {
//       task.taskList.add(newTask);
//     } else {
//       _tasks.add(newTask);
//     }
//     print(taskCount);
//     for (var task in tasks) {
//       print(task.taskName);
//     }
//   }

//   void updateTask(Tasks task, String updateTaskName) {
//     task.taskName = updateTaskName;
//   }

//   void addTime(Tasks task, int time) {
//     task.taskTime += time;
//   }

//   void deleteTask(Tasks task) {
//     _tasks.remove(task);
//   }
// }

class AddTask extends StatelessWidget {
  final String taskName;
  final taskStatus;
  final int taskTime = 0;

  AddTask({this.taskName, this.taskStatus});

  @override
  Widget build(BuildContext context) {
    CollectionReference task = FirebaseFirestore.instance.collection('tasks');

    Future<void> addTask() {
      return task
          .add({
            'taskName': taskName,
            'taskStatus': taskStatus,
            'taskTime': taskTime
          })
          .then((value) => print('Task Added'))
          .catchError((error) => print('Failed to add task: $error'));
    }

    return FlatButton(onPressed: addTask, child: Text('Add Task'));
  }
}

class UpdateTask extends StatelessWidget {
  final String documentReference;
  final String taskName;
  final String taskStatus;
  final int taskTime;

  UpdateTask(
      {this.documentReference, this.taskName, this.taskStatus, this.taskTime});

  @override
  Widget build(BuildContext context) {
    CollectionReference task = FirebaseFirestore.instance.collection('tasks');

    Future<void> updateTask() {
      return task
          .doc(documentReference)
          .update({
            'taskName': taskName,
            'taskStatus': taskStatus,
            'taskTime': taskTime
          })
          .then((value) => print('Task Updated'))
          .catchError((error) => print("Failed to update task: $error"));
    }

    return FlatButton(onPressed: updateTask, child: Text('Update Task'));
  }
}

class DeleteTask extends StatelessWidget {
  final String documentReference;

  DeleteTask({this.documentReference});

  @override
  Widget build(BuildContext context) {
    CollectionReference task = FirebaseFirestore.instance.collection('tasks');

    Future<void> deleteTask() {
      return task
          .doc(documentReference)
          .delete()
          .then((value) => print('Task Deleted'))
          .catchError((error) => print('Failed to delete task: $error'));
    }

    // Future<void> deleteField() {
    //   return task
    //     .doc(documentReference)
    //     .delete()
    //     .then((value) => print('task Deleted'))
    //     .catchError((error) => print('Failed to delete task: $error'));
    // }

    return FlatButton(onPressed: deleteTask, child: Text('Delete Task'));
  }
}

class TaskStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');

    return StreamBuilder<QuerySnapshot>(
        stream: tasks.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading');
          }
          return new ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              return new ListTile(
                title: new Text(document.data()['taskName']),
                subtitle: new Text(document.data()['taskTime'].toString()),
              );
            }).toList(),
          );
        });
  }
}
