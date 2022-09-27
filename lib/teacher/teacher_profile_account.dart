import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_school/common_module/app_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TeacherProfileAccount extends StatefulWidget {
   static String routeName = '/teacher-profile';
  TeacherProfileAccount({Key? key}) : super(key: key);

  @override
  State<TeacherProfileAccount> createState() => _TeacherProfileAccountState();
}

class _TeacherProfileAccountState extends State<TeacherProfileAccount> {
  CollectionReference users = FirebaseFirestore.instance.collection('teacher');
  User? user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 0),
        alignment: Alignment.bottomCenter,
        // height: 50,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.close),
        ),
      ),
      // backgroundColor: AppColor.background,
      body: SafeArea(
          child: SingleChildScrollView(
              child: FutureBuilder<DocumentSnapshot>(
        future: users.doc(user?.email).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Wrap(
              children: [
                Center(
                    child: Text(
                  'Teacher Profile Details',
                  style: TextStyle(fontSize: 24, color: Colors.pink),
                )),
                SizedBox(
                  height: 30,
                ),
                Divider(
                  thickness: 1.2,
                  color: AppColor.background,
                ),
                ListTile(
                  textColor: AppColor.background,
                  trailing: Text(
                    data['name'],
                    style: TextStyle(
                      fontSize: 19,
                    ),
                  ),
                  title: Text(
                    'User Name',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                  ),
                ),
                ListTile(
                  textColor: AppColor.background,
                  trailing: Text(
                    data['age'],
                    style: TextStyle(
                      fontSize: 19,
                    ),
                  ),
                  title: Text(
                    'Age',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                  ),
                ),
                ListTile(
                  textColor: AppColor.background,
                  trailing: Text(
                    data['email'],
                    style: TextStyle(
                      fontSize: 19,
                    ),
                  ),
                  title: Text(
                    'Email Id',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                  ),
                ),
                ListTile(
                  textColor: AppColor.background,
                  trailing: Text(
                    data['subject'],
                    style: TextStyle(
                      fontSize: 19,
                    ),
                  ),
                  title: Text(
                    'Subject',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                  ),
                ),
                ListTile(
                  textColor: AppColor.background,
                  trailing: Text(
                    data['experince'],
                    style: TextStyle(
                      fontSize: 19,
                    ),
                  ),
                  title: Text(
                    'Experiance',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                  ),
                ),
                ListTile(
                  textColor: AppColor.background,
                  trailing: Text(
                    data['mobile'],
                    style: TextStyle(
                      fontSize: 19,
                    ),
                  ),
                  title: Text(
                    'Mobile Number',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                  ),
                ),
                ListTile(
                  textColor: AppColor.background,
                  trailing: Text(
                    data['qualification'],
                    style: TextStyle(
                      fontSize: 19,
                    ),
                  ),
                  title: Text(
                    'Education Qualification',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ))),
    );
  }
}
