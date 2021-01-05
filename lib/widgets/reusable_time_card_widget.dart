import 'package:flutter/material.dart';

class ReusableTimeCard extends StatelessWidget {
  ReusableTimeCard(
      {this.task, this.project, this.projectColor, this.timeLogged});

  final String task;
  final String project;
  final Color projectColor;
  final String timeLogged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 200,
          minWidth: 100,
        ),
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Text(
              task,
              softWrap: false,
              overflow: TextOverflow.fade,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textScaleFactor: 1.25,
            ),
            Text(
              project,
              softWrap: false,
              overflow: TextOverflow.fade,
              style: TextStyle(
                color: projectColor,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.play_arrow_rounded),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.create_rounded),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.delete_outline_rounded),
                  onPressed: () {},
                ),
              ]
            )
          ],
        ),
      )
    );
  }
}
