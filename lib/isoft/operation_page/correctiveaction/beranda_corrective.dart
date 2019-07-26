import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/isoft/operation_page/correctiveaction/car_IA.dart';
import 'package:flutter_abuba/isoft/operation_page/correctiveaction/car_nonIA.dart';
import 'package:flutter_abuba/isoft/operation_page/correctiveaction/form_createnew.dart';
import 'package:flutter_abuba/isoft/operation_page/correctiveaction/praReport.dart';
import 'package:flutter_abuba/isoft/operation_page/correctiveaction/pra_create.dart';
import 'package:flutter_abuba/isoft/operation_page/correctiveaction/verifikasi.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MenuCorrective extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  MenuCorrective({this.idUser, this.namaUser, this.departmentUser});

  @override
  _MenuCorrectiveState createState() => _MenuCorrectiveState();
}

class _MenuCorrectiveState extends State<MenuCorrective> {
  final _scaffoldState = GlobalKey<ScaffoldState>();

  var verifikasiCount;
  var continueCount;
  var closedCount;
  var unClosedCount;

  bool reportProses = false;

  @override
  void initState() {
    super.initState();

    verifikasiJumlah().then((result) {
      setState(() {
        verifikasiCount = result;
      });
    });

    continueJumlah().then((result) {
      setState(() {
        continueCount = result;
      });
    });

    closedJumlah().then((result) {
      setState(() {
        closedCount = result;
      });
    });

    unClosedJumlah().then((result) {
      setState(() {
        unClosedCount = result;
      });
    });
  }

  Future<int> verifikasiJumlah() async {
    var query = Firestore.instance.collection('correctiveAction').where('userCreated', isEqualTo: widget.idUser);
    var querySnapshot = await query.getDocuments();
    var jumlah = querySnapshot.documents.length;

    return jumlah;
  }

  Future<int> continueJumlah() async {
    var query = Firestore.instance.collection('correctiveAction').where('userDituju', isEqualTo: widget.idUser);
    var querySnapshot = await query.getDocuments();
    var jumlah = querySnapshot.documents.length;

    return jumlah;
  }

  Future<int> closedJumlah() async {
    var query = Firestore.instance.collection('correctiveAction').where('status', isEqualTo: 'CLOSED');
    var querySnapshot = await query.getDocuments();
    var jumlah = querySnapshot.documents.length;

    return jumlah;
  }

  Future<int> unClosedJumlah() async {
    var query = Firestore.instance.collection('correctiveAction');
    var querySnapshot = await query.getDocuments();
    var jumlah = querySnapshot.documents.length;

    return jumlah;
  }

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
                'ISO',
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
                  'Corrective Action',
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
                    onTap: () {
                      Navigator.push(context,
                          MyCustomRoute(
                              builder: (context) => FormCreateNew(idUser: widget.idUser, departmentUser: widget.departmentUser, namaUser: widget.namaUser, status: 'newCAR')
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
                            'Create New',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            '',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12.0),
                          ),
                        ),
                      ],
                    ),
                  ),

                  GestureDetector(
                    onTap: () => Navigator.push(context,
                            MyCustomRoute(builder: (context) => Verifikasi(idUser: widget.idUser, departmentUser: widget.departmentUser, namaUser: widget.namaUser))),
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
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            'Verification',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            '',
                            style: TextStyle(
                                fontSize: 12.0, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () async {
                          if (reportProses == false) {
                            setState(() {
                              reportProses = true;
                            });
                            double persen = (closedCount / unClosedCount) * 100.0;

                            var closedCAR;
                            var openCAR;
                            var doneCAR;
                            var ongoingCAR;
                            var unclosedCAR;
                            var grafik;
                            int departmentIDUser;
                            List<dynamic> coba = [];
                            String grafikText;
                            Firestore.instance.collection('user').where('id', isEqualTo: widget.idUser).snapshots().listen((data10) {
                              setState(() {
                                departmentIDUser = data10.documents[0].data['departmentID'];
                              });
                            });
                            await new Future.delayed(Duration(
                              seconds: 1
                            ));

                            CollectionReference reference = Firestore.instance.collection('correctiveAction');
                            reference.snapshots().listen((data) {
                              data.documentChanges.forEach((change) {
                                if (departmentIDUser == change.document.data['departmentDituju']) {
                                  setState(() {
                                    coba.add(change.document.data['status']);
                                  });
                                }
                              });
                            });
                            await new Future.delayed(Duration(
                              seconds: 1
                            ));
                            setState(() {
                              openCAR = coba.where((c) => c == 'OPEN').toList().length;
                              closedCAR = coba.where((c) => c == 'CLOSED').toList().length;
                              ongoingCAR = coba.where((c) => c == 'ONGOING').toList().length;
                              doneCAR = coba.where((c) => c == 'DONE').toList().length;

                              unclosedCAR = openCAR + doneCAR + ongoingCAR + closedCAR;
                              grafik = (closedCAR / unclosedCAR) * 100;
                              reportProses = false;

                              var bantu = grafik.toString().split('.');
                              if (bantu.length > 1) {
                                if (bantu[1].length > 1) {
                                  grafikText = bantu[0] + '.' + bantu[1].toString().substring(0, 2);
                                } else {
                                  grafikText = bantu[0] + '.' + bantu[1].toString();
                                }
                              } else {
                                grafikText = grafik.toString();
                              }
                            });
                            
                            Navigator.push(context,
                              MyCustomRoute(
                                builder: (context) => PraReportCar(idUser: widget.idUser, departmentUser: widget.departmentUser, namaUser: widget.namaUser, persen: persen, closedCAR: closedCAR, grafik: grafik, unclosedCAR: unclosedCAR, grafikText: grafikText)
                              )
                            );
                          } else {
                            print('loading');
                          }
                        },
                        child: reportProses
                          ? Container(
                              child: SizedBox(
                                width: 25.0,
                                height: 25.0,
                                child: CircularProgressIndicator(),
                              )
                            )
                          : Container(
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
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text('View Report',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12.0),
                            softWrap: false,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text(
                          '',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12.0),
                        ),
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
                          MyCustomRoute(
                              builder: (context) => CarIA(idUser: widget.idUser, departmentUser: widget.departmentUser, namaUser: widget.namaUser)
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
                                        'assets/images/iso/internal audit.png',
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
                            'CAR Internal',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            'Audit',
                            style: TextStyle(
                                fontSize: 12.0, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MyCustomRoute(
                              builder: (context) => CarNonIA(idUser: widget.idUser, departmentUser: widget.departmentUser, namaUser: widget.namaUser)
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
                                        'assets/images/iso/internal audit.png',
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
                            'CAR Non',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            'Internal Audit',
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
