import 'package:flutter/material.dart';
import 'package:productivity_app/components/time_page/test.dart';
import 'package:productivity_app/components/time_page/time_log_list.dart';
import 'package:fl_chart/fl_chart.dart';
import 'base_framework.dart';

class TimeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseFramework(
      dashboard: TimeDashboard(),
      list: TimeLogList(),
    );
    // Column(
    //   mainAxisSize: MainAxisSize.max,
    //   crossAxisAlignment: CrossAxisAlignment.stretch,
    //   children: <Widget>[
    //     Flexible(
    //       flex: 1,
    //       fit: FlexFit.loose,
    //       child: TimeDashboard()
    //     ),
    //     Flexible(
    //       flex: 1,
    //       fit: FlexFit.loose,
    //       child: TimeLogList(),
    //     )
    //   ]
    // );
  }
}

class TimeDashboard extends StatelessWidget {
  const TimeDashboard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
          Flexible(
            flex: 1,
            fit: FlexFit.loose,
            child: Row(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: BarChart(BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 20,
                    barTouchData: BarTouchData(
                      enabled: false,
                      touchTooltipData: BarTouchTooltipData(
                        tooltipBgColor: Colors.transparent,
                        tooltipPadding: const EdgeInsets.all(0),
                        tooltipBottomMargin: 8,
                        getTooltipItem: (
                          BarChartGroupData group,
                          int groupIndex,
                          BarChartRodData rod,
                          int rodIndex,
                        ) {
                          return BarTooltipItem(
                            rod.y.round().toString(),
                            TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ),
                    titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: SideTitles(
                          showTitles: true,
                          margin: 20,
                          getTitles: (double value) {
                            switch (value.toInt()) {
                              case 0:
                                return 'Mn';
                              case 1:
                                return 'Te';
                              case 2:
                                return 'Wd';
                              case 3:
                                return 'Tu';
                              case 4:
                                return 'Fr';
                              case 5:
                                return 'St';
                              case 6:
                                return 'Sn';
                              default:
                                return '';
                            }
                          },
                        ),
                        leftTitles: SideTitles(showTitles: false)),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    barGroups: [
                      BarChartGroupData(
                        x: 0,
                        barRods: [
                          BarChartRodData(y: 8, colors: [
                            Colors.lightBlueAccent,
                            Colors.greenAccent
                          ])
                        ],
                        showingTooltipIndicators: [0],
                      ),
                      BarChartGroupData(
                        x: 1,
                        barRods: [
                          BarChartRodData(y: 10, colors: [
                            Colors.lightBlueAccent,
                            Colors.greenAccent
                          ])
                        ],
                        showingTooltipIndicators: [0],
                      ),
                      BarChartGroupData(
                        x: 2,
                        barRods: [
                          BarChartRodData(y: 14, colors: [
                            Colors.lightBlueAccent,
                            Colors.greenAccent
                          ])
                        ],
                        showingTooltipIndicators: [0],
                      ),
                      BarChartGroupData(
                        x: 3,
                        barRods: [
                          BarChartRodData(y: 15, colors: [
                            Colors.lightBlueAccent,
                            Colors.greenAccent
                          ])
                        ],
                        showingTooltipIndicators: [0],
                      ),
                      BarChartGroupData(
                        x: 3,
                        barRods: [
                          BarChartRodData(y: 13, colors: [
                            Colors.lightBlueAccent,
                            Colors.greenAccent
                          ])
                        ],
                        showingTooltipIndicators: [0],
                      ),
                      BarChartGroupData(
                        x: 3,
                        barRods: [
                          BarChartRodData(y: 10, colors: [
                            Colors.lightBlueAccent,
                            Colors.greenAccent
                          ])
                        ],
                        showingTooltipIndicators: [0],
                      ),
                    ],
                  )),
                ),
                Flexible(flex: 1, fit: FlexFit.loose, child: PieChartSample3()),
              ],
            ),
          )
        ]));
  }
}
