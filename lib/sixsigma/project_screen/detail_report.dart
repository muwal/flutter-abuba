import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailReport extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  var index;
  DetailReport({this.idUser, this.namaUser, this.departmentUser, this.index});

  @override
  _DetailReportState createState() => _DetailReportState();
}

class _DetailReportState extends State<DetailReport>
    with TickerProviderStateMixin {
  AnimationController animationController;

  String userNama;
  String tanggal;
  String no;

  String projectName;
  String createdDate;
  String createdBy;
  String ketPerformance;
  String ketOperational;

  int sampleSize;
  String WhoCollect;
  String noteWhoCollect;

  String WhenCollect;

  String howCollect;
  String noteHowCollect;

  String howUsed;
  String noteHowUsed;

  int dataSource;
  int dataLocation;
  int dataHowCollected;
  int dataHowUsed;
  int dataAdditional;

  bool showNote = false;

  String additionalCollect;
  String noteAdditionalCollect;

  @override
  void initState() {
    super.initState();
    setState(() {

      Firestore.instance
          .collection('dataCollection')
          .document(widget.index)
          .snapshots()
          .listen((data) {
        Timestamp tanggalBantu = data.data['dateCreated'];
        no = data.data['dataCollectionNo'].toString().padLeft(4, '0');
        tanggal = tanggalBantu.toDate().toString().substring(8, 10) +
            '/' +
            tanggalBantu.toDate().toString().substring(5, 7) +
            '/' +
            tanggalBantu.toDate().toString().substring(0, 4);
        projectName = data.data['projectName'];
        Timestamp dateBantu = data.data['date'];
        createdDate = dateBantu.toDate().toString().substring(8, 10) +
            '/' +
            dateBantu.toDate().toString().substring(5, 7) +
            '/' +
            dateBantu.toDate().toString().substring(0, 4);
        ketOperational = data.data['operationalDefinition'];
        ketPerformance = data.data['performanceMeasure'];
        sampleSize = data.data['sampleSize'];
        dataSource = data.data['dataSource'];
        dataSource = data.data['dataLocation'];
        dataSource = data.data['dataHowCollected'];
        dataSource = data.data['dataHowUsed'];
        dataSource = data.data['dataAdditional'];
        noteWhoCollect = data.data['noteCollectData'];
        Timestamp whenBantu = data.data['whenCollect'];
        WhenCollect = whenBantu.toDate().toString().substring(8, 10) +
            '/' +
            whenBantu.toDate().toString().substring(5, 7) +
            '/' +
            whenBantu.toDate().toString().substring(0, 4);

        noteHowCollect = data.data['noteDataCollected'];
        noteHowUsed = data.data['noteDataUsed'];
        noteAdditionalCollect = data.data['noteAdditionalData'];


        Firestore.instance
            .collection('user')
            .where('id', isEqualTo: data.data['userCreated'])
            .snapshots()
            .listen((data2) {
          userNama = data2.documents[0].data['nama'];
        });

        Firestore.instance
            .collection('user')
            .where('id', isEqualTo: data.data['whoCollectData'])
            .snapshots()
            .listen((data2) {
          WhoCollect = data2.documents[0].data['nama'];
        });

        Firestore.instance
            .collection('user')
            .where('id', isEqualTo: data.data['createdBy'])
            .snapshots()
            .listen((data2) {
          createdBy = data2.documents[0].data['nama'];
        });
      });
    });

    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(
        from:
        animationController.value == 0.0 ? 1.0 : animationController.value);
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
                  'Project Screen',
                  style: TextStyle(color: Colors.black12, fontSize: 12.0),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    '|',
                    style: TextStyle(
                        color: AbubaPallate.greenabuba, fontSize: 12.0),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    'Detail Report',
                    style: TextStyle(
                        color: AbubaPallate.greenabuba, fontSize: 12.0),
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
                margin: EdgeInsets.symmetric(horizontal: 15.0),
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15.0),
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'General Info',
                              style: TextStyle(
                                color: AbubaPallate.greenabuba,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Nama Project',
                                    style: TextStyle(
                                      color: Colors.black87
                                    ),
                                  )
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Flexible(
                                    child: Text(
                                      'Project Online Sales',
                                      style: TextStyle(
                                          color: Colors.black38
                                      ),
                                    )
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                    child: Text(
                                      'Deskripsi Project',
                                      style: TextStyle(
                                          color: Colors.black87
                                      ),
                                    )
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Flexible(
                                    child: Text(
                                      'Memperbaiki penjualan di akhir pekan untuk outlet Luar Jabotabek dengan menjalankan system order online',
                                      style: TextStyle(
                                          color: Colors.black38
                                      ),
                                      textAlign: TextAlign.end,
                                    )
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15.0),
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Screen Project Idea',
                              style: TextStyle(
                                  color: AbubaPallate.greenabuba,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.0
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                    child: Text(
                                      '1. Is the word “implement” listed in the description?',
                                      style: TextStyle(
                                          color: Colors.black87
                                      ),
                                    )
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Flexible(
                                    child: Text(
                                      'NO',
                                      style: TextStyle(
                                          color: Colors.black38
                                      ),
                                      textAlign: TextAlign.end,
                                    )
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                    child: Text(
                                      '2. Does the phrase “lack of” or "there is no" appear in the description?',
                                      style: TextStyle(
                                          color: Colors.black87
                                      ),
                                    )
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Flexible(
                                    child: Text(
                                      'NO',
                                      style: TextStyle(
                                          color: Colors.black38
                                      ),
                                      textAlign: TextAlign.end,
                                    )
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                    child: Text(
                                      '3. Does the idea recommend starting or stopping a particular practice?',
                                      style: TextStyle(
                                          color: Colors.black87
                                      ),
                                    )
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Flexible(
                                    child: Text(
                                      'NO',
                                      style: TextStyle(
                                          color: Colors.black38
                                      ),
                                      textAlign: TextAlign.end,
                                    )
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                    child: Text(
                                      '4. Is this process part of the candidate\'s regular job or are they familiar with it?',
                                      style: TextStyle(
                                          color: Colors.black87
                                      ),
                                    )
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Flexible(
                                    child: Text(
                                      'YES',
                                      style: TextStyle(
                                          color: Colors.black38
                                      ),
                                      textAlign: TextAlign.end,
                                    )
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                    child: Text(
                                      '5. Is there anyone in a leadership position willing to sponsor this project?',
                                      style: TextStyle(
                                          color: Colors.black87
                                      ),
                                    )
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Flexible(
                                    child: Text(
                                      'YES',
                                      style: TextStyle(
                                          color: Colors.black38
                                      ),
                                      textAlign: TextAlign.end,
                                    )
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            color: Colors.grey[400],
                            width: MediaQuery.of(context).size.width * 0.5,
                            padding: EdgeInsets.all(5.0),
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                    child: Text(
                                      'RESULT',
                                      style: TextStyle(
                                          color: Colors.white,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600
                                      ),
                                    )
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Flexible(
                                    child: Text(
                                      'PROCEED',
                                      style: TextStyle(
                                          color: AbubaPallate.menuBluebird,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600
                                      ),
                                      textAlign: TextAlign.end,
                                    )
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15.0),
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Determine Project Type',
                              style: TextStyle(
                                  color: AbubaPallate.greenabuba,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.0
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                    child: Text(
                                      '1. Will the project require the design of an entirely new process?',
                                      style: TextStyle(
                                          color: Colors.black87
                                      ),
                                    )
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Flexible(
                                    child: Text(
                                      'NO',
                                      style: TextStyle(
                                          color: Colors.black38
                                      ),
                                      textAlign: TextAlign.end,
                                    )
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                    child: Text(
                                      '2. Will this project likely result in a process with little resemblance to the original process?',
                                      style: TextStyle(
                                          color: Colors.black87
                                      ),
                                    )
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Flexible(
                                    child: Text(
                                      'NO',
                                      style: TextStyle(
                                          color: Colors.black38
                                      ),
                                      textAlign: TextAlign.end,
                                    )
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                    child: Text(
                                      '3. Is the goal of the project to implement a measurement system?',
                                      style: TextStyle(
                                          color: Colors.black87
                                      ),
                                    )
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Flexible(
                                    child: Text(
                                      'NO',
                                      style: TextStyle(
                                          color: Colors.black38
                                      ),
                                      textAlign: TextAlign.end,
                                    )
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                    child: Text(
                                      '4. Are the root cause and solution known?',
                                      style: TextStyle(
                                          color: Colors.black87
                                      ),
                                    )
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Flexible(
                                    child: Text(
                                      'YES',
                                      style: TextStyle(
                                          color: Colors.black38
                                      ),
                                      textAlign: TextAlign.end,
                                    )
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            color: Colors.grey[400],
                            width: MediaQuery.of(context).size.width * 0.5,
                            padding: EdgeInsets.all(5.0),
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                    child: Text(
                                      'RESULT',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600
                                      ),
                                    )
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Flexible(
                                    child: Text(
                                      'PROCESS IMPROVEMENT',
                                      style: TextStyle(
                                          color: AbubaPallate.menuBluebird,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600
                                      ),
                                      textAlign: TextAlign.end,
                                    )
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15.0),
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Goal Statement',
                              style: TextStyle(
                                  color: AbubaPallate.greenabuba,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.0
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                              child: Text(
                                'Meningkatkan Penjualan sebesar 30 % dari Rp 100 Juta menjadi Rp 130 Juta mulai bulan Juni 2019',
                                style: TextStyle(
                                    color: Colors.black87
                                ),
                              )
                          ),
                        ],
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 15.0),
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Results of Weighted Criteria Matrix',
                              style: TextStyle(
                                  color: AbubaPallate.greenabuba,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.0
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 15.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                height: 180.0,
                                width: 150.0,
                                margin: EdgeInsets.only(
                                    top: 30.0),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      color: AbubaPallate
                                          .greenabuba,
                                      height: 50.0,
                                      child: Center(
                                        child: Text(
                                          'TOP PICKS',
                                          style: TextStyle(
                                              color: Colors
                                                  .white,
                                              fontSize: 16.0,
                                              fontWeight:
                                              FontWeight
                                                  .w700),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.grey[200],
                                      height: 120.0,
                                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              '3.8 ; 7.5',
                                              style: TextStyle(
                                                  fontSize: 22.0,
                                                  color: Colors
                                                      .grey,
                                                  fontWeight:
                                                  FontWeight
                                                      .w700),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 180.0,
                                width: 150.0,
                                margin: EdgeInsets.only(
                                    top: 30.0),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      color: Colors.grey,
                                      height: 50.0,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'POTENTIAL INVESTMENT',
                                              style: TextStyle(
                                                  color: Colors
                                                      .white,
                                                  fontSize: 16.0,
                                                  fontWeight:
                                                  FontWeight
                                                      .w700),
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      color: Colors.grey[200],
                                      height: 120.0,
                                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                  fontSize: 22.0,
                                                  color: Colors
                                                      .grey,
                                                  fontWeight:
                                                  FontWeight
                                                      .w700),
                                              textAlign: TextAlign.center,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                height: 180.0,
                                width: 150.0,
                                margin: EdgeInsets.only(
                                    top: 30.0),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      color: Colors.grey,
                                      height: 50.0,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'CONSIDER',
                                              style: TextStyle(
                                                  color: Colors
                                                      .white,
                                                  fontSize: 16.0,
                                                  fontWeight:
                                                  FontWeight
                                                      .w700),
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      color: Colors.grey[200],
                                      height: 120.0,
                                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                  fontSize: 22.0,
                                                  color: Colors
                                                      .grey,
                                                  fontWeight:
                                                  FontWeight
                                                      .w700),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 180.0,
                                width: 150.0,
                                margin: EdgeInsets.only(
                                    top: 30.0),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      color: Colors.grey,
                                      height: 50.0,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'LEAST LIKELY',
                                              style: TextStyle(
                                                  color: Colors
                                                      .white,
                                                  fontSize: 16.0,
                                                  fontWeight:
                                                  FontWeight
                                                      .w700),
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      color: Colors.grey[200],
                                      height: 120.0,
                                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                  fontSize: 22.0,
                                                  color: Colors
                                                      .grey,
                                                  fontWeight:
                                                  FontWeight
                                                      .w700),
                                              textAlign: TextAlign.center,
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
                        ],
                      ),
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
