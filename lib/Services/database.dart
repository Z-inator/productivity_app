import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/status.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';

class DatabaseService {
  final User _user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore instance = FirebaseFirestore.instance;

  // Collection reference
  final CollectionReference rootCollection =
      FirebaseFirestore.instance.collection('users');

  // Build new user collections
  Future<void> buildNewUser() async {
    final DocumentReference userDocument = rootCollection.doc(_user.uid);
    WriteBatch batch = FirebaseFirestore.instance.batch();

    final List<Status> statuses = [
      Status(
          statusName: 'To Do',
          statusColor: 4287954944,
          statusOrder: 1,
          equalToComplete: false,
          statusDescription:
              'This status represents tasks that have not been started.'),
      Status(
          statusName: 'In Progress',
          statusColor: 4278241363,
          statusOrder: 2,
          equalToComplete: false,
          statusDescription:
              'This status represents tasks that have been started but not completed.'),
      Status(
          statusName: 'Review',
          statusColor: 4294917376,
          statusOrder: 3,
          equalToComplete: false,
          statusDescription:
              'This status represents tasks that have been completed.'),
      Status(
          statusName: 'Done',
          statusColor: 4279828479,
          statusOrder: 4,
          equalToComplete: true,
          statusDescription:
              'This status represents tasks that have been completed.')
    ];
    statuses.forEach((status) {
      batch.set(
          userDocument.collection('statuses').doc(), status.toFirestore());
    });
  }

  // Add item to Firestore
  Future<void> addItem({String type, Map<String, dynamic> addData}) async {
    return rootCollection
        .doc(_user.uid)
        .collection(type)
        .add(addData)
        .then((value) => print('$type Added'))
        .catchError((error) => print('Failed to add $type: $error'));
  }

  // Update item in Firestore
  Future<void> updateItem({
      String type, String itemID, Map<String, dynamic> updateData}) async {
    return rootCollection
        .doc(_user.uid)
        .collection(type)
        .doc(itemID)
        .update(updateData)
        .then((value) => print('$type Added'))
        .catchError((error) => print('Failed to add $type: $error'));
  }

  // Update batch items in Firestore
  Future<void> updateBatchItems(String type, List<dynamic> itemsToUpdate) {
    WriteBatch batch = instance.batch();
    for (dynamic item in itemsToUpdate) {
      DocumentReference documentReference = rootCollection
          .doc(_user.uid)
          .collection(type)
          .doc(item.id.toString());
      Map<String, dynamic> mapOfItem = item.toFirestore();
      batch.update(documentReference, mapOfItem);
    }
    return batch
        .commit()
        .then((value) => print('Batch Update Complete'))
        .catchError((error) => print('Failes Batch Update: $error'));
  }

  // Delete item out of Firestore
  Future<void> deleteItem({String type, String itemID}) async {
    return rootCollection
        .doc(_user.uid)
        .collection(type)
        .doc(itemID)
        .delete()
        .then((value) => print('$type Added'))
        .catchError((error) => print('Failed to add $type: $error'));
  }
}
