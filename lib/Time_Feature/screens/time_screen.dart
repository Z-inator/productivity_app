import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Shared/functions/color_functions.dart';
import 'package:productivity_app/Task_Feature/screens/components/project_picker.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Time_Feature/models/times.dart';
import 'package:productivity_app/Time_Feature/providers/time_entry_screen_state.dart';
import 'package:productivity_app/Time_Feature/screens/components/time_entries_list.dart';
import 'package:provider/provider.dart';

class TimeScreen extends StatefulWidget {
  @override
  _TimeScreenState createState() => _TimeScreenState();
}

class _TimeScreenState extends State<TimeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    List<MaterialColor> colorList = AppColors().colorList;
    List<TimeEntry> timeEntries = Provider.of<List<TimeEntry>>(context);
    List<Project> projects = Provider.of<List<Project>>(context);
    return ChangeNotifierProvider(
      create: (context) =>
          TimeEntryBodyState(entries: timeEntries, projects: projects),
      builder: (context, child) {
        TimeEntryBodyState timeEntryBodyState =
            Provider.of<TimeEntryBodyState>(context);
        Project currentProject = timeEntryBodyState.currentProject;
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(color: DynamicColorTheme.of(context).data.hoverColor),
              child: ProjectPicker(
                saveProject: timeEntryBodyState.changeEntryList,
                child: currentProject != null
                  ? ListTile(
                    leading: Icon(Icons.topic_rounded, color: colorList[timeEntryBodyState.currentProject.projectColor]),
                    title: Text(timeEntryBodyState.currentProject.projectName, style: DynamicColorTheme.of(context).data.textTheme.subtitle1.copyWith(color: colorList[currentProject.projectColor]))
                  )
                  : ListTile(
                    leading: Icon(Icons.filter_list_rounded),
                    title: Text('Sort by Project'),
                  ),
              ),
            ),
            Expanded(child: TimeEntriesByDay(timeEntries: timeEntryBodyState.currentEntryList))
          ],
        );
      },
    );
  }
}
