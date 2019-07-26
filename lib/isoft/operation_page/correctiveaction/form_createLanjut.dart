import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/isoft/operation_page/correctiveaction/car_nonIA.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:search_widget/search_widget.dart';

class LeaderBoard {
  final String name;
  final int id;

  LeaderBoard(this.name, this.id);
}

class FormCreateLanjutan extends StatefulWidget {
  FormCreateLanjutan({this.idUser, this.namaUser, this.departmentUser, this.status, this.index});

  final int idUser;
  final String namaUser;
  final String departmentUser;
  final String status;
  var index;

  @override
  _FormCreateLanjutanState createState() => _FormCreateLanjutanState();
}

class _FormCreateLanjutanState extends State<FormCreateLanjutan> with TickerProviderStateMixin {
  TabController _tabController;
  AnimationController animationController;
  bool _isProccess = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  final List<Tab> internalAuditTabs = <Tab>[
    new Tab(child: Text('Problem', style: TextStyle(color: Colors.grey[400]))),
    new Tab(child: Text('Root Cause', style: TextStyle(color: Colors.grey[400]))),
    new Tab(child: Text('Correction',style: TextStyle(color: Colors.grey[400]))),
    new Tab(child:Text('Action Plan', style: TextStyle(color: Colors.grey[400]))),
  ];

  int carNo;
  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime dateStart;
  DateTime dateEnd;
  DateTime dateSchedule;
  String rootCause;
  TextEditingController remarksRootCause =TextEditingController();
  TextEditingController immediateAction =TextEditingController();
  DateTime dateImmediate;
  TextEditingController rekomendasi =TextEditingController();
  DateTime dueDate;

  String category;
  String problem;
  String when;
  String departmentWhere;
  String divisiWhere;
  String areaWhere;
  String howSevere;
  String remarksProblem = '';
  String status;
  String userCreated;
  String departmentCreated;

  String rootCauseView;
  String remarksRootCauseView;
  String immediateActionView;
  String dateImmediateView;
  String recommendationView;
  String duedateView;

  String imageCAR;
  String imageCARSave;
  File imageCAR1;
  String filenameCAR1;
  bool prosesUpload = false;

