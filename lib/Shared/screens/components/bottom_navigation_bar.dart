import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Shared/providers/page_state.dart';
import 'package:productivity_app/Shared/widgets/add_speed_dial.dart';
import 'package:provider/provider.dart';

class NavigationBar extends StatelessWidget {
  const NavigationBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageState state = Provider.of<PageState>(context);
    return BottomAppBar(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
            color: DynamicColorTheme.of(context).data.cardColor,
            border: Border.symmetric(horizontal: BorderSide(color: Colors.grey))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                icon: Icon(Icons.dashboard_rounded),
                tooltip: 'Dashboard',
                color: state.page == 0
                    ? DynamicColorTheme.of(context).data.textTheme.subtitle1.color
                    : DynamicColorTheme.of(context).data.unselectedWidgetColor,
                onPressed: () {
                  state.changePage(0);
                }),
            IconButton(
                icon: Icon(Icons.rule_rounded),
                tooltip: 'Tasks',
                color: state.page == 2
                    ? DynamicColorTheme.of(context).data.textTheme.subtitle1.color
                    : DynamicColorTheme.of(context).data.unselectedWidgetColor,
                onPressed: () {
                  state.changePage(2);
                }),
            AddSpeedDial(),
            IconButton(
                icon: Icon(Icons.timer_rounded),
                tooltip: 'Time Log',
                color: state.page == 1
                    ? DynamicColorTheme.of(context).data.textTheme.subtitle1.color
                    : DynamicColorTheme.of(context).data.unselectedWidgetColor,
                onPressed: () {
                  state.changePage(1);
                }),
            IconButton(
                icon: Icon(Icons.bar_chart_rounded),
                tooltip: 'Goals',
                color: state.page == 3
                    ? DynamicColorTheme.of(context).data.textTheme.subtitle1.color
                    : DynamicColorTheme.of(context).data.unselectedWidgetColor,
                onPressed: () {
                  state.changePage(3);
                }),
          ],
        ),
      ),
    );
  }
}




// This is my floating bottom navigation bar.
// I found it beautiful but it didn't fit the rest of the app.
// I have too many cards and elevated widgets for it to look correct.
// It would be better suited for a Pinterest style app with a grid layout.

// return Positioned(
//       bottom: 0,
//       left: 0,
//       right: 0,
//       child: Container(
//         margin: EdgeInsets.fromLTRB(40, 0, 40, 20),
//         child: Card(
//           elevation: 12,
//           child: Row(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               IconButton(
//                   icon: Icon(Icons.dashboard_rounded),
//                   color: state.page == 0
//                       ? Colors.black
//                       : DynamicColorTheme.of(context).data.unselectedWidgetColor,
//                   onPressed: () {
//                     state.changePage(0);
//                   }),
//               IconButton(
//                   icon: Icon(Icons.timer_rounded),
//                   color: state.page == 1
//                       ? Colors.black
//                       : DynamicColorTheme.of(context).data.unselectedWidgetColor,
//                   onPressed: () {
//                     state.changePage(1);
//                   }),
//               AddSpeedDial(
//                   // options: {
//                   //   Icons.timer_rounded: EditBottomSheet()
//                   //       .buildTimeEntryEditBottomSheet(
//                   //           context: context, isUpdate: false),
//                   //   Icons.timelapse_rounded: EditBottomSheet()
//                   //       .buildTimeEntryEditBottomSheet(
//                   //           context: context, isUpdate: false),
//                   //   Icons.rule_rounded: EditBottomSheet()
//                   //       .buildTaskEditBottomSheet(
//                   //           context: context, isUpdate: false),
//                   //   Icons.topic_rounded: EditBottomSheet()
//                   //       .buildProjectEditBottomSheet(
//                   //           context: context, isUpdate: false)
//                   // }
//                   ),
//               IconButton(
//                   icon: Icon(Icons.rule_rounded),
//                   color: state.page == 2
//                       ? Colors.black
//                       : DynamicColorTheme.of(context).data.unselectedWidgetColor,
//                   onPressed: () {
//                     state.changePage(2);
//                   }),
//               IconButton(
//                   icon: Icon(Icons.bar_chart_rounded),
//                   color: state.page == 3
//                       ? Colors.black
//                       : DynamicColorTheme.of(context).data.unselectedWidgetColor,
//                   onPressed: () {
//                     state.changePage(3);
//                   }),
//             ],
//           ),
//         ),
//       ),
//       // ),
//     );
