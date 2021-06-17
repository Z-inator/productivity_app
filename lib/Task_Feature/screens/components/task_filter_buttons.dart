import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Task_Feature/Task_Feature.dart';

class FilterButtonRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TaskBodyState taskBodyState = Provider.of<TaskBodyState>(context);
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 10),
      scrollDirection: Axis.horizontal,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
              taskBodyState.options.length,
              (index) => FilterButton(
                    index: index,
                    icon: taskBodyState.icons[index],
                    filterName: taskBodyState.options[index],
                    whenPressed: taskBodyState.changePage,
                  ))),
    );
  }
}

class FilterButton extends StatelessWidget {
  final int index;
  final IconData icon;
  final String filterName;
  final Function(int) whenPressed;
  FilterButton(
      {Key? key, required this.index, required this.icon, required this.filterName, required this.whenPressed})
      : super(key: key);

  late bool isSelected;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = DynamicColorTheme.of(context).data;
    TaskBodyState taskBodyState = Provider.of<TaskBodyState>(context);
    isSelected = index == taskBodyState.page;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: OutlinedButton.icon(
          icon: Icon(icon),
          label: Text(filterName),
          onPressed: () => whenPressed(index),
          style: OutlinedButton.styleFrom(
            primary: isSelected
                ? themeData.colorScheme.onSecondary
                : themeData.colorScheme.secondaryVariant,
            backgroundColor: isSelected
                ? themeData.colorScheme.secondaryVariant
                : themeData.colorScheme.background,
          )),
    );
  }
}
