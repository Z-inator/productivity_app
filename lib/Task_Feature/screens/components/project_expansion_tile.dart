import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Shared/Shared.dart';
import '../../../Task_Feature/Task_Feature.dart';
import '../../../Time_Feature/Time_Feature.dart';
import '../../../Services/database.dart';

class ProjectExpansionTile extends StatelessWidget {
  final Project? project;
  final int? numberOfTasks;
  const ProjectExpansionTile({Key? key, this.project, this.numberOfTasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MaterialColor> colorList = AppColorList;
    final DatabaseService databaseService =
        Provider.of<DatabaseService>(context);
    final ProjectService projectService = Provider.of<ProjectService>(context);
    final TimeService timeService = Provider.of<TimeService>(context);
    List<TimeEntry> timeEntries = timeService.getTimeEntriesByProject(
        Provider.of<List<TimeEntry>>(context), project);
    int recordedTime = projectService.getRecordedTime(timeEntries);
    return Theme(
      data: DynamicColorTheme.of(context)
          .data
          .copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        leading: Icon(
          Icons.topic_rounded,
          color: DynamicColorTheme.of(context).isDark ? colorList[project!.projectColor].shade200 : colorList[project!.projectColor],
        ),
        title: Text(
          project!.projectName.isEmpty
              ? 'NO PROJECT TITLES'
              : project!.projectName,
          style: DynamicColorTheme.of(context)
              .data
              .textTheme
              .subtitle1!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        children: [
          ExpansionTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
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
                              Text('Delete Project: ${project!.projectName}?'),
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
                                      type: 'projects', itemID: project!.id);
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
                    style:
                        DynamicColorTheme.of(context).data.textTheme.subtitle2),
                trailing: Text(
                    'Recorded Time: ${DateTimeFunctions().timeToText(seconds: recordedTime)}',
                    style:
                        DynamicColorTheme.of(context).data.textTheme.subtitle2),
              ),
              project!.projectClient.isNotEmpty
                  ? ListTile(
                      title: Text('Client: ${project!.projectClient}',
                          style: DynamicColorTheme.of(context)
                              .data
                              .textTheme
                              .subtitle1),
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }
}
