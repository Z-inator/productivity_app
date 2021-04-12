import 'package:flutter/material.dart';
import 'package:productivity_app/Shared/widgets/edit_bottom_sheets.dart';
import 'package:productivity_app/Task_Feature/providers/project_edit_state.dart';
import 'package:productivity_app/Task_Feature/providers/task_edit_state.dart';
import 'package:productivity_app/Task_Feature/screens/components/project_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/components/task_edit_bottomsheet.dart';
import 'package:productivity_app/Time_Feature/providers/time_entry_edit_state.dart';
import 'package:productivity_app/Time_Feature/screens/components/time_entry_edit_bottomsheet.dart';
import 'package:provider/provider.dart';
import 'package:productivity_app/Shared/widgets/flutter_speed_dial/flutter_speed_dial.dart';

class AddSpeedDial extends StatelessWidget {
  Map<IconData, Function> options;
  AddSpeedDial({this.options});

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      icon: Icons.add_rounded,
      iconTheme: IconThemeData(size: 40),
      activeIcon: Icons.close_rounded,
      renderOverlay: false,
      curve: Curves.bounceIn,
      tooltip: 'Add Menu',
      buttonSize: 40,
      childrenButtonSize: 40,
      backgroundColor: Theme.of(context).accentColor,
      foregroundColor: Theme.of(context).primaryColor,
      elevation: 0,
      shape: CircleBorder(),
      children: [
        SpeedDialChild(
          child:
              Icon(Icons.timer_rounded, color: Theme.of(context).accentColor),
          backgroundColor: Theme.of(context).cardColor,
          onTap: () {}      //TODO: add timer start here
        ),
        SpeedDialChild(
            child: Icon(Icons.timelapse_rounded,
                color: Theme.of(context).accentColor),
            backgroundColor: Theme.of(context).cardColor,
            onTap: () => EditBottomSheet().buildTimeEntryEditBottomSheet(
                context: context, isUpdate: false)),
        SpeedDialChild(
            child:
                Icon(Icons.rule_rounded, color: Theme.of(context).accentColor),
            backgroundColor: Theme.of(context).cardColor,
            onTap: () => EditBottomSheet()
                .buildTaskEditBottomSheet(context: context, isUpdate: false)),
        SpeedDialChild(
            child:
                Icon(Icons.topic_rounded, color: Theme.of(context).accentColor),
            backgroundColor: Theme.of(context).cardColor,
            onTap: () => EditBottomSheet().buildProjectEditBottomSheet(
                context: context, isUpdate: false)),
        // TODO: Implement Goal/Habits
        // SpeedDialChild(
        //     child: Icon(Icons.bar_chart_rounded,
        //         color: Theme.of(context).accentColor),
        //     backgroundColor: Theme.of(context).cardColor,
        //     onTap: () {})
      ],
    );
  }
}
