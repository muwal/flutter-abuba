import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/isoft/operation_page/correctiveaction/car_IA.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class FormCreateLanjutanIA extends StatefulWidget {
  FormCreateLanjutanIA({this.idUser, this.namaUser, this.departmentUser, this.status, this.index});

  final int idUser;
  final String namaUser;
  final String departmentUser;
  final String status;
  var index;

  @override
  _FormCreateLanjutanIAState createState() => _FormCreateLanjutanIAState();
}

class _FormCreateLanjutanIAState extends State<FormCreateLanjutanIA> with TickerProviderStateMixin {
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
  String rekomendasiFS;

  var val2;
  var val3;
  bool showImageIA = false;
  List<dynamic> imageSplit = [];
  
  String imageCAR;
  String imageCARSave;
  File imageCAR1;
  String filenameCAR1;
  bool prosesUpload = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: internalAuditTabs.length);

    Firestore.instance.collection('correctiveAction').document(widget.index).snapshots().listen((data) {
      setState(() {
        rekomendasiFS = data.data['rekomendasiFS'];
        carNo = data.data['carNo'];
        problem = data.data['problem'];
        if (data.data['remarksProblem'] == "" || data.data['remarksProblem'] == null) {
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

    CollectionReference reference2 = Firestore.instance.collection('audit_internal');
    reference2.snapshots().listen((data3) {
      data3.documentChanges.forEach((change2) {
        if (change2.document.data['FSCarNo'].contains(carNo)) {
          val2 = change2.document.data['FSCarNo'].indexWhere((test) => test == carNo);
          
          if (change2.document.data['FSArea'][val2] == 'Area Luar') {
            val3 = change2.document.data['iamgeAreaLuar'][change2.document.data['pertanyaanAreaLuar'].indexWhere((test) => test == change2.document.data['FSProblem'][val2])];
          } else if (change2.document.data['FSArea'][val2] == 'Dinning Area') {
            val3 = change2.document.data['imageDinningArea'][change2.document.data['pertanyaanDinningArea'].indexWhere((test) => test == change2.document.data['FSProblem'][val2])];
          } else if (change2.document.data['FSArea'][val2] == 'Service') {
            val3 = change2.document.data['imageService'][change2.document.data['pertanyaanService'].indexWhere((test) => test == change2.document.data['FSProblem'][val2])];
          } else if (change2.document.data['FSArea'][val2] == 'Cashier') {
            val3 = change2.document.data['imageCashier'][change2.document.data['pertanyaanCashier'].indexWhere((test) => test == change2.document.data['FSProblem'][val2])];
          } else if (change2.document.data['FSArea'][val2] == 'Administrasi Keuangan') {
            val3 = change2.document.data['imageCashierAccuracy'][change2.document.data['pertanyaanCashierAccuracy'].indexWhere((test) => test == change2.document.data['FSProblem'][val2])];
          } else if (change2.document.data['FSArea'][val2] == 'Back of The House (BOH)') {
            val3 = change2.document.data['imageBoh'][change2.document.data['pertanyaanBoh'].indexWhere((test) => test == change2.document.data['FSProblem'][val2])];
          } else if (change2.document.data['FSArea'][val2] == 'Warehouse') {
            val3 = change2.document.data['imageWarehouse'][change2.document.data['pertanyaanWarehouse'].indexWhere((test) => test == change2.document.data['FSProblem'][val2])];
          } else if (change2.document.data['FSArea'][val2] == 'Social Block') {
            val3 = change2.document.data['imageSocialBlock'][change2.document.data['pertanyaanSocialBlock'].indexWhere((test) => test == change2.document.data['FSProblem'][val2])];
          } else if (change2.document.data['FSArea'][val2] == 'Personal Hygiene') {
            val3 = change2.document.data['imagePersonal'][change2.document.data['pertanyaanPersonal'].indexWhere((test) => test == change2.document.data['FSProblem'][val2])];
          } else if (change2.document.data['FSArea'][val2] == 'Food Completely Cooked') {
            val3 = change2.document.data['imageFoodCooked'][change2.document.data['pertanyaanFoodCooked'].indexWhere((test) => test == change2.document.data['FSProblem'][val2])];
          }
        }
      });
    });

    animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(
      from: animationController.value == 0.0
        ? 1.0
        : animationController.value
    );
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
                                                  textAlign: TextAlign.end,
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
                                                  textAlign: TextAlign.end,
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
                                                    textAlign: TextAlign.end,
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
                                                  remarksProblem == null ? '-' : remarksProblem,
                                                  style: TextStyle(
                                                    fontSize: 13.0,
                                                    color: Colors.black38,
                                                    fontWeight: FontWeight.w700
                                                  ),
                                                  textAlign: TextAlign.end,
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
                                  val3 == null
                                    ? Container()
                                    : Padding(
                                        padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              imageSplit = val3.toString().split('###');
                                              showImageIA = !showImageIA;
                                            });
                                          },
                                          child: Icon(Icons.image, color: showImageIA ? Colors.grey : AbubaPallate.menuBluebird),
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
                                              .animateTo((_tabController.index + 1) % 2);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              showImageIA
                                ? Container(
                                    child: GridView.count(
                                      padding: const EdgeInsets.only(right: 17.0, left: 17.0, bottom: 10.0),
                                      crossAxisCount: 5,
                                      childAspectRatio: 1.0,
                                      mainAxisSpacing: 4.0,
                                      crossAxisSpacing: 4.0,
                                      shrinkWrap: true,
                                      children: List.generate(imageSplit.length, (index2) {
                                        return GridTile(
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(context,
                                                MyCustomRoute(builder: (context) => DetailScreen(image: imageSplit[index2].toString(), indexx: index2))
                                              );
                                            },
                                            child: Hero(
                                              tag: 'imageHero${index2.toString()}',
                                              child: Image.network(
                                                imageSplit[index2].toString(),
                                                fit: BoxFit.cover,
                                              ),
                                              transitionOnUserGestures: true,
                                            )
                                          )
                                        );
                                      }).toList()
                                    ),
                                  )
                                : Container(),
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
                                                      textAlign: TextAlign.end,
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
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: StreamBuilder(
                                        stream: Firestore.instance.collection('correctiveAction_rootCause').orderBy('root_cause', descending: false).snapshots(),
                                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                          if (!snapshot.hasData)
                                            return Container(
                                              child: Center(
                                                child: CircularProgressIndicator(),
                                              ),
                                            );

                                          return DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              labelText: 'Root Cause',
                                              labelStyle: TextStyle(fontSize: 12.0),
                                            ),
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Please select root cause';
                                              } else {
                                                return null;
                                              }
                                            },
                                            value: rootCause,
                                            onChanged: (String value) {
                                              setState(() {
                                                rootCause = value;
                                                });
                                            },
                                            items: snapshot.data.documents.map((DocumentSnapshot document) {
                                              return DropdownMenuItem(
                                                value: document['id'].toString(),
                                                child: Padding(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: RichText(
                                                    overflow: TextOverflow.visible,
                                                    text: TextSpan(
                                                      text: document['root_cause'].toString(),
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12.0
                                                      )
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }).toList()
                                          );
                                        },
                                      )
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
                                                      textAlign: TextAlign.end,
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
                                                  rekomendasiFS == null ? '-' : rekomendasiFS,
                                                  style: TextStyle(
                                                      fontSize: 13.0,
                                                      color: Colors.black38,
                                                      fontWeight: FontWeight.w700
                                                  ),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
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
                                                      'Action Plan',
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
                                                      textAlign: TextAlign.end,
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
                                                      strokeWidth: 2,
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

                                                        var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL().then((doc) {
                                                          setState(() {
                                                            prosesUpload = false;
                                                          });
                                                        });
                                                        var url = downUrl.toString();

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
                                                          strokeWidth: 2,
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

                                                            var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL().then((doc) {
                                                              setState(() {
                                                                prosesUpload = false;
                                                              });
                                                            });
                                                            var url = downUrl.toString();

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
                                          _tabController.animateTo((_tabController.index - 1));
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
                                                    setState(() {
                                                      _isProccess = false;
                                                    });

                                                    showDialog(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder: (context) => Dialog(
                                                        child: Container(
                                                          height: 180.0,
                                                          child: Column(
                                                            children: <Widget>[
                                                              Container(
                                                                color: AbubaPallate.greenabuba,
                                                                height: 50.0,
                                                                child: Center(
                                                                  child: Text(
                                                                    'SUCCESSFUL!',
                                                                    style: TextStyle(
                                                                      color: Colors.white,
                                                                      fontSize: 17.0,
                                                                      fontWeight: FontWeight.w700),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 20.0,
                                                              ),
                                                              Container(
                                                                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                                                child: Text(
                                                                  'Corrective Action No. CAR-${carNo.toString().padLeft(4, '0')}',
                                                                  style: TextStyle(
                                                                    fontSize: 16.0,
                                                                  ),
                                                                ),
                                                              ),
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.end,
                                                                children: <Widget>[
                                                                  FlatButton(
                                                                    child: Text('OK'),
                                                                    onPressed: () {
                                                                      Navigator.pop(context);
                                                                    },
                                                                  )
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ).whenComplete(() {
                                                      Navigator.pop(context);
                                                    });
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
                                                  'QUIT',
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
                                                        'rootCause': int.tryParse(rootCause),
                                                        'remarksRootCause':remarksRootCause.text,
                                                        'immediateAction':immediateAction.text,
                                                        'immediateDate':dateImmediate,
                                                        'recommendationAction':rekomendasi.text,
                                                        'dueDate':dueDate,
                                                        'status': 'ONGOING',
                                                        'dateSend': DateTime.now()
                                                      }).then((doc) {
                                                        setState(() {
                                                          _isProccess = false;
                                                        });

                                                        showDialog(
                                                          barrierDismissible: false,
                                                          context: context,
                                                          builder: (context) => Dialog(
                                                            child: Container(
                                                              height: 180.0,
                                                              child: Column(
                                                                children: <Widget>[
                                                                  Container(
                                                                    color: AbubaPallate.greenabuba,
                                                                    height: 50.0,
                                                                    child: Center(
                                                                      child: Text(
                                                                        'SUCCESSFUL!',
                                                                        style: TextStyle(
                                                                          color: Colors.white,
                                                                          fontSize: 17.0,
                                                                          fontWeight: FontWeight.w700),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 20.0,
                                                                  ),
                                                                  Container(
                                                                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                                                    child: Text(
                                                                      'Corrective Action No. CAR-${carNo.toString().padLeft(4, '0')}',
                                                                      style: TextStyle(
                                                                        fontSize: 16.0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                    children: <Widget>[
                                                                      FlatButton(
                                                                        child: Text('OK'),
                                                                        onPressed: () {
                                                                          Navigator.pop(context);
                                                                        },
                                                                      )
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        ).whenComplete(() {
                                                          Navigator.pushReplacement(context,
                                                            MyCustomRoute(
                                                                builder: (context) => CarIA(idUser: widget.idUser, departmentUser: widget.departmentUser, namaUser: widget.namaUser)
                                                            )
                                                          );
                                                        });
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

class DetailScreen extends StatefulWidget {
  final String image;
  final int indexx;
  DetailScreen({this.image, this.indexx});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero${widget.indexx.toString()}',
            child: Image.network(
              widget.image.toString(),
            ),
            transitionOnUserGestures: true,
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}