import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Task_Feature/providers/project_edit_state.dart';
import 'package:productivity_app/Task_Feature/screens/components/grouped_tasks.dart';
import 'package:productivity_app/Task_Feature/screens/components/project_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/components/task_edit_bottomsheet.dart';
import 'package:productivity_app/Shared/functions/datetime_functions.dart';
import 'package:productivity_app/Shared/functions/time_functions.dart';
import 'package:provider/provider.dart';

class ProjectExpansionTile extends StatelessWidget {
  final Project project;
  const ProjectExpansionTile({Key key, this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          accentColor: Theme.of(context).unselectedWidgetColor,
        ),
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
          trailing: IconButton(
              icon: Icon(Icons.edit_rounded),
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
              }),
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  project.projectClient != null 
                  ? Text('Client: ${project.projectClient}',
                      style: Theme.of(context).textTheme.subtitle1)
                  : Text(''),
                  Text('Tasks: 10',
                      style: Theme.of(context).textTheme.subtitle1),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Time: ${project.projectTime}',
                      style: Theme.of(context).textTheme.subtitle1),
                  OutlinedButton.icon(
                    icon: Icon(Icons.playlist_add_check_rounded),
                    label: Text('Tasks\n10'), // TODO: make this a live number
                    onPressed: () {
                      Navigator.pushNamed(context, '/projectscreen',
                          arguments: project);
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
