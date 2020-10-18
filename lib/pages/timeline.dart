import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:patienttalks/widgets/header.dart';
import 'package:patienttalks/widgets/progress.dart';

final CollectionReference usersRef = Firestore.instance.collection('users');

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  void initState() {
    super.initState();
    updateUser();
    deleteUser();
  }

  createUser() async {
    await usersRef
        .document('ddd66d6')
        .setData({'username': 'amr', 'postCount': 0, 'isAdmin': false});
  }

  updateUser() async {
    final doc = await usersRef.document('ddd66d6').get();
    if (doc.exists) {
      doc.reference
          .updateData({'username': 'said', 'postCount': 6, 'isAdmin': false});
    }
  }

  deleteUser() async {
    final doc = await usersRef.document('ddd66d6').get();
    if (doc.exists) {
      doc.reference.delete();
    }
  }

  TabBar tabBar;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: header(context,
              isAppTitle: true,
              tabBar: TabBar(tabs: [
                Tab(child: Center(child: Text('Main'))),
                Tab(child: Center(child: Text('followers')))
              ])),
          body: TabBarView(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: usersRef.snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return circularProgress();
                  }
                  final List<Text> children = snapshot.data.documents
                      .map((doc) => Text(doc['username']))
                      .toList();

                  return Container(
                    child: ListView(
                      children: children,
                    ),
                  );
                },
              ),
              Text('followers')
            ],
          ),
        ),
      ),
    );
  }
}
