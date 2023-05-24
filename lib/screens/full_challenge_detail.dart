import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChallengeDetail extends StatelessWidget {
  final Map<String, dynamic>? sessionData;

  const ChallengeDetail({Key? key, required this.sessionData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (sessionData == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Full Challenge Details'),
        ),
        body: Center(
          child: Text('No Challenges Listed'),
        ),
      );
    }

    String challengeTitle = sessionData!['title'] as String? ?? 'No Title';
    String challengeType = sessionData!['type'] as String? ?? 'No Type';
    Timestamp? challengeStartDate = sessionData!['startDate'] as Timestamp?;
    Timestamp? challengeEndDate = sessionData!['endDate'] as Timestamp?;
    String description =
        sessionData!['description'] as String? ?? 'No Description';

    String formattedStartDate = challengeStartDate != null
        ? challengeStartDate.toDate().toString()
        : 'No Start Time';

    String formattedEndDate = challengeEndDate != null
        ? challengeEndDate.toDate().toString()
        : 'No End Time';

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
              challengeTitle,
              style: GoogleFonts.bebasNeue(
                fontSize: 35,
              ),
            ),
            SizedBox(height: 25),
            Text(
              'Challenge Type: $challengeType',
              style: GoogleFonts.bebasNeue(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Start Date: $formattedStartDate',
              style: GoogleFonts.bebasNeue(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'End Date: $formattedEndDate',
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
              onPressed: () {
                // Handle joining the session
                joinSession(context);
              },
              child: Text('Join Session'),
            ),
          ],
        ),
      ),
    );
  }

  // Function to handle joining the session
  void joinSession(BuildContext context) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      String userId = currentUser.uid;

      // Retrieve the logged-in user's first name from the "Users" collection
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .get();
      if (userSnapshot.exists) {
        String firstName = userSnapshot['Firstname'] as String? ?? '';

        // Get the session ID from the sessionData
        String? sessionId = sessionData?['sessionId'] as String?;

        if (sessionId != null) {
          // Update the "WorkoutChallenges" document with the user's first name
          DocumentReference sessionRef = FirebaseFirestore.instance
              .collection('WorkoutChallenges')
              .doc(sessionId);

          await FirebaseFirestore.instance.runTransaction((transaction) async {
            DocumentSnapshot sessionSnapshot =
                await transaction.get(sessionRef);

            if (sessionSnapshot.exists) {
              List<dynamic> participants =
                  sessionSnapshot['participants'] as List<dynamic>? ?? [];
              participants.add(firstName);

              transaction.update(sessionRef, {'participants': participants});
            }
          });

          // Show a snackbar indicating successful join
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('You have joined the challenge!'),
            ),
          );

          // TODO: Add any additional logic or navigate to a new screen after joining the session
        } else {
          // Handle the case when the session ID is null
          print('Session ID is null');
        }
      }
    }
  }
}
