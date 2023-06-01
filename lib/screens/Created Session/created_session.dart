import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project1/screens/Created%20Session/full_details_created.dart';
import 'package:test_project1/screens/Joined%20Session/joined_Session_display.dart';
import 'package:test_project1/screens/Create%20Workout/session_create.dart';
import 'package:test_project1/screens/View%20Workouts/session_detail.dart';

import '../Homescreen/homescreen_screen.dart';
import '../Joined Session/joined_session.dart';

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
              title: Text('Homepage'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Create Workout Session'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SessionCreate()),
                );
              },
            ),
            // Workout Sessions
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

                      return ListTile(
                        title: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[700],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 18),
                          child: Text(
                            sessionName,
                            style: GoogleFonts.bebasNeue(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateSessionDetail(
                                sessionData: sessionSnapshot.data()
                                    as Map<String, dynamic>,
                                sessionId:
                                    sessionId, // Pass the sessionId parameter here
                              ),
                            ),
                          );
                        },
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
