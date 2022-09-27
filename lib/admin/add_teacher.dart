import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../common_module/app_color.dart';

class AddTeacher extends StatefulWidget {
  static String routeName = '/add-teacher';
  const AddTeacher({Key? key}) : super(key: key);

  @override
  State<AddTeacher> createState() => _AddTeacherState();
}

class _AddTeacherState extends State<AddTeacher> {
  User? user = FirebaseAuth.instance.currentUser!;
  var name = TextEditingController();
  var email = TextEditingController();
  var pass = TextEditingController();
  var mobile = TextEditingController();
  var subject = TextEditingController();
  var qualification = TextEditingController();
  var age = TextEditingController();
  var experince = TextEditingController();
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
                'Add Teacher',
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
                    hintText: 'Subject Name',
                    fillColor: AppColor.white,
                    filled: true),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return ('Please enter Your Qualification');
                  }
                  return null;
                },
                controller: qualification,
                decoration: InputDecoration(
                    hintText: 'Enter Qualification',
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
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return ('Please enter Your Experince');
                  }
                  return null;
                },
                controller: experince,
                decoration: InputDecoration(
                    hintText: 'Enter Experince',
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
                    _addTeacher();
                    createAuth();
                  },
                  child: Text(
                    'Add Teacher',
                    style: TextStyle(fontSize: 22, color: AppColor.background),
                  ))
            ],
          ),
        ),
      )),
    );
  }

  void _addTeacher() async {
    if (_formKey.currentState!.validate()) {
      var collection = FirebaseFirestore.instance
          .collection('teacher')
          .doc(email.text);
      try {
        collection
            .set({
              'admin': [],
              'name': name.text,
              'email': email.text,
              'password': pass.text,
              'mobile': mobile.text,
              'subject': subject.text,
              'qualification': qualification.text,
              'age': age.text,
              'experince': experince.text,
            })
            .then((value) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error"));
        setState(() {});
        name.clear();
        email.clear();
        pass.clear();
        mobile.clear();
        age.clear();
        experince.clear();
        qualification.clear();
        subject.clear();

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
