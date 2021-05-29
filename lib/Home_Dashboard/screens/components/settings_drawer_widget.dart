import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Authentification/screens/about.dart';
import 'package:productivity_app/Authentification/services/authentification_data.dart';
import 'package:productivity_app/Shared/functions/color_functions.dart';
import 'package:productivity_app/Theme/style.dart';
import 'package:provider/provider.dart';

class SettingsDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of<AuthService>(context);
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

class ThemeSettings extends StatelessWidget {
  int currentColor;
  ThemeSettings({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final List<int> colorList = AppColors().colorList;
    return Column(
      children: [
        SwitchListTile(
          title: Text('Dark Mode'),
          value: DynamicTheme.of(context).themeId == 2,
          activeColor: DynamicTheme.of(context).theme.accentColor,
          onChanged: (value) {
            if (DynamicTheme.of(context).themeId == 2) {
              DynamicTheme.of(context).setTheme(AppThemes.Dark);
            } else {
              DynamicTheme.of(context)
                  .setTheme(AppThemes.LightBlue);
            }
          },
        ),
        // ListTile(
        //     title: SingleChildScrollView(
        //         padding: EdgeInsets.symmetric(vertical: 20),
        //         scrollDirection: Axis.horizontal,
        //         child: Row(
        //             children: colorList.map((color) {
        //           return IconButton(
        //               icon: Icon(
        //                 DynamicTheme.of(context).theme.color.value == color
        //                     ? Icons.check_circle_rounded
        //                     : Icons.circle,
        //                 color: Color(color),
        //                 size: 36,
        //               ),
        //               onPressed: () => DynamicTheme.of(context).theme
        //                   .setColor(color: Color(color), shouldSave: true));
        //         }).toList()))),
      ],
    );
  }
}

class UserSetings extends StatelessWidget {
  const UserSetings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
