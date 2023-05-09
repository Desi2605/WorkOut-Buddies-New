import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project1/screens/signin_screen.dart';
import 'package:test_project1/utils/workout_tile.dart';
import 'package:test_project1/utils/workout_type.dart';

class SessionScreen extends StatefulWidget {
  const SessionScreen({Key? key}) : super(key: key);

  @override
  _SessionScreenState createState() => _SessionScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // user tap on type

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Icon(Icons.menu),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Icon(Icons.person),
          )
        ],
      ),
      body: Column(children: [
        //Choose the best Workout For you
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Text("Choose the WorkOut that you prefer",
              style: GoogleFonts.bebasNeue(
                fontSize: 45,
              )),
        ),
        SizedBox(height: 25),

        //Search Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Find your workout here...',
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade600),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade600),
              ),
            ),
          ),
        ),

        SizedBox(height: 25),
        // List of Workouts

        Expanded(
            child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            WorkoutTile(
              workoutImagePath: 'lib/images/img1.jpg',
              workoutName: 'BADMINTON',
              workoutDescrip: 'LOCATED IN DSS',
              workoutDescrip1: 'Test',
            ),
            WorkoutTile(
              workoutImagePath: 'lib/images/img2.jpg',
              workoutName: 'JOGGIN',
              workoutDescrip: 'AROUND THE CAMPUS',
              workoutDescrip1: 'Test',
            ),
            WorkoutTile(
              workoutImagePath: 'lib/images/img3.jpg',
              workoutName: 'GYM',
              workoutDescrip: 'LOCATED IN DSS',
              workoutDescrip1: 'Test',
            ),
            WorkoutTile(
              workoutImagePath: 'lib/images/img3.jpg',
              workoutName: 'FUTSAL',
              workoutDescrip: 'LOCATED IN SPORTS ARENA',
              workoutDescrip1: 'Test',
            ),
          ],
        )),
      ]),
    );
  }
}
