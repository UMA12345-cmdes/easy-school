import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_school/common_module/app_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StudentProfileAccount extends StatefulWidget {
  static String routeName = '/student-profile-account';
  StudentProfileAccount({Key? key}) : super(key: key);

  @override
  State<StudentProfileAccount> createState() => _StudentProfileAccountState();
}

class _StudentProfileAccountState extends State<StudentProfileAccount> {
  CollectionReference users = FirebaseFirestore.instance.collection('student');
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
                  'Student Profile Details',
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
                    'Student Name',
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
                    data['batch'],
                    style: TextStyle(
                      fontSize: 19,
                    ),
                  ),
                  title: Text(
                    'Batch',
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
                    data['session'],
                    style: TextStyle(
                      fontSize: 19,
                    ),
                  ),
                  title: Text(
                    'Session',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                  ),
                ),
                ListTile(
                  textColor: AppColor.background,
                  trailing: Text(
                    data['course'],
                    style: TextStyle(
                      fontSize: 19,
                    ),
                  ),
                  title: Text(
                    'Course ',
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
