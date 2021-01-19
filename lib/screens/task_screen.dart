import 'package:flutter/material.dart';
import 'package:productivity_app/components/task_page/task_list.dart';
import 'package:productivity_app/components/time_page/time_log_list.dart';
import 'package:productivity_app/components/task_page/due_task_list_builder.dart';
import 'package:productivity_app/components/task_page/reusable_task_expansion_tile.dart';
import 'package:productivity_app/components/base_framework.dart';

class TaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseFramework(
      dashboard: TaskDashboard(),
      list: TaskList(),
    );
    // Column(
    //   mainAxisSize: MainAxisSize.max,
    //   crossAxisAlignment: CrossAxisAlignment.stretch,
    //   children: <Widget>[
    //     Flexible(
    //       flex: 1,
    //       fit: FlexFit.loose,
    //       child: Container(
    //         padding: EdgeInsets.all(20),
    //         child: Column(
    //           mainAxisSize: MainAxisSize.max,
    //           children: <Widget>[
    //             ListTile(
    //               title: Text('Total Number of Tasks:'),
    //               subtitle: Text('40'),
    //             ),
    //             TaskExpansionTile(
    //               day: 'Today',
    //               taskCount: 5.toString(),
    //             ),
    //             TaskExpansionTile(
    //               day: 'This Week',
    //               taskCount: 10.toString(),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //     Flexible(
    //       flex: 1,
    //       fit: FlexFit.loose,
    //       child: TaskList(),
    //     )
    //   ]
    // );
  }
}

class TaskDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        ListTile(
          title: Text('Total Number of Tasks:'),
          subtitle: Text('40'),
        ),
        TaskExpansionTile(
          day: 'Today',
          taskCount: 5.toString(),
        ),
        TaskExpansionTile(
          day: 'This Week',
          taskCount: 10.toString(),
        ),
      ],
    );
  }
}
