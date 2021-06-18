import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:productivity_app/Shared/functions/color_functions.dart';
import 'package:productivity_app/Shared/functions/datetime_functions.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

// Projects can also use radial menu using percentages for completing goals of different amounts

class GoalScreen extends StatelessWidget {
  List<FakeHabitData> habitCharts = [
      FakeHabitData(habitName: 'Workout', habitColor: 5, habitPercentage: .75),
      FakeHabitData(
          habitName: 'Learn Something',
          habitColor: 8,
          habitPercentage: .4),
      FakeHabitData(
          habitName: 'Wake Up Early',
          habitColor: 12,
          habitPercentage: .2)
  ];

  List<FakeProjectData> projectCharts = [
      FakeProjectData(
          projectName: 'New App',
          projectColor: 2,
          projectTime: 14400,
          projectGoalTime: 18000),
      FakeProjectData(
          projectName: 'Backyard Padio',
          projectColor: 7,
          projectTime: 7000,
          projectGoalTime: 28800),
      FakeProjectData(
          projectName: 'Marketing Launch',
          projectColor: 15,
          projectTime: 108000,
          projectGoalTime: 144000)
  ];

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = DynamicColorTheme.of(context).data;
    return Scaffold(
      appBar: AppBar(
        title: Text('Coming Soon'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
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
              // height: MediaQuery.of(context).size.height / 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: projectCharts.map((fakeProjectData) => ListTile(
                    leading: Text(DateTimeFunctions().timeToTextWithoutSeconds(seconds: fakeProjectData.projectTime)),
                    title: Text(fakeProjectData.projectName,
                        textAlign: TextAlign.center,),
                    subtitle: ProjectGoalChart(fakeProjectData: fakeProjectData),
                    trailing: Text(DateTimeFunctions().timeToTextWithoutSeconds(seconds: fakeProjectData.projectGoalTime)),
                )
                ).toList(),
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
              children: habitCharts.map((fakeHabitData) => RadialHabitChart(fakeHabitData: fakeHabitData)).toList(),
            )
          ],
        ),
      ),
    );
  }
}

class RadialHabitChart extends StatelessWidget {
  const RadialHabitChart({
    Key? key,
    required this.fakeHabitData,
  }) : super(key: key);

  final FakeHabitData fakeHabitData;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircularPercentIndicator(
        radius: 90,
        lineWidth: 20,
        animation: true,
        circularStrokeCap: CircularStrokeCap.round,
        percent: fakeHabitData.habitPercentage,
        center: Text('${(fakeHabitData.habitPercentage * 100).toInt().toString()}%'),
        footer: Text(fakeHabitData.habitName,
            softWrap: true,),
        backgroundColor: DynamicColorTheme.of(context).data.colorScheme.onBackground,
        progressColor: DynamicColorTheme.of(context).isDark
                  ? AppColorList[fakeHabitData.habitColor].shade200
                  : AppColorList[fakeHabitData.habitColor].shade400,
      )
    );
  }
}

class ProjectGoalChart extends StatelessWidget {
  const ProjectGoalChart({Key? key, required this.fakeProjectData})
      : super(key: key);

  final FakeProjectData fakeProjectData;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LinearPercentIndicator(
        lineHeight: 40,
        animation: true,
        linearStrokeCap: LinearStrokeCap.roundAll,
        center: Text('${((fakeProjectData.projectTime / fakeProjectData.projectGoalTime) * 100).toInt().toString()}%',
            style: TextStyle(color: DynamicColorTheme.of(context).data.colorScheme.onPrimary),),
        percent: fakeProjectData.projectTime / fakeProjectData.projectGoalTime,
        backgroundColor: DynamicColorTheme.of(context).data.colorScheme.onBackground,
        progressColor: DynamicColorTheme.of(context).isDark
                  ? AppColorList[fakeProjectData.projectColor].shade200
                  : AppColorList[fakeProjectData.projectColor].shade400,
      )
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
