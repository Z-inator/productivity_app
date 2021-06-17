import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../Shared/Shared.dart';
import '../Authentification.dart';

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
    ThemeData themeData = DynamicColorTheme.of(context).data;
    return Container(
        child: SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  foregroundColor: themeData
                      .colorScheme
                      .onSecondary,
                  backgroundColor: themeData.colorScheme.secondary,
                  title: Text(
                    'Welcome to the AppName',
                    style: themeData
                        .textTheme
                        .headline6!
                        .copyWith(
                            color: themeData
                                .colorScheme
                                .onSecondary),
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.help_rounded,
                          color: themeData
                              .colorScheme
                              .onSecondary),
                      onPressed: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AboutPage())),
                    )
                  ],
                ),
                body: SlidingUpPanel(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                  color: themeData.colorScheme.surface,
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
                                style: themeData
                                    .textTheme
                                    .headline6),
                            trailing: OutlinedButton.icon(
                              icon: Icon(isRegister
                                  ? Icons.account_circle_rounded
                                  : Icons.person_add_rounded),
                              label: Text(isRegister ? 'Sign In' : 'Register'),
                              onPressed: () {
                                setState(() {
                                  isRegister = !isRegister;
                                });
                              },
                            )),
                        isRegister ? RegisterForm() : SignInForm(),
                      ],
                    ),
                  ),
                  collapsed: Container(
                      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          color: themeData
                              .colorScheme
                              .surface),
                      child: ListTile(
                        title: Text('Sign In or Register to get Started',
                            style: themeData
                                .textTheme
                                .headline6),
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
                          color: themeData
                              .colorScheme
                              .secondary,
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
