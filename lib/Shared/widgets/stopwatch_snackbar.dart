import 'package:flutter/material.dart';
import 'package:productivity_app/Shared/functions/time_functions.dart';
import 'package:productivity_app/Shared/widgets/edit_bottom_sheets.dart';
import 'package:productivity_app/Shared/widgets/project_picker.dart';
import 'package:productivity_app/Time_Feature/providers/stopwatch_state.dart';
import 'package:productivity_app/Time_Feature/screens/components/time_entry_edit_bottomsheet.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class StopwatchSnackbar extends StatelessWidget {
  const StopwatchSnackbar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StopwatchState stopwatchState = Provider.of<StopwatchState>(context);
    return SnackBar(
        content: ListTile(
      tileColor: Theme.of(context).shadowColor,
      leading: IconButton(
        icon: Icon(Icons.stop_rounded, color: Colors.red),
        onPressed: () => stopwatchState.stopStopwatch(),
      ),
      title: Text(
          TimeFunctions().timeToText(seconds: stopwatchState.elapsedTicks)),
      trailing: IconButton(
        icon: Icon(Icons.edit_rounded),
        onPressed: () => EditBottomSheet().buildEditBottomSheet(
            context: context,
            bottomSheet: TimeEntryEditBottomSheet(
                isUpdate: false, entry: stopwatchState.timeEntry)),
      ),
    ));
  }
}

class StopwatchBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    StopwatchState stopwatchState = Provider.of<StopwatchState>(context);
    return SlidingUpPanel(
      panelSnapping: true,
      header: Container(
        margin: EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.stop_rounded, color: Colors.red),
              onPressed: () => stopwatchState.stopStopwatch()),
            Text(
              TimeFunctions().timeToText(seconds: stopwatchState.elapsedTicks)),
          ],
          // ListTile(
          // leading: IconButton(
          //     icon: Icon(Icons.stop_rounded, color: Colors.red),
          //     onPressed: () => stopwatchState.stopStopwatch()),
          // title: Text(
          //     TimeFunctions().timeToText(seconds: stopwatchState.elapsedTicks)),
          // )
        ),
      ),
      panel: Container(
        margin: EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(),
            ProjectPicker(
                saveProject: stopwatchState.updateEntryProject,
                child: ListTile(
                  leading: Icon(
                    Icons.circle,
                    color: Color(stopwatchState.timeEntry.project.projectColor),
                  ),
                  title: Text(
                      stopwatchState.timeEntry.project.projectName.isEmpty
                          ? 'Add Project'
                          : stopwatchState.timeEntry.project.projectName,
                      style: Theme.of(context).textTheme.subtitle1),
                  trailing: Icon(Icons.arrow_drop_down_rounded,
                      color: Theme.of(context).unselectedWidgetColor),
                )),
            // TaskPicker(),
          ],
        ),
      ),
    );
  }
}
