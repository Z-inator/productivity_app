import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Authentification.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email;
  String password;
  String displayName;
  bool signingIn = false;
  Icon passwordNotValid = Icon(Icons.close_rounded, color: Colors.red);
  Icon passwordValid = Icon(Icons.check_rounded, color: Colors.green);
  bool password1Valid;
  bool password2Matches;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context, listen: false);
    return signingIn
        ? Center(child: CircularProgressIndicator())
        : Container(
            height: MediaQuery.of(context).size.height - 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Enter your Display Name',
                              icon: Icon(Icons.send_rounded)),
                          textAlign: TextAlign.center,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your display name';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              displayName = value;
                            });
                          },
                        ),
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
                              helperText:
                                  'Passwords must be at least 8 characters long and include an uppercase letter, lowercase letter, number, and special character.',
                              helperMaxLines: 3,
                              icon: password1Valid == null
                                  ? Icon(Icons.lock_rounded)
                                  : password1Valid
                                      ? passwordValid
                                      : passwordNotValid),
                          textAlign: TextAlign.center,
                          validator: (password) =>
                              auth.passwordValidation(password),
                          onChanged: (value) {
                            if (auth.passwordValidation(value) == null) {
                              setState(() {
                                password1Valid = true;
                                password = value;
                              });
                            } else {
                              setState(() {
                                password1Valid = false;
                                password = value;
                              });
                            }
                          },
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: 'Re-enter your Password',
                              helperText: 'Passwords must match',
                              icon: password2Matches == null
                                  ? Icon(Icons.lock_rounded)
                                  : password2Matches
                                      ? passwordValid
                                      : passwordNotValid),
                          textAlign: TextAlign.center,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please re-enter your password';
                            } else if (value == password) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            if (value == password) {
                              setState(() {
                                password2Matches = true;
                              });
                            } else {
                              setState(() {
                                password2Matches = false;
                              });
                            }
                          },
                        ),
                        ElevatedButton.icon(
                          icon: Icon(Icons.check_circle_outline_rounded),
                          label: Text('Register'),
                          onPressed: () async {
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            if (_formKey.currentState.validate()) {
                              dynamic result = await auth
                                  .registerWithEmailAndPassword(email, password, displayName);
                              if (result != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(result.toString())));
                              }
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
                        title: Text('Register using Google',
                            style: DynamicColorTheme.of(context).data.textTheme.headline6),
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