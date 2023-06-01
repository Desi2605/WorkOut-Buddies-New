import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_project1/reusable_widgets/resusable_widgets.dart';
import 'package:test_project1/utils/colors_util.dart';

import '../Homescreen/homescreen_screen.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController _emailTextController = TextEditingController();

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Success'),
        content: Text('Check your registered email'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(errorMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _resetPassword() {
    String email = _emailTextController.text;

    FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
      _showSuccessDialog();
      Navigator.of(context).pop();
    }).catchError((error) {
      _showErrorDialog(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Reset Password Here",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor("#00008B"),
              hexStringToColor("#5D3FD3"),
              hexStringToColor("#FF5733"),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomLeft,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(30, 200, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                  "Enter Email",
                  Icons.mail_lock_outlined,
                  false,
                  _emailTextController,
                ),
                const SizedBox(
                  height: 20,
                ),
                FirebaseButtons(
                  context,
                  "Reset Password",
                  () {
                    _resetPassword();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
