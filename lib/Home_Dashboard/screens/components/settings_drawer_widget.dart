import 'package:dynamic_color_theme/dynamic_color_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/Services/database.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Authentification/Authentification.dart';
import '../../../Shared/Shared.dart';


class SettingsDrawer extends StatelessWidget {
  String githubURL = 'https://github.com/Z-inator/productivity_app';

  Future<void> launchURL() async => await canLaunch(githubURL)
      ? await launch(githubURL)
      : throw 'Could not launch $githubURL';

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = DynamicColorTheme.of(context).data;
    AuthService auth = Provider.of<AuthService>(context);
    User user = auth.user!;
    return Drawer(
        child: Column(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: themeData.colorScheme.secondaryVariant),
          child: ListTile(
            title: Text('${user.displayName}\nSettings',
                style: themeData
                    .textTheme
                    .headline5!
                    .copyWith(
                        color: themeData
                            .colorScheme
                            .onSecondary)),
            trailing: IconButton(
                icon: Icon(Icons.cancel_rounded),
                onPressed: () => Navigator.pop(context)),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ExpansionTile(
                  leading: Icon(Icons.account_circle_rounded),
                  title: Text('Account Settings'),
                  children: [
                    ChangeDisplayNameDialog(),
                    ChangeEmailDialog(),
                    ChangePasswordDialog(),
                    DeleteUserDialog()
                  ],
                ),
                ExpansionTile(
                  leading: Icon(Icons.brightness_6_rounded),
                  title: Text('Theme Settings'),
                  children: [ThemeSettings()],
                ),
                ExpansionTile(
                  leading: Icon(Icons.help_rounded),
                  title: Text('About'),
                  children: [
                    ListTile(
                      title: Text('Creator: Z-inator'),
                      subtitle: Text('License: MIT License\nVersion: 1.0'),
                      trailing: IconButton(
                        icon: Icon(Icons.open_in_browser_rounded),
                        tooltip: 'Go to GitHub',
                        onPressed: launchURL,
                      ),
                    )
                  ],
                ),
                ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Logout'),
                    onTap: () => auth.signOut())
              ],
            ),
          ),
        )
      ],
    ));
  }
}

class ThemeSettings extends StatelessWidget {
  ThemeSettings({Key? key}) : super(key: key);
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

class ChangeDisplayNameDialog extends StatefulWidget {
  ChangeDisplayNameDialog({Key? key}) : super(key: key);

  @override
  _ChangeDisplayNameDialogState createState() =>
      _ChangeDisplayNameDialogState();
}

class _ChangeDisplayNameDialogState extends State<ChangeDisplayNameDialog> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<AuthService>(context).user!;
    return ListTile(
      title: Text('Display Name: ${user.displayName}'),
      trailing: IconButton(
        icon: Icon(Icons.edit_rounded),
        onPressed: () => showDialog(
            context: context,
            builder: (context) {
              String displayName = user.displayName!;
              GlobalKey<FormState> displayChangeFormKey =
                  GlobalKey<FormState>();
              String? updateError;
              return AlertDialog(
                title: Text('Change display name'),
                content: Form(
                    key: displayChangeFormKey,
                    child: TextFormField(
                      decoration: InputDecoration(hintText: 'New display name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email address';
                        }
                        return null;
                      },
                      textAlign: TextAlign.center,
                      onChanged: (newText) {
                        setState(() {
                          displayName = newText;
                        });
                      },
                    )),
                actions: [
                  TextButton(
                    child: Text('Cancel'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  TextButton(
                    child: Text('Update Email'),
                    onPressed: () async {
                      if (displayChangeFormKey.currentState!.validate()) {
                        await user
                            .updateProfile(displayName: displayName)
                            .catchError(
                                (error) => updateError = error.toString());
                        if (updateError != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(updateError!)));
                        } else {
                          Navigator.of(context).pop(context);
                        }
                      }
                    },
                  )
                ],
              );
            }),
      ),
    );
  }
}

