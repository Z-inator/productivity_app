// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Home_Dashboard/Home_Dashboard.dart';
import '../../../Shared/Shared.dart';
import '../../../Task_Feature/Task_Feature.dart';
import '../../../Time_Feature/Time_Feature.dart';
import '../../test_screen.dart';

class BaseFramework extends StatefulWidget {
  @override
  _BaseFrameworkState createState() => _BaseFrameworkState();
}

class _BaseFrameworkState extends State<BaseFramework>
    with TickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StopwatchState stopwatchState = Provider.of<StopwatchState>(context);
    return Provider.of<List<Task>>(context) == null ||
            Provider.of<List<Project>>(context) == null ||
            Provider.of<List<Status>>(context) == null ||
            Provider.of<List<TimeEntry>>(context) == null
        ? Center(child: CircularProgressIndicator()) // TODO: Add logo animation
        : Container(
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
                      labelColor: DynamicColorTheme.of(context)
                          .data
                          .primaryIconTheme
                          .color,
                      tabs: [
                        IconButton(
                            icon: Icon(Icons.dashboard_rounded),
                            tooltip: 'Dashboard',
                            onPressed: () {
                              tabController!.animateTo(0);
                            }),
                        IconButton(
                            icon: Icon(Icons.rule_rounded),
                            tooltip: 'Tasks',
                            onPressed: () {
                              tabController!.animateTo(1);
                            }),
                        AddSpeedDial(),
                        IconButton(
                            icon: Icon(Icons.timelapse_rounded),
                            tooltip: 'Time Log',
                            onPressed: () {
                              tabController!.animateTo(3);
                            }),
                        IconButton(
                            icon: Icon(Icons.bar_chart_rounded),
                            tooltip: 'Goals',
                            onPressed: () {
                              tabController!.animateTo(4);
                            }),
                      ]),
                )),
                drawer: SettingsDrawer(),
                // floatingActionButton: FloatingActionButton(backgroundColor: Color.fromARGB(100, 149, 0, 0), onPressed: () {},),
              ),
            ));
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
