import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/isoft/hrd_page/maintenance/berandamaintenance.dart';
import 'package:flutter_abuba/isoft/hrd_page/perbaikan/berandaperbaikan.dart';
import 'package:flutter_abuba/isoft/operation_page/changemanagement/beranda_management.dart';
import 'package:flutter_abuba/isoft/operation_page/correctiveaction/beranda_corrective.dart';
import 'package:flutter_abuba/isoft/operation_page/internalaudit/beranda_audit.dart';
import 'package:flutter_abuba/isoft/operation_page/meeting/beranda_meeting.dart';
import 'package:flutter_abuba/isoft/operation_page/workinginstruction/beranda_working.dart';
import 'package:flutter_abuba/isoft/operation_page/documentcontrol/beranda_document.dart';
import 'package:flutter_abuba/isoft/operation_page/riskassesment/beranda_risk_register.dart';
import 'package:flutter/services.dart';
import 'package:flutter_abuba/isoft/hrd_page/medical/menu_medical.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MenuHRD extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;

  MenuHRD({this.idUser, this.namaUser, this.departmentUser});

  @override
  _MenuHRDState createState() => _MenuHRDState();
}

class _MenuHRDState extends State<MenuHRD> with TickerProviderStateMixin {
  AnimationController animationController;

  final FirebaseAuth _auth = FirebaseAuth.instance;

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

  String userNama = 'User Name';

  Future<FirebaseUser> getUser() async {
    return await _auth.currentUser();
  }

  @override
  void initState() {
    super.initState();
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
        child: WillPopScope(
          onWillPop: () {
            Navigator.pop(context);
          },
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
                                    Flexible(
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0,
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
                                                        fontSize: 16.0,
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
                                                left: 5.0,
                                                right: 5.0,
                                                bottom: 0.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    widget.namaUser,
                                                    style: TextStyle(
                                                      fontSize: 18.0,
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
                                    GestureDetector(
                                      onTap: () {},
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
                                    ),
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
                                width: MediaQuery.of(context).size.width * 0.4,
                                margin: EdgeInsets.symmetric(vertical: 10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/images/hrd/maintenance2.png',
                                      width: 45.0,
                                      height: 45.0,
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
                                width: MediaQuery.of(context).size.width * 0.4,
                                margin: EdgeInsets.symmetric(vertical: 10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/images/hrd/perbaikan2.png',
                                      width: 45.0,
                                      height: 45.0,
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
                        /*Column(
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
                                    'assets/images/iso/kpi2.png',
                                    width: 35.0,
                                    height: 35.0,
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
                                    'KPI Monitoring',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400, color: Colors.grey),
                                    textAlign: TextAlign.center,
                                  ),
                              )
                            ],
                          ),
                        ],
                      ),*/
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
                                          stream: Firestore.instance.collection('audit_internal').where('leadAuditor', isEqualTo: widget.idUser).where('leadAuditorConfirm', isEqualTo: widget.idUser).where('auditEnd', isNull: true).snapshots(),
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
                                          stream: Firestore.instance.collection('audit_internal').where('leadAuditor', isEqualTo: widget.idUser).where('auditee', isEqualTo: widget.idUser).where('auditEnd', isNull: true).snapshots(),
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
                                          stream: Firestore.instance.collection('audit_internal').where('leadAuditor', isEqualTo: widget.idUser).where('subAreaAuditor', arrayContains: widget.idUser).where('auditEnd', isNull: true).snapshots(),
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
                                          stream: Firestore.instance.collection('audit_internal').where('status', isEqualTo: 'ONGOING').where('auditEnd', isNull: true).where('dateAudit', isLessThanOrEqualTo: DateTime.now()).snapshots(),
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
                                      StreamBuilder(
                                        stream: Firestore.instance.collection('minutesMeeting').where('status', isEqualTo: 'OPEN').where('dateMeeting', isEqualTo: DateTime.now()).snapshots(),
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
                                        stream: Firestore.instance.collection('minutesMeeting').where('status', isEqualTo: 'ONGOING').where('dateMeeting', isEqualTo: DateTime.now()).snapshots(),
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
                                        stream: Firestore.instance.collection('minutesMeeting').where('status', isEqualTo: 'CLOSE').where('picIDNotulen', arrayContains: widget.idUser).snapshots(),
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
                                      StreamBuilder(
                                        stream: Firestore.instance.collection('changeMgmt').where('approveBy', isEqualTo: widget.idUser).where('finalStatus', isEqualTo: 'OPEN').snapshots(),
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
                                        stream: Firestore.instance.collection('changeMgmt').where('personReview', arrayContains: widget.idUser).snapshots(),
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
      ),
    );
  }
}
