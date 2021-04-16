import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageViewDotsState extends ChangeNotifier {
  int activePage;

  PageViewDotsState() : activePage = 0;

  void changePage(int index) {
    activePage = index;
    notifyListeners();
  }
}

class PageViewDots extends StatelessWidget {
  int index;
  PageViewDots({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageViewDotsState state = Provider.of<PageViewDotsState>(context);
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 10),
      height: state.activePage == index ? 12 : 8,
      width: state.activePage == index ? 12 : 8,
      decoration: BoxDecoration(
          color: state.activePage == index
              ? Theme.of(context).accentColor
              : Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(25))),
    );
  }
}

class PageViewDotsRow extends StatelessWidget {
  final int numberOfPages;
  const PageViewDotsRow({Key key, this.numberOfPages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageViewDotsState state = Provider.of<PageViewDotsState>(context);
    return ListTile(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            List.generate(numberOfPages, (index) => PageViewDots(index: index)),
      ),
    );
  }
}
