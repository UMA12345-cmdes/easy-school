import 'package:easy_school/admin/admin_teacher_chat.dart';
import 'package:easy_school/admin/live_video.dart';
import 'package:easy_school/common_module/app_color.dart';
import 'package:flutter/material.dart';

import 'teacher_details.dart';

class TeacherContent extends StatefulWidget {
  static String routeName = '/teacher-content';
  final String email;
  final String name;
  final String mobile;
  final String age;
  final String subject;
  final String qualification;
  final String experince;
  TeacherContent(
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
  State<TeacherContent> createState() => _TeacherContentState();
}

class _TeacherContentState extends State<TeacherContent> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
            bottom: TabBar(
              tabs: [
                Tab(text: 'Chat'),
                Tab(
                  text: 'BioData',
                ),
                Tab(text: 'Live'),
              ],
            ),

            // title: Text('Teacher Data'),
            centerTitle: true,
          ),
          body: TabBarView(
            children: [
              AdminTeacherChat(
                email: widget.email,
              ),
              TeacherDetails(
                email: widget.email,
                name: widget.name,
                age: widget.age,
                experince: widget.experince,
                mobile: widget.mobile,
                qualification: widget.qualification,
                subject: widget.subject,
              ),
               TeacherDetails(
                email: widget.email,
                name: widget.name,
                age: widget.age,
                experince: widget.experince,
                mobile: widget.mobile,
                qualification: widget.qualification,
                subject: widget.subject,
              ),
               
              // LiveVideo(),
            ],
          ),
        ),
      ),
    );
  }
}
