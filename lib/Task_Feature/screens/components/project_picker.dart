import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Shared/functions/color_functions.dart';
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
    List<MaterialColor> colorList = AppColors.colorList;
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
                    color: Colors.grey,
              ),
              title: Text('No Project',
                      style:
                          DynamicColorTheme.of(context).data.textTheme.subtitle1),
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
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: projects.map((project) => ListTile(
                      leading: Icon(
                        Icons.topic_rounded,
                        color: DynamicColorTheme.of(context).isDark ? colorList[project.projectColor].shade200 : colorList[project.projectColor],
                      ),
                      title: Text(project.projectName,
                          style: DynamicColorTheme.of(context)
                              .data
                              .textTheme
                              .subtitle1),
                      onTap: () {
                        saveProject(project);
                        Navigator.pop(context);
                      },
                    )).toList(),
                ),
              ),
            ),
            // child: Container(
            //     width: MediaQuery.of(context).size.width,
            //     height: MediaQuery.of(context).size.height / 2,
            //   child: ListView(
            //     children: projects.map((project) {
            //       return ListTile(
            //         leading: Icon(
            //           Icons.topic_rounded,
            //           color: DynamicColorTheme.of(context).isDark ? colorList[project.projectColor].shade200 : colorList[project.projectColor],
            //         ),
            //         title: Text(project.projectName,
            //             style: DynamicColorTheme.of(context)
            //                 .data
            //                 .textTheme
            //                 .subtitle1),
            //         onTap: () {
            //           saveProject(project);
            //           Navigator.pop(context);
            //         },
            //       );
            //     }).toList(),
            //   ),
            // ),
          )
        ];
      },
    child: child);
  }
}

// class ProjectPicker extends StatelessWidget {
//   final Function(Project) saveProject;
//   final Function noProject;
//   final Widget child;
//   const ProjectPicker({Key key, this.saveProject, this.noProject, this.child})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     List<MaterialColor> colorList = AppColors.colorList;
//     final List<Project> projects = Provider.of<List<Project>>(context);
//     return DropDownButtonHideUnderline(

//       child: Container(
//         decoration: ShapeDecoration(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(25))
//           )
//         )
//       ),
//     );
//   }
// }