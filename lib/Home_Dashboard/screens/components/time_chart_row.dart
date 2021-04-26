import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Home_Dashboard/screens/components/TimeBarChart.dart';
import 'package:productivity_app/Home_Dashboard/screens/components/pageview_position_dots.dart';
import 'package:productivity_app/Home_Dashboard/screens/components/pageview_row.dart';
import 'package:productivity_app/Home_Dashboard/services/charts_and_graphs.dart';
import 'package:productivity_app/Shared/functions/time_functions.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/screens/project_screen.dart';
import 'package:productivity_app/Task_Feature/services/projects_data.dart';
import 'package:productivity_app/Time_Feature/models/times.dart';
import 'package:productivity_app/Time_Feature/services/times_data.dart';
import 'package:provider/provider.dart';

class TimeChartRow extends StatelessWidget {
  TimeChartRow({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TimeGraphs timeGraphsState = Provider.of<TimeGraphs>(context);
    List<TimeEntry> timeEntries = Provider.of<List<TimeEntry>>(context);
    List<DateTime> currentWeek = timeGraphsState.getCurrentWeek(DateTime.now());
    List<TimeEntry> weeksTimeEntries = timeGraphsState.getTimeRangeData(
        timeEntries, currentWeek[0], currentWeek[1]);
    return weeksTimeEntries == null
        ? Center(child: CircularProgressIndicator())
        : weeksTimeEntries.isEmpty
            ? Center(child: Text('Add Time Entries to see Recorded Data'))
            : PageViewRow(pages: [
                TimeBarChart(
                  timeEntries: weeksTimeEntries,
                ),
                TimePieChart(timeEntries: weeksTimeEntries),
                TimeBarChartByProject(timeEntries: weeksTimeEntries)
              ]);
  }
}

class TimePieChart extends StatelessWidget {
  final List<TimeEntry> timeEntries;
  final DateTime startDay;
  final DateTime endDay;
  const TimePieChart({Key key, this.timeEntries, this.startDay, this.endDay})
      : super(key: key);

  List<PieChartSectionData> buildSectionData(
      List<Map<Project, int>> projectData,
      TextStyle titleStyle,
      int totalTimeRangeTime) {
    List<PieChartSectionData> sectionData = [];
    for (var project in projectData) {
      String percentage =
          '${((project.values.first / totalTimeRangeTime) * 100).toInt()}%';
      sectionData.add(generatePieSections(
          project.keys.first, project.values.first, percentage, titleStyle));
    }
    return sectionData;
  }

  @override
  Widget build(BuildContext context) {
    TimeGraphs timeGraphsState = Provider.of<TimeGraphs>(context);
    ProjectService projectService = Provider.of<ProjectService>(context);
    int totalTimeRangeTime = timeGraphsState.getTotalTimeRangeTime(timeEntries);
    List<Map<Project, int>> projectData =
        timeGraphsState.getProjectPieChartData(projectService, timeEntries);
    List<PieChartSectionData> sectionData = buildSectionData(
        projectData, Theme.of(context).textTheme.subtitle1, totalTimeRangeTime);
    return Column(
      children: [
        ListTile(
          title: Text('Time by Project'),
        ),
        Expanded(
            child: Card(
                child: projectData == null
                    ? Center(
                        child: Text('No Recorded Time for the Week'),
                      )
                    : Container(
                        margin: EdgeInsets.all(25),
                        child: PieChart(
                          PieChartData(
                              centerSpaceRadius: 40,
                              sectionsSpace: 0,
                              borderData: FlBorderData(show: false),
                              sections: sectionData,
                              pieTouchData: PieTouchData(
                                touchCallback: (pieTouchResponse) {},
                              )),
                          swapAnimationDuration: Duration(microseconds: 500),
                          swapAnimationCurve: Curves.easeInOut,
                        ),
                      )))
      ],
    );
  }

  PieChartSectionData generatePieSections(Project project, int recordedTime,
      String percentage, TextStyle titleStyle) {
    return PieChartSectionData(
        color: Color(project.projectColor),
        value: recordedTime.toDouble(),
        title: percentage,
        titlePositionPercentageOffset: 1,
        titleStyle: titleStyle);
  }
}

class TimeBarChartByProject extends StatelessWidget {
  final List<TimeEntry> timeEntries;
  final DateTime startDay;
  final DateTime endDay;
  const TimeBarChartByProject(
      {Key key, this.timeEntries, this.startDay, this.endDay})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PieChartSample2();
  }
}

class PieChartSample2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            const SizedBox(
              height: 18,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
                  PieChartData(
                      pieTouchData:
                          PieTouchData(touchCallback: (pieTouchResponse) {
                        setState(() {
                          final desiredTouch = pieTouchResponse.touchInput
                                  is! PointerExitEvent &&
                              pieTouchResponse.touchInput is! PointerUpEvent;
                          if (desiredTouch &&
                              pieTouchResponse.touchedSection != null) {
                            touchedIndex = pieTouchResponse
                                .touchedSection.touchedSectionIndex;
                          } else {
                            touchedIndex = -1;
                          }
                        });
                      }),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: showingSections()),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Indicator(
                  color: Color(0xff0293ee),
                  text: 'First',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Color(0xfff8b250),
                  text: 'Second',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Color(0xff845bef),
                  text: 'Third',
                  isSquare: true,
                ),
                SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Color(0xff13d38e),
                  text: 'Fourth',
                  isSquare: true,
                ),
                SizedBox(
                  height: 18,
                ),
              ],
            ),
            const SizedBox(
              width: 28,
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;

  const Indicator({
    Key key,
    this.color,
    this.text,
    this.isSquare,
    this.size = 16,
    this.textColor = const Color(0xff505050),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
        )
      ],
    );
  }
}
