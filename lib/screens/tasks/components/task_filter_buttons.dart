import 'package:flutter/material.dart';
import 'package:productivity_app/screens/tasks/components/task_stream.dart';
import 'package:provider/provider.dart';

class FilterButtonRow extends StatefulWidget {
  @override
  _FilterButtonRowState createState() => _FilterButtonRowState();
}

class _FilterButtonRowState extends State<FilterButtonRow> {
  int setBody = 0;

  // void _changePage(BuildContext context, int newPage) {
  //   Provider.of<TaskBodyState>(context, listen: false).changePage(newPage);
  // }

  @override
  Widget build(BuildContext context) {
    TaskBodyState _taskBodyState = Provider.of<TaskBodyState>(context);
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextButton.icon(
              onPressed: () {
                // _changePage(context, 0);
                _taskBodyState.changePage(0);
                setState(() {
                  setBody = 0;
                });
              },
              icon: Icon(Icons.label_rounded),
              label: Text('Status'),
              style: TextButton.styleFrom(
                backgroundColor:
                    setBody == 0 ? Theme.of(context).primaryColor : null,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextButton.icon(
              onPressed: () {
                // _changePage(context, 1);
                _taskBodyState.changePage(1);
                setState(() {
                  setBody = 1;
                });
              },
              icon: Icon(Icons.topic_rounded),
              label: Text('Project'),
              style: TextButton.styleFrom(
                backgroundColor:
                    setBody == 1 ? Theme.of(context).primaryColor : null,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextButton.icon(
              onPressed: () {
                // _changePage(context, 2);
                _taskBodyState.changePage(2);
                setState(() {
                  setBody = 2;
                });
              },
              icon: Icon(Icons.notification_important_rounded),
              label: Text('Due Date'),
              style: TextButton.styleFrom(
                backgroundColor:
                    setBody == 2 ? Theme.of(context).primaryColor : null,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextButton.icon(
              onPressed: () {
                // _changePage(context, 3);
                _taskBodyState.changePage(3);
                setState(() {
                  setBody = 3;
                });
              },
              icon: Icon(Icons.playlist_add_rounded),
              label: Text('Create Date'),
              style: TextButton.styleFrom(
                backgroundColor:
                    setBody == 3 ? Theme.of(context).primaryColor : null,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
