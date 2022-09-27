import 'package:easy_school/admin/admin_teacher_chat.dart';
import 'package:easy_school/admin/live_video.dart';
import 'package:easy_school/common_module/app_color.dart';
import 'package:easy_school/teacher/get_profile_details.dart';
import 'package:easy_school/teacher/teacher_admin_chat.dart';
import 'package:easy_school/teacher/teacher_profile_account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth/login.dart';
class TeacherProfile extends StatefulWidget {
   static String routeName = '/teacher-profile';
  TeacherProfile({Key? key}) : super(key: key);

  @override
  State<TeacherProfile> createState() => _TeacherProfileState();
}

class _TeacherProfileState extends State<TeacherProfile> {
    User? user = FirebaseAuth.instance.currentUser!;
     void logOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
  
    print(' ${user?.email}');
    return Scaffold(
      
      // backgroundColor: AppColor.background,
      body: SafeArea(
         child: SingleChildScrollView(
                 child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: [
                     Container(
                       child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: CircleAvatar(
                              radius: 55,
                              child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      width: 35,
                                      height: 35,
                                      alignment: Alignment.topLeft,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                           40),
                                        color: Colors.white,
                                      ),
                                      child: IconButton(
                                        alignment: Alignment.bottomRight,
                                        onPressed: () async {
                                          // await uploadProfile();
                                        },
                                        icon: Icon(Icons.add, color: AppColor.background,),
                                      ),
                                    ),
                                  ),
                           ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                               GetProfileDetails(documentId: user!.email.toString()),
                                Text(
                                  "${user?.email.toString()}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                  ),
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: Text('Manage Your Google Account'))
                            ],
                          ),

                        ],
                       ),
                     ),
                     SizedBox(height: 20,),
                     Divider(thickness: 1.3, color: AppColor.background,),
                      ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TeacherProfileAccount()));
                },
                leading: Icon(
                  Icons.person,
                ),
                title: Text('Account'),
              ),
                ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TeacherAdminChat(email: '${user?.email.toString()}')));
                },
                leading: Icon(
                  Icons.mail,
                ),
                title: Text('Chat'),
              ),
              //   ListTile(
              //   onTap: () {
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: (context) => LiveVideo()));
              //   },
              //   leading: Icon(
              //     Icons.live_tv_rounded,
              //   ),
              //   title: Text('Live'),
              // ),
                ListTile(
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => ));
                },
                leading: Icon(
                  Icons.details
                ),
                title: Text('About'),
              ),
               ListTile(
                textColor: AppColor.background,
                iconColor: AppColor.background,
                onTap: () {
                  logOut();
                },
                leading: Icon(
                  Icons.logout_outlined, 
                ),
                title: Text('SignOut'),
              ),


                   ],
                 ),
                ),
        ),
    );
  }
}