import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

import '../../../Shared/Shared.dart';
import '../../../Task_Feature/Task_Feature.dart';
import '../../../Time_Feature/Time_Feature.dart';

class AddSpeedDial extends StatelessWidget {
  ValueNotifier<bool> isDialOpen = ValueNotifier<bool>(false);

  // List<SpeedDialChild> getSpeedDialChildren(
  //     BuildContext context, Map<IconData, Future> options) {
  //   List<SpeedDialChild> children = [];
  //   options.forEach((key, value) {
  //     SpeedDialChild temp = SpeedDialChild(
  //       child: Icon(key, color:themeData.accentColor),
  //       backgroundColor:themeData.cardColor,
  //       onTap: () => value,
  //     );
  //     children.add(temp);
  //   });
  //   return children;
  // }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = DynamicColorTheme.of(context).data;
    // List<SpeedDialChild> speedDialChildren =
    //     getSpeedDialChildren(context, options);
    return SpeedDial(
      icon: Icons.add_rounded,
      iconTheme: IconThemeData(size: 45),
      activeIcon: Icons.close_rounded,
      closeManually: true,
      openCloseDial: isDialOpen,
      overlayColor:
         themeData.colorScheme.secondaryVariant,
      overlayOpacity: .1,
      renderOverlay: true,
      curve: Curves.bounceIn,
      tooltip: 'Add Menu',
      buttonSize: 45,
      childrenButtonSize: 45,
      elevation: 0,
      shape: CircleBorder(),
      backgroundColor:themeData.colorScheme.secondary,
      foregroundColor:
         themeData.colorScheme.onSecondary,
      children: [
        SpeedDialChild(
            child: Icon(Icons.timer_rounded),
            backgroundColor:
               themeData.colorScheme.surface,
            foregroundColor:
               themeData.colorScheme.secondary,
            onTap: () {
              isDialOpen.value = !isDialOpen.value;
              Provider.of<StopwatchState>(context, listen: false)
                  .startStopwatch();
            }),
        SpeedDialChild(
            child: Icon(Icons.timelapse_rounded),
            backgroundColor:
               themeData.colorScheme.surface,
            foregroundColor:
               themeData.colorScheme.secondary,
            onTap: () {
              isDialOpen.value = !isDialOpen.value;
              EditBottomSheet().buildEditBottomSheet(
                  context: context,
                  bottomSheet: TimeEntryEditBottomSheet(isUpdate: false));
            }),
        SpeedDialChild(
            child: Icon(Icons.rule_rounded),
            backgroundColor:
               themeData.colorScheme.surface,
            foregroundColor:
               themeData.colorScheme.secondary,
            onTap: () {
              isDialOpen.value = !isDialOpen.value;
              EditBottomSheet().buildEditBottomSheet(
                  context: context,
                  bottomSheet: TaskEditBottomSheet(isUpdate: false));
            }),
        SpeedDialChild(
            child: Icon(Icons.topic_rounded),
            backgroundColor:
               themeData.colorScheme.surface,
            foregroundColor:
               themeData.colorScheme.secondary,
            onTap: () {
              isDialOpen.value = !isDialOpen.value;
              EditBottomSheet().buildEditBottomSheet(
                  context: context,
                  bottomSheet: ProjectEditBottomSheet(isUpdate: false));
            }),
      ],
      // TODO: Implement Goal/Habits
      // SpeedDialChild(
      //     child: Icon(Icons.bar_chart_rounded,
      //         color:themeData.accentColor),
      //     backgroundColor:themeData.cardColor,
      //     onTap: () {})
    );
  }
}
