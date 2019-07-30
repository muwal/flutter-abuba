import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/isoft/operation_page/internalaudit/form_jadwal_start.dart';

import 'form_createnew.dart';
import 'form_jadwalaudit.dart';
import 'form_auditreport.dart';

class MenuAudit extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;

  MenuAudit({this.idUser, this.namaUser, this.departmentUser});
  @override
  _MenuAuditState createState() => _MenuAuditState();
}

class _MenuAuditState extends State<MenuAudit> {
  final _scaffoldState = GlobalKey<ScaffoldState>();

  bool showNotifIAKonfirmasiLead = false;
  bool showNotifIAKonfirmasiAuditee = false;
  bool showNotifIAKonfirmasiAuditor = false;
  bool showNotifIAStartAuditLead = false;
  bool showNotifIAStartAuditAuditee = false;
  bool showNotifIAStartAuditAuditor = false;

  @override
  void initState() {
    CollectionReference reference5 = Firestore.instance.collection('audit_internal');
    reference5.where('auditEnd', isNull: true).where('leadAuditor', isEqualTo: widget.idUser).where('leadAuditorConfirm', isEqualTo: widget.idUser).snapshots().listen((querySnapshot5) {
      querySnapshot5.documentChanges.forEach((change5) {
        setState(() {
          showNotifIAKonfirmasiLead = true;
        });
      });
    });

    CollectionReference reference6 = Firestore.instance.collection('audit_internal');
    reference6.where('auditEnd', isNull: true).where('auditee', isEqualTo: widget.idUser).where('auditeeConfirm', isEqualTo: widget.idUser).snapshots().listen((querySnapshot6) {
      querySnapshot6.documentChanges.forEach((change6) {
        setState(() {
          showNotifIAKonfirmasiAuditee = true;
        });
      });
    });
    
    CollectionReference reference7 = Firestore.instance.collection('audit_internal');
    reference7.where('auditEnd', isNull: true).where('subAreaAuditor', arrayContains: widget.idUser.toString()).snapshots().listen((querySnapshot7) {
      querySnapshot7.documentChanges.forEach((change7) {
        setState(() {
          if (change7.document.data['auditorConfirm'].contains(widget.idUser.toString())) {
            showNotifIAKonfirmasiAuditor = true;
          } else {
            showNotifIAKonfirmasiAuditor = false;
          }
        });
      });
    });

    CollectionReference reference8 = Firestore.instance.collection('audit_internal');
    reference8.where('auditEnd', isNull: true).where('leadAuditorConfirm', isEqualTo: 'CONFIRM').where('auditeeConfirm', isEqualTo: 'CONFIRM').where('auditee', isEqualTo: widget.idUser).where('auditeeCheckIn', isNull: true).snapshots().listen((querySnapshot8) {
      querySnapshot8.documentChanges.forEach((change8) {
        setState(() {
          Timestamp bantu = change8.document.data['dateAudite'];
          if (bantu.toDate().toString().substring(8, 10) + '/' + bantu.toDate().toString().substring(5, 7) + '/' +bantu.toDate().toString().substring(0, 4) == DateTime.now().toString().substring(8, 10) + '/' + DateTime.now().toString().substring(5, 7) + '/' +DateTime.now().toString().substring(0, 4) || bantu.toDate().isBefore(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day))) {
            showNotifIAStartAuditAuditee = true;
          } else {
            showNotifIAStartAuditAuditee = false;
          }
        });
      });
    });

