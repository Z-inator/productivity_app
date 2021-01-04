import 'package:flutter/material.dart';

class ReusableTimeCard extends StatelessWidget {
  ReusableTimeCard({this.task, this.project, this.timeLogged});

  final String task;
  final String project;
  final String timeLogged;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      constraints: BoxConstraints(
        maxWidth: 200,
      ),
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Text(
            task,
            softWrap: false,
            overflow: TextOverflow.fade,
          ),
          Text(
            project,
            softWrap: false,
            overflow: TextOverflow.fade,
          ),
          Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.play_arrow_rounded),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.edit_location_rounded),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.delete_outline_rounded),
                  onPressed: () {},
                ),
              ])
        ],
      ),
    ));
  }
}
