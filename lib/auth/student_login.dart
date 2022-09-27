import 'package:easy_school/admin/admin_home.dart';
import 'package:easy_school/admin/admin_tab_screen.dart';
import 'package:easy_school/auth/login.dart';
import 'package:easy_school/common_module/app_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../student/student_tab_screen.dart';
import '../teacher/teacher_tab_screen.dart';

class StudentLogin extends StatefulWidget {
  @override
  State<StudentLogin> createState() => _StudentLoginState();
}

class _StudentLoginState extends State<StudentLogin> {
  static String routeName = 'StudentLogin';
  TextEditingController email = TextEditingController();

  var pass = TextEditingController();

  bool _signInFetching = false;

  String? errorMessage;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 110, left: 15, right: 15),
            child: Card(
              child: Container(
                height: MediaQuery.of(context).size.height / 1.9,
                margin: EdgeInsets.all(10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Student Login ',
                        style: TextStyle(
                            color: AppColor.background,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                            fillColor: AppColor.white,
                            filled: true,
                            hintText: 'Enter Email'),
                        onSaved: (value) {
                          email.text = value!;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Please Enter Your Email");
                          }
                          // reg expression for email validation
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return ("Please Enter a valid email");
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: pass,
                        obscureText: true,
                        //  validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return ("Please Enter Your password");
                        //   }
                        //    return null;
                        // },
                        decoration: InputDecoration(
                            fillColor: AppColor.white,
                            filled: true,
                            hintText: 'Enter Password',
                            )
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _StudentLogin();
                        },
                        child: Text('Submit'),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Login as'),
                          TextButton(
                            child: Text(
                              'Teacher/ Admin',
                              style: TextStyle(
                                color: AppColor.background,
                                fontSize: 18,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()));
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }

  void selectStudentLogin() {}

  Future<void> _StudentLogin() async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      try {
        FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: email.text.trim(), password: pass.text.trim())
            .then((uid) => {
                  setState(() {
                    _signInFetching = false;
                  }),
                  Fluttertoast.showToast(msg: 'Sign In Successful'),
                  Navigator.popUntil(context, (route) => route.isFirst),
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StudentTabScreen()))
                });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        setState(() {
          _signInFetching = false;
        });
      }
    }
    setState(() {
      _signInFetching = false;
    });
  }
}
