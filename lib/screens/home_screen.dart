import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Card(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.all_out),
                    onPressed: () {},
                  ),
                  Text('User\'s Name'),
                ],
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.all_out),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.all_out),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.all_out),
                    onPressed: () {},
                  ),
                ],
              ),
              // Row(
              //   children: <Widget>[
              //     LinearProgressIndicator(
              //       semanticsLabel: 'Progress',
              //     )
              //   ],
              // )
            ],
          ),
        ),
        ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.play_arrow_outlined),
                    title: Text('Most Recent Log'),
                    subtitle: Text('Project Title'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        child: Text('Edit'),
                        onPressed: () {},
                      ),
                      TextButton(
                        child: Text('Delete'),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              )
            )
          ],
        )
      ],
    );
  }
}
