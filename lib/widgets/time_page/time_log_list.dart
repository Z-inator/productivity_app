import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:productivity_app/widgets/time_page/time_log_entry_list_builder.dart';
import 'reusable_time_log_row.dart';
import 'reusable_time_card_header.dart';

class TimeLogList extends StatefulWidget {
  @override
  _TimeLogListState createState() => _TimeLogListState();
}

class _TimeLogListState extends State<TimeLogList> {
  final List<String> date = ['Today', 'Yesterday', 'Mon, 4 Jan', 'Sun, 3 Jan'];
  final List<String> time = ['10:20:30', '10:20:30', '10:20:30', '10:20:30'];

  // final List<Map<int,List>> finalList = [];
  // List newList () {
  //   for (int i = 0;i < date.length; i++) {
  //     finalList[i][0].addAll([date[i],time[i]]);
  //     finalList[i][1].add(data);
  //   }
  //   return finalList;
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: date.length,
        itemBuilder: (context, index) {
          print('building large row with lots of characters to stand out');
          return Card(
            child: Container(
              padding: EdgeInsets.all(5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TimeCardHeader(
                    date: date[index],
                    dateTime: time[index],
                  ),
                  TimeLogEntryBuilder()
                ]
              )
            )
          );
        }
      ),
    );
  }
}

// abstract class ListItem {
//   Widget buildHeading(BuildContext context);
//   Widget buildLogEntry(BuildContext context);
// }

// class Header implements ListItem {

// }
