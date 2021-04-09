import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubtaskService {
  final User user;
  SubtaskService({this.user});

  // Collection reference
  CollectionReference _getSubtaskReference() {
    if (user == null) {
      return null;
    } else {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('subtasks');
    }
  }

  CollectionReference get subtasks {
    return _getSubtaskReference();
  }

  // Add Subtask
  Future<void> addSubtask(
      {String subtaskName, bool isDone = false, String taskName}) async {
    return _getSubtaskReference()
        .add({
          'subtaskName': subtaskName,
          'isDone': isDone,
          'taskName': taskName
        })
        .then((value) => print('Subtask Added'))
        .catchError((error) => print('Failed to add subtask: $error'));
  }

  // Update Subtask
  Future<void> updateSubtask({String subtaskID, Map updateData}) async {
    return _getSubtaskReference()
        .doc(subtaskID)
        .update(Map<String, dynamic>.from(updateData))
        .then((value) => print('Subtask Updated'))
        .catchError((error) => print('Failed to update subtask: $error'));
  }

  // Delete Subtask
  Future<void> deleteSubtask({String subtaskID}) async {
    return _getSubtaskReference()
        .doc(subtaskID)
        .delete()
        .then((value) => print('Subtask Deleted'))
        .catchError((error) => print('Failed to delete subtask: $error'));
  }
}

class SubtaskStream extends StatelessWidget {
  final User user;
  const SubtaskStream({this.user});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: SubtaskService().subtasks.snapshots(),
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
                    SubtaskService().updateSubtask(
                      subtaskID: docID, updateData: {
                        'subtaskName': 'NewSubtaskNameUpdate',
                        'isDone': true
                      });
                  }),
              title: Text(document.data()['SubtaskName'].toString()),
              trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    SubtaskService().deleteSubtask(subtaskID: docID);
                  }),
            );
          }).toList(),
        );
      },
    );
  }
}
