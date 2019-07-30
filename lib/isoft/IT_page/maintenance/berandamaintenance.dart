import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/isoft/IT_page/maintenance/maintenance_test.dart';
import 'package:flutter_abuba/isoft/IT_page/maintenance/skipped_maintenance.dart';
import 'package:flutter_abuba/isoft/IT_page/maintenance/report_maintenance.dart';
import 'package:flutter/services.dart';
import 'package:flutter_abuba/isoft/operation_page/workinginstruction/list/form_list.dart';

class BerandaMaintenance extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  BerandaMaintenance({this.idUser, this.namaUser, this.departmentUser});

  @override
  _BerandaMaintenanceState createState() => _BerandaMaintenanceState();
}

class _BerandaMaintenanceState extends State<BerandaMaintenance> with TickerProviderStateMixin {
  final _scaffoldState = GlobalKey<ScaffoldState>();
  AnimationController animationController;

  List<bool> showDetail = [];
  List<dynamic> outlet = [];
  List<dynamic> dueDate = [];
  List<dynamic> lokasi = [];
  List<dynamic> maintenanceNo = [];
  List<dynamic> merek = [];
  List<dynamic> item = [];
  List<dynamic> itemNo = [];
  List<dynamic> frequency = [];
  List<dynamic> pic = [];
  List<dynamic> picID = [];
  List<String> qrCode = [];
  var indexx = [];
  List<dynamic> status = [];
  List<dynamic> userCreated = [];
  List<dynamic> job = [];
  List<dynamic> jobStatus = [];

  Future<bool> _onWillPop() {
    Navigator.pop(context);
    /*SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Color(0xfff9f9f9), //
    ));*/
    return null;
  }

  bool showNotifMaintenanceTLToday = false;
  bool showNotifMaintenanceTLSkip = false;
  bool showNotifMaintenanceTLReschedule = false;

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(
      from: animationController.value == 0.0
        ? 1.0
        : animationController.value
    );

    CollectionReference reference = Firestore.instance.collection('maintenance_IT');
    reference.where('pic', isEqualTo: widget.idUser).where('status', isEqualTo: 'OPEN').limit(10).snapshots().listen((querySnapshot) {
      querySnapshot.documentChanges.forEach((change) {
        // setState(() {
          Timestamp bantu = change.document.data['dueDate'];
          if (bantu.toDate().toString().substring(8, 10) + '/' + bantu.toDate().toString().substring(5, 7) + '/' +bantu.toDate().toString().substring(0, 4) == DateTime.now().toString().substring(8, 10) + '/' + DateTime.now().toString().substring(5, 7) + '/' +DateTime.now().toString().substring(0, 4)) {
            dueDate.add(change.document.data['dueDate']);
            maintenanceNo.add(change.document.data['maintenanceNo']);
            frequency.add(change.document.data['frequency']);
            status.add(change.document.data['status']);
            userCreated.add(change.document.data['userCreated']);
            picID.add(change.document.data['pic']);

            job.add(change.document.data['jobdesc']);
            jobStatus.add(change.document.data['jobdesc_status']);

            Firestore.instance.collection('outlet').where('id', isEqualTo: change.document.data['outlet']).snapshots().listen((data) {
              outlet.add(data.documents[0].data['nama_outlet']);
            });

            Firestore.instance.collection('lokasi').where('id', isEqualTo: change.document.data['lokasi']).snapshots().listen((data2) {
              lokasi.add(data2.documents[0].data['lokasi']);
            });

            merek.add(change.document.data['merek']);
            indexx.add(change.document.documentID);
            item.add(change.document.data['item']);
            itemNo.add(change.document.data['itemNo']);
            qrCode.add(change.document.data['itemNo']);

            Firestore.instance.collection('user').where('id', isEqualTo: change.document.data['pic']).snapshots().listen((data5) {
              pic.add(data5.documents[0].data['nama']);
            });
          }
        // });
      });
    });

