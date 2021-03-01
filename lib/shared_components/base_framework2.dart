import 'dart:math';

import 'package:flutter/material.dart';
import 'package:productivity_app/screens/home/home_screen.dart';
import 'package:productivity_app/screens/tasks/test.dart';
import 'package:productivity_app/screens/test_screen.dart';
import 'package:productivity_app/screens/timeEntries/time_screen.dart';
import 'package:productivity_app/services/database.dart';
import 'package:productivity_app/services/tasks_data.dart';
import 'package:productivity_app/services/timer.dart';
import 'package:productivity_app/shared_components/bottom_navigation_bar.dart';
import 'package:productivity_app/shared_components/settings_drawer_widget.dart';
import 'package:productivity_app/models/projects.dart';
import 'package:productivity_app/services/authentification_data.dart';

import 'bottom_navigation_bar2.dart';

class BaseFramework2 extends StatefulWidget {
  @override
  _BaseFramework2State createState() => _BaseFramework2State();
}

class _BaseFramework2State extends State<BaseFramework2> {
  int selectedPage = 0;

  List<Widget> pages = [
    HomeScreen(),
    TimeScreen(),
    ProjectContentPage(),
    TestScreen()
  ];

  void setPage(int index) {
    setState(() {
      selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SafeArea(
      child: Scaffold(
          body: pages[selectedPage],
          // NestedScrollView(
          //   floatHeaderSlivers: true,
          //   headerSliverBuilder:
          //       (BuildContext context, bool innerBoxIsScrolled) {
          //     return <Widget>[
          //       SliverAppBar(
          //         automaticallyImplyLeading:
          //             false, // Hides the setting drawer icon
          //         floating: true,
          //         snap: true,
          //         stretch: true,
          //         expandedHeight: 300.0,
          //         backgroundColor: Colors.grey[50],
          //         flexibleSpace: FlexibleSpaceBar(
          //           stretchModes: <StretchMode>[StretchMode.blurBackground],
          //           background: Container(
          //             margin: EdgeInsets.only(top: 10, left: 5, right: 5),
          //             color: Colors.green,
          //           ),
          //         ),
          //         forceElevated: innerBoxIsScrolled,
          //         onStretchTrigger: () {
          //           return;
          //         },
          //       )
          //     ];
          //   },
          //   body: pages[selectedPage],
          // ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(40)),
              child: BottomAppBar(
                color: Colors.blue,
                elevation: 20,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: IconButton(
                          icon: Icon(Icons.home_rounded),
                          color: selectedPage == 0 ? Colors.red : Colors.white,
                          onPressed: () {
                            setPage(0);
                          }),
                    ),
                    Expanded(
                      child: IconButton(
                          icon: Icon(Icons.timer_rounded),
                          color: selectedPage == 1 ? Colors.red : Colors.white,
                          onPressed: () {
                            setPage(0);
                          }),
                    ),
                    Spacer(),
                    Expanded(
                      child: IconButton(
                          icon: Icon(Icons.playlist_add_rounded),
                          color: selectedPage == 2 ? Colors.red : Colors.white,
                          onPressed: () {
                            setPage(2);
                          }),
                    ),
                    Expanded(
                      child: IconButton(
                          icon: Icon(Icons.gavel_rounded),
                          color: selectedPage == 3 ? Colors.red : Colors.white,
                          onPressed: () {
                            setPage(3);
                          }),
                    ),
                  ],
                ),
              ),
            ),
          )),
    ));
  }
}
