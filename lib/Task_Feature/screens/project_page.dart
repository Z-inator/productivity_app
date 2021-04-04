import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Task_Feature/providers/project_edit_state.dart';
import 'package:productivity_app/Task_Feature/screens/components/project_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/components/project_expansion_tile.dart';
import 'package:productivity_app/Task_Feature/screens/components/task_expansion_tile.dart';
import 'package:productivity_app/Task_Feature/screens/task_by_status.dart';
import 'package:productivity_app/Task_Feature/services/projects_data.dart';
import 'package:productivity_app/Task_Feature/services/tasks_data.dart';
import 'package:productivity_app/Shared/functions/color_functions.dart';
import 'package:productivity_app/Shared/functions/datetime_functions.dart';
import 'package:productivity_app/Shared/functions/time_functions.dart';
import 'package:productivity_app/Time_Feature/models/times.dart';
import 'package:productivity_app/Time_Feature/screens/time_entries_by_day.dart';
import 'package:productivity_app/Time_Feature/screens/time_stream.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ProjectPage extends StatelessWidget {
  final Project project;
  ProjectPage({this.project});

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
    List<Task> tasks = Provider.of<List<Task>>(context);
    List<TimeEntry> timeEntries = Provider.of<List<TimeEntry>>(context);
    tasks = filteredTasks(tasks);
    timeEntries = filteredTimeEntries(timeEntries);
    return SafeArea(
      child: DefaultTabController(
        length: 2,
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
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled:
                            true, // Allows the modal to me dynamic and keeps the menu above the keyboard
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25))),
                        builder: (BuildContext context) {
                          return ChangeNotifierProvider(
                            create: (context) => ProjectEditState(),
                            child: ProjectEditBottomSheet(
                              project: project,
                              isUpdate: true,
                            ),
                          );
                        });
                  },
                )
              ],
              bottom: TabBar(
                  unselectedLabelColor: Colors.grey,
                  labelColor: Colors.black,
                  tabs: [
                    Tab(
                      text: 'Tasks',
                    ),
                    Tab(
                      text: 'Time Entries',
                    )
                  ]),
            ),
            //TODO: implement an expansiontile as bottomsheet for project details

            // body: SlidingUpPanel(
            //   borderRadius: BorderRadius.circular(25),
            //   panel: Scaffold(
            //     body: Center(child: Text('info')),
            //     floatingActionButton: FloatingActionButton.extended(
            //       backgroundColor: Color(project.projectColor),
            //       onPressed: () {},
            //       label: Text(project.projectName),
            //     ),
            //     floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
            //   ),
            //   collapsed: Container(
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(25)
            //     ),
            //   ),
            //   body: TabBarView(
            //     children: [
            //       (tasks.isEmpty
            //           ? Center(child: Text('No Tasks for ${project.projectName}'))
            //           : TasksByStatus(associatedTasks: tasks)),
            //       (timeEntries.isEmpty
            //           ? Center(child: Text('No Time Entries for ${project.projectName}'))
            //           : TimeEntriesByDay(associatedEntries: timeEntries))
            //   ]),
            // )
        ),
      ),
    );
  }
}

