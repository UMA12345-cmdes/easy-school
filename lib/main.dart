import 'package:easy_school/admin/add_student.dart';
import 'package:easy_school/admin/add_teacher.dart';
import 'package:easy_school/admin/admin_home.dart';
import 'package:easy_school/admin/admin_student_chat.dart';
import 'package:easy_school/admin/admin_tab_screen.dart';
import 'package:easy_school/admin/admin_teacher_chat.dart';
import 'package:easy_school/admin/live_video.dart';
import 'package:easy_school/admin/student_content.dart';
import 'package:easy_school/admin/student_home.dart';
import 'package:easy_school/admin/teacher_home.dart';
import 'package:easy_school/auth/login.dart';
import 'package:easy_school/common_module/app_color.dart';
import 'package:easy_school/provider/provider.dart';
import 'package:easy_school/student/student_home_screen.dart';
import 'package:easy_school/student/student_profile.dart';
import 'package:easy_school/student/student_profile_account.dart';
import 'package:easy_school/student/student_school_info.dart';
import 'package:easy_school/student/student_tab_screen.dart';
import 'package:easy_school/teacher/teacher_home_screen.dart';
import 'package:easy_school/teacher/teacher_profile.dart';
import 'package:easy_school/teacher/teacher_profile_account.dart';
import 'package:easy_school/teacher/teacher_tab_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp( MyApp());

}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);
  

  User? user= FirebaseAuth.instance.currentUser!;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProviderData(),
        )
      ],
      child: GetMaterialApp(
        title: 'Easy School',
                debugShowCheckedModeBanner: false,
           
        theme: ThemeData(
          fontFamily: 'Lato',
          primaryColor: AppColor.background,
          primarySwatch: Colors.pink,
        ),
        home: FirebaseAuth.instance.currentUser != null ? FirebaseAuth.instance.currentUser!.email == 'admin@gmail.com' ?
        AdminTabsScreen() : TeacherTabScreen() 
         : Login(),
        routes: {
          Login.routeName: (_) => Login(),
          StudentSchoolInfo.routeName: (_)=> StudentSchoolInfo(),
          StudentTabScreen.routeName: (_)=> StudentTabScreen(),
          StudentProfile.routeName: (_)=> StudentProfile(),
          StudentProfileAccount.routeName: (_)=> StudentProfileAccount(),
          StudentHomeScreen.routeName: (_)=> StudentHomeScreen(),
          AddTeacher.routeName:(_)=> AddTeacher(),
          AddStudent.routeName:(_)=> AddStudent(),
          AdminHome.routeName:(_)=> AdminHome(),
          // AdminStudentChat.routeName:(_) => AdminStudentChat(email: '',)
          AdminTabsScreen.routeName: (_)=> AdminTabsScreen(),
          AdminTeacherChat.routeName: (_)=> AdminTeacherChat(email: ''),
          // LiveVideo.routeName: (_)=> LiveVideo(),
          StudentHome.routeName: (_)=> StudentHome(),
          TeacherHome.routeName: (_)=> TeacherHome(),
          TeacherHomeScreen.routeName: (_)=> TeacherHomeScreen(),
          TeacherProfile.routeName: (_)=> TeacherProfile(),
          TeacherProfileAccount.routeName: (_)=> TeacherProfileAccount(),
          TeacherTabScreen.routeName: (_)=> TeacherTabScreen(),
          
          // StudentContent.routeName: (_)=> StudentContent(email: '', name: '', mobile: '', age: '', subject: '', batch: batch, course: course, session: session)

        },
 
        
      ),
    );
  }
 
}