  List<LeaderBoard> listRootCause = <LeaderBoard>[];
  int selectedRootCause;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: internalAuditTabs.length);

    Firestore.instance.collection('correctiveAction').document(widget.index).snapshots().listen((data) {
      setState(() {
        carNo = data.data['carNo'];
        problem = data.data['problem'];
        if (data.data['remarksProblem'] == "") {
          remarksProblem = '-';
        } else {
          remarksProblem = data.data['remarksProblem'];
        }
        status = data.data['status'];
        Timestamp whenBantu = data.data['when'];
        when = whenBantu.toDate().toString().substring(8, 10) + '/' + whenBantu.toDate().toString().substring(5, 7) + '/' + whenBantu.toDate().toString().substring(0, 4);
        departmentWhere = data.data['departmentWhere'];
        divisiWhere = data.data['divisiWhere'];
        areaWhere = data.data['areaWhere'];
        howSevere = data.data['howSevere'];


        if (data.data['status'] != 'OPEN') {
          if (data.data['remarksRootCause'] == "") {
            remarksRootCauseView = '-';
          } else {
            remarksRootCauseView = data.data['remarksRootCause'];
          }
          immediateActionView = data.data['immediateAction'];
          Timestamp dateImmediateViewBantu = data.data['immediateDate'];
          dateImmediateView = dateImmediateViewBantu.toDate().toString().substring(8, 10) + '/' + dateImmediateViewBantu.toDate().toString().substring(5, 7) + '/' + dateImmediateViewBantu.toDate().toString().substring(0, 4);
          recommendationView = data.data['recommendationAction'];
          Timestamp duedateViewBantu = data.data['dueDate'];
          duedateView = duedateViewBantu.toDate().toString().substring(8, 10) + '/' + duedateViewBantu.toDate().toString().substring(5, 7) + '/' + duedateViewBantu.toDate().toString().substring(0, 4);

          Firestore.instance.collection('correctiveAction_rootCause').where('id', isEqualTo: data.data['rootCause']).snapshots().listen((data4) {
            rootCauseView = data4.documents[0].data['root_cause'];
          });
        } else {
          remarksRootCauseView = '';
          immediateActionView = '';
          dateImmediateView = '';
          recommendationView = '';
          duedateView = '';
          rootCauseView = '';
        }

        Firestore.instance.collection('correctiveAction_category').where('id', isEqualTo: data.data['category']).snapshots().listen((data2) {
          category = data2.documents[0].data['category'];
        });

        Firestore.instance.collection('user').where('id', isEqualTo: data.data['userCreated']).snapshots().listen((data3) {
          userCreated = data3.documents[0].data['nama'];
          departmentCreated = data3.documents[0].data['department'];
        });
      });
    });

    animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(
      from: animationController.value == 0.0
        ? 1.0
        : animationController.value
    );

    CollectionReference reference4 = Firestore.instance.collection('correctiveAction_rootCause');
    reference4.orderBy('root_cause', descending: false).snapshots().listen((data2) {
      data2.documentChanges.forEach((change4) {
        setState(() {
          listRootCause.add(LeaderBoard(change4.document.data['root_cause'], change4.document.data['id']));
        });
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _appBar() {
    return AppBar(
      elevation: 0.25,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.asset(
            'assets/images/logo2.png',
            height: 150.0,
            width: 120.0,
          ),
          new Container(
            child: new Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Text(
                    'CAR-${carNo.toString().padLeft(4, '0')}',
                    style: TextStyle(fontSize: 14.0, color: Colors.black54, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      bottom: new TabBar(
        controller: _tabController,
        isScrollable: true,
        onTap: null,
        indicatorColor: AbubaPallate.greenabuba,
        tabs: internalAuditTabs,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: internalAuditTabs.length,
        child: Scaffold(
          appBar: _appBar(),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Form(
              autovalidate: _autoValidate,
              key: _formKey,
              child: AnimatedBuilder(
                animation: animationController,
                builder: (_, Widget child) {
                  return animationController.isAnimating
                    ? Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        controller: _tabController,
                        children: <Widget>[
                          ListView(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  padding: const EdgeInsets.only(top: 15.0),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: Colors.grey, width: 1.0)
                                    )
                                  ),
                                  child:  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.35,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Category',
                                                  style: TextStyle(
                                                      fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.35,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  category,
                                                  style: TextStyle(
                                                      fontSize: 13.0,
                                                      color: Colors.black38,
                                                      fontWeight: FontWeight.w700
                                                  ),
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
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  padding: const EdgeInsets.only(top: 15.0),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: Colors.grey, width: 1.0)
                                    )
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.35,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Problem',
                                                  style: TextStyle(
                                                      fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.35,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  problem,
                                                  style: TextStyle(
                                                      fontSize: 13.0,
                                                      color: Colors.black38,
                                                      fontWeight: FontWeight.w700
                                                  ),
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
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  padding: const EdgeInsets.only(top: 15.0),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: Colors.grey, width: 1.0)
                                    )
                                  ),
                                  child:  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.35,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'When',
                                                  style: TextStyle(
                                                      fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.35,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  when,
                                                  style: TextStyle(
                                                      fontSize: 13.0,
                                                      color: Colors.black38,
                                                      fontWeight: FontWeight.w700
                                                  ),
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
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  padding: const EdgeInsets.only(top: 15.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(color: Colors.grey, width: 1.0)
                                      )
                                  ),
                                  child:  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.35,
                                            child: Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Department',
                                                    style: TextStyle(
                                                        fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.35,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    departmentWhere,
                                                    style: TextStyle(
                                                        fontSize: 13.0,
                                                        color: Colors.black38,
                                                        fontWeight: FontWeight.w700
                                                    ),
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
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  padding: const EdgeInsets.only(top: 15.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(color: Colors.grey, width: 1.0)
                                      )
                                  ),
                                  child:  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.35,
                                            child: Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Divisi',
                                                    style: TextStyle(
                                                        fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.35,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    divisiWhere,
                                                    style: TextStyle(
                                                        fontSize: 13.0,
                                                        color: Colors.black38,
                                                        fontWeight: FontWeight.w700
                                                    ),
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
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  padding: const EdgeInsets.only(top: 15.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(color: Colors.grey, width: 1.0)
                                      )
                                  ),
                                  child:  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.35,
                                            child: Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Area',
                                                    style: TextStyle(
                                                        fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.35,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    areaWhere,
                                                    style: TextStyle(
                                                        fontSize: 13.0,
                                                        color: Colors.black38,
                                                        fontWeight: FontWeight.w700
                                                    ),
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
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  padding: const EdgeInsets.only(top: 15.0),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: Colors.grey, width: 1.0)
                                    )
                                  ),
                                  child:  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child:
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.35,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'How Severe : ',
                                                  style: TextStyle(
                                                      fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.35,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  howSevere,
                                                  style: TextStyle(fontSize: 13.0, color: howSevere == 'High' ? Colors.redAccent : howSevere == 'Medium' ? Colors.orangeAccent : Colors.green, fontWeight: FontWeight.w700),
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
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  padding: const EdgeInsets.only(top: 15.0),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: Colors.grey, width: 1.0)
                                    )
                                  ),
                                  child:  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.35,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Remarks',
                                                  style: TextStyle(
                                                      fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.35,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  remarksProblem,
                                                  style: TextStyle(
                                                      fontSize: 13.0,
                                                      color: Colors.black38,
                                                      fontWeight: FontWeight.w700
                                                  ),
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 10.0, right: 20.0),
                                    child: ButtonTheme(
                                      minWidth: 50.0,
                                      height: 30.0,
                                      child: OutlineButton(
                                        child: Text(
                                          'NEXT',
                                          style: TextStyle(
                                              fontSize: 13.0, color: Colors.blue),
                                        ),
                                        borderSide:
                                            BorderSide(color: Colors.blue, width: 1.0),
                                        highlightedBorderColor: Colors.blue,
                                        onPressed: () {
                                          _tabController
                                              .animateTo((_tabController.index + 1) % 2);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          status != 'OPEN'
                            ? ListView(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      padding: const EdgeInsets.only(top: 15.0),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(color: Colors.grey, width: 1.0)
                                        )
                                      ),
                                      child:  Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.35,
                                              child: Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      'Root Cause',
                                                      style: TextStyle(
                                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.35,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      rootCauseView,
                                                      style: TextStyle(
                                                          fontSize: 13.0,
                                                          color: Colors.black38,
                                                          fontWeight: FontWeight.w700
                                                      ),
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
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      padding: const EdgeInsets.only(top: 15.0),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(color: Colors.grey, width: 1.0)
                                        )
                                      ),
                                      child:  Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.35,
                                              child: Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      'Remarks',
                                                      style: TextStyle(
                                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.35,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      remarksRootCauseView,
                                                      style: TextStyle(
                                                          fontSize: 13.0,
                                                          color: Colors.black38,
                                                          fontWeight: FontWeight.w700
                                                      ),
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                                        child: ButtonTheme(
                                          minWidth: 50.0,
                                          height: 30.0,
                                          child: OutlineButton(
                                            child: Text(
                                              'PREV',
                                              style: TextStyle(
                                                  fontSize: 13.0, color: Colors.grey),
                                            ),
                                            borderSide:
                                                BorderSide(color: Colors.grey, width: 1.0),
                                            highlightedBorderColor: Colors.grey,
                                            onPressed: () {
                                              _tabController
                                                  .animateTo((_tabController.index - 1));
                                            },
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0, right: 20.0),
                                        child: ButtonTheme(
                                          minWidth: 50.0,
                                          height: 30.0,
                                          child: OutlineButton(
                                            child: Text(
                                              'NEXT',
                                              style: TextStyle(
                                                  fontSize: 13.0, color: Colors.blue),
                                            ),
                                            borderSide:
                                                BorderSide(color: Colors.blue, width: 1.0),
                                            highlightedBorderColor: Colors.blue,
                                            onPressed: () {
                                              _tabController
                                                  .animateTo((_tabController.index + 1));
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            : ListView(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                    child: SearchWidget<LeaderBoard>(
                                      dataList: listRootCause,
                                      hideSearchBoxWhenItemSelected: true,
                                      listContainerHeight: MediaQuery.of(context).size.height / 4,
                                      queryBuilder: (String query, List<LeaderBoard> list) {
                                        return list.where((LeaderBoard item) => item.name.toLowerCase().contains(query.toLowerCase())).toList();
                                      },
                                      popupListItemBuilder: (LeaderBoard item) {
                                        return Container(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(
                                            item.name,
                                            style: TextStyle(fontSize: 16.0),
                                          ),
                                        );
                                      },
                                      selectedItemBuilder: (LeaderBoard selectedItem, VoidCallback deleteSelectedItem) {
                                        selectedRootCause = selectedItem.id;

                                        return Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 2.0,
                                            horizontal: 4.0,
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(
                                                    left: 16,
                                                    right: 16,
                                                    top: 8,
                                                    bottom: 8,
                                                  ),
                                                  child: Text(
                                                    selectedItem.name,
                                                    style: TextStyle(fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.delete_outline, size: 22),
                                                color: Colors.grey[700],
                                                onPressed: deleteSelectedItem,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      // widget customization
                                      noItemsFoundWidget: Container(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Icon(
                                              Icons.folder_open,
                                              size: 24,
                                              color: Colors.grey[900].withOpacity(0.7),
                                            ),
                                            SizedBox(width: 10.0),
                                            Text(
                                              "No Items Found",
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.grey[900].withOpacity(0.7),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      textFieldBuilder: (TextEditingController controllerCategory, FocusNode focusNodeCategory) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                          child: TextField(
                                            controller: controllerCategory,
                                            focusNode: focusNodeCategory,
                                            style: new TextStyle(fontSize: 16, color: Colors.grey[600]),
                                            decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Color(0x4437474F)),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                              ),
                                              border: InputBorder.none,
                                              hintText: "Root Cause",
                                              hintStyle: TextStyle(
                                                fontSize: 14.0
                                              ),
                                              contentPadding: EdgeInsets.only(
                                                left: 16,
                                                right: 20,
                                                top: 14,
                                                bottom: 14,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                    child: TextField(
                                      maxLines: 3,
                                      keyboardType: TextInputType.multiline,
                                      decoration: InputDecoration(
                                        labelText: 'Remarks (optional)',
                                        labelStyle: TextStyle(fontSize: 12.0),
                                      ),
                                      maxLength: 250,
                                      controller: remarksRootCause,
                                      textCapitalization: TextCapitalization.sentences,
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                                        child: ButtonTheme(
                                          minWidth: 50.0,
                                          height: 30.0,
                                          child: OutlineButton(
                                            child: Text(
                                              'PREV',
                                              style: TextStyle(
                                                  fontSize: 13.0, color: Colors.grey),
                                            ),
                                            borderSide:
                                                BorderSide(color: Colors.grey, width: 1.0),
                                            highlightedBorderColor: Colors.grey,
                                            onPressed: () {
                                              _tabController
                                                  .animateTo((_tabController.index - 1));
                                            },
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0, right: 20.0),
                                        child: ButtonTheme(
                                          minWidth: 50.0,
                                          height: 30.0,
                                          child: OutlineButton(
                                            child: Text(
                                              'NEXT',
                                              style: TextStyle(
                                                  fontSize: 13.0, color: Colors.blue),
                                            ),
                                            borderSide:
                                                BorderSide(color: Colors.blue, width: 1.0),
                                            highlightedBorderColor: Colors.blue,
                                            onPressed: () {
                                              _tabController
                                                  .animateTo((_tabController.index + 1));
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                          status != 'OPEN'
                            ? ListView(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      padding: const EdgeInsets.only(top: 15.0),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(color: Colors.grey, width: 1.0)
                                        )
                                      ),
                                      child:  Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child:
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.35,
                                              child: Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      'Immediate Action',
                                                      style: TextStyle(
                                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.35,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      immediateActionView,
                                                      style: TextStyle(
                                                          fontSize: 13.0,
                                                          color: Colors.black38,
                                                          fontWeight: FontWeight.w700
                                                      ),
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
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      padding: const EdgeInsets.only(top: 15.0),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(color: Colors.grey, width: 1.0)
                                        )
                                      ),
                                      child:  Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.35,
                                              child: Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      'Date',
                                                      style: TextStyle(
                                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.35,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      dateImmediateView,
                                                      style: TextStyle(
                                                          fontSize: 13.0,
                                                          color: Colors.black38,
                                                          fontWeight: FontWeight.w700
                                                      ),
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                                        child: ButtonTheme(
                                          minWidth: 50.0,
                                          height: 30.0,
                                          child: OutlineButton(
                                            child: Text(
                                              'PREV',
                                              style: TextStyle(
                                                  fontSize: 13.0, color: Colors.grey),
                                            ),
                                            borderSide:
                                                BorderSide(color: Colors.grey, width: 1.0),
                                            highlightedBorderColor: Colors.grey,
                                            onPressed: () {
                                              _tabController
                                                  .animateTo((_tabController.index - 1));
                                            },
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0, right: 20.0),
                                        child: ButtonTheme(
                                          minWidth: 50.0,
                                          height: 30.0,
                                          child: OutlineButton(
                                            child: Text(
                                              'NEXT',
                                              style: TextStyle(
                                                  fontSize: 13.0, color: Colors.blue),
                                            ),
                                            borderSide:
                                                BorderSide(color: Colors.blue, width: 1.0),
                                            highlightedBorderColor: Colors.blue,
                                            onPressed: () {
                                              _tabController
                                                  .animateTo((_tabController.index + 1));
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            : ListView(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                    child: TextFormField(
                                      maxLines: 3,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        labelText: 'What',
                                        labelStyle: TextStyle(fontSize: 12.0),
                                      ),
                                      maxLength: 250,
                                      validator: (value) {
                                        if (value.length < 10) {
                                          return 'Immediate action must be more than 10 character';
                                        } else if (value.length > 250) {
                                          return 'Immediate action must be less than 250 character';
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller: immediateAction,
                                      textCapitalization: TextCapitalization.sentences,
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(color: Colors.black87),
                                        ),
                                      ),
                                      child: FlatButton(
                                        onPressed: () async {
                                          final DateTime picked = await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2019, 1),
                                              lastDate: DateTime(2101));
                                          if (picked != null && picked != dateImmediate)
                                            setState(() {
                                              dateImmediate = picked;
                                            });
                                        },
                                        child: Text(
                                          dateImmediate == null ? 'Date' : dateImmediate.toString().substring(8, 10) + '/' + dateImmediate.toString().substring(5, 7) + '/' + dateImmediate.toString().substring(0, 4),
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontSize: 12.0
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ),
                                    /*DateTimePickerFormField(
                                      format: dateFormat,
                                      onChanged: (dt) => setState(() => dateImmediate = dt),
                                      dateOnly: true,
                                      editable: false,
                                      resetIcon: null,
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Please select date';
                                        } else {
                                          return null;
                                        }
                                      },
                                      style: TextStyle(fontSize: 14.0, color: Colors.black),
                                      decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelStyle: TextStyle(fontSize: 12.0),
                                          labelText: 'Date'),
                                    ),*/
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                                        child: ButtonTheme(
                                          minWidth: 50.0,
                                          height: 30.0,
                                          child: OutlineButton(
                                            child: Text(
                                              'PREV',
                                              style: TextStyle(
                                                  fontSize: 13.0, color: Colors.grey),
                                            ),
                                            borderSide:
                                                BorderSide(color: Colors.grey, width: 1.0),
                                            highlightedBorderColor: Colors.grey,
                                            onPressed: () {
                                              _tabController
                                                  .animateTo((_tabController.index - 1));
                                            },
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0, right: 20.0),
                                        child: ButtonTheme(
                                          minWidth: 50.0,
                                          height: 30.0,
                                          child: OutlineButton(
                                            child: Text(
                                              'NEXT',
                                              style: TextStyle(
                                                  fontSize: 13.0, color: Colors.blue),
                                            ),
                                            borderSide:
                                                BorderSide(color: Colors.blue, width: 1.0),
                                            highlightedBorderColor: Colors.blue,
                                            onPressed: () {
                                              _tabController
                                                  .animateTo((_tabController.index + 1));
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                          ListView(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                child: status != 'OPEN'
                                  ? Container(
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      padding: const EdgeInsets.only(top: 15.0),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(color: Colors.grey, width: 1.0)
                                        )
                                      ),
                                      child:  Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.35,
                                              child: Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      'Recommendation',
                                                      style: TextStyle(
                                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.35,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      recommendationView,
                                                      style: TextStyle(
                                                          fontSize: 13.0,
                                                          color: Colors.black38,
                                                          fontWeight: FontWeight.w700
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  : TextFormField(
                                      maxLines: 3,
                                      keyboardType: TextInputType.multiline,
                                      decoration: InputDecoration(
                                        labelText: 'What',
                                        labelStyle: TextStyle(fontSize: 12.0),
                                      ),
                                      maxLength: 250,
                                      controller: rekomendasi,
                                      validator: (value) {
                                        if (value.length < 10) {
                                          return 'Recommendation action must be more than 10 character';
                                        } else if (value.length > 250) {
                                          return 'Recommendation action must be less than 250 character';
                                        } else {
                                          return null;
                                        }
                                      },
                                      textCapitalization: TextCapitalization.sentences,
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                child: status != 'OPEN'
                                  ? Container(
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      padding: const EdgeInsets.only(top: 15.0),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(color: Colors.grey, width: 1.0)
                                        )
                                      ),
                                      child:  Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.35,
                                              child: Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      'Due Date ',
                                                      style: TextStyle(
                                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.35,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      duedateView,
                                                      style: TextStyle(
                                                          fontSize: 13.0,
                                                          color: Colors.black38,
                                                          fontWeight: FontWeight.w700
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  :
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: Colors.black87),
                                    ),
                                  ),
                                  child: FlatButton(
                                    onPressed: () async {
                                      final DateTime picked = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2019, 1),
                                          lastDate: DateTime(2101));
                                      if (picked != null && picked != dueDate)
                                        setState(() {
                                          dueDate = picked;
                                        });
                                    },
                                    child: Text(
                                      dueDate == null ? 'Due Date' : dueDate.toString().substring(8, 10) + '/' + dueDate.toString().substring(5, 7) + '/' + dueDate.toString().substring(0, 4),
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 12.0
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                                /*DateTimePickerFormField(
                                      format: dateFormat,
                                      onChanged: (dt) => setState(() => dueDate = dt),
                                      dateOnly: true,
                                      editable: false,
                                      resetIcon: null,
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Please select date';
                                        } else {
                                          return null;
                                        }
                                      },
                                      style: TextStyle(fontSize: 14.0, color: Colors.black),
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelStyle: TextStyle(fontSize: 12.0),
                                        labelText: 'Due Date'
                                      ),
                                    ),*/
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.5,
                                  padding: const EdgeInsets.only(top: 15.0),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: Colors.grey, width: 1.0)
                                    )
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.35,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Send To',
                                                  style: TextStyle(
                                                      fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.35,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  '$userCreated - $departmentCreated',
                                                  style: TextStyle(
                                                      fontSize: 13.0,
                                                      color: Colors.black38,
                                                      fontWeight: FontWeight.w700
                                                  ),
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
                              status == 'ONGOING'
                                ? Container(
                                    padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.35,
                                            child: Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Picture',
                                                    style: TextStyle(
                                                      fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          imageCAR == null
                                            ? prosesUpload
                                                ? SizedBox(
                                                    width: 25.0,
                                                    height: 25.0,
                                                    child: CircularProgressIndicator(
                                                      strokeWidth: 2.0,
                                                    ),
                                                  )
                                                : GestureDetector(
                                                    onTap: () async {
                                                      var selectedImage = await ImagePicker.pickImage(source: ImageSource.camera, maxHeight: 400.0, maxWidth: 400.0);
                                                      
                                                      imageCAR1 = selectedImage;
                                                      if (imageCAR1 == null) {
                                                        
                                                      } else {
                                                        setState(() {
                                                          prosesUpload = true;
                                                        });
                                                        filenameCAR1 = basename(imageCAR1.path);

                                                        StorageReference strRef = FirebaseStorage.instance.ref().child(filenameCAR1);
                                                        StorageUploadTask uploadTask = strRef.putFile(imageCAR1);

                                                        var url;
                                                        var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL().then((doc) {
                                                          setState(() {
                                                            prosesUpload = false;
                                                            url = doc.toString();
                                                          });
                                                        });

                                                        setState(() {
                                                          List<String> bantuImageAreaLuar = [];
                                                          List<String> bantuImageAreaLuarSave = [];

                                                          if (imageCAR != null) {
                                                            bantuImageAreaLuar = imageCAR.split('###');
                                                            bantuImageAreaLuar.add(filenameCAR1);
                                                            imageCAR = bantuImageAreaLuar.join('###');

                                                            bantuImageAreaLuarSave = imageCARSave.split('###');
                                                            bantuImageAreaLuarSave.add(url);
                                                            imageCARSave = bantuImageAreaLuarSave.join('###');
                                                          } else {
                                                            imageCARSave = url;
                                                            imageCAR = filenameCAR1;
                                                          }
                                                        });
                                                      }
                                                    },
                                                    child: Container(
                                                      width: MediaQuery.of(context).size.width * 0.35,
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: <Widget>[
                                                          Flexible(
                                                            child: Icon(
                                                              Icons.camera_alt,
                                                              color: Colors.black54,
                                                            )
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                            : imageCAR.split('###').length >= 3
                                                ? Container(
                                                    width: MediaQuery.of(context).size.width * 0.35,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            'Sudah mencapai batas maksimal 3 foto',
                                                            style: TextStyle(
                                                                fontSize: 13.0,
                                                                color: Colors.red[300],
                                                                fontStyle: FontStyle.italic,
                                                                fontWeight: FontWeight.w700
                                                            ),
                                                            textAlign: TextAlign.end,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : prosesUpload
                                                    ? SizedBox(
                                                        width: 25.0,
                                                        height: 25.0,
                                                        child: CircularProgressIndicator(
                                                          strokeWidth: 2.0,
                                                        ),
                                                      )
                                                    : GestureDetector(
                                                        onTap: () async {
                                                          var selectedImage = await ImagePicker.pickImage(source: ImageSource.camera, maxHeight: 400.0, maxWidth: 400.0);
                                                      
                                                          imageCAR1 = selectedImage;
                                                          if (imageCAR1 == null) {
                                                            
                                                          } else {
                                                            setState(() {
                                                              prosesUpload = true;
                                                            });
                                                            filenameCAR1 = basename(imageCAR1.path);

                                                            StorageReference strRef = FirebaseStorage.instance.ref().child(filenameCAR1);
                                                            StorageUploadTask uploadTask = strRef.putFile(imageCAR1);

                                                            var url;
                                                            var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL().then((doc) {
                                                              setState(() {
                                                                prosesUpload = false;
                                                                url = doc.toString();
                                                              });
                                                            });

                                                            setState(() {
                                                              List<String> bantuImageAreaLuar = [];
                                                              List<String> bantuImageAreaLuarSave = [];

                                                              if (imageCAR != null) {
                                                                bantuImageAreaLuar = imageCAR.split('###');
                                                                bantuImageAreaLuar.add(filenameCAR1);
                                                                imageCAR = bantuImageAreaLuar.join('###');

                                                                bantuImageAreaLuarSave = imageCARSave.split('###');
                                                                bantuImageAreaLuarSave.add(url);
                                                                imageCARSave = bantuImageAreaLuarSave.join('###');
                                                              } else {
                                                                imageCARSave = url;
                                                                imageCAR = filenameCAR1;
                                                              }
                                                            });
                                                          }
                                                        },
                                                        child: Container(
                                                          width: MediaQuery.of(context).size.width * 0.35,
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: <Widget>[
                                                              Flexible(
                                                                child: Icon(
                                                                  Icons.camera_alt,
                                                                  color: Colors.black54,
                                                                )
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                                    child: ButtonTheme(
                                      minWidth: 50.0,
                                      height: 30.0,
                                      child: OutlineButton(
                                        child: Text(
                                          'PREV',
                                          style: TextStyle(
                                              fontSize: 13.0, color: Colors.grey),
                                        ),
                                        borderSide:
                                            BorderSide(color: Colors.grey, width: 1.0),
                                        highlightedBorderColor: Colors.grey,
                                        onPressed: () {
                                          _tabController
                                              .animateTo((_tabController.index - 1));
                                        },
                                      ),
                                    ),
                                  ),
                                  status == 'ONGOING'
                                    ? Padding(
                                        padding: const EdgeInsets.only(top: 10.0, right: 20.0),
                                        child: _isProccess
                                          ? Container(
                                              child: Center(
                                                child: CircularProgressIndicator(),
                                              ),
                                            )
                                          : ButtonTheme(
                                              minWidth: 50.0,
                                              height: 30.0,
                                              child: OutlineButton(
                                                child: Text(
                                                  'DONE',
                                                  style: TextStyle(
                                                    fontSize: 13.0,
                                                    color: AbubaPallate.greenabuba),
                                                ),
                                                borderSide: BorderSide(color: AbubaPallate.greenabuba, width: 1.0),
                                                highlightedBorderColor: AbubaPallate.greenabuba,
                                                onPressed: () {
                                                  setState(() {
                                                    _isProccess = true;
                                                  });
                                                  DocumentReference docReference = Firestore.instance.collection('correctiveAction').document(widget.index);

                                                  docReference.updateData({
                                                    'status': 'DONE',
                                                    'dateDone': DateTime.now(),
                                                    'imageDone': imageCARSave
                                                  }).then((doc) {
                                                    Navigator.pushReplacement(context, 
                                                      MaterialPageRoute(
                                                        builder: (_) => CarNonIA(departmentUser: widget.departmentUser, namaUser: widget.namaUser, idUser: widget.idUser)
                                                      )
                                                    );
                                                    // setState(() {
                                                    //   _isProccess = false;
                                                    // });

                                                    // showDialog(
                                                    //   barrierDismissible: false,
                                                    //   context: context,
                                                    //   builder: (context) => Dialog(
                                                    //     child: Container(
                                                    //       height: 180.0,
                                                    //       child: Column(
                                                    //         children: <Widget>[
                                                    //           Container(
                                                    //             color: AbubaPallate.greenabuba,
                                                    //             height: 50.0,
                                                    //             child: Center(
                                                    //               child: Text(
                                                    //                 'SUCCESSFUL!',
                                                    //                 style: TextStyle(
                                                    //                   color: Colors.white,
                                                    //                   fontSize: 17.0,
                                                    //                   fontWeight: FontWeight.w700),
                                                    //               ),
                                                    //             ),
                                                    //           ),
                                                    //           SizedBox(
                                                    //             height: 20.0,
                                                    //           ),
                                                    //           Container(
                                                    //             padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                                    //             child: Text(
                                                    //               'Corrective Action No. CAR-${carNo.toString().padLeft(4, '0')}',
                                                    //               style: TextStyle(
                                                    //                 fontSize: 16.0,
                                                    //               ),
                                                    //             ),
                                                    //           ),
                                                    //           Row(
                                                    //             mainAxisAlignment: MainAxisAlignment.end,
                                                    //             children: <Widget>[
                                                    //               FlatButton(
                                                    //                 child: Text('OK'),
                                                    //                 onPressed: () {
                                                    //                   Navigator.pop(context);
                                                    //                 },
                                                    //               )
                                                    //             ],
                                                    //           )
                                                    //         ],
                                                    //       ),
                                                    //     ),
                                                    //   )
                                                    // ).whenComplete(() {
                                                    //   Navigator.pop(context);
                                                    // });
                                                  }).catchError((error) {
                                                    print(error);
                                                  });
                                                },
                                              ),
                                            )
                                      )
                                    : status == 'DONE'
                                        ? Padding(
                                            padding: const EdgeInsets.only(top: 10.0, right: 20.0),
                                            child: ButtonTheme(
                                              minWidth: 50.0,
                                              height: 30.0,
                                              child: OutlineButton(
                                                child: Text(
                                                  'CLOSE',
                                                  style: TextStyle(
                                                    fontSize: 13.0,
                                                    color: AbubaPallate.greenabuba),
                                                ),
                                                borderSide: BorderSide(color: AbubaPallate.greenabuba, width: 1.0),
                                                highlightedBorderColor: AbubaPallate.greenabuba,
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.only(top: 10.0, right: 20.0),
                                            child: _isProccess
                                              ? Container(
                                                  child: Center(
                                                    child: CircularProgressIndicator(),
                                                  ),
                                                )
                                              : ButtonTheme(
                                                  minWidth: 50.0,
                                                  height: 30.0,
                                                  child: OutlineButton(
                                                    child: Text(
                                                      'SAVE',
                                                      style: TextStyle(
                                                        fontSize: 13.0,
                                                        color: AbubaPallate.greenabuba),
                                                    ),
                                                    borderSide: BorderSide(color: AbubaPallate.greenabuba, width: 1.0),
                                                    highlightedBorderColor: AbubaPallate.greenabuba,
                                                    onPressed: () {
                                                      setState(() {
                                                        _isProccess = true;
                                                      });
                                                      DocumentReference docReference = Firestore.instance.collection('correctiveAction').document(widget.index);

                                                      docReference.updateData({
                                                        'rootCause': int.tryParse(selectedRootCause.toString()),
                                                        'remarksRootCause':remarksRootCause.text,
                                                        'immediateAction':immediateAction.text,
                                                        'immediateDate':dateImmediate,
                                                        'recommendationAction':rekomendasi.text,
                                                        'dueDate':dueDate,
                                                        'status': 'ONGOING',
                                                        'dateSend': DateTime.now()
                                                      }).then((doc) {
                                                        // setState(() {
                                                        //   _isProccess = false;
                                                        // });

                                                        Navigator.pushReplacement(context, 
                                                          MaterialPageRoute(
                                                            builder: (_) => CarNonIA(departmentUser: widget.departmentUser, namaUser: widget.namaUser, idUser: widget.idUser)
                                                          )
                                                        );

                                                        // showDialog(
                                                        //   barrierDismissible: false,
                                                        //   context: context,
                                                        //   builder: (context) => Dialog(
                                                        //     child: Container(
                                                        //       height: 180.0,
                                                        //       child: Column(
                                                        //         children: <Widget>[
                                                        //           Container(
                                                        //             color: AbubaPallate.greenabuba,
                                                        //             height: 50.0,
                                                        //             child: Center(
                                                        //               child: Text(
                                                        //                 'SUCCESSFUL!',
                                                        //                 style: TextStyle(
                                                        //                   color: Colors.white,
                                                        //                   fontSize: 17.0,
                                                        //                   fontWeight: FontWeight.w700),
                                                        //               ),
                                                        //             ),
                                                        //           ),
                                                        //           SizedBox(
                                                        //             height: 20.0,
                                                        //           ),
                                                        //           Container(
                                                        //             padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                                        //             child: Text(
                                                        //               'Corrective Action No. CAR-${carNo.toString().padLeft(4, '0')}',
                                                        //               style: TextStyle(
                                                        //                 fontSize: 16.0,
                                                        //               ),
                                                        //             ),
                                                        //           ),
                                                        //           Row(
                                                        //             mainAxisAlignment: MainAxisAlignment.end,
                                                        //             children: <Widget>[
                                                        //               FlatButton(
                                                        //                 child: Text('OK'),
                                                        //                 onPressed: () {
                                                        //                   Navigator.pop(context);
                                                        //                 },
                                                        //               )
                                                        //             ],
                                                        //           )
                                                        //         ],
                                                        //       ),
                                                        //     ),
                                                        //   )
                                                        // ).whenComplete(() {
                                                        //   Navigator.pop(context);
                                                        // });
                                                      }).catchError((error) {
                                                        print(error);
                                                      });
                                                    },
                                                  ),
                                                ),
                                      ),
                                ],
                              )
                            ],
                          ),
                        ],
                      );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
