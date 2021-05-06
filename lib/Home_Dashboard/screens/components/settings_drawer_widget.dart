import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Authentification/screens/about.dart';
import 'package:productivity_app/Authentification/services/authentification_data.dart';
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
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor
            ),
            child: ListTile(
              title: Text(user.displayName, style: TextStyle(
                color: Theme.of(context).textTheme.subtitle2.color,
                fontSize: 24
              )),
              trailing: IconButton(icon: Icon(Icons.cancel_rounded), onPressed: () => Navigator.pop(context)),
            )
          ),
          ListTile(
            leading: Icon(Icons.account_circle_rounded),
            title: Text('User Settings'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserSetings())),
          ),
          ListTile(
            leading: Icon(Icons.brightness_6_rounded),
            title: Text('Theme Settings'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ThemeSettings())),),
          ListTile(
            leading: Icon(Icons.help_rounded),
            title: Text('About'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage())),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () => auth.signOut()
          )
        ],
      )
    );
  }
}

class UserSetings extends StatelessWidget {
  const UserSetings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}

class ThemeSettings extends StatelessWidget {
  const ThemeSettings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}