import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project1/screens/Workout%20Challeng/challenge_detail.dart';
import 'package:test_project1/screens/View%20Workouts/full_session_detail.dart';
import 'package:test_project1/screens/Create%20Workout/session_create.dart';
import 'package:test_project1/screens/View%20Workouts/session_detail.dart';
import 'package:test_project1/screens/Auth/signin_screen.dart';
import 'package:test_project1/utils/workout_tile.dart';
import 'package:test_project1/utils/workout_type.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // user tap on type

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

      //------------------------------------------------------------------//
      drawer: Drawer(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, //Need to Edit this to make it Nice
          children: [
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

            // View Challenges
            ListTile(
              title: Text('Workout Challenges'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChallengeDetailPage()),
                );
              },
            ),
            //Rewards
            ListTile(
              title: Text('Contact Us'),
              onTap: () {},
            ),
          ],
        ),
      ),

//-------------------------------------------------------------------------//

      body: Column(children: [
        //Choose the best Workout For you
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Text("Choose the WorkOut that you prefer",
              style: GoogleFonts.bebasNeue(fontSize: 45, color: Colors.white)),
        ),
        SizedBox(height: 25),

//------------------------------------------------------------------------//

//----------------------------------------------------------------------//

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
                workoutDescrip1: 'Badminton is ',
              ),
              WorkoutTile(
                workoutImagePath: 'lib/images/img2.jpg',
                workoutName: 'JOGGING',
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
                workoutImagePath: 'lib/images/futsal.jpg',
                workoutName: 'FUTSAL',
                workoutDescrip: 'LOCATED IN SPORTS ARENA',
                workoutDescrip1: 'Test',
              ),
              WorkoutTile(
                workoutImagePath: 'lib/images/volleyball.jpg',
                workoutName: 'VOLLEYBALL',
                workoutDescrip: 'LOCATED IN SPORTS ARENA',
                workoutDescrip1: 'Test',
              ),
              WorkoutTile(
                workoutImagePath: 'lib/images/tennis.jpg',
                workoutName: 'TENNIS',
                workoutDescrip: 'LOCATED IN SPORTS ARENA',
                workoutDescrip1: 'Test',
              ),
              WorkoutTile(
                workoutImagePath: 'lib/images/basketball.jpeg',
                workoutName: 'BASKETBALL',
                workoutDescrip: 'LOCATED IN SPORTS ARENA',
                workoutDescrip1: 'Test',
              ),
              WorkoutTile(
                workoutImagePath: 'lib/images/swimming.jpeg',
                workoutName: 'SWIMMING',
                workoutDescrip: 'LOCATED IN SPORTS ARENA',
                workoutDescrip1: 'Test',
              ),
              WorkoutTile(
                workoutImagePath: 'lib/images/football.jpeg',
                workoutName: 'FOOTBALL',
                workoutDescrip: 'LOCATED IN SPORTS ARENA',
                workoutDescrip1: 'Test',
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
//---------------------------------------------------------------------------//
