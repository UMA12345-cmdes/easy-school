import 'package:easy_school/student/student_home_screen.dart';
import 'package:easy_school/student/student_profile.dart';
import 'package:easy_school/student/student_school_info.dart';
import 'package:flutter/material.dart';

import '../common_module/app_color.dart';

class StudentTabScreen extends StatefulWidget {
  static String routeName = 'studentTabScreen';
  StudentTabScreen({Key? key}) : super(key: key);

  @override
  State<StudentTabScreen> createState() => _StudentTabScreenState();
}

class _StudentTabScreenState extends State<StudentTabScreen> {
  int curIdx = 0;

  final List<Widget> _pages = [
    StudentHomeScreen(),
    StudentSchoolInfo(),
    StudentProfile()
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
                Icons.file_copy,
              ),
              label: 'School Information'),
          NavigationDestination(
            icon: Icon(Icons.person),
             label: 'Profile'),
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
