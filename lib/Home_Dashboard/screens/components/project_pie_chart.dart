import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Time_Feature/Time_Feature.dart';
import '../../../Task_Feature/Task_Feature.dart';
import '../../../Home_Dashboard/Home_Dashboard.dart';
import '../../../Shared/Shared.dart';

class TimePieChart extends StatelessWidget {
  final List<TimeEntry> timeEntries;
  TimePieChart({Key key, this.timeEntries}) : super(key: key);

  Widget badgeWidget(TextStyle textStyle, Project project) {
    return Card(
        child: Padding(
      padding: EdgeInsets.all(5),
      child: Text(project.projectName, style: textStyle),
    ));
  }

  @override
  Widget build(BuildContext context) {
    TimeGraphs timeGraphsState = Provider.of<TimeGraphs>(context);
    ProjectService projectService = Provider.of<ProjectService>(context);
    int totalTimeRangeTime = timeGraphsState.getTotalTimeRangeTime(timeEntries);
    List<Map<Project, int>> projectData =
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
                              DynamicColorTheme.of(context).isDark,
                              projectData,
                              totalTimeRangeTime,
                              DynamicColorTheme.of(context)
                                  .data
                                  .textTheme
                                  .subtitle2,
                              DynamicColorTheme.of(context)
                                  .data
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
      bool isDark,
      List<Map<Project, int>> projectData,
      int totalTimeRangeTime,
      TextStyle titleStyle,
      TextStyle badgeStyle,
      double radius) {
    return List.generate(projectData.length, (index) {
      List<MaterialColor> colorList = AppColorList;
      Project project = projectData.elementAt(index).keys.first;
      int recordedTime = projectData.elementAt(index).values.first;
      int percentage = ((recordedTime / totalTimeRangeTime) * 100).toInt();
      return PieChartSectionData(
          color: isDark
              ? colorList[project.projectColor].shade200
              : colorList[project.projectColor],
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
