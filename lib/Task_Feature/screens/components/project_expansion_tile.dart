import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Shared/Shared.dart';
import '../../../Task_Feature/Task_Feature.dart';
import '../../../Time_Feature/Time_Feature.dart';
import '../../../Services/database.dart';

class ProjectExpansionTile extends StatelessWidget {
  final Project project;
  const ProjectExpansionTile({Key? key, required this.project})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MaterialColor> colorList = AppColorList;
    ThemeData themeData = DynamicColorTheme.of(context).data;
    final DatabaseService databaseService =
        Provider.of<DatabaseService>(context);
    List<TimeEntry> timeEntries = TimeService.getTimeEntriesByProject(
        Provider.of<List<TimeEntry>>(context), project);
    List<Task> tasks = Provider.of<List<Task>>(context);
    int recordedTime = ProjectService.getRecordedTime(timeEntries);
    int projectTaskCount = ProjectService.getTaskCount(
        tasks.where((task) => task.project?.id == project.id).toList());
    return Theme(
      data: themeData
          .copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        leading: Icon(
          Icons.topic_rounded,
          color: project.projectColor != null
                  ? DynamicColorTheme.of(context).isDark
                      ? colorList[project.projectColor!].shade200
                      : colorList[project.projectColor!]
                  : Colors.grey,
        ),
        title: Text(
          project.projectName ?? 'NO PROJECT TITLES',
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
                                      collectionReference:
                                          databaseService.projectReference!,
                                      objectID: project.id!);
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
                leading: Text('Tasks: $projectTaskCount',
                    style:
                        themeData.textTheme.subtitle2),
                trailing: Text(
                    'Recorded Time: ${DateTimeFunctions().timeToText(seconds: recordedTime)}',
                    style:
                        themeData.textTheme.subtitle2),
              ),
              project.projectClient != null
                  ? ListTile(leading: Text('Client: ${project.projectClient}'))
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }
}
