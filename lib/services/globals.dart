import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Global {
  // Data Models

  // User
  final String userID = FirebaseAuth.instance.currentUser.uid;
  final user = FirebaseAuth.instance.currentUser;
  // Firestore References for writes
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
}
