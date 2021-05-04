import 'package:flutter/material.dart';
import 'package:productivity_app/Shared/functions/time_functions.dart';
import 'package:productivity_app/Shared/widgets/edit_bottom_sheets.dart';
import 'package:productivity_app/Shared/widgets/stopwatch_widget.dart';
import 'package:productivity_app/Task_Feature/providers/project_edit_state.dart';
import 'package:productivity_app/Task_Feature/providers/task_edit_state.dart';
import 'package:productivity_app/Task_Feature/screens/components/project_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/components/task_edit_bottomsheet.dart';
import 'package:productivity_app/Shared/providers/stopwatch_state.dart';
import 'package:productivity_app/Time_Feature/providers/time_entry_edit_state.dart';
import 'package:productivity_app/Time_Feature/screens/components/time_entry_edit_bottomsheet.dart';
import 'package:provider/provider.dart';
import 'package:productivity_app/Shared/widgets/flutter_speed_dial/flutter_speed_dial.dart';

class AddSpeedDial extends StatelessWidget {
  Map<IconData, Future> options;
  AddSpeedDial({this.options});

  // List<SpeedDialChild> getSpeedDialChildren(
  //     BuildContext context, Map<IconData, Future> options) {
  //   List<SpeedDialChild> children = [];
  //   options.forEach((key, value) {
  //     SpeedDialChild temp = SpeedDialChild(
  //       child: Icon(key, color: Theme.of(context).accentColor),
  //       backgroundColor: Theme.of(context).cardColor,
  //       onTap: () => value,
  //     );
  //     children.add(temp);
  //   });
  //   return children;
  // }

  @override
  Widget build(BuildContext context) {
    // List<SpeedDialChild> speedDialChildren =
    //     getSpeedDialChildren(context, options);
    return SpeedDial(
      icon: Icons.add_rounded,
      iconTheme: IconThemeData(size: 45),
      activeIcon: Icons.close_rounded,
      renderOverlay: false,
      curve: Curves.bounceIn,
      tooltip: 'Add Menu',
      buttonSize: 45,
      childrenButtonSize: 45,
      backgroundColor: Theme.of(context).accentColor,
      foregroundColor: Theme.of(context).primaryColor,
      elevation: 0,
      shape: CircleBorder(),
      openCloseDial: ,
      children: [
        SpeedDialChild(
            child:
                Icon(Icons.timer_rounded, color: Theme.of(context).accentColor),
            backgroundColor: Theme.of(context).cardColor,
            onTap: () => Provider.of<StopwatchState>(context, listen: false).startStopwatch()),
        SpeedDialChild(
            child: Icon(Icons.timelapse_rounded,
                color: Theme.of(context).accentColor),
            backgroundColor: Theme.of(context).cardColor,
            onTap: () => EditBottomSheet().buildEditBottomSheet(
                context: context,
                bottomSheet: TimeEntryEditBottomSheet(isUpdate: false))),
        SpeedDialChild(
            child:
                Icon(Icons.rule_rounded, color: Theme.of(context).accentColor),
            backgroundColor: Theme.of(context).cardColor,
            onTap: () => EditBottomSheet().buildEditBottomSheet(
                context: context,
                bottomSheet: TaskEditBottomSheet(isUpdate: false))),
        SpeedDialChild(
            child:
                Icon(Icons.topic_rounded, color: Theme.of(context).accentColor),
            backgroundColor: Theme.of(context).cardColor,
            onTap: () => EditBottomSheet().buildEditBottomSheet(
                context: context,
                bottomSheet: ProjectEditBottomSheet(isUpdate: false))),
      ],
      // TODO: Implement Goal/Habits
      // SpeedDialChild(
      //     child: Icon(Icons.bar_chart_rounded,
      //         color: Theme.of(context).accentColor),
      //     backgroundColor: Theme.of(context).cardColor,
      //     onTap: () {})
    );
  }
}
