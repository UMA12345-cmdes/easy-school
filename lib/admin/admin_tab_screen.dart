import 'package:easy_school/admin/student_home.dart';
import 'package:easy_school/admin/teacher_home.dart';
import 'package:flutter/material.dart';

import '../common_module/app_color.dart';
import 'admin_home.dart';

class AdminTabsScreen extends StatefulWidget {
  static String routeName = 'admintabScreen';
  const AdminTabsScreen({Key? key}) : super(key: key);

  @override
  State<AdminTabsScreen> createState() => _AdminTabsScreenState();
}

class _AdminTabsScreenState extends State<AdminTabsScreen> {
  int curIdx = 0;

  final List<Widget> _pages = [
    AdminHome(),
    TeacherHome(),
    StudentHome(),
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
                Icons.person,
              ),
              label: 'Teacher'),
          NavigationDestination(icon: Icon(Icons.people), label: 'Student'),
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
