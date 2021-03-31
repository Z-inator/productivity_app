import 'package:productivity_app/Task_Feature/screens/task_project_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Home_Dashboard/screens/home_screen.dart';
import 'package:productivity_app/test_screen.dart';
import 'package:productivity_app/Time_Feature/screens/time_screen.dart';


class BaseFramework extends StatefulWidget {
  @override
  _BaseFrameworkState createState() => _BaseFrameworkState();
}

class _BaseFrameworkState extends State<BaseFramework> {
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
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 5),
                    )
                  ]),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(25)),
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
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder()
                        ),
                        child: Icon(Icons.add_rounded),
                        onPressed: () {},
                      ),
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
        ]),
      ),
    ));
  }
}
