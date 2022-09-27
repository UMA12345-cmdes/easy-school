import 'package:easy_school/student/get_student_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../common_module/app_color.dart';
class StudentHomeScreen extends StatelessWidget {
  static String routeName = '/student-home-screen';
   StudentHomeScreen({Key? key}) : super(key: key);
User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GetStudentProfile(documentId: user!.email.toString()),
        //  centerTitle: true,
        backgroundColor: AppColor.background,
        leading: Icon(
          Icons.person,
          size: 30,
        ),

        actions: [
          Center(
              child: Text(
            'Easy School',
            style: TextStyle(fontSize: 22),
          )),
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Image(image: Image.asset('assets/image/log_bg.jpg').image),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListBody(
                children: [
                  Center(
                      child: Text(
                    'Descriptions',
                    style: TextStyle(fontSize: 24),
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Educational facilities are the facilities provided to students,'
                    'so that they can use every opportunity to develop full potential.'
                    'Educational facilities include buildings, fixtures, and equipment necessary '
                    'for the effective and efficient operation of the program of public education,'
                    'classrooms, libraries, rooms and space for physical education, space for fine '
                    'arts, restrooms, specialized laboratories, cafeterias, media centers, building'
                    'equipment, building fixtures, furnishings, related exterior facilities, landscaping'
                    'and paving,'
                    'and similar items which the State Board of Education may determine necessary. However, educational facilities do not include swimming pools,'
                    'tracks, stadiums, and other facilities or portions of facilities used primarily for'
                    'athletic competition and the central and area administrative offices of local units of'
                    'administration. [ O.C.G.A. § 20-2-260]'
                    'The traditional idea of classroom as an instructor focused learning space has changed. '
                    'The growth of computer-based instruction, video projection, and other telecommunication'
                    'requirements changed the nature of educational facilities.',
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
