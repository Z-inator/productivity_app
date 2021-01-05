import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'reusable_time_card_widget.dart';

class TimeLogList extends StatefulWidget {
  @override
  _TimeLogListState createState() => _TimeLogListState();
}

class _TimeLogListState extends State<TimeLogList> {
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
            return ReusableTimeCard(
              task: list[index],
              project: list[index],
            );
          }
        ),
      )
    );
  }
}
