import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_project1/screens/joined_Session_display.dart';
import 'package:test_project1/screens/session_create.dart';
import 'package:test_project1/screens/session_detail.dart';

import 'joined_session.dart';

class CreatedDetailPage extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final DocumentReference userDoc =
        FirebaseFirestore.instance.collection('Users').doc(user!.uid);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer(); // Open the drawer
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.5),
            child: Icon(Icons.person),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              title: Text('Create Workout Session'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SessionCreate()),
                );
              },
            ),
            ListTile(
              title: Text('Workout Sessions'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SessionDetailPage()),
                );
              },
            ),
            ListTile(
              title: Text('Joined Sessions'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JoinedDetailPage()),
                );
              },
            ),
            ListTile(
              title: Text('Created Sessions'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreatedDetailPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: userDoc.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData && snapshot.data!.exists) {
            final List<String> sessionIds =
                List<String>.from(snapshot.data!.get('CreatedSession'));

            if (sessionIds.isEmpty) {
              return Center(
                child: Text('No created sessions found.'),
              );
            }

            return ListView.builder(
              itemCount: sessionIds.length,
              itemBuilder: (context, index) {
                final String sessionId = sessionIds[index];

                return FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('WorkoutSession')
                      .doc(sessionId)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    if (snapshot.hasData && snapshot.data!.exists) {
                      final DocumentSnapshot sessionSnapshot = snapshot.data!;
                      final String sessionName = sessionSnapshot.get('Title');

                      return Card(
                        child: ListTile(
                          title: Text('Session Name: $sessionName'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                          onTap: () {},
                        ),
                      );
                    }
                    return Text('Failed to load session data.');
                  },
                );
              },
            );
          }

          return Center(
            child: Text('Failed to load created sessions.'),
          );
        },
      ),
    );
  }
}
