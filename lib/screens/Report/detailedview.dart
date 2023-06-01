import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReportDetailed extends StatelessWidget {
  final Map<String, dynamic>? sessionData;
  final String sessionId; // Add this property

  const ReportDetailed({
    Key? key,
    required this.sessionData,
    required this.sessionId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (sessionData == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Joined Session Details'),
        ),
        body: Center(
          child: Text('Session data is unavailable.'),
        ),
      );
    }
    String reportTitle = sessionData!['Title'] as String? ?? 'No Title';
    String description =
        sessionData!['Description'] as String? ?? 'No Description';
    Timestamp? reportTimestamp = sessionData!['Report Date'] as Timestamp?;
    DateTime reportDate =
        reportTimestamp != null ? reportTimestamp.toDate() : DateTime.now();
    String reportStatus =
        sessionData!['Report Status'] as String? ?? 'No Title';

    return Scaffold(
      appBar: AppBar(
        title: Text('Joined Session Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              reportTitle,
              style: GoogleFonts.bebasNeue(
                fontSize: 35,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Description: $description',
              style: GoogleFonts.bebasNeue(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Date: $reportDate',
              style: GoogleFonts.bebasNeue(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Report Status: $reportStatus',
              style: GoogleFonts.bebasNeue(fontSize: 20),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
