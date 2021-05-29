// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Home_Dashboard/screens/components/settings_drawer_widget.dart';
import 'package:productivity_app/Home_Dashboard/screens/home_screen.dart';
import 'package:productivity_app/Shared/providers/stopwatch_state.dart';
import 'package:productivity_app/Shared/widgets/add_speed_dial.dart';
import 'package:productivity_app/Shared/widgets/stopwatch_widget.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/status.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Task_Feature/screens/task_project_screen.dart';
import 'package:productivity_app/Time_Feature/models/times.dart';
import 'package:productivity_app/Time_Feature/screens/time_screen.dart';
import 'package:productivity_app/test_screen.dart';
import 'package:provider/provider.dart';

class BaseFramework extends StatefulWidget {
  @override
  _BaseFrameworkState createState() => _BaseFrameworkState();
}

class _BaseFrameworkState extends State<BaseFramework>
    with TickerProviderStateMixin {
  TabController tabController;

  @override
  Widget build(BuildContext context) {
    final StopwatchState stopwatchState = Provider.of<StopwatchState>(context);
    return Provider.of<List<Task>>(context) == null ||
            Provider.of<List<Project>>(context) == null ||
            Provider.of<List<Status>>(context) == null ||
            Provider.of<List<TimeEntry>>(context) == null
        ? Center(child: CircularProgressIndicator()) // TODO: Add logo animation
        : Container(
            decoration: BoxDecoration(
                color: DynamicTheme.of(context).theme.canvasColor),
            child: SafeArea(
              child: Scaffold(
                extendBody: true,
                body: Column(children: [
                  if (stopwatchState.stopwatch.isRunning) StopWatchTile() else Container(),
                  Expanded(
                      child: TabBarView(
                          controller: tabController,
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
                  padding: EdgeInsets.only(
                      top: 2), // Added to counteract the TabBar indicator line
                  child: TabBar(
                      controller: tabController,
                      indicatorColor: Colors.transparent,
                      labelColor:
                          DynamicTheme.of(context).theme.primaryIconTheme.color,
                      tabs: [
                        IconButton(
                            icon: Icon(Icons.dashboard_rounded),
                            tooltip: 'Dashboard',
                            onPressed: () {
                              tabController.animateTo(0);
                            }),
                        IconButton(
                            icon: Icon(Icons.rule_rounded),
                            tooltip: 'Tasks',
                            onPressed: () {
                              tabController.animateTo(1);
                            }),
                        AddSpeedDial(),
                        IconButton(
                            icon: Icon(Icons.timelapse_rounded),
                            tooltip: 'Time Log',
                            onPressed: () {
                              tabController.animateTo(3);
                            }),
                        IconButton(
                            icon: Icon(Icons.bar_chart_rounded),
                            tooltip: 'Goals',
                            onPressed: () {
                              tabController.animateTo(4);
                            }),
                      ]),
                )),
                drawer: SettingsDrawer(),
              ),
            ));
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
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
