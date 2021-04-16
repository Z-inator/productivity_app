import 'package:flutter/material.dart';
import 'package:productivity_app/Home_Dashboard/screens/components/pageview_position_dots.dart';
import 'package:productivity_app/Home_Dashboard/screens/components/time_chart_row.dart';
import 'package:provider/provider.dart';

class PageViewRow extends StatelessWidget {
  final List<Widget> pages;
  PageViewRow({Key key, this.pages}) : super(key: key);

  PageController controller;

  @override
  Widget build(BuildContext context) {
    controller = PageController(viewportFraction: .95);
    return ChangeNotifierProvider(
        create: (context) => PageViewDotsState(),
        builder: (context, child) {
          PageViewDotsState state = Provider.of<PageViewDotsState>(context);
          return Container(
            height: MediaQuery.of(context).size.height / 2,
            child: Column(
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
                        child: Card(
                          child: pages[index],
                        )
                      );
                    },
                  ),
                ),
                PageViewDotsRow(numberOfPages: pages.length)
              ],
            ),
          );
        });
  }
}
