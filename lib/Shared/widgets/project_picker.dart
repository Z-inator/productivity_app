import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/providers/task_edit_state.dart';
import 'package:provider/provider.dart';

class ProjectPicker extends StatelessWidget {
  const ProjectPicker({Key key,this.saveProject})
      : super(key: key);

  final Function(Project) saveProject;

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<TaskEditState>(context);

    final List<Project> projects = Provider.of<List<Project>>(context);
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25))),
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry>[
          PopupMenuItem(
            child: Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width / 2,
              child: ListView(
                children: projects.map((project) {
                  return ListTile(
                    leading: Icon(
                      Icons.circle,
                      color: Color(project.projectColor),
                    ),
                    title: Text(project.projectName,
                        style: Theme.of(context).textTheme.subtitle1),
                    onTap: () {
                      state.updateTaskProject(project);
                      Navigator.pop(context);
                    },
                  );
                }).toList(),
              ),
            ),
          )
        ];
      },
      child: ListTile(
        leading: Icon(
          Icons.circle,
          color: Color(state.isUpdate ? state.newTask.project.projectColor : 0x8A000000),
        ),
        title: Text(state.isUpdate ? state.newTask.project.projectName : 'Add Project',
            style: Theme.of(context).textTheme.subtitle1),
        trailing: Icon(Icons.arrow_drop_down_rounded,
            color: Theme.of(context).unselectedWidgetColor),
      ),
    );
  }
}