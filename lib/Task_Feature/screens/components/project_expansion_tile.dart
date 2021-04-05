import 'package:flutter/material.dart';
import 'package:productivity_app/Shared/widgets/time_range_picker.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Task_Feature/providers/project_edit_state.dart';
import 'package:productivity_app/Task_Feature/screens/components/grouped_tasks.dart';
import 'package:productivity_app/Task_Feature/screens/components/project_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/components/task_edit_bottomsheet.dart';
import 'package:productivity_app/Shared/functions/datetime_functions.dart';
import 'package:productivity_app/Shared/functions/time_functions.dart';
import 'package:productivity_app/Task_Feature/screens/project_page.dart';
import 'package:provider/provider.dart';
import 'package:simple_time_range_picker/simple_time_range_picker.dart';

class ProjectExpansionTile extends StatelessWidget {
  final Project project;
  const ProjectExpansionTile({Key key, this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        initiallyExpanded: false,
        leading: Icon(
          Icons.circle,
          color: Color(project.projectColor),
        ),
        title: Text(
          project.projectName,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        children: [
          ListTile(
            title: Text('Assigned Tasks: ', style: Theme.of(context).textTheme.subtitle1),
            trailing: IconButton(
              icon: Icon(Icons.add_rounded),
              tooltip: 'Add Task',
              onPressed: () {},
            )
          ),
          ListTile(
            title: Text('Recorded Time: ', style: Theme.of(context).textTheme.subtitle1),
            trailing: RangeTimePicker()
          ),
          ListTile(
            title: Text('Client: ${project.projectClient}', style: Theme.of(context).textTheme.subtitle1),
            trailing: project.projectClient == ''
                ? IconButton(
                  icon: Icon(Icons.person_add_rounded),
                  tooltip: 'Add Client',
                  onPressed: () {},
                )
                : null
          ),
          Container(
            margin: EdgeInsets.all(16),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton.icon(
                  icon: Icon(Icons.edit_rounded),
                  label: Text('Edit Project'),
                  onPressed: () => showModalBottomSheet(
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
                      })
                ),
                // ElevatedButton.icon(
                //   icon: Icon(Icons.edit_rounded),
                //   label: Text('Edit Project'),
                //   onPressed: () => showModalBottomSheet(
                //       context: context,
                //       isScrollControlled:
                //           true, // Allows the modal to me dynamic and keeps the menu above the keyboard
                //       shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.only(
                //               topLeft: Radius.circular(25),
                //               topRight: Radius.circular(25))),
                //       builder: (BuildContext context) {
                //         return ChangeNotifierProvider(
                //           create: (context) => ProjectEditState(),
                //           child: ProjectEditBottomSheet(
                //             project: project,
                //             isUpdate: true,
                //           ),
                //         );
                //       })
                // ),
                ElevatedButton.icon(
                  icon: Icon(Icons.open_with_rounded),
                  label: Text('Project Page'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) {
                        return ProjectPage(project: project);
                      }),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
