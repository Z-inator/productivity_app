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

  // Sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = userCredential.user;
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
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      // Create a new document for the user with the uid
      await DatabaseService().buildUser(user.uid, 'Butt', 'Face');
      return user;
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
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth =
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

// class Authentification {
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _db = FirebaseFirestore.instance;

//   // Firebase user one-time fetch
//   Future<User> getUser() async {
//     try {
//       final user = _auth.currentUser;
//       if (user != null) {
//         print('User sign in: ${user.email}');
//       } else {
//         print('No user signed in');
//       }
//       return user;
//     } catch (error) {
//       print(error);
//       return null;
//     }
//   }

//   // Firebase user realtime stream
//   Stream<User> get user => _auth.authStateChanges();

//   // sign in with Google
//   Future<User> googleSignIn() async {
//     try {
//       GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
//       GoogleSignInAuthentication googleAuth =
//           await googleSignInAccount.authentication;

//       final GoogleAuthCredential credential = GoogleAuthProvider.credential(
//           accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

//       final User user = (await _auth.signInWithCredential(credential)).user;

//       return user;
//     } catch (error) {
//       print(error);
//       return null;
//     }
//   }

//   Future<User> createUserWithEmailPassword(
//       {String firstName,
//       String lastname,
//       String email,
//       String password}) async {
//     try {
//       UserCredential userCredential = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(email: 'email', password: 'password');
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//         print('The pasword provided is too weak');
//       } else if (e.code == 'email-already-in-use') {
//         print('The account already exists for that email.');
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<User> signInWithEmailPassword({String email, String password}) async {
//     try {
//       UserCredential userCredential = await FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: email, password: password);
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         print('No user found for that email');
//       } else if (e.code == 'wrong-password') {
//         print('Wrong password provided for that user');
//       }
//     }
//   }

//   // Sign out
//   Future<void> signOut() {
//     return _auth.signOut();
//   }
// }
