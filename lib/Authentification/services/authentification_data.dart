import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:productivity_app/Authentification/services/database.dart';
import 'package:productivity_app/Users/models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User get user {
    return _auth.currentUser;
  }

  // Authentification change user stream
  Stream<UserModel> get onAuthStateChanged {
    return _auth.authStateChanges().map((user) {
      return user == null ? null : UserModel.fromFirestore(user);
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

  // Sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential != null) {
        return 'Successfully Signed In';
      }
    } on FirebaseAuthException catch (errorrror) {
      if (errorrror.code == 'user-not-found') {
        return 'User not found';
      } else if (errorrror.code == 'wrong-password') {
        return 'Wrong password provided';
      }
    }
  }

  // Register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((UserCredential userCredential) => {
                userCredential.user.sendEmailVerification(),
                DatabaseService().buildUser(
                    uid: userCredential.user.uid,
                    firstName: 'Butt',
                    lastName: 'Face')
              });

      // // Send verification email
      // if (!userCredential.user.emailVerified) {
      //   user.sendEmailVerification();
      // }

      // // Create a new document for the user with the uid
      // await DatabaseService()
      //     .buildUser(uid: user.uid, lastName: 'Face', firstName: 'Butt');
      // return user;
    } on FirebaseAuthException catch (errorrror) {
      if (errorrror.code == 'weak-password') {
        print('Password is too weak');
      } else if (errorrror.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (errorrror) {
      print(errorrror);
    }
  }

  // sign in with Google
  Future<User> googleSignIn() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;

      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      final User user = (await _auth.signInWithCredential(credential)).user;
      print(user);
      return user;
    } catch (errorrror) {
      print(errorrror);
      return null;
    }
  }

  static SnackBar customSnackBar({String content}) {
    return SnackBar(
      content: Text(
        content,
      ),
    );
  }

  Future<User> signInWithGoogle({BuildContext context}) async {
    User user;

    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential =
            await _auth.signInWithPopup(authProvider);

        user = userCredential.user;
      } catch (error) {
        print(error);
      }
    } else {

      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential =
              await _auth.signInWithCredential(credential);
          user = userCredential.user;
        } on FirebaseAuthException catch (error) {
          if (error.code == 'account-exists-with-different-credential') {
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                content:
                    'The account already exists with a different credential',
              ),
            );
          } else if (error.code == 'invalid-credential') {
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                content:
                    'Invalid credentials. Try again.',
              ),
            );
          }
        } catch (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(
              content: 'Error using Google Sign In. Try again.',
            ),
          );
        }
      }
    }

    return user;
  }

  Future<void> signOut({BuildContext context}) async {

    try {
      if (!kIsWeb) {
        await _googleSignIn.signOut();
      }
      await _auth.signOut();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(
          content: 'Error signing out. Try again.',
        ),
      );
    }
  }


  // Sign out
  // Future signOut() async {
  //   try {
  //     return await _auth.signOut();
  //   } catch (errorrror) {
  //     print(errorrror);
  //     return null;
  //   }
  // }
}
