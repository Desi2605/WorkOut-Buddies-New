import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_project1/reusable_widgets/resusable_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
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
  TextEditingController _minimumTextController = TextEditingController();
  TextEditingController _maximumTextController = TextEditingController();
  String? _selectedWorkoutType;

  List<String> workoutTypes = ['Badminton', 'Gym', 'Futsal', 'Running'];

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

      //-------------------------------------------------------------------//
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
              onTap: () {},
            ),
            ListTile(
              title: Text('Rewards'),
              onTap: () {},
            ),
          ],
        ),
      ),

      //---------------------------------------------------------------------//

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

              //----------------------------------------------------------------------//
              SizedBox(height: 20),
              reusableTextField(
                "Title of Session",
                Icons.person_outlined,
                false,
                _workoutTitleTextController,
              ),

              //---------------------------------------------------------------------//

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

              //-------------------------------------------------------------------//

              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  _selectDate(context); // Call the date picker
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[800],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _selectedDate == null
                              ? 'Select Date'
                              : 'Date: ${_selectedDate!.toLocal()}'
                                  .split(' ')[0],
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(
                          Icons.calendar_today,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //--------------------------------------------------------------------//

              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  _selectStartTime(context); // Call the start time picker
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[800],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _selectedStartTime == null
                              ? 'Select Start Time'
                              : 'Start Time: ${_selectedStartTime!.format(context)}',
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(
                          Icons.access_time,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),
//----------------------------------------------------------------------------------//
              GestureDetector(
                onTap: () {
                  _selectEndTime(context); // Call the end time picker
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[800],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _selectedEndTime == null
                              ? 'Select End Time'
                              : 'End Time: ${_selectedEndTime!.format(context)}',
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(
                          Icons.access_time,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              //--------------------------------------------------------------------//

              SizedBox(height: 20),
              reusableTextField(
                "Enter Minimum Number",
                Icons.mail_lock_outlined,
                false,
                _minimumTextController,
              ),

              //-----------------------------------------------------------------//

              SizedBox(height: 20),
              reusableTextField(
                "Enter Maximum Number",
                Icons.mail_lock_outlined,
                false,
                _maximumTextController,
              ),

              //---------------------------------------------------------------------//
              SizedBox(height: 20),
              reusableTextField(
                "Session Description",
                Icons.mail_lock_outlined,
                false,
                _descriptionTextController,
              ),
              //---------------------------------------------------------------------//

              SizedBox(height: 20),
              FirebaseButtons(context, "Publish Session", () {
                FirebaseFirestore.instance.collection("WorkoutSession").add({
                  "SessionId": UniqueKey().toString(),
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
                  "Min ppl": _minimumTextController.text,
                  "Max ppl": _maximumTextController.text,
                }).then((value) {
                  print("Session has been created and posted");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SessionDetailPage(),
                    ),
                  );
                }).catchError((error) {
                  print("Error creating session: $error");
                });
              }),
            ],
          ),
        ),
      ),
    );
  }
//----------------------------------------------------------------------------//

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

//--------------------------------------------------------------------------//
  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedStartTime) {
      setState(() {
        _selectedStartTime = picked;
      });
    }
  }
//------------------------------------------------------------------------//

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedEndTime) {
      setState(() {
        _selectedEndTime = picked;
      });
    }
  }
}
