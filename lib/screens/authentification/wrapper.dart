import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:productivity_app/services/authentification_data.dart';
import 'package:provider/provider.dart';
import 'package:productivity_app/screens/test_screen.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return RaisedButton(
          onPressed: () {
            AuthService().signInWithEmailAndPassword(
                'someone@gmail.com', 'testing123456');
          },
          child: Text('Sign In'));
    }
    return TestScreen();
  }
}
