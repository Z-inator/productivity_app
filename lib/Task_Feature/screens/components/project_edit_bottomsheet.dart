import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Shared/Shared.dart';
import '../../../Task_Feature/Task_Feature.dart';
import '../../../Services/database.dart';

class ProjectEditBottomSheet extends StatelessWidget {
  bool isUpdate;
  Project? project;
  ProjectEditBottomSheet({Key? key, required this.isUpdate, this.project})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProjectEditState(oldProject: project),
      builder: (context, child) {
        final DatabaseService databaseService =
            Provider.of<DatabaseService>(context);
        final projectEditState = Provider.of<ProjectEditState>(context);
        return Container(
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                    hintText: projectEditState.newProject.projectName ?? 'Project Name'),
                textAlign: TextAlign.center,
                onChanged: (newText) {
                  projectEditState.updateProjectName(newText);
                },
              ),
              ColorSelector(
                matchColor: isUpdate
                    ? DynamicColorTheme.of(context).isDark
                        ? AppColorList[projectEditState.newProject.projectColor!]
                            .shade200
                            .value
                        : AppColorList[projectEditState.newProject.projectColor!]
                            .value
                    : Colors.grey.value,
                saveColor: projectEditState.updateProjectColor,
                colorList: AppColorList,
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: projectEditState.newProject.projectClient ?? 'Add Client'),
                textAlign: TextAlign.center,
                onChanged: (newText) {
                  projectEditState.updateProjectClient(newText);
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
                                collectionReference: databaseService.projectReference,
                                objectID: project!.id,
                                updateData:
                                    projectEditState.newProject.toJson())
                            : databaseService.addItem(
                                collectionReference: databaseService.projectReference,
                                object:
                                    projectEditState.newProject);
                        Navigator.pop(context);
                      }))
            ],
          ),
        );
      },
    );
  }
}
