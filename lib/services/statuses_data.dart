import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:productivity_app/services/tasks_data.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StatusService {
  final User user;
  StatusService({this.user});

  // Collection reference
  CollectionReference _getStatusReference() {
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

  // Add Status
  Future<void> addStatus(
      {String statusName, int statusColor, int statusTime = 0}) async {
    return _getStatusReference()
        .add({
          'StatusName': statusName,
          'StatusColor': statusColor,
          'StatusTime': statusTime,
          'taskList': {}
        })
        .then((value) => print('Status Added'))
        .catchError((error) => print('Failed to add status: $error'));
  }

  // Update Status
  Future<void> updateStatus({String statusID, Map updateData}) async {
    return _getStatusReference()
        .doc(statusID)
        .update(Map<String, dynamic>.from(updateData))
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


