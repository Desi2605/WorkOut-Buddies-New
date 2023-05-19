import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SessionDetail extends StatelessWidget {
  final Map<String, dynamic>? sessionData;

  const SessionDetail({Key? key, required this.sessionData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (sessionData == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Full Details of Session'),
        ),
        body: Center(
          child: Text('Session data is unavailable.'),
        ),
      );
    }

    String sessionTitle = sessionData!['Title'] ?? 'No Title';
    String sessionType = sessionData!['Type'] ?? 'No Type';
    String sessionDate = sessionData!['Date'] ?? 'No Date';
    String sessionStartTime = sessionData!['Start Time'] ?? 'No Start Time';
    String sessionEndTime = sessionData!['End Time'] ?? 'No End Time';
    String minPeople = sessionData!['Min ppl']?.toString() ?? 'No Min People';
    String maxPeople = sessionData!['Max ppl']?.toString() ?? 'No Max People';
    String description = sessionData!['Description'] ?? 'No Description';

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
              sessionTitle,
              style: GoogleFonts.bebasNeue(
                fontSize: 35,
              ),
            ),
            SizedBox(height: 25),
            Text(
              ' Workout Type: $sessionType',
              style: GoogleFonts.bebasNeue(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Date: $sessionDate',
              style: GoogleFonts.bebasNeue(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Start Time: $sessionStartTime',
              style: GoogleFonts.bebasNeue(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'End Time: $sessionEndTime',
              style: GoogleFonts.bebasNeue(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Min People: $minPeople',
              style: GoogleFonts.bebasNeue(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Max People: $maxPeople',
              style: GoogleFonts.bebasNeue(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Description: $description',
              style: GoogleFonts.bebasNeue(fontSize: 20),
            ),
            // Display other session details as desired

            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () async {
                FirebaseAuth auth = FirebaseAuth.instance;
                User? user = auth.currentUser;

                if (user != null) {
                  String sessionId = sessionData!['SessionId'];
                  String displayName = user.displayName ?? '';
                  String firstName;

                  if (displayName.isNotEmpty) {
                    firstName =
                        displayName.split(' ')[0]; // Extract the first name
                  } else {
                    firstName = user.email!.split(
                        '@')[0]; // Use the email address as the first name
                  }

                  if (firstName.isNotEmpty) {
                    joinSession(sessionId, firstName);
                  } else {
                    print('User does not have a valid first name');
                  }
                } else {
                  print('User not logged in');
                }
              },
              child: Text('Join Session'),
            ),
          ],
        ),
      ),
    );
  }

  void joinSession(String sessionId, String userFirstName) {
    FirebaseFirestore.instance
        .collection('WorkoutSession')
        .where('SessionId', isEqualTo: sessionId)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        final sessionDocumentId = snapshot.docs[0].id;

        FirebaseFirestore.instance
            .collection('WorkoutSession')
            .doc(sessionDocumentId)
            .update({
          'participants': FieldValue.arrayUnion([userFirstName])
        }).then((_) {
          print('Successfully joined the session.');
          // Add any additional logic you want to execute after joining the session
        }).catchError((error) {
          print('Error updating session participants: $error');
          // Handle the error in an appropriate way, such as displaying an error message
        });
      } else {
        print('Session document does not exist.');
        // Handle the case where the session document does not exist
      }
    }).catchError((error) {
      print('Error retrieving session document: $error');
      // Handle the error in an appropriate way, such as displaying an error message
    });
  }
}
