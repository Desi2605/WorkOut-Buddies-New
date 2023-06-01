import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class EditPage extends StatefulWidget {
  final Map<String, dynamic>? sessionData;
  final String sessionId;

  const EditPage({
    Key? key,
    required this.sessionData,
    required this.sessionId,
  }) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _startTimeController = TextEditingController();
  TextEditingController _endTimeController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _participantsController = TextEditingController();

  List<String> workoutTypeOptions = [
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

  List<String> maxParticipantsOptions = [
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

  String? selectedWorkoutType;
  String? selectedMaxParticipants;
  String? selectedDate;

  @override
  void initState() {
    super.initState();

    // Set the initial values of the form fields
    _titleController.text = widget.sessionData!['Title'] ?? '';
    _startTimeController.text = widget.sessionData!['Start Time'] ?? '';
    _endTimeController.text = widget.sessionData!['End Time'] ?? '';
    _descriptionController.text = widget.sessionData!['Description'] ?? '';
    _participantsController.text = widget.sessionData!['Participants'] ?? '';

    selectedWorkoutType = widget.sessionData!['Type'] ?? workoutTypeOptions[0];
    selectedMaxParticipants =
        widget.sessionData!['Maximum Participants']?.toString() ??
            maxParticipantsOptions[0];
    selectedDate = widget.sessionData!['Date'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Session'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedWorkoutType,
                decoration: InputDecoration(
                  labelText: 'Workout Type',
                ),
                items: workoutTypeOptions.map((String workoutType) {
                  return DropdownMenuItem<String>(
                    value: workoutType,
                    child: Text(workoutType),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedWorkoutType = value;
                  });
                },
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedMaxParticipants,
                decoration: InputDecoration(
                  labelText: 'Maximum Participants',
                ),
                items: maxParticipantsOptions.map((String maxParticipants) {
                  return DropdownMenuItem<String>(
                    value: maxParticipants,
                    child: Text(maxParticipants),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedMaxParticipants = value;
                  });
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _startTimeController,
                decoration: InputDecoration(
                  labelText: 'Start Time',
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter the start time';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _endTimeController,
                decoration: InputDecoration(
                  labelText: 'End Time',
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter the end time';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _participantsController,
                decoration: InputDecoration(
                  labelText: 'Participants',
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter participants';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    updateSession();
                  }
                },
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateSession() async {
    final title = _titleController.text;
    final startTime = _startTimeController.text;
    final endTime = _endTimeController.text;
    final description = _descriptionController.text;
    final participants = _participantsController.text;

    try {
      await FirebaseFirestore.instance
          .collection('sessions')
          .doc(widget.sessionId)
          .update({
        'Title': title,
        'Type': selectedWorkoutType,
        'Start Time': startTime,
        'End Time': endTime,
        'Description': description,
        'Participants': participants,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Session updated successfully')),
      );

      Navigator.pop(context); // Return to the previous screen
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update session')),
      );
    }
  }
}