    CollectionReference reference11 = Firestore.instance.collection('maintenance_IT');
    reference11.where('pic', isEqualTo: widget.idUser).where('status', isEqualTo: 'OPEN').snapshots().listen((querySnapshot11) {
      querySnapshot11.documentChanges.forEach((change11) {
        setState(() {
          Timestamp bantu = change11.document.data['dueDate'];
          if (bantu.toDate().toString().substring(8, 10) + '/' + bantu.toDate().toString().substring(5, 7) + '/' +bantu.toDate().toString().substring(0, 4) == DateTime.now().toString().substring(8, 10) + '/' + DateTime.now().toString().substring(5, 7) + '/' +DateTime.now().toString().substring(0, 4)) {
            showNotifMaintenanceTLToday = true;
          } else {
            showNotifMaintenanceTLToday = false;
          }
        });
      });
    });

    CollectionReference reference12 = Firestore.instance.collection('maintenance_IT');
    reference12.where('pic', isEqualTo: widget.idUser).where('status', isEqualTo: 'RESCHEDULE').snapshots().listen((querySnapshot12) {
      querySnapshot12.documentChanges.forEach((change12) {
        setState(() {
          Timestamp bantu = change12.document.data['newDueDate'];
          if (bantu.toDate().toString().substring(8, 10) + '/' + bantu.toDate().toString().substring(5, 7) + '/' +bantu.toDate().toString().substring(0, 4) == DateTime.now().toString().substring(8, 10) + '/' + DateTime.now().toString().substring(5, 7) + '/' +DateTime.now().toString().substring(0, 4)) {
            showNotifMaintenanceTLSkip = true;
          } else {
            showNotifMaintenanceTLSkip = false;
          }
        });
      });
    });