    CollectionReference reference9 = Firestore.instance.collection('audit_internal');
    reference9.where('auditEnd', isNull: true).where('leadAuditorConfirm', isEqualTo: 'CONFIRM').where('auditeeConfirm', isEqualTo: 'CONFIRM').where('leadAuditor', isEqualTo: widget.idUser).where('leadAuditorCheckIn', isNull: true).where('status', isEqualTo: 'ONGOING').snapshots().listen((querySnapshot9) {
      querySnapshot9.documentChanges.forEach((change9) {
        setState(() {
          Timestamp bantu = change9.document.data['dateAudite'];
          if (bantu.toDate().toString().substring(8, 10) + '/' + bantu.toDate().toString().substring(5, 7) + '/' +bantu.toDate().toString().substring(0, 4) == DateTime.now().toString().substring(8, 10) + '/' + DateTime.now().toString().substring(5, 7) + '/' +DateTime.now().toString().substring(0, 4) || bantu.toDate().isBefore(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day))) {
            showNotifIAStartAuditLead = true;
          } else {
            showNotifIAStartAuditLead = false;
          }
        });
      });
    });

    CollectionReference reference10 = Firestore.instance.collection('audit_internal');
    reference10.where('auditEnd', isNull: true).where('subAreaAuditor', arrayContains: widget.idUser).where('leadAuditorConfirm', isEqualTo: 'CONFIRM').where('auditeeConfirm', isEqualTo: 'CONFIRM').where('status', isEqualTo: 'ONGOING').snapshots().listen((querySnapshot10) {
      querySnapshot10.documentChanges.forEach((change10) {
        setState(() {
          Timestamp bantu = change10.document.data['dateAudite'];
          if (bantu.toDate().toString().substring(8, 10) + '/' + bantu.toDate().toString().substring(5, 7) + '/' +bantu.toDate().toString().substring(0, 4) == DateTime.now().toString().substring(8, 10) + '/' + DateTime.now().toString().substring(5, 7) + '/' +DateTime.now().toString().substring(0, 4) || bantu.toDate().isBefore(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day))) {
            showNotifIAStartAuditAuditor = true;
          } else {
            showNotifIAStartAuditAuditor = false;
          }
        });
      });
    });

    super.initState();
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
                'Home',
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
                  'Internal Audit',
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
                    onTap: () => Navigator.push(
                        context,
                        MyCustomRoute(
                            builder: (context) => FormCreateNew(departmentUser: widget.departmentUser, namaUser: widget.namaUser, idUser: widget.idUser))),
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
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            '',
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
                            MyCustomRoute(
                              builder: (context) => KonfirmasiAudit(departmentUser: widget.departmentUser, namaUser: widget.namaUser, idUser: widget.idUser)
                            )
                          );
                        },
                        child: Stack(
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.width * 0.09,
                              width: MediaQuery.of(context).size.width * 0.09,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/iso/qc.png',
                                  ),
                                  fit: BoxFit.cover
                                )
                              ),
                            ),
                            showNotifIAKonfirmasiLead
                              ? Positioned(
                                  top: 0.0,
                                  right: 0.0,
                                  child: Icon(
                                    Icons.brightness_1,
                                    size: 13.0,
                                    color: Colors.redAccent,
                                  ),
                                )
                              : Container(),
                            showNotifIAKonfirmasiAuditee
                              ? Positioned(
                                  top: 0.0,
                                  right: 0.0,
                                  child: Icon(
                                    Icons.brightness_1,
                                    size: 13.0,
                                    color: Colors.redAccent,
                                  ),
                                )
                              : Container(),
                            showNotifIAKonfirmasiAuditor
                              ? Positioned(
                                  top: 0.0,
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
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text('Konfirmasi',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12.0),
                            softWrap: false,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          '',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                        MyCustomRoute(
                          builder: (context) => new StartAudit(departmentUser: widget.departmentUser, namaUser: widget.namaUser, idUser: widget.idUser)
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
                            showNotifIAStartAuditAuditee
                              ? Positioned(
                                  top: 0.0,
                                  right: 0.0,
                                  child: Icon(
                                    Icons.brightness_1,
                                    size: 13.0,
                                    color: Colors.redAccent,
                                  ),
                                )
                              : Container(),
                            showNotifIAStartAuditAuditor
                              ? Positioned(
                                  top: 0.0,
                                  right: 0.0,
                                  child: Icon(
                                    Icons.brightness_1,
                                    size: 13.0,
                                    color: Colors.redAccent,
                                  ),
                                )
                              : Container(),
                            showNotifIAStartAuditLead
                              ? Positioned(
                                  top: 0.0,
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
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            'Start Audit',
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
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MyCustomRoute(
                            builder: (context) => FormAuditReport(departmentUser: widget.departmentUser, idUser: widget.idUser, namaUser: widget.namaUser,))),
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
                                        'assets/images/IT/report.png',
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
                            'Audit Report',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  /*GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MyCustomRoute(
                            builder: (context) => FormAuditSum())),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Stack(
                          overflow: Overflow.visible,
                          children: <Widget>[
                            Container(
                              height: 70.0,
                              width: 70.0,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border:
                                  Border.all(color: Colors.grey, width: 1.0),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(18.0))),
                            ),
                            Positioned(
                              bottom: 22.5,
                              left: 25.0,
                              child: Icon(MdiIcons.heart,
                                  size: 25.0, color: Colors.grey),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            'Audit',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            'Summary',
                            style: TextStyle(
                                fontSize: 12.0, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MyCustomRoute(
                            builder: (context) => FormAuditTeam())),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Stack(
                          overflow: Overflow.visible,
                          children: <Widget>[
                            Container(
                              height: 70.0,
                              width: 70.0,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border:
                                  Border.all(color: Colors.grey, width: 1.0),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(18.0))),
                            ),
                            Positioned(
                              bottom: 22.5,
                              left: 25.0,
                              child: Icon(MdiIcons.heart,
                                  size: 25.0, color: Colors.grey),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            'Audit Team',
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
                  ),*/
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
