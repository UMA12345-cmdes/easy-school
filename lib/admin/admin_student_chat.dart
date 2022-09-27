import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_school/common_module/app_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminStudentChat extends StatefulWidget {
  static String routeName = '/admin-teacher-chat';
  final String email;
  AdminStudentChat({Key? key, required this.email}) : super(key: key);

  @override
  State<AdminStudentChat> createState() => _AdminStudentChatState();
}

class _AdminStudentChatState extends State<AdminStudentChat> {
  List element = [];
  @override
  void initState() {
    displayChat();
    // TODO: implement initState
    super.initState();
  }

  var chatController = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser!;

  displayChat() async {
    var collect = await FirebaseFirestore.instance
        .collection('student')
        .doc(widget.email);

    collect.get().then((value) {
      Map<String, dynamic>? data = value.data();
      setState(() {
        element = data!['chat'] as List;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child:  Wrap(
              children: [
                SingleChildScrollView(
                  child: Container(
                    height: 570,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: element.length,
                        itemBuilder: (context, index) {
                          return SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: ListTile(
                              onTap: () {
                                setState(() {});
                              },
                              leading: CircleAvatar(
                                backgroundColor: Colors.pink,
                              ),
                              trailing: Text(element[index]['email']),
                              title: Text(element[index]['msg']),
                              subtitle: Text(element[index]['createdAt']
                                  .toString()
                                  .split(' ')
                                  .first),
                            ),
                          );
                        }),
                  ),
                ),
                StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) =>
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: TextFormField(
                    controller: chatController,
                    decoration: InputDecoration(
                        hintText: 'Send a message....',
                        hintStyle: TextStyle(color: AppColor.background),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _send();
                              });
                            },
                            icon: Icon(
                              Icons.send,
                              color: AppColor.background,
                            ))
                        // border: OutlineInputBorder(),
                        ),
                  ),
                )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _send() async {
    DateTime _date = DateTime.now();
    var collection = FirebaseFirestore.instance.collection(
        'student'); //.doc(widget.email);//.collection('chat').doc(widget.email);
    try {
//     List msgList =[
//        chatController.text

//     ];
//  List<Map<String, dynamic>> emailMap = [
//         {
//           'msg': msgList,
//         }

//       ];

//       Map<String, dynamic> adminList = {
//         'admin': FieldValue.arrayUnion(emailMap),
//       };

//  Map<String, dynamic> commMap ={
//   'comm': adminList
//  };

      List<Map<String, dynamic>> updatedList = [
        {
          'msg': chatController.text,
          'createdAt': _date.toString(),
          'email': user?.email
        }
      ];

      Map<String, dynamic> updatedData = {
        'chat': FieldValue.arrayUnion(updatedList),
      };
       if(chatController.text.isEmpty)
      return print('enter message');
     
     else
      collection
          .doc(widget.email)
          .update(updatedData)
          .then((value) => print("Comments send"))
          .catchError((error) => print("Failed to send: $error"));
      chatController.clear();
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
      }
    }
  }
}
