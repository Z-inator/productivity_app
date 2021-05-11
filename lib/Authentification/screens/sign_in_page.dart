import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Authentification/screens/about.dart';
import 'package:productivity_app/Authentification/screens/components/register_form.dart';
import 'package:productivity_app/Authentification/screens/components/sign_in_form.dart';
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
    Image(image: AssetImage('assets/images/dashboard.png')),
    Image(image: AssetImage('assets/images/tasks.png')),
    Image(image: AssetImage('assets/images/timer.png')),
  ];

  bool isRegister = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: DynamicColorTheme.of(context).data.accentColor,
                  title: Text('Welcome to the AppName'),
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
                                style: DynamicColorTheme.of(context).data.textTheme.headline6),
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
                        tileColor: DynamicColorTheme.of(context).data.cardColor,
                        title: Text('Sign In or Register to get Started',
                            style: DynamicColorTheme.of(context).data.textTheme.headline6),
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
                          color: DynamicColorTheme.of(context).data.accentColor,
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
                    Expanded(child: PageViewRow(pages: pages)),
                    Container(height: 185)
                  ]),
                ))));
  }
}