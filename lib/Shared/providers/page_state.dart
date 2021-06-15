import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class PageState extends ChangeNotifier {
  int page = 0;
//   Widget widget = HomeScreen();
//   // bool showOverlay = false;
//   // AnimationController controller;

//   PageState({this.page, this.widget});

//   List<Widget> screens = [
//     HomeScreen(),
//     TimeScreen(),
//     TaskProjectScreen(),
//     TestScreen()
//   ];

  void changePage(int newPage) {
    page = newPage;
    notifyListeners();
  }
}
