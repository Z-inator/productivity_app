import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Home_Dashboard/services/charts_and_graphs.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/services/projects_data.dart';
import 'package:productivity_app/Time_Feature/models/times.dart';
import 'package:provider/provider.dart';

class TimePieChart extends StatelessWidget {
  final List<TimeEntry> timeEntries;
  const TimePieChart({Key key, this.timeEntries}) : super(key: key);

  Widget badgeWidget(TextStyle textStyle, Project project) {
    return Card(
        child: Padding(
      padding: EdgeInsets.all(5),
      child: Text(project.projectName, style: textStyle),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final TimeGraphs timeGraphsState = Provider.of<TimeGraphs>(context);
    final ProjectService projectService = Provider.of<ProjectService>(context);
    final int totalTimeRangeTime = timeGraphsState.getTotalTimeRangeTime(timeEntries);
    final List<Map<Project, int>> projectData =
        timeGraphsState.getProjectPieChartData(projectService, timeEntries);
    return Card(
        child: projectData == null
            ? Center(
                child: Text('No Recorded Time for the Week'),
              )
            : Container(
                margin: EdgeInsets.all(25),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return PieChart(
                      PieChartData(
                          centerSpaceRadius: 0,
                          sectionsSpace: 0,
                          borderData: FlBorderData(show: false),
                          sections: generatePieSections(
                              projectData,
                              totalTimeRangeTime,
                              DynamicTheme.of(context)
                                  .theme
                                  .textTheme
                                  .subtitle2,
                              DynamicTheme.of(context)
                                  .theme
                                  .textTheme
                                  .subtitle1,
                              constraints.maxHeight / 2.25)),
                      swapAnimationDuration: Duration(microseconds: 500),
                      swapAnimationCurve: Curves.easeInOut,
                    );
                  },
                ),
              ));
  }

  List<PieChartSectionData> generatePieSections(
      List<Map<Project, int>> projectData,
      int totalTimeRangeTime,
      TextStyle titleStyle,
      TextStyle badgeStyle,
      double radius) {
    return List.generate(projectData.length, (index) {
      final Project project = projectData.elementAt(index).keys.first;
      final int recordedTime = projectData.elementAt(index).values.first;
      final int percentage = ((recordedTime / totalTimeRangeTime) * 100).toInt();
      return PieChartSectionData(
          color: Color(project.projectColor),
          value: recordedTime.toDouble(),
          radius: radius,
          title: '$percentage%',
          titlePositionPercentageOffset: .5,
          titleStyle: titleStyle,
          badgeWidget: badgeWidget(badgeStyle, project),
          badgePositionPercentageOffset: .9);
    });
  }
}
