import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Authentification/screens/about.dart';
import 'package:productivity_app/Authentification/services/authentification_data.dart';
import 'package:productivity_app/Shared/functions/color_functions.dart';
import 'package:productivity_app/Shared/widgets/color_selector.dart';
import 'package:productivity_app/Theme/style.dart';
import 'package:provider/provider.dart';

class SettingsDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);
    User user = auth.user;
    return Drawer(
        child: Column(
      children: [
        DrawerHeader(
            decoration: BoxDecoration(color: DynamicColorTheme.of(context).data.accentColor),
            child: ListTile(
              title: Text(user.displayName,
                  style: TextStyle(
                      color: DynamicColorTheme.of(context).data.textTheme.subtitle2.color,
                      fontSize: 24)),
              trailing: IconButton(
                  icon: Icon(Icons.cancel_rounded),
                  onPressed: () => Navigator.pop(context)),
            )),
        ListTile(
          leading: Icon(Icons.account_circle_rounded),
          title: Text('User Settings'),
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => UserSetings())),
        ),
        ExpansionTile(
          leading: Icon(Icons.brightness_6_rounded),
          title: Text('Theme Settings'),
          children: [ThemeSettings()],
        ),
        ListTile(
          leading: Icon(Icons.help_rounded),
          title: Text('About'),
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => AboutPage())),
        ),
        ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () => auth.signOut())
      ],
    ));
  }
}

class UserSetings extends StatelessWidget {
  const UserSetings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ThemeSettings extends StatelessWidget {
  ThemeSettings({Key key}) : super(key: key);
  int currentColor;
  @override
  Widget build(BuildContext context) {
    final List<int> colorList = AppColors().colorList;
    return Column(
      children: [
        SwitchListTile(
          title: Text('Dark Mode'),
          value: DynamicColorTheme.of(context).isDark,
          activeColor: DynamicColorTheme.of(context).data.accentColor,
          onChanged: (value) => DynamicColorTheme.of(context).setIsDark(isDark: value, shouldSave: true),
        ),
        ListTile(
          title: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        scrollDirection: Axis.horizontal,
        child: Row(
            children: colorList.map((color) {
          return IconButton(
            icon: Icon(
              DynamicColorTheme.of(context).color.value == color ? Icons.check_circle_rounded : Icons.circle,
              color: Color(color),
              size: 36,
            ),
            onPressed: () => DynamicColorTheme.of(context).setColor(color: Color(color), shouldSave: true)
          );
        }).toList()))
        ),
      ],
    );
  }
}
