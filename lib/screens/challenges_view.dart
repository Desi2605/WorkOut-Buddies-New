import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project1/screens/homescreen_screen.dart';

class challenges extends StatefulWidget {
  const challenges({Key? key}) : super(key: key);

  @override
  _challengeScreenState createState() => _challengeScreenState();
}

class _challengeScreenState extends State<challenges> {
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
          Padding(
            padding: const EdgeInsets.only(right: 20.5),
            child: Icon(Icons.logout_outlined),
          )
        ],
      ),

      //------------------------------------------------------------------//
      drawer: Drawer(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, //Need to Edit this to make it Nice
          children: [
            ListTile(
              title: Text('HOMEPAGE'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
            // Workout Sessions
            ListTile(
              title: Text('WORKOUT CHALLENGES'),
              onTap: () {},
            ),

            // View Challenges
            ListTile(
              title: Text('CHALLENGES JOINED'),
              onTap: () {},
            ),
            //Rewards
          ],
        ),
      ),

//-------------------------------------------------------------------------//

      body: Column(children: [
        //Choose the best Workout For you
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Text("Wanna Join the Challenge",
              textAlign: TextAlign.center,
              style: GoogleFonts.bebasNeue(
                fontSize: 40,
              )),
        ),
        SizedBox(height: 25),
      ]),
    );
  }
}
//---------------------------------------------------------------------------//