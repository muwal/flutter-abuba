import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/isoft/operation_page/meeting/done_task.dart';
import 'package:flutter_abuba/isoft/operation_page/meeting/report_meeting.dart';

import 'form_createnew.dart';
import 'form_checkin.dart';

class MenuMeeting extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  MenuMeeting({this.idUser, this.namaUser, this.departmentUser});

  @override
  _MenuMeetingState createState() => _MenuMeetingState();
}

class _MenuMeetingState extends State<MenuMeeting> {
  final _scaffoldState = GlobalKey<ScaffoldState>();

  bool showNotifOpenStatus = false;
  bool showNotifCheckIn = false;

  @override
  void initState() {
    CollectionReference reference = Firestore.instance.collection('minutesMeeting');
    reference.where('status', isEqualTo: 'CLOSE').where('picIDNotulen', arrayContains: widget.idUser).snapshots().listen((querySnapshot) {
      querySnapshot.documentChanges.forEach((change) {
        setState(() {
          int indexPIC = change.document.data['picIDNotulen'].indexOf(widget.idUser);
          if (change.document.data['statusActionPlan'][indexPIC] == 'OPEN') {
            showNotifOpenStatus = true;
          } else {
            showNotifOpenStatus = false;
          }
        });
      });
    });

    CollectionReference reference2 = Firestore.instance.collection('minutesMeeting');
    reference2.where('status', isEqualTo: 'OPEN').where('pesertaID', arrayContains: widget.idUser).snapshots().listen((querySnapshot2) {
      querySnapshot2.documentChanges.forEach((change2) {
        setState(() {
          Timestamp bantu = change2.document.data['dateMeeting'];
          if (bantu.toDate().toString().substring(8, 10) + '/' + bantu.toDate().toString().substring(5, 7) + '/' +bantu.toDate().toString().substring(0, 4) == DateTime.now().toString().substring(8, 10) + '/' + DateTime.now().toString().substring(5, 7) + '/' +DateTime.now().toString().substring(0, 4)) {
            int indexPIC = change2.document.data['pesertaID'].indexOf(widget.idUser);
            if (change2.document.data['checkOutPeserta'][indexPIC] == null) {
              showNotifCheckIn = true;
            } else {
              showNotifCheckIn = false;
            }
          } else {
            showNotifCheckIn = false;
          }
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldState,
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
        body: _buildLogMenu(),
      ),
    );
  }

  Widget _buildLogMenu() {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'ISO',
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
                  'Minute of Meeting',
                  style:
                      TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Wrap(
            spacing: 10.0,
            runSpacing: 15.0,
            direction: Axis.horizontal,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => Navigator.push(context,
                        MyCustomRoute(builder: (context) => FormCreateNew(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser))),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Stack(
                          overflow: Overflow.visible,
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.width * 0.09,
                              width: MediaQuery.of(context).size.width * 0.09,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                        'assets/images/hrd/create new.png',
                                      ),
                                      fit: BoxFit.cover
                                  )
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            'Create',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => Navigator.push(context,
                            MyCustomRoute(builder: (context) => FormCheckin(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser))),
                        child: Stack(
                          overflow: Overflow.visible,
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.width * 0.09,
                              width: MediaQuery.of(context).size.width * 0.09,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                        'assets/images/iso/qc.png',
                                      ),
                                      fit: BoxFit.cover
                                  )
                              ),
                            ),
                            showNotifCheckIn
                              ? Positioned(
                                  top: 0.0,
                                  right: 0.0,
                                  child: Icon(
                                    Icons.brightness_1,
                                    size: 13.0,
                                    color: Colors.redAccent,
                                  ),
                                )
                              : Container()
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text('Check In',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12.0),
                            softWrap: false,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => Navigator.push(context,
                            MyCustomRoute(builder: (context) => DoneTask(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser))),
                        child: Stack(
                          overflow: Overflow.visible,
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.width * 0.09,
                              width: MediaQuery.of(context).size.width * 0.09,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                        'assets/images/hrd/open status.png',
                                      ),
                                      fit: BoxFit.cover
                                  )
                              ),
                            ),
                            showNotifOpenStatus
                              ? Positioned(
                                  top: 0.0,
                                  right: 0.0,
                                  child: Icon(
                                    Icons.brightness_1,
                                    size: 13.0,
                                    color: Colors.redAccent,
                                  ),
                                )
                              : Container()
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text('Open Status',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12.0),
                            softWrap: false,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                        MaterialPageRoute(
                          builder: (_) => FormReport(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)
                        )
                      );
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Stack(
                          overflow: Overflow.visible,
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.width * 0.09,
                              width: MediaQuery.of(context).size.width * 0.09,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                        'assets/images/IT/report.png',
                                      ),
                                      fit: BoxFit.cover
                                  )
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            'Report',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
