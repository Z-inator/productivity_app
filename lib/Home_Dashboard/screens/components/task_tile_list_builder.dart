import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'reusable_time_tile.dart';

class TimeTileList extends StatefulWidget {
  @override
  _TimeTileListState createState() => _TimeTileListState();
}

class _TimeTileListState extends State<TimeTileList> {
  final List<String> list = [
    'asdfsadf asdfsfsa sadf',
    'asdfsfa' 'adf',
    'asdfasd',
    'asdfas sadfad',
    'asdfsad',
    'asdf',
    'asdfsadf asdfsfsa sadf',
    'asdfsfa' 'adf',
    'asdfasd',
    'asdfas sadfad',
    'asdfsad',
    'asdf',
    'asdfsadf asdfsfsa sadf',
    'asdfsfa' 'adf',
    'asdfasd',
    'asdfas sadfad',
    'asdfsad',
    'asdf',
    'asdfsadf asdfsfsa sadf',
    'asdfsfa' 'adf',
    'asdfasd',
    'asdfas sadfad',
    'asdfsad',
    'asdf',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      child: Scrollbar(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return ReusableTimeTile(
              task: list[index],
              project: list[index],
            );
          }
        ),
      )
    );
  }
}
