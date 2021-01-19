import 'package:flutter/material.dart';

class TimeLogRow extends StatelessWidget {
  TimeLogRow({this.task, this.project, this.timeRange, this.time});

  final String task;
  final String project;
  final String timeRange;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Flexible(
          flex: 1,
          fit: FlexFit.loose,
          child: IconButton(
            icon: Icon(Icons.play_arrow_rounded),
            onPressed: () {},
          ),
        ),
        Flexible(
          flex: 4,
          fit: FlexFit.tight,
          child: InkWell(
            onTap: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  task,
                  style: DefaultTextStyle.of(context)
                      .style
                      .apply(fontSizeFactor: 1.3),
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  textAlign: TextAlign.left,
                ),
                Text(
                  project,
                  style: TextStyle(color: Colors.blue),
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ),
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: InkWell(
            onTap: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('$timeRange - $timeRange'),
                Text(time),
              ]
            ),
          ),
        )
      ],
    );
  }
}
