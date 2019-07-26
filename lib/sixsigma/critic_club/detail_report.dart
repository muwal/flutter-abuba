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
                  'Critics Club Worksheet',
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
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          ExpansionTile(
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        '1. Finding Someone to Challange your Idea',
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: 150.0,
                                            child: Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Nama Project',
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black87,),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 150.0,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Cost Saving',
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
                                      padding:
                                          const EdgeInsets.only(bottom: 0.0),
                                      child: Divider(
                                        height: 6.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: 150.0,
                                            child: Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Jelaskan Ide Anda',
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black87,),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 150.0,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Meningkatkan penjualan dengan melakukan upselling oleh cashier',
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
                                      padding:
                                          const EdgeInsets.only(bottom: 0.0),
                                      child: Divider(
                                        height: 6.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: 150.0,
                                            child: Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Siapa saja pihak yang mungkin akan memiliki perbedaan perspektif dengan Anda dalam project ini',
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black87,),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 150.0,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        'Awal, Cello, Jody',
                                                        style: TextStyle(
                                                            fontSize: 12.0,
                                                            color: Colors.black54),
                                                        textAlign: TextAlign.end,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Container(
                                                      padding: EdgeInsets.only(top: 10.0),
                                                        alignment: Alignment.centerRight,
                                                        child: SizedBox(
                                                          height: 20.0,
                                                          width: 70.0,
                                                          child: OutlineButton(
                                                            borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                                                            highlightedBorderColor: AbubaPallate.menuBluebird,
                                                            onPressed: () {
                                                              setState(() {
                                                                showNote = !showNote;
                                                              });
                                                            },
                                                            child: Text(
                                                              'NOTE',
                                                              style: TextStyle(color: AbubaPallate.menuBluebird, fontSize: 12.0),
                                                            ),
                                                          ),
                                                        )
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    showNote
                                        ? Padding(
                                      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                          ),
                                        ),
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Note',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontWeight: FontWeight.w700),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    '-',
                                                    style: TextStyle(
                                                      color: Colors.black38,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                        : Container(),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(bottom: 0.0),
                                      child: Divider(
                                        height: 6.0,
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: 150.0,
                                            child: Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Siapa saja yang paling sering tidak sependapat dengan Anda di project sebelumnya',
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black87,),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 150.0,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.end,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        'Awal, Cello, Jody',
                                                        style: TextStyle(
                                                            fontSize: 12.0,
                                                            color: Colors.black54),
                                                        textAlign: TextAlign.end,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Container(
                                                        padding: EdgeInsets.only(top: 10.0),
                                                        alignment: Alignment.centerRight,
                                                        child: SizedBox(
                                                          height: 20.0,
                                                          width: 70.0,
                                                          child: OutlineButton(
                                                            borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                                                            highlightedBorderColor: AbubaPallate.menuBluebird,
                                                            onPressed: () {
                                                              setState(() {
                                                                showNote = !showNote;
                                                              });
                                                            },
                                                            child: Text(
                                                              'NOTE',
                                                              style: TextStyle(color: AbubaPallate.menuBluebird, fontSize: 12.0),
                                                            ),
                                                          ),
                                                        )
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    showNote
                                        ? Padding(
                                      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                          ),
                                        ),
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Note',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontWeight: FontWeight.w700),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    '-',
                                                    style: TextStyle(
                                                      color: Colors.black38,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                        : Container(),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(bottom: 0.0),
                                      child: Divider(
                                        height: 6.0,
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: 150.0,
                                            child: Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Siapa saja pihak yang memiliki “gaya bekerja” yang berbeda dengan Anda',
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black87,),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 150.0,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.end,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        'Awal, Cello, Jody',
                                                        style: TextStyle(
                                                            fontSize: 12.0,
                                                            color: Colors.black54),
                                                        textAlign: TextAlign.end,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Container(
                                                        padding: EdgeInsets.only(top: 10.0),
                                                        alignment: Alignment.centerRight,
                                                        child: SizedBox(
                                                          height: 20.0,
                                                          width: 70.0,
                                                          child: OutlineButton(
                                                            borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                                                            highlightedBorderColor: AbubaPallate.menuBluebird,
                                                            onPressed: () {
                                                              setState(() {
                                                                showNote = !showNote;
                                                              });
                                                            },
                                                            child: Text(
                                                              'NOTE',
                                                              style: TextStyle(color: AbubaPallate.menuBluebird, fontSize: 12.0),
                                                            ),
                                                          ),
                                                        )
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    showNote
                                        ? Padding(
                                      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                          ),
                                        ),
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Note',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontWeight: FontWeight.w700),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    '-',
                                                    style: TextStyle(
                                                      color: Colors.black38,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                        : Container(),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(bottom: 0.0),
                                      child: Divider(
                                        height: 6.0,
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: 150.0,
                                            child: Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Siapa saja yang pendapatnya Anda hargai namun sering tidak Anda jalankan',
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black87,),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 150.0,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.end,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        'Awal, Cello, Jody',
                                                        style: TextStyle(
                                                            fontSize: 12.0,
                                                            color: Colors.black54),
                                                        textAlign: TextAlign.end,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Container(
                                                        padding: EdgeInsets.only(top: 10.0),
                                                        alignment: Alignment.centerRight,
                                                        child: SizedBox(
                                                          height: 20.0,
                                                          width: 70.0,
                                                          child: OutlineButton(
                                                            borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                                                            highlightedBorderColor: AbubaPallate.menuBluebird,
                                                            onPressed: () {
                                                              setState(() {
                                                                showNote = !showNote;
                                                              });
                                                            },
                                                            child: Text(
                                                              'NOTE',
                                                              style: TextStyle(color: AbubaPallate.menuBluebird, fontSize: 12.0),
                                                            ),
                                                          ),
                                                        )
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    showNote
                                        ? Padding(
                                      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                          ),
                                        ),
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Note',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontWeight: FontWeight.w700),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    '-',
                                                    style: TextStyle(
                                                      color: Colors.black38,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                        : Container(),
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
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        '2. Potential Critics',
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: 150.0,
                                            child: Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Apa yang kira kira Anda lupa atau terlewatkan saat mengajukan ide ini ?',
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black87,),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 150.0,
                                            child: Container(
                                              width: 150.0,
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'Data Collection',
                                                          style: TextStyle(
                                                              fontSize: 12.0,
                                                              color: Colors.black54),
                                                          textAlign: TextAlign.end,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: <Widget>[
                                                      Container(
                                                          padding: EdgeInsets.only(top: 10.0),
                                                          alignment: Alignment.centerRight,
                                                          child: SizedBox(
                                                            height: 20.0,
                                                            width: 70.0,
                                                            child: OutlineButton(
                                                              borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                                                              highlightedBorderColor: AbubaPallate.menuBluebird,
                                                              onPressed: () {
                                                                setState(() {
                                                                  showNote = !showNote;
                                                                });
                                                              },
                                                              child: Text(
                                                                'NOTE',
                                                                style: TextStyle(color: AbubaPallate.menuBluebird, fontSize: 12.0),
                                                              ),
                                                            ),
                                                          )
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    showNote
                                        ? Padding(
                                      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                          ),
                                        ),
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Note',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontWeight: FontWeight.w700),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    '-',
                                                    style: TextStyle(
                                                      color: Colors.black38,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                        : Container(),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(bottom: 0.0),
                                      child: Divider(
                                        height: 6.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: 150.0,
                                            child: Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Apa saja pengaruh yang dihasilkan dari ide Anda ini ?',
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black87,),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 150.0,
                                            child: Container(
                                              width: 150.0,
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'Cost Saving',
                                                          style: TextStyle(
                                                              fontSize: 12.0,
                                                              color: Colors.black54),
                                                          textAlign: TextAlign.end,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: <Widget>[
                                                      Container(
                                                          padding: EdgeInsets.only(top: 10.0),
                                                          alignment: Alignment.centerRight,
                                                          child: SizedBox(
                                                            height: 20.0,
                                                            width: 70.0,
                                                            child: OutlineButton(
                                                              borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                                                              highlightedBorderColor: AbubaPallate.menuBluebird,
                                                              onPressed: () {
                                                                setState(() {
                                                                  showNote = !showNote;
                                                                });
                                                              },
                                                              child: Text(
                                                                'NOTE',
                                                                style: TextStyle(color: AbubaPallate.menuBluebird, fontSize: 12.0),
                                                              ),
                                                            ),
                                                          )
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    showNote
                                        ? Padding(
                                      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                          ),
                                        ),
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Note',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontWeight: FontWeight.w700),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    '-',
                                                    style: TextStyle(
                                                      color: Colors.black38,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                        : Container(),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(bottom: 0.0),
                                      child: Divider(
                                        height: 6.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: 150.0,
                                            child: Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Apabila Anda menjadi stakeholder, apa yang akan Anda pikirkan ?',
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black87,),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 150.0,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.end,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        'Happy',
                                                        style: TextStyle(
                                                            fontSize: 12.0,
                                                            color: Colors.black54),
                                                        textAlign: TextAlign.end,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Container(
                                                        padding: EdgeInsets.only(top: 10.0),
                                                        alignment: Alignment.centerRight,
                                                        child: SizedBox(
                                                          height: 20.0,
                                                          width: 70.0,
                                                          child: OutlineButton(
                                                            borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                                                            highlightedBorderColor: AbubaPallate.menuBluebird,
                                                            onPressed: () {
                                                              setState(() {
                                                                showNote = !showNote;
                                                              });
                                                            },
                                                            child: Text(
                                                              'NOTE',
                                                              style: TextStyle(color: AbubaPallate.menuBluebird, fontSize: 12.0),
                                                            ),
                                                          ),
                                                        )
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    showNote
                                        ? Padding(
                                      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                          ),
                                        ),
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Note',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontWeight: FontWeight.w700),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    '-',
                                                    style: TextStyle(
                                                      color: Colors.black38,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                        : Container(),

                                    Padding(
                                      padding:
                                      const EdgeInsets.only(bottom: 0.0),
                                      child: Divider(
                                        height: 6.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: 150.0,
                                            child: Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Apa saja yang kira – kira akan mengecewakan stakeholder ?',
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black87,),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 150.0,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.end,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        'Happy',
                                                        style: TextStyle(
                                                            fontSize: 12.0,
                                                            color: Colors.black54),
                                                        textAlign: TextAlign.end,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Container(
                                                        padding: EdgeInsets.only(top: 10.0),
                                                        alignment: Alignment.centerRight,
                                                        child: SizedBox(
                                                          height: 20.0,
                                                          width: 70.0,
                                                          child: OutlineButton(
                                                            borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                                                            highlightedBorderColor: AbubaPallate.menuBluebird,
                                                            onPressed: () {
                                                              setState(() {
                                                                showNote = !showNote;
                                                              });
                                                            },
                                                            child: Text(
                                                              'NOTE',
                                                              style: TextStyle(color: AbubaPallate.menuBluebird, fontSize: 12.0),
                                                            ),
                                                          ),
                                                        )
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    showNote
                                        ? Padding(
                                      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                          ),
                                        ),
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Note',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontWeight: FontWeight.w700),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    '-',
                                                    style: TextStyle(
                                                      color: Colors.black38,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                        : Container(),

                                    Padding(
                                      padding:
                                      const EdgeInsets.only(bottom: 0.0),
                                      child: Divider(
                                        height: 6.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: 150.0,
                                            child: Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Faktor apa saja yang belum Anda pertimbangkan ?',
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: Colors.black87,),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 150.0,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.end,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        'Happy',
                                                        style: TextStyle(
                                                            fontSize: 12.0,
                                                            color: Colors.black54),
                                                        textAlign: TextAlign.end,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Container(
                                                        padding: EdgeInsets.only(top: 10.0),
                                                        alignment: Alignment.centerRight,
                                                        child: SizedBox(
                                                          height: 20.0,
                                                          width: 70.0,
                                                          child: OutlineButton(
                                                            borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                                                            highlightedBorderColor: AbubaPallate.menuBluebird,
                                                            onPressed: () {
                                                              setState(() {
                                                                showNote = !showNote;
                                                              });
                                                            },
                                                            child: Text(
                                                              'NOTE',
                                                              style: TextStyle(color: AbubaPallate.menuBluebird, fontSize: 12.0),
                                                            ),
                                                          ),
                                                        )
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    showNote
                                        ? Padding(
                                      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                          ),
                                        ),
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Note',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontWeight: FontWeight.w700),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    '-',
                                                    style: TextStyle(
                                                      color: Colors.black38,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                        : Container(),

                                    Padding(
                                      padding:
                                      const EdgeInsets.only(bottom: 0.0),
                                      child: Divider(
                                        height: 6.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: 150.0,
                                            child: Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Bagaimana pengaruhnya ide ini terhadap biaya ?',
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black87,),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 150.0,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.end,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        'Happy',
                                                        style: TextStyle(
                                                            fontSize: 12.0,
                                                            color: Colors.black54),
                                                        textAlign: TextAlign.end,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Container(
                                                        padding: EdgeInsets.only(top: 10.0),
                                                        alignment: Alignment.centerRight,
                                                        child: SizedBox(
                                                          height: 20.0,
                                                          width: 70.0,
                                                          child: OutlineButton(
                                                            borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                                                            highlightedBorderColor: AbubaPallate.menuBluebird,
                                                            onPressed: () {
                                                              setState(() {
                                                                showNote = !showNote;
                                                              });
                                                            },
                                                            child: Text(
                                                              'NOTE',
                                                              style: TextStyle(color: AbubaPallate.menuBluebird, fontSize: 12.0),
                                                            ),
                                                          ),
                                                        )
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    showNote
                                        ? Padding(
                                      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                          ),
                                        ),
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Note',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontWeight: FontWeight.w700),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    '-',
                                                    style: TextStyle(
                                                      color: Colors.black38,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                        : Container(),

                                    Padding(
                                      padding:
                                      const EdgeInsets.only(bottom: 0.0),
                                      child: Divider(
                                        height: 6.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: 150.0,
                                            child: Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Sebutkan 5 hal yang mungkin salah dengan ide Anda ini !',
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black87,),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 150.0,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.end,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        'Happy',
                                                        style: TextStyle(
                                                            fontSize: 12.0,
                                                            color: Colors.black54),
                                                        textAlign: TextAlign.end,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Container(
                                                        padding: EdgeInsets.only(top: 10.0),
                                                        alignment: Alignment.centerRight,
                                                        child: SizedBox(
                                                          height: 20.0,
                                                          width: 70.0,
                                                          child: OutlineButton(
                                                            borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                                                            highlightedBorderColor: AbubaPallate.menuBluebird,
                                                            onPressed: () {
                                                              setState(() {
                                                                showNote = !showNote;
                                                              });
                                                            },
                                                            child: Text(
                                                              'NOTE',
                                                              style: TextStyle(color: AbubaPallate.menuBluebird, fontSize: 12.0),
                                                            ),
                                                          ),
                                                        )
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    showNote
                                        ? Padding(
                                      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                          ),
                                        ),
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Note',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontWeight: FontWeight.w700),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    '-',
                                                    style: TextStyle(
                                                      color: Colors.black38,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                        : Container(),

                                    Padding(
                                      padding:
                                      const EdgeInsets.only(bottom: 0.0),
                                      child: Divider(
                                        height: 6.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: 150.0,
                                            child: Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Sebutkan 5 hal yang mungkin salah dengan ide Anda ini !',
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black87,),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 150.0,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.end,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        'Happy',
                                                        style: TextStyle(
                                                            fontSize: 12.0,
                                                            color: Colors.black54),
                                                        textAlign: TextAlign.end,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Container(
                                                        padding: EdgeInsets.only(top: 10.0),
                                                        alignment: Alignment.centerRight,
                                                        child: SizedBox(
                                                          height: 20.0,
                                                          width: 70.0,
                                                          child: OutlineButton(
                                                            borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                                                            highlightedBorderColor: AbubaPallate.menuBluebird,
                                                            onPressed: () {
                                                              setState(() {
                                                                showNote = !showNote;
                                                              });
                                                            },
                                                            child: Text(
                                                              'NOTE',
                                                              style: TextStyle(color: AbubaPallate.menuBluebird, fontSize: 12.0),
                                                            ),
                                                          ),
                                                        )
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    showNote
                                        ? Padding(
                                      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                          ),
                                        ),
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Note',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontWeight: FontWeight.w700),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    '-',
                                                    style: TextStyle(
                                                      color: Colors.black38,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                        : Container(),

                                    Padding(
                                      padding:
                                      const EdgeInsets.only(bottom: 0.0),
                                      child: Divider(
                                        height: 6.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: 150.0,
                                            child: Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Apa hal terburuk yang mungkin terjadi karena kesalahan tersebut di atas ?',
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black87,),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 150.0,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.end,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        'Happy',
                                                        style: TextStyle(
                                                            fontSize: 12.0,
                                                            color: Colors.black54),
                                                        textAlign: TextAlign.end,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Container(
                                                        padding: EdgeInsets.only(top: 10.0),
                                                        alignment: Alignment.centerRight,
                                                        child: SizedBox(
                                                          height: 20.0,
                                                          width: 70.0,
                                                          child: OutlineButton(
                                                            borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                                                            highlightedBorderColor: AbubaPallate.menuBluebird,
                                                            onPressed: () {
                                                              setState(() {
                                                                showNote = !showNote;
                                                              });
                                                            },
                                                            child: Text(
                                                              'NOTE',
                                                              style: TextStyle(color: AbubaPallate.menuBluebird, fontSize: 12.0),
                                                            ),
                                                          ),
                                                        )
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    showNote
                                        ? Padding(
                                      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                          ),
                                        ),
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Note',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontWeight: FontWeight.w700),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    '-',
                                                    style: TextStyle(
                                                      color: Colors.black38,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                        : Container(),

                                    Padding(
                                      padding:
                                      const EdgeInsets.only(bottom: 0.0),
                                      child: Divider(
                                        height: 6.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: 150.0,
                                            child: Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Apa kira – kira yang akan berpotensi merugikan perusahaan dari ide Anda ini ?',
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black87,),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 150.0,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.end,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        'Happy',
                                                        style: TextStyle(
                                                            fontSize: 12.0,
                                                            color: Colors.black54),
                                                        textAlign: TextAlign.end,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Container(
                                                        padding: EdgeInsets.only(top: 10.0),
                                                        alignment: Alignment.centerRight,
                                                        child: SizedBox(
                                                          height: 20.0,
                                                          width: 70.0,
                                                          child: OutlineButton(
                                                            borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                                                            highlightedBorderColor: AbubaPallate.menuBluebird,
                                                            onPressed: () {
                                                              setState(() {
                                                                showNote = !showNote;
                                                              });
                                                            },
                                                            child: Text(
                                                              'NOTE',
                                                              style: TextStyle(color: AbubaPallate.menuBluebird, fontSize: 12.0),
                                                            ),
                                                          ),
                                                        )
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    showNote
                                        ? Padding(
                                      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                          ),
                                        ),
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Note',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontWeight: FontWeight.w700),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    '-',
                                                    style: TextStyle(
                                                      color: Colors.black38,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                        : Container(),

                                    Padding(
                                      padding:
                                      const EdgeInsets.only(bottom: 0.0),
                                      child: Divider(
                                        height: 6.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: 150.0,
                                            child: Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Apakah ide ini pernah gagal di masa lalu ?',
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black87,),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 150.0,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.end,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        'Happy',
                                                        style: TextStyle(
                                                            fontSize: 12.0,
                                                            color: Colors.black54),
                                                        textAlign: TextAlign.end,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Container(
                                                        padding: EdgeInsets.only(top: 10.0),
                                                        alignment: Alignment.centerRight,
                                                        child: SizedBox(
                                                          height: 20.0,
                                                          width: 70.0,
                                                          child: OutlineButton(
                                                            borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                                                            highlightedBorderColor: AbubaPallate.menuBluebird,
                                                            onPressed: () {
                                                              setState(() {
                                                                showNote = !showNote;
                                                              });
                                                            },
                                                            child: Text(
                                                              'NOTE',
                                                              style: TextStyle(color: AbubaPallate.menuBluebird, fontSize: 12.0),
                                                            ),
                                                          ),
                                                        )
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    showNote
                                        ? Padding(
                                      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                          ),
                                        ),
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Note',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontWeight: FontWeight.w700),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    '-',
                                                    style: TextStyle(
                                                      color: Colors.black38,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                        : Container(),

                                    Padding(
                                      padding:
                                      const EdgeInsets.only(bottom: 0.0),
                                      child: Divider(
                                        height: 6.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: 150.0,
                                            child: Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Pendekatan apa yang lebih baik dan harus dilakukan agar masalah di masa lalu tidak terulang lagi ?',
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black87,),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 150.0,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.end,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        'Happy',
                                                        style: TextStyle(
                                                            fontSize: 12.0,
                                                            color: Colors.black54),
                                                        textAlign: TextAlign.end,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Container(
                                                        padding: EdgeInsets.only(top: 10.0),
                                                        alignment: Alignment.centerRight,
                                                        child: SizedBox(
                                                          height: 20.0,
                                                          width: 70.0,
                                                          child: OutlineButton(
                                                            borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                                                            highlightedBorderColor: AbubaPallate.menuBluebird,
                                                            onPressed: () {
                                                              setState(() {
                                                                showNote = !showNote;
                                                              });
                                                            },
                                                            child: Text(
                                                              'NOTE',
                                                              style: TextStyle(color: AbubaPallate.menuBluebird, fontSize: 12.0),
                                                            ),
                                                          ),
                                                        )
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    showNote
                                        ? Padding(
                                      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                          ),
                                        ),
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Note',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontWeight: FontWeight.w700),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    '-',
                                                    style: TextStyle(
                                                      color: Colors.black38,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                        : Container(),

                                    Padding(
                                      padding:
                                      const EdgeInsets.only(bottom: 0.0),
                                      child: Divider(
                                        height: 6.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: 150.0,
                                            child: Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Apa kerugian bagi perusahaan atau proses bila ide Anda ini tidak dijalankan ? ',
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black87,),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 150.0,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.end,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        'Happy',
                                                        style: TextStyle(
                                                            fontSize: 12.0,
                                                            color: Colors.black54),
                                                        textAlign: TextAlign.end,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Container(
                                                        padding: EdgeInsets.only(top: 10.0),
                                                        alignment: Alignment.centerRight,
                                                        child: SizedBox(
                                                          height: 20.0,
                                                          width: 70.0,
                                                          child: OutlineButton(
                                                            borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                                                            highlightedBorderColor: AbubaPallate.menuBluebird,
                                                            onPressed: () {
                                                              setState(() {
                                                                showNote = !showNote;
                                                              });
                                                            },
                                                            child: Text(
                                                              'NOTE',
                                                              style: TextStyle(color: AbubaPallate.menuBluebird, fontSize: 12.0),
                                                            ),
                                                          ),
                                                        )
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    showNote
                                        ? Padding(
                                      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                          ),
                                        ),
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Note',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontWeight: FontWeight.w700),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    '-',
                                                    style: TextStyle(
                                                      color: Colors.black38,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                        : Container(),
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
