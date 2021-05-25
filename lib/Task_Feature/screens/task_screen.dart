import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Task_Feature/providers/task_page_state.dart';
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

class _TaskScreenState extends State<TaskScreen> with AutomaticKeepAliveClientMixin {
    
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => TaskBodyState(),
        builder: (context, child) {
          TaskBodyState state = Provider.of<TaskBodyState>(context);
          return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                FilterButtonRow(), 
                Expanded(child: state.widget)
              ]);
        });
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
