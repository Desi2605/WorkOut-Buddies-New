import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_project1/reusable_widgets/resusable_widgets.dart';
import 'package:test_project1/utils/colors_util.dart';

import '../Homescreen/homescreen_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _firstnameTextController = TextEditingController();
  TextEditingController _lastnameTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  GlobalKey<FormState> formsignup =
      GlobalKey<FormState>(); // Used for email specification

  bool validateEmail(String email) {
    final pattern =
        r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+uniten\.edu\.my$'; // Email specification in Student.uniten.edu.my
    final regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up Here",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("#00008B"),
          hexStringToColor("#5D3FD3"),
          hexStringToColor("#FF5733"),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Form(
          key: formsignup,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 200, 20, 0),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField(
                    "Enter Firstname",
                    Icons.person_outlined,
                    false,
                    _firstnameTextController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter Lastname", Icons.person_outlined,
                      false, _lastnameTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter Username", Icons.person_outlined,
                      false, _userNameTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter Email", Icons.mail_lock_outlined,
                      false, _emailTextController,
                      validator: validateEmail(_emailTextController.text)),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter Password", Icons.lock_outlined,
                      false, _passwordTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  FirebaseButtons(context, "SIGN UP", () {
                    bool isFormValid = formsignup.currentState!.validate();
                    if (isFormValid) {
                      FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: _emailTextController.text,
                              password: _passwordTextController.text)
                          .then((value) {
                        String userId = value.user!.uid; // Get the user ID
                        FirebaseFirestore.instance
                            .collection("Users")
                            .doc(userId)
                            .set({
                          "UserId": userId, // Store the user ID
                          "Firstname": _firstnameTextController.text,
                          "Lastname": _lastnameTextController.text,
                          "Username": _userNameTextController.text,
                          "Email": _emailTextController.text,
                          "Password": _passwordTextController.text,
                          "CreatedSession": [],
                          "JoinedSessions": [],
                          "AccountStatus":
                              "Active", // Set the account status as "active"
                        }).then((_) {
                          print("Account Has Been Created");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        }).catchError((error) {
                          print("Error ${error.toString()}");
                        });
                      }).catchError((error) {
                        print("Error ${error.toString()}");
                      });
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Error"),
                          content: Text("Please use Uniten Student Email"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("OK"),
                            ),
                          ],
                        ),
                      );
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
