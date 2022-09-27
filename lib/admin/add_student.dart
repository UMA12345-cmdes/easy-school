// ignore_for_file: prefer_const_constructors_in_immutables

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../common_module/app_color.dart';

class AddStudent extends StatefulWidget {
   static String routeName = '/add-student';
  AddStudent({Key? key}) : super(key: key);

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
 
  User? user = FirebaseAuth.instance.currentUser!;
  var name = TextEditingController();
  var email = TextEditingController();
  var pass = TextEditingController();
  var mobile = TextEditingController();
  var subject = TextEditingController();
  var course = TextEditingController();
  var age = TextEditingController();
  var batch = TextEditingController();
  var session = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  var errorMessage ='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: const EdgeInsets.only(top: 2),
        alignment: Alignment.topRight,
        child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.close)),
      ),
      backgroundColor: AppColor.background,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'Add Student ',
                style: TextStyle(fontSize: 22, color: AppColor.white),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                height: 1.3,
                width: 270,
                color: AppColor.white,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: name,
                decoration: InputDecoration(
                    hintText: 'Enter Name',
                    fillColor: AppColor.white,
                    filled: true),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: email,
                decoration: InputDecoration(
                    hintText: 'Enter Email',
                    fillColor: AppColor.white,
                    filled: true),
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
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: pass,
                obscureText: true,
                onSaved: (value) {
                  pass.text = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return ('Please enter Your Password');
                  }
                  if (value.length <= 6) {
                    return ('weak password');
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Enter password',
                  fillColor: AppColor.white,
                  filled: true,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: mobile,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ('Empty Mobile');
                  }
                  if (value.length < 10 || value.length > 13) {
                    return ('Enter Correct Mobile number');
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Enter Mobile No',
                    fillColor: AppColor.white,
                    filled: true),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return ('Please enter Your subject');
                  }
                  return null;
                },
                controller: subject,
                decoration: InputDecoration(
                    hintText: 'Enter Subject Name',
                    fillColor: AppColor.white,
                    filled: true),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return ('Please enter Your Session');
                  }
                  return null;
                },
                controller: session,
                decoration: InputDecoration(
                    hintText: 'Enter Session ',
                    fillColor: AppColor.white,
                    filled: true),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return ('Please enter Your course');
                  }
                  return null;
                },
                controller: course,
                decoration: InputDecoration(
                    hintText: 'Enter course',
                    fillColor: AppColor.white,
                    filled: true),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return ('Please enter Your age');
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                controller: age,
                decoration: InputDecoration(
                    hintText: 'Enter age',
                    fillColor: AppColor.white,
                    filled: true),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return ('Please enter Your batch');
                  }
                  return null;
                },
                controller: batch,
                decoration: InputDecoration(
                    hintText: 'Enter batch',
                    fillColor: AppColor.white,
                    filled: true),
              ),
              const SizedBox(
                height: 30,
              ),
              MaterialButton(
                  height: 47,
                  minWidth: 220,
                  elevation: 20,
                  color: AppColor.white,
                  onPressed: () {
                    _addStudent();
                    createAuth();
                  },
                  child: Text(
                    'Add Student',
                    style: TextStyle(fontSize: 22, color: AppColor.background),
                  ))
            ],
          ),
        ),
      )),
    );
  }

  void _addStudent() async {
    if (_formKey.currentState!.validate()) {
      var collection = FirebaseFirestore.instance
          .collection('student')
          .doc(email.text);
      try {
        collection
            .set({
              'chat': [],
              'name': name.text,
              'email': email.text,
              'password': pass.text,
              'mobile': mobile.text,
              'subject': subject.text,
              'course': course.text,
              'age': age.text,
              'batch': batch.text,
              'session': session.text
            })
            .then((value) => print("Student Added"))
            .catchError((error) => print("Failed to add user: $error"));
        setState(() {});
        name.clear();
        email.clear();
        pass.clear();
        mobile.clear();
        age.clear();
        batch.clear();
        course.clear();
        subject.clear();
        session.clear();

        Navigator.pop(context);
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          default:
            errorMessage = "An undefined Error happened.+$error";
        }
        Fluttertoast.showToast(msg: errorMessage);
      }
    }
  }

  void createAuth() async {
    String emailid = email.text.trim();
    String password = pass.text.trim();

    if (emailid.isNotEmpty || password.isNotEmpty) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: emailid, password: password);
        if (userCredential.user != null) {
          Navigator.pop(context);
        }
      } on FirebaseAuthException catch (ex) {
        log(ex.code.toString());
      }
    }
  }
}
