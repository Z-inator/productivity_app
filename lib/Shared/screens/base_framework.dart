// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:productivity_app/Shared/providers/page_state.dart';
import 'package:productivity_app/Shared/screens/components/bottom_navigation_bar.dart';

import 'package:productivity_app/Shared/widgets/add_speed_dial.dart';
import 'package:productivity_app/Shared/widgets/edit_bottom_sheets.dart';
import 'package:productivity_app/Shared/widgets/flutter_speed_dial/flutter_speed_dial.dart';
import 'package:productivity_app/Shared/widgets/stopwatch_widget.dart';
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
import 'package:productivity_app/Shared/providers/stopwatch_state.dart';
import 'package:productivity_app/Time_Feature/providers/time_entry_edit_state.dart';
import 'package:productivity_app/Time_Feature/screens/components/time_entry_edit_bottomsheet.dart';
import 'package:productivity_app/Home_Dashboard/screens/components/settings_drawer_widget.dart';
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

class _BaseFrameworkState extends State<BaseFramework>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider.of<List<Task>>(context) == null ||
            Provider.of<List<Project>>(context) == null ||
            Provider.of<List<Status>>(context) == null ||
            Provider.of<List<TimeEntry>>(context) == null
        ? Center(child: CircularProgressIndicator()) // TODO: Add logo animation
        : ChangeNotifierProvider(
            create: (context) => PageState(page: 0, widget: HomeScreen()),
            builder: (context, child) {
              PageState pageState = Provider.of<PageState>(context);
              StopwatchState stopwatchState =
                  Provider.of<StopwatchState>(context);
              return Container(
                  decoration: BoxDecoration(
                      color: DynamicColorTheme.of(context).data.canvasColor),
                  child: SafeArea(
                    child: Scaffold(
                      extendBody: true,
                      body: Column(children: [
                        stopwatchState.stopwatch.isRunning
                            ? StopWatchTile()
                            : Container(),
                        Expanded(
                            child: TabBarView(
                                controller: _tabController,
                                physics: NeverScrollableScrollPhysics(),
                                children: [
                                  HomeScreen(),
                                  TaskProjectScreen(),
                                  Container(),
                                  TimeScreen(),
                                  TestScreen()
                                ]))
                      ]),
                      bottomNavigationBar: BottomAppBar(
                          child: Container(
                            padding: EdgeInsets.only(top: 2),                   // Added to counteract the TabBar indicator line
                            child: TabBar(
                              controller: _tabController,
                              indicatorColor: Colors.transparent,
                              labelColor: DynamicColorTheme.of(context).data.primaryIconTheme.color,
                              tabs: [
                                IconButton(
                                    icon: Icon(Icons.dashboard_rounded),
                                    tooltip: 'Dashboard',
                                    onPressed: () {
                                      _tabController.animateTo(0);
                                    }),
                                IconButton(
                                    icon: Icon(Icons.rule_rounded),
                                    tooltip: 'Tasks',
                                    onPressed: () {
                                      _tabController.animateTo(1);
                                    }),
                                AddSpeedDial(),
                                IconButton(
                                    icon: Icon(Icons.timer_rounded),
                                    tooltip: 'Time Log',
                                    onPressed: () {
                                      _tabController.animateTo(3);
                                    }),
                                IconButton(
                                    icon: Icon(Icons.bar_chart_rounded),
                                    tooltip: 'Goals',
                                    onPressed: () {
                                      _tabController.animateTo(4);
                                    }),
                              ]),
                          )),
                      drawer: SettingsDrawer(),
                    ),
                  ));
            },
          );
  }
}

// class StopwatchAppBar extends StatelessWidget {
//   const StowatchAppBar({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(

//     );
//   }
// }
