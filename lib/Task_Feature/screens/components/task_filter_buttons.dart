import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/providers/task_page_state.dart';
import 'package:provider/provider.dart';


class FilterButtonRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TaskBodyState taskBodyState = Provider.of<TaskBodyState>(context);
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: OutlinedButton.icon(
              onPressed: () {
                taskBodyState.changePage(0);
              },
              icon: Icon(Icons.label_rounded),
              label: Text('Status'),
              style: OutlinedButton.styleFrom(
                primary: taskBodyState.page == 0 ? Theme.of(context).primaryColor : null,
                backgroundColor:
                    taskBodyState.page == 0 ? Theme.of(context).accentColor : null,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: OutlinedButton.icon(
              onPressed: () {
                taskBodyState.changePage(1);
              },
              icon: Icon(Icons.topic_rounded),
              label: Text('Project'),
              style: OutlinedButton.styleFrom(
                primary: taskBodyState.page == 1 ? Theme.of(context).primaryColor : null,
                backgroundColor:
                    taskBodyState.page == 1 ? Theme.of(context).accentColor : null,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: OutlinedButton.icon(
              onPressed: () {
                taskBodyState.changePage(2);
              },
              icon: Icon(Icons.notification_important_rounded),
              label: Text('Due Date'),
              style: OutlinedButton.styleFrom(
                primary: taskBodyState.page == 2 ? Theme.of(context).primaryColor : null,
                backgroundColor:
                    taskBodyState.page == 2 ? Theme.of(context).accentColor : null,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: OutlinedButton.icon(
              onPressed: () {
                taskBodyState.changePage(3);
              },
              icon: Icon(Icons.playlist_add_rounded),
              label: Text('Create Date'),
              style: OutlinedButton.styleFrom(
                primary: taskBodyState.page == 3 ? Theme.of(context).primaryColor : null,
                backgroundColor:
                    taskBodyState.page == 3 ? Theme.of(context).accentColor : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
