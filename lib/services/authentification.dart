import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

Future<UserCredential> signInWithEmail() async {
  FirebaseAuth auth = FirebaseAuth.instance;

  auth.authStateChanges().listen((User user) {
    if (user == null) {
      print('User is currently signed out.');
    } else {
      print('User is signed in.');
    }
  });

  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: 'email', password: 'password');
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The pasword provided is too weak');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}

Future<UserCredential> signInWithGoogle() async {
  final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
