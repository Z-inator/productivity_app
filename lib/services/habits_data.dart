import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/services/globals.dart';

class HabitService {
  // Collection reference
  final CollectionReference habitsReference = FirebaseFirestore.instance
      .collection('users')
      .doc(Global().userID)
      .collection('habits');

  // Add Habit
  Future<void> addHabit(String habitName, String habitColor) async {
    return await habitsReference
        .add({'habitName': habitName, })
        .then((value) => print('Habit Added'))
        .catchError((error) => print('Failed to add habit: $error'));
  }

  // Update Habit
  Future<void> updateHabit(
      String habitID, String habitName, ) async {
    return await habitsReference
        .doc(habitID)
        .set({'habitName': habitName, });
  }

  // Delete Habit
  Future<void> deleteHabit(String habitID) async {
    return habitsReference
        .doc(habitID)
        .delete()
        .then((value) => print('Habit Deleted'))
        .catchError((error) => print('Failed to delete habit: $error'));
  }

  // Habit Collections Stream
  Stream<QuerySnapshot> get habitsCollection {
    return habitsReference.snapshots();
  }
}