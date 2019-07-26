import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormReport extends StatefulWidget {
  final int idUser;
  final String namaUser;
  FormReport({this.idUser, this.namaUser});

  @override
  _FormReportState createState() => _FormReportState();
}

class _FormReportState extends State<FormReport> with TickerProviderStateMixin {
  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime dateStart;
  DateTime dateEnd;

  AnimationController animationController;

  bool showDataFiltered = false;
  bool showHelper = false;
  String helperText = '';

  List<dynamic> date = [];
  List<dynamic> outlet = [];
  List<dynamic> lokasi = [];
  List<dynamic> item = [];
  List<dynamic> merek = [];
  List<dynamic> itemNo = [];
  List<dynamic> status = [];
  List<dynamic> pic = [];
  List<dynamic> frequency = [];
  List<dynamic> jobdesc = [];
  List<dynamic> jobdescSkip = [];
  List<dynamic> jobdescStatus = [];
  List<dynamic> jobdescNameDone = [];
  List<dynamic> jobdescNameSkip = [];
  List<dynamic> jobdescTime = [];
  List<dynamic> dueDate = [];
  List<dynamic> alasan = [];
  List<dynamic> newSchedule = [];
  List<dynamic> rescheduleBy = [];
  var docID = [];

  String alasanName = '';
  String rescheduleByName = '';

