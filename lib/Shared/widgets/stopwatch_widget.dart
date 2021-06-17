import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/Task_Feature.dart';
import 'package:productivity_app/Task_Feature/screens/components/components.dart';
import 'package:provider/provider.dart';

import '../../../Shared/Shared.dart';
import '../../../Time_Feature/Time_Feature.dart';

class StopWatchTile extends StatelessWidget {
  const StopWatchTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MaterialColor> colorList = AppColorList;
    ThemeData themeData = DynamicColorTheme.of(context).data;
    StopwatchState stopwatchState = Provider.of<StopwatchState>(context);
    List<Task> tasks = Provider.of<List<Task>>(context);
    if (stopwatchState.newEntry.project != null) {
      tasks = tasks
          .where((task) =>
              task.project?.id == stopwatchState.newEntry.project?.id)
          .toList();
    }
    return Container(
      child: Card(
        margin: EdgeInsets.all(0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2,
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  IconButton(
                    icon: Icon(Icons.stop_rounded, color: Colors.red),
                    onPressed: () {
                      stopwatchState.stopStopwatch();
                      EditBottomSheet().buildEditBottomSheet(
                          context: context,
                          bottomSheet: TimeEntryEditBottomSheet(
                            isUpdate: false,
                            entry: stopwatchState.newEntry,
                          ));
                    }
                  ),
                  Text(DateTimeFunctions()
                    .timeToText(seconds: stopwatchState.elapsedTicks),
                    style: themeData.textTheme.headline5,),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              padding: EdgeInsets.fromLTRB(5, 5, 20, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ProjectPicker(
                  saveProject: stopwatchState.updateEntryProject, 
                  child: Text(stopwatchState.newEntry.project?.projectName ?? 'Add Project',
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.fade,
                      maxLines: 2,
                      style: themeData.textTheme.subtitle1!.copyWith(
                        color: stopwatchState.newEntry.project != null
                          ? DynamicColorTheme.of(context).isDark
                            ? colorList[stopwatchState.newEntry.project!.projectColor!]
                                .shade200
                            : colorList[stopwatchState.newEntry.project!.projectColor!]
                          : themeData.colorScheme.onSurface),)),
                  TaskPicker(
                    tasks: tasks,
                    saveTask: stopwatchState.updateEntryTask,
                    child: Text(stopwatchState.newEntry.task?.taskName ?? 'Add Task',
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.fade,
                        maxLines: 3,
                        style: themeData.textTheme.subtitle1)
                  ),
                ],
              ),
            )
          ],
        )
      )
    );
  }
}

// Decided against this implementation.
// It looked good and felt fancy, but it didn't match the rest of the app.
// I like my creation so I am going to keep it here for future reference.

// class StopwatchBottomSheet extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     StopwatchState stopwatchState = Provider.of<StopwatchState>(context);
//     return SlidingUpPanel(
//       panelSnapping: true,
//       borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
//       color: themeData.cardColor,
//       minHeight: 70,
//       slideDirection: SlideDirection.DOWN,
//       header: Container(
//         width: MediaQuery.of(context).size.width,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             ListTile(
//           leading: IconButton(
//               icon: Icon(Icons.stop_rounded, color: Colors.red),
//               onPressed: () => stopwatchState.stopStopwatch()),
//           title: Text(
//               TimeFunctions().timeToText(seconds: stopwatchState.elapsedTicks)),
//           ),
//             Container(
//               margin: EdgeInsets.only(bottom: 10),
//               width: 60,
//               height: 5,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.all(Radius.circular(25)),
//                 color: themeData.accentColor,
//               ),
//             ),
//           ],
//         ),
//       ),
//       panel: Container(
//         padding: EdgeInsets.only(top: 120),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(),
//             ProjectPicker(
//                 saveProject: stopwatchState.updateEntryProject,
//                 child: ListTile(
//                   leading: Icon(
//                     Icons.circle,
//                     color: Color(stopwatchState.timeEntry.project.projectColor),
//                   ),
//                   title: Text(
//                       stopwatchState.timeEntry.project.projectName.isEmpty
//                           ? 'Add Project'
//                           : stopwatchState.timeEntry.project.projectName,
//                       style: themeData.textTheme.subtitle1),
//                   trailing: Icon(Icons.arrow_drop_down_rounded,
//                       color: themeData.unselectedWidgetColor),
//                 )),
//             // TaskPicker(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class StopwatchSnackbar extends StatelessWidget {
//   const StopwatchSnackbar({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     StopwatchState stopwatchState = Provider.of<StopwatchState>(context);
//     return SnackBar(
//         content: ListTile(
//       tileColor: themeData.shadowColor,
//       leading: IconButton(
//         icon: Icon(Icons.stop_rounded, color: Colors.red),
//         onPressed: () => stopwatchState.stopStopwatch(),
//       ),
//       title: Text(
//           TimeFunctions().timeToText(seconds: stopwatchState.elapsedTicks)),
//       trailing: IconButton(
//         icon: Icon(Icons.edit_rounded),
//         onPressed: () => EditBottomSheet().buildEditBottomSheet(
//             context: context,
//             bottomSheet: TimeEntryEditBottomSheet(
//                 isUpdate: false, entry: stopwatchState.timeEntry)),
//       ),
//     ));
//   }
// }
