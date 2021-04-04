import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/status.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Task_Feature/providers/status_edit_state.dart';
import 'package:productivity_app/Task_Feature/providers/task_edit_state.dart';
import 'package:productivity_app/Task_Feature/screens/components/project_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/components/status_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/screens/components/task_edit_bottomsheet.dart';
import 'package:productivity_app/Task_Feature/services/projects_data.dart';
import 'package:productivity_app/Task_Feature/services/projects_data.dart';
import 'package:productivity_app/Time_Feature/services/times_data.dart';
import 'package:productivity_app/Shared/functions/color_functions.dart';
import 'package:productivity_app/Shared/functions/datetime_functions.dart';
import 'package:productivity_app/Shared/functions/time_functions.dart';
import 'package:provider/provider.dart';

class StatusExpansionTile extends StatelessWidget {
  final Status status;
  const StatusExpansionTile({Key key, this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
            initiallyExpanded: false,
            leading: Icon(
              Icons.circle,
              color: Color(status.statusColor),
            ),
            title: Text(
              status.statusName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: IconButton(
                icon: Icon(Icons.edit_rounded),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled:
                          true, // Allows the modal to me dynamic and keeps the menu above the keyboard
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25))),
                      builder: (BuildContext context) {
                        return ChangeNotifierProvider(
                            create: (context) => StatusEditState(),
                            child: StatusEditBottomSheet(
                              status: status,
                              isUpdate: true,
                            ));
                      });
                }),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Text('Tasks: 10',
                    style: Theme.of(context).textTheme.subtitle1),
              ),
              Container(
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                      'Description\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Donec vel.',
                      overflow: TextOverflow.fade,
                      maxLines: 3,
                      style: Theme.of(context).textTheme.subtitle1))
            ]));
  }
}
