import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';

class KonfirmasiAudit extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;

  KonfirmasiAudit({this.idUser, this.departmentUser, this.namaUser});

  @override
  _KonfirmasiAuditState createState() => _KonfirmasiAuditState();
}

class _KonfirmasiAuditState extends State<KonfirmasiAudit> with TickerProviderStateMixin {
  AnimationController animationController;

  List<String> department = [];
  List<String> object = [];
  List<Timestamp> tanggal = [];
  List<int> auditee = [];
  List<List<dynamic>> auditor = [];
  List<int> leadAuditor = [];
  List<Timestamp> auditEnd = [];
  List<bool> showDetail = [];
  List<List<dynamic>> subArea = [];
  List<String> auditeeName = [];
  List<String> leadAuditorName = [];

  List<dynamic> auditorName = [];
  int indexShowDetail = 0;
  List<List<dynamic>> auditorConfirm = [];
  List<List<dynamic>> auditorConfirmStatus = [];
  List<String> auditeeConfirm = [];
  List<String> leadAuditorConfirm = [];
  var indexx = [];

  bool isProcess = false;

  @override
  void initState() {
    super.initState();

    CollectionReference reference = Firestore.instance.collection('audit_internal');
    reference.snapshots().listen((querySnapshot) {
      querySnapshot.documentChanges.forEach((change) {
        setState(() {
          tanggal.add(change.document.data['dateAudit']);
          auditee.add(change.document.data['auditee']);
          leadAuditor.add(change.document.data['leadAuditor']);
          auditor.add(change.document.data['subAreaAuditor']);
          auditEnd.add(change.document.data['auditEnd']);
          showDetail.add(false);
          subArea.add(change.document.data['subArea']);
          auditorConfirm.add(change.document.data['auditorConfirm']);
          auditorConfirmStatus.add(change.document.data['auditorConfirm']);
          auditeeConfirm.add(change.document.data['auditeeConfirm'].toString());
          leadAuditorConfirm.add(change.document.data['leadAuditorConfirm'].toString());
          indexx.add(change.document.documentID);

          Firestore.instance.collection('department').where('id', isEqualTo: change.document.data['department']).snapshots().listen((data3) {
            department.add(data3.documents[0].data['name']);
          });

          Firestore.instance.collection('user').where('id', isEqualTo: change.document.data['auditee']).snapshots().listen((data5) {
            auditeeName.add(data5.documents[0].data['nama']);
          });

          Firestore.instance.collection('user').where('id', isEqualTo: change.document.data['leadAuditor']).snapshots().listen((data6) {
            leadAuditorName.add(data6.documents[0].data['nama']);
          });

          Firestore.instance.collection('audit_object').where('id', isEqualTo: change.document.data['object']).snapshots().listen((data4) {
            object.add(data4.documents[0].data['object']);
          });
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
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                icon: Icon(Icons.refresh, color: Colors.black54),
                tooltip: 'Resfresh',
                onPressed: () {
                  Navigator.pushReplacement(context,
                    MaterialPageRoute(
                      builder: (_) => KonfirmasiAudit(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)
                    )
                  );
                },
              ),
            )
          ],
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: AnimatedBuilder(
            animation: animationController,
            builder: (_, Widget child) {
              return animationController.isAnimating
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : ListView(
                    children: <Widget>[
                      Container(
                        child: StreamBuilder(
                          stream: Firestore.instance.collection('audit_internal').snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData)
                              return Container(
                                child: Center(
                                  child: CircularProgressIndicator()
                                ),
                              );
                            
                            return Column(
                              children: List.generate(snapshot.data.documents.length, (index) {
                                Timestamp tanggalAudit = snapshot.data.documents[index].data['dateAudit'];

                                String status = '';
                                if (snapshot.data.documents[index].data['auditee'] == widget.idUser) {
                                  status = 'AUDITEE';
                                } else if (snapshot.data.documents[index].data['leadAuditor'] == widget.idUser) {
                                  status = 'LEAD AUDITOR';
                                } else if (snapshot.data.documents[index].data['subAreaAuditor'].contains(widget.idUser.toString())) {
                                  status = 'AUDITOR';
                                } else {
                                  status = '-';
                                }
                                if (snapshot.data.documents[index].data['auditee'] == widget.idUser || snapshot.data.documents[index].data['leadAuditor'] == widget.idUser || snapshot.data.documents[index].data['subAreaAuditor'].contains(widget.idUser.toString())) {
                                  if (snapshot.data.documents[index].data['auditEnd'] == null) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                      child: Card(
                                        elevation: 4.0,
                                        child: Container(
                                          color: Colors.white,
                                          padding: EdgeInsets.symmetric(vertical: 15.0),
                                          child: Column(
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: RichText(
                                                      softWrap: true,
                                                      textAlign: TextAlign.center,
                                                      overflow: TextOverflow.visible,
                                                      text: TextSpan(
                                                        text: department[index] == null ? '-' : department[index],
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.black87,
                                                          fontSize: 15.0,
                                                        ),
                                                      )
                                                    )
                                                  ),
                                                  Expanded(
                                                    child: RichText(
                                                      softWrap: true,
                                                      textAlign: TextAlign.center,
                                                      overflow: TextOverflow.visible,
                                                      text: TextSpan(
                                                        text: status,
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          color: AbubaPallate.menuBluebird,
                                                          fontSize: 15.0,
                                                        ),
                                                      )
                                                    )
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: <Widget>[
                                                          RichText(
                                                            softWrap: true,
                                                            textAlign: TextAlign.start,
                                                            overflow: TextOverflow.visible,
                                                            text: TextSpan(
                                                              text: object[index] == null ? '-' : object[index],
                                                              style: TextStyle(
                                                                fontSize: 14.0,
                                                                fontWeight: FontWeight.w300,
                                                                color: Colors.black45
                                                              ),
                                                            ),
                                                          ),
                                                          RichText(
                                                            softWrap: true,
                                                            textAlign: TextAlign.start,
                                                            overflow: TextOverflow.visible,
                                                            text: TextSpan(
                                                              text: tanggalAudit == null ? '-' : tanggalAudit.toDate().toString().substring(8, 10) + '/' + tanggalAudit.toDate().toString().substring(5, 7) + '/' +tanggalAudit.toDate().toString().substring(0, 4),
                                                              style: TextStyle(
                                                                fontSize: 14.0,
                                                                fontWeight: FontWeight.w300,
                                                                color: Colors.black45
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 5.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: <Widget>[
                                                          showDetail[index]
                                                            ? ButtonTheme(
                                                                minWidth: 50.0,
                                                                height: 30.0,
                                                                child: OutlineButton(
                                                                  child: Text(
                                                                    'CLOSE',
                                                                    style: TextStyle(
                                                                      fontSize: 13.0,
                                                                      color: Colors.grey,
                                                                      fontWeight: FontWeight.bold
                                                                    ),
                                                                  ),
                                                                  borderSide: BorderSide(color: Colors.grey, width: 2.0),
                                                                  highlightedBorderColor: Colors.grey,
                                                                  splashColor: Colors.grey,
                                                                  onPressed: () {
                                                                    setState(() {
                                                                      auditorName.clear();
                                                                      showDetail[index] = false;
                                                                    });
                                                                  },
                                                                ),
                                                              )
                                                            : status == 'AUDITEE'
                                                                ? snapshot.data.documents[index].data['auditeeConfirm'].toString() == 'CONFIRM'
                                                                    ? ButtonTheme(
                                                                        minWidth: 50.0,
                                                                        height: 30.0,
                                                                        child: OutlineButton(
                                                                          child: Text(
                                                                            'CONFIRMED',
                                                                            style: TextStyle(
                                                                              fontSize: 13.0,
                                                                              color: AbubaPallate.greenabuba,
                                                                              fontWeight: FontWeight.bold
                                                                            ),
                                                                          ),
                                                                          borderSide: BorderSide(color: AbubaPallate.greenabuba, width: 2.0),
                                                                          highlightedBorderColor: AbubaPallate.greenabuba,
                                                                          splashColor: AbubaPallate.greenabuba,
                                                                          onPressed: () {
                                                                            // setState(() async {
                                                                            //   indexShowDetail = showDetail.length;
                                                                            //   if (showDetail[index]) {
                                                                            //     showDetail[index] = false;
                                                                            //     print('close');
                                                                            //     print(showDetail);
                                                                            //   } else {
                                                                            //     print('open');
                                                                            //     print(showDetail);
                                                                            //     showDetail.clear();
                                                                            //     for (int s = 0; s < indexShowDetail; s++) {
                                                                            //       showDetail.add(false);
                                                                            //     }
                                                                            //     showDetail[index] = !showDetail[index];

                                                                            //     if (showDetail[index] == true) {
                                                                            //       auditorName.clear();
                                                                            //       for (int o = 0; o < snapshot.data.documents[index].data['subAreaAuditor'].length; o++) {
                                                                            //         Firestore.instance.collection('user').where('id', isEqualTo: int.tryParse(snapshot.data.documents[index].data['subAreaAuditor'][o].toString())).snapshots().listen((data7) {
                                                                            //           setState(() {
                                                                            //             auditorName.add(data7.documents[0].data['nama']);
                                                                            //           });
                                                                            //         });
                                                                            //       }
                                                                            //     } else {
                                                                            //       auditorName.clear();
                                                                            //     }
                                                                            //   }
                                                                            //   await new Future.delayed(Duration(
                                                                            //     seconds: 3
                                                                            //   ));
                                                                            // });
                                                                            showDialog(
                                                                              barrierDismissible: false,
                                                                              context: context,
                                                                              builder: (BuildContext context) {
                                                                                return DialogView(
                                                                                  idUser: widget.idUser,
                                                                                  status: status,
                                                                                  auditor: snapshot.data.documents[index].data['subAreaAuditor'],
                                                                                  indexx: snapshot.data.documents[index].documentID,
                                                                                );
                                                                              }
                                                                            );
                                                                          },
                                                                        ),
                                                                      )
                                                                    : ButtonTheme(
                                                                        minWidth: 50.0,
                                                                        height: 30.0,
                                                                        child: OutlineButton(
                                                                          child: Text(
                                                                            'VIEW',
                                                                            style: TextStyle(
                                                                              fontSize: 13.0,
                                                                              color: AbubaPallate.menuBluebird,
                                                                              fontWeight: FontWeight.bold
                                                                            ),
                                                                          ),
                                                                          borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 2.0),
                                                                          highlightedBorderColor: AbubaPallate.menuBluebird,
                                                                          splashColor: AbubaPallate.menuBluebird,
                                                                          onPressed: () {
                                                                            showDialog(
                                                                              barrierDismissible: false,
                                                                              context: context,
                                                                              builder: (BuildContext context) {
                                                                                return DialogView(
                                                                                  idUser: widget.idUser,
                                                                                  status: status,
                                                                                  auditor: snapshot.data.documents[index].data['subAreaAuditor'],
                                                                                  indexx: snapshot.data.documents[index].documentID,
                                                                                );
                                                                              }
                                                                            );
                                                                            // setState(() async {
                                                                            //   indexShowDetail = showDetail.length;
                                                                            //   if (showDetail[index]) {
                                                                            //     showDetail[index] = false;
                                                                            //     print('close');
                                                                            //     print(showDetail);
                                                                            //   } else {
                                                                            //     print('open');
                                                                            //     print(showDetail);
                                                                            //     showDetail.clear();
                                                                            //     for (int s = 0; s < indexShowDetail; s++) {
                                                                            //       showDetail.add(false);
                                                                            //     }
                                                                            //     showDetail[index] = !showDetail[index];

                                                                            //     if (showDetail[index] == true) {
                                                                            //       auditorName.clear();
                                                                            //       for (int o = 0; o < snapshot.data.documents[index].data['subAreaAuditor'].length; o++) {
                                                                            //         Firestore.instance.collection('user').where('id', isEqualTo: int.tryParse(snapshot.data.documents[index].data['subAreaAuditor'][o].toString())).snapshots().listen((data7) {
                                                                            //           setState(() {
                                                                            //             auditorName.add(data7.documents[0].data['nama']);
                                                                            //           });
                                                                            //         });
                                                                            //       }
                                                                            //     } else {
                                                                            //       auditorName.clear();
                                                                            //     }
                                                                            //   }
                                                                            //   await new Future.delayed(Duration(
                                                                            //     seconds: 3
                                                                            //   ));
                                                                            // });
                                                                          },
                                                                        ),
                                                                      )
                                                                : status == 'AUDITOR'
                                                                    ? snapshot.data.documents[index].data['auditorConfirm'].contains(widget.idUser.toString())
                                                                        ? ButtonTheme(
                                                                            minWidth: 50.0,
                                                                            height: 30.0,
                                                                            child: OutlineButton(
                                                                              child: Text(
                                                                                'VIEW',
                                                                                style: TextStyle(
                                                                                  fontSize: 13.0,
                                                                                  color: AbubaPallate.menuBluebird,
                                                                                  fontWeight: FontWeight.bold
                                                                                ),
                                                                              ),
                                                                              borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 2.0),
                                                                              highlightedBorderColor: AbubaPallate.menuBluebird,
                                                                              splashColor: AbubaPallate.menuBluebird,
                                                                              onPressed: () {
                                                                                showDialog(
                                                                                  barrierDismissible: false,
                                                                                  context: context,
                                                                                  builder: (BuildContext context) {
                                                                                    return DialogView(
                                                                                      status: status,
                                                                                      idUser: widget.idUser,
                                                                                      auditor: snapshot.data.documents[index].data['subAreaAuditor'],
                                                                                      indexx: snapshot.data.documents[index].documentID,
                                                                                    );
                                                                                  }
                                                                                );
                                                                                // setState(() async {
                                                                                //   indexShowDetail = showDetail.length;
                                                                                //   if (showDetail[index]) {
                                                                                //     showDetail[index] = false;
                                                                                //     print('close');
                                                                                //     print(showDetail);
                                                                                //   } else {
                                                                                //     print('open');
                                                                                //     print(showDetail);
                                                                                //     showDetail.clear();
                                                                                //     for (int s = 0; s < indexShowDetail; s++) {
                                                                                //       showDetail.add(false);
                                                                                //     }
                                                                                //     showDetail[index] = !showDetail[index];

                                                                                //     if (showDetail[index] == true) {
                                                                                //       auditorName.clear();
                                                                                //       for (int o = 0; o < snapshot.data.documents[index].data['subAreaAuditor'].length; o++) {
                                                                                //         Firestore.instance.collection('user').where('id', isEqualTo: int.tryParse(snapshot.data.documents[index].data['subAreaAuditor'][o].toString())).snapshots().listen((data7) {
                                                                                //           setState(() {
                                                                                //             auditorName.add(data7.documents[0].data['nama']);
                                                                                //           });
                                                                                //         });
                                                                                //       }
                                                                                //     } else {
                                                                                //       auditorName.clear();
                                                                                //     }
                                                                                //   }
                                                                                //   await new Future.delayed(Duration(
                                                                                //     seconds: 3
                                                                                //   ));
                                                                                // });
                                                                              },
                                                                            ),
                                                                          )
                                                                        : ButtonTheme(
                                                                            minWidth: 50.0,
                                                                            height: 30.0,
                                                                            child: OutlineButton(
                                                                              child: Text(
                                                                                'CONFIRMED',
                                                                                style: TextStyle(
                                                                                  fontSize: 13.0,
                                                                                  color: AbubaPallate.greenabuba,
                                                                                  fontWeight: FontWeight.bold
                                                                                ),
                                                                              ),
                                                                              borderSide: BorderSide(color: AbubaPallate.greenabuba, width: 2.0),
                                                                              highlightedBorderColor: AbubaPallate.greenabuba,
                                                                              splashColor: AbubaPallate.greenabuba,
                                                                              onPressed: () {
                                                                                showDialog(
                                                                                  barrierDismissible: false,
                                                                                  context: context,
                                                                                  builder: (BuildContext context) {
                                                                                    return DialogView(
                                                                                      idUser: widget.idUser,
                                                                                      status: status,
                                                                                      auditor: snapshot.data.documents[index].data['subAreaAuditor'],
                                                                                      indexx: snapshot.data.documents[index].documentID,
                                                                                    );
                                                                                  }
                                                                                );
                                                                                // setState(() async {
                                                                                //   indexShowDetail = showDetail.length;
                                                                                //   if (showDetail[index]) {
                                                                                //     showDetail[index] = false;
                                                                                //     print('close');
                                                                                //     print(showDetail);
                                                                                //   } else {
                                                                                //     print('open');
                                                                                //     print(showDetail);
                                                                                //     showDetail.clear();
                                                                                //     for (int s = 0; s < indexShowDetail; s++) {
                                                                                //       showDetail.add(false);
                                                                                //     }
                                                                                //     showDetail[index] = !showDetail[index];

                                                                                //     if (showDetail[index] == true) {
                                                                                //       auditorName.clear();
                                                                                //       for (int o = 0; o < snapshot.data.documents[index].data['subAreaAuditor'].length; o++) {
                                                                                //         Firestore.instance.collection('user').where('id', isEqualTo: int.tryParse(snapshot.data.documents[index].data['subAreaAuditor'][o].toString())).snapshots().listen((data7) {
                                                                                //           setState(() {
                                                                                //             auditorName.add(data7.documents[0].data['nama']);
                                                                                //           });
                                                                                //         });
                                                                                //       }
                                                                                //     } else {
                                                                                //       auditorName.clear();
                                                                                //     }
                                                                                //   }
                                                                                //   await new Future.delayed(Duration(
                                                                                //     seconds: 3
                                                                                //   ));
                                                                                // });
                                                                              },
                                                                            ),
                                                                          )
                                                                    : status == 'LEAD AUDITOR'
                                                                        ? snapshot.data.documents[index].data['leadAuditorConfirm'].toString() == 'CONFIRM'
                                                                            ? ButtonTheme(
                                                                                minWidth: 50.0,
                                                                                height: 30.0,
                                                                                child: OutlineButton(
                                                                                  child: Text(
                                                                                    'CONFIRMED',
                                                                                    style: TextStyle(
                                                                                      fontSize: 13.0,
                                                                                      color: AbubaPallate.greenabuba,
                                                                                      fontWeight: FontWeight.bold
                                                                                    ),
                                                                                  ),
                                                                                  borderSide: BorderSide(color: AbubaPallate.greenabuba, width: 2.0),
                                                                                  highlightedBorderColor: AbubaPallate.greenabuba,
                                                                                  splashColor: AbubaPallate.greenabuba,
                                                                                  onPressed: () {
                                                                                    showDialog(
                                                                                      barrierDismissible: false,
                                                                                      context: context,
                                                                                      builder: (BuildContext context) {
                                                                                        return DialogView(
                                                                                          idUser: widget.idUser,
                                                                                          status: status,
                                                                                          auditor: snapshot.data.documents[index].data['subAreaAuditor'],
                                                                                          indexx: snapshot.data.documents[index].documentID,
                                                                                        );
                                                                                      }
                                                                                    );
                                                                                    // setState(() async {
                                                                                    //   indexShowDetail = showDetail.length;
                                                                                    //   if (showDetail[index]) {
                                                                                    //     showDetail[index] = false;
                                                                                    //     print('close');
                                                                                    //     print(showDetail);
                                                                                    //   } else {
                                                                                    //     print('open');
                                                                                    //     print(showDetail);
                                                                                    //     showDetail.clear();
                                                                                    //     for (int s = 0; s < indexShowDetail; s++) {
                                                                                    //       showDetail.add(false);
                                                                                    //     }
                                                                                    //     showDetail[index] = !showDetail[index];

                                                                                    //     if (showDetail[index] == true) {
                                                                                    //       auditorName.clear();
                                                                                    //       for (int o = 0; o < snapshot.data.documents[index].data['subAreaAuditor'].length; o++) {
                                                                                    //         Firestore.instance.collection('user').where('id', isEqualTo: int.tryParse(snapshot.data.documents[index].data['subAreaAuditor'][o].toString())).snapshots().listen((data7) {
                                                                                    //           setState(() {
                                                                                    //             auditorName.add(data7.documents[0].data['nama']);
                                                                                    //           });
                                                                                    //         });
                                                                                    //       }
                                                                                    //     } else {
                                                                                    //       auditorName.clear();
                                                                                    //     }
                                                                                    //   }
                                                                                    //   await new Future.delayed(Duration(
                                                                                    //     seconds: 3
                                                                                    //   ));
                                                                                    // });
                                                                                  },
                                                                                ),
                                                                              )
                                                                            : ButtonTheme(
                                                                                minWidth: 50.0,
                                                                                height: 30.0,
                                                                                child: OutlineButton(
                                                                                  child: Text(
                                                                                    'VIEW',
                                                                                    style: TextStyle(
                                                                                      fontSize: 13.0,
                                                                                      color: AbubaPallate.menuBluebird,
                                                                                      fontWeight: FontWeight.bold
                                                                                    ),
                                                                                  ),
                                                                                  borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 2.0),
                                                                                  highlightedBorderColor: AbubaPallate.menuBluebird,
                                                                                  splashColor: AbubaPallate.menuBluebird,
                                                                                  onPressed: () {
                                                                                    showDialog(
                                                                                      barrierDismissible: false,
                                                                                      context: context,
                                                                                      builder: (BuildContext context) {
                                                                                        return DialogView(
                                                                                          status: status,
                                                                                          idUser: widget.idUser,
                                                                                          auditor: snapshot.data.documents[index].data['subAreaAuditor'],
                                                                                          indexx: snapshot.data.documents[index].documentID,
                                                                                        );
                                                                                      }
                                                                                    );
                                                                                    // setState(() async {
                                                                                    //   indexShowDetail = showDetail.length;
                                                                                    //   if (showDetail[index]) {
                                                                                    //     showDetail[index] = false;
                                                                                    //     print('close');
                                                                                    //     print(showDetail);
                                                                                    //   } else {
                                                                                    //     print('open');
                                                                                    //     print(showDetail);
                                                                                    //     showDetail.clear();
                                                                                    //     for (int s = 0; s < indexShowDetail; s++) {
                                                                                    //       showDetail.add(false);
                                                                                    //     }
                                                                                    //     showDetail[index] = !showDetail[index];

                                                                                    //     if (showDetail[index] == true) {
                                                                                    //       auditorName.clear();
                                                                                    //       for (int o = 0; o < snapshot.data.documents[index].data['subAreaAuditor'].length; o++) {
                                                                                    //         Firestore.instance.collection('user').where('id', isEqualTo: int.tryParse(snapshot.data.documents[index].data['subAreaAuditor'][o].toString())).snapshots().listen((data7) {
                                                                                    //           setState(() {
                                                                                    //             auditorName.add(data7.documents[0].data['nama']);
                                                                                    //           });
                                                                                    //         });
                                                                                    //       }
                                                                                    //     } else {
                                                                                    //       auditorName.clear();
                                                                                    //     }
                                                                                    //   }
                                                                                    //   await new Future.delayed(Duration(
                                                                                    //     seconds: 3
                                                                                    //   ));
                                                                                    // });
                                                                                  },
                                                                                ),
                                                                              )
                                                                        : Container()
                                                        ],
                                                      ),
                                                    )
                                                  ),
                                                ],
                                              ),
                                              showDetail[index] == true
                                                ? Padding(
                                                    padding: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                    child: Container(
                                                      decoration: const BoxDecoration(
                                                        border: Border(
                                                          top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                          left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                          right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                          bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                        ),
                                                      ),
                                                      padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
                                                      child: Column(
                                                        children: <Widget>[
                                                          Padding(
                                                            padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 5.0, top: 10.0),
                                                            child: Container(
                                                              width: MediaQuery.of(context).size.width,
                                                              height: 35.0,
                                                              decoration: new BoxDecoration(
                                                                color: Colors.grey,
                                                                shape: BoxShape.rectangle,
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: <Widget>[
                                                                  Flexible(
                                                                    child: Container(
                                                                      padding: EdgeInsets.only(left: 10.0),
                                                                      alignment: Alignment.centerLeft,
                                                                      child: Text(
                                                                        'Department',
                                                                        style: TextStyle(
                                                                            color: Colors.white, fontSize: 12.0),
                                                                        textAlign: TextAlign.center,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Flexible(
                                                                    child: Container(
                                                                      alignment: Alignment.centerLeft,
                                                                      child: Text(
                                                                        'Sub Area - Auditor',
                                                                        style: TextStyle(
                                                                            color: Colors.white, fontSize: 12.0),
                                                                        textAlign: TextAlign.center,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(left: 20.0, right: 12.0, top: 10.0),
                                                            child: Column(
                                                              children: <Widget>[
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: <Widget>[
                                                                    Container(
                                                                      alignment: Alignment.topLeft,
                                                                      width: MediaQuery.of(context).size.width * 0.3,
                                                                      child: Column( 
                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                        children: <Widget>[
                                                                          Row(
                                                                            children: <Widget>[
                                                                              Flexible(
                                                                                child: Text(
                                                                                  department[index],
                                                                                  style: TextStyle(color: Colors.grey[500], fontSize: 13.0, fontWeight: FontWeight.w700)
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(
                                                                            height: 3.0,
                                                                          ),
                                                                          Row(
                                                                            children: <Widget>[
                                                                              Flexible(
                                                                                child: Text(
                                                                                  object[index],
                                                                                  style: TextStyle(color: Colors.grey[500], fontSize: 13.0, fontWeight: FontWeight.w700)
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(
                                                                            height: 3.0,
                                                                          ),
                                                                          Row(
                                                                            children: <Widget>[
                                                                              Flexible(
                                                                                child: Text(
                                                                                  tanggalAudit.toDate().toString().substring(8, 10) + '/' + tanggalAudit.toDate().toString().substring(5, 7) + '/' + tanggalAudit.toDate().toString().substring(0, 4),
                                                                                  style: TextStyle(color: Colors.grey[500], fontSize: 13.0, fontWeight: FontWeight.w700)
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(
                                                                            height: 15.0,
                                                                          ),
                                                                          Row(
                                                                            children: <Widget>[
                                                                              Flexible(
                                                                                child: Text(
                                                                                  'Auditee',
                                                                                  style: TextStyle(color: AbubaPallate.greenabuba, fontSize: 13.0, fontWeight: FontWeight.w700)
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(
                                                                            height: 3.0,
                                                                          ),
                                                                          Row(
                                                                            children: <Widget>[
                                                                              Flexible(
                                                                                child: Text(
                                                                                  auditeeName[index],
                                                                                  style: TextStyle(color: Colors.grey[500], fontSize: 13.0, fontWeight: FontWeight.w700)
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                width: 3.0,
                                                                              ),
                                                                              snapshot.data.documents[index].data['auditeeConfirm'].toString() != 'CONFIRM'
                                                                                ? Container()
                                                                                : Flexible(
                                                                                    child: Tooltip(
                                                                                      child: Icon(Icons.check, size: 16.0, color: Colors.green),
                                                                                      message: 'CONFIRMED',
                                                                                    )
                                                                                  )
                                                                            ],
                                                                          ),
                                                                          SizedBox(
                                                                            height: 15.0,
                                                                          ),
                                                                          Row(
                                                                            children: <Widget>[
                                                                              Flexible(
                                                                                child: Text(
                                                                                  'Lead Auditor',
                                                                                  style: TextStyle(color: AbubaPallate.greenabuba, fontSize: 13.0, fontWeight: FontWeight.w700)
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                width: 3.0,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(
                                                                            height: 3.0,
                                                                          ),
                                                                          Row(
                                                                            children: <Widget>[
                                                                              Flexible(
                                                                                child: Text(
                                                                                  leadAuditorName[index],
                                                                                  style: TextStyle(color: Colors.grey[500], fontSize: 13.0, fontWeight: FontWeight.w700)
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                width: 3.0,
                                                                              ),
                                                                              snapshot.data.documents[index].data['leadAuditorConfirm'].toString() != 'CONFIRM'
                                                                                ? Container()
                                                                                : Flexible(
                                                                                    child: Tooltip(
                                                                                      child: Icon(Icons.check, size: 16.0, color: Colors.green),
                                                                                      message: 'CONFIRMED',
                                                                                    )
                                                                                  )
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      width: MediaQuery.of(context).size.width * 0.5,
                                                                      child: Column(
                                                                        children: List.generate(snapshot.data.documents[index].data['subArea'].length, (index2) {
                                                                          return Column(
                                                                            children: <Widget>[
                                                                              Row(
                                                                                children: <Widget>[
                                                                                  Flexible(
                                                                                    child: Text(
                                                                                      snapshot.data.documents[index].data['subArea'][index2],
                                                                                      style: TextStyle(color: Colors.grey[500], fontSize: 13.0, fontWeight: FontWeight.w700)
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                children: <Widget>[
                                                                                  Flexible(
                                                                                    child: Text(
                                                                                      auditorName[index2].toString(),
                                                                                      style: TextStyle(color: Colors.grey[500], fontSize: 13.0)
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: 5.0,
                                                                                  ),
                                                                                  snapshot.data.documents[index].data['auditorConfirm'][index2] != 'CONFIRM'
                                                                                    ? Container()
                                                                                    : Flexible(
                                                                                        child: Tooltip(
                                                                                          child: Icon(Icons.check, size: 16.0, color: Colors.green),
                                                                                          message: 'CONFIRMED',
                                                                                        )
                                                                                      )
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 10.0,
                                                                              )
                                                                            ],
                                                                          );
                                                                        }).toList(),
                                                                      )
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            )
                                                          ),
                                                          status == 'AUDITOR'
                                                            ? snapshot.data.documents[index].data['auditorConfirm'].contains(widget.idUser.toString())
                                                                ? Container(
                                                                    alignment: Alignment.centerRight,
                                                                    padding: EdgeInsets.only(right: 20.0, top: 5.0),
                                                                    child: ButtonTheme(
                                                                      minWidth: 50.0,
                                                                      height: 30.0,
                                                                      child: RaisedButton(
                                                                        child: isProcess
                                                                          ? SizedBox(
                                                                              child: CircularProgressIndicator(
                                                                                valueColor: AlwaysStoppedAnimation(Colors.white),
                                                                                strokeWidth: 2.0
                                                                              ),
                                                                              height: 20.0,
                                                                              width: 20.0
                                                                            )
                                                                          : Text(
                                                                              'CONFIRM',
                                                                              style: TextStyle(
                                                                                fontSize: 13.0,
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.bold
                                                                              ),
                                                                            ),
                                                                        elevation: 0.0,
                                                                        color: AbubaPallate.greenabuba,
                                                                        splashColor: AbubaPallate.greenabuba,
                                                                        onPressed: () {
                                                                          setState(() {
                                                                            isProcess = true;
                                                                          });
                                                                          DocumentReference docReference = Firestore.instance.collection('audit_internal').document(snapshot.data.documents[index].documentID);
                                                                          List<String> auditorConfirmSave = [];

                                                                          for (int au = 0; au < snapshot.data.documents[index].data['subAreaAuditor'].length; au++) {
                                                                            if (int.tryParse(snapshot.data.documents[index].data['subAreaAuditor'][au].toString()) == widget.idUser) {
                                                                              auditorConfirmSave.add('CONFIRM');
                                                                            } else {
                                                                              auditorConfirmSave.add(snapshot.data.documents[index].data['auditorConfirm'][au].toString());
                                                                            }
                                                                          }
                                                                          docReference.updateData({
                                                                            'auditorConfirm': auditorConfirmSave,
                                                                          }).then((doc) {
                                                                            setState(() {
                                                                              isProcess = false;
                                                                            });
                                                                            print('success confirm auditor');
                                                                          }).catchError((error) {
                                                                            print(error);
                                                                          });
                                                                        },
                                                                      ),
                                                                    ),
                                                                  )
                                                                : Container()
                                                            : Container(),
                                                          status == 'LEAD AUDITOR'
                                                            ? snapshot.data.documents[index].data['leadAuditorConfirm'].toString() == widget.idUser.toString()
                                                                ? Container(
                                                                    alignment: Alignment.centerRight,
                                                                    padding: EdgeInsets.only(right: 20.0, top: 5.0),
                                                                    child: ButtonTheme(
                                                                      minWidth: 50.0,
                                                                      height: 30.0,
                                                                      child: RaisedButton(
                                                                        child: isProcess
                                                                          ? SizedBox(
                                                                              child: CircularProgressIndicator(
                                                                                valueColor: AlwaysStoppedAnimation(Colors.white),
                                                                                strokeWidth: 2.0
                                                                              ),
                                                                              height: 20.0,
                                                                              width: 20.0
                                                                            )
                                                                          : Text(
                                                                              'CONFIRM',
                                                                              style: TextStyle(
                                                                                fontSize: 13.0,
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.bold
                                                                              ),
                                                                            ),
                                                                        elevation: 0.0,
                                                                        color: AbubaPallate.greenabuba,
                                                                        splashColor: AbubaPallate.greenabuba,
                                                                        onPressed: () {
                                                                          setState(() {
                                                                            isProcess = true;
                                                                          });

                                                                          if (snapshot.data.documents[index].data['auditorConfirm'].contains(widget.idUser.toString())) {
                                                                            DocumentReference docReference = Firestore.instance.collection('audit_internal').document(snapshot.data.documents[index].documentID);
                                                                            List<String> auditorConfirmSave = [];

                                                                            for (int au = 0; au < snapshot.data.documents[index].data['subAreaAuditor'].length; au++) {
                                                                              if (int.tryParse(snapshot.data.documents[index].data['subAreaAuditor'][au].toString()) == widget.idUser) {
                                                                                auditorConfirmSave.add('CONFIRM');
                                                                              } else {
                                                                                auditorConfirmSave.add(snapshot.data.documents[index].data['auditorConfirm'][au].toString());
                                                                              }
                                                                            }
                                                                            docReference.updateData({
                                                                              'auditorConfirm': auditorConfirmSave,
                                                                              'leadAuditorConfirm': 'CONFIRM',
                                                                            }).then((doc) {
                                                                              setState(() {
                                                                                isProcess = false;
                                                                              });
                                                                              print('success confirm lead dan auditor');
                                                                            }).catchError((error) {
                                                                              print(error);
                                                                            });
                                                                          } else {
                                                                            DocumentReference docReference = Firestore.instance.collection('audit_internal').document(snapshot.data.documents[index].documentID);
                                                                            docReference.updateData({
                                                                              'leadAuditorConfirm': 'CONFIRM',
                                                                            }).then((doc) {
                                                                              setState(() {
                                                                                isProcess = false;
                                                                              });
                                                                              print('success confirm lead auditor');
                                                                            }).catchError((error) {
                                                                              print(error);
                                                                            });
                                                                          }
                                                                        },
                                                                      ),
                                                                    ),
                                                                  )
                                                                : Container()
                                                            : Container(),
                                                          status == 'AUDITEE'
                                                            ? snapshot.data.documents[index].data['auditeeConfirm'].toString() == widget.idUser.toString()
                                                                ? Container(
                                                                    alignment: Alignment.centerRight,
                                                                    padding: EdgeInsets.only(right: 20.0, top: 5.0),
                                                                    child: ButtonTheme(
                                                                      minWidth: 50.0,
                                                                      height: 30.0,
                                                                      child: RaisedButton(
                                                                        child: isProcess
                                                                          ? SizedBox(
                                                                              child: CircularProgressIndicator(
                                                                                valueColor: AlwaysStoppedAnimation(Colors.white),
                                                                                strokeWidth: 2.0
                                                                              ),
                                                                              height: 20.0,
                                                                              width: 20.0
                                                                            )
                                                                          : Text(
                                                                              'CONFIRM',
                                                                              style: TextStyle(
                                                                                fontSize: 13.0,
                                                                                color: Colors.white,
                                                                                fontWeight: FontWeight.bold
                                                                              ),
                                                                            ),
                                                                        elevation: 0.0,
                                                                        color: AbubaPallate.greenabuba,
                                                                        splashColor: AbubaPallate.greenabuba,
                                                                        onPressed: () {
                                                                          setState(() {
                                                                            isProcess = true;
                                                                          });
                                                                          DocumentReference docReference = Firestore.instance.collection('audit_internal').document(snapshot.data.documents[index].documentID);
                                                                          docReference.updateData({
                                                                            'auditeeConfirm': 'CONFIRM',
                                                                          }).then((doc) {
                                                                            setState(() {
                                                                              isProcess = false;
                                                                            });
                                                                            print('success confirm auditee');
                                                                          }).catchError((error) {
                                                                            print(error);
                                                                          });
                                                                        },
                                                                      ),
                                                                    ),
                                                                  )
                                                                : Container()
                                                            : Container()
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                : Container()
                                            ],
                                          )
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                } else {
                                  return Container();
                                }
                              }).toList()
                            );
                          },
                        )
                      )
                    ],
                  );
            },
          ),
        )
      ),
    );
  }
}

class DialogView extends StatefulWidget {
  var indexx;
  List<dynamic> auditor;
  final String status;
  final int idUser;

  DialogView({this.indexx, this.auditor, this.status, this.idUser});
  @override
  _DialogViewState createState() => _DialogViewState();
}

class _DialogViewState extends State<DialogView> with TickerProviderStateMixin {
  AnimationController animationController;
  String department;
  String object;
  String tanggal;
  String auditeeName;
  String auditeeConfirm;
  String leadAuditorName;
  String leadAuditorConfirm;
  List<dynamic> subArea = [];
  List<dynamic> auditorName = [];
  List<dynamic> auditorConfirm = [];
  bool isProcess = false;
  
  @override
  void initState() {
    Firestore.instance.collection('audit_internal').document(widget.indexx).snapshots().listen((data) {
      setState(() {
        Timestamp tanggalBantu = data.data['dateAudit'];
        tanggal = tanggalBantu.toDate().toString().substring(8, 10) + '/' + tanggalBantu.toDate().toString().substring(5, 7) + '/' + tanggalBantu.toDate().toString().substring(0, 4);
        auditeeConfirm = data.data['auditeeConfirm'].toString();
        leadAuditorConfirm = data.data['leadAuditorConfirm'].toString();
        subArea = data.data['subArea'];
        auditorConfirm = data.data['auditorConfirm'];

        Firestore.instance.collection('department').where('id', isEqualTo: data.data['department']).snapshots().listen((data2) {
          department = data2.documents[0].data['name'];
        });

        Firestore.instance.collection('audit_object').where('id', isEqualTo: data.data['object']).snapshots().listen((data3) {
          object = data3.documents[0].data['object'];
        });

        Firestore.instance.collection('user').where('id', isEqualTo: data.data['auditee']).snapshots().listen((data4) {
          auditeeName = data4.documents[0].data['nama'];
        });

        Firestore.instance.collection('user').where('id', isEqualTo: data.data['leadAuditor']).snapshots().listen((data5) {
          leadAuditorName = data5.documents[0].data['nama'];
        });
      });
    });

    for (int a = 0; a < widget.auditor.length; a++) {
      Firestore.instance.collection('user').where('id', isEqualTo: int.tryParse(widget.auditor[a].toString())).snapshots().listen((data) {
        setState(() {
          auditorName.add(data.documents[0].data['nama']);
        });
      });
    }
    
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(
      from: animationController.value == 0.0
        ? 1.0
        : animationController.value
    );

    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        child: AnimatedBuilder(
          animation: animationController,
          builder: (_, Widget child) {
            return animationController.isAnimating
              ? Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 5.0, top: 10.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 35.0,
                        decoration: new BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.rectangle,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.only(left: 10.0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Department',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12.0),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Sub Area - Auditor',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12.0),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ),
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                            child: Container(
                              padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0, right: 12.0, top: 10.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              alignment: Alignment.topLeft,
                                              width: MediaQuery.of(context).size.width * 0.2,
                                              child: Column( 
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          department,
                                                          style: TextStyle(color: Colors.grey[500], fontSize: 13.0, fontWeight: FontWeight.w700)
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 3.0,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          object,
                                                          style: TextStyle(color: Colors.grey[500], fontSize: 13.0, fontWeight: FontWeight.w700)
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 3.0,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          tanggal,
                                                          style: TextStyle(color: Colors.grey[500], fontSize: 13.0, fontWeight: FontWeight.w700)
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 15.0,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'Auditee',
                                                          style: TextStyle(color: AbubaPallate.greenabuba, fontSize: 13.0, fontWeight: FontWeight.w700)
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 3.0,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          auditeeName,
                                                          style: TextStyle(color: Colors.grey[500], fontSize: 13.0, fontWeight: FontWeight.w700)
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 3.0,
                                                      ),
                                                      auditeeConfirm.toString() != 'CONFIRM'
                                                        ? Container()
                                                        : Flexible(
                                                            child: Tooltip(
                                                              child: Icon(Icons.check, size: 16.0, color: Colors.green),
                                                              message: 'CONFIRMED',
                                                            )
                                                          )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 15.0,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'Lead Auditor',
                                                          style: TextStyle(color: AbubaPallate.greenabuba, fontSize: 13.0, fontWeight: FontWeight.w700)
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 3.0,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 3.0,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          leadAuditorName,
                                                          style: TextStyle(color: Colors.grey[500], fontSize: 13.0, fontWeight: FontWeight.w700)
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 3.0,
                                                      ),
                                                      leadAuditorConfirm.toString() != 'CONFIRM'
                                                        ? Container()
                                                        : Flexible(
                                                            child: Tooltip(
                                                              child: Icon(Icons.check, size: 16.0, color: Colors.green),
                                                              message: 'CONFIRMED',
                                                            )
                                                          )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.45,
                                              child: Column(
                                                children: List.generate(subArea.length, (index2) {
                                                  return Column(
                                                    children: <Widget>[
                                                      Row(
                                                        children: <Widget>[
                                                          Flexible(
                                                            child: Text(
                                                              subArea[index2],
                                                              style: TextStyle(color: Colors.grey[500], fontSize: 13.0, fontWeight: FontWeight.w700)
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: <Widget>[
                                                          Flexible(
                                                            child: Text(
                                                              auditorName[index2],
                                                              style: TextStyle(color: Colors.grey[500], fontSize: 13.0)
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 5.0,
                                                          ),
                                                          auditorConfirm[index2] != 'CONFIRM'
                                                            ? Container()
                                                            : Flexible(
                                                                child: Tooltip(
                                                                  child: Icon(Icons.check, size: 16.0, color: Colors.green),
                                                                  message: 'CONFIRMED',
                                                                )
                                                              )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10.0,
                                                      )
                                                    ],
                                                  );
                                                }).toList(),
                                              )
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                          child: Text('Close', style: TextStyle(color: Colors.black45)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        widget.status == 'AUDITOR'
                          ? auditorConfirm.contains(widget.idUser.toString())
                              ? FlatButton(
                                  child: isProcess
                                    ? SizedBox(
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation(AbubaPallate.greenabuba),
                                          strokeWidth: 2.0
                                        ),
                                        height: 20.0,
                                        width: 20.0
                                      )
                                    : Text('Confirm', style: TextStyle(color: AbubaPallate.greenabuba)),
                                  onPressed: () {
                                    setState(() {
                                      isProcess = true;
                                    });
                                    DocumentReference docReference = Firestore.instance.collection('audit_internal').document(widget.indexx);
                                    List<String> auditorConfirmSave = [];

                                    for (int au = 0; au < widget.auditor.length; au++) {
                                      if (int.tryParse(widget.auditor[au].toString()) == widget.idUser) {
                                        auditorConfirmSave.add('CONFIRM');
                                      } else {
                                        auditorConfirmSave.add(auditorConfirm[au].toString());
                                      }
                                    }
                                    docReference.updateData({
                                      'auditorConfirm': auditorConfirmSave,
                                    }).then((doc) {
                                      setState(() {
                                        isProcess = false;
                                      });
                                      print('success confirm auditor');
                                      Navigator.pop(context);
                                    }).catchError((error) {
                                      print(error);
                                    });
                                  },
                                )
                              : Container()
                          : Container(),
                        widget.status == 'LEAD AUDITOR'
                          ? leadAuditorConfirm.toString() == widget.idUser.toString()
                              ? FlatButton(
                                  child: isProcess
                                    ? SizedBox(
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation(AbubaPallate.greenabuba),
                                          strokeWidth: 2.0
                                        ),
                                        height: 20.0,
                                        width: 20.0
                                      )
                                    : Text('Confirm', style: TextStyle(color: AbubaPallate.greenabuba)),
                                  onPressed: () {
                                    setState(() {
                                      isProcess = true;
                                    });

                                    if (auditorConfirm.contains(widget.idUser.toString())) {
                                      DocumentReference docReference = Firestore.instance.collection('audit_internal').document(widget.indexx);
                                      List<String> auditorConfirmSave = [];

                                      for (int au = 0; au < widget.auditor.length; au++) {
                                        if (int.tryParse(widget.auditor[au].toString()) == widget.idUser) {
                                          auditorConfirmSave.add('CONFIRM');
                                        } else {
                                          auditorConfirmSave.add(auditorConfirm[au].toString());
                                        }
                                      }
                                      docReference.updateData({
                                        'auditorConfirm': auditorConfirmSave,
                                        'leadAuditorConfirm': 'CONFIRM',
                                      }).then((doc) {
                                        setState(() {
                                          isProcess = false;
                                        });
                                        print('success confirm lead dan auditor');
                                        Navigator.pop(context);
                                      }).catchError((error) {
                                        print(error);
                                      });
                                    } else {
                                      DocumentReference docReference = Firestore.instance.collection('audit_internal').document(widget.indexx);
                                      docReference.updateData({
                                        'leadAuditorConfirm': 'CONFIRM',
                                      }).then((doc) {
                                        setState(() {
                                          isProcess = false;
                                        });
                                        print('success confirm lead auditor');
                                        Navigator.pop(context);
                                      }).catchError((error) {
                                        print(error);
                                      });
                                    }
                                  },
                                )
                              : Container()
                          : Container(),
                        widget.status == 'AUDITEE'
                          ? auditeeConfirm.toString() == widget.idUser.toString()
                              ? FlatButton(
                                  child: isProcess
                                    ? SizedBox(
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation(AbubaPallate.greenabuba),
                                          strokeWidth: 2.0
                                        ),
                                        height: 20.0,
                                        width: 20.0
                                      )
                                    : Text('Confirm', style: TextStyle(color: AbubaPallate.greenabuba)),
                                  onPressed: () {
                                    setState(() {
                                      isProcess = true;
                                    });
                                    DocumentReference docReference = Firestore.instance.collection('audit_internal').document(widget.indexx);
                                    docReference.updateData({
                                      'auditeeConfirm': 'CONFIRM',
                                    }).then((doc) {
                                      setState(() {
                                        isProcess = false;
                                      });
                                      print('success confirm auditee');
                                      Navigator.pop(context);
                                    }).catchError((error) {
                                      print(error);
                                    });
                                  },
                                )
                              : Container()
                          : Container()
                      ],
                    )
                  ],
                );
          },
        )
      ),
    );
  }
}