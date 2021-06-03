import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Task_Feature/Task_Feature.dart';

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
    TaskService taskService = Provider.of<TaskService>(context);
    List<Task> tasks = Provider.of<List<Task>>(context);
    List<Project> projects = Provider.of<List<Project>>(context);
    List<Status> statuses = Provider.of<List<Status>>(context);
    return ChangeNotifierProvider(
        create: (context) =>
            TaskBodyState(taskService: taskService, tasks: tasks, statuses: statuses, projects: projects),
        builder: (context, child) {
          TaskBodyState taskBodyState = Provider.of<TaskBodyState>(context);
          return Column(mainAxisSize: MainAxisSize.max, children: [
            FilterButtonRow(),
            Expanded(
                child: tasks.isEmpty
                    ? Center(child: Text('Add Tasks to see them listed here.'))
                    : TaskList(
                        taskMap: taskBodyState.currentTaskList,
                        getWidget: taskBodyState.getWidget,
                      ))
          ]);
        });
  }
}
// Working on being able to use TaskList on Project Page as well.

class TaskList extends StatelessWidget {
  List<Map<dynamic, List<Task>>> taskMap;
  Function(dynamic item, int numberOfTasks) getWidget;
  TaskList({Key key, this.taskMap, this.getWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(bottom: 100),
      children: taskMap.map((Map<dynamic, List<Task>> item) {
        return Container(
          padding: EdgeInsets.all(10),
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                getWidget(item.keys.single, item.values.length) as Widget,
                Divider(),
                GroupedTasks(tasks: item.values.single)
              ],
            ),
          ),
        );
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
