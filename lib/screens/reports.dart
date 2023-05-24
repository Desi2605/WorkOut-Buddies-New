import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_project1/reusable_widgets/resusable_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project1/screens/challenge_detail.dart';
import 'package:test_project1/screens/session_detail.dart';
import 'homescreen_screen.dart';

class SessionCreate extends StatefulWidget {
  const SessionCreate({Key? key}) : super(key: key);

  @override
  _SessionCreateState createState() => _SessionCreateState();
}

class _SessionCreateState extends State<SessionCreate> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _workoutTitleTextController = TextEditingController();
  TextEditingController _descriptionTextController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedStartTime;
  TimeOfDay? _selectedEndTime;
  TextEditingController _maximumTextController = TextEditingController();
  String? _selectedWorkoutType;

  List<String> workoutTypes = [
    'Badminton',
    'Gym',
    'Futsal',
  ];

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
              title: Text('View Workout Sessions'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SessionDetailPage()),
                );
              },
            ),
            ListTile(
              title: Text('View Workout Challenges'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChallengeDetailPage()),
                );
              },
            ),
            ListTile(
              title: Text('Rewards'),
              onTap: () {
                
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  "Create Workout Sessions",
                  style: GoogleFonts.bebasNeue(
                    fontSize: 50,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              reusableTextField(
                "Title of Session",
                Icons.person_outlined,
                false,
                _workoutTitleTextController,
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  filled: true,
                  labelText: 'Select Workout Type',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                value: _selectedWorkoutType,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedWorkoutType = newValue;
                  });
                },
                items: workoutTypes.map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2024),
                  ).then((value) {
                    setState(() {
                      _selectedDate = value;
                    });
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[800],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Text(
                          _selectedDate != null
                              ? _selectedDate!.toString().split(' ')[0]
                              : 'Select Date',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  ).then((value) {
                    setState(() {
                      _selectedStartTime = value;
                    });
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[800],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Text(
                          _selectedStartTime != null
                              ? _selectedStartTime!.format(context)
                              : 'Select Start Time',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  ).then((value) {
                    setState(() {
                      _selectedEndTime = value;
                    });
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[800],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Text(
                          _selectedEndTime != null
                              ? _selectedEndTime!.format(context)
                              : 'Select End Time',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              reusableTextField(
                "Maximum No. of Participants",
                Icons.person_outlined,
                false,
                _maximumTextController,
              ),
              SizedBox(height: 20),
              reusableTextField(
                "Description",
                Icons.description_outlined,
                false,
                _descriptionTextController,
              ),
              SizedBox(height: 20),
              FirebaseButtons(context, "Publish Session", () async {
                // Create a new session document in the "WorkoutSession" collection
                DocumentReference sessionRef = await FirebaseFirestore.instance
                    .collection("WorkoutSession")
                    .add({
                  "SessionId": UniqueKey().toString(),
                  "SessionStatus": "active",
                  "Title": _workoutTitleTextController.text,
                  "Type": _selectedWorkoutType,
                  "Description": _descriptionTextController.text,
                  "Date": _selectedDate != null
                      ? _selectedDate!.toLocal().toString()
                      : null,
                  "Start Time": _selectedStartTime != null
                      ? _selectedStartTime!.format(context)
                      : null,
                  "End Time": _selectedEndTime != null
                      ? _selectedEndTime!.format(context)
                      : null,
                  "Maximum Participants":
                      int.parse(_maximumTextController.text),
                });

                // Get the current user's document reference
                final user = FirebaseAuth.instance.currentUser!;
                DocumentReference userRef = FirebaseFirestore.instance
                    .collection("Users")
                    .doc(user.uid);

                // Update the user's document to store the new session ID
                // Add the session ID to the existing array or create a new array if it doesn't exist
                await userRef.update({
                  "CreatedSession": FieldValue.arrayUnion([sessionRef.id]),
                });

                Navigator.pop(context);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
