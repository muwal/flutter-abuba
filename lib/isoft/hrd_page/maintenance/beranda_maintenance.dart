import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/isoft/hrd_page/maintenance/maintenance_test.dart';
import 'package:flutter_abuba/isoft/hrd_page/maintenance/skipped_maintenance.dart';
import 'package:flutter_abuba/isoft/hrd_page/maintenance/report_maintenance.dart';

class BerandaMaintenance extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  BerandaMaintenance({this.idUser, this.namaUser, this.departmentUser});

  @override
  _BerandaMaintenanceState createState() => _BerandaMaintenanceState();
}

class _BerandaMaintenanceState extends State<BerandaMaintenance> {
  final _scaffoldState = GlobalKey<ScaffoldState>();
  List<dynamic> outlet = [];
  List<dynamic> outletSkip = [];
  bool isPressed = false;

  bool buttonView = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldState,
        appBar: AppBar(
          elevation: 0.25,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Image.asset(
            'assets/images/logo2.png',
            height: 150.0,
            width: 120.0,
          ),
        ),
        body: _buildLogMenu(),
      ),
    );
  }

  Widget _buildLogMenu() {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'HRD',
                style: TextStyle(color: Colors.black12, fontSize: 12.0),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  '|',
                  style:
                  TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  'Maintenance',
                  style:
                  TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Wrap(
            spacing: 10.0,
            runSpacing: 15.0,
            direction: Axis.horizontal,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    onTap: () async {
                      Navigator.push(context,
                        MaterialPageRoute(
                          builder: (_) => FormMaintenanceTestHRD(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)
                        )
                      );
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Stack(
                          overflow: Overflow.visible,
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.width * 0.09,
                              width: MediaQuery.of(context).size.width * 0.09,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                        'assets/images/hrd/today task.png',
                                      ),
                                      fit: BoxFit.cover
                                  )
                              ),
                            ),
                            Positioned(
                              top: -10.0,
                              right: -8.0,
                              child: Icon(
                                Icons.brightness_1,
                                size: 25.0,
                                color: Colors.redAccent,
                              ),
                            ),
                            Positioned(
                              top: -5.0,
                              right: 2.0,
                              child: Text(
                                '2',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            'Task Lists',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (isPressed == false) {
                        setState(() {
                          outlet.clear();
                          outlet = [];
                          outletSkip.clear();
                          outletSkip = [];
                          isPressed = true;
                        });
                        CollectionReference reference = Firestore.instance.collection('maintenance_HRD');
                        reference.snapshots().listen((querySnapshot) {
                          querySnapshot.documentChanges.forEach((change) {
                            setState(() {
                              outlet.add(change.document.data['outlet']);
                            });
                          });
                        });

                        await new Future.delayed(Duration(
                            milliseconds: 500
                        ));

                        setState(() {
                          isPressed = false;
                        });

                        Navigator.push(context,
                          MaterialPageRoute(
                            builder: (_) => SkippedMaintenance(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser, count: outlet.length, countAll: outlet.length + outletSkip.length)
                          )
                        );
                      } else {

                      }
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Stack(
                          overflow: Overflow.visible,
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.width * 0.09,
                              width: MediaQuery.of(context).size.width * 0.09,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                        'assets/images/hrd/reschedule task.png',
                                      ),
                                      fit: BoxFit.cover
                                  )
                              ),
                            ),
                            Positioned(
                              top: -10.0,
                              right: -8.0,
                              child: Icon(
                                Icons.brightness_1,
                                size: 25.0,
                                color: Colors.redAccent,
                              ),
                            ),
                            Positioned(
                              top: -5.0,
                              right: 2.0,
                              child: Text(
                                '2',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            'Reschedule Task',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        buttonView = false;
                        buttonView = true;
                      });
                      await new Future.delayed(Duration(seconds: 3));
                      setState(() {
                        buttonView = true;
                        buttonView = false;
                      });

                      Navigator.push(context,
                        MaterialPageRoute(
                          builder: (_) => FormReport(idUser: widget.idUser, namaUser: widget.namaUser)
                        )
                      );
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Stack(
                          overflow: Overflow.visible,
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.width * 0.09,
                              width: MediaQuery.of(context).size.width * 0.09,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                        'assets/images/hrd/report.png',
                                      ),
                                      fit: BoxFit.cover
                                  )
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            buttonView
                                ? 'Preparing data ...'
                                : 'Report',
                            style: TextStyle(
                                fontSize: 12.0,
                                color: buttonView
                                    ? Colors.black54
                                    : Colors.black87, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[],
              ),
            ],
          ),
        ),
      ],
    );
  }
}