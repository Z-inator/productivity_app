import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/status.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Task_Feature/providers/task_page_state.dart';
import 'package:productivity_app/Task_Feature/screens/components/task_expansion_tile.dart';
import 'package:productivity_app/Task_Feature/screens/task_by_create_date.dart';
import 'package:productivity_app/Task_Feature/screens/task_by_due_date.dart';
import 'package:productivity_app/Task_Feature/screens/task_by_project.dart';
import 'package:productivity_app/Task_Feature/screens/task_by_status.dart';
import 'package:productivity_app/Task_Feature/screens/components/task_filter_buttons.dart';
import 'package:productivity_app/Authentification/services/authentification_data.dart';
import 'package:productivity_app/Task_Feature/services/projects_data.dart';
import 'package:productivity_app/Task_Feature/services/statuses_data.dart';
import 'package:productivity_app/Task_Feature/services/tasks_data.dart';
import 'package:productivity_app/Shared/functions/color_functions.dart';
import 'package:productivity_app/Shared/functions/datetime_functions.dart';
import 'package:productivity_app/Shared/functions/time_functions.dart';
import 'package:provider/provider.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key key}) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    List<Task> tasks = Provider.of<List<Task>>(context);
    List<Project> projects = Provider.of<List<Project>>(context);
    List<Status> statuses = Provider.of<List<Status>>(context);
    return ChangeNotifierProvider(
        create: (context) => TaskBodyState(),
        builder: (context, child) {
          TaskBodyState taskBodyState = Provider.of<TaskBodyState>(context);
          return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                FilterButtonRow(), 
                Expanded(
                  child: TaskList(
                    tasks: taskBodyState.currentTaskList.
                  )
                )]);
        });
  }
}
  // Working on being able to use TaskList on Project Page as well.

class TaskList extends StatelessWidget {
  List<Task> tasks;
  Function getTasks;
  Widget groupingWidget;
  TaskList({Key key, this.tasks, this.getTasks, this.groupingWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TaskBodyState taskBodyState = Provider.of<TaskBodyState>(context);
    return ListView(
      padding: EdgeInsets.only(bottom: 100),
      children:
          taskBodyState.currentTaskList.map((Map<dynamic, List<Task>> item) {
        return Container(
          padding: EdgeInsets.all(10),
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                taskBodyState.getWidget(item.keys.single, item.values.length),
                GroupedTasks(tasks: item.values.single)
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class GroupedTasks extends StatelessWidget {
  final List<Task> tasks;
  const GroupedTasks({this.tasks});

  @override
  Widget build(BuildContext context) {
    return tasks == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : tasks.isEmpty
            ? Center(
                child: Text(
                'No Tasks Yet',
                style: DynamicColorTheme.of(context).data.textTheme.caption,
              ))
            : ListBody(
                children: tasks.map((task) {
                  return TaskExpansionTile(task: task);
                }).toList(),
              );
  }
}

class DayTile extends StatelessWidget {
  final String day;
  final int numberOfTasks;
  const DayTile({Key key, this.day, this.numberOfTasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(day), Text(numberOfTasks.toString())],
      ),
    );
  }
}

// class TaskScreenBody extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     Widget body = Provider.of<TaskBodyState>(context).widget;
//     return body;
//   }
// }

// class TaskStream extends StatefulWidget {
//   @override
//   _TaskStreamState createState() => _TaskStreamState();
// }

// class _TaskStreamState extends State<TaskStream>
//     with AutomaticKeepAliveClientMixin {
//   @override
//   bool get wantKeepAlive => true;

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<List<Task>>(
//         stream: TaskService().streamTasks(context),
//         builder: (BuildContext context, snapshot) {
//           if (snapshot.hasError) {
//             return Center(child: Text('Something went wrong'));
//           }
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: Text('Loading'));
//           }
//           return Container(
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [FilterButtonRow(), Expanded(child: TaskBody())],
//             ),
//           );
//         });
//   }
// }
