import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:productivity_app/Time_Feature/models/models.dart';

import '../../../Task_Feature/Task_Feature.dart';

class DatabaseService extends ChangeNotifier {
  User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  // StreamSubscription<QuerySnapshot>? taskSubscription;
  Stream<List<Task>>? taskListStream;
  List<Task> tasks = [];
  // StreamSubscription<QuerySnapshot>? statusSubscription;
  Stream<List<Status>>? statusListStream;
  List<Status> statuses = [];
  // StreamSubscription<QuerySnapshot>? projectSubscription;
  Stream<List<Project>>? projectListStream;
  List<Project> projects = [];
  // StreamSubscription<QuerySnapshot>? timeEntrySubscription;
  Stream<List<TimeEntry>>? timeEntryListStream;
  List<TimeEntry> timeEntries = [];

  CollectionReference<Task>? taskReference;
  CollectionReference<Project>? projectReference;
  CollectionReference<Status>? statusReference;
  CollectionReference<TimeEntry>? timeEntryReference;

  DatabaseService() {
    init();
  }

  Future<void> init() async {
    projectReference = FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection('projects')
        .withConverter<Project>(
          fromFirestore: (DocumentSnapshot<Map<String, dynamic>> snapshot, _) =>
              Project.fromJson(
            snapshot.data()!,
            snapshot,
          ),
          toFirestore: (project, _) => project.toJson(),
        );
    projectListStream = projectReference?.snapshots().map(
        (QuerySnapshot<Project> querySnapshot) => querySnapshot.docs
                .map((QueryDocumentSnapshot<Project> documentSnapshot) {
              projects.add(documentSnapshot.data());
              notifyListeners();
              return documentSnapshot.data();
            }).toList());
    // .listen((QuerySnapshot<Project> querySnapshot) {
    //   querySnapshot.docs.forEach((QueryDocumentSnapshot<Project> documentSnapshot) {
    //     projects.add(documentSnapshot.data());
    //   });
    //   notifyListeners();
    // });
    statusReference = FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection('statuses')
        .withConverter<Status>(
          fromFirestore: (DocumentSnapshot<Map<String, dynamic>> snapshot, _) =>
              Status.fromJson(
            snapshot.data()!,
            snapshot,
          ),
          toFirestore: (status, _) => status.toJson(),
        );
    statusListStream = statusReference?.snapshots().map(
        (QuerySnapshot<Status> querySnapshot) => querySnapshot.docs
                .map((QueryDocumentSnapshot<Status> documentSnapshot) {
              statuses.add(documentSnapshot.data());
              notifyListeners();
              return documentSnapshot.data();
            }).toList());
    // .listen((QuerySnapshot<Status> querySnapshot) {
    //   querySnapshot.docs.forEach((QueryDocumentSnapshot<Status> documentSnapshot) {
    //     statuses.add(documentSnapshot.data());
    //   });
    //   notifyListeners();
    // });
    taskReference = FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection('tasks')
        .withConverter<Task>(
          fromFirestore: (DocumentSnapshot<Map<String, dynamic>> snapshot, _) =>
              Task.fromJson(
                  snapshot.data()!,
                  snapshot,
                  getProject(snapshot.data()!['project'] as String?),
                  getStatus(snapshot.data()!['status'] as String?)),
          toFirestore: (task, _) => task.toJson(),
        );
    taskListStream = taskReference?.snapshots().map(
        (QuerySnapshot<Task> querySnapshot) => querySnapshot.docs
                .map((QueryDocumentSnapshot<Task> documentSnapshot) {
              tasks.add(documentSnapshot.data());
              notifyListeners();
              return documentSnapshot.data();
            }).toList());
    // .listen((QuerySnapshot<Task> querySnapshot) {
    //   querySnapshot.docs.forEach((QueryDocumentSnapshot<Task> documentSnapshot) {
    //     tasks.add(documentSnapshot.data());
    //   });
    //   notifyListeners();
    // });
    timeEntryReference = FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection('timeEntries')
        .withConverter<TimeEntry>(
          fromFirestore: (DocumentSnapshot<Map<String, dynamic>> snapshot, _) =>
              TimeEntry.fromJson(
                  snapshot.data()!,
                  snapshot,
                  getProject(snapshot.data()!['project'] as String?),
                  getTask(snapshot.data()!['task'] as String?)),
          toFirestore: (timeEntry, _) => timeEntry.toJson(),
        );
    timeEntryListStream = timeEntryReference?.snapshots().map(
        (QuerySnapshot<TimeEntry> querySnapshot) => querySnapshot.docs
                .map((QueryDocumentSnapshot<TimeEntry> documentSnapshot) {
              timeEntries.add(documentSnapshot.data());
              notifyListeners();
              return documentSnapshot.data();
            }).toList());
    // .listen((QuerySnapshot<TimeEntry> querySnapshot) {
    //   querySnapshot.docs.forEach((QueryDocumentSnapshot<TimeEntry> documentSnapshot) {
    //     entries.add(documentSnapshot.data());
    //   });
    //   notifyListeners();
    // });
  }

