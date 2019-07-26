import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/isoft/IT_page/perbaikan/form_perbaikan.dart';
import 'package:flutter_abuba/isoft/IT_page/perbaikan/openStatus.dart';
import 'package:flutter_abuba/isoft/IT_page/perbaikan/report_perbaikan.dart';
import 'package:flutter_abuba/isoft/IT_page/perbaikan/verifikasi.dart';
import 'package:flutter_abuba/isoft/IT_page/perbaikan/working_order.dart';
import 'package:flutter_abuba/isoft/IT_page/perbaikan/lostAsset.dart';

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
                'IT',
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
                  'Perbaikan',
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
                      if (preCreate == false) {
                        preCreate = true;
                        itemMaintenance = [];

                        CollectionReference ref2 = Firestore.instance.collection('maintenance_IT');
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
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        preCreate
                          ? SizedBox(
                              width: 25.0,
                              height: 25.0,
                              child: CircularProgressIndicator(strokeWidth: 1.5),
                            )
                          : Stack(
                              overflow: Overflow.visible,
                              children: <Widget>[
                                Container(
                                    height: MediaQuery.of(context).size.width * 0.09,
                                    width: MediaQuery.of(context).size.width * 0.09,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                              'assets/images/hrd/create new.png',
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
                            'Create',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12.0),
                          ),
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
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            'Working Order',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                            MaterialPageRoute(
                              builder: (_) => FormVerifikasi(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)
                            )
                          );
                        },
                        child: Stack(
                          overflow: Overflow.visible,
                          children: <Widget>[
                            Container(
                                height: MediaQuery.of(context).size.width * 0.09,
                                width: MediaQuery.of(context).size.width * 0.09,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                          'assets/images/hrd/verifikasi.png',
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
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text('Verifikasi',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12.0),
                            softWrap: false,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),

                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                            MaterialPageRoute(
                              builder: (_) => OpenStatus(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)
                            )
                          );
                        },
                        child: Stack(
                          overflow: Overflow.visible,
                          children: <Widget>[
                            Container(
                                height: MediaQuery.of(context).size.width * 0.09,
                                width: MediaQuery.of(context).size.width * 0.09,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                          'assets/images/hrd/open status.png',
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
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text('Open Status',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12.0),
                            softWrap: false,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                        MaterialPageRoute(
                          builder: (_) => LostAsset(departmentUser: widget.departmentUser, namaUser: widget.namaUser, idUser: widget.idUser)
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
                                          'assets/images/iso/risk assesment.png',
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
                            'Lost Asset',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12.0),
                          ),
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
                            'Report',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
