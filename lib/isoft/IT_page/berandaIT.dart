import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/isoft/IT_page/maintenance/berandamaintenance.dart';
import 'package:flutter_abuba/isoft/IT_page/perbaikan/berandaperbaikan.dart';
import 'package:flutter_abuba/isoft/operation_page/changemanagement/beranda_management.dart';
import 'package:flutter_abuba/isoft/operation_page/correctiveaction/beranda_corrective.dart';
import 'package:flutter_abuba/isoft/operation_page/documentcontrol/beranda_document.dart';
import 'package:flutter_abuba/isoft/operation_page/internalaudit/beranda_audit.dart';
import 'package:flutter_abuba/isoft/operation_page/meeting/beranda_meeting.dart';
import 'package:flutter_abuba/isoft/operation_page/riskassesment/beranda_risk_register.dart';
import 'package:flutter_abuba/isoft/operation_page/workinginstruction/beranda_working.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_abuba/launcher/launcher_view.dart';

class MenuIT extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;

  MenuIT({this.idUser, this.namaUser, this.departmentUser});
  @override
  _MenuITState createState() => _MenuITState();
}

class _MenuITState extends State<MenuIT> with TickerProviderStateMixin {
  AnimationController animationController;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String userNama = 'User Name';

  Future<FirebaseUser> getUser() async {
    return await _auth.currentUser();
  }

  bool showNotifMeetingOpenStatus = false;
  bool showNotifMeetingCheckIn = false;
  bool showNotifChangeMgmtReview = false;
  bool showNotifChangeMgmtApproval = false;
  bool showNotifIAKonfirmasiLead = false;
  bool showNotifIAKonfirmasiAuditee = false;
  bool showNotifIAKonfirmasiAuditor = false;
  bool showNotifIAStartAuditLead = false;
  bool showNotifIAStartAuditAuditee = false;
  bool showNotifIAStartAuditAuditor = false;
  bool showNotifMaintenanceTLToday = false;
  bool showNotifMaintenanceTLSkip = false;
  bool showNotifMaintenanceTLReschedule = false;
  bool showNotifPerbaikanWO = false;

  int managerIT;
  int asManagerIT;