  Project? getProject(String? projectID) {
    if (projectID == null) {
      return null;
    }
    return projects.singleWhere((project) => project.id == projectID);
  }

  Status? getStatus(String? statusID) {
    if (statusID == null) {
      return null;
    }
    return statuses.singleWhere((status) => status.id == statusID);
  }

  Task? getTask(String? taskID) {
    if (taskID == null) {
      return null;
    }
    return tasks.singleWhere((task) => task.id == taskID);
  }

  // Collection reference
  final CollectionReference rootCollection =
      FirebaseFirestore.instance.collection('users');

  // Add item to Firestore
  Future<void> addItem(
      {required CollectionReference<dynamic>? collectionReference,
      required Object object}) async {
    return collectionReference
        ?.add(object)
        .then((value) => print('${object.toString()} Added'))
        .catchError(
            (error) => print('Failed to add ${object.toString()}: $error'));
  }

  // Update item in Firestore
  Future<void> updateItem(
      {required CollectionReference<dynamic>? collectionReference,
      required Map<String, Object?> updateData,
      String? objectID}) async {
    return collectionReference
        ?.doc(objectID)
        .update(updateData)
        .then((value) => print('${collectionReference.path} Updated'))
        .catchError((error) =>
            print('Failed to add ${collectionReference.path}: $error'));
  }

  // Update batch items in Firestore
  Future<void> updateBatchItems(String type, List<dynamic> itemsToUpdate) {
    WriteBatch batch = firestore.batch();
    for (dynamic item in itemsToUpdate) {
      DocumentReference documentReference = rootCollection
          .doc(user!.uid)
          .collection(type)
          .doc(item.id.toString());
      Map<String, dynamic> mapOfItem =
          item.toFirestore() as Map<String, dynamic>;
      batch.update(documentReference, mapOfItem);
    }
    return batch
        .commit()
        .then((value) => print('Batch Update Complete'))
        .catchError((error) => print('Failes Batch Update: $error'));
  }

  // Delete item out of Firestore
  Future<void> deleteItem(
      {required CollectionReference collectionReference,
      required String objectID}) async {
    return collectionReference
        .doc(objectID)
        .delete()
        .then((value) => print('${collectionReference.path} Deleted'))
        .catchError((error) =>
            print('Failed to add ${collectionReference.path}: $error'));
  }

  // Build new user collections
  Future<void> buildNewUser() async {
    final DocumentReference userDocument = rootCollection.doc(user!.uid);
    WriteBatch batch = FirebaseFirestore.instance.batch();

    final List<Status> statuses = [
      Status(
          statusName: 'To Do',
          statusColor: 2,
          statusOrder: 1,
          equalToComplete: false,
          statusDescription:
              'This status represents tasks that have not been started.'),
      Status(
          statusName: 'In Progress',
          statusColor: 5,
          statusOrder: 2,
          equalToComplete: false,
          statusDescription:
              'This status represents tasks that have been started but not completed.'),
      Status(
          statusName: 'Review',
          statusColor: 0,
          statusOrder: 3,
          equalToComplete: false,
          statusDescription:
              'This status represents tasks that have been completed.'),
      Status(
          statusName: 'Done',
          statusColor: 9,
          statusOrder: 4,
          equalToComplete: true,
          statusDescription:
              'This status represents tasks that have been completed.')
    ];
    Task exampleTask = Task(
      createDate: DateTime.now(),
      taskName: 'This is what an example task will look like',
    );
    Project exampleProject = Project(projectName: 'This is an example project');
    TimeEntry exampleEntry = TimeEntry(
        entryName: 'This is an example time entry',
        startTime: DateTime.now(),
        endTime: DateTime.now().add(Duration(hours: 1)));

    statuses.forEach((status) {
      batch.set(userDocument.collection('statuses').doc(), status.toJson());
    });
    batch.set(userDocument.collection('tasks').doc(), exampleTask.toJson());
    batch.set(
        userDocument.collection('projects').doc(), exampleProject.toJson());
    batch.set(userDocument.collection('timeEntries').doc(), exampleEntry.toJson());
  }
}
