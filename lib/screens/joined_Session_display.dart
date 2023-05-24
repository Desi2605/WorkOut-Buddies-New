import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class JoinSessionDetail extends StatelessWidget {
  final Map<String, dynamic>? sessionData;

  const JoinSessionDetail({Key? key, required this.sessionData})
      : super(key: key);

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
    int maxPeople = sessionData!['Maximum Participants'] ?? 0;
    String maxPeopleString =
        maxPeople != 0 ? maxPeople.toString() : 'No Max People';
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
          ],
        ),
      ),
    );
  }
}
