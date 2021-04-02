import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:productivity_app/Authentification/screens/sign_in_page.dart';
import 'package:productivity_app/Task_Feature/models/projects.dart';
import 'package:productivity_app/Task_Feature/models/status.dart';
import 'package:productivity_app/Task_Feature/models/tasks.dart';
import 'package:productivity_app/Time_Feature/models/times.dart';
import 'package:productivity_app/Home_Dashboard/screens/home_screen.dart';
import 'package:productivity_app/Authentification/services/authentification_data.dart';
import 'package:productivity_app/Task_Feature/services/projects_data.dart';
import 'package:productivity_app/Task_Feature/services/statuses_data.dart';
import 'package:productivity_app/Task_Feature/services/tasks_data.dart';
import 'package:productivity_app/Time_Feature/services/times_data.dart';
import 'package:productivity_app/Shared/widgets/base_framework.dart';
import 'package:productivity_app/Users/models/user_model.dart';
import 'package:provider/provider.dart';
import 'package:productivity_app/test_screen.dart';


/// Builds the signed-in or non signed-in UI, depending on the user snapshot.
/// This widget should be below the [MaterialApp].
/// An [AuthWidgetBuilder] ancestor is required for this widget to work.
 
 
class AuthWidget extends StatelessWidget {
  const AuthWidget({Key key, @required this.userSnapshot}) : super(key: key);
  final AsyncSnapshot<UserModel> userSnapshot;

  @override
  Widget build(BuildContext context) {
    if (userSnapshot.connectionState == ConnectionState.active) {
      return userSnapshot.hasData ? BaseFramework() : SignInPage();
    }
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}


// class Wrapper extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // List<Project> projects = Provider.of<List<Project>>(context);
//     // List<Status> statuses =  Provider.of<List<Status>>(context);
//     final User user = Provider.of<User>(context);
//     if (user == null) {
//       return Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//                 onPressed: () {
//                   AuthService().signInWithEmailAndPassword(
//                       'zaw1593@yahoo.com', 'testing123456');
//                 },
//                 child: Text('Sign In')),
//             ElevatedButton(
//               onPressed: () {
//                 AuthService().registerWithEmailAndPassword(
//                     'zaw1593@yahoo.com', 'testing123456');
//               },
//               child: Text('Register'),
//             )
//           ]);
//     }
//     if (!user.emailVerified) {
//       user.sendEmailVerification();
//       // var actionCodeSettings = ActionCodeSettings(   // TODO: add email verification redirect to app
//       //   url: 'https://www.'
//       // )
//     }
//     return
//         // MultiProvider(
//         //   providers: [
//         //     StreamProvider.value(value: TaskService().streamTasks(projects, statuses)),
//         //     StreamProvider<List<TimeEntry>>.value(value: TimeService().streamTimeEntries(projects)),
//         //   ],
//         // child:
//         BaseFramework();
//     // );
//   }
// }
