import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Task_Feature/providers/task_screen_state.dart';
import 'package:provider/provider.dart';

class FilterButton extends StatelessWidget {
  final int index;
  final IconData icon;
  final String filterName;
  final Function(int) whenPressed;
  bool isSelected;

  FilterButton(
      {Key key, this.index, this.icon, this.filterName, this.whenPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TaskBodyState taskBodyState = Provider.of<TaskBodyState>(context);
    isSelected = index == taskBodyState.page;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: OutlinedButton.icon(
          icon: Icon(icon),
          label: Text(filterName),
          onPressed: () => whenPressed(index),
          style: OutlinedButton.styleFrom(
            primary: isSelected
                ? DynamicTheme.of(context).theme.primaryColor
                : DynamicTheme.of(context).theme.accentColor,
            backgroundColor: isSelected
                ? DynamicTheme.of(context).theme.accentColor
                : DynamicTheme.of(context).theme.primaryColor,
          )),
    );
  }
}

class FilterButtonRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TaskBodyState taskBodyState = Provider.of<TaskBodyState>(context);
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
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
