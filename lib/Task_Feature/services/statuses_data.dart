import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:productivity_app/Task_Feature/models/status.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Task_Feature/services/tasks_data.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StatusService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Collection reference
  CollectionReference _getStatusReference() {
    final User user = _auth.currentUser;
    if (user == null) {
      return null;
    } else {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('statuses');
    }
  }

  CollectionReference get statuses {
    return _getStatusReference();
  }

  // Snapshot Conversion to Status Model and Stream
  Stream<List<Status>> streamStatuses() {
    final CollectionReference ref = _getStatusReference();

    return ref.orderBy('statusOrder', descending: false).snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((queryDocument) => Status.fromFirestore(queryDocument))
            .toList());
  }

  int getTaskCount(BuildContext context, Status status) {
    List<Task> tasks = Provider.of<List<Task>>(context);
    return tasks.length;
  }

  // List<Status> sortStatuses(BuildContext context) {
  //   List<Status> statuses = Provider.of<List<Status>>(context);
  //   statuses.sort((a, b) => a.statusOrder.compareTo(b.statusOrder));
  //   return statuses;
  // }

  // Add Status
  Future<void> addStatus({Map<String, dynamic> addData}) async {
    return _getStatusReference()
        .add(addData)
        .then((value) => print('Status Added'))
        .catchError((error) => print('Failed to add status: $error'));
  }

  // Update Status
  Future<void> updateStatus(
      {String statusID, Map<String, dynamic> updateData}) async {
    return _getStatusReference()
        .doc(statusID)
        .update(updateData)
        .then((value) => print('Status Updated'))
        .catchError((error) => print('Failed to update status: $error'));
  }

  // Delete Status
  Future<void> deleteStatus({String statusID}) async {
    return _getStatusReference()
        .doc(statusID)
        .delete()
        .then((value) => print('Status Deleted'))
        .catchError((error) => print('Failed to delete status: $error'));
  }
}
