import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserModel {
  String displayName;
  String userID;

  UserModel({this.userID, this.displayName});

  factory UserModel.fromFirestore(User user) {
    return UserModel(userID: user.uid, displayName: user.displayName);
  }
}
