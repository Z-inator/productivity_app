import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Shared/Shared.dart';
import '../../../Task_Feature/Task_Feature.dart';
import '../../../Time_Feature/Time_Feature.dart';

class AddSpeedDial extends StatelessWidget {
  // List<SpeedDialChild> getSpeedDialChildren(
  //     BuildContext context, Map<IconData, Future> options) {
  //   List<SpeedDialChild> children = [];
  //   options.forEach((key, value) {
  //     SpeedDialChild temp = SpeedDialChild(
  //       child: Icon(key, color: DynamicColorTheme.of(context).data.accentColor),
  //       backgroundColor: DynamicColorTheme.of(context).data.cardColor,
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
      // openCloseDial: Provider.of<AuthService>(context).isDialOpen,
      // onOpen: () => Provider.of<AuthService>(context, listen: false).isDialOpen.value = true,
      // onClose: () => Provider.of<AuthService>(context, listen: false).isDialOpen.value = false,
      renderOverlay: false,
      curve: Curves.bounceIn,
      tooltip: 'Add Menu',
      buttonSize: 45,
      childrenButtonSize: 45,
      elevation: 0,
      shape: CircleBorder(),
      // openCloseDial: ValueNotifier(_value),
      children: [
        SpeedDialChild(
            child: Icon(Icons.timer_rounded),
            onTap: () => Provider.of<StopwatchState>(context, listen: false)
                .startStopwatch(oldEntry: TimeEntry())),
        SpeedDialChild(
            child: Icon(Icons.timelapse_rounded),
            onTap: () => EditBottomSheet().buildEditBottomSheet(
                context: context,
                bottomSheet: TimeEntryEditBottomSheet(isUpdate: false))),
        SpeedDialChild(
            child: Icon(Icons.rule_rounded),
            onTap: () => EditBottomSheet().buildEditBottomSheet(
                context: context,
                bottomSheet: TaskEditBottomSheet(isUpdate: false))),
        SpeedDialChild(
            child: Icon(Icons.topic_rounded),
            onTap: () => EditBottomSheet().buildEditBottomSheet(
                context: context,
                bottomSheet: ProjectEditBottomSheet(isUpdate: false))),
      ],
      // TODO: Implement Goal/Habits
      // SpeedDialChild(
      //     child: Icon(Icons.bar_chart_rounded,
      //         color: DynamicColorTheme.of(context).data.accentColor),
      //     backgroundColor: DynamicColorTheme.of(context).data.cardColor,
      //     onTap: () {})
    );
  }
}