  @override
  void initState() {
    CollectionReference reference = Firestore.instance.collection('minutesMeeting');
    reference.where('status', isEqualTo: 'CLOSE').where('picIDNotulen', arrayContains: widget.idUser).snapshots().listen((querySnapshot) {
      querySnapshot.documentChanges.forEach((change) {
        setState(() {
          int indexPIC = change.document.data['picIDNotulen'].indexOf(widget.idUser);
          if (change.document.data['statusActionPlan'][indexPIC] == 'OPEN') {
            showNotifMeetingOpenStatus = true;
          } else {
            showNotifMeetingOpenStatus = false;
          }
        });
      });
    });

    CollectionReference reference2 = Firestore.instance.collection('minutesMeeting');
    reference2.where('status', isEqualTo: 'OPEN').where('pesertaID', arrayContains: widget.idUser).snapshots().listen((querySnapshot2) {
      querySnapshot2.documentChanges.forEach((change2) {
        setState(() {
          Timestamp bantu = change2.document.data['dateMeeting'];
          if (bantu.toDate().toString().substring(8, 10) + '/' + bantu.toDate().toString().substring(5, 7) + '/' +bantu.toDate().toString().substring(0, 4) == DateTime.now().toString().substring(8, 10) + '/' + DateTime.now().toString().substring(5, 7) + '/' +DateTime.now().toString().substring(0, 4)) {
            int indexPIC = change2.document.data['pesertaID'].indexOf(widget.idUser);
            if (change2.document.data['checkOutPeserta'][indexPIC] == null) {
              showNotifMeetingCheckIn = true;
            } else {
              showNotifMeetingCheckIn = false;
            }
          } else {
            showNotifMeetingCheckIn = false;
          }
        });
      });
    });

    CollectionReference reference3 = Firestore.instance.collection('changeMgmt');
    reference3.where('personReview', arrayContains: widget.idUser).where('statusApprove', isEqualTo: false).where('finalStatus', isEqualTo: 'OPEN').snapshots().listen((querySnapshot3) {
      querySnapshot3.documentChanges.forEach((change3) {
        setState(() {
          int indexPIC = change3.document.data['personReview'].indexOf(widget.idUser);
          if (change3.document.data['personReviewStatus'][indexPIC] == 'OPEN') {
            showNotifChangeMgmtReview = true;
          } else {
            showNotifChangeMgmtReview = false;
          }
        });
      });
    });

    CollectionReference reference4 = Firestore.instance.collection('changeMgmt');
    reference4.where('approveBy', isEqualTo: widget.idUser).where('finalStatus', isEqualTo: 'OPEN').snapshots().listen((querySnapshot4) {
      querySnapshot4.documentChanges.forEach((change4) {
        setState(() {
          if (change4.document.data['personReviewStatus'].contains('OPEN') == false) {
            showNotifChangeMgmtApproval = true;
          } else {
            showNotifChangeMgmtApproval = false;
          }
        });
      });
    });

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

    Firestore.instance.collection('user').where('grade', isEqualTo: 'Manager').where('department', isEqualTo: 'IT').snapshots().listen((data3) {
      setState(() {
        managerIT = data3.documents[0].data['id'];
      });
    });

    Firestore.instance.collection('user').where('grade', isEqualTo: 'Assistant Manager').where('department', isEqualTo: 'IT').snapshots().listen((data4) {
      setState(() {
        asManagerIT = data4.documents[0].data['id'];
      });
    });

    CollectionReference reference14 = Firestore.instance.collection('perbaikanIT');
    reference14.where('status', isEqualTo: 'NOT READY').snapshots().listen((querySnapshot14) {
      querySnapshot14.documentChanges.forEach((change14) {
        setState(() {
          if (managerIT == widget.idUser || asManagerIT == widget.idUser) {
            showNotifPerbaikanWO = true;
          } else {
            showNotifPerbaikanWO = false;
          }
        });
      });
    });

    getUser().then((user) {
      if (user != null) {
        Firestore.instance.collection('user').where('email', isEqualTo: user.email).snapshots().listen((data) {
          setState(() {
            userNama = data.documents[0].data['nama'];
          });
        });
      }
    });

    animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(from: animationController.value == 0.0 ? 1.0 : animationController.value);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Color(0xfff9f9f9),),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xfff9f9f9),
          body: Scrollbar(
            child: ListView(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  verticalDirection: VerticalDirection.down,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  PopupMenuButton(
                                    child: Container(
                                      width: 40.0,
                                      height: 40.0,
                                      decoration: new BoxDecoration(
                                          color: AbubaPallate.greenabuba,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 3.0,
                                          ),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  'https://image.flaticon.com/icons/png/512/149/149071.png'),
                                              fit: BoxFit.cover)),
                                    ),
                                    elevation: 3.2,
                                    onCanceled: () {},
                                    tooltip: 'Tooltip',
                                    onSelected: (val) {
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: Text('Are you sure?'),
                                            content: Text(
                                                'Do you want to sign out ?'),
                                            actions: <Widget>[
                                              FlatButton(
                                                onPressed: () =>
                                                    Navigator.of(context)
                                                        .pop(false),
                                                child: Text('No'),
                                              ),
                                              FlatButton(
                                                onPressed: () async {
                                                  await _auth
                                                      .signOut()
                                                      .then((_) {
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                LoginPage()));
                                                  });
                                                },
                                                child: Text('Yes'),
                                              )
                                            ],
                                          ));
                                    },
                                    itemBuilder: (BuildContext context) {
                                      return [
                                        PopupMenuItem(
                                          value: 'signout',
                                          child: Text('Sign Out'),
                                        )
                                      ];
                                    },
                                  ),
                                  Flexible(
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0,
                                              right: 5.0,
                                              bottom: 2.5),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Hello,',
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      color: Colors.black54,
                                                      letterSpacing: 1.0),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0,
                                              right: 5.0,
                                              bottom: 0.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  widget.namaUser ?? '-',
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Stack(
                                    children: <Widget>[
                                      Icon(Icons.notifications, color: Colors.grey[400],)
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25.0),
                        bottomRight: Radius.circular(5.0),
                        topRight: Radius.circular(5.0),
                        topLeft: Radius.circular(5.0),
                      ),
                    ),
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Stack(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/Line_graph.png',
                          fit: BoxFit.fill,
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Your Performance',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                              Text(
                                '90%',
                                style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    elevation: 5.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // maintenance
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MyCustomRoute(
                                  builder: (context) => BerandaMaintenance(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser))),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                                topLeft: Radius.circular(10.0),
                              ),
                            ),
                            elevation: 5.0,
                            child: Container(
                              width: 150.0,
                              margin: EdgeInsets.symmetric(vertical: 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Stack(
                                    overflow: Overflow.visible,
                                    children: <Widget>[
                                      Center(
                                        child: Image.asset(
                                          'assets/images/IT/maintenanceIT.png',
                                          width: 45.0,
                                          height: 45.0,
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
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Flexible(
                                          child: Text(
                                        'Maintenance',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400),
                                      ))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // perbaikan
                        GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MyCustomRoute(
                                  builder: (context) => BerandaPerbaikan(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser))),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                                topLeft: Radius.circular(10.0),
                              ),
                            ),
                            elevation: 5.0,
                            child: Container(
                              width: 150.0,
                              margin: EdgeInsets.symmetric(vertical: 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Stack(
                                    overflow: Overflow.visible,
                                    children: <Widget>[
                                      Center(
                                        child: Image.asset(
                                          'assets/images/IT/maintenanceIT.png',
                                          width: 45.0,
                                          height: 45.0,
                                        ),
                                      ),
                                      showNotifPerbaikanWO
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
                                      StreamBuilder(
                                        stream: Firestore.instance.collection('perbaikanIT').where('userVerifikasi', isEqualTo: widget.idUser).where('statusPerbaikan', isEqualTo: 'CLOSE').snapshots(),
                                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                          if (snapshot.data == null) return Container();

                                          if (snapshot.data.documents.length == 0) {
                                            return Container();
                                          } else {
                                            return Positioned(
                                              top: -7.0,
                                              right: 0.0,
                                              child: Icon(
                                                Icons.brightness_1,
                                                size: 13.0,
                                                color: Colors.redAccent,
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                      StreamBuilder(
                                        stream: Firestore.instance.collection('perbaikanIT').where('pic', isEqualTo: widget.idUser).where('status', isEqualTo: 'OPEN').snapshots(),
                                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                          if (snapshot.data == null) return Container();

                                          if (snapshot.data.documents.length == 0) {
                                            return Container();
                                          } else {
                                            return Positioned(
                                              top: -7.0,
                                              right: 0.0,
                                              child: Icon(
                                                Icons.brightness_1,
                                                size: 13.0,
                                                color: Colors.redAccent,
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Flexible(
                                          child: Text('Perbaikan',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400)))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 15.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text("ISO", style: TextStyle(color: Colors.black38,fontWeight: FontWeight.w500),),
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
                            MyCustomRoute(
                              builder: (context) => MenuAudit(departmentUser: widget.departmentUser, namaUser: widget.namaUser, idUser: widget.idUser)
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
                                        'assets/images/iso/internal audit2.png',
                                        width: 30.0,
                                        height: 30.0,
                                      ),
                                    ),
                                    StreamBuilder(
                                      stream: Firestore.instance.collection('audit_internal').where('auditEnd', isNull: true).where('leadAuditor', isEqualTo: widget.idUser).where('leadAuditorConfirm', isEqualTo: widget.idUser).snapshots(),
                                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (snapshot.data == null) return Container();

                                        if (snapshot.data.documents.length == 0) {
                                          return Container();
                                        } else {
                                          return Positioned(
                                            top: -7.0,
                                            right: 0.0,
                                            child: Icon(
                                              Icons.brightness_1,
                                              size: 13.0,
                                              color: Colors.redAccent,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                    StreamBuilder(
                                      stream: Firestore.instance.collection('audit_internal').where('auditEnd', isNull: true).where('auditee', isEqualTo: widget.idUser).where('auditeeConfirm', isEqualTo: widget.idUser).snapshots(),
                                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (snapshot.data == null) return Container();

                                        if (snapshot.data.documents.length == 0) {
                                          return Container();
                                        } else {
                                          return Positioned(
                                            top: -7.0,
                                            right: 0.0,
                                            child: Icon(
                                              Icons.brightness_1,
                                              size: 13.0,
                                              color: Colors.redAccent,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                    StreamBuilder(
                                      stream: Firestore.instance.collection('audit_internal').where('auditEnd', isNull: true).where('auditorConfirm', arrayContains: widget.idUser.toString()).snapshots(),
                                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (snapshot.data == null) return Container();

                                        if (snapshot.data.documents.length == 0) {
                                          return Container();
                                        } else {
                                          return Positioned(
                                            top: -7.0,
                                            right: 0.0,
                                            child: Icon(
                                              Icons.brightness_1,
                                              size: 13.0,
                                              color: Colors.redAccent,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                    showNotifIAStartAuditAuditee
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
                                    showNotifIAStartAuditAuditor
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
                                    showNotifIAStartAuditLead
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
                              )
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Internal Audit',
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
                            MyCustomRoute(
                              builder: (context) => MenuCorrective(departmentUser: widget.departmentUser, namaUser: widget.namaUser, idUser: widget.idUser)
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
                                        'assets/images/iso/corrective action2.png',
                                        width: 30.0,
                                        height: 30.0,
                                      ),
                                    ),
                                    StreamBuilder(
                                      stream: Firestore.instance.collection('correctiveAction').where('userCreated', isEqualTo: widget.idUser).where('status', isEqualTo: 'DONE').snapshots(),
                                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (snapshot.data == null) return Container();

                                        if (snapshot.data.documents.length == 0) {
                                          return Container();
                                        } else {
                                          return Positioned(
                                            top: -7.0,
                                            right: 0.0,
                                            child: Icon(
                                              Icons.brightness_1,
                                              size: 13.0,
                                              color: Colors.redAccent,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                    StreamBuilder(
                                      stream: Firestore.instance.collection('correctiveAction').where('category', isEqualTo: 1).where('userDituju', isEqualTo: widget.idUser).where('status', isEqualTo: 'OPEN').snapshots(),
                                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (snapshot.data == null) return Container();

                                        if (snapshot.data.documents.length == 0) {
                                          return Container();
                                        } else {
                                          return Positioned(
                                            top: -7.0,
                                            right: 0.0,
                                            child: Icon(
                                              Icons.brightness_1,
                                              size: 13.0,
                                              color: Colors.redAccent,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                    StreamBuilder(
                                      stream: Firestore.instance.collection('correctiveAction').where('category', isEqualTo: 1).where('userDituju', isEqualTo: widget.idUser).where('status', isEqualTo: 'ONGOING').snapshots(),
                                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (snapshot.data == null) return Container();

                                        if (snapshot.data.documents.length == 0) {
                                          return Container();
                                        } else {
                                          return Positioned(
                                            top: -7.0,
                                            right: 0.0,
                                            child: Icon(
                                              Icons.brightness_1,
                                              size: 13.0,
                                              color: Colors.redAccent,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                    StreamBuilder(
                                      stream: Firestore.instance.collection('correctiveAction').where('category', isEqualTo: 1).where('userDituju', isEqualTo: widget.idUser).where('status', isEqualTo: 'DONE').snapshots(),
                                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (snapshot.data == null) return Container();

                                        if (snapshot.data.documents.length == 0) {
                                          return Container();
                                        } else {
                                          return Positioned(
                                            top: -7.0,
                                            right: 0.0,
                                            child: Icon(
                                              Icons.brightness_1,
                                              size: 13.0,
                                              color: Colors.redAccent,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                    StreamBuilder(
                                      stream: Firestore.instance.collection('correctiveAction').where('category', isEqualTo: 2).where('userDituju', isEqualTo: widget.idUser).where('status', isEqualTo: 'OPEN').snapshots(),
                                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (snapshot.data == null) return Container();

                                        if (snapshot.data.documents.length == 0) {
                                          return Container();
                                        } else {
                                          return Positioned(
                                            top: -7.0,
                                            right: 0.0,
                                            child: Icon(
                                              Icons.brightness_1,
                                              size: 13.0,
                                              color: Colors.redAccent,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                )
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
                                    'Corrective Action',
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
                            MyCustomRoute(
                              builder: (context) => BerandaRiskRegister(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)
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
                                        'assets/images/iso/risk assesment2.png',
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
                                    'Risk Assesment',
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
                            MyCustomRoute(
                              builder: (context) => MenuMeeting(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)
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
                                        'assets/images/iso/minute of meeting2.png',
                                        width: 30.0,
                                        height: 30.0,
                                      ),
                                    ),
                                    showNotifMeetingCheckIn
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
                                    showNotifMeetingOpenStatus
                                      ? Positioned(
                                          top: -7.0,
                                          right: 0.0,
                                          child: Icon(
                                            Icons.brightness_1,
                                            size: 13.0,
                                            color: Colors.redAccent,
                                          ),
                                        )
                                      : Container()
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
                                    'Minute of Meeting',
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
                            MyCustomRoute(
                              builder: (context) => BerandaDocument(departmentUser: widget.departmentUser, namaUser: widget.namaUser, idUser: widget.idUser)
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
                                        'assets/images/iso/document control2.png',
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
                                    'Document Control',
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
                            MyCustomRoute(
                              builder: (context) => BerandaWorking(departmentUser: widget.departmentUser, namaUser: widget.namaUser, idUser: widget.idUser),
                            ),
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
                                        'assets/images/iso/daily checklist2.png',
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
                                    'Working Instruction',
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
                            MyCustomRoute(
                              builder: (context) => BerandaManagement(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)
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
                                        'assets/images/iso/change management2.png',
                                        width: 30.0,
                                        height: 30.0,
                                      ),
                                    ),
                                    showNotifChangeMgmtReview
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
                                    showNotifChangeMgmtApproval
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
                                    'Change Management',
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
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
