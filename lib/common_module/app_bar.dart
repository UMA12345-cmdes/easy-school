import 'package:easy_school/common_module/app_color.dart';
import 'package:flutter/material.dart';
class AppBarItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
     title: Text('Easy School'),
     centerTitle: true,
     backgroundColor: AppColor.background,
      )
      
    );
  }
}