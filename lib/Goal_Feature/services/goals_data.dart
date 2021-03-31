import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GoalService {
  final User user;
  GoalService({this.user});

  // Collection reference
  CollectionReference _getGoalReference() {
    if (user == null) {
      return null;
    } else {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('goals');
    }
  }

  CollectionReference get goals {
    return _getGoalReference();
  }

  // Add Goal
  Future<void> addGoal(
      {String goalName,
      int goalOccurence,
      List goalCompletions,
      String goalColor}) async {
    return _getGoalReference()
        .add({
          'GoalName': goalName,
          'GoalOccurence': goalOccurence,
          'GoalCompletions': goalCompletions,
          'GoalColor': goalColor
        })
        .then((value) => print('Goal Added'))
        .catchError((error) => print('Failed to add Goal: $error'));
  }

  // Update Goal
  Future<void> updateGoal({String goalID, Map updateData}) async {
    return _getGoalReference()
        .doc(goalID)
        .update(Map<String, dynamic>.from(updateData))
        .then((value) => print('Goal Updated'))
        .catchError((error) => print('Failed to update Goal: $error'));
  }

  // Delete Goal
  Future<void> deleteGoal({String goalID}) async {
    return _getGoalReference()
        .doc(goalID)
        .delete()
        .then((value) => print('Goal Deleted'))
        .catchError((error) => print('Failed to delete Goal: $error'));
  }
}
