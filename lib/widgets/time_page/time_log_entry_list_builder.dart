import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'reusable_time_log_row.dart';
import 'package:productivity_app/widgets/home_page/reusable_time_tile.dart';

class TimeLogEntryBuilder extends StatefulWidget {
  @override
  _TimeLogEntryBuilderState createState() => _TimeLogEntryBuilderState();
}

class _TimeLogEntryBuilderState extends State<TimeLogEntryBuilder> {
  final List<List<String>> data = [
    ['Sonair', 'Taiwan Fund, Inc. (The)', '0:53', '9:22:25'],
    ['Andalax', 'Cavco Industries, Inc.', '17:18', '8:35:14'],
    ['Daltfresh', 'Heico Corporation', '11:07', '11:46:30'],
    ['Asoka', 'Kimco Realty Corporation', '4:05', '15:54:26'],
    ['Home Ing', 'ClearBridge Large Cap Growth ESG ETF', '1:47', '16:05:54'],
    ['Bigtax', 'Cass Information Systems, Inc', '16:12', '4:37:58'],
    ['Zamit', 'HFF, Inc.', '12:18', '22:40:23'],
    ['Sub-Ex', 'Cedar Realty Trust, Inc.', '1:33', '23:02:25'],
    ['Transcof', 'Gabelli Equity Trust, Inc. (The)', '15:09', '4:48:46'],
    ['Andalax', 'ClearBridge Energy MLP Fund Inc.', '10:07', '21:30:59'],
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: data.length,
          itemBuilder: (context, index) {
            print('building row $index');
            return TimeLogRow(
              // task: list[index],
              // project: list[index],
              // timeRange: list[index],
              // time: list[index],
              task: data[index][0],
              project: data[index][1],
              timeRange: data[index][2],
              time: data[index][3],
            );
          }),
    );
  }
}
