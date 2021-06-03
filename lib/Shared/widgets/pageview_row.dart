import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Home_Dashboard/Home_Dashboard.dart';


class PageViewRow extends StatelessWidget {
  final List<Widget> pages;
  PageViewRow({Key key, this.pages}) : super(key: key);

  PageController controller;

  @override
  Widget build(BuildContext context) {
    controller = PageController();
    return ChangeNotifierProvider(
        create: (context) => PageViewDotsState(),
        builder: (context, child) {
          PageViewDotsState state = Provider.of<PageViewDotsState>(context);
          return Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: controller,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (int index) => state.changePage(index),
                  itemCount: pages.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
                      child: pages[index]
                    );
                  },
                ),
              ),
              PageViewDotsRow(numberOfPages: pages.length)
            ],
          );
        });
  }
}
