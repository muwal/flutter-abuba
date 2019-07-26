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
  String department;
  String divisi;
  String area;
  String shift;
  String noteWhen;
  String noteWhere;

  String why1;
  String why2;
  String why3;
  String why4;
  String why5;

  String perbaikan1;
  String perbaikan2;
  String perbaikan3;
  String perbaikan4;
  String perbaikan5;
  List<dynamic> pelaksana1 = [];
  List<dynamic> pelaksana2 = [];
  List<dynamic> pelaksana3 = [];
  List<dynamic> pelaksana4 = [];
  List<dynamic> pelaksana5 = [];
  String waktu1;
  String waktu2;
  String waktu3;
  String waktu4;
  String waktu5;

  @override
  void initState() {
    super.initState();
    Firestore.instance.collection('fiveWhys').document(widget.index).snapshots().listen((data) {
      setState(() {
        Timestamp tanggalBantu = data.data['dateCreated'];
        tanggal = tanggalBantu.toDate().toString().substring(8, 10) + '/' + tanggalBantu.toDate().toString().substring(5, 7) + '/' + tanggalBantu.toDate().toString().substring(0, 4);
        no = data.data['fiveWhysNo'].toString().padLeft(4, '0');
        what = data.data['customerComplaint'];
        who = data.data['whoName'];
        noteWhen = data.data['noteWhen'];
        noteWhere = data.data['noteWhere'];
        Timestamp tanggalWhen = data.data['dateWhen'];
        when = tanggalWhen.toDate().toString().substring(8, 10) + '/' + tanggalWhen.toDate().toString().substring(5, 7) + '/' + tanggalWhen.toDate().toString().substring(0, 4) + '  -' + data.data['dateWhen'].toString().substring(10, 16);

        why1 = data.data['why1'];
        why2 = data.data['why2'];
        why3 = data.data['why3'];
        why4 = data.data['why4'];
        why5 = data.data['why5'];

        perbaikan1 = data.data['perbaikan1'];
        perbaikan2 = data.data['perbaikan2'];
        perbaikan3 = data.data['perbaikan3'];
        perbaikan4 = data.data['perbaikan4'];
        perbaikan5 = data.data['perbaikan5'];

        pelaksana1 = data.data['pelaksanaName1'];
        pelaksana2 = data.data['pelaksanaName2'];
        pelaksana3 = data.data['pelaksanaName3'];
        pelaksana4 = data.data['pelaksanaName4'];
        pelaksana5 = data.data['pelaksanaName5'];

        Timestamp tanggalWhy1 = data.data['dateWhy1'];
        Timestamp tanggalWhy2 = data.data['dateWhy2'];
        Timestamp tanggalWhy3 = data.data['dateWhy3'];
        Timestamp tanggalWhy4 = data.data['dateWhy4'];
        Timestamp tanggalWhy5 = data.data['dateWhy5'];

        waktu1 = tanggalWhy1.toDate().toString().substring(8, 10) + '/' + tanggalWhy1.toDate().toString().substring(5, 7) + '/' + tanggalWhy1.toDate().toString().substring(0, 4);
        waktu2 = tanggalWhy2.toDate().toString().substring(8, 10) + '/' + tanggalWhy2.toDate().toString().substring(5, 7) + '/' + tanggalWhy2.toDate().toString().substring(0, 4);
        waktu3 = tanggalWhy3.toDate().toString().substring(8, 10) + '/' + tanggalWhy3.toDate().toString().substring(5, 7) + '/' + tanggalWhy3.toDate().toString().substring(0, 4);
        waktu4 = tanggalWhy4.toDate().toString().substring(8, 10) + '/' + tanggalWhy4.toDate().toString().substring(5, 7) + '/' + tanggalWhy4.toDate().toString().substring(0, 4);
        waktu5 = tanggalWhy5.toDate().toString().substring(8, 10) + '/' + tanggalWhy5.toDate().toString().substring(5, 7) + '/' + tanggalWhy5.toDate().toString().substring(0, 4);

        Firestore.instance.collection('divisi').where('id', isEqualTo: data.data['divisi']).snapshots().listen((data3) {
          divisi = data3.documents[0].data['divisi'];
        });

        Firestore.instance.collection('shift').where('id', isEqualTo: data.data['shift']).snapshots().listen((data3) {
          shift = data3.documents[0].data['shift'];
        });

        Firestore.instance.collection('area').where('id', isEqualTo: data.data['area']).snapshots().listen((data3) {
          area = data3.documents[0].data['area'];
        });

        Firestore.instance.collection('department').where('id', isEqualTo: data.data['department']).snapshots().listen((data5) {
          department = data5.documents[0].data['department'];
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
                                        '5 Why No. FHY-$no',
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
                                      '1. Define The Problem',
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
                                            'WHAT - Apa masalah yang sedang terjadi ?',
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
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            what,
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Divider(
                                      height: 6.0,
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
                                            'WHO - Siapa yang terlibat dengan masalah ini ?',
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
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            who.join(', ').toString(),
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Divider(
                                      height: 6.0,
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
                                            'WHEN - Kapan Masalah ini terjadi ?',
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
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            '$when - $shift',
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15.0, bottom: 0.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            noteWhen == "" ? 'Note : -' : 'Note : $noteWhen',
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Divider(
                                      height: 6.0,
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
                                            'WHERE - Dimana lokasi masalah ditemukan ?',
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
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            'Dept. $department - $divisi - $area',
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15.0, bottom: 15.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            noteWhere == "" ? 'Note : -' : 'Note : $noteWhere',
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black54),
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
                        // batas
                        ExpansionTile(
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      '2. Primary Cause',
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
                                            'WHY 1 - Mengapa hal tersebut bisa terjadi ?',
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
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            why1,
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Divider(
                                      height: 6.0,
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
                                            'WHY 2 - Mengapa begitu ?',
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
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            why2,
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Divider(
                                      height: 6.0,
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
                                            'WHY 3 - Mengapa begitu ?',
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
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            why3,
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Divider(
                                      height: 6.0,
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
                                            'WHY 4 - Mengapa begitu ?',
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
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            why4,
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Divider(
                                      height: 6.0,
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
                                            'WHY 5 - Mengapa begitu ?',
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
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            why5,
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black54),
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
                                      '3. Corrective Action',
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
                                            'WHY 1',
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
                                        left: 15.0, right: 15.0, bottom: 10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            why1,
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0, right: 15.0, bottom: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            'Tindakan Perbaikan',
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0, right: 15.0, bottom: 10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            perbaikan1,
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0, right: 15.0, bottom: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            'Pelaksana',
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0, right: 15.0, bottom: 10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            pelaksana1.join(', ').toString(),
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0, right: 15.0, bottom: 0.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Waktu',
                                                  style: TextStyle(
                                                      fontSize: 12.0,
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
                                                  waktu1,
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
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Divider(
                                      height: 6.0,
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
                                            'WHY 2',
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
                                        left: 15.0, right: 15.0, bottom: 10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            why2,
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0, right: 15.0, bottom: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            'Tindakan Perbaikan',
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0, right: 15.0, bottom: 10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            perbaikan2,
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0, right: 15.0, bottom: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            'Pelaksana',
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0, right: 15.0, bottom: 10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            pelaksana2.join(', ').toString(),
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0, right: 15.0, bottom: 0.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Waktu',
                                                  style: TextStyle(
                                                      fontSize: 12.0,
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
                                                  waktu2,
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
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Divider(
                                      height: 6.0,
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
                                            'WHY 3',
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
                                        left: 15.0, right: 15.0, bottom: 10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            why3,
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0, right: 15.0, bottom: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            'Tindakan Perbaikan',
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0, right: 15.0, bottom: 10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            perbaikan3,
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0, right: 15.0, bottom: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            'Pelaksana',
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0, right: 15.0, bottom: 10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            pelaksana3.join(', ').toString(),
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0, right: 15.0, bottom: 0.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Waktu',
                                                  style: TextStyle(
                                                      fontSize: 12.0,
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
                                                  waktu3,
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
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Divider(
                                      height: 6.0,
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
                                            'WHY 4',
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
                                        left: 15.0, right: 15.0, bottom: 10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            why4,
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0, right: 15.0, bottom: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            'Tindakan Perbaikan',
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0, right: 15.0, bottom: 10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            perbaikan4,
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0, right: 15.0, bottom: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            'Pelaksana',
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0, right: 15.0, bottom: 10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            pelaksana4.join(', ').toString(),
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0, right: 15.0, bottom: 0.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Waktu',
                                                  style: TextStyle(
                                                      fontSize: 12.0,
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
                                                  waktu4,
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
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: Divider(
                                      height: 6.0,
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
                                            'WHY 5',
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
                                        left: 15.0, right: 15.0, bottom: 10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            why5,
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0, right: 15.0, bottom: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            'Tindakan Perbaikan',
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0, right: 15.0, bottom: 10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            perbaikan5,
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0, right: 15.0, bottom: 5.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            'Pelaksana',
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0, right: 15.0, bottom: 10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            pelaksana5.join(', ').toString(),
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0, right: 15.0, bottom: 15.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Waktu',
                                                  style: TextStyle(
                                                      fontSize: 12.0,
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
                                                  waktu5,
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
