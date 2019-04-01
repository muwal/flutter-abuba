import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:intl/intl.dart';

class DetailReport extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  var index;
  DetailReport({this.idUser, this.namaUser, this.departmentUser, this.index});

  @override
  _DetailReportState createState() => _DetailReportState();
}

class _DetailReportState extends State<DetailReport> with TickerProviderStateMixin {
  AnimationController animationController;
  final formatter = NumberFormat('#,###');

  String userNama;
  String tanggal;
  String no;
  String projectName;
  String projectSponsor;
  String projectManager;
  String department;
  String processImpacted;
  String expectedStart;
  String expectedEnd;
  int expectedSavings;
  int estimatedCost;
  String greenBelt;
  String blackBelt;

  String problemIssue;
  String purpose;
  String businessCase;
  String goalsMetric;
  int expectedDeliverables;

  String withinScope;
  String outsideScope;

  String fromProjectTeam;
  String preliminary;
  String define;
  String measurement;
  String analysis;
  String improvement;
  String control;
  String projectSummary;
  String closeOut;

  List<dynamic> projectTeam = [];
  List<dynamic> supportResources = [];
  List<dynamic> specialNeeds = [];

  String costType;
  String vendor;
  int rate;
  int quantity;
  int amount;

  String processOwner;
  String keyStakeholders;
  String finalCustomer;
  int expectedBenefits;

  String typeBenefits;
  String basisEstimate;
  int estimatedBenefits;

  String risks;
  String constraints;
  String assumption;

