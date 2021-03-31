import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HabitService {
  final User user;
  HabitService({this.user});

  // Collection reference
  CollectionReference _getHabitReference() {
    if (user == null) {
      return null;
    } else {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('habits');
    }
  }

  CollectionReference get habits {
    return _getHabitReference();
  }

  // Add Habit
  Future<void> addHabit(
      {String habitName,
      int habitOccurence,
      List habitCompletions,
      String habitColor}) async {
    return _getHabitReference()
        .add({
          'habitName': habitName,
          'habitOccurence': habitOccurence,
          'habitCompletions': habitCompletions,
          'habitColor': habitColor
        })
        .then((value) => print('Habit Added'))
        .catchError((error) => print('Failed to add habit: $error'));
  }

  // Update Habit
  Future<void> updateHabit({String habitID, Map updateData}) async {
    return _getHabitReference()
        .doc(habitID)
        .update(Map<String, dynamic>.from(updateData))
        .then((value) => print('Habit Updated'))
        .catchError((error) => print('Failed to update habit: $error'));
  }

  // Delete Habit
  Future<void> deleteHabit({String habitID}) async {
    return _getHabitReference()
        .doc(habitID)
        .delete()
        .then((value) => print('Habit Deleted'))
        .catchError((error) => print('Failed to delete habit: $error'));
  }
}
