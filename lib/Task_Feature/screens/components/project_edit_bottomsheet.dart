import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Shared/widgets/color_selector.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/providers/project_edit_state.dart';
import 'package:productivity_app/Task_Feature/services/projects_data.dart';
import 'package:productivity_app/Shared/functions/color_functions.dart';
import 'package:productivity_app/Shared/functions/time_functions.dart';
import 'package:provider/provider.dart';

class ProjectEditBottomSheet extends StatelessWidget {
  final Project project;
  final bool isUpdate;
  ProjectEditBottomSheet({this.project, this.isUpdate});

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<ProjectEditState>(context);
    isUpdate ? state.updateProject(project) : state.addProject();
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: state.newProject.projectName ?? 'Project Name'),
            textAlign: TextAlign.center,
            onChanged: (newText) {
              state.updateProjectName(newText);
            },
          ),
          ColorSelector(saveColor: state.updateProjectColor, matchColor: state.newProject.projectColor,
          ),
          TextField(
            decoration: InputDecoration(
                hintText: state.newProject.projectClient ?? 'Client Name'),
            textAlign: TextAlign.center,
            onChanged: (newText) {
              state.updateProjectClient(newText);
            },
          ),
          Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton.icon(
                icon: Icon(Icons.check_circle_outline_rounded),
                label: Text(isUpdate ? 'Update' : 'Add'),
                onPressed: () {
                  // ProjectService().updateProject(
                  //     projectID: widget.project.projectID,
                  //     updateData: {
                  //       'projectName': newProject.projectName ??
                  //           widget.project.projectName,
                  //       'projectClient': newProject.projectClient ??
                  //           widget.project.projectClient,
                  //       'projectColor': newProject.projectColor ??
                  //           widget.project.projectColor
                  //     });
                  Navigator.pop(context);
                },
              ))
        ],
      ),
    );
  }
}
