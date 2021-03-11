import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/services/projects_data.dart';
import 'package:productivity_app/shared_components/color_functions.dart';
import 'package:productivity_app/shared_components/time_functions.dart';
import 'package:provider/provider.dart';

class ProjectEditBottomSheet extends StatefulWidget {
  final String projectName;
  final Color projectColor;
  final String projectClient;
  final String projectID;
  ProjectEditBottomSheet(
      {this.projectName,
      this.projectColor,
      this.projectClient,
      this.projectID});

  @override
  _ProjectEditBottomSheetState createState() => _ProjectEditBottomSheetState();
}

class _ProjectEditBottomSheetState extends State<ProjectEditBottomSheet> {
  String newProjectName;

  String newClientName;

  Color newProjectColor;

  int newProjectColorValue;

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration:
                InputDecoration(hintText: widget.projectName ?? 'Project Name'),
            textAlign: TextAlign.center,
            onChanged: (newText) {
              newProjectName = newText;
            },
          ),
          StatefulBuilder(
              builder: (BuildContext context, StateSetter modalSetState) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 20),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ProjectColors().colorList.map((color) {
                  return IconButton(
                      icon: (newProjectColor ?? widget.projectColor) == Color(color)
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
                        modalSetState(() {
                          newProjectColor = Color(color);
                        });
                      });
                }).toList(),
              ),
            );
          }),
          TextField(
            decoration:
                InputDecoration(hintText: widget.projectClient ?? 'Client Name'),
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
                  ProjectService(user: user)
                      .updateProject(projectID: widget.projectID, updateData: {
                    'projectName': newProjectName ?? widget.projectName,
                    'projectClient': newClientName ?? widget.projectClient,
                    'projectColor':
                        int.parse('0x${newProjectColor.value.toRadixString(16).toUpperCase().toString()}')
                        ??
                        int.parse('0x${widget.projectColor.value.toRadixString(16).toUpperCase().toString()}')
                  });
                  Navigator.pop(context);
                },
              ))
        ],
      ),
    );
  }
}
