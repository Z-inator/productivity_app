import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/services/projects_data.dart';
import 'package:productivity_app/Shared/color_functions.dart';
import 'package:productivity_app/Shared/time_functions.dart';
import 'package:provider/provider.dart';

class ProjectEditBottomSheet extends StatefulWidget {
  final Project project;
  ProjectEditBottomSheet({this.project});

  @override
  _ProjectEditBottomSheetState createState() => _ProjectEditBottomSheetState();
}

class _ProjectEditBottomSheetState extends State<ProjectEditBottomSheet> {
  Project newProject = Project();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: (newProject.projectName == null)
                  ? (widget.project.projectName ?? 'Select Project')
                  : newProject.projectName,
            ),
            textAlign: TextAlign.center,
            onChanged: (newText) {
              newProject.projectName = newText;
            },
          ),
          // TODO: this widget is causing errors
          StatefulBuilder(
              builder: (BuildContext context, StateSetter colorSetState) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 20),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ProjectColors().colorList.map((color) {
                  return IconButton(
                      icon: (newProject.projectColor == null) ? 
                          (widget.project.projectColor == color ? Icon(Icons.check_circle_rounded, color: Color(color), size: 36) : Icon(Icons.circle, color: Color(color), size: 36))
                          :
                          (newProject.projectColor == color ? Icon(Icons.check_circle_rounded, color: Color(color), size: 36) : Icon(Icons.circle, color: Color(color), size: 36)),
                      onPressed: () {
                        colorSetState(() {
                          newProject.projectColor = color;
                        });
                      });
                }).toList(),
              ),
            );
          }),
          TextField(
            decoration: InputDecoration(
                hintText: widget.project.projectClient ?? 'Client Name'),
            textAlign: TextAlign.center,
            onChanged: (newText) {
              newProject.projectClient = newText;
            },
          ),
          Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton.icon(
                icon: Icon(Icons.check_circle_outline_rounded),
                label: Text('Submit'),
                onPressed: () {
                  ProjectService().updateProject(
                      projectID: widget.project.projectID,
                      updateData: {
                        'projectName':
                            newProject.projectName ?? widget.project.projectName,
                        'projectClient':
                            newProject.projectClient ?? widget.project.projectClient,
                        'projectColor':
                            newProject.projectColor ?? widget.project.projectColor
                      });
                  Navigator.pop(context);
                },
              ))
        ],
      ),
    );
  }
}