  @override
  void initState() {
    super.initState();
    Firestore.instance.collection('projectCharter').document(widget.index).snapshots().listen((data) {
      setState(() {
        tanggal = data.data['dateCreated'].toString().substring(8, 10) + '/' + data.data['dateCreated'].toString().substring(5, 7) + '/' + data.data['dateCreated'].toString().substring(0, 4);
        no = data.data['projectCharterNo'].toString().padLeft(4, '0');
        projectName = data.data['projectName'];
        expectedStart = data.data['expectedStart'].toString().substring(8, 10) + '/' + data.data['expectedStart'].toString().substring(5, 7) + '/' + data.data['expectedStart'].toString().substring(0, 4);
        expectedEnd = data.data['expectedCompletion'].toString().substring(8, 10) + '/' + data.data['expectedCompletion'].toString().substring(5, 7) + '/' + data.data['expectedCompletion'].toString().substring(0, 4);
        expectedSavings = data.data['expectedSavings'];
        estimatedCost = data.data['estimatedCost'];

        problemIssue = data.data['problemIssue'];
        purpose = data.data['purpose'];
        businessCase = data.data['businessCase'];
        expectedDeliverables = data.data['expectedDeliverables'];

        withinScope = data.data['withinScope'];
        outsideScope = data.data['outsideScope'];

        fromProjectTeam = data.data['fromProjectTeamStart'].toString().substring(8, 10) + '/' + data.data['fromProjectTeamStart'].toString().substring(5, 7) + '/' + data.data['fromProjectTeamStart'].toString().substring(0, 4) + ' - ' + data.data['fromProjectTeamEnd'].toString().substring(8, 10) + '/' + data.data['fromProjectTeamEnd'].toString().substring(5, 7) + '/' + data.data['fromProjectTeamEnd'].toString().substring(0, 4);
        preliminary = data.data['preliminaryStart'].toString().substring(8, 10) + '/' + data.data['preliminaryStart'].toString().substring(5, 7) + '/' + data.data['preliminaryStart'].toString().substring(0, 4) + ' - ' + data.data['preliminaryEnd'].toString().substring(8, 10) + '/' + data.data['preliminaryEnd'].toString().substring(5, 7) + '/' + data.data['preliminaryEnd'].toString().substring(0, 4);
        define = data.data['defineStart'].toString().substring(8, 10) + '/' + data.data['defineStart'].toString().substring(5, 7) + '/' + data.data['defineStart'].toString().substring(0, 4) + ' - ' + data.data['defineEnd'].toString().substring(8, 10) + '/' + data.data['defineEnd'].toString().substring(5, 7) + '/' + data.data['defineEnd'].toString().substring(0, 4);
        measurement = data.data['measurementStart'].toString().substring(8, 10) + '/' + data.data['measurementStart'].toString().substring(5, 7) + '/' + data.data['measurementStart'].toString().substring(0, 4) + ' - ' + data.data['measurementEnd'].toString().substring(8, 10) + '/' + data.data['measurementEnd'].toString().substring(5, 7) + '/' + data.data['measurementEnd'].toString().substring(0, 4);
        analysis = data.data['analysisStart'].toString().substring(8, 10) + '/' + data.data['analysisStart'].toString().substring(5, 7) + '/' + data.data['analysisStart'].toString().substring(0, 4) + ' - ' + data.data['analysisEnd'].toString().substring(8, 10) + '/' + data.data['analysisEnd'].toString().substring(5, 7) + '/' + data.data['analysisEnd'].toString().substring(0, 4);
        improvement = data.data['improvementStart'].toString().substring(8, 10) + '/' + data.data['improvementStart'].toString().substring(5, 7) + '/' + data.data['improvementStart'].toString().substring(0, 4) + ' - ' + data.data['improvementEnd'].toString().substring(8, 10) + '/' + data.data['improvementEnd'].toString().substring(5, 7) + '/' + data.data['improvementEnd'].toString().substring(0, 4);
        control = data.data['controlStart'].toString().substring(8, 10) + '/' + data.data['controlStart'].toString().substring(5, 7) + '/' + data.data['controlStart'].toString().substring(0, 4) + ' - ' + data.data['controlEnd'].toString().substring(8, 10) + '/' + data.data['controlEnd'].toString().substring(5, 7) + '/' + data.data['controlEnd'].toString().substring(0, 4);
        projectSummary = data.data['projectSummaryStart'].toString().substring(8, 10) + '/' + data.data['projectSummaryStart'].toString().substring(5, 7) + '/' + data.data['projectSummaryStart'].toString().substring(0, 4) + ' - ' + data.data['projectSummaryEnd'].toString().substring(8, 10) + '/' + data.data['projectSummaryEnd'].toString().substring(5, 7) + '/' + data.data['projectSummaryEnd'].toString().substring(0, 4);
        closeOut = data.data['closeOutStart'].toString().substring(8, 10) + '/' + data.data['closeOutStart'].toString().substring(5, 7) + '/' + data.data['closeOutStart'].toString().substring(0, 4) + ' - ' + data.data['closeOutEnd'].toString().substring(8, 10) + '/' + data.data['closeOutEnd'].toString().substring(5, 7) + '/' + data.data['closeOutEnd'].toString().substring(0, 4);

        projectTeam = data.data['projectTeamName'];
        supportResources = data.data['supportResourcesName'];
        specialNeeds = data.data['specialNeedsName'];

        rate = data.data['rate'];
        quantity = data.data['quantity'];
        amount = data.data['amount'];

        expectedBenefits = data.data['expectedBenefit'];
        keyStakeholders = data.data['keyStakeholders'];

        estimatedBenefits = data.data['estimatedBenefit'];
        basisEstimate = data.data['basisEstimate'];

        risks = data.data['risks'];
        constraints = data.data['constraints'];
        assumption = data.data['assumption'];

        Firestore.instance.collection('project-sponsor').where('id', isEqualTo: data.data['projectSponsor']).snapshots().listen((data3) {
          projectSponsor = data3.documents[0].data['sponsor'];
        });

        Firestore.instance.collection('user').where('id', isEqualTo: data.data['projectManager']).snapshots().listen((data4) {
          projectManager = data4.documents[0].data['nama'];
        });

        Firestore.instance.collection('department').where('id', isEqualTo: data.data['department']).snapshots().listen((data5) {
          department = data5.documents[0].data['department'];
        });

        Firestore.instance.collection('green-belt').where('id', isEqualTo: data.data['greenBelt']).snapshots().listen((data6) {
          greenBelt = data6.documents[0].data['greenBelt'];
        });

        Firestore.instance.collection('black-belt').where('id', isEqualTo: data.data['blackBelt']).snapshots().listen((data7) {
          blackBelt = data7.documents[0].data['blackBelt'];
        });

        Firestore.instance.collection('process-impacted').where('id', isEqualTo: data.data['processImpacted']).snapshots().listen((data8) {
          processImpacted = data8.documents[0].data['impacted'];
        });

        Firestore.instance.collection('goals-metric').where('id', isEqualTo: data.data['goals']).snapshots().listen((data9) {
          goalsMetric = data9.documents[0].data['goals'];
        });

        Firestore.instance.collection('cost-type').where('id', isEqualTo: data.data['type']).snapshots().listen((data10) {
          costType = data10.documents[0].data['type'];
        });
        
        Firestore.instance.collection('vendor').where('id', isEqualTo: data.data['vendor']).snapshots().listen((data11) {
          vendor = data11.documents[0].data['vendor'];
        });

        Firestore.instance.collection('user').where('id', isEqualTo: data.data['processOwner']).snapshots().listen((data12) {
          processOwner = data12.documents[0].data['nama'];
        });

        Firestore.instance.collection('department').where('id', isEqualTo: data.data['finalCustomer']).snapshots().listen((data13) {
          finalCustomer = data13.documents[0].data['department'];
        });

        Firestore.instance.collection('type-benefit').where('id', isEqualTo: data.data['typeBenefit']).snapshots().listen((data14) {
          typeBenefits = data14.documents[0].data['type'];
        });

        Firestore.instance.collection('user').where('id', isEqualTo: data.data['userCreated']).snapshots().listen((data2) {
          userNama = data2.documents[0].data['nama'];
        });
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        body: _formDetail(),
      ),
    );
  }

  Widget _formDetail() {
    return Scrollbar(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Report',
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
                    'Detail',
                    style:
                        TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
          AnimatedBuilder(
            animation: animationController,
            builder: (_, Widget child) {
              return animationController.isAnimating
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Container(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 150.0,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        userNama,
                                        style: TextStyle(
                                            fontSize: 12.0, color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 150.0,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Project Charter No. CHA-$no',
                                        style: TextStyle(
                                            fontSize: 12.0, color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 12.0, right: 12.0, bottom: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 150.0,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Diinput oleh',
                                        style: TextStyle(
                                            fontSize: 10.0, color: Colors.black38),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: 150.0,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        tanggal,
                                        style: TextStyle(
                                            fontSize: 10.0,
                                            color: Colors.black38,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0.0),
                          child: Divider(
                            height: 6.0,
                          ),
                        ),

                        ExpansionTile(
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      '1. General Information',
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {},
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Project Name',
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  projectName,
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.black54),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                                    child: Divider(
                                      height: 6.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Project Sponsor',
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  projectSponsor,
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.black54),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                                    child: Divider(
                                      height: 6.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Project Manager',
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  projectManager,
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.black54),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                                    child: Divider(
                                      height: 6.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Department',
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  department,
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.black54),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                                    child: Divider(
                                      height: 6.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Process Impacted',
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  processImpacted,
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.black54),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                                    child: Divider(
                                      height: 6.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Expected Start Date',
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  expectedStart,
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.black54),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                                    child: Divider(
                                      height: 6.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Expected Completion Date',
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  expectedEnd,
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.black54),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                                    child: Divider(
                                      height: 6.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Expected Savings',
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Rp ${formatter.format(expectedSavings)}',
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.black54),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                                    child: Divider(
                                      height: 6.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Estimated Cost',
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Rp ${formatter.format(estimatedCost)}',
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.black54),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                                    child: Divider(
                                      height: 6.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Green Belt Assigned',
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  greenBelt,
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.black54),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                                    child: Divider(
                                      height: 6.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Black Belt Assigned',
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  blackBelt,
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.black54),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        ExpansionTile(
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      '2. Problem, Goals, Objectives and Deliverable',
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {},
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(
                                        'Problem or Issue',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 20.0, right: 15.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              problemIssue,
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.black54),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                                    child: Divider(
                                      height: 6.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(
                                        'Purpose or Project',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 20.0, right: 15.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              purpose,
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.black54),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                                    child: Divider(
                                      height: 6.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(
                                        'Business Case',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 20.0, right: 15.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              businessCase,
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.black54),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                                    child: Divider(
                                      height: 6.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(
                                        'Goals Metric',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 20.0, right: 15.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              goalsMetric,
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.black54),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                                    child: Divider(
                                      height: 6.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(
                                        'Expected Deliverables',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 20.0, right: 15.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              formatter.format(expectedDeliverables).toString(),
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.black54),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        ExpansionTile(
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      '3. Project Scope',
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {},
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(
                                        'Within Scope',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 20.0, right: 15.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              withinScope,
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.black54),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                                    child: Divider(
                                      height: 6.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(
                                        'Outside of Scope',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 20.0, right: 15.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              outsideScope,
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.black54),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        ExpansionTile(
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      '4. Tentative Schedule',
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {},
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'From Project Team',
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  fromProjectTeam,
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.black54),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                                    child: Divider(
                                      height: 6.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Preliminary Review',
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  preliminary,
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.black54),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                                    child: Divider(
                                      height: 6.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Define Scope',
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  define,
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.black54),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                                    child: Divider(
                                      height: 6.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Measurement Phase',
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  measurement,
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.black54),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                                    child: Divider(
                                      height: 6.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Analysis Phase',
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  analysis,
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.black54),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                                    child: Divider(
                                      height: 6.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Improvement Phase',
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  improvement,
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.black54),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                                    child: Divider(
                                      height: 6.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Control Phase',
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  control,
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.black54),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                                    child: Divider(
                                      height: 6.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Project Summary Report',
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  projectSummary,
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.black54),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                                    child: Divider(
                                      height: 6.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Close Out',
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  closeOut,
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.black54),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        ExpansionTile(
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      '5. Project Resources and Costs',
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {},
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(
                                        'Project Team',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 20.0, right: 15.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              projectTeam.join(', ').toString(),
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.black54),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                                    child: Divider(
                                      height: 6.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(
                                        'Support Resources',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 20.0, right: 15.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              supportResources.join(', ').toString(),
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.black54),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                                    child: Divider(
                                      height: 6.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(
                                        'Special Needs',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 20.0, right: 15.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              specialNeeds.join(', ').toString(),
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.black54),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        ExpansionTile(
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      '6. Costing',
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {},
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Cost Type',
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  costType,
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.black54),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                                    child: Divider(
                                      height: 6.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Vendor / Labor Names',
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  vendor,
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.black54),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                                    child: Divider(
                                      height: 6.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Rate (IDR)',
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'IDR ${formatter.format(rate)}',
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.black54),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                                    child: Divider(
                                      height: 6.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Quantity',
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  quantity.toString(),
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.black54),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                                    child: Divider(
                                      height: 6.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Amount',
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  formatter.format(amount),
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.black54),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        ExpansionTile(
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      '7. Project Benefits and Customers',
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {},
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Process Owner',
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  processOwner,
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.black54),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                                    child: Divider(
                                      height: 6.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Key Stakeholders',
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  keyStakeholders,
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.black54),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                                    child: Divider(
                                      height: 6.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Final Customer',
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  finalCustomer,
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.black54),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                                    child: Divider(
                                      height: 6.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Expected Benefits',
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  formatter.format(expectedBenefits),
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.black54),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        ExpansionTile(
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      '8. Estimated Benefit',
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {},
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Type of Benefit',
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  typeBenefits,
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.black54),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                                    child: Divider(
                                      height: 6.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Estimated Benefit',
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  formatter.format(estimatedBenefits),
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.black54),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                                    child: Divider(
                                      height: 6.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(
                                        'Describe Basis of Estimate',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 20.0, right: 15.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              basisEstimate,
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.black54),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        ExpansionTile(
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      '9. Risk, Constraints and Assumption',
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {},
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(
                                        'Risks',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 20.0, right: 15.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              risks,
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.black54),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                                    child: Divider(
                                      height: 6.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(
                                        'Constraints',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 20.0, right: 15.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              constraints,
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.black54),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                                    child: Divider(
                                      height: 6.0,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(
                                        'Assumption',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 20.0, right: 15.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              assumption,
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.black54),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
            },
          )
        ],
      ),
    );
  }
}
