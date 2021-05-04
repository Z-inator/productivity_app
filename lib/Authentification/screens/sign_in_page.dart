import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Authentification/services/authentification_data.dart';
import 'package:productivity_app/Home_Dashboard/screens/components/pageview_row.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  List<Widget> pages = [
    Image(image: AssetImage('assets/images/TimeDashboard1.png')),
    Image(image: AssetImage('assets/images/TimeDashboard2.png')),
    Image(image: AssetImage('assets/images/TaskDashboard.png')),
    Image(image: AssetImage('assets/images/TaskList.png')),
    Image(image: AssetImage('assets/images/ProjectList.png')),
    Image(image: AssetImage('assets/images/TimeList.png')),
  ];

  bool isRegister = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Theme.of(context).accentColor,
                  title: Text('Welcome to the AppName',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.subtitle2.color)),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.help_rounded),
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AboutPage())),
                    )
                  ],
                ),
                body: SlidingUpPanel(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                  panelSnapping: true,
                  minHeight: 80,
                  maxHeight: MediaQuery.of(context).size.height - 105,
                  backdropEnabled: true,
                  backdropTapClosesPanel: true,
                  onPanelOpened: () {
                    setState(() {});
                  },
                  onPanelClosed: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    setState(() {});
                  },
                  panel: Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Column(
                      children: [
                        ListTile(
                            title: Text(isRegister ? 'Register' : 'Sign In',
                                style: Theme.of(context).textTheme.headline6),
                            trailing: OutlinedButton.icon(
                              icon: Icon(isRegister
                                  ? Icons.account_circle_rounded
                                  : Icons.person_add_rounded),
                              label: Text(isRegister ? 'Sign In' : 'Register'),
                              onPressed: () {
                                setState(() {
                                  isRegister = !isRegister;
                                });
                                print('button is pressed');
                              },
                            )),
                        isRegister ? RegisterForm() : SignInForm(),
                      ],
                    ),
                  ),
                  collapsed: Container(
                      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: ListTile(
                        tileColor: Theme.of(context).cardColor,
                        title: Text('Sign In or Register to get Started',
                            style: Theme.of(context).textTheme.headline6),
                      )),
                  header: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: 10),
                    child: Center(
                      child: Container(
                        width: 60,
                        height: 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                  ),
                  body: Column(children: [
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: ListTile(
                        leading: Icon(Icons.lightbulb),
                        title: Text(
                            'This app is designed as a general purpose, individual, productivity tracker and helper to help you make the most of everyday.',
                            maxLines: 3),
                      ),
                    ),
                    ListTile(
                      title: Text('Features',
                          style: Theme.of(context).textTheme.headline6),
                    ),
                    Expanded(
                      child: DefaultTabController(
                          length: 4,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TabBar(
                                  unselectedLabelColor:
                                      Theme.of(context).unselectedWidgetColor,
                                  labelColor: Theme.of(context).accentColor,
                                  labelPadding:
                                      EdgeInsets.fromLTRB(5, 20, 5, 10),
                                  tabs: [
                                    Text('Dashboard'),
                                    Text('Tasks'),
                                    Text('Timer'),
                                    Text('Goals')
                                  ]),
                              Expanded(
                                  child: TabBarView(
                                children: [
                                  DashboardTimeFeatureSnippet1(),
                                  TaskFeatureSnippet(),
                                  TimeFeatureSnippet(),
                                  GoalFeatureSnippet()
                                ],
                              )),
                            ],
                          )),
                    ),
                  ]),
                ))));
  }
}

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
                            FocusScopeNode currentFocus = FocusScope.of(context);
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

class RegisterForm extends StatefulWidget {
  RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email;
  String password;
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
                            FocusScopeNode currentFocus = FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            if (_formKey.currentState.validate()) {
                              dynamic result = await auth
                                  .signInWithEmailAndPassword(email, password);
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

class AboutPage extends StatelessWidget {
  const AboutPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class DashboardTimeFeatureSnippet1 extends StatelessWidget {
  const DashboardTimeFeatureSnippet1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image(image: AssetImage('assets/images/TimeDashboard1.png')),
    );
  }
}

class DashboardTimeFeatureSnippet2 extends StatelessWidget {
  const DashboardTimeFeatureSnippet2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image(image: AssetImage('assets/images/TimeDashboard2.png')),
    );
  }
}

class DashboardTaskFeatureSnippet extends StatelessWidget {
  const DashboardTaskFeatureSnippet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image(image: AssetImage('assets/images/TaskDashboard.png')),
    );
  }
}

class TaskFeatureSnippet extends StatelessWidget {
  const TaskFeatureSnippet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image(image: AssetImage('assets/images/TaskList.png')),
    );
  }
}

class ProjectFeatureSnippet extends StatelessWidget {
  const ProjectFeatureSnippet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image(image: AssetImage('assets/images/ProjectList.png')),
    );
  }
}

class TimeFeatureSnippet extends StatelessWidget {
  const TimeFeatureSnippet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image(image: AssetImage('assets/images/TimeList.png')),
    );
  }
}

class GoalFeatureSnippet extends StatelessWidget {
  const GoalFeatureSnippet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
