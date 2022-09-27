import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_school/admin/student_details.dart';
import 'package:easy_school/common_module/app_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../admin/student_content.dart';

class StudentSchoolInfo extends StatefulWidget {
  static String routeName = '/student-school-info';
  StudentSchoolInfo({Key? key}) : super(key: key);

  @override
  State<StudentSchoolInfo> createState() => _StudentSchoolInfoState();
}

class _StudentSchoolInfoState extends State<StudentSchoolInfo> {
  @override
  Widget build(BuildContext context) {
    int sl_no = 0;
    // CollectionReference users = FirebaseFirestore.instance.collection('student');
    // User? user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      // backgroundColor: AppColor.background,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Student Informations',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('student').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something is wrong');
                }
                if (ConnectionState.waiting == snapshot.connectionState) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    primary: false,
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: AppColor.background),
                      child: DataTable(
                          columns: const [
                            DataColumn(label: Text('Sl. No')),
                            DataColumn(label: Text('Name')),
                            DataColumn(label: Text('course')),
                            DataColumn(label: Text('session')),
                          ],
                          rows: snapshot.data!.docs.map((rowData) {
                            sl_no = sl_no + 1;

                            return DataRow(
                              color: MaterialStateColor.resolveWith(
                                (states) => Colors.black12,
                              ),
                              cells: <DataCell>[
                                DataCell(CircleAvatar(
                                    radius: 17, child: Text(sl_no.toString()))),
                                DataCell(Text(rowData['name'])),
                                DataCell(Text(rowData['course'])),
                              
                                DataCell(Row(
                                  children: [
                                    Spacer(),
                                    Text(rowData['session']),
                                    Spacer(),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      StudentDetails(
                                                        email: rowData['email'],
                                                        name: rowData['name'],
                                                        age: rowData['age'],
                                                        batch: rowData['batch'],
                                                        mobile:
                                                            rowData['mobile'],
                                                        course:
                                                            rowData['course'],
                                                        subject:
                                                            rowData['subject'],
                                                        session:
                                                            rowData['session'],
                                                      )));
                                        },
                                        icon: const Icon(
                                          Icons.arrow_right_alt,
                                          color: Colors.pink,
                                        ))
                                  ],
                                )),
                              ],
                            );
                          }).toList()),
                    ),
                  );
                }
                sl_no = 0;
                return Text('No Data');
              },
            ),
          ],
        ),
      )),
    );
  }
}
