import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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


class Authentification with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User> getUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        print('User signed in: ${user.email}');
      } else {
        print('User is currently signed out.');
      }
      notifyListeners();
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future signout() async {
    var result = await FirebaseAuth.instance.signOut();
    print('Signing out User.');
    notifyListeners();
    return result;
  }

  Future<User> registerUserWithEmailAndPassword(
      {String firstName,
      String lastName,
      String email,
      String password}) async {
    var userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    var newUser = userCredential.user;

    String newDisplayName = '$firstName $lastName';

    await newUser
        .updateProfile(displayName: newDisplayName)
        .catchError((error) => print(error));

    await newUser.reload();

    User updatedUser = FirebaseAuth.instance.currentUser;

    print('new display name: ${updatedUser.displayName}');

    notifyListeners();

    return updatedUser;
  }

  Future<User> signInUserWithEmailAndPassword(
      {String email, String password}) async {
    try {
      var result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      notifyListeners();
    } catch (firebaseAuthException) {
      throw new FirebaseAuthException(
          message: firebaseAuthException.message,
          code: firebaseAuthException.code);
    }
  }

  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    final User user = (await _auth.signInWithCredential(credential)).user;
    print('Successfully signed in user with Google Provider');
    print('Name: ${user.displayName} | uID; ${user.uid}');

    notifyListeners();

    User firebaseUser = FirebaseAuth.instance.currentUser;

    return firebaseUser;
  }
}
