import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_school/admin/teacher_content.dart';
import 'package:easy_school/admin/teacher_details.dart';
import 'package:flutter/material.dart';

import 'add_teacher.dart';
import '../common_module/app_color.dart';

class TeacherHome extends StatefulWidget {
  static String routeName = 'teacherHome';
  const TeacherHome({Key? key}) : super(key: key);

  @override
  State<TeacherHome> createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {
  bool _isDeleteLoading = false;

  // Map<int, bool> selectedFlag = {};
  // bool isSelectionMode = false;
  int sl_no = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teachers'),
        //  centerTitle: true,
        backgroundColor: AppColor.background,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddTeacher()));
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('teacher').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                  data: Theme.of(context).copyWith(dividerColor: Colors.white),
                  child: DataTable(

                      //border: TableBorder.symmetric(inside: BorderSide(width: 1.5,style: BorderStyle.solid,color: Colors.red)),
                      columns: const [
                        DataColumn(label: Text('Sl. No')),
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('Age')),
                        DataColumn(label: Text('Buttons')),
                      ],
                      rows: snapshot.data!.docs.map((rowData) {
                        sl_no = sl_no + 1;
                        //  selectedFlag[sl_no] = selectedFlag[sl_no] ?? false;
                        // bool isSelected = selectedFlag[sl_no];
                        return DataRow(
                          color: MaterialStateColor.resolveWith(
                            (states) => Colors.black12,
                          ),
                          cells: <DataCell>[
                            DataCell(CircleAvatar(
                                radius: 17, child: Text(sl_no.toString()))),
                            DataCell(Text(rowData['name'])),
                            DataCell(Text(rowData['age'])),
                            DataCell(Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.pink,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      deleteTeacher(rowData);
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.pink,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TeacherContent(
                                                    email: rowData['email'],
                                                    name: rowData['name'],
                                                    age: rowData['age'],
                                                    experince:
                                                        rowData['experince'],
                                                    mobile: rowData['mobile'],
                                                    qualification: rowData[
                                                        'qualification'],
                                                    subject: rowData['subject'],
                                                  )
                                              // AddTeacher()
                                              ));
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
      )),
    );
  }

  void deleteTeacher(QueryDocumentSnapshot rowData) {
    Map<String, dynamic> data = rowData.data() as Map<String, dynamic>;

    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Delete'),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      icon: const Icon(Icons.close_rounded)),
                ],
              ),
              titlePadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              content: Text('Are You Sure you want to delete?'),
              actions: [
                ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        _isDeleteLoading = true;
                      });
                      await FirebaseFirestore.instance
                          .collection('teacher')
                          .doc(rowData['email'])
                          .delete();
                      setState(() {
                        _isDeleteLoading = false;
                        Navigator.of(context).pop();
                      });
                    },
                    child: _isDeleteLoading
                        ? Center(child: CircularProgressIndicator())
                        : Text('Delete'))
              ],
            ));
  }
}
