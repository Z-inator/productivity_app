import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  User get user {
    return _auth.currentUser;
  }

  // Authentification change user stream
  Stream<User> get onAuthStateChanged {
    return _auth.authStateChanges().map((user) {
      return user == null ? null : user;
    });
  }

  // Get user reference
  DocumentReference getUserReference(String userID) {
    final User user = _auth.currentUser;
    if (user == null) {
      return null;
    } else {
      return FirebaseFirestore.instance.collection('users').doc(userID);
    }
  }

  String passwordValidation(String password) {
    int passwordMinLength = 8;
    if (password == null || password.isEmpty) {
      return 'Please enter your password';
    } else if (!password.contains(RegExp(r'[A-Z]'))) {
      return 'Please include an uppercase letter';
    } else if (!password.contains(RegExp(r'[a-z]'))) {
      return 'Please include a lowercase letter';
    } else if (!password.contains(RegExp(r'[0-9]'))) {
      return 'Please include a number';
    } else if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Please include a special character';
    } else if (password.length < passwordMinLength) {
      return 'Password does not meet length requirements';
    }
    return null;
  }

  // Sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential != null) {}
    } on FirebaseAuthException catch (errorrror) {
      if (errorrror.code == 'user-not-found') {
        return 'User not found';
      } else if (errorrror.code == 'wrong-password') {
        return 'Wrong password provided';
      }
    }
  }

  // Register with email and password
  Future registerWithEmailAndPassword(
      String email, String password, String displayName) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (error) {
      if (error.code == 'weak-password') {
        return 'Password is too weak';
      } else if (error.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (error) {
      return error.toString();
    }
    try {
      await user.updateProfile(displayName: displayName);
    } catch (error) {
      return error.toString();
    }
  }

  // Sign in with Google
  Future googleSignIn() async {
    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();
      try {
        final UserCredential userCredential =
            await _auth.signInWithPopup(authProvider);
      } catch (error) {
        print(error);
      }
    } else {
      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
        try {
          await _auth.signInWithCredential(credential);
        } on FirebaseAuthException catch (error) {
          switch (error.code) {
            case 'account-exists-with-different-credential':
              return 'The account already exists using a different register method';
            case 'invalid-credential':
              return 'Invalid credentials. Try again.';
            default:
              return 'Error using Google Sign In. Try again.';
          }
        } catch (error) {
          return 'Error using Google Sign In. Try again.';
        }
      }
    }
  }

  // Sign Out
  Future signOut() async {
    try {
      if (!kIsWeb) {
        await _googleSignIn.signOut();
      }
      await _auth.signOut();
      return 'Successfully Signed Out';
    } catch (error) {
      return 'Error signing out. Try again.';
    }
  }
}
