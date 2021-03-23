import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/models/projects.dart';
import 'package:productivity_app/services/projects_data.dart';
import 'package:productivity_app/shared_components/color_functions.dart';
import 'package:productivity_app/shared_components/time_functions.dart';
import 'package:provider/provider.dart';

class ProjectEditBottomSheet extends StatefulWidget {
  final Project project;
  ProjectEditBottomSheet({this.project});

  @override
  _ProjectEditBottomSheetState createState() => _ProjectEditBottomSheetState();
}

class _ProjectEditBottomSheetState extends State<ProjectEditBottomSheet> {
  String newProjectName;
  String newClientName;
  Color newProjectColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration:
                InputDecoration(hintText: widget.project.projectName ?? 'Project Name'),
            textAlign: TextAlign.center,
            onChanged: (newText) {
              newProjectName = newText;
            },
          ),
          StatefulBuilder(
              builder: (BuildContext context, StateSetter colorSetState) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 20),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ProjectColors().colorList.map((color) {
                  return IconButton(
                      icon: (newProjectColor ?? Color(widget.project.projectColor)) ==
                              Color(color)
                          ? Icon(
                              Icons.check_circle_rounded,
                              color: Color(color),
                              size: 36,
                            )
                          : Icon(
                              Icons.circle,
                              color: Color(color),
                              size: 36,
                            ),
                      onPressed: () {
                        colorSetState(() {
                          newProjectColor = Color(color);
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
              newClientName = newText;
            },
          ),
          Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton.icon(
                icon: Icon(Icons.check_circle_outline_rounded),
                label: Text('Submit'),
                onPressed: () {
                  ProjectService()
                      .updateProject(projectID: widget.project.projectID, updateData: {
                    'projectName': newProjectName ?? widget.project.projectName,
                    'projectClient': newClientName ?? widget.project.projectClient,
                    'projectColor': int.parse(
                            '0x${newProjectColor.value.toRadixString(16).toUpperCase().toString()}') ??
                        int.parse(
                            '0x${widget.project.projectColor.toString()}')
                  });
                  Navigator.pop(context);
                },
              ))
        ],
      ),
    );
  }
}
