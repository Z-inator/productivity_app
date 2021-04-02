import 'package:flutter/material.dart';
import 'package:productivity_app/Authentification/services/authentification_data.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  Future<void> signIn(BuildContext context) async {
    try {
      final auth = Provider.of<AuthService>(context, listen: false);
      await auth.signInWithEmailAndPassword('zaw1593@yahoo.com', 'testing123456');
    } catch (e) {
      print(e);
    }
  }

  Future<void> register(BuildContext context) async {
    try {
      final auth = Provider.of<AuthService>(context, listen: false);
      await auth.signInWithEmailAndPassword('zaw1593@yahoo.com', 'testing123456');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
              onPressed: () => signIn(context),
              child: Text('Sign In')),
          ElevatedButton(
            onPressed: () => register(context),
            child: Text('Register'),
          )
        ]);
  }
}