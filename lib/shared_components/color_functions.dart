import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:productivity_app/services/projects_data.dart';
import 'package:provider/provider.dart';

class ProjectColors {
  final List<int> colorList = [   // 20
    0xFFFF8a80, // Light Red
    0xFFD50000, // Red
    0xFF950000, // Dark Red
    0xFFE040FB, // Purple
    0xFFAA00FF, // Dark Purple
    0xFF1A237E, // Indigo
    0xFF2962FF, // Blue
    0xFF40C4FF, // Light Blue
    0xFF18FFFF, // Cyan
    0xFF1DE9B6, // Teal
    0xFF00C853, // Green
    0xFF1B5E20, // Dark Green
    0xFF76FF03, // Light Green
    0xFFFFC400, // Gold
    0xFFFF9100, // Orange
    0xFFFF3D00, // Deep Orange
    0xFFA1887F, // Light Brown
    0xFF4E342E, // Dark Brown
    0xFF757575, // Gray
    0xFF607D8B, // Blue Gray
  ];

  Color getColor({int colorNumber}) {
    final Color color = Color(colorList[colorNumber]);
    return color;
  }

  Widget colorSelector(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) {
        return colorList
            .map((color) => PopupMenuItem(
                  child: Icon(
                    Icons.circle,
                    color: Color(color),
                  ),
                  value: color,
                ))
            .toList();
      },
      onSelected: (value) {
        return value;
      },
    );
  }

  Widget getProjectColoredText(BuildContext context, String projectName) {
    final User user = Provider.of<User>(context);
    return FutureBuilder(
      future: ProjectService()
          .projects
          .where('projectName', isEqualTo: projectName)
          .get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading');
        }
        int colorNumber = snapshot.data.docs[0].data()['projectColor'];
        final Color projectColor = Color(colorNumber);
        return Text(projectName, style: TextStyle(color: projectColor));
      },
    );
  }

  // colorReturn(User user, String projectName) {
  //   ProjectService(user: user)
  //       .projects
  //       .where('projectName', isEqualTo: projectName)
  //       .get()
  //       .then((QuerySnapshot query) {
  //     Color color = getColor(colorNumber: query.docs[0].data()['projectColor']);
  //     print(color);
  //     return color;
  //   });
  // }

  // Future colorReturn2(User user, String projectName) {
  //   ProjectService(user: user)
  //       .projects
  //       .where('projectName', isEqualTo: projectName)
  //       .get()
  //       .then((QuerySnapshot query) {
  //     return query.docs[0].data()['projectColor'];
  //   });
  // }
}
