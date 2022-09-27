import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_school/common_module/app_color.dart';
import 'package:flutter/material.dart';

class TeacherDetails extends StatefulWidget {
  static String routeName = '/teacher-details';
  final String email;
  final String name;
  final String mobile;
  final String age;
  final String subject;
  final String qualification;
  final String experince;
  TeacherDetails(
      {Key? key,
      required this.email,
      required this.name,
      required this.mobile,
      required this.age,
      required this.subject,
      required this.qualification,
      required this.experince})
      : super(key: key);

  @override
  State<TeacherDetails> createState() => _TeacherDetailsState();
}

class _TeacherDetailsState extends State<TeacherDetails> {
  @override
  void initState() {
    displayTeacher();
    // TODO: implement initState
    super.initState();
  }

  void displayTeacher() async {
    FirebaseFirestore.instance.collection('teacher').doc(widget.email).get();
    //     .then((value) {
    //   Map<String, dynamic>? data = value.data();
    //   setState(() {
    //     element = data!['comments'] as List;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(child: SingleChildScrollView(child: StreamBuilder(
        builder: (context, snapshot) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 7, vertical: 10),
            child: ListBody(
              children: [
                SizedBox(
                  height: 10,
                ),
                Center(
                    child: Text(
                  'Teacher Details',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                )),
                ListTile(
                  title: Text('Name '),
                  trailing: Text(widget.name),
                ),
                Divider(
                  thickness: 1.3,
                  color: AppColor.white,
                ),
                ListTile(
                  title: Text('Email '),
                  trailing: Text(widget.email),
                ),
                Divider(
                  thickness: 1.3,
                  color: AppColor.white,
                ),
                ListTile(
                  title: Text('Age '),
                  trailing: Text(widget.age),
                ),
                Divider(
                  thickness: 1.3,
                  color: AppColor.white,
                ),
                ListTile(
                  title: Text('Experiance '),
                  trailing: Text(widget.experince),
                ),
                Divider(
                  thickness: 1.3,
                  color: AppColor.white,
                ),
                ListTile(
                  title: Text('Mobile Number '),
                  trailing: Text(widget.mobile),
                ),
                Divider(
                  thickness: 1.3,
                  color: AppColor.white,
                ),
                ListTile(
                  title: Text('Educations Qualification '),
                  trailing: Text(widget.qualification),
                ),
                Divider(
                  thickness: 1.3,
                  color: AppColor.white,
                ),
                ListTile(
                  title: Text('Subject '),
                  trailing: Text(widget.subject),
                ),
                Divider(
                  thickness: 1.3,
                  color: AppColor.white,
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Note :-',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                Text(
                    'The traditional idea of classroom as an instructor focused learning space has changed. '
                    'The growth of computer-based instruction, video projection, and other telecommunication '
                    'requirements changed the nature of educational facilities.'),
              ],
            ),
          );
        },
      ))),
    );
  }
}
