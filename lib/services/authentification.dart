import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

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
