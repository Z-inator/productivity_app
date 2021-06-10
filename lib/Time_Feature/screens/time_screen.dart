import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Shared/Shared.dart';
import '../../../Task_Feature/Task_Feature.dart';
import '../../../Time_Feature/Time_Feature.dart';

class TimeScreen extends StatefulWidget {
  const TimeScreen({Key? key}) : super(key: key);
  @override
  _TimeScreenState createState() => _TimeScreenState();
}

class _TimeScreenState extends State<TimeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<TimeEntry> getTimeEntryGroup(
      TimeEntryBodyState timeEntryBodyState, List<TimeEntry> timeEntries) {
    if (timeEntryBodyState.currentProject == null) {
      return timeEntries;
    } else {
      return timeEntries
          .where((entry) =>
              entry.project?.id == timeEntryBodyState.currentProject?.id)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<MaterialColor> colorList = AppColorList;
    List<TimeEntry> timeEntries = Provider.of<List<TimeEntry>>(context);
    List<Project> projects = Provider.of<List<Project>>(context);
    return ChangeNotifierProvider(
      create: (context) => TimeEntryBodyState(),
      builder: (context, child) {
        TimeEntryBodyState timeEntryBodyState =
            Provider.of<TimeEntryBodyState>(context);
        Project? currentProject = timeEntryBodyState.currentProject;
        return Column(
          children: [
            ProjectPicker(
              saveProject: timeEntryBodyState.changeProject,
              child: currentProject != null
                  ? ListTile(
                      leading: Icon(Icons.topic_rounded,
                          color: DynamicColorTheme.of(context).isDark
                              ? colorList[currentProject.projectColor!].shade200
                              : colorList[currentProject.projectColor!]),
                      title: Text(currentProject.projectName!,
                          style: DynamicColorTheme.of(context)
                              .data
                              .textTheme
                              .subtitle1!
                              .copyWith(
                                  color: DynamicColorTheme.of(context).isDark
                                      ? colorList[currentProject.projectColor!]
                                          .shade200
                                      : colorList[
                                          currentProject.projectColor!])),
                      trailing: Icon(Icons.expand_more_rounded),
                    )
                  : ListTile(
                      leading: Icon(Icons.filter_list_rounded),
                      title: Text('Filter by Project'),
                      trailing: Icon(Icons.expand_more_rounded),
                    ),
            ),
            Divider(
              color: DynamicColorTheme.of(context)
                  .data
                  .colorScheme
                  .secondaryVariant,
            ),
            Expanded(
                child: TimeEntriesByDay(
                    timeEntries:
                        getTimeEntryGroup(timeEntryBodyState, timeEntries)))
          ],
        );
      },
    );
  }
}
