// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:productivity_app/Shared/providers/page_state.dart';
import 'package:productivity_app/Shared/widgets/add_new_selector.dart';
import 'package:productivity_app/Shared/widgets/add_speed_dial.dart';
import 'package:productivity_app/Shared/widgets/edit_bottom_sheets.dart';
import 'package:productivity_app/Shared/widgets/flutter_speed_dial/flutter_speed_dial.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/status.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
// import 'package:productivity_app/Shared/widgets/flutter_speed_dial/src/speed_dial.dart';
import 'package:productivity_app/Task_Feature/providers/project_edit_state.dart';
import 'package:productivity_app/Task_Feature/providers/task_edit_state.dart';
import 'package:productivity_app/Task_Feature/screens/components/project_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/components/task_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/task_project_screen.dart';
import 'package:productivity_app/Time_Feature/models/times.dart';
import 'package:productivity_app/Time_Feature/providers/time_entry_edit_state.dart';
import 'package:productivity_app/Time_Feature/screens/components/time_entry_edit_bottomsheet.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Home_Dashboard/screens/home_screen.dart';
import 'package:productivity_app/test_screen.dart';
import 'package:productivity_app/Time_Feature/screens/time_screen.dart';

class BaseFramework extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Task> tasks = Provider.of<List<Task>>(context);
    List<Project> projects = Provider.of<List<Project>>(context);
    List<Status> statuses = Provider.of<List<Status>>(context);
    List<TimeEntry> timeEntries = Provider.of<List<TimeEntry>>(context);
    return tasks == null ||
            projects == null ||
            statuses == null ||
            timeEntries == null
        ? Center(child: CircularProgressIndicator())
        : ChangeNotifierProvider(
            create: (context) => PageState(page: 0, widget: HomeScreen()),
            builder: (context, child) {
              return Container(
                  decoration:
                      BoxDecoration(color: Theme.of(context).canvasColor),
                  child: SafeArea(
                    child: Scaffold(
                      extendBody: true,
                      body: PageBody(),
                      bottomNavigationBar: NavigationBar(),
                      floatingActionButton: AddSpeedDial(),
                      floatingActionButtonLocation:
                          FloatingActionButtonLocation.centerDocked,
                    ),
                  ));
            },
          );
  }
}

class PageBody extends StatelessWidget {
  const PageBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageState state = Provider.of<PageState>(context);
    return state.widget;
  }
}

class NavigationBar extends StatelessWidget {
  const NavigationBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageState state = Provider.of<PageState>(context);
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      color: Theme.of(context).cardColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              icon: Icon(Icons.dashboard_rounded),
              color: state.page == 0
                  ? Colors.black
                  : Theme.of(context).unselectedWidgetColor,
              onPressed: () {
                state.changePage(0);
              }),
          // AddSpeedDial(),
          IconButton(
              icon: Icon(Icons.rule_rounded),
              color: state.page == 2
                  ? Colors.black
                  : Theme.of(context).unselectedWidgetColor,
              onPressed: () {
                state.changePage(2);
              }),
          SizedBox(width: 56, height: 1),
          IconButton(
              icon: Icon(Icons.timer_rounded),
              color: state.page == 1
                  ? Colors.black
                  : Theme.of(context).unselectedWidgetColor,
              onPressed: () {
                state.changePage(1);
              }),
          IconButton(
              icon: Icon(Icons.bar_chart_rounded),
              color: state.page == 3
                  ? Colors.black
                  : Theme.of(context).unselectedWidgetColor,
              onPressed: () {
                state.changePage(3);
              }),
        ],
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
//                       : Theme.of(context).unselectedWidgetColor,
//                   onPressed: () {
//                     state.changePage(0);
//                   }),
//               IconButton(
//                   icon: Icon(Icons.timer_rounded),
//                   color: state.page == 1
//                       ? Colors.black
//                       : Theme.of(context).unselectedWidgetColor,
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
//                       : Theme.of(context).unselectedWidgetColor,
//                   onPressed: () {
//                     state.changePage(2);
//                   }),
//               IconButton(
//                   icon: Icon(Icons.bar_chart_rounded),
//                   color: state.page == 3
//                       ? Colors.black
//                       : Theme.of(context).unselectedWidgetColor,
//                   onPressed: () {
//                     state.changePage(3);
//                   }),
//             ],
//           ),
//         ),
//       ),
//       // ),
//     );
