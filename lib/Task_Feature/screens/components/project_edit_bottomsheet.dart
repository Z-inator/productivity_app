import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Services/database.dart';
import 'package:productivity_app/Shared/widgets/color_selector.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/providers/project_edit_state.dart';
import 'package:productivity_app/Task_Feature/services/projects_data.dart';
import 'package:productivity_app/Shared/functions/color_functions.dart';
import 'package:provider/provider.dart';

class ProjectEditBottomSheet extends StatelessWidget {
  final bool isUpdate;
  final Project project;
  const ProjectEditBottomSheet({Key key, this.isUpdate, this.project})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProjectEditState(oldProject: project),
      builder: (context, child) {
        final DatabaseService databaseService =
            Provider.of<DatabaseService>(context);
        final state = Provider.of<ProjectEditState>(context);
        return Container(
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                    hintText: state.newProject.projectName.isEmpty
                        ? 'Project Name'
                        : state.newProject.projectName),
                textAlign: TextAlign.center,
                onChanged: (newText) {
                  state.updateProjectName(newText);
                },
              ),
              ColorSelector(
                saveColor: state.updateProjectColor,
                matchColor: state.newProject.projectColor,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: state.newProject.projectClient.isEmpty
                        ? 'Add Client'
                        : state.newProject.projectClient),
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
                        isUpdate
                            ? databaseService.updateItem(
                                type: 'projects',
                                itemID: project.id,
                                updateData: state.newProject.toFirestore())
                            : databaseService.addItem(
                                type: 'projects',
                                addData: state.newProject.toFirestore());
                        Navigator.pop(context);
                      }))
            ],
          ),
        );
      },
    );
  }
}
