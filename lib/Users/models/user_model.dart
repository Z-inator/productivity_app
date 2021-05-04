import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserModel {
  String displayName;
  String email;
  String userID;

  UserModel({this.userID, this.email, this.displayName});

  factory UserModel.fromFirestore(User user) {
    return UserModel(
      userID: user.uid, 
      email: user.email,
      displayName: user.displayName);
  }
}
