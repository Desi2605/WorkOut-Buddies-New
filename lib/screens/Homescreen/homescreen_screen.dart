import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project1/screens/Report/createreport.dart';
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
              title: Text('Report'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReportCreate()),
                );
              },
            ),
          ],
        ),
      ),

//-------------------------------------------------------------------------//

      body: Column(children: [
        //Choose the best Workout For you
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Text("Workouts Avaliable in Uniten",
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
                workoutDescrip: 'LOCATED IN DEWAN SERI SARJANA',
                workoutDescrip1:
                    'Badminton is a racquet sport played using racquets to hit a shuttlecock across a net.   ',
              ),
              WorkoutTile(
                workoutImagePath: 'lib/images/img2.jpg',
                workoutName: 'JOGGING',
                workoutDescrip: 'AROUND THE CAMPUS',
                workoutDescrip1:
                    'There are spots where you can jog around the campus. The management has a walkway all around the campus.',
              ),
              WorkoutTile(
                workoutImagePath: 'lib/images/img3.jpg',
                workoutName: 'GYM',
                workoutDescrip: 'LOCATED IN DEWAN SERI SARJANA',
                workoutDescrip1:
                    'Treadmill,Weights and the avaliable items which will be in a gym is provided in the gym',
              ),
              WorkoutTile(
                workoutImagePath: 'lib/images/futsal.jpg',
                workoutName: 'FUTSAL',
                workoutDescrip: 'LOCATED IN SPORTS ARENA',
                workoutDescrip1:
                    'The court in sports arena is newly build. There is 2 courts provided. Its free for uniten students only',
              ),
              WorkoutTile(
                workoutImagePath: 'lib/images/volleyball.jpg',
                workoutName: 'VOLLEYBALL',
                workoutDescrip: 'LOCATED IN SPORTS ARENA',
                workoutDescrip1: 'One court is newly done in thee sports arena',
              ),
              WorkoutTile(
                workoutImagePath: 'lib/images/tennis.jpg',
                workoutName: 'TENNIS',
                workoutDescrip: 'LOCATED IN BEHIND STADIUM',
                workoutDescrip1:
                    'There is no booking needed. You can just go and start playing',
              ),
              WorkoutTile(
                workoutImagePath: 'lib/images/basketball.jpeg',
                workoutName: 'BASKETBALL',
                workoutDescrip: 'LOCATED IN SPORTS ARENA',
                workoutDescrip1:
                    '1 courts is there in sports arena. You have to make a booking. But the facility is free for students',
              ),
              WorkoutTile(
                workoutImagePath: 'lib/images/swimming.jpeg',
                workoutName: 'SWIMMING',
                workoutDescrip: 'LOCATED IN UNITEN SWIMMING POOL',
                workoutDescrip1:
                    'You need to wear proper swimming suit and bring a headcap for swimming',
              ),
              WorkoutTile(
                workoutImagePath: 'lib/images/football.jpeg',
                workoutName: 'FOOTBALL',
                workoutDescrip: 'LOCATED IN ILSAS',
                workoutDescrip1: 'Get a team and time to play',
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
//---------------------------------------------------------------------------//
