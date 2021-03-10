import 'dart:math';
import 'package:productivity_app/screens/tasks/task_project_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/screens/home/home_screen.dart';
import 'package:productivity_app/screens/tasks/test.dart';
import 'package:productivity_app/screens/test_screen.dart';
import 'package:productivity_app/screens/timeEntries/time_screen.dart';
import 'package:productivity_app/services/database.dart';
import 'package:productivity_app/services/tasks_data.dart';
import 'package:productivity_app/services/timer.dart';
import 'package:productivity_app/services/times_data.dart';
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

  List<Widget> screens = [
    HomeScreen(),
    TimeScreen(),
    TaskScreen(),
    TestScreen()
  ];

  void setPage(int index) {
    setState(() {
      selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    return Container(
        child: SafeArea(
      child: Scaffold(
        body: Stack(children: [
          screens[selectedPage],
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.fromLTRB(40, 0, 40, 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 5),
                    )
                  ]),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: BottomAppBar(
                  color: Colors.white,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          icon: Icon(Icons.dashboard_rounded),
                          color: selectedPage == 0
                              ? Colors.black
                              : Theme.of(context).unselectedWidgetColor,
                          onPressed: () {
                            setPage(0);
                          }),
                      IconButton(
                          icon: Icon(Icons.timer_rounded),
                          color: selectedPage == 1
                              ? Colors.black
                              : Theme.of(context).unselectedWidgetColor,
                          onPressed: () {
                            setPage(1);
                          }),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                              onPrimary: Colors.white,
                              shape: CircleBorder(),
                              elevation: 10,
                            ),
                            onPressed: () {
                              print(Theme.of(context)
                                  .unselectedWidgetColor
                                  .toString());
                            },
                            child: Icon(Icons.add_rounded)),
                      ),
                      // FloatingActionButton(
                      //   elevation: 10,
                      //   mini: true,
                      //   onPressed: () {},
                      //   child: Icon(Icons.add_rounded),
                      // ),
                      IconButton(
                          icon: Icon(Icons.playlist_add_check_rounded),
                          color: selectedPage == 2
                              ? Colors.black
                              : Theme.of(context).unselectedWidgetColor,
                          onPressed: () {
                            setPage(2);
                          }),
                      IconButton(
                          icon: Icon(Icons.bar_chart_rounded),
                          color: selectedPage == 3
                              ? Colors.black
                              : Theme.of(context).unselectedWidgetColor,
                          onPressed: () {
                            setPage(3);
                          }),
                    ],
                  ),
                ),
              ),
            ),
          )
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
        ]),
      ),
    ));
  }
}
