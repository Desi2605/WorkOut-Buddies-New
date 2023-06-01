import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChallengeDetail extends StatefulWidget {
  final Map<String, dynamic>? sessionData;

  const ChallengeDetail({Key? key, required this.sessionData})
      : super(key: key);

  @override
  _ChallengeDetailState createState() => _ChallengeDetailState();
}

class _ChallengeDetailState extends State<ChallengeDetail> {
  String firstName = '';
  bool _isExpandedChallengeType = false;
  bool _isExpandedStartDate = false;
  bool _isExpandedEndDate = false;
  bool _isExpandedDescription = false;

  @override
  void initState() {
    super.initState();
    fetchUserFirstName();
  }

  Future<void> fetchUserFirstName() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;

      if (user != null) {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .get();

        if (snapshot.exists) {
          final userData = snapshot.data() as Map<String, dynamic>;
          setState(() {
            firstName = userData['Firstname'] as String? ?? '';
          });
        } else {
          print('User document does not exist');
        }
      } else {
        print('User not logged in');
      }
    } catch (error) {
      print('Error retrieving user document: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.sessionData == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Full Challenge Details'),
        ),
        body: Center(
          child: Text('No Challenges Listed'),
        ),
      );
    }

    String challengeTitle =
        widget.sessionData!['title'] as String? ?? 'No Title';
    String challengeType = widget.sessionData!['type'] as String? ?? 'No Type';
    Timestamp? challengeStartDate =
        widget.sessionData!['startDate'] as Timestamp?;
    Timestamp? challengeEndDate = widget.sessionData!['endDate'] as Timestamp?;
    String description =
        widget.sessionData!['description'] as String? ?? 'No Description';

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
            Center(
              child: Text(
                challengeTitle,
                style: GoogleFonts.bebasNeue(
                  fontSize: 35,
                ),
              ),
            ),
            SizedBox(height: 25),
            ExpansionPanelList(
              elevation: 1,
              expandedHeaderPadding: EdgeInsets.all(0),
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  if (index == 0) {
                    _isExpandedChallengeType = !isExpanded;
                  } else if (index == 1) {
                    _isExpandedStartDate = !isExpanded;
                  } else if (index == 2) {
                    _isExpandedEndDate = !isExpanded;
                  } else if (index == 3) {
                    _isExpandedDescription = !isExpanded;
                  }
                });
              },
              children: [
                ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text(
                        'Challenge Type',
                        style: GoogleFonts.bebasNeue(fontSize: 20),
                      ),
                    );
                  },
                  body: ListTile(
                    title: Text(
                      'Type: $challengeType',
                      style: GoogleFonts.bebasNeue(fontSize: 16),
                    ),
                  ),
                  isExpanded: _isExpandedChallengeType,
                ),
                ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text(
                        'Start Date',
                        style: GoogleFonts.bebasNeue(fontSize: 20),
                      ),
                    );
                  },
                  body: ListTile(
                    title: Text(
                      'Start Date: $formattedStartDate',
                      style: GoogleFonts.bebasNeue(fontSize: 16),
                    ),
                  ),
                  isExpanded: _isExpandedStartDate,
                ),
                ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text(
                        'End Date',
                        style: GoogleFonts.bebasNeue(fontSize: 20),
                      ),
                    );
                  },
                  body: ListTile(
                    title: Text(
                      'End Date: $formattedEndDate',
                      style: GoogleFonts.bebasNeue(fontSize: 16),
                    ),
                  ),
                  isExpanded: _isExpandedEndDate,
                ),
                ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text(
                        'Description',
                        style: GoogleFonts.bebasNeue(fontSize: 20),
                      ),
                    );
                  },
                  body: ListTile(
                    title: Text(
                      'Description: $description',
                      style: GoogleFonts.bebasNeue(fontSize: 16),
                    ),
                  ),
                  isExpanded: _isExpandedDescription,
                ),
              ],
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                joinSession();
              },
              child: Text('Join Session'),
            ),
          ],
        ),
      ),
    );
  }

  void joinSession() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;

      if (user != null) {
        String email = user.email ?? '';

        if (email.isNotEmpty) {
          QuerySnapshot sessionSnapshot = await FirebaseFirestore.instance
              .collection('WorkoutChallenges')
              .where('Challengeid',
                  isEqualTo: widget.sessionData!['Challengeid'])
              .limit(1)
              .get();

          if (sessionSnapshot.docs.isNotEmpty) {
            DocumentReference sessionRef = sessionSnapshot.docs[0].reference;

            await sessionRef.update({
              'participants': FieldValue.arrayUnion([email])
            });

            await FirebaseFirestore.instance
                .collection('Users')
                .doc(user.uid)
                .update({
              'JoinedChallenges': FieldValue.arrayUnion([sessionRef.id])
            });

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Successfully joined the session.'),
              ),
            );
          } else {
            print('Session document not found');
          }
        } else {
          print('User does not have a valid email');
        }
      } else {
        print('User not logged in');
      }
    } catch (error) {
      print('Error joining session: $error');
    }
  }
}
