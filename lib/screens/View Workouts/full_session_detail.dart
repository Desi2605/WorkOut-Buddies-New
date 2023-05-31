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

    String sessionTitle = sessionData!['Title'] as String? ?? 'No Title';
    String sessionType = sessionData!['Type'] as String? ?? 'No Type';
    String sessionDate = sessionData!['Date'] as String? ?? 'No Date';
    String sessionStartTime =
        sessionData!['Start Time'] as String? ?? 'No Start Time';
    String sessionEndTime =
        sessionData!['End Time'] as String? ?? 'No End Time';
    String maxPeople =
        sessionData!['Maximum Participants']?.toString() ?? 'No Max People';
    String description =
        sessionData!['Description'] as String? ?? 'No Description';

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
                  String sessionId = sessionData!['SessionId'] as String? ?? '';

                  String firstName = await fetchUserFirstName(user.uid!);

                  if (firstName.isNotEmpty) {
                    joinSession(sessionId, firstName, maxPeople, context);
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

  Future<String> fetchUserFirstName(String uid) async {
    String firstName = '';

    try {
      DocumentSnapshot snapshot =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();

      if (snapshot.exists) {
        final userData = snapshot.data() as Map<String, dynamic>;
        firstName = userData['Firstname'] as String? ?? '';
      } else {
        print('User document does not exist');
      }
    } catch (error) {
      print('Error retrieving user document: $error');
    }

    return firstName;
  }

  void joinSession(String sessionId, String firstName, String maxPeople,
      BuildContext context) {
    FirebaseFirestore.instance
        .collection('WorkoutSession')
        .where('SessionId', isEqualTo: sessionId)
        .get()
        .then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        final sessionDocument = snapshot.docs[0];
        final sessionData = sessionDocument.data() as Map<String, dynamic>;
        final participants = sessionData['participants'] as List<dynamic>?;
        final sessionStatus = sessionData['SessionStatus'] as String?;

        if (sessionStatus == 'Disabled') {
          // Session is disabled, show a snackbar message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Sorry, the session is currently disabled due to some issues.'),
              duration: Duration(seconds: 3),
            ),
          );
          return;
        }

        if (participants != null &&
            participants.length >= int.parse(maxPeople)) {
          // Session is full, show a snackbar message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Sorry, the session is already full.'),
              duration: Duration(seconds: 3),
            ),
          );
          return;
        }

        final sessionDocumentId = sessionDocument.id;

        FirebaseFirestore.instance
            .collection('WorkoutSession')
            .doc(sessionDocumentId)
            .update({
          'participants': FieldValue.arrayUnion([firstName])
        }).then((_) {
          print('Successfully joined the session.');

          // Store the session document ID in the user's document
          FirebaseAuth auth = FirebaseAuth.instance;
          User? user = auth.currentUser;
          if (user != null) {
            FirebaseFirestore.instance
                .collection('Users')
                .doc(user.uid)
                .update({
              'JoinedSessions': FieldValue.arrayUnion([sessionDocumentId])
            }).then((_) {
              print('Session document ID stored in the user document.');
            }).catchError((error) {
              print('Error updating user document: $error');
            });
          } else {
            print('User not logged in');
          }

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
