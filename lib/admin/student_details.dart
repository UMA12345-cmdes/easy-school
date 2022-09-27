import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_school/common_module/app_color.dart';
import 'package:flutter/material.dart';

class StudentDetails extends StatefulWidget {
  static String routeName = 'student-details';
  final String email;
  final String name;
  final String mobile;

  final String age;
  final String subject;
  final String course;

  final String session;
  final String batch;
  StudentDetails(
      {Key? key,
      required this.email,
      required this.name,
      required this.mobile,
      required this.age,
      required this.subject,
      required this.course,
      required this.session,
      required this.batch})
      : super(key: key);

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
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
      // floatingActionButton: Container(
      //   margin:  EdgeInsets.only(top: 2),
      //   alignment: Alignment.topRight,
      //   child: FloatingActionButton(
      //       onPressed: () {
      //         Navigator.of(context).pop();
      //       },
      //       child:  Icon(Icons.close)),
      // ),
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
                  'Student Details',
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
                  title: Text('Batch '),
                  trailing: Text(widget.batch),
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
                  title: Text('Course '),
                  trailing: Text(widget.course),
                ),
                Divider(
                  thickness: 1.3,
                  color: AppColor.white,
                ),
                ListTile(
                  title: Text('session '),
                  trailing: Text(widget.session),
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