class ChangePasswordDialog extends StatefulWidget {
  ChangePasswordDialog({Key? key}) : super(key: key);

  @override
  _ChangePasswordDialogState createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<AuthService>(context).user!;
    AuthService auth = Provider.of<AuthService>(context);
    return ListTile(
        title: Text('Change Password'),
        trailing: IconButton(
            icon: Icon(Icons.edit_rounded),
            onPressed: () => showDialog(
                context: context,
                builder: (context) {
                  GlobalKey<FormState> passwordChangeFormKey =
                      GlobalKey<FormState>();
                  Icon passwordNotValid =
                      Icon(Icons.close_rounded, color: Colors.red);
                  Icon passwordValid =
                      Icon(Icons.check_rounded, color: Colors.green);
                  bool? password1Valid;
                  bool? password2Matches;
                  String? password;
                  String? updateError;
                  return AlertDialog(
                    title: Text('Change Password'),
                    content: Form(
                      key: passwordChangeFormKey,
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: 'Enter your Password',
                              helperText:
                                  'Passwords must be at least 8 characters long and include an uppercase letter, lowercase letter, number, and special character.',
                              helperMaxLines: 3,
                              icon: password1Valid == null
                                  ? Icon(Icons.lock_rounded)
                                  : password1Valid
                                      ? passwordValid
                                      : passwordNotValid),
                          textAlign: TextAlign.center,
                          validator: (password) =>
                              auth.passwordValidation(password),
                          onChanged: (value) {
                            if (auth.passwordValidation(value) == null) {
                              setState(() {
                                password1Valid = true;
                                password = value;
                              });
                            } else {
                              setState(() {
                                password1Valid = false;
                                password = value;
                              });
                            }
                          },
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: 'Re-enter your Password',
                              helperText: 'Passwords must match',
                              icon: password2Matches == null
                                  ? Icon(Icons.lock_rounded)
                                  : password2Matches
                                      ? passwordValid
                                      : passwordNotValid),
                          textAlign: TextAlign.center,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please re-enter your password';
                            } else if (value != password) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            if (value == password) {
                              setState(() {
                                password2Matches = true;
                              });
                            } else {
                              setState(() {
                                password2Matches = false;
                              });
                            }
                          },
                        ),
                      ]),
                    ),
                    actions: [
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      TextButton(
                        child: Text('Update Password'),
                        onPressed: () async {
                          // FocusScopeNode currentFocus = FocusScope.of(context);
                          // if (!currentFocus.hasPrimaryFocus) {
                          //   currentFocus.unfocus();
                          // }
                          if (passwordChangeFormKey.currentState!.validate()) {
                            await user.updatePassword(password!).catchError(
                                (error) => updateError = error.toString());
                            if (updateError != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(updateError!)));
                            } else {
                              Navigator.of(context).pop(context);
                            }
                          }
                        },
                      )
                    ],
                  );
                })));
  }
}

class ChangeEmailDialog extends StatefulWidget {
  ChangeEmailDialog({Key? key}) : super(key: key);

  @override
  _ChangeEmailDialogState createState() => _ChangeEmailDialogState();
}

