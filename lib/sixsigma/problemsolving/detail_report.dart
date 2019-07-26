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

class _DetailReportState extends State<DetailReport> with TickerProviderStateMixin {
  AnimationController animationController;

  String userNama;
  String tanggal;
  String no;
  String what;
  List<dynamic> who = [];
  String when;
  String shift;
  String department;
  String divisi;
  String area;
  String why;
  String howSevere;

  String team;
  String champion;
  String leader;
  String recordKeeper;
  List<dynamic> participants = [];

  String tindakanSegera;
  String waktuPelaksanaan;
  String pelaksana;

  String tindakanPermanen;
  String whoTindakanPermanen;
  String whenTindakanPermanen;
  String efektifitas;
  String whoVerifikasi;
  String whenVerifikasi;
  String whoValidasi;
  String whenValidasi;

  List<dynamic> taskLeader = [];
  List<dynamic> duedateLeader = [];
  List<dynamic> taskRecordKeeper = [];
  List<dynamic> duedateRecordKeeper = [];
  List<dynamic> taskParticipants = [];
  List<dynamic> duedateParticipants = [];
  List<dynamic> personTask = [];

  @override
  void initState() {
    super.initState();
    Firestore.instance.collection('problemSolving').document(widget.index).snapshots().listen((data) {
      setState(() {
        Timestamp tanggalBantu = data.data['dateCreated'];
        tanggal = tanggalBantu.toDate().toString().substring(8, 10) + '/' + tanggalBantu.toDate().toString().substring(5, 7) + '/' + tanggalBantu.toDate().toString().substring(0, 4);
        no = data.data['problemSolvingNo'].toString().padLeft(4, '0');
        Timestamp whenBantu = data.data['dateTerjadi'];
        when = whenBantu.toDate().toString().substring(8, 10) + '/' + whenBantu.toDate().toString().substring(5, 7) + '/' + whenBantu.toDate().toString().substring(0, 4) + '  -' + whenBantu.toDate().toString().substring(10, 16);
        howSevere = data.data['howSevere'];

        taskLeader = data.data['taskLeader'];
        duedateLeader = data.data['duedateLeader'];
        taskRecordKeeper = data.data['taskRecordKeeper'];
        duedateRecordKeeper = data.data['duedateRecordKeeper'];
        taskParticipants = data.data['taskParticipants'];
        duedateParticipants = data.data['duedateParticipants'];
        personTask = data.data['personTaskName'];

        who = data.data['whoTerlibatName'];

        tindakanSegera = data.data['tindakanSegera'];
        Timestamp waktuBantu = data.data['waktuPelaksanaan'];
        waktuPelaksanaan = waktuBantu.toDate().toString().substring(8, 10) + '/' + waktuBantu.toDate().toString().substring(5, 7) + '/' + waktuBantu.toDate().toString().substring(0, 4);

        Firestore.instance.collection('user').where('id', isEqualTo: data.data['pelaksana']).snapshots().listen((data13) {
          pelaksana = data13.documents[0].data['nama'];
        });
        
        Firestore.instance.collection('tindakanPermanen_problemSolving').where('id', isEqualTo: data.data['tindakanPermanen']).snapshots().listen((data14) {
          tindakanPermanen = data14.documents[0].data['tindakan'];
        });

        Firestore.instance.collection('user').where('id', isEqualTo: data.data['whoTindakanPermanen']).snapshots().listen((data15) {
          whoTindakanPermanen = data15.documents[0].data['nama'];
        });
        
        whenTindakanPermanen = data.data['whenTindakanPermanen'].toString().substring(8, 10) + '/' + data.data['whenTindakanPermanen'].toString().substring(5, 7) + '/' + data.data['whenTindakanPermanen'].toString().substring(0, 4);

        Firestore.instance.collection('ukurEfektifitas_problemSolving').where('id', isEqualTo: data.data['efektifitas']).snapshots().listen((data16) {
          efektifitas = data16.documents[0].data['ukur'];
        });
        
        Firestore.instance.collection('user').where('id', isEqualTo: data.data['whoVerifikasi']).snapshots().listen((data17) {
          whoVerifikasi = data17.documents[0].data['nama'];
        });

        whenVerifikasi = data.data['whenVerifikasi'].toString().substring(8, 10) + '/' + data.data['whenVerifikasi'].toString().substring(5, 7) + '/' + data.data['whenVerifikasi'].toString().substring(0, 4);

        Firestore.instance.collection('user').where('id', isEqualTo: data.data['whoValidasi']).snapshots().listen((data18) {
          whoValidasi = data18.documents[0].data['nama'];
        });

        whenValidasi = data.data['whenValidasi'].toString().substring(8, 10) + '/' + data.data['whenValidasi'].toString().substring(5, 7) + '/' + data.data['whenValidasi'].toString().substring(0, 4);

        if (data.data['team'] == true) {
          team = 'YES';
          participants = data.data['participantsName'];

          Firestore.instance.collection('user').where('id', isEqualTo: data.data['champion']).snapshots().listen((data10) {
            champion = data10.documents[0].data['nama'];
          });

          Firestore.instance.collection('user').where('id', isEqualTo: data.data['leader']).snapshots().listen((data11) {
            leader = data11.documents[0].data['nama'];
          });

          Firestore.instance.collection('user').where('id', isEqualTo: data.data['recordKeeper']).snapshots().listen((data12) {
            recordKeeper = data12.documents[0].data['nama'];
          });
        } else {
          team = 'NO';
          participants = [];
          champion = '-';
          leader = '-';
          recordKeeper = '-';
        }

        Firestore.instance.collection('user').where('id', isEqualTo: data.data['userCreated']).snapshots().listen((data2) {
          userNama = data2.documents[0].data['nama'];
        });

        Firestore.instance.collection('what_problemSolving').where('id', isEqualTo: data.data['problem']).snapshots().listen((data3) {
          what = data3.documents[0].data['what'];
        });
        
        Firestore.instance.collection('shift').where('id', isEqualTo: data.data['shift']).snapshots().listen((data5) {
          shift = data5.documents[0].data['shift'];
        });

        Firestore.instance.collection('department').where('id', isEqualTo: data.data['department']).snapshots().listen((data6) {
          department = data6.documents[0].data['department'];
        });

        Firestore.instance.collection('divisi').where('id', isEqualTo: data.data['divisi']).snapshots().listen((data7) {
          divisi = data7.documents[0].data['divisi'];
        });

        Firestore.instance.collection('area').where('id', isEqualTo: data.data['area']).snapshots().listen((data8) {
          area = data8.documents[0].data['area'];
        });

        Firestore.instance.collection('konsekuensi_problemSolving').where('id', isEqualTo: data.data['why']).snapshots().listen((data9) {
          why = data9.documents[0].data['konsekuensi'];
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
    return ListView(
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
                        padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
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
                                      'Problem Solving No. PSV-$no',
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
                                    '1. Identify Problem',
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
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'WHAT',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 0.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: 150.0,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                'Apa masalah yang sedang terjadi?',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black54),
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
                                                what,
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black87),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Divider(
                                    height: 12.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'WHO',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 0.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: 150.0,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                'Siapa yang terlibat dengan masalah ini?',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black54),
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
                                                who.join(', ').toString(),
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black87),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Divider(
                                    height: 12.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'WHEN',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 0.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: 150.0,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                'Kapan masalah ini terjadi?',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black54),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 150.0,
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    when,
                                                    style: TextStyle(
                                                        fontSize: 12.0,
                                                        color: Colors.black87),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    shift,
                                                    style: TextStyle(
                                                        fontSize: 12.0,
                                                        color: Colors.black87),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Divider(
                                    height: 12.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'WHERE',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 0.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: 150.0,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                'Dimana lokasi masalah ditemukan?',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black54),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 150.0,
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    department,
                                                    style: TextStyle(
                                                        fontSize: 12.0,
                                                        color: Colors.black87),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    '$divisi - $area',
                                                    style: TextStyle(
                                                        fontSize: 12.0,
                                                        color: Colors.black87),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Divider(
                                    height: 12.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'WHY',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 0.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: 150.0,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                'Mengapa temuan / issue ini bisa menjadi masalah. Apa konsekuensi dari masalah ini?',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black54),
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
                                                why,
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black87),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Divider(
                                    height: 12.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'HOW SEVERE',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: 150.0,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                'Seberapa parah akibat yang ditimbulkan dari masalah ini?',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black54),
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
                                                howSevere,
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black87),
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
                                    '2. Identify Team',
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
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'TEAM',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 0.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: 150.0,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                'Apakah untuk menyelesaikan masalah ini perlu dibentuk tim khusus?',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black54),
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
                                                team,
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: team == 'YES' ? Colors.green : Colors.redAccent,
                                                    fontWeight: FontWeight.w700
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Divider(
                                    height: 12.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'CHAMPION',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 0.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: 150.0,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                'Mentor, mengarahkan dan membantu tim menjelaskan ke pihak management',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black54),
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
                                                champion,
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black87),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Divider(
                                    height: 12.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'LEADER',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 0.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: 150.0,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                'Bertanggung jawab pada pelaksanaan teknis, mengadakan meeting, menyiapkan fasilitas pada team dan report kepada champion',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black54),
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
                                                leader,
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black87),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Divider(
                                    height: 12.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'RECORD KEEPER',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 0.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: 150.0,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                'Mencatat perkembangan penyelesaian masalah dan membuat minute of meeting',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black54),
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
                                                recordKeeper,
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black87),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Divider(
                                    height: 12.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'PARTICIPANTS',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            'Memberi ide, menjalankan tugas dan melaporkan perkembangan kepada leader secara tepat waktu',
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
                                  padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            participants.length == 0 ? '-' : participants.join(', ').toString(),
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black87),
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
                                    '3. Immediate Action',
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
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'TINDAKAN SEGERA',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 0.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            'Tindakan apa yang harus dilakukan dengan segera agar masalah tidak membesar?',
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
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 0.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            tindakanSegera,
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black87
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Divider(
                                    height: 12.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'WAKTU PELAKSANAAN',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 0.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: 150.0,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                'Kapan tindakan tersebut akan dilaksanakan?',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black54),
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
                                                waktuPelaksanaan,
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black87),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Divider(
                                    height: 12.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'PELAKSANA',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: 150.0,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                'Siapa yang akan melakukan tindakan segera tersebut?',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black54),
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
                                                pelaksana,
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black87),
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
                                    '5. Corrective Action Plan',
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
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'WHAT',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 0.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: 150.0,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                'Apa tindakan permanen yang akan dilakukan untuk menyelesaikan masalah tersebut?',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black54),
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
                                                tindakanPermanen,
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black87
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Divider(
                                    height: 12.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'WHO',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 0.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: 150.0,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                'Siapa penanggung jawab dari tindakan permanen tersebut?',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black54),
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
                                                whoTindakanPermanen,
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black87),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Divider(
                                    height: 12.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'WHEN',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 0.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: 150.0,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                'Kapan tindakan permanen itu akan dijalankan?',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black54),
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
                                                whenTindakanPermanen,
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black87),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Divider(
                                    height: 12.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'EFFECTIVENESS',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 0.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: 150.0,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                'Bagaimana cara mengukur efektifitas dari tindakan permanen tersebut?',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black54),
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
                                                efektifitas,
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black87),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Divider(
                                    height: 12.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'VERIFICATION - WHO',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 0.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: 150.0,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                'Siapa yang bertanggung jawab melakukan verifikasi?',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black54),
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
                                                whoVerifikasi,
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black87),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Divider(
                                    height: 12.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'VERIFICATION - WHEN',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 0.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: 150.0,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                'Kapan verifikasi akan dilakukan. Sebaiknya tidak lebih dari 7 hari setelah implementasi tindakan permanen',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black54),
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
                                                whenVerifikasi,
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black87),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Divider(
                                    height: 12.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'VALIDATION - WHO',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 0.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: 150.0,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                'Siapa yang bertanggung jawab melakukan validasi?',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black54),
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
                                                whoValidasi,
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black87),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Divider(
                                    height: 12.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'VALIDATION - WHEN',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: 150.0,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                'Kapan validasi akan dilakukan? dilakukan setelah 6 bulan pelaksanaan action plan',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black54),
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
                                                whenValidasi,
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black87),
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
                                    '6. Complete Action Plan',
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
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          leader,
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          'LEADER',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                taskLeader.length == 0
                                  ? Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15.0, right: 15.0, bottom: 0.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                width: 150.0,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        '-',
                                                        style: TextStyle(
                                                            fontSize: 12.0,
                                                            color: Colors.black54),
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
                                                        '-',
                                                        style: TextStyle(
                                                            fontSize: 12.0,
                                                            color: Colors.black87
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      children: List.generate(taskLeader.length, (index) {
                                        return Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0, right: 15.0, bottom: 0.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                    width: 150.0,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            taskLeader[index],
                                                            style: TextStyle(
                                                                fontSize: 12.0,
                                                                color: Colors.black54),
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
                                                            duedateLeader[index],
                                                            style: TextStyle(
                                                                fontSize: 12.0,
                                                                color: Colors.black87
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      }).toList(),
                                    ),

                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Divider(
                                    height: 12.0,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0, bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          recordKeeper,
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          'RECORD KEEPER',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                taskRecordKeeper.length == 0
                                  ? Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15.0, right: 15.0, bottom: 0.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                width: 150.0,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        '-',
                                                        style: TextStyle(
                                                            fontSize: 12.0,
                                                            color: Colors.black54),
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
                                                        '-',
                                                        style: TextStyle(
                                                            fontSize: 12.0,
                                                            color: Colors.black87
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      children: List.generate(taskRecordKeeper.length, (index) {
                                        return Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0, right: 15.0, bottom: 0.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                    width: 150.0,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            taskRecordKeeper[index],
                                                            style: TextStyle(
                                                                fontSize: 12.0,
                                                                color: Colors.black54),
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
                                                            duedateRecordKeeper[index],
                                                            style: TextStyle(
                                                                fontSize: 12.0,
                                                                color: Colors.black87
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      }).toList(),
                                    ),

                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Divider(
                                    height: 12.0,
                                  ),
                                ),
                                personTask.length == 0
                                  ? Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15.0, right: 15.0, bottom: 5.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  recordKeeper,
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  'PARTICIPANTS',
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.w600),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15.0, right: 15.0, bottom: 15.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                width: 150.0,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        '-',
                                                        style: TextStyle(
                                                            fontSize: 12.0,
                                                            color: Colors.black54),
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
                                                        '-',
                                                        style: TextStyle(
                                                            fontSize: 12.0,
                                                            color: Colors.black87
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      children: List.generate(personTask.length, (index) {
                                        return Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0, right: 15.0, bottom: 5.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      personTask[index],
                                                      style: TextStyle(
                                                          fontSize: 14.0,
                                                          color: Colors.black54,
                                                          fontWeight: FontWeight.w700),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      'PARTICIPANTS',
                                                      style: TextStyle(
                                                          fontSize: 14.0,
                                                          color: Colors.black54,
                                                          fontWeight: FontWeight.w600),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            taskParticipants.length == 0
                                              ? Column(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: const EdgeInsets.only(
                                                          left: 15.0, right: 15.0, bottom: 0.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[
                                                          Container(
                                                            width: 150.0,
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: <Widget>[
                                                                Flexible(
                                                                  child: Text(
                                                                    '-',
                                                                    style: TextStyle(
                                                                        fontSize: 12.0,
                                                                        color: Colors.black54),
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
                                                                    '-',
                                                                    style: TextStyle(
                                                                        fontSize: 12.0,
                                                                        color: Colors.black87
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : Column(
                                                  children: List.generate(taskParticipants.length, (index2) {
                                                    return Column(
                                                      children: <Widget>[
                                                        Padding(
                                                          padding: const EdgeInsets.only(
                                                              left: 15.0, right: 15.0, bottom: 0.0),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: <Widget>[
                                                              Container(
                                                                width: 150.0,
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  children: <Widget>[
                                                                    Flexible(
                                                                      child: Text(
                                                                        taskParticipants[index2],
                                                                        style: TextStyle(
                                                                            fontSize: 12.0,
                                                                            color: Colors.black54),
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
                                                                        duedateParticipants[index2],
                                                                        style: TextStyle(
                                                                            fontSize: 12.0,
                                                                            color: Colors.black87
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  }).toList(),
                                                ),
                                          ],
                                        );
                                      }).toList(),
                                    )
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
    );
  }
}
