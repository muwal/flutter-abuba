import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/isoft/hrd_page/perbaikan/form_perbaikan.dart';
import 'package:flutter_abuba/isoft/hrd_page/perbaikan/openStatus.dart';
import 'package:flutter_abuba/isoft/hrd_page/perbaikan/report_perbaikan.dart';
import 'package:flutter_abuba/isoft/hrd_page/perbaikan/verifikasi.dart';
import 'package:flutter_abuba/isoft/hrd_page/perbaikan/working_order.dart';
import 'package:flutter_abuba/isoft/hrd_page/perbaikan/lostAsset.dart';
import 'package:flutter/services.dart';

class BerandaPerbaikan extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  BerandaPerbaikan({this.idUser, this.namaUser, this.departmentUser});

  @override
  _BerandaPerbaikanState createState() => _BerandaPerbaikanState();
}

class _BerandaPerbaikanState extends State<BerandaPerbaikan> {
  final _scaffoldState = GlobalKey<ScaffoldState>();
  List<dynamic> itemMaintenance = [];
  bool preCreate = false;

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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Color(0xff239d6d),
      ),
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
            body: _buildLogMenu(),
          ),
        ),
      ),
    );
  }

  Widget _buildLogMenu() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bgabuba.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Text(
                    'Assisten Manager',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: new BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  child: Text(
                    'Working Order',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.22,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Flexible(
                                          child: Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0,
                                                    right: 5.0,
                                                    bottom: 5.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Icon(Icons.location_on,
                                                        color: Colors.grey,
                                                        size: 16.0),
                                                    Flexible(
                                                      child: Text(
                                                        'Abuba Bogor - Bar',
                                                        style: TextStyle(
                                                            fontSize: 14.0,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                Colors.black87),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0,
                                                    right: 5.0,
                                                    bottom: 5.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        'Electronic - AC Split 2',
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: AbubaPallate
                                                                .greenabuba),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0,
                                                    right: 5.0,
                                                    bottom: 5.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        '# BBTQ029',
                                                        style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.black54),
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
                                    padding: const EdgeInsets.only(top: 2.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Flexible(
                                          child: Column(
                                            children: <Widget>[
                                              /*Padding(
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
                                              ),*/
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0,
                                                    right: 5.0,
                                                    bottom: 5.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        '12/01/2019',
                                                        style: TextStyle(
                                                          fontSize: 14.0,
                                                          fontWeight:
                                                              FontWeight.w500,
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
                                    padding: const EdgeInsets.only(
                                        top: 0.0, bottom: 3.0),
                                    child: Divider(
                                      height: 3.0,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                          child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
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
                                              minWidth: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.15,
                                              height: 30.0,
                                              child: OutlineButton(
                                                child: Row(
                                                  children: <Widget>[
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.15,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        'Detail',
                                                        style: TextStyle(
                                                            fontSize: 13.0,
                                                            color: AbubaPallate
                                                                .menuBluebird,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 2.0),
                                                highlightedBorderColor:
                                                    Colors.transparent,
                                                splashColor: Colors.white,
                                                onPressed: () {},
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
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
              ),
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
                  child: Text(
                    "Perbaikan",
                    style: TextStyle(
                        color: Colors.black38, fontWeight: FontWeight.w500),
                  ),
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
                    if (preCreate == false) {
                      preCreate = true;
                      itemMaintenance = [];

                      CollectionReference ref2 = Firestore.instance.collection('maintenance_HRD');
                      ref2.orderBy('itemNo', descending: false).snapshots().listen((data2) {
                        data2.documentChanges.forEach((getData2) {
                          setState(() {
                            if (itemMaintenance.length == 0) {
                              itemMaintenance.add(getData2.document.data['itemNo'] + ' - ' + getData2.document.data['item']);
                            } else {
                              if (itemMaintenance.contains(getData2.document.data['itemNo'] + ' - ' + getData2.document.data['item'])) {

                              } else {
                                itemMaintenance.add(getData2.document.data['itemNo'] + ' - ' + getData2.document.data['item']);
                              }
                            }
                          });
                        });
                      });
                      await new Future.delayed(Duration(
                          seconds: 2
                      ));
                      preCreate = false;
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (_) => FormPerbaikan(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser, itemMaintenance: itemMaintenance)
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
                          margin: EdgeInsets.symmetric(vertical: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              preCreate
                                  ? SizedBox(
                                      width: 30.0,
                                      height: 30.0,
                                      child: CircularProgressIndicator(
                                          strokeWidth: 1.5),
                                    )
                                  : Image.asset(
                                      'assets/images/hrd/create new2.png',
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
                              'Create',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey),
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
                            builder: (_) => WorkingOrder(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)
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
                              'Working Order',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey),
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
                            builder: (_) => OpenStatus(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'assets/images/hrd/open status2.png',
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
                              'Open Status',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey),
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
                            builder: (_) => FormVerifikasi(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)
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
                                'assets/images/hrd/verifikasi2.png',
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
                              'Verifikasi',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey),
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
                    /*Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => LostAsset(
                                departmentUser: widget.departmentUser,
                                namaUser: widget.namaUser,
                                idUser: widget.idUser)));*/
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
                                'assets/images/iso/risk assesment2.png',
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
                              'Lost Asset',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey),
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
                            builder: (_) => FormReport(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)
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
                              'Report',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey),
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
    );
  }
}
