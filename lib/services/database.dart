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
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'statuses': {'toDo': 'To Do', 'inProgress': 'In Progress', 'done': 'Done'}
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
