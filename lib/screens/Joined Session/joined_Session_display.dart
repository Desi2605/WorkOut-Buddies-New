import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JoinSessionDetail extends StatefulWidget {
  final Map<String, dynamic>? sessionData;
  final String sessionId; // Add this property

  const JoinSessionDetail({
    Key? key,
    required this.sessionData,
    required this.sessionId,
  }) : super(key: key);

  @override
  _JoinSessionDetailState createState() => _JoinSessionDetailState();
}

class _JoinSessionDetailState extends State<JoinSessionDetail> {
  bool _isExpandedParticipants = false;
  bool _isExpandedDescription = false;
  bool _isExpandedMaxPeople = false;
  bool _isExpandedTime = false;
  bool _isExpandedDate = false;

  @override
  Widget build(BuildContext context) {
    if (widget.sessionData == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Joined Session Details'),
        ),
        body: Center(
          child: Text('Session data is unavailable.'),
        ),
      );
    }

    String sessionTitle = widget.sessionData!['Title'] as String? ?? 'No Title';
    String sessionType = widget.sessionData!['Type'] as String? ?? 'No Type';
    String sessionDate = widget.sessionData!['Date'] as String? ?? 'No Date';
    String sessionStartTime =
        widget.sessionData!['Start Time'] as String? ?? 'No Start Time';
    String sessionEndTime =
        widget.sessionData!['End Time'] as String? ?? 'No End Time';
    String maxPeople =
        widget.sessionData!['Maximum Participants']?.toString() ??
            'No Max People';
    String description =
        widget.sessionData!['Description'] as String? ?? 'No Description';

    String participants = '';

    if (widget.sessionData!['participants'] != null) {
      final participantList =
          widget.sessionData!['participants'] as List<dynamic>;
      participants = participantList.join(', ');
    } else {
      participants = 'No Participants';
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Joined Session Detail'),
          actions: [],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
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
                  'Workout Type: $sessionType',
                  style: GoogleFonts.bebasNeue(fontSize: 20),
                ),
                SizedBox(height: 20),
                ExpansionPanelList(
                  elevation: 1,
                  expandedHeaderPadding: EdgeInsets.all(0),
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      if (index == 0) {
                        _isExpandedDate = !isExpanded;
                      } else if (index == 1) {
                        _isExpandedTime = !isExpanded;
                      } else if (index == 2) {
                        _isExpandedMaxPeople = !isExpanded;
                      } else if (index == 3) {
                        _isExpandedDescription = !isExpanded;
                      } else if (index == 4) {
                        _isExpandedParticipants = !isExpanded;
                      }
                    });
                  },
                  children: [
                    ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Text(
                            'Date',
                            style: GoogleFonts.bebasNeue(fontSize: 20),
                          ),
                        );
                      },
                      body: ListTile(
                        title: Text(
                          'Date: $sessionDate',
                          style: GoogleFonts.bebasNeue(fontSize: 16),
                        ),
                      ),
                      isExpanded: _isExpandedDate,
                    ),
                    ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Text(
                            'Time',
                            style: GoogleFonts.bebasNeue(fontSize: 20),
                          ),
                        );
                      },
                      body: Column(
                        children: [
                          ListTile(
                            title: Text(
                              'Start Time: $sessionStartTime',
                              style: GoogleFonts.bebasNeue(fontSize: 16),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              'End Time: $sessionEndTime',
                              style: GoogleFonts.bebasNeue(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      isExpanded: _isExpandedTime,
                    ),
                    ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Text(
                            'Max People',
                            style: GoogleFonts.bebasNeue(fontSize: 20),
                          ),
                        );
                      },
                      body: ListTile(
                        title: Text(
                          maxPeople,
                          style: GoogleFonts.bebasNeue(fontSize: 16),
                        ),
                      ),
                      isExpanded: _isExpandedMaxPeople,
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
                          description,
                          style: GoogleFonts.bebasNeue(fontSize: 16),
                        ),
                      ),
                      isExpanded: _isExpandedDescription,
                    ),
                    ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Text(
                            'Participants',
                            style: GoogleFonts.bebasNeue(fontSize: 20),
                          ),
                        );
                      },
                      body: ListTile(
                        title: Text(
                          participants,
                          style: GoogleFonts.bebasNeue(fontSize: 16),
                        ),
                      ),
                      isExpanded: _isExpandedParticipants,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
