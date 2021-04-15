import 'package:flutter/cupertino.dart';
import 'package:productivity_app/Home_Dashboard/screens/home_screen.dart';
import 'package:productivity_app/Task_Feature/screens/task_project_screen.dart';
import 'package:productivity_app/Time_Feature/screens/time_screen.dart';
import 'package:productivity_app/test_screen.dart';
import 'package:provider/provider.dart';

class PageState extends ChangeNotifier {
  int page = 0;
  Widget widget = HomeScreen();
  // bool showOverlay = false;
  // AnimationController controller;

  PageState({this.page, this.widget});

  List<Widget> screens = [
    HomeScreen(),
    TimeScreen(),
    TaskProjectScreen(),
    TestScreen()
  ];

  void changePage(int newPage) {
    page = newPage;
    widget = screens[newPage];
    notifyListeners();
  }
}
