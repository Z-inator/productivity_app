// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:productivity_app/Shared/providers/page_state.dart';
import 'package:productivity_app/Shared/screens/components/bottom_navigation_bar.dart';
import 'package:productivity_app/Shared/screens/components/page_body.dart';
import 'package:productivity_app/Shared/widgets/add_speed_dial.dart';
import 'package:productivity_app/Shared/widgets/edit_bottom_sheets.dart';
import 'package:productivity_app/Shared/widgets/flutter_speed_dial/flutter_speed_dial.dart';
import 'package:productivity_app/Shared/widgets/stopwatch_widget.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/status.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
// import 'package:productivity_app/Shared/widgets/flutter_speed_dial/src/speed_dial.dart';
import 'package:productivity_app/Task_Feature/providers/project_edit_state.dart';
import 'package:productivity_app/Task_Feature/providers/task_edit_state.dart';
import 'package:productivity_app/Task_Feature/screens/components/project_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/components/task_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/task_project_screen.dart';
import 'package:productivity_app/Time_Feature/models/times.dart';
import 'package:productivity_app/Time_Feature/providers/stopwatch_state.dart';
import 'package:productivity_app/Time_Feature/providers/time_entry_edit_state.dart';
import 'package:productivity_app/Time_Feature/screens/components/time_entry_edit_bottomsheet.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Home_Dashboard/screens/home_screen.dart';
import 'package:productivity_app/test_screen.dart';
import 'package:productivity_app/Time_Feature/screens/time_screen.dart';

class BaseFramework extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Task> tasks = Provider.of<List<Task>>(context);
    List<Project> projects = Provider.of<List<Project>>(context);
    List<Status> statuses = Provider.of<List<Status>>(context);
    List<TimeEntry> timeEntries = Provider.of<List<TimeEntry>>(context);
    return tasks == null ||
            projects == null ||
            statuses == null ||
            timeEntries == null
        ? Center(child: CircularProgressIndicator())
        : ChangeNotifierProvider(
            create: (context) => PageState(page: 0, widget: HomeScreen()),
            builder: (context, child) {
              StopwatchState stopwatchState = Provider.of<StopwatchState>(context);
              return Container(
                  decoration:
                      BoxDecoration(color: Theme.of(context).canvasColor),
                  child: SafeArea(
                    child: Scaffold(
                      extendBody: true,
                      body: Column(
                        children: [
                          stopwatchState.stopwatch.isRunning
                          ? StopWatchTile()
                          : Container(),
                          Expanded(child: PageBody())
                        ]  
                      ),
                      bottomNavigationBar: NavigationBar(),
                      // bottomSheet: 
                      // drawer: ,
                    ),
                  ));
            },
          );
  }
}

// class StopwatchAppBar extends StatelessWidget {
//   const StowatchAppBar({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
      
//     );
//   }
// }