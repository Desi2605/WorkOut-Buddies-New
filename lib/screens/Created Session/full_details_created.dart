import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateSessionDetail extends StatelessWidget {
  final Map<String, dynamic>? sessionData;

  const CreateSessionDetail({Key? key, required this.sessionData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (sessionData == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Created Session Details'),
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

    String Participants = '';

    if (sessionData!['participants'] != null) {
      final participants = sessionData!['participants'] as List<dynamic>;
      Participants = participants.join(', ');
    } else {
      Participants = 'No Participants';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Created Session Detail'),
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
            SizedBox(height: 20),
            Text(
              'Participants: $Participants',
              style: GoogleFonts.bebasNeue(fontSize: 20),
            ),
            // Display other session details as desired

            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
