import 'package:easy_school/admin/admin_student_chat.dart';
import 'package:easy_school/admin/admin_teacher_chat.dart';
import 'package:easy_school/admin/live_video.dart';
import 'package:easy_school/admin/student_details.dart';
import 'package:easy_school/common_module/app_color.dart';
import 'package:flutter/material.dart';

class StudentContent extends StatefulWidget {
  static String routeName = '/student-content';
  final String email;
  final String name;
  final String mobile;

  final String age;
  final String subject;
  final String batch;

  final String course;
  final String session;
  StudentContent(
      {Key? key,
      required this.email,
      required this.name,
      required this.mobile,
      required this.age,
      required this.subject,
      required this.batch,
      required this.course,
      required this.session})
      : super(key: key);

  @override
  State<StudentContent> createState() => _StudentContentState();
}

class _StudentContentState extends State<StudentContent> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Lato',
        primaryColor: AppColor.background,
        primarySwatch: Colors.pink,
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          floatingActionButton: Container(
            margin: EdgeInsets.only(top: 4),
            alignment: Alignment.topRight,
            child: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.close)),
          ),
          appBar: AppBar(
            backgroundColor: Colors.pink,
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: 'Chat',
                ),
                Tab(text: 'BioData'),
                Tab(text: 'Live'),
              ],
            ),

            // title: Text('Teacher Data'),
            centerTitle: true,
          ),
          body: TabBarView(
            children: [
              AdminStudentChat(
                email: widget.email,
              ),
              StudentDetails(
                email: widget.email,
                name: widget.name,
                age: widget.age,
                batch: widget.batch,
                mobile: widget.mobile,
                course: widget.course,
                subject: widget.subject,
                session: widget.session,
              ),
              // LiveVideo(),
              AdminStudentChat(
                email: widget.email,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
