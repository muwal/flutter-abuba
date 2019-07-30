import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/isoft/operation_page/changemanagement/management_approval.dart';
import 'package:flutter_abuba/isoft/operation_page/changemanagement/management_create.dart';
import 'package:flutter_abuba/isoft/operation_page/changemanagement/management_report.dart';
import 'package:flutter_abuba/isoft/operation_page/changemanagement/management_review.dart';

class BerandaManagement extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;

  BerandaManagement({this.idUser, this.namaUser, this.departmentUser});
  @override
  _BerandaManagementState createState() => _BerandaManagementState();
}

class _BerandaManagementState extends State<BerandaManagement> {
  bool showNotifChangeMgmtReview = false;
  bool showNotifChangeMgmtApproval = false;

  @override
  void initState() {
    CollectionReference reference = Firestore.instance.collection('changeMgmt');
    reference.where('personReview', arrayContains: widget.idUser).where('statusApprove', isEqualTo: false).where('finalStatus', isEqualTo: 'OPEN').snapshots().listen((querySnapshot) {
      querySnapshot.documentChanges.forEach((change) {
        setState(() {
          int indexPIC = change.document.data['personReview'].indexOf(widget.idUser);
          if (change.document.data['personReviewStatus'][indexPIC] == 'OPEN') {
            showNotifChangeMgmtReview = true;
          } else {
            showNotifChangeMgmtReview = false;
          }
        });
      });
    });

    CollectionReference reference2 = Firestore.instance.collection('changeMgmt');
    reference2.where('approveBy', isEqualTo: widget.idUser).where('finalStatus', isEqualTo: 'OPEN').snapshots().listen((querySnapshot2) {
      querySnapshot2.documentChanges.forEach((change2) {
        setState(() {
          if (change2.document.data['personReviewStatus'].contains('OPEN') == false) {
            showNotifChangeMgmtApproval = true;
          } else {
            showNotifChangeMgmtApproval = false;
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
                  'Change Management',
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
                    onTap: () {
                      Navigator.push(context,
                        MyCustomRoute(
                          builder: (context) => new ManagementCreate(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)
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
                        onTap: () {
                          Navigator.push(context,
                            MyCustomRoute(
                              builder: (context) => new ManagementReview(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)
                            )
                          );
                        },
                        child: Stack(
                          overflow: Overflow.visible,
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.width * 0.09,
                              width: MediaQuery.of(context).size.width * 0.09,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                        'assets/images/incoming/inspection.png',
                                      ),
                                      fit: BoxFit.cover
                                  )
                              ),
                            ),
                            showNotifChangeMgmtReview
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
                        child: Text('Review',
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
                        MyCustomRoute(
                          builder: (context) => new ManagementApproval(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)
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
                                        'assets/images/iso/qc.png',
                                      ),
                                      fit: BoxFit.cover
                                  )
                              ),
                            ),
                            showNotifChangeMgmtApproval
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
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            'Approval',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                        MyCustomRoute(
                          builder: (context) => new ManagementReport(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)
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
                                        'assets/images/hrd/report.png',
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