class _ChangeEmailDialogState extends State<ChangeEmailDialog> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<AuthService>(context).user!;
    return ListTile(
        title: Text(user.email!),
        trailing: IconButton(
            icon: Icon(Icons.edit_rounded),
            onPressed: () => showDialog(
                context: context,
                builder: (context) {
                  GlobalKey<FormState> emailChangeFormKey =
                      GlobalKey<FormState>();
                  String email = user.email!;
                  String confirmEmail = user.email!;
                  String? updateError;
                  return AlertDialog(
                    title: Text('Change Email'),
                    content: Form(
                      key: emailChangeFormKey,
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        TextFormField(
                          decoration: InputDecoration(hintText: 'New email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an email address';
                            }
                            return null;
                          },
                          textAlign: TextAlign.center,
                          onChanged: (newText) {
                            setState(() {
                              email = newText;
                            });
                          },
                        ),
                        TextFormField(
                          decoration:
                              InputDecoration(hintText: 'Confirm new email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an email address';
                            } else if (value != email) {
                              return 'Emails must match';
                            }
                          },
                          textAlign: TextAlign.center,
                          onChanged: (newText) {
                            setState(() {
                              confirmEmail = newText;
                            });
                          },
                        )
                      ]),
                    ),
                    actions: [
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      TextButton(
                        child: Text('Update Email'),
                        onPressed: () async {
                          // FocusScopeNode currentFocus = FocusScope.of(context);
                          // if (!currentFocus.hasPrimaryFocus) {
                          //   currentFocus.unfocus();
                          // }
                          if (emailChangeFormKey.currentState!.validate()) {
                            await user.updateEmail(confirmEmail).catchError(
                                (error) => updateError = error.toString());
                            if (updateError != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(updateError!)));
                            } else {
                              Navigator.of(context).pop(context);
                            }
                          }
                        },
                      )
                    ],
                  );
                })));
  }
}

class DeleteUserDialog extends StatefulWidget {
  DeleteUserDialog({Key? key}) : super(key: key);

  @override
  _DeleteUserDialogState createState() => _DeleteUserDialogState();
}

class _DeleteUserDialogState extends State<DeleteUserDialog> {
  @override
  Widget build(BuildContext context) {
    AuthService authService = Provider.of<AuthService>(context);
    ThemeData themeData = DynamicColorTheme.of(context).data;
    return ListTile(
      tileColor: themeData.colorScheme.error,
      title: Text('Delete User',
          style: themeData.textTheme.subtitle1!
              .copyWith(color: themeData.colorScheme.onError)),
      trailing: IconButton(
        icon: Icon(Icons.delete_forever_rounded,
            color: themeData.colorScheme.onError),
        onPressed: () => showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Are you sure you want to delete your account?'),
                content: Text(
                    'This action cannot be undone and will result in a complete loss of all your tracked time entries, tasks, projects, and statuses.'),
                actions: [
                  TextButton(
                    child: Text('Cancel'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  TextButton(
                    child: Text('Confirm Deletion'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      authService
                          .deleteUser(Provider.of<DatabaseService>(context));
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            }),
      ),
    );
  }
}


// class UserSetings extends StatelessWidget {
//   const UserSetings({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     AuthService authService = Provider.of<AuthService>(context);
//     User user = authService.user!;
//     return Container(
//         child: SafeArea(
//       child: Scaffold(
//           appBar: AppBar(
//             title: Text(user.displayName!),
//             actions: [ChangeDisplayNameDialog()],
//           ),
//           body: Column(
//             children: [ChangeEmailDialog(), ChangePasswordDialog()],
//           ),
//           floatingActionButton: FloatingActionButton.extended(
//             backgroundColor:
//                 DynamicColorTheme.of(context).data.colorScheme.error,
//             foregroundColor:
//                 DynamicColorTheme.of(context).data.colorScheme.onError,
//             label: Text('Delete User'),
//             onPressed: () => showDialog(
//                 context: context,
//                 builder: (context) {
//                   return AlertDialog(
//                     title:
//                         Text('Are you sure you want to delete your account?'),
//                     content: Text(
//                         'This action cannot be undone and will result in a complete loss of all your tracked time entries, tasks, projects, and statuses.'),
//                     actions: [
//                       TextButton(
//                         child: Text('Cancel'),
//                         onPressed: () => Navigator.of(context).pop(),
//                       ),
//                       TextButton(
//                         child: Text('Confirm Deletion'),
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                           authService.deleteUser(
//                               Provider.of<DatabaseService>(context));
//                           Navigator.of(context).pop();
//                         },
//                       )
//                     ],
//                   );
//                 }),
//           )),
//     ));
//   }
// }