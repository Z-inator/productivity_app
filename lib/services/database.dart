import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:productivity_app/models/projects.dart';

class DatabaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  // Build new user collections
  Future<void> buildUser(
      {String uid, String firstName, String lastName}) async {
    await userCollection.doc(uid).set({
      'firstName': firstName,
      'lastName': lastName,
    });
    List<String> statuses = ['To Do', 'In Progress', 'Done', 'Archived'];
    List<int> statusColors = [4287954944, 4280902399, 4278241363, 4285887861];
    int counter = 0;
    statuses.map((status) async {
      await userCollection.doc(uid).collection('statuses').doc().set({
        'statusName': status,
        'statusColor': statusColors.elementAt(counter)
      });
      counter += 1;
    });
  }
}

// // Reduce repetition method for items
// Future<void> addItem(Map data, String type) async {
//   return await userCollection
//       .doc(uid)
//       .collection(type)
//       .add(data)
//       .then((value) => print('$type Added'))
//       .catchError((error) => print('Failed to add $type: $error'));
// }
