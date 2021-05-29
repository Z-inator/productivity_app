import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Home_Dashboard/screens/home_screen.dart';
import 'package:productivity_app/Shared/widgets/edit_bottom_sheets.dart';
import 'package:productivity_app/Shared/widgets/flutter_speed_dial/flutter_speed_dial.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/status.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Task_Feature/screens/components/project_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/components/status_expansion_tile.dart';
import 'package:productivity_app/Task_Feature/screens/components/task_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/components/task_list_tab.dart';
import 'package:productivity_app/Task_Feature/services/tasks_data.dart';
import 'package:productivity_app/Time_Feature/models/times.dart';
import 'package:productivity_app/Time_Feature/screens/components/time_entries_list.dart';
import 'package:productivity_app/Time_Feature/screens/components/time_entry_edit_bottomsheet.dart';
import 'package:provider/provider.dart';

class ProjectPage extends StatelessWidget {
  final Project project;
  List<Map<dynamic, List<Task>>> taskMap = [];
  List<Task> tasks;
  List<Status> statuses;
  List<TimeEntry> timeEntries;
  ProjectPage({this.project});

  @override
  Widget build(BuildContext context) {
    final TaskService taskService = Provider.of<TaskService>(context);
    final List<Task> tasks = Provider.of<List<Task>>(context)
        .where((task) => task.project.id == project.id)
        .toList();
    final List<Status> statuses = Provider.of<List<Status>>(context);
    taskMap = taskService.getTasksByStatus(tasks, statuses);
    final List<TimeEntry> timeEntries = Provider.of<List<TimeEntry>>(context)
        .where((entry) => entry.project.id == project.id)
        .toList();
    return SafeArea(
        child: DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            project.projectName,
            style: TextStyle(color: Color(project.projectColor)),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.edit_rounded,
                  color: DynamicTheme.of(context).theme.unselectedWidgetColor,
                ),
                onPressed: () => EditBottomSheet().buildEditBottomSheet(
                    context: context,
                    bottomSheet: ProjectEditBottomSheet(
                        isUpdate: true, project: project))),
          ],
          bottom: TabBar(
              unselectedLabelColor:
                  DynamicTheme.of(context).theme.unselectedWidgetColor,
              labelColor: Colors.black,
              tabs: [
                Tab(icon: Icon(Icons.dashboard_rounded)),
                Tab(icon: Icon(Icons.playlist_add_check_rounded)),
                Tab(icon: Icon(Icons.timer_rounded)),
                Tab(icon: Icon(Icons.bar_chart_rounded))
              ]),
        ),
        body: TabBarView(children: [
          HomeScreen(),
          if (tasks.isEmpty) Center(child: Text('No Tasks for ${project.projectName}')) else TaskList(
                  taskMap: taskMap,
                  getWidget: (item, numberOfTasks) => StatusExpansionTile(
                      status: item as Status, numberOfTasks: numberOfTasks)),
          if (timeEntries.isEmpty) Center(
                  child: Text('No Time Recorded for ${project.projectName}')) else TimeEntriesByDay(timeEntries: timeEntries),
          HomeScreen()
        ]),
        floatingActionButton: ProjectPageSpeedDial(project: project),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
      ),
    ));
  }
}

class ProjectPageSpeedDial extends StatelessWidget {
  final Project project;
  const ProjectPageSpeedDial({Key key, this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      icon: Icons.add_rounded,
      iconTheme: IconThemeData(size: 40),
      activeIcon: Icons.close_rounded,
      renderOverlay: false,
      curve: Curves.bounceIn,
      tooltip: 'Add Menu',
      buttonSize: 40,
      childrenButtonSize: 40,
      backgroundColor: DynamicTheme.of(context).theme.accentColor,
      foregroundColor: DynamicTheme.of(context).theme.primaryColor,
      elevation: 4,
      shape: CircleBorder(),
      children: [
        SpeedDialChild(
            child: Icon(Icons.timer_rounded,
                color: DynamicTheme.of(context).theme.accentColor),
            backgroundColor: DynamicTheme.of(context).theme.cardColor,
            onTap: () {} //TODO: add timer start here
            ),
        SpeedDialChild(
            child: Icon(Icons.timelapse_rounded,
                color: DynamicTheme.of(context).theme.accentColor),
            backgroundColor: DynamicTheme.of(context).theme.cardColor,
            onTap: () => EditBottomSheet().buildEditBottomSheet(
                context: context,
                bottomSheet: TimeEntryEditBottomSheet(
                    isUpdate: false, entry: TimeEntry(project: project)))),
        SpeedDialChild(
            child: Icon(Icons.rule_rounded,
                color: DynamicTheme.of(context).theme.accentColor),
            backgroundColor: DynamicTheme.of(context).theme.cardColor,
            onTap: () => EditBottomSheet().buildEditBottomSheet(
                context: context,
                bottomSheet: TaskEditBottomSheet(
                    isUpdate: false, task: Task(project: project)))),
      ],
      // TODO: Implement Goal/Habits
      // SpeedDialChild(
      //     child: Icon(Icons.bar_chart_rounded,
      //         color: DynamicTheme.of(context).theme.accentColor),
      //     backgroundColor: DynamicTheme.of(context).theme.cardColor,
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
//                   style: DynamicTheme.of(context).theme.textTheme.subtitle1)
//               : Text(''),
//           Text('Tasks: 10', style: DynamicTheme.of(context).theme.textTheme.subtitle1),
//         ],
//       ),
//     ),
//     Container(
//       margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text('Time: ${project.projectTime}',
//               style: DynamicTheme.of(context).theme.textTheme.subtitle1),
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
//                     style: DynamicTheme.of(context).theme.textTheme.subtitle1)
//                 : Text(''),
//             Text('Tasks: 10', style: DynamicTheme.of(context).theme.textTheme.subtitle1),
//           ],
//         ),
//       ),
//       Container(
//         margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text('Time: ${project.projectTime}',
//                 style: DynamicTheme.of(context).theme.textTheme.subtitle1),
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
//   header: Text(project.projectName, style: DynamicTheme.of(context).theme.textTheme.headline5.copyWith(color: Color(project.projectColor), fontWeight: FontWeight.bold)),
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
