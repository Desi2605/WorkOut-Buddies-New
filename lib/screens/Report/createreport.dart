import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project1/screens/Report/createdreportview.dart';

import '../Homescreen/homescreen_screen.dart';

class ReportCreate extends StatefulWidget {
  const ReportCreate({Key? key}) : super(key: key);

  @override
  _ReportCreateState createState() => _ReportCreateState();
}

class _ReportCreateState extends State<ReportCreate> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _titleTextController = TextEditingController();
  TextEditingController _descriptionTextController = TextEditingController();

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
                title: Text('Create Reports'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ReportCreate()),
                  );
                }),
            ListTile(
                title: Text('View Reports'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ReportDetailPage()),
                  );
                }),
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
                  "CREATE REPORT",
                  style: GoogleFonts.bebasNeue(
                    fontSize: 50,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _titleTextController,
                decoration: InputDecoration(
                  labelText: 'Title of Report',
                  prefixIcon: Icon(Icons.person_outlined),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _descriptionTextController,
                decoration: InputDecoration(
                  labelText: 'Explanation',
                  prefixIcon: Icon(Icons.description_outlined),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  submitSession();
                },
                child: Text('Publish Session'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void submitSession() async {
    String title = _titleTextController.text;
    String description = _descriptionTextController.text;

    try {
      // Create a new session document in the "Reports" collection
      DocumentReference reportRef =
          await FirebaseFirestore.instance.collection("Reports").add({
        "Report Date": DateTime.now(),
        "Report Status": "Pending",
        "Title": title,
        "Description": description,
      });

      // Get the generated document ID
      String reportId = reportRef.id;

      // Get the currently logged-in user ID
      String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
      // Replace this with your actual logic to get the user ID

      // Store the report ID in the user's document under the "Report" field
      await FirebaseFirestore.instance.collection("Users").doc(userId).update({
        "Report": FieldValue.arrayUnion([reportId]),
      });

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Report Successfully Created'),
          content: Text('Once the report is reviewed, it will be updated'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to Create Report. Please try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
