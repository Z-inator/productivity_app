import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/providers/task_edit_state.dart';
import 'package:provider/provider.dart';

class ProjectPicker extends StatelessWidget {
  final Function(Project) saveProject;
  final Widget child;
  const ProjectPicker({Key key, this.saveProject, this.child})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    final List<Project> projects = Provider.of<List<Project>>(context);
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25))),
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry>[
          PopupMenuItem(
            child: ListTile(
              leading: Icon(
                Icons.topic_rounded,
                color: Color(4285887861),
              ),
              title: Text('No Project',
                  style: Theme.of(context).textTheme.subtitle1),
              onTap: () {
                saveProject(Project());
                Navigator.pop(context);
              },
            )
          ),
          PopupMenuDivider(),
          PopupMenuItem(
            child: Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                children: projects.map((project) {
                  return ListTile(
                    leading: Icon(
                      Icons.topic_rounded,
                      color: Color(project.projectColor),
                    ),
                    title: Text(project.projectName,
                        style: Theme.of(context).textTheme.subtitle1),
                    onTap: () {
                      saveProject(project);
                      Navigator.pop(context);
                    },
                  );
                }).toList(),
              ),
            ),
          )
        ];
      },
      child: child
    );
  }
}
