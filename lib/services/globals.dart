import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class Global with ChangeNotifier{
  // Data Models

  // User
  final user = FirebaseAuth.instance.currentUser;
  // final String userID = FirebaseAuth.instance.currentUser.uid;
  // Firestore References for writes
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
}
