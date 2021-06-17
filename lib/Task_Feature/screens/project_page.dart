import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

import '../../../Home_Dashboard/Home_Dashboard.dart';
import '../../../Shared/Shared.dart';
import '../../../Task_Feature/Task_Feature.dart';
import '../../../Time_Feature/Time_Feature.dart';

class ProjectPage extends StatefulWidget {
  final Project project;

  ProjectPage({required this.project});

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage>
    with TickerProviderStateMixin {
  List<Map<dynamic, List<Task>>> taskMap = [];

  List<Map<dynamic, List<TimeEntry>>> timeEntryMap = [];

  TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<MaterialColor> colorList = AppColorList;
    ThemeData themeData = themeData;
    StopwatchState stopwatchState = Provider.of<StopwatchState>(context);
    List<Task> tasks = Provider.of<List<Task>>(context)
        .where((task) => task.project?.id == widget.project.id)
        .toList();
    List<Status> statuses = Provider.of<List<Status>>(context);
    taskMap = TaskService.getTasksByStatus(tasks, statuses);
    List<TimeEntry> timeEntries = Provider.of<List<TimeEntry>>(context)
        .where((entry) => entry.project?.id == widget.project.id)
        .toList();
    timeEntryMap = TimeService.getTimeEntriesByDay(timeEntries);
    return SafeArea(
        child: Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     widget.project.projectName!,
      //     style: TextStyle(
      //         color: DynamicColorTheme.of(context).isDark
      //             ? colorList[widget.project.projectColor!].shade200
      //             : colorList[widget.project.projectColor!]),
      //   ),
      //   actions: [
      //     IconButton(
      //         icon: Icon(
      //           Icons.edit_rounded,
      //           color: themeData.unselectedWidgetColor,
      //         ),
      //         onPressed: () => EditBottomSheet().buildEditBottomSheet(
      //             context: context,
      //             bottomSheet: ProjectEditBottomSheet(
      //                 isUpdate: true, project: widget.project))),
      //   ],
      // ),
      body: Column(
        children: [
          stopwatchState.stopwatch.isRunning ? StopWatchTile() : Container(),
          AppBar(
            title: Text(
              widget.project.projectName!,
              style: TextStyle(
                  color: DynamicColorTheme.of(context).isDark
                      ? colorList[widget.project.projectColor!].shade200
                      : colorList[widget.project.projectColor!]),
            ),
            actions: [
              IconButton(
                  icon: Icon(
                    Icons.edit_rounded,
                    color: DynamicColorTheme.of(context)
                        .data
                        .unselectedWidgetColor,
                  ),
                  onPressed: () => EditBottomSheet().buildEditBottomSheet(
                      context: context,
                      bottomSheet: ProjectEditBottomSheet(
                          isUpdate: true, project: widget.project))),
            ],
          ),
          Expanded(
            child: TabBarView(
                controller: tabController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  // HomeScreen(),
                  taskMap.isEmpty
                      ? Center(
                          child: Text(
                              'No Tasks for ${widget.project.projectName}'))
                      : TaskList(
                          taskMap: taskMap,
                          getWidget: (item, numberOfTasks) =>
                              StatusExpansionTile(status: item as Status)),
                  timeEntryMap.isEmpty
                      ? Center(
                          child: Text(
                              'No Time Recorded for ${widget.project.projectName}'))
                      : TimeEntriesByDay(timeEntries: timeEntries),
                  // HomeScreen()
                ]),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigation(
          themeData: themeData, tabController: tabController, widget: widget),
    ));
  }
}

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    Key? key,
    required this.themeData,
    required this.tabController,
    required this.widget,
  }) : super(key: key);

  final ThemeData themeData;
  final TabController? tabController;
  final ProjectPage widget;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PageState>(
        create: (context) => PageState(),
        builder: (context, child) {
          PageState pageState = Provider.of<PageState>(context);
          return BottomAppBar(
              child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: themeData.colorScheme.onBackground),
                          bottom: BorderSide(
                              color: themeData.colorScheme.onBackground))),
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // IconButton(
                        //     icon: Icon(Icons.dashboard_rounded),
                        //     tooltip: 'Dashboard',
                        //     onPressed: () {
                        //       tabController!.animateTo(0);
                        //     }),
                        IconButton(
                            icon: Icon(Icons.rule_rounded,
                                color: pageState.page == 0
                                    ? themeData.iconTheme.color
                                    : themeData.colorScheme.onBackground),
                            tooltip: 'Tasks',
                            onPressed: () {
                              tabController!.animateTo(0);
                              pageState.changePage(0);
                            }),
                        ProjectPageSpeedDial(project: widget.project),
                        IconButton(
                            icon: Icon(Icons.timelapse_rounded,
                                color: pageState.page == 1
                                    ? themeData.iconTheme.color
                                    : themeData.colorScheme.onBackground),
                            tooltip: 'Time Log',
                            onPressed: () {
                              tabController!.animateTo(1);
                              pageState.changePage(1);
                            }),
                        // IconButton(
                        //     icon: Icon(Icons.bar_chart_rounded),
                        //     tooltip: 'Goals',
                        //     onPressed: () {
                        //       tabController!.animateTo(3);
                        //     }),
                      ])));
        });
  }
}

