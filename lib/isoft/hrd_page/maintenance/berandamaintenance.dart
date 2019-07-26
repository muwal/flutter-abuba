import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/isoft/hrd_page/maintenance/maintenance_test.dart';
import 'package:flutter_abuba/isoft/hrd_page/maintenance/skipped_maintenance.dart';
import 'package:flutter_abuba/isoft/hrd_page/maintenance/report_maintenance.dart';
import 'package:flutter/services.dart';

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

  Future<bool> _onWillPop() {
    Navigator.pop(context);
    /*SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Color(0xfff9f9f9), //
    ));*/
    return null;
  }

  @override
  Widget build(BuildContext context) {
    /*SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Color(0xff239d6d), //
    ));*/
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Color(0xff239d6d),),
      child: SafeArea(
        child: WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
            backgroundColor: Color(0xff239d6d),
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            key: _scaffoldState,
            body:  Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/bgabuba.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ListView(
                  children: <Widget>[
                    /*Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                          onPressed: _onWillPop,
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                        ),
                        *//*SizedBox(
                            width: 10.0,
                          ),
                          Flexible(
                            child: Text('Maintenance', style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w600),)
                          )*//*
                      ],
                    ),
                    SizedBox(
                      height: 35.0,
                    ),*/
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 25.0),
                          padding: EdgeInsets.all(10.0),
                          decoration: new BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          child: Text('Today Task', style: TextStyle(color: Colors.white),),
                        ),
                      ],
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.275,
                        margin: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: ListView.builder(
                                itemCount: 5,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Container(
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      elevation: 2.0,
                                      child: Container(
                                        width: MediaQuery.of(context).size.width * 0.80,
                                        height: MediaQuery.of(context).size.height * 0.60,
                                        child: Column(
                                          children: <Widget>[

                                            Padding(
                                              padding: const EdgeInsets.only(top: 10.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Column(
                                                      children: <Widget>[
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 10.0, right: 5.0, bottom: 5.0),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: <Widget>[
                                                              Icon(Icons.location_on, color: Colors.grey, size: 16.0),
                                                              Flexible(
                                                                child: Text(
                                                                  'Abuba Bogor - Kitchen',
                                                                  style: TextStyle(
                                                                      fontSize: 14.0,
                                                                      fontWeight: FontWeight.w400,
                                                                      color: Colors.black87
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 10.0, right: 5.0, bottom: 5.0),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: <Widget>[
                                                              Flexible(
                                                                child: Text(
                                                                  'ABC - Sauce',
                                                                  style: TextStyle(
                                                                      fontSize: 16.0,
                                                                      fontWeight: FontWeight.w700,
                                                                      color: AbubaPallate.greenabuba
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 10.0, right: 5.0, bottom: 5.0),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: <Widget>[
                                                              Flexible(
                                                                child: Text(
                                                                  '# 323232',
                                                                  style: TextStyle(
                                                                      fontSize: 16.0,
                                                                      fontWeight: FontWeight.w500,
                                                                      color: Colors.black54
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 5.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Column(
                                                      children: <Widget>[
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 10.0, right: 5.0, bottom: 5.0),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: <Widget>[
                                                              Flexible(
                                                                child: Text(
                                                                  'FREQUENCY',
                                                                  style: TextStyle(
                                                                      fontSize: 15.0,
                                                                      fontWeight: FontWeight.w800,
                                                                      color: Colors.black54,
                                                                      letterSpacing: 1.0
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 10.0, right: 5.0, bottom: 5.0),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: <Widget>[
                                                              Flexible(
                                                                child: Text(
                                                                  '6 Month',
                                                                  style: TextStyle(
                                                                    fontSize: 14.0,
                                                                    fontWeight: FontWeight.w500,
                                                                    color: Colors.black54,
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 10.0, bottom: 3.0),
                                              child: Divider(
                                                height: 3.0,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Flexible(
                                                    child: Container(
                                                      width: MediaQuery.of(context).size.width * 0.5,
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[
                                                          /*ButtonTheme(
                                                            minWidth: MediaQuery.of(context).size.width * 0.15,
                                                            height: 30.0,
                                                            child: OutlineButton(
                                                              child: Row(
                                                                children: <Widget>[
                                                                  Container(
                                                                    width: MediaQuery.of(context).size.width * 0.15,
                                                                    alignment: Alignment.center,
                                                                    child: Text(
                                                                      'Detail',
                                                                      style: TextStyle(
                                                                          fontSize: 13.0,
                                                                          color: AbubaPallate.menuBluebird,
                                                                          fontWeight: FontWeight.bold
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              borderSide: BorderSide(color: Colors.transparent, width: 2.0),
                                                              highlightedBorderColor: Colors.transparent,
                                                              splashColor: Colors.white,
                                                              onPressed: () {

                                                              },
                                                            ),
                                                          ),*/
                                                          ButtonTheme(
                                                            minWidth: MediaQuery.of(context).size.width * 0.15,
                                                            height: 30.0,
                                                            child: OutlineButton(
                                                              child: Row(
                                                                children: <Widget>[
                                                                  Container(
                                                                    width: MediaQuery.of(context).size.width * 0.15,
                                                                    alignment: Alignment.center,
                                                                    child: Text(
                                                                      'Skip',
                                                                      style: TextStyle(
                                                                          fontSize: 13.0,
                                                                          color: AbubaPallate.menuBluebird,
                                                                          fontWeight: FontWeight.bold
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              borderSide: BorderSide(color: Colors.transparent, width: 2.0),
                                                              highlightedBorderColor: Colors.transparent,
                                                              splashColor: Colors.white,
                                                              onPressed: () {

                                                              },
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                ),
                                                GestureDetector(
                                                  onTap: () {

                                                  },
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.1,
                                                    height: MediaQuery.of(context).size.width * 0.1,
                                                    padding: EdgeInsets.only(right: 10.0, bottom: 10.0, left: 10.0),
                                                    margin: EdgeInsets.only(right: 15.0),
                                                    alignment: Alignment.centerRight,
                                                    decoration: new BoxDecoration(
                                                        color: Colors.transparent,
                                                        shape: BoxShape.rectangle,
                                                        image: DecorationImage(
                                                            image: AssetImage('assets/images/scannerBlue.png'),
                                                            fit: BoxFit.fitWidth
                                                        )
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 0.0),
                            child: Text("Maintenance", style: TextStyle(color: Colors.black38,fontWeight: FontWeight.w500),),
                          ),
                          Expanded(
                            child: new Container(
                                margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                                child: Divider(
                                  color: Colors.black38,
                                  height: 2,
                                )),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15.0),
                      height: 330.0,
                      child: GridView.count(
                        crossAxisCount: 3,
                        children: <Widget>[
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
                                CollectionReference reference = Firestore.instance.collection('maintenance');
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
                                        builder: (_) => FormMaintenanceTestHRD(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)
                                    )
                                );
                              } else {

                              }
                            },
                            child: Column(
                              children: <Widget>[
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15.0),
                                      bottomRight: Radius.circular(15.0),
                                      topRight: Radius.circular(15.0),
                                      topLeft: Radius.circular(15.0),
                                    ),
                                  ),
                                  elevation: 1.0,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.17,
//                              height: MediaQuery.of(context).size.width * 0.15,
                                    margin: EdgeInsets.symmetric(vertical: 10.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset(
                                          'assets/images/hrd/today task2.png',
                                          width: 30.0,
                                          height: 30.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Task List',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400, color: Colors.grey),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
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
                                CollectionReference reference = Firestore.instance.collection('maintenance_IT');
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
                              children: <Widget>[
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15.0),
                                      bottomRight: Radius.circular(15.0),
                                      topRight: Radius.circular(15.0),
                                      topLeft: Radius.circular(15.0),
                                    ),
                                  ),
                                  elevation: 1.0,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.17,
//                              height: MediaQuery.of(context).size.width * 0.15,
                                    margin: EdgeInsets.symmetric(vertical: 10.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset(
                                          'assets/images/hrd/reschedule task2.png',
                                          width: 30.0,
                                          height: 30.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Reschedule Task',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400, color: Colors.grey),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
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
                              children: <Widget>[
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15.0),
                                      bottomRight: Radius.circular(15.0),
                                      topRight: Radius.circular(15.0),
                                      topLeft: Radius.circular(15.0),
                                    ),
                                  ),
                                  elevation: 1.0,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.17,
//                              height: MediaQuery.of(context).size.width * 0.15,
                                    margin: EdgeInsets.symmetric(vertical: 10.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Image.asset(
                                          'assets/images/hrd/report2.png',
                                          width: 30.0,
                                          height: 30.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        buttonView
                                            ? 'Preparing data ...'
                                            : 'Report',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400, color: buttonView
                                            ? Colors.black54
                                            : Colors.grey),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
      ),
    );
  }
}
