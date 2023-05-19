import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_project1/screens/session_create.dart';

class SessionDetailPage extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
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
          )
        ],
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, //Need to Edit this to make it Nice
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
            // Workout Sessions
            ListTile(
              title: Text('View Workout Sessions'),
              onTap: () {},
            ),

            // View Challenges
            ListTile(
              title: Text('View Workout Challenges'),
              onTap: () {},
            ),

            //Rewards
            ListTile(
              title: Text('Rewards'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('WorkoutSession').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final sessions = snapshot.data!.docs;

          if (sessions.isEmpty) {
            return Center(child: Text('No sessions found'));
          }

          return ListView.builder(
            itemCount: sessions.length,
            itemBuilder: (context, index) {
              final sessionData =
                  sessions[index].data() as Map<String, dynamic>;

              return ListTile(
                title: Text(sessionData['Title']),
                onTap: () {
                  // Handle tapping on a session item
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SessionDetail(sessionData: sessionData),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class SessionDetail extends StatelessWidget {
  final Map<String, dynamic> sessionData;

  const SessionDetail({Key? key, required this.sessionData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Full Details of Session'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sessionData['Title'],
              style: GoogleFonts.bebasNeue(
                fontSize: 35,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Type: ${sessionData['Type']}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Date: ${sessionData['Date']}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Time: ${sessionData['Time']}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Min People: ${sessionData['Min ppl'] ?? ''}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Max People: ${sessionData['Max ppl'] ?? ''}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Description: ${sessionData['Description'] ?? ''}',
              style: TextStyle(fontSize: 16),
            ),
            // Display other session details as desired
          ],
        ),
      ),
    );
  }
}
