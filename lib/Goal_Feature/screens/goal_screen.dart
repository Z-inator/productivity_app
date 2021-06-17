import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Shared/functions/color_functions.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class GoalScreen extends StatelessWidget {
  List<Widget> habitCharts = [
    RadialHabitChart(fakeHabitData: [
      FakeHabitData(habitName: 'Workout', habitColor: 5, habitPercentage: .75)
    ]),
    RadialHabitChart(
      fakeHabitData: [
        FakeHabitData(
            habitName: 'Learn Something New',
            habitColor: 8,
            habitPercentage: .4)
      ],
    ),
    RadialHabitChart(fakeHabitData: [
      FakeHabitData(
          habitName: 'Don\'t get on Social Media',
          habitColor: 12,
          habitPercentage: .2)
    ])
  ];

  List<Widget> projectCharts = [
    ProjectGoalChart(fakeProjectData: [
      FakeProjectData(
          projectName: 'New App',
          projectColor: 2,
          projectTime: 4,
          projectGoalTime: 5),
    ]),
    ProjectGoalChart(fakeProjectData: [
      FakeProjectData(
          projectName: 'Backyard Padio',
          projectColor: 7,
          projectTime: 2,
          projectGoalTime: 8),
    ]),
    ProjectGoalChart(fakeProjectData: [
      FakeProjectData(
          projectName: 'Marketing Launch',
          projectColor: 15,
          projectTime: 30,
          projectGoalTime: 40)
    ])
  ];

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = DynamicColorTheme.of(context).data;
    return Scaffold(
      appBar: AppBar(
        title: Text('Coming Soon'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ListTile(
            title: Text(
              'Goals',
              style: themeData.textTheme.headline5,
            ),
            subtitle: Text(
                'Track goals across projects. Set a goal of how much time you want to spend on a project and log your activity towards that goal.'),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 3,
            child: Column(
              children: projectCharts,
            ),
          ),
          ListTile(
            title: Text('Habits', style: themeData.textTheme.headline5),
            subtitle: Text(
                'Build a great routine by creating lasting habits. Create a new habit and log the success of that habit'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: habitCharts,
          )
        ],
      ),
    );
  }
}

class RadialHabitChart extends StatelessWidget {
  const RadialHabitChart({
    Key? key,
    required this.fakeHabitData,
  }) : super(key: key);

  final List<FakeHabitData> fakeHabitData;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SfCircularChart(
        legend:
            Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
        series: <CircularSeries>[
          RadialBarSeries<FakeHabitData, String>(
              dataSource: fakeHabitData,
              maximumValue: 1,
              xValueMapper: (FakeHabitData data, _) => data.habitName,
              yValueMapper: (FakeHabitData data, _) => data.habitPercentage,
              strokeColor: DynamicColorTheme.of(context).isDark
                  ? AppColorList[fakeHabitData.single.habitColor].shade200
                  : AppColorList[fakeHabitData.single.habitColor].shade400,
              dataLabelSettings: DataLabelSettings(isVisible: true))
        ],
      ),
    );
  }
}

class ProjectGoalChart extends StatelessWidget {
  const ProjectGoalChart({Key? key, required this.fakeProjectData})
      : super(key: key);

  final List<FakeProjectData> fakeProjectData;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
        primaryYAxis: CategoryAxis(
          maximum: fakeProjectData.single.projectGoalTime.toDouble(),

        ),
        series: <BarSeries<FakeProjectData, String>>[
          BarSeries<FakeProjectData, String>(
            dataSource: fakeProjectData, 
            // maximumValue: fakeProjectData.single.projectGoalTime,
            xValueMapper: (FakeProjectData data, _) => data.projectName, 
            yValueMapper: (FakeProjectData data, _) => data.projectTime,
            color: DynamicColorTheme.of(context).isDark
                  ? AppColorList[fakeProjectData.single.projectColor].shade200
                  : AppColorList[fakeProjectData.single.projectColor].shade400,
          )
        ],
      ),
    );
  }
}

class FakeProjectData {
  final String projectName;
  final int projectColor;
  final int projectTime;
  final int projectGoalTime;

  FakeProjectData(
      {required this.projectName,
      required this.projectColor,
      required this.projectTime,
      required this.projectGoalTime});
}

class FakeHabitData {
  final String habitName;
  final int habitColor;
  final double habitPercentage;

  FakeHabitData(
      {required this.habitName,
      required this.habitColor,
      required this.habitPercentage});
}