    CollectionReference reference13 = Firestore.instance.collection('maintenance_IT');
    reference13.where('rescheduleBy', isEqualTo: widget.idUser).where('status', isEqualTo: 'SKIP').where('newDueDate', isNull: true).snapshots().listen((querySnapshot13) {
      querySnapshot13.documentChanges.forEach((change13) {
        setState(() {
          showNotifMaintenanceTLReschedule = true;
        });
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
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
                child: AnimatedBuilder(
                  animation: animationController,
                  builder: (_, Widget child) {
                    return animationController.isAnimating
                      ? Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : ListView(
                  children: <Widget>[
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: <Widget>[
                    //     // IconButton(
                    //     //   onPressed: _onWillPop,
                    //     //   icon: Icon(Icons.arrow_back, color: Colors.white),
                    //     // ),
                    //     /*SizedBox(
                    //         width: 10.0,
                    //       ),
                    //       Flexible(
                    //         child: Text('Maintenance', style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w600),)
                    //       )*/
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 35.0,
                    // ),
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
                            child: item.length == 0
                              ? Container(
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    elevation: 2.0,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.80,
                                      height: MediaQuery.of(context).size.height * 0.60,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(right: 5.0),
                                            child: Text(
                                              'Tidak Ada Tugas Hari Ini',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: item.length + 1,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    if (index < item.length) { 
                                      return GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (builder) {
                                              return DialogBottomDetail(
                                                job: job[index],
                                                jobStatus: jobStatus[index],
                                                departmentUser: widget.departmentUser,
                                                idUser: widget.idUser,
                                                namaUser: widget.namaUser,
                                              );
                                            }
                                          );
                                        },
                                        child: Container(
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
                                                                        outlet[index] + ' - ' + lokasi[index],
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
                                                                        merek[index] + ' - ' + item[index],
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
                                                                        itemNo[index],
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
                                                                        frequency[index],
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
                                        ),
                                      );
                                    } else {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(context,
                                            MaterialPageRoute(
                                              builder: (_) => FormMaintenanceTest(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)
                                            )
                                          );
                                        },
                                        child: Container(
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15.0),
                                            ),
                                            elevation: 2.0,
                                            child: Container(
                                              width: MediaQuery.of(context).size.width * 0.80,
                                              height: MediaQuery.of(context).size.height * 0.60,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding: EdgeInsets.only(right: 5.0),
                                                        child: Text(
                                                          'MORE',
                                                          style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight: FontWeight.bold
                                                          ),
                                                        ),
                                                      ),
                                                      Icon(Icons.arrow_forward_ios, size: 18.0)
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                )
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
                            onTap: () {
                              Navigator.push(context,
                                MaterialPageRoute(
                                  builder: (_) => FormMaintenanceTest(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)
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
                                    margin: EdgeInsets.symmetric(vertical: 10.0),
                                    child: Stack(
                                      overflow: Overflow.visible,
                                      children: <Widget>[
                                        Center(
                                          child: Image.asset(
                                            'assets/images/hrd/today task2.png',
                                            width: 30.0,
                                            height: 30.0,
                                          ),
                                        ),
                                        showNotifMaintenanceTLToday
                                          ? Positioned(
                                              top: -7.0,
                                              right: 0.0,
                                              child: Icon(
                                                Icons.brightness_1,
                                                size: 13.0,
                                                color: Colors.redAccent,
                                              ),
                                            )
                                          : Container(),
                                        showNotifMaintenanceTLSkip
                                          ? Positioned(
                                              top: -7.0,
                                              right: 0.0,
                                              child: Icon(
                                                Icons.brightness_1,
                                                size: 13.0,
                                                color: Colors.redAccent,
                                              ),
                                            )
                                          : Container(),
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
                            onTap: () {
                               Navigator.push(context,
                                MaterialPageRoute(
                                  builder: (_) => SkippedMaintenance(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)
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
                                    margin: EdgeInsets.symmetric(vertical: 10.0),
                                    child: Stack(
                                      overflow: Overflow.visible,
                                      children: <Widget>[
                                        Center(
                                          child: Image.asset(
                                            'assets/images/hrd/reschedule task2.png',
                                            width: 30.0,
                                            height: 30.0,
                                          ),
                                        ),
                                        showNotifMaintenanceTLReschedule
                                          ? Positioned(
                                              top: -7.0,
                                              right: 0.0,
                                              child: Icon(
                                                Icons.brightness_1,
                                                size: 13.0,
                                                color: Colors.redAccent,
                                              ),
                                            )
                                          : Container(),
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
                            onTap: () {
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
                                    margin: EdgeInsets.symmetric(vertical: 10.0),
                                    child: Stack(
                                      overflow: Overflow.visible,
                                      children: <Widget>[
                                        Center(
                                          child: Image.asset(
                                            'assets/images/hrd/report2.png',
                                            width: 30.0,
                                            height: 30.0,
                                          ),
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
                                        'Report',
                                        style: TextStyle(fontWeight: FontWeight.w400, color: Colors.grey),
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
                );
                  },
                )
              ),
            ),
          ),
      ),
    );
  }
}

class DialogBottomDetail extends StatefulWidget {
  List<dynamic> job;
  List<dynamic> jobStatus;
  final int idUser;
  final String departmentUser;
  final String namaUser;

  DialogBottomDetail({this.job, this.jobStatus, this.departmentUser, this.idUser, this.namaUser});
  @override
  _DialogBottomDetailState createState() => _DialogBottomDetailState();
}

class _DialogBottomDetailState extends State<DialogBottomDetail> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Text(
                    'Detail Maintenance',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.3 - 40.0,
            child: widget.job.length == 0
              ? Center(
                  child: Text(
                    'No Data',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                )
              : Column(
                  children: <Widget>[
                    Expanded(
                      child: Scrollbar(
                        child: ListView.builder(
                          physics: ScrollPhysics(),
                          itemCount: widget.job.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        '${index + 1}. ${widget.job[index]}',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              trailing: Container(
                                alignment: Alignment.centerRight,
                                width: MediaQuery.of(context).size.width * 0.15,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        widget.jobStatus[index],
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: AbubaPallate.menuBluebird,
                                          fontWeight: FontWeight.w500
                                        ),
                                        textAlign: TextAlign.end,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                        ),
                      )
                    ),
                  ],
                ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            width: MediaQuery.of(context).size.width * 0.4,
            child: ButtonTheme(
              minWidth: MediaQuery.of(context).size.width * 0.3,
              height: 35.0,
              child: OutlineButton(
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Working Instruction',
                          style: TextStyle(
                            fontSize: 13.0,
                            color: AbubaPallate.menuBluebird,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                    ],
                  )
                ),
                borderSide: BorderSide(color: Colors.grey[350], width: 2.0),
                highlightedBorderColor: Colors.grey[350],
                splashColor: Colors.white,
                onPressed: () {
                  Navigator.pushReplacement(context, 
                    MaterialPageRoute(
                      builder: (_) => FormListWorking(departmentUser: widget.departmentUser, namaUser: widget.namaUser, idUser: widget.idUser, type: 'maintenanceIT')
                    )
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}