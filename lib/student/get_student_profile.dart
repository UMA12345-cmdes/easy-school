import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetStudentProfile extends StatelessWidget {
  static String routeName = '/get-student-profile';
  final String? documentId;
  GetStudentProfile({this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('student');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
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
          return Text(
            "${data['name']}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          );
        }

        return Text("loading");
      },
    );
  }
}
