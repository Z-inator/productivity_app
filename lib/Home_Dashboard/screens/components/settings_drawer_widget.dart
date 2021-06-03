import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Authentification/Authentification.dart';
import '../../../Shared/Shared.dart';

class SettingsDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);
    return Drawer(
        child: Column(
      children: [
        DrawerHeader(
            child: ListTile(
          title: Text('Settings'),
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
  @override
  Widget build(BuildContext context) {
    final List<MaterialColor> colorList = AppColorList;
    return Column(
      children: [
        SwitchListTile(
          title: Text('Dark Mode'),
          value: DynamicColorTheme.of(context).isDark,
          onChanged: (value) {
            DynamicColorTheme.of(context)
                .setIsDark(isDark: value, shouldSave: true);
            DynamicColorTheme.of(context).setColor(
                color: DynamicColorTheme.of(context).color, shouldSave: true);
          },
        ),
        ListTile(
            title: ColorSelector(
                matchColor: DynamicColorTheme.of(context).color.value,
                saveColor: (int color) => DynamicColorTheme.of(context)
                    .setColor(color: Color(color), shouldSave: true),
                colorList: AppAccentColorList)),
      ],
    );
  }
}