  @override
  void initState() {
    super.initState();
    CollectionReference reference = Firestore.instance.collection('maintenance_IT');
    reference.snapshots().listen((data) {
      data.documentChanges.forEach((change) {
        setState(() {
          docID.add(change.document.documentID);
          date.add(change.document.data['dateCreated']);
          status.add(change.document.data['status']);
          frequency.add(change.document.data['frequency']);
          jobdesc.add(change.document.data['jobdesc']);
          jobdescSkip.add(change.document.data['jobdesc_skip']);
          jobdescStatus.add(change.document.data['jobdesc_status']);
          jobdescTime.add(change.document.data['jobdesc_done']);
          dueDate.add(change.document.data['dueDate']);
          rescheduleBy.add(change.document.data['rescheduleBy']);
          item.add(change.document.data['item']);
          itemNo.add(change.document.data['itemNo']);
          merek.add(change.document.data['merek']);

          if (change.document.data['newDueDate'] == null) {
            newSchedule.add(null);
          } else {
            newSchedule.add(change.document.data['newDueDate']);
          }

          Firestore.instance.collection('maintenance_alasan').where('id', isEqualTo: change.document.data['alasan']).snapshots().listen((data2) {
            alasan.add(data2.documents[0].data['alasan']);
          });

          Firestore.instance.collection('outlet').where('id', isEqualTo: change.document.data['outlet']).snapshots().listen((data4) {
            outlet.add(data4.documents[0].data['nama_outlet']);
          });

          Firestore.instance.collection('lokasi').where('id', isEqualTo: change.document.data['lokasi']).snapshots().listen((data5) {
            lokasi.add(data5.documents[0].data['lokasi']);
          });

          Firestore.instance.collection('user').where('id', isEqualTo: change.document.data['pic']).snapshots().listen((data6) {
            pic.add(data6.documents[0].data['nama']);
          });
        });
      });
    });

    animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(from: animationController.value == 0.0
      ? 1.0
      : animationController.value
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

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
        body:  GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: AnimatedBuilder(
            animation: animationController,
            builder: (_, Widget child) {
              return animationController.isAnimating
                  ? Container(
                      child: Center(
                          child: CircularProgressIndicator()
                      )
                    )
                  : Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(bottom: 10.0, right: 15.0, left: 15.0, top: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Maintenance',
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
                                  'Report',
                                  style:
                                  TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // _searchBox(),
                        Container(
                          width: width,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: width * 0.3,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Date',
                                          style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  width: width * 0.3,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Location / Item',
                                          style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  width: width * 0.3,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Status',
                                          style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          child: ListView.builder(
                            itemCount: outlet.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (status[index] == 'RESCHEDULE') {
                                return Container();
                              } else if (status[index] != 'OPEN') {
                                return Container(
                                  width: width,
                                  padding: const EdgeInsets.only(right: 5.0, left: 5.0),
                                  color: Colors.white,
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: index == status.length - 1 ? const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0) : const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              width: width * 0.3,
                                              child: Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      date[index].toDate().toString().substring(8, 10) + '/' + date[index].toDate().toString().substring(5, 7) + '/' +date[index].toDate().toString().substring(0, 4),
                                                      style: TextStyle(
                                                          fontSize: 12.0, color: Colors.black),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: width * 0.3,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Container(
                                                    width: MediaQuery.of(context).size.width * 0.7,
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Flexible(
                                                          fit: FlexFit.loose,
                                                          child: RichText(
                                                            softWrap: true,
                                                            textAlign: TextAlign.start,
                                                            overflow: TextOverflow.visible,
                                                            text: TextSpan(
                                                              text: '${outlet[index]}',
                                                              style: TextStyle(
                                                                  fontSize: 12.0,
                                                                  color: Colors.black
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3.0,
                                                  ),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width * 0.7,
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Flexible(
                                                          fit: FlexFit.loose,
                                                          child: RichText(
                                                            softWrap: true,
                                                            textAlign: TextAlign.start,
                                                            overflow: TextOverflow.visible,
                                                            text: TextSpan(
                                                              text: lokasi[index],
                                                              style: TextStyle(
                                                                  fontSize: 11.0,
                                                                  fontWeight: FontWeight.w300,
                                                                  color: Colors.black45
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width * 0.7,
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Flexible(
                                                          fit: FlexFit.loose,
                                                          child: RichText(
                                                            softWrap: true,
                                                            textAlign: TextAlign.start,
                                                            overflow: TextOverflow.visible,
                                                            text: TextSpan(
                                                              text: '${merek[index]} - ${item[index]}',
                                                              style: TextStyle(
                                                                  fontSize: 12.0,
                                                                  color: Colors.black
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3.0,
                                                  ),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width * 0.7,
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Flexible(
                                                          fit: FlexFit.loose,
                                                          child: RichText(
                                                            softWrap: true,
                                                            textAlign: TextAlign.start,
                                                            overflow: TextOverflow.visible,
                                                            text: TextSpan(
                                                              text: '# ${itemNo[index]}',
                                                              style: TextStyle(
                                                                  fontSize: 11.0,
                                                                  fontWeight: FontWeight.w300,
                                                                  color: Colors.black45
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ),
                                            Container(
                                              width: width * 0.3,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Container(
                                                      width: width * 0.2,
                                                      child: ButtonTheme(
                                                        minWidth: 50.0,
                                                        height: 30.0,
                                                        splashColor: status[index] == 'DONE' ? AbubaPallate.greenabuba : Colors.redAccent,
                                                        child: OutlineButton(
                                                          borderSide: BorderSide(color: status[index] == 'DONE' ? AbubaPallate.greenabuba : Colors.redAccent),
                                                          child: Text(
                                                            status[index] == 'SKIP' ? 'SKIPPED' : status[index],
                                                            style: TextStyle(
                                                              fontSize: 12.0,
                                                              color: status[index] == 'DONE' ? AbubaPallate.greenabuba : Colors.redAccent
                                                            ),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                          onPressed: () {
                                                            showDialog(
                                                              context: context,
                                                              barrierDismissible: false,
                                                              builder: (BuildContext context) {
                                                                return DialogDetail(
                                                                  docID: docID[index]
                                                                );
                                                              }
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            }
                          ),
                        )
                      ],
                    );
            },
          )
        )
      ),
    );
  }
}

class DialogDetail extends StatefulWidget {
  var docID;

  DialogDetail({this.docID});
  @override
  _DialogDetailState createState() => _DialogDetailState();
}

class _DialogDetailState extends State<DialogDetail> with TickerProviderStateMixin {
  AnimationController animationController2;

  String area;
  String lokasi;
  String asset;
  String brand;
  String id;
  
  String frequency;
  String jadwal;
  String pic;
  
  List<dynamic> jobDone = [];
  String tglDone;
  Timestamp bantuTglDone;
  Timestamp bantujadwal;
  String noteSkipSave;
  String noteSave;

  String jobSkip;
  String newDueDate;
  String rescheduleBy;
  String alasan;
  String noteSkip;

  Color colorTglPelaksanaan;
  String noteViewSave;

  @override
  void initState() {
    Firestore.instance.collection('maintenance_IT').document(widget.docID).snapshots().listen((data) {
      Firestore.instance.collection('outlet').where('id', isEqualTo: data.data['outlet']).snapshots().listen((data2) {
        area = data2.documents[0].data['nama_outlet'];
      });

      Firestore.instance.collection('lokasi').where('id', isEqualTo: data.data['lokasi']).snapshots().listen((data3) {
        lokasi = data3.documents[0].data['lokasi'];
      });

      asset = data.data['merek'];
      brand = data.data['item'];
      id = data.data['itemNo'];

      frequency = data.data['frequency'];
      jadwal = data.data['dueDate'].toDate().toString().substring(8, 10) + '/' + data.data['dueDate'].toDate().toString().substring(5, 7) + '/' + data.data['dueDate'].toDate().toString().substring(0, 4);
      bantujadwal = data.data['dueDate'];

      if (data.data.containsKey('noteSkipSave')) {
        if (data.data['noteSkipSave'] == null) {
          noteSkipSave = '-';
        } else {
          noteSkipSave = data.data['noteSkipSave'];
        }
      } else {
        noteSkipSave = '-';
      }

      if (data.data.containsKey('noteSave')) {
        if (data.data['noteSave'] == null) {
          noteSave = '-';
        } else {
          noteSave = data.data['noteSave'];
        }
      } else {
        noteSave = '-';
      }

      if (data.data.containsKey('noteSkip')) {
        if (data.data['noteSkip'] == null) {
          noteSkip = '-';
        } else {
          noteSkip = data.data['noteSkip'];
        }
      } else {
        noteSkip = '-';
      }

      if (noteSave == '-' && noteSkipSave == '-') {
        noteViewSave = '-';
      } else {
        if (noteSave == '-' && noteSkipSave != '-') {
          noteViewSave = noteSkipSave;
        } else if (noteSave != '-' && noteSkipSave == '-') {
          noteViewSave = noteSave;
        } else if (noteSave != '-' && noteSkipSave != '-') {
          noteViewSave = noteSkipSave + ', ' + noteSave.toLowerCase();
        }
      }

      Firestore.instance.collection('user').where('id', isEqualTo: data.data['pic']).snapshots().listen((data4) {
        pic = data4.documents[0].data['nama'];
      });

      if (data.data['alasan'] == null) {
        alasan = '-';
      } else {
        Firestore.instance.collection('maintenance_alasan').where('id', isEqualTo: data.data['alasan']).snapshots().listen((data5) {
          alasan = data5.documents[0].data['alasan'];
        });
      }

      if (data.data['newDueDate'] == null) {
        newDueDate = '-';
      } else {
        newDueDate = data.data['newDueDate'].toDate().toString().substring(8, 10) + '/' + data.data['newDueDate'].toDate().toString().substring(5, 7) + '/' + data.data['newDueDate'].toDate().toString().substring(0, 4);
      }

      if (data.data['rescheduleBy'] == null) {
        rescheduleBy = '-';
      } else {
        Firestore.instance.collection('user').where('id', isEqualTo: data.data['rescheduleBy']).snapshots().listen((data6) {
          rescheduleBy = data6.documents[0].data['nama'];
        });
      }

      if (data.data.containsKey('jobdesc_skip')) {
        jobSkip = data.data['jobdesc_skip'].join(', ').toString();
      } else {
        jobSkip = '-';
      }

      if (data.data['jobdesc_status'].contains('DONE')) {
        for (int i = 0; i < data.data['jobdesc_status'].length; i++) {
          if (data.data['jobdesc_status'][i] == 'DONE') {
            jobDone.add(data.data['jobdesc'][i]);
            tglDone = data.data['jobdesc_done'][i].toDate().toString().substring(8, 10) + '/' + data.data['jobdesc_done'][i].toDate().toString().substring(5, 7) + '/' + data.data['jobdesc_done'][i].toDate().toString().substring(0, 4);
            bantuTglDone = data.data['jobdesc_done'][i];
          }
        }
      } else {
        jobDone.add('-');
        tglDone = '-';
        bantuTglDone = null;
      }

      if (tglDone == '-') {
        colorTglPelaksanaan = Colors.black38;
      } else {
        if (newDueDate != '-') {
          if (bantuTglDone.toDate().isBefore(data.data['newDueDate'].toDate()) || newDueDate == tglDone) {
            colorTglPelaksanaan = Colors.black38;
          } else {
            colorTglPelaksanaan = Colors.redAccent;
          }
        } else {
          if (bantuTglDone.toDate().isAfter(bantujadwal.toDate())) {
            colorTglPelaksanaan = Colors.redAccent;
          } else {
            colorTglPelaksanaan = Colors.black38;
          }
        }
      }
    });

    animationController2 = AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController2.reverse(from: animationController2.value == 0.0
      ? 1.0
      : animationController2.value
    );

    super.initState();
  }

  // sini batas

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          children: <Widget>[
            Container(
              color: AbubaPallate.greenabuba,
              height: 50.0,
              child: Center(
                child: Text(
                  'DATA',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w700
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5.0, top: 20.0),
              child: Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Column(
                      children: <Widget>[
                        AnimatedBuilder(
                          animation: animationController2,
                          builder: (_, Widget child) {
                            return animationController2.isAnimating
                              ? Container(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : Flexible(
                                  child: ListView(
                                    physics: ScrollPhysics(),
                                    shrinkWrap: true,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.35,
                                              child: Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      'General Info',
                                                      style: TextStyle(
                                                          fontSize: 15.0, color: Colors.black87, fontWeight: FontWeight.bold
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
                                        padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.3,
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
                                              width: MediaQuery.of(context).size.width * 0.3,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      area,
                                                      style: TextStyle(
                                                          fontSize: 13.0,
                                                          color: Colors.black38,
                                                          fontWeight: FontWeight.w700
                                                      ),
                                                      textAlign: TextAlign.right,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.3,
                                              child: Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      'Lokasi',
                                                      style: TextStyle(
                                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                      ),
                                                    ),
                                                  ),
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
                                                      lokasi,
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
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.3,
                                              child: Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      'Asset',
                                                      style: TextStyle(
                                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                      ),
                                                    ),
                                                  ),
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
                                                      asset,
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
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.3,
                                              child: Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      'Brand',
                                                      style: TextStyle(
                                                        fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                      ),
                                                    ),
                                                  ),
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
                                                      brand,
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
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.3,
                                              child: Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      'ID#',
                                                      style: TextStyle(
                                                        fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                      ),
                                                    ),
                                                  ),
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
                                                      id.toString(),
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
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 5.0),
                                        child: Divider(
                                          height: 5.0,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.3,
                                              child: Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      'Schedule',
                                                      style: TextStyle(
                                                        fontSize: 15.0, color: Colors.black87, fontWeight: FontWeight.bold
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
                                        padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.3,
                                              child: Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      'Frequency',
                                                      style: TextStyle(
                                                        fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                      ),
                                                    ),
                                                  ),
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
                                                      frequency,
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
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.3,
                                              child: Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      'Jadwal',
                                                      style: TextStyle(
                                                        fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                      ),
                                                    ),
                                                  ),
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
                                                      jadwal,
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
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.3,
                                              child: Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      'Pelaksana',
                                                      style: TextStyle(
                                                        fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                      ),
                                                    ),
                                                  ),
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
                                                      pic,
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
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 5.0),
                                        child: Divider(
                                          height: 5.0,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.3,
                                              child: Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      'Done',
                                                      style: TextStyle(
                                                        fontSize: 15.0, color: AbubaPallate.greenabuba, fontWeight: FontWeight.bold
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
                                        padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.3,
                                              child: Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      'Tugas',
                                                      style: TextStyle(
                                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.centerRight,
                                              width: MediaQuery.of(context).size.width * 0.3,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      jobDone.join(', ').toString(),
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
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.3,
                                              child: Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      'Tgl Pelaksanaan',
                                                      style: TextStyle(
                                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                      ),
                                                    ),
                                                  ),
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
                                                      tglDone,
                                                      style: TextStyle(
                                                        fontSize: 13.0,
                                                        color: colorTglPelaksanaan,
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
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.3,
                                              child: Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      'Note',
                                                      style: TextStyle(
                                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                      ),
                                                    ),
                                                  ),
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
                                                      noteViewSave,
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
                                      Padding(
                                        padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 5.0),
                                        child: Divider(
                                          height: 5.0,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.3,
                                              child: Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      'Skipped History',
                                                      style: TextStyle(
                                                          fontSize: 15.0, color: Colors.redAccent, fontWeight: FontWeight.bold
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
                                        padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.2,
                                              child: Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      'Tugas',
                                                      style: TextStyle(
                                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                      ),
                                                    ),
                                                  ),
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
                                                      jobSkip,
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
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.3,
                                              child: Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      'Jadwal Seharusnya',
                                                      style: TextStyle(
                                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                      ),
                                                    ),
                                                  ),
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
                                                      jobSkip == '-' ? '-' : jadwal,
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
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.3,
                                              child: Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      'Jadwal Baru',
                                                      style: TextStyle(
                                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                      ),
                                                    ),
                                                  ),
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
                                                      newDueDate,
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
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.3,
                                              child: Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      'Jadwal Diubah Oleh',
                                                      style: TextStyle(
                                                        fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                      ),
                                                    ),
                                                  ),
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
                                                      rescheduleBy,
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
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.3,
                                              child: Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      'Alasan Ditunda',
                                                      style: TextStyle(
                                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                      ),
                                                    ),
                                                  ),
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
                                                      alasan,
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
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.3,
                                              child: Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      'Note',
                                                      style: TextStyle(
                                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                      ),
                                                    ),
                                                  ),
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
                                                      noteSkip,
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
                                    ],
                                  ),
                                );
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 20.0),
              alignment: Alignment.centerRight,
              child: ButtonTheme(
                minWidth: 50.0,
                height: 30.0,
                splashColor: AbubaPallate.greenabuba,
                child: OutlineButton(
                  borderSide: BorderSide(
                    color: AbubaPallate.greenabuba
                  ),
                  child: Text(
                    'Close',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: AbubaPallate.greenabuba
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ),
            )
          ],
        )
      ),
    );
  }
}