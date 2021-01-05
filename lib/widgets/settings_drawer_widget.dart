import 'package:flutter/material.dart';

class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Stack(
                children: <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(color: Colors.blue),
                    child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                        ),
                        title: Text(
                          'User\s Name',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          'dapibus ultrices in iaculis nunc sed augue lacus viverra vitae congue eu consequat ac felis donec et odio pellentesque ',
                          overflow: TextOverflow.fade,
                          maxLines: 4,
                        )),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(Icons.clear_rounded),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              )),
          Expanded(
            flex: 4,
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.settings_applications_rounded),
                  title: Text('Settings'),
                ),
                ListTile(
                  leading: Icon(Icons.settings_applications_rounded),
                  title: Text('Settings'),
                ),
                ListTile(
                  leading: Icon(Icons.settings_applications_rounded),
                  title: Text('Settings'),
                ),
                ListTile(
                  leading: Icon(Icons.settings_applications_rounded),
                  title: Text('Settings'),
                ),
                ListTile(
                  leading: Icon(Icons.settings_applications_rounded),
                  title: Text('Settings'),
                ),
                ListTile(
                  leading: Icon(Icons.settings_applications_rounded),
                  title: Text('Settings'),
                ),
                ListTile(
                  leading: Icon(Icons.settings_applications_rounded),
                  title: Text('Settings'),
                ),
                ListTile(
                  leading: Icon(Icons.settings_applications_rounded),
                  title: Text('Settings'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}