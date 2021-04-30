import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Home_Dashboard/screens/components/home_page_dashboard.dart';
import 'package:productivity_app/Home_Dashboard/screens/home_screen.dart';
import 'package:productivity_app/Shared/widgets/edit_bottom_sheets.dart';
import 'package:productivity_app/Shared/widgets/flutter_speed_dial/flutter_speed_dial.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Task_Feature/providers/project_edit_state.dart';
import 'package:productivity_app/Task_Feature/providers/task_edit_state.dart';
import 'package:productivity_app/Task_Feature/screens/components/grouped_tasks.dart';
import 'package:productivity_app/Task_Feature/screens/components/project_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/components/project_expansion_tile.dart';
import 'package:productivity_app/Task_Feature/screens/components/task_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/components/task_expansion_tile.dart';
import 'package:productivity_app/Task_Feature/screens/task_by_status.dart';
import 'package:productivity_app/Task_Feature/services/projects_data.dart';
import 'package:productivity_app/Task_Feature/services/tasks_data.dart';
import 'package:productivity_app/Shared/functions/color_functions.dart';
import 'package:productivity_app/Shared/functions/datetime_functions.dart';
import 'package:productivity_app/Shared/functions/time_functions.dart';
import 'package:productivity_app/Time_Feature/models/times.dart';
import 'package:productivity_app/Time_Feature/screens/components/time_entry_edit_bottomsheet.dart';
import 'package:productivity_app/Time_Feature/screens/time_entries_by_day.dart';
import 'package:productivity_app/Time_Feature/services/times_data.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ProjectPage extends StatelessWidget {
  final Project project;
  const ProjectPage({this.project});

  List<Task> filteredTasks(List<Task> tasks) {
    return tasks
        .where((task) => task.project.projectName == project.projectName)
        .toList();
  }

  List<TimeEntry> filteredTimeEntries(List<TimeEntry> timeEntries) {
    return timeEntries
        .where((entry) => entry.project.projectName == project.projectName)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    TaskService taskService = Provider.of<TaskService>(context);
    List<Task> tasks = taskService.getTasksByProject(
        Provider.of<List<Task>>(context), project);
    TimeService timeService = Provider.of<TimeService>(context);
    List<TimeEntry> timeEntries = timeService.getTimeEntriesByProject(
        Provider.of<List<TimeEntry>>(context), project);
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
                  color: Theme.of(context).unselectedWidgetColor,
                ),
                onPressed: () => EditBottomSheet().buildEditBottomSheet(
                    context: context,
                    bottomSheet: ProjectEditBottomSheet(
                        isUpdate: true, project: project))),
          ],
          bottom: TabBar(
              unselectedLabelColor: Theme.of(context).unselectedWidgetColor,
              labelColor: Colors.black,
              tabs: [
                Tab(icon: Icon(Icons.dashboard_rounded)),
                Tab(icon: Icon(Icons.timer_rounded)),
                Tab(icon: Icon(Icons.playlist_add_check_rounded)),
                Tab(icon: Icon(Icons.bar_chart_rounded))
              ]),
        ),
        body: TabBarView(children: [
          HomeScreen(),
          (timeEntries.isEmpty
              ? Center(
                  child: Text('No Time Recorded for ${project.projectName}'))
              : TimeEntriesByDay(timeEntries: timeEntries)),
          (tasks.isEmpty
              ? Center(child: Text('No Tasks for ${project.projectName}'))
              : TasksByStatus(associatedTasks: tasks)),
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
      backgroundColor: Theme.of(context).accentColor,
      foregroundColor: Theme.of(context).primaryColor,
      elevation: 4,
      shape: CircleBorder(),
      children: [
        SpeedDialChild(
            child:
                Icon(Icons.timer_rounded, color: Theme.of(context).accentColor),
            backgroundColor: Theme.of(context).cardColor,
            onTap: () {} //TODO: add timer start here
            ),
        SpeedDialChild(
            child: Icon(Icons.timelapse_rounded,
                color: Theme.of(context).accentColor),
            backgroundColor: Theme.of(context).cardColor,
            onTap: () => EditBottomSheet().buildEditBottomSheet(
                context: context,
                bottomSheet: TimeEntryEditBottomSheet(
                    isUpdate: false, project: project))),
        SpeedDialChild(
            child:
                Icon(Icons.rule_rounded, color: Theme.of(context).accentColor),
            backgroundColor: Theme.of(context).cardColor,
            onTap: () => EditBottomSheet().buildEditBottomSheet(
                context: context,
                bottomSheet:
                    TaskEditBottomSheet(isUpdate: false, task: Task(project: project)))),
      ],
      // TODO: Implement Goal/Habits
      // SpeedDialChild(
      //     child: Icon(Icons.bar_chart_rounded,
      //         color: Theme.of(context).accentColor),
      //     backgroundColor: Theme.of(context).cardColor,
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
//                   style: Theme.of(context).textTheme.subtitle1)
//               : Text(''),
//           Text('Tasks: 10', style: Theme.of(context).textTheme.subtitle1),
//         ],
//       ),
//     ),
//     Container(
//       margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text('Time: ${project.projectTime}',
//               style: Theme.of(context).textTheme.subtitle1),
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
//                     style: Theme.of(context).textTheme.subtitle1)
//                 : Text(''),
//             Text('Tasks: 10', style: Theme.of(context).textTheme.subtitle1),
//           ],
//         ),
//       ),
//       Container(
//         margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text('Time: ${project.projectTime}',
//                 style: Theme.of(context).textTheme.subtitle1),
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
//   header: Text(project.projectName, style: Theme.of(context).textTheme.headline5.copyWith(color: Color(project.projectColor), fontWeight: FontWeight.bold)),
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
