import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

import 'package:productivity_app/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Authentification change user stream
  Stream<User> get user {
    return _auth.authStateChanges();
  }

  // Get user reference
  DocumentReference getUserReference(String userID) {
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
      final User user = userCredential.user;
      return user;
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        print('No user found for that email');
      } else if (error.code == 'wrong-password') {
        print('Wrong password provided for that user');
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
    } on FirebaseAuthException catch (error) {
      if (error.code == 'weak-password') {
        print('Password is too weak');
      } else if (error.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (error) {
      print(error);
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
    } catch (error) {
      print(error);
      return null;
    }
  }

  // Sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error);
      return null;
    }
  }
}
