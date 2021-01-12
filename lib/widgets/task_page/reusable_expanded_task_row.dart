import 'package:flutter/material.dart';

class ExpandedTaskRow extends StatelessWidget {
  const ExpandedTaskRow({
    this.statuses,
    this.dueTask,
  });

  final List<String> statuses;
  final String dueTask;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Flexible(
          flex: 1,
          fit: FlexFit.loose,
          child: PopupMenuButton(
            icon: Icon(Icons.check_circle_outline_rounded),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem(child: Text(statuses[0])),
              PopupMenuItem(child: Text(statuses[1])),
              PopupMenuItem(child: Text(statuses[2])),
            ]
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
                  dueTask,
                  style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.3),
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Associated Project',
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
          flex: 1,
          fit: FlexFit.loose,
          child: Text('Tracked Time'),
        ),
        Flexible(
          flex: 1,
          fit: FlexFit.loose,
          child: IconButton(
            icon: Icon(Icons.today_rounded),
            onPressed: () {},
          )
        )
      ],
    );
  }
}