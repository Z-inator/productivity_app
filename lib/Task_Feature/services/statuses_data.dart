import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../Task_Feature/Task_Feature.dart';

class StatusService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Collection reference
  CollectionReference? _getStatusReference() {
    final User? user = _auth.currentUser;
    if (user == null) {
      return null;
    } else {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('statuses');
    }
  }

  CollectionReference? get statuses {
    return _getStatusReference();
  }

  // Snapshot Conversion to Status Model and Stream
  Stream<List<Status>> streamStatuses() {
    final CollectionReference ref = _getStatusReference()!;

    return ref.orderBy('statusOrder', descending: false).snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((queryDocument) => Status.fromFirestore(queryDocument))
            .toList());
  }

  int getTaskCount(List<Task> tasks, Status status) {
    return tasks.length;
  }

  // // Add Status
  // Future<void> addStatus({Map<String, dynamic> addData}) async {
  //   return _getStatusReference()
  //       .add(addData)
  //       .then((value) => print('Status Added'))
  //       .catchError((error) => print('Failed to add status: $error'));
  // }

  // // Update Status
  // Future<void> updateStatus(
  //     {String statusID, Map<String, dynamic> updateData}) async {
  //   return _getStatusReference()
  //       .doc(statusID)
  //       .update(updateData)
  //       .then((value) => print('Status Updated'))
  //       .catchError((error) => print('Failed to update status: $error'));
  // }

  // // Delete Status
  // Future<void> deleteStatus({String statusID}) async {
  //   return _getStatusReference()
  //       .doc(statusID)
  //       .delete()
  //       .then((value) => print('Status Deleted'))
  //       .catchError((error) => print('Failed to delete status: $error'));
  // }
}
