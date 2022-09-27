import 'package:easy_school/admin/student_home.dart';
import 'package:easy_school/teacher/teacher_home_screen.dart';
import 'package:easy_school/teacher/teacher_profile.dart';
import 'package:flutter/material.dart';

import '../admin/admin_home.dart';
import '../common_module/app_color.dart';

class TeacherTabScreen extends StatefulWidget {
   static String routeName = 'teacher-tab-screen';
  const TeacherTabScreen({Key? key}) : super(key: key);

  @override
  State<TeacherTabScreen> createState() => _TeacherTabScreenState();
}

class _TeacherTabScreenState extends State<TeacherTabScreen> {
  int curIdx = 0;

  final List<Widget> _pages = [
    TeacherHomeScreen(), 
    StudentHome(),
     TeacherProfile()
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: curIdx,
        onDestinationSelected: (int index) {
          setState(() {
            curIdx = index;
          });
        },
        backgroundColor: AppColor.background,
        elevation: 5,
        animationDuration: const Duration(milliseconds: 1000),
        destinations: const [
          NavigationDestination(
            icon: Icon(
              Icons.home,
              size: 28,
            ),
            label: 'Home',
          ),
          NavigationDestination(
              icon: Icon(
                Icons.people_alt,
              ),
              label: 'Student'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        height: 60,
      ),
      body: IndexedStack(
        children: [_pages[curIdx]],
      ),
    );
  }
}
