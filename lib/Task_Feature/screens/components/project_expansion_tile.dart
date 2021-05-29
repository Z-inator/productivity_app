import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Services/database.dart';
import 'package:productivity_app/Shared/functions/datetime_functions.dart';
import 'package:productivity_app/Shared/providers/stopwatch_state.dart';
import 'package:productivity_app/Shared/widgets/edit_bottom_sheets.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Task_Feature/screens/components/project_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/components/task_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/project_page.dart';
import 'package:productivity_app/Task_Feature/services/projects_data.dart';
import 'package:productivity_app/Time_Feature/models/times.dart';
import 'package:productivity_app/Time_Feature/screens/components/time_entry_edit_bottomsheet.dart';
import 'package:productivity_app/Time_Feature/services/times_data.dart';
import 'package:provider/provider.dart';

class ProjectExpansionTile extends StatelessWidget {
  final Project project;
  final int numberOfTasks;
  const ProjectExpansionTile({Key key, this.project, this.numberOfTasks})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DatabaseService databaseService =
        Provider.of<DatabaseService>(context);
    final ProjectService projectService = Provider.of<ProjectService>(context);
    final TimeService timeService = Provider.of<TimeService>(context);
    final List<TimeEntry> timeEntries = timeService.getTimeEntriesByProject(
        Provider.of<List<TimeEntry>>(context), project);
    final int recordedTime = projectService.getRecordedTime(timeEntries);
    return Theme(
      data: DynamicTheme.of(context)
          .theme
          .copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        leading: Icon(
          Icons.topic_rounded,
          color: Color(project.projectColor),
        ),
        title: Text(
          project.projectName.isEmpty
              ? 'NO PROJECT TITLES'
              : project.projectName,
          style: DynamicTheme.of(context)
              .theme
              .textTheme
              .subtitle1
              .copyWith(fontWeight: FontWeight.bold),
        ),
        children: [
          ExpansionTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.play_arrow_rounded),
                  tooltip: 'Start Timer',
                  onPressed: () => Provider.of<StopwatchState>(context,
                          listen: false)
                      .startStopwatch(oldEntry: TimeEntry(project: project)),
                ),
                IconButton(
                    icon: Icon(Icons.timelapse_rounded),
                    tooltip: 'Add Time Entry',
                    onPressed: () => EditBottomSheet().buildEditBottomSheet(
                        context: context,
                        bottomSheet: TimeEntryEditBottomSheet(
                            isUpdate: false,
                            entry: TimeEntry(project: project)))),
                IconButton(
                  icon: Icon(Icons.delete_rounded),
                  tooltip: 'Delete Project',
                  onPressed: () => showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title:
                              Text('Delete Project: ${project.projectName}?'),
                          content: ListTile(
                            title: Text(
                                'This will permanently delete this project.\nIt will not delete related time entries or tasks.'),
                          ),
                          actions: [
                            OutlinedButton.icon(
                              icon: Icon(Icons.cancel_rounded),
                              label: Text('Cancel'),
                              onPressed: () => Navigator.pop(context),
                            ),
                            ElevatedButton.icon(
                                icon: Icon(Icons.check_circle_outline_rounded),
                                label: Text('Delete'),
                                onPressed: () {
                                  databaseService.deleteItem(
                                      type: 'projects', itemID: project.id);
                                  Navigator.pop(context);
                                })
                          ],
                        );
                      }),
                ),
                IconButton(
                  icon: Icon(Icons.edit_rounded),
                  tooltip: 'Edit Project',
                  onPressed: () => EditBottomSheet().buildEditBottomSheet(
                      context: context,
                      bottomSheet: ProjectEditBottomSheet(
                          isUpdate: true, project: project)),
                ),
                IconButton(
                  icon: Icon(Icons.add_rounded),
                  tooltip: 'Add Task',
                  onPressed: () => EditBottomSheet().buildEditBottomSheet(
                      context: context,
                      bottomSheet: TaskEditBottomSheet(
                          isUpdate: false, task: Task(project: project))),
                ),
                IconButton(
                    icon: Icon(Icons.topic_rounded),
                    tooltip: 'Project Page',
                    onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (BuildContext context) {
                            return ProjectPage(project: project);
                          }),
                        )),
              ],
            ),
            children: [
              ListTile(
                leading: Text('Tasks: $numberOfTasks',
                    style: DynamicTheme.of(context).theme.textTheme.subtitle2),
                trailing: Text(
                    'Recorded Time: ${DateTimeFunctions().timeToText(seconds: recordedTime)}',
                    style: DynamicTheme.of(context).theme.textTheme.subtitle2),
              ),
              if (project.projectClient.isNotEmpty) ListTile(
                      title: Text('Client: ${project.projectClient}',
                          style: DynamicTheme.of(context)
                              .theme
                              .textTheme
                              .subtitle1),
                    ) else Container(),
            ],
          ),
        ],
      ),
    );
  }
}
