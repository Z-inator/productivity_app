import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Home_Dashboard/services/charts_and_graphs.dart';
import 'package:productivity_app/Shared/functions/datetime_functions.dart';
import 'package:productivity_app/Time_Feature/models/times.dart';
import 'package:productivity_app/Time_Feature/services/times_data.dart';
import 'package:provider/provider.dart';

class TimeBarChart extends StatelessWidget {
  final List<TimeEntry> timeEntries;
  final DateTime startDay;
  final DateTime endDay;
  const TimeBarChart({Key key, this.timeEntries, this.startDay, this.endDay})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TimeGraphs timeGraphsState = Provider.of<TimeGraphs>(context);
    final TimeService timeService = Provider.of<TimeService>(context);
    final List<DateTime> days = timeGraphsState.getDays(startDay, endDay);
    final List<Map<DateTime, int>> timeData =
        timeGraphsState.getTimeBarChartData(timeService, timeEntries, days);
    final List<BarChartGroupData> groupData =
        buildGroupData(DynamicTheme.of(context).theme.accentColor, timeData);
    final double maxDayTime = timeGraphsState.getMaxTime(timeData);
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
                                color: DynamicTheme.of(context)
                                    .theme
                                    .unselectedWidgetColor),
                            bottom: BorderSide(
                                width: 5,
                                color: DynamicTheme.of(context)
                                    .theme
                                    .unselectedWidgetColor))),
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
                          getTextStyles: (value) => DynamicTheme.of(context)
                              .theme
                              .textTheme
                              .subtitle1,
                          getTitles: (value) {
                            final int newValue = value.toInt() + 7;
                            final int dayValue = newValue % 7;
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
                          getTextStyles: (value) => DynamicTheme.of(context)
                              .theme
                              .textTheme
                              .subtitle1,
                          getTitles: (value) {
                            final int hourValue = value ~/ (60 * 60);
                            if (value == 0) {
                              return '0';
                            }
                            return '$hourValue';
                          },
                        )),
                    barTouchData: BarTouchData(
                        touchTooltipData: BarTouchTooltipData(
                      fitInsideHorizontally: true,
                      fitInsideVertically: true,
                      tooltipRoundedRadius: 25,
                      tooltipBgColor: Colors.grey[700],
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        final Map<DateTime, int> entry = timeData[groupIndex];
                        final DateTime day = entry.keys.first;
                        final String dayTime = DateTimeFunctions()
                            .timeToText(seconds: entry.values.first);
                        return BarTooltipItem(
                            '${day.month} / ${day.day}\n$dayTime',
                            DynamicTheme.of(context)
                                .theme
                                .textTheme
                                .subtitle1
                                .copyWith(color: Colors.white));
                      },
                    )),
                    barGroups: groupData),
                swapAnimationDuration: Duration(microseconds: 500),
                swapAnimationCurve: Curves.easeInOut,
              ),
            ),
    );
  }

  List<BarChartGroupData> buildGroupData(
      Color color, List<Map<DateTime, int>> timeData) {
    final List<BarChartGroupData> groupData = [];
    for (final entry in timeData) {
      groupData.add(generateBarGroup(
          color, timeData.indexOf(entry), entry.values.first.toDouble()));
    }
    return groupData;
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
