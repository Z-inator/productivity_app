import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Home_Dashboard/Home_Dashboard.dart';
import '../../../Shared/Shared.dart';
import '../../../Time_Feature/Time_Feature.dart';

class TimeBarChart extends StatelessWidget {
  final List<TimeEntry>? timeEntries;
  final DateTime? startDay;
  final DateTime? endDay;
  const TimeBarChart({Key? key, this.timeEntries, this.startDay, this.endDay})
      : super(key: key);

  List<BarChartGroupData> buildGroupData(
      Color color, List<Map<DateTime, int>> timeData) {
    List<BarChartGroupData> groupData = [];
    for (var entry in timeData) {
      groupData.add(generateBarGroup(
          color, timeData.indexOf(entry), entry.values.first.toDouble()));
    }
    return groupData;
  }

  @override
  Widget build(BuildContext context) {
    TimeGraphs timeGraphsState = Provider.of<TimeGraphs>(context);

    List<DateTime> days = timeGraphsState.getDays(startDay!, endDay!);
    List<Map<DateTime, int>> timeData =
        timeGraphsState.getTimeBarChartData(timeEntries, days);
    List<BarChartGroupData> groupData =
        buildGroupData(Theme.of(context).accentColor, timeData);
    double maxDayTime = timeGraphsState.getMaxTime(timeData);
    return Card(
      child: timeData == null
          ? Center(
              child: Text('No Recorded Time for the Week.'),
            )
          : Container(
              margin: EdgeInsets.all(25),
              child: BarChart(
                BarChartData(
                    maxY: maxDayTime,
                    alignment: BarChartAlignment.spaceAround,
                    borderData: FlBorderData(
                        show: true,
                        border: Border(
                            left: BorderSide(
                                width: 5,
                                color: DynamicColorTheme.of(context).data.unselectedWidgetColor),
                            bottom: BorderSide(
                                width: 5,
                                color:
                                    DynamicColorTheme.of(context).data.unselectedWidgetColor))),
                    gridData: FlGridData(
                        show: true,
                        drawHorizontalLine: true,
                        horizontalInterval: (2 * (60 * 60)).toDouble()
                        // drawVerticalLine: true,
                        // checkToShowVerticalLine: (value) => value == 0,
                        // getDrawingVerticalLine: (value) {
                        //   return FlLine(strokeWidth: 5);
                        // },
                        ),
                    titlesData: FlTitlesData(
                        show: true,
                        
                        bottomTitles: SideTitles(
                          margin: 10,
                          showTitles: true,
                          getTextStyles: (value) =>
                              DynamicColorTheme.of(context).data.textTheme.subtitle1!,
                          getTitles: (value) {
                            int newValue = value.toInt() + 7;
                            int dayValue = newValue % 7;
                            switch (dayValue) {
                              case 0:
                                return 'M';
                              case 1:
                                return 'T';
                              case 2:
                                return 'W';
                              case 3:
                                return 'T';
                              case 4:
                                return 'F';
                              case 5:
                                return 'S';
                              case 6:
                                return 'S';
                              default:
                                return '';
                            }
                          },
                        ),
                        leftTitles: SideTitles(
                          showTitles: true,
                          margin: 10,
                          interval: (2 * (60 * 60)).toDouble(),
                          getTextStyles: (value) =>
                              DynamicColorTheme.of(context).data.textTheme.subtitle1!,
                          getTitles: (value) {
                            int hourValue = value ~/ (60 * 60);
                            if (value == 0) {
                              return '0';
                            }
                            return '${hourValue}';
                          },
                        )),
                    barTouchData: BarTouchData(
                        touchTooltipData: BarTouchTooltipData(
                      fitInsideHorizontally: true,
                      fitInsideVertically: true,
                      tooltipRoundedRadius: 25,
                      tooltipBgColor: Colors.grey[700],
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        Map<DateTime, int> entry = timeData[groupIndex];
                        DateTime day = entry.keys.first;
                        String dayTime = DateTimeFunctions()
                            .timeToText(seconds: entry.values.first);
                        return BarTooltipItem(
                            '${day.month} / ${day.day}\n$dayTime',
                            DynamicColorTheme.of(context).data
                                .textTheme
                                .subtitle1!
                                .copyWith(color: Colors.white),
                            textAlign: TextAlign.center);
                      },
                    )),
                    barGroups: groupData),
                swapAnimationDuration: Duration(microseconds: 500),
                swapAnimationCurve: Curves.easeInOut,
              ),
            ),
    );
  }

  // List<BarChartGroupData> generateBarGroups(
  //     List<Map<DateTime, int>> timeData,

  // ) {
  //   return List.generate(timeData.length, (index) {
  //     return BarChartGroupData(x: x)
  //   })
  // }

  BarChartGroupData generateBarGroup(Color color, int x, double y) {
    return BarChartGroupData(x: x, barsSpace: 4, barRods: [
      BarChartRodData(y: y, colors: [color], width: 10)
    ]);
  }
}
