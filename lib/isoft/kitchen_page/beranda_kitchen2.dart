import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/creative_page/form_comment.dart';
import 'package:flutter_abuba/creative_page/form_create.dart';
import 'package:flutter_abuba/creative_page/form_detail.dart';
import 'form_create.dart';
import 'report.dart';
import 'package:flutter_abuba/isoft/operation_page/changemanagement/beranda_management.dart';
import 'package:flutter_abuba/isoft/operation_page/correctiveaction/beranda_corrective.dart';
import 'package:flutter_abuba/isoft/operation_page/internalaudit/beranda_audit.dart';
import 'package:flutter_abuba/isoft/operation_page/kpimonitoring/kpi_monitoring_beranda.dart';
import 'package:flutter_abuba/isoft/operation_page/meeting/beranda_meeting.dart';
import 'package:flutter_abuba/whats_page/form_comment.dart';
import 'package:flutter_abuba/whats_page/form_create_happening.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_abuba/isoft/operation_page/riskassesment/beranda_risk_register.dart';
import 'package:flutter_abuba/isoft/operation_page/documentcontrol/beranda_document.dart';
import 'package:flutter_abuba/isoft/operation_page/workinginstruction/beranda_working.dart';

class MenuKitchen extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;

  MenuKitchen({this.idUser, this.namaUser, this.departmentUser});
  @override
  _MenuKitchenState createState() => _MenuKitchenState();
}

class _MenuKitchenState extends State<MenuKitchen> with TickerProviderStateMixin {
  AnimationController animationController;

  List<String> department = [
    'Procurement',
    'FAT',
    'IA',
    'BD',
    'HRD',
    'IT',
    'BOD',
    'IA',
    'OPR',
  ];

  List<String> nama = [
    'Inne Rettiani',
    'Dewi Kurniasih',
    'Indah',
    'Andi Lala',
    'Rizal Baydillah',
    'Sony Ramdhani Tahir',
    'M. Ali Ariansyah',
    'Ade Ridwan',
    'Rahmat Yasir',
  ];

  List<String> gambar = [
    'inne.jpeg',
    'Ibu DEWI KURNIASIH - FAT MANAGER.png',
    'INDAH.jpeg',
    'Pak ANDI LALA - BUSINESS DEVELOPMENT MANAGER.jpeg',
    'Pak RIZAL BAYDILLAH - HRD MANAGER.jpeg',
    'Pak SONNY RAMADHAN - IT ASST. MANAGER.jpg',
    'DIRUT (2).jpg',
    'Pak ADE RIDWAN - INTERNAL AUDIT MANAGER.jpeg',
    'Pak YASIR - OPERASIONAL MANAGER.jpeg',
  ];
  
  List<bool> _alreadyOKHappening = [false, false, true];
  List<int> _counterOKHappening = [200, 150, 500];
  List<bool> _likeHappening = [false, true, false];
  List<int> _counterLikeHappening = [0, 20, 100];

  List<bool> _likeIdea = [false, true, false];
  List<int> _counterLikeIdea = [0, 20, 100];
  List<int> _counterViewIdea = [100, 50, 33];

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(
        from: animationController.value == 0.0
            ? 1.0
            : animationController.value
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Color(0xfff9f9f9),),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.25,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Text('Kitchen', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black),),
                ),
                Stack(
                  children: <Widget>[
                    Icon(Icons.notifications, color: Colors.grey[400],)
                  ],
                )
              ],
            ),
          ),
          body: _buildAbubaMenu(),
        ),
      ),
    );
  }

  Widget _buildAbubaMenu() {
    return Scrollbar(
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 15.0,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            height: 100.0,
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 0.1,
              crossAxisSpacing: 0.1,
              childAspectRatio: 1.8,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MyCustomRoute(
                            builder: (context) => FormCreateKitchen(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)));
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
                                    'assets/images/hrd/create new2.png',
                                    width: 30.0,
                                    height: 30.0,
                                  ),
                                ),
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
                              'Create',
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
                    Navigator.push(
                        context,
                        MyCustomRoute(
                            builder: (context) => KitchenReport(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)));
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
                              'Report',
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
          ),
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
    );
  }
}