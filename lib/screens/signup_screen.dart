import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_project1/reusable_widgets/resusable_widgets.dart';
import 'package:test_project1/utils/colors_util.dart';

import 'homescreen_screen.dart';

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
  GlobalKey<FormFieldState> formsignup = GlobalKey();

  // Function to validate email using regular expressions
  bool validateEmail(String email) {
    // Regular expression pattern for email validation
    final pattern =
        r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$'; // change this later
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
          hexStringToColor("808080"),
          hexStringToColor("000000"),
          hexStringToColor("000000")
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
                  reusableTextFieild(
                    "Enter Firstname",
                    Icons.person_outlined,
                    false,
                    _firstnameTextController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextFieild("Enter Lastname", Icons.person_outlined,
                      false, _lastnameTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextFieild("Enter Username", Icons.person_outlined,
                      false, _userNameTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextFieild("Enter Email", Icons.mail_lock_outlined,
                      false, _emailTextController,
                      validator: validateEmail(_emailTextController.text)),
                  const SizedBox(
                    height: 20,
                  ),
                  reusableTextFieild("Enter Password", Icons.lock_outlined,
                      false, _passwordTextController),
                  const SizedBox(
                    height: 20,
                  ),
                  FirebaseButtons(context, "SIGN UP", () {
                    bool isformvalid = formsignup.currentState!.validate();
                    isformvalid
                        ? FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: _emailTextController.text,
                                password: _passwordTextController.text)
                            .then((value) {
                            FirebaseFirestore.instance
                                .collection("Users")
                                .doc(value.user!.uid)
                                .set({
                              "Firstname": _firstnameTextController.text,
                              "Lastname": _lastnameTextController.text,
                              "Username": _userNameTextController.text,
                              "Email": _emailTextController.text,
                              "Password": _passwordTextController.text
                            });
                            print("Account Has Been Created");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                          }).onError((error, stackTrace) {
                            print("Error ${error.toString()}");
                          })
                        : showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Error"),
                              content: Text(
                                  "Invalid email or password."), // edit this
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("OK"),
                                ),
                              ],
                            ),
                          );
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
