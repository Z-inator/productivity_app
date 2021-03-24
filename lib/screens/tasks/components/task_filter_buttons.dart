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
            child: OutlinedButton.icon(
              onPressed: () {
                _taskBodyState.changePage(0);
                setState(() {
                  setBody = _taskBodyState.page;
                });
              },
              icon: Icon(Icons.label_rounded),
              label: Text('Status'),
              style: OutlinedButton.styleFrom(
                primary: setBody == 0 ? Theme.of(context).primaryColor : null,
                backgroundColor:
                    setBody == 0 ? Theme.of(context).accentColor : null,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: OutlinedButton.icon(
              onPressed: () {
                _taskBodyState.changePage(1);
                setState(() {
                  setBody = _taskBodyState.page;
                });
              },
              icon: Icon(Icons.topic_rounded),
              label: Text('Project'),
              style: OutlinedButton.styleFrom(
                primary: setBody == 1 ? Theme.of(context).primaryColor : null,
                backgroundColor:
                    setBody == 1 ? Theme.of(context).accentColor : null,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: OutlinedButton.icon(
              onPressed: () {
                _taskBodyState.changePage(2);
                setState(() {
                  setBody = _taskBodyState.page;
                });
              },
              icon: Icon(Icons.notification_important_rounded),
              label: Text('Due Date'),
              style: OutlinedButton.styleFrom(
                primary: setBody == 2 ? Theme.of(context).primaryColor : null,
                backgroundColor:
                    setBody == 2 ? Theme.of(context).accentColor : null,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: OutlinedButton.icon(
              onPressed: () {
                _taskBodyState.changePage(3);
                setState(() {
                  setBody = _taskBodyState.page;
                });
              },
              icon: Icon(Icons.playlist_add_rounded),
              label: Text('Create Date'),
              style: OutlinedButton.styleFrom(
                primary: setBody == 3 ? Theme.of(context).primaryColor : null,
                backgroundColor:
                    setBody == 3 ? Theme.of(context).accentColor : null,
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
