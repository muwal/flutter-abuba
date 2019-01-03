import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';

class BerandaManagement extends StatefulWidget {
  @override
  _BerandaManagementState createState() => _BerandaManagementState();
}

class _BerandaManagementState extends State<BerandaManagement> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AbubaAppBar(),
      ),
    );
  }
}
