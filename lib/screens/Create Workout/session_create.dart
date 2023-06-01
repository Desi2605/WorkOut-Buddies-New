import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_project1/reusable_widgets/resusable_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project1/screens/Report/createreport.dart';
import 'package:test_project1/screens/View%20Workouts/session_detail.dart';
import 'package:test_project1/screens/Workout%20Challeng/challenge_detail.dart';
import '../Auth/signin_screen.dart';
import '../Created Session/created_session.dart';
import '../Homescreen/homescreen_screen.dart';
import '../Joined Session/joined_session.dart';

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
  String? _selectedMinTime;
  String? _userFirstName;

  List<String> workoutTypes = [
    'Badminton',
    'Gym',
    'Futsal',
    'Jogging',
    'Volleyball',
    'Tennis',
    'Basketball',
    'Swimming',
    'Football'
  ];

  List<String> Mintime = [
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12'
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
          IconButton(
            icon: Icon(Icons.logout_outlined),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => SignInScreen()),
                (route) => false,
              );
            },
          ),
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
              title: Text('Workout Sessions'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SessionDetailPage()),
                );
              },
            ),
            ListTile(
              title: Text('Joined Sessions'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JoinedDetailPage()),
                );
              },
            ),
            ListTile(
              title: Text('Created Sessions'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreatedDetailPage()),
                );
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
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  filled: true,
                  labelText: 'Select Max No Participants',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                value: _selectedMinTime,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedMinTime = newValue;
                    _maximumTextController.text = newValue ?? '';
                  });
                },
                items: Mintime.map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
              ),
              SizedBox(height: 20),
              reusableTextField(
                "Description(Communication Method)",
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
                  "SessionStatus": "Active",
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
                      int.tryParse(_maximumTextController.text) ?? 0,
                  "participants": [
                    _userFirstName ?? ''
                  ] // Add owner's first name to participants
                });

                // Get the current user's document reference
                final user = FirebaseAuth.instance.currentUser!;
                DocumentReference userRef = FirebaseFirestore.instance
                    .collection("Users")
                    .doc(user.uid);

                // Fetch the first name of the logged-in user
                DocumentSnapshot userSnapshot = await userRef.get();
                String? firstName =
                    (userSnapshot.data() as Map<String, dynamic>)['Firstname'];

                // Update the user's document to store the new session ID
                // Add the session ID to the existing array or create a new array if it doesn't exist
                await userRef.update({
                  "CreatedSession": FieldValue.arrayUnion([sessionRef.id]),
                });

                Navigator.pop(context);
              })
            ],
          ),
        ),
      ),
    );
  }
}
