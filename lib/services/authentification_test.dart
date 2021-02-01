import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

// Future<User> createUserWithEmailPassword(
//     {String firstName, String lastname, String email, String password}) async {
//   try {
//     UserCredential userCredential = await FirebaseAuth.instance
//         .createUserWithEmailAndPassword(email: 'email', password: 'password');
//   } on FirebaseAuthException catch (e) {
//     if (e.code == 'weak-password') {
//       print('The pasword provided is too weak');
//     } else if (e.code == 'email-already-in-use') {
//       print('The account already exists for that email.');
//     }
//   } catch (e) {
//     print(e);
//   }
// }

// Future<User> signInWithEmailPassword({String email, String password}) async {
//   try {
//     UserCredential userCredential = await FirebaseAuth.instance
//         .signInWithEmailAndPassword(email: email, password: password);
//   } on FirebaseAuthException catch (e) {
//     if (e.code == 'user-not-found') {
//       print('No user found for that email');
//     } else if (e.code == 'wrong-password') {
//       print('Wrong password provided for that user');
//     }
//   }
// }

// Future<User> signOut() async {
//   await FirebaseAuth.instance.signOut();
// }

// Future<UserCredential> signInWithGoogle() async {
//   final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
//   final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//   final GoogleAuthCredential credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
//   return await FirebaseAuth.instance.signInWithCredential(credential);
// }

