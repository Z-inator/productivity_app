import 'package:flutter/material.dart';
import 'package:productivity_app/Authentification/services/authentification_data.dart';
import 'package:provider/provider.dart';

class SignInForm extends StatefulWidget {
  SignInForm({Key key}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool signingIn = false;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context, listen: false);
    return signingIn
        ? Center(child: CircularProgressIndicator())
        : Container(
            height: MediaQuery.of(context).size.height - 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: 'Enter your Email',
                              icon: Icon(Icons.send_rounded)),
                          textAlign: TextAlign.center,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: 'Enter your Password',
                              icon: Icon(Icons.lock_rounded)),
                          textAlign: TextAlign.center,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                        ),
                        ElevatedButton.icon(
                          icon: Icon(Icons.check_circle_outline_rounded),
                          label: Text('Sign In'),
                          onPressed: () async {
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                signingIn = true;
                              });
                              dynamic result = await auth
                                  .signInWithEmailAndPassword(email, password);
                              if (result != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(result.toString())));
                              }
                              setState(() {
                                signingIn = false;
                              });
                            }
                          },
                        ),
                      ],
                    )),
                GestureDetector(
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        leading: Image(
                            image: AssetImage('assets/logos/google_logo.png')),
                        title: Text('Sign In using Google',
                            style: Theme.of(context).textTheme.headline6),
                      ),
                    ),
                  ),
                  onTap: () async {
                    setState(() {
                      signingIn = true;
                    });
                    var result = await auth.googleSignIn();
                    if (result != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(result.toString())));
                    }
                    setState(() {
                      signingIn = false;
                    });
                  },
                )
              ],
            ),
          );
  }
}