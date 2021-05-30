import 'package:flutter/material.dart';
import 'package:productivity_app/Shared/functions/color_functions.dart';
import 'package:productivity_app/Shared/functions/datetime_functions.dart';
import 'package:productivity_app/Shared/widgets/edit_bottom_sheets.dart';
import 'package:productivity_app/Task_Feature/screens/components/project_picker.dart';
import 'package:productivity_app/Shared/providers/stopwatch_state.dart';
import 'package:productivity_app/Time_Feature/models/times.dart';
import 'package:productivity_app/Time_Feature/screens/components/time_entry_edit_bottomsheet.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class StopWatchTile extends StatelessWidget {
  const StopWatchTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MaterialColor> colorList = AppColors().colorList;
    StopwatchState stopwatchState = Provider.of<StopwatchState>(context);
    return Container(
      child: Card(
        margin: EdgeInsets.all(0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)),
        child: ListTile(
          leading: IconButton(
              icon: Icon(Icons.stop_rounded, color: Colors.red),
              onPressed: () {
                stopwatchState.stopStopwatch();
                EditBottomSheet().buildEditBottomSheet(
                    context: context,
                    bottomSheet: TimeEntryEditBottomSheet(
                      isUpdate: false,
                      entry: stopwatchState.newEntry,
                    ));
              }),
          title: Text(
              DateTimeFunctions().timeToText(seconds: stopwatchState.elapsedTicks)),
          trailing: Text(
            stopwatchState.newEntry.project.projectName,
            style: TextStyle(
                color: colorList[stopwatchState.newEntry.project.projectColor]),
          ),
        ),
      ),
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
//       color: DynamicColorTheme.of(context).data.cardColor,
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
//                 color: DynamicColorTheme.of(context).data.accentColor,
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
//                       style: DynamicColorTheme.of(context).data.textTheme.subtitle1),
//                   trailing: Icon(Icons.arrow_drop_down_rounded,
//                       color: DynamicColorTheme.of(context).data.unselectedWidgetColor),
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
//       tileColor: DynamicColorTheme.of(context).data.shadowColor,
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