class ProjectPageSpeedDial extends StatelessWidget {
  final Project project;
  ValueNotifier<bool> isDialOpen = ValueNotifier<bool>(false);
  ProjectPageSpeedDial({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = DynamicColorTheme.of(context).data;
    return SpeedDial(
      icon: Icons.add_rounded,
      iconTheme: IconThemeData(size: 45),
      activeIcon: Icons.close_rounded,
      closeManually: true,
      openCloseDial: isDialOpen,
      overlayColor:
          themeData.colorScheme.secondaryVariant,
      overlayOpacity: .1,
      renderOverlay: true,
      curve: Curves.bounceIn,
      tooltip: 'Add Menu',
      buttonSize: 45,
      childrenButtonSize: 45,
      elevation: 0,
      shape: CircleBorder(),
      backgroundColor: themeData.colorScheme.secondary,
      foregroundColor:
          themeData.colorScheme.onSecondary,
      children: [
        SpeedDialChild(
            child: Icon(Icons.timer_rounded),
            backgroundColor:
                themeData.colorScheme.surface,
            foregroundColor:
                themeData.colorScheme.secondary,
            onTap: () {
              isDialOpen.value = !isDialOpen.value;
              Provider.of<StopwatchState>(context, listen: false)
                  .startStopwatch(oldEntry: TimeEntry(project: project));
            }),
        SpeedDialChild(
            child: Icon(Icons.timelapse_rounded),
            backgroundColor:
                themeData.colorScheme.surface,
            foregroundColor:
                themeData.colorScheme.secondary,
            onTap: () {
              isDialOpen.value = !isDialOpen.value;
              EditBottomSheet().buildEditBottomSheet(
                  context: context,
                  bottomSheet: TimeEntryEditBottomSheet(
                    isUpdate: false,
                    entry: TimeEntry(project: project),
                  ));
            }),
        SpeedDialChild(
            child: Icon(Icons.rule_rounded),
            backgroundColor:
                themeData.colorScheme.surface,
            foregroundColor:
                themeData.colorScheme.secondary,
            onTap: () {
              isDialOpen.value = !isDialOpen.value;
              EditBottomSheet().buildEditBottomSheet(
                  context: context,
                  bottomSheet: TaskEditBottomSheet(
                      isUpdate: false, task: Task(project: project)));
            }),
      ],
      // TODO: Implement Goal/Habits
      // SpeedDialChild(
      //     child: Icon(Icons.bar_chart_rounded,
      //         color: themeData.accentColor),
      //     backgroundColor: themeData.cardColor,
      //     onTap: () {})
    );
  }
}

// bottomNavigationBar: ExpansionTile(
//   collapsedBackgroundColor: Color(project.projectColor),
//   initiallyExpanded: false,
//   title: Text(project.projectName, style: TextStyle(fontWeight: FontWeight.bold),),
//   leading: IconButton(
//     icon: Icon(Icons.add_rounded),
//     onPressed: () {},
//   ),
//   trailing: IconButton(
//     icon: Icon(Icons.edit_rounded),
//     onPressed: () => showModalBottomSheet(
//         context: context,
//         isScrollControlled:
//             true, // Allows the modal to me dynamic and keeps the menu above the keyboard
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(25),
//                 topRight: Radius.circular(25))),
//         builder: (BuildContext context) {
//           return ChangeNotifierProvider(
//             create: (context) => ProjectEditState(),
//             child: ProjectEditBottomSheet(
//               project: project,
//               isUpdate: true,
//             ),
//           );
//         })
//   ),
//   children: [
//     Container(
//       margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           project.projectClient != null
//               ? Text('Client: ${project.projectClient}',
//                   style: themeData.textTheme.subtitle1)
//               : Text(''),
//           Text('Tasks: 10', style: themeData.textTheme.subtitle1),
//         ],
//       ),
//     ),
//     Container(
//       margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text('Time: ${project.projectTime}',
//               style: themeData.textTheme.subtitle1),
//           OutlinedButton.icon(
//             icon: Icon(Icons.playlist_add_check_rounded),
//             label: Text('Tasks\n10'), // TODO: make this a live number
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (BuildContext context) {
//                   return ProjectPage(project: project);
//                 }),
//               );
//             },
//           ),
//         ],
//       ),
//     ),
//   ],
// ),
// bottomSheet:
// ProjectExpansionTile(project: project)

// body: SlidingUpPanel(
//   borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
//   panel: Column(
//     mainAxisAlignment: MainAxisAlignment.spaceAround,
//     mainAxisSize: MainAxisSize.min,
//     children: [
//       Container(
//         margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             project.projectClient != null
//                 ? Text('Client: ${project.projectClient}',
//                     style: themeData.textTheme.subtitle1)
//                 : Text(''),
//             Text('Tasks: 10', style: themeData.textTheme.subtitle1),
//           ],
//         ),
//       ),
//       Container(
//         margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text('Time: ${project.projectTime}',
//                 style: themeData.textTheme.subtitle1),
//             OutlinedButton.icon(
//               icon: Icon(Icons.playlist_add_check_rounded),
//               label: Text('Tasks\n10'), // TODO: make this a live number
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (BuildContext context) {
//                     return ProjectPage(project: project);
//                   }),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     ],
//   ),
//   padding: EdgeInsets.all(20),
//   minHeight: 100,
//   maxHeight: MediaQuery.of(context).size.height / 5,
//   header: Text(project.projectName, style: themeData.textTheme.headline5.copyWith(color: Color(project.projectColor), fontWeight: FontWeight.bold)),
//   // collapsed: Container(
//   //   decoration: BoxDecoration(
//   //     borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
//   //     color: Color(project.projectColor)
//   //   ),
//   //   child: Center(child: Text(project.projectName)),
//   // ),
//   body: TabBarView(
//     children: [
//       HomeScreen(),
//       (tasks.isEmpty
//           ? Center(child: Text('No Tasks for ${project.projectName}'))
//           : TasksByStatus(associatedTasks: tasks)),
//       (timeEntries.isEmpty
//           ? Center(child: Text('No Time Entries for ${project.projectName}'))
//           : TimeEntriesByDay(associatedEntries: timeEntries)),
//       HomeScreen()
//   ]),
// )
