import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project1/screens/challenges_view.dart';
import 'package:test_project1/screens/full_session_detail.dart';
import 'package:test_project1/screens/session_create.dart';
import 'package:test_project1/screens/session_detail.dart';
import 'package:test_project1/screens/signin_screen.dart';
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
                  MaterialPageRoute(builder: (context) => challenges()),
                );
              },
            ),
            //Rewards
            ListTile(
              title: Text('Rewards'),
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
              style: GoogleFonts.bebasNeue(
                fontSize: 45,
              )),
        ),
        SizedBox(height: 25),

//------------------------------------------------------------------------//

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
          ),
        ),
      ]),
    );
  }
}
//---------------------------------------------------------------------------//
