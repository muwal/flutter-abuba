import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/creative_page/form_comment.dart';
import 'package:flutter_abuba/creative_page/form_create.dart';
import 'package:flutter_abuba/creative_page/form_detail.dart';
import 'package:flutter_abuba/isoft/operation_page/incoming/beranda_incoming.dart';
import 'package:flutter_abuba/isoft/operation_page/incoming/beranda_incoming2.dart';
import 'package:flutter_abuba/isoft/operation_page/kpimonitoring/kpi_monitoring_beranda.dart';
import 'package:flutter_abuba/isoft/operation_page/workinginstruction/beranda_working.dart';
import 'package:flutter_abuba/whats_page/form_comment.dart';
import 'package:flutter_abuba/whats_page/form_create_happening.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:flutter_abuba/isoft/operation_page/logbook/beranda_logbook.dart';
import 'package:flutter_abuba/isoft/operation_page/dailychecklist/beranda_checklist.dart';
import 'kitchen/form_inspection.dart';
import 'internalaudit/beranda_audit.dart';
import 'correctiveaction/beranda_corrective.dart';
import 'meeting/beranda_meeting.dart';
import 'changemanagement/beranda_management.dart';
import 'riskassesment/beranda_risk_register.dart';
import 'qcchecklist/beranda_qc.dart';
import 'documentcontrol/beranda_document.dart';
import 'logbook/linecheck/beranda_linecheck.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BerandaOperation extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  BerandaOperation({this.idUser, this.namaUser, this.departmentUser});

  @override
  _BerandaOperationState createState() => _BerandaOperationState();
}

class _BerandaOperationState extends State<BerandaOperation> with TickerProviderStateMixin {
  AnimationController animationController;

  List<String> department = [
    'Procurement',
    'FAT',
    'IA',
    'BD',
    'HRD',
    'IT',
    'BOD',
    'IA',
    'OPR',
  ];

  List<String> nama = [
    'Inne Rettiani',
    'Dewi Kurniasih',
    'Indah',
    'Andi Lala',
    'Rizal Baydillah',
    'Sony Ramdhani Tahir',
    'M. Ali Ariansyah',
    'Ade Ridwan',
    'Rahmat Yasir',
  ];

  List<String> gambar = [
    'inne.jpeg',
    'Ibu DEWI KURNIASIH - FAT MANAGER.png',
    'INDAH.jpeg',
    'Pak ANDI LALA - BUSINESS DEVELOPMENT MANAGER.jpeg',
    'Pak RIZAL BAYDILLAH - HRD MANAGER.jpeg',
    'Pak SONNY RAMADHAN - IT ASST. MANAGER.jpg',
    'DIRUT (2).jpg',
    'Pak ADE RIDWAN - INTERNAL AUDIT MANAGER.jpeg',
    'Pak YASIR - OPERASIONAL MANAGER.jpeg',
  ];

  List<bool> _alreadyOKHappening = [false, false, true];
  List<int> _counterOKHappening = [200, 150, 500];
  List<bool> _likeHappening = [false, true, false];
  List<int> _counterLikeHappening = [0, 20, 100];

  List<bool> _likeIdea = [false, true, false];
  List<int> _counterLikeIdea = [0, 20, 100];
  List<int> _counterViewIdea = [100, 50, 33];

  @override
  void initState() {
    super.initState();
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
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: _appBar(),
          body: TabBarView(
            children: <Widget>[
              _buildOperationMenu(),
              _buildIsoMenu(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIsoMenu() {
    return ListView(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
              child: Text(
                'ISO Requirements',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
            ),
            /*Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: ButtonTheme(
                minWidth: 50.0,
                height: 20.0,
                child: RaisedButton(
                  color: AbubaPallate.greenabuba,
                  child: Text(
                    'Info',
                    style: TextStyle(fontSize: 13.0, color: Colors.white),
                  ),
                  onPressed: () {},
                ),
              ),
            ),*/
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Text(
            'ISO 9001, OHSAS 18001, ISO 14001, HACCP, Halal',
            style: TextStyle(color: Colors.black38),
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        Wrap(
          spacing: 10.0,
          runSpacing: 15.0,
          direction: Axis.horizontal,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(context,
                  //       MaterialPageRoute(
                  //         builder: (context) => new BerandaKpiMonitoring()
                  //       )
                  //     );
                  //   },
                  //   child: Column(
                  //     mainAxisSize: MainAxisSize.min,
                  //     children: <Widget>[
                  //       Stack(
                  //         overflow: Overflow.visible,
                  //         children: <Widget>[
                  //           Container(
                  //             height: MediaQuery.of(context).size.width * 0.09,
                  //             width: MediaQuery.of(context).size.width * 0.09,
                  //             decoration: BoxDecoration(
                  //                 image: DecorationImage(
                  //                     image: AssetImage(
                  //                       'assets/images/iso/kpi.png',
                  //                     ),
                  //                     fit: BoxFit.cover
                  //                 )
                  //             ),
                  //           ),
                  //           /*Positioned(
                  //             top: -5.0,
                  //             right: -5.0,
                  //             child: Icon(
                  //               Icons.brightness_1,
                  //               size: 25.0,
                  //               color: Colors.redAccent,
                  //             ),
                  //           ),
                  //           Positioned(
                  //             top: 0.0,
                  //             right: 4.0,
                  //             child: Text(
                  //               '2',
                  //               style: TextStyle(color: Colors.white),
                  //             ),
                  //           )*/
                  //         ],
                  //       ),
                  //       Padding(
                  //         padding: EdgeInsets.only(top: 10.0),
                  //         child: Text(
                  //           'KPI',
                  //           style: TextStyle(
                  //               fontWeight: FontWeight.w500, fontSize: 12.0),
                  //         ),
                  //       ),
                  //       Padding(
                  //         padding: EdgeInsets.only(top: 5.0),
                  //         child: Text(
                  //           'Monitoring',
                  //           style: TextStyle(fontSize: 10.0),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  GestureDetector(
                    onTap: () => Navigator.push(context,
                        MyCustomRoute(builder: (context) => MenuAudit(departmentUser: widget.departmentUser, namaUser: widget.namaUser, idUser: widget.idUser))),
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
                                        'assets/images/iso/internal audit.png',
                                      ),
                                      fit: BoxFit.cover
                                  )
                              ),
                            ),
                            Positioned(
                              top: -10.0,
                              right: -8.0,
                              child: Icon(
                                Icons.brightness_1,
                                size: 25.0,
                                color: Colors.redAccent,
                              ),
                            ),
                            Positioned(
                              top: -5.0,
                              right: 2.0,
                              child: Text(
                                '2',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            'Internal',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            'Audit',
                            style: TextStyle(fontSize: 10.0),
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MyCustomRoute(
                            builder: (context) => MenuCorrective(departmentUser: widget.departmentUser, namaUser: widget.namaUser, idUser: widget.idUser))),
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
                                        'assets/images/iso/corrective action.png',
                                      ),
                                      fit: BoxFit.cover
                                  )
                              ),
                            ),
                            Positioned(
                              top: -10.0,
                              right: -8.0,
                              child: Icon(
                                Icons.brightness_1,
                                size: 25.0,
                                color: Colors.redAccent,
                              ),
                            ),
                            Positioned(
                              top: -5.0,
                              right: 2.0,
                              child: Text(
                                '2',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            'Corrective',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            'Action',
                            style: TextStyle(fontSize: 10.0),
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MyCustomRoute(
                              builder: (context) => BerandaRiskRegister(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)));
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
                                        'assets/images/iso/risk assesment.png',
                                      ),
                                      fit: BoxFit.cover
                                  )
                              ),
                            ),
                            /*Positioned(
                              top: -5.0,
                              right: -5.0,
                              child: Icon(
                                Icons.brightness_1,
                                size: 25.0,
                                color: Colors.redAccent,
                              ),
                            ),
                            Positioned(
                              top: 0.0,
                              right: 4.0,
                              child: Text(
                                '2',
                                style: TextStyle(color: Colors.white),
                              ),
                            )*/
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            'Risk',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            'Assesment',
                            style: TextStyle(fontSize: 10.0),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 8.0, left: 8.0, top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MyCustomRoute(
                            builder: (context) => MenuMeeting(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser))),
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
                                        'assets/images/iso/minute of meeting.png',
                                      ),
                                      fit: BoxFit.cover
                                  )
                              ),
                            ),
                            Positioned(
                              top: -10.0,
                              right: -8.0,
                              child: Icon(
                                Icons.brightness_1,
                                size: 25.0,
                                color: Colors.redAccent,
                              ),
                            ),
                            Positioned(
                              top: -5.0,
                              right: 2.0,
                              child: Text(
                                '2',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            'Minute of',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            'Meeting',
                            style: TextStyle(fontSize: 10.0),
                          ),
                        )
                      ],
                    ),
                  ),
                  /*Column(
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
                                      'assets/images/iso/management review.png',
                                    ),
                                    fit: BoxFit.cover
                                )
                            ),
                          ),
                          *//*Positioned(
                            top: -5.0,
                            right: -5.0,
                            child: Icon(
                              Icons.brightness_1,
                              size: 25.0,
                              color: Colors.redAccent,
                            ),
                          ),
                          Positioned(
                            top: 0.0,
                            right: 4.0,
                            child: Text(
                              '2',
                              style: TextStyle(color: Colors.white),
                            ),
                          )*//*
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          'Management',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12.0),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text(
                          'Review',
                          style: TextStyle(fontSize: 10.0),
                        ),
                      )
                    ],
                  ),*/
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MyCustomRoute(
                            builder: (context) => BerandaDocument(departmentUser: widget.departmentUser, namaUser: widget.namaUser, idUser: widget.idUser))),
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
                                    'assets/images/iso/document control.png',
                                  ),
                                  fit: BoxFit.cover
                                )
                              ),
                            ),
                            Positioned(
                              top: -10.0,
                              right: -8.0,
                              child: Icon(
                                Icons.brightness_1,
                                size: 25.0,
                                color: Colors.redAccent,
                              ),
                            ),
                            Positioned(
                              top: -5.0,
                              right: 2.0,
                              child: Text(
                                '2',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            'SOP',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            '',
                            style: TextStyle(fontSize: 10.0),
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(context,
                      MyCustomRoute(
                        builder: (context) => BerandaWorking(departmentUser: widget.departmentUser, namaUser: widget.namaUser, idUser: widget.idUser),
                      ),
                    ),
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
                                    'assets/images/operational/daily checklist.png',
                                  ),
                                  fit: BoxFit.cover
                                )
                              ),
                            ),
                            Positioned(
                              top: -10.0,
                              right: -8.0,
                              child: Icon(
                                Icons.brightness_1,
                                size: 25.0,
                                color: Colors.redAccent,
                              ),
                            ),
                            Positioned(
                              top: -5.0,
                              right: 2.0,
                              child: Text(
                                '2',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            'Working',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            'Instruction',
                            style: TextStyle(fontSize: 10.0),
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MyCustomRoute(builder: (context) => BerandaManagement(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)));
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
                                        'assets/images/iso/change management.png',
                                      ),
                                      fit: BoxFit.cover
                                  )
                              ),
                            ),
                            Positioned(
                              top: -10.0,
                              right: -8.0,
                              child: Icon(
                                Icons.brightness_1,
                                size: 25.0,
                                color: Colors.redAccent,
                              ),
                            ),
                            Positioned(
                              top: -5.0,
                              right: 2.0,
                              child: Text(
                                '2',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            'Change',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            'Management',
                            style: TextStyle(fontSize: 10.0),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            /*Padding(
              padding: EdgeInsets.only(right: 12.0, left: 25.0, bottom: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MyCustomRoute(
                            builder: (context) => BerandaQC())),
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
                            Positioned(
                              top: -5.0,
                              right: -5.0,
                              child: Icon(
                                Icons.brightness_1,
                                size: 25.0,
                                color: Colors.redAccent,
                              ),
                            ),
                            Positioned(
                              top: 0.0,
                              right: 4.0,
                              child: Text(
                                '2',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            'QC',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            'Checklist',
                            style: TextStyle(fontSize: 10.0),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),*/
          ],
        ),
      ],
    );
  }

  Widget _buildOperationMenu() {
    return Scrollbar(
      child: ListView(
        children: <Widget>[
          /*Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20.0, top: 10.0, bottom: 10.0),
                child: Text(
                  'Operational Process',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
              ),
              *//*Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: ButtonTheme(
                  minWidth: 50.0,
                  height: 20.0,
                  child: RaisedButton(
                    color: AbubaPallate.greenabuba,
                    child: Text(
                      'Info',
                      style: TextStyle(fontSize: 13.0, color: Colors.white),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),*//*
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Text(
              'Lakukan aktifitas ini dimulai dari opening hingga closing outlet',
              style: TextStyle(color: Colors.black38),
            ),
          ),*/
          SizedBox(
            height: 15.0,
          ),
          Wrap(
            spacing: 10.0,
            runSpacing: 15.0,
            direction: Axis.horizontal,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    // GestureDetector(
                    //   onTap: () => Navigator.push(
                    //       context,
                    //       MyCustomRoute(
                    //           builder: (context) => MenuLogBook(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser))),
                    //   child: Column(
                    //     mainAxisSize: MainAxisSize.min,
                    //     children: <Widget>[
                    //       Stack(
                    //         overflow: Overflow.visible,
                    //         children: <Widget>[
                    //           Container(
                    //             height: MediaQuery.of(context).size.width * 0.09,
                    //             width: MediaQuery.of(context).size.width * 0.09,
                    //             decoration: BoxDecoration(
                    //                 image: DecorationImage(
                    //                     image: AssetImage(
                    //                       'assets/images/operational/briefing.png',
                    //                     ),
                    //                     fit: BoxFit.cover
                    //                 )
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //       Padding(
                    //         padding: EdgeInsets.only(top: 10.0),
                    //         child: Text(
                    //           'Briefing',
                    //           style: TextStyle(
                    //               fontWeight: FontWeight.w500, fontSize: 12.0),
                    //         ),
                    //       ),
                    //       Padding(
                    //         padding: EdgeInsets.only(top: 5.0),
                    //         child: Text(
                    //           '',
                    //           style: TextStyle(
                    //               fontWeight: FontWeight.w500, fontSize: 12.0),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MyCustomRoute(
                              builder: (context) => MenuChecklist(idUser: widget.idUser, departmentUser: widget.departmentUser, namaUser: widget.namaUser))),
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
                                          'assets/images/operational/daily checklist.png',
                                        ),
                                        fit: BoxFit.cover
                                    )
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text('Line Check',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.0),
                                softWrap: false,
                                overflow: TextOverflow.ellipsis),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Text(
                              'Shifting',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 12.0),
                            ),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // showSearch(context: context, delegate: DataSearch());
                        Navigator.push(context,
                          MyCustomRoute(
                            builder: (context) => new BerandaIncoming2(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)
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
                                          'assets/images/operational/incoming.png',
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
                              'Incoming',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 12.0),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Text(
                              'Material',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 12.0),
                            ),
                          )
                        ],
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.push(
                    //         context,
                    //         MyCustomRoute(
                    //             builder: (context) => FormTemperature()));
                    //   },
                    //   child: Column(
                    //     mainAxisSize: MainAxisSize.min,
                    //     children: <Widget>[
                    //       Stack(
                    //         overflow: Overflow.visible,
                    //         children: <Widget>[
                    //           Container(
                    //             height: 70.0,
                    //             width: 70.0,
                    //             decoration: BoxDecoration(
                    //                 color: Colors.transparent,
                    //                 border: Border.all(
                    //                     color: Colors.grey, width: 1.0),
                    //                 borderRadius: BorderRadius.all(
                    //                     Radius.circular(18.0))),
                    //           ),
                    //           Positioned(
                    //             bottom: 22.5,
                    //             left: 25.0,
                    //             child: Icon(MdiIcons.heart,
                    //                 size: 25.0, color: Colors.grey),
                    //           ),
                    //           Positioned(
                    //             top: -5.0,
                    //             right: -5.0,
                    //             child: Icon(
                    //               Icons.brightness_1,
                    //               size: 25.0,
                    //               color: Colors.redAccent,
                    //             ),
                    //           ),
                    //           Positioned(
                    //             top: -1.0,
                    //             right: 3.0,
                    //             child: Text(
                    //               '2',
                    //               style: TextStyle(color: Colors.white),
                    //             ),
                    //           )
                    //         ],
                    //       ),
                    //       Padding(
                    //         padding: EdgeInsets.only(top: 10.0),
                    //         child: Text(
                    //           'Storage',
                    //           style: TextStyle(
                    //               fontWeight: FontWeight.w500, fontSize: 12.0),
                    //         ),
                    //       ),
                    //       Padding(
                    //         padding: EdgeInsets.only(top: 5.0),
                    //         child: Text(
                    //           '',
                    //           style: TextStyle(
                    //               fontWeight: FontWeight.w500, fontSize: 12.0),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MyCustomRoute(
                              builder: (context) => BerandaLinecheck(idUser: widget.idUser, departmentUser: widget.departmentUser, namaUser: widget.namaUser))),
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
                                          'assets/images/incoming/inspection.png',
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
                              'QC Checklist',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 12.0),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text(
                              '',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 12.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Column(
                    //   mainAxisSize: MainAxisSize.min,
                    //   children: <Widget>[
                    //     Stack(
                    //       overflow: Overflow.visible,
                    //       children: <Widget>[
                    //         Container(
                    //           height: 70.0,
                    //           width: 70.0,
                    //           decoration: BoxDecoration(
                    //               color: Colors.transparent,
                    //               border: Border.all(
                    //                   color: Colors.grey, width: 1.0),
                    //               borderRadius:
                    //                   BorderRadius.all(Radius.circular(18.0))),
                    //         ),
                    //         Positioned(
                    //           bottom: 22.5,
                    //           left: 25.0,
                    //           child: Icon(MdiIcons.heart,
                    //               size: 25.0, color: Colors.grey),
                    //         ),
                    //         Positioned(
                    //           top: -5.0,
                    //           right: -5.0,
                    //           child: Icon(
                    //             Icons.brightness_1,
                    //             size: 25.0,
                    //             color: Colors.redAccent,
                    //           ),
                    //         ),
                    //         Positioned(
                    //           top: -1.0,
                    //           right: 3.0,
                    //           child: Text(
                    //             '2',
                    //             style: TextStyle(color: Colors.white),
                    //           ),
                    //         )
                    //       ],
                    //     ),
                    //     Padding(
                    //       padding: EdgeInsets.only(top: 10.0),
                    //       child: Text(
                    //         'Event',
                    //         style: TextStyle(
                    //             fontWeight: FontWeight.w500, fontSize: 12.0),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // Column(
                    //   mainAxisSize: MainAxisSize.min,
                    //   children: <Widget>[
                    //     Stack(
                    //       overflow: Overflow.visible,
                    //       children: <Widget>[
                    //         Container(
                    //           height: 70.0,
                    //           width: 70.0,
                    //           decoration: BoxDecoration(
                    //               color: Colors.transparent,
                    //               border: Border.all(
                    //                   color: Colors.grey, width: 1.0),
                    //               borderRadius:
                    //                   BorderRadius.all(Radius.circular(18.0))),
                    //         ),
                    //         Positioned(
                    //           bottom: 22.5,
                    //           left: 25.0,
                    //           child: Icon(MdiIcons.heart,
                    //               size: 25.0, color: Colors.grey),
                    //         ),
                    //         Positioned(
                    //           top: -5.0,
                    //           right: -5.0,
                    //           child: Icon(
                    //             Icons.brightness_1,
                    //             size: 25.0,
                    //             color: Colors.redAccent,
                    //           ),
                    //         ),
                    //         Positioned(
                    //           top: -1.0,
                    //           right: 3.0,
                    //           child: Text(
                    //             '2',
                    //             style: TextStyle(color: Colors.white),
                    //           ),
                    //         )
                    //       ],
                    //     ),
                    //     Padding(
                    //       padding: EdgeInsets.only(top: 10.0),
                    //       child: Text(
                    //         'Open Close',
                    //         style: TextStyle(
                    //             fontWeight: FontWeight.w500, fontSize: 12.0),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Column(
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
                                        'assets/images/operational/more.png',
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
                            'MORE',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            ],
          ),
          Divider(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20.0, top: 10.0, bottom:10.0),
                child: Text(
                  'Best Employee',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
              ),
              /*Padding(
                          padding: EdgeInsets.only(right: 20.0),
                          child: ButtonTheme(
                            minWidth: 50.0,
                            height: 20.0,
                            child: OutlineButton(
                              child: Text(
                                'More',
                                style: TextStyle(fontSize: 13.0),
                              ),
                              borderSide: BorderSide(color: Colors.green, width: 1.0),
                              highlightedBorderColor: Colors.green,
                              onPressed: () {},
                            ),
                          ),
                        ),*/
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: 20.0, left: 20.0),
            child: Text(
              'Selamat kepada 10 besar karyawan dengan performance terbaik',
              style: TextStyle(color: Colors.black38),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            margin: EdgeInsets.symmetric(vertical: 5.0),
            height: 140.0,
            child: Column(
              children: <Widget>[
                Flexible(
                    child: AnimatedBuilder(
                      animation: animationController,
                      builder: (_, Widget child) {
                        return animationController.isAnimating
                            ? Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                        : ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: nama.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Stack(
                                                overflow: Overflow.visible,
                                                children: <Widget>[
                                                  Container(
                                                    height: 70.0,
                                                    width: 70.0,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        color: Colors.grey[300],
                                                        width: 3.0,
                                                      ),
                                                      // image: DecorationImage(
                                                      //   image: NetworkImage("https://image.flaticon.com/icons/png/512/149/149071.png"),
                                                      //   fit: BoxFit.cover
                                                      // )
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                          'assets/images/user/'+gambar[index],
                                                        ),
                                                        fit: BoxFit.cover
                                                    )
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
                                              child: Text(
                                                nama[index],
                                                style: TextStyle(fontSize: 13.0),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
                                              child: Text(
                                                department[index],
                                                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700),
                                              ),
                                            )
                                          ],
                                        );
                                      },
                                    );
                        //     : StreamBuilder(
                        //   stream: Firestore.instance.collection('user').where('aksesStatus', isEqualTo: 'owner').limit(10).snapshots(),
                        //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        //     if (!snapshot.hasData)
                        //       return Container(
                        //         child: Center(
                        //           child: CircularProgressIndicator(),
                        //         ),
                        //       );

                        //     return ListView.builder(
                        //       scrollDirection: Axis.horizontal,
                        //       itemCount: snapshot.data.documents.length,
                        //       itemBuilder: (BuildContext context, int index) {
                        //         return Column(
                        //           mainAxisSize: MainAxisSize.min,
                        //           children: <Widget>[
                        //             Padding(
                        //               padding: EdgeInsets.all(10.0),
                        //               child: Stack(
                        //                 overflow: Overflow.visible,
                        //                 children: <Widget>[
                        //                   Container(
                        //                     height: 70.0,
                        //                     width: 70.0,
                        //                     decoration: BoxDecoration(
                        //                         color: Colors.white,
                        //                         shape: BoxShape.circle,
                        //                         border: Border.all(
                        //                           color: Colors.grey[300],
                        //                           width: 3.0,
                        //                         ),
                        //                         image: DecorationImage(
                        //                             image: NetworkImage("https://image.flaticon.com/icons/png/512/149/149071.png"),
                        //                             fit: BoxFit.cover
                        //                         )
                        //                     ),
                        //                   )
                        //                 ],
                        //               ),
                        //             ),
                        //             Padding(
                        //               padding: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
                        //               child: Text(
                        //                 snapshot.data.documents[index].data['nama'],
                        //                 style: TextStyle(fontSize: 13.0),
                        //               ),
                        //             ),
                        //             Padding(
                        //               padding: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
                        //               child: Text(
                        //                 snapshot.data.documents[index].data['department'],
                        //                 style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700),
                        //               ),
                        //             )
                        //           ],
                        //         );
                        //       },
                        //     );
                        //   },
                        // );
                      },
                    )
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Divider(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Creative Idea',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: ButtonTheme(
                  minWidth: 50.0,
                  height: 20.0,
                  buttonColor: Colors.green,
                  child: RaisedButton(
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    shape: CircleBorder(
                        side: BorderSide(width: 1.0, color: Colors.green)),
                    color: Colors.green,
                    onPressed: () => Navigator.push(context,
                        MyCustomRoute(builder: (context) => FormCreate(idUser: widget.idUser, departmentUser: widget.departmentUser, namaUser: widget.namaUser))),
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            height: 370.0,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Flexible(
                    child: AnimatedBuilder(
                      animation: animationController,
                      builder: (_, Widget child) {
                        return animationController.isAnimating
                            ? Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                            : StreamBuilder(
                          stream: Firestore.instance.collection('creative-idea').orderBy('dateCreated', descending: true).snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData)
                              return Container(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );

                            if (snapshot.data.documents.length == 0) {
                              return Container();
                            } else {
                              return CardList2(document: snapshot.data.documents, idUser: widget.idUser);
                            }
                          },
                        );
                      },
                    )
                ),
              ],
            ),
          ),
          Divider(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  'What\'s Happening in Abuba',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: ButtonTheme(
                  minWidth: 50.0,
                  height: 20.0,
                  buttonColor: Colors.green,
                  child: RaisedButton(
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    shape: CircleBorder(
                        side: BorderSide(width: 1.0, color: Colors.green)),
                    color: Colors.green,
                    onPressed: () => Navigator.push(
                        context,
                        MyCustomRoute(
                            builder: (context) => FormCreateHappening(idUser: widget.idUser))),
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            height: 350.0,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Flexible(
                    child: AnimatedBuilder(
                      animation: animationController,
                      builder: (_, Widget child) {
                        return animationController.isAnimating
                            ? Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                            : StreamBuilder(
                          stream: Firestore.instance.collection('whats-happening').orderBy('dateCreated', descending: true).snapshots(),
                          builder: (BuildContext contex, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData)
                              return Container(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );

                            if (snapshot.data.documents.length == 0) {
                              return Container();
                            } else {
                              return CardList(document: snapshot.data.documents, idUser: widget.idUser,);
                            }
                          },
                        );
                      },
                    )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
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
                child: Row(
                  children: [
                    Icon(
                      Icons.favorite,
                      color: Colors.red[500],
                      size: 20.0,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      '41 pts',
                      style: TextStyle(fontSize: 12.0, color: Colors.grey),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    ),
    bottom: new TabBar(
      isScrollable: false,
      indicatorColor: AbubaPallate.greenabuba,
      tabs: <Widget>[
        new Tab(
          child: Text(
            'Operation',
            style: TextStyle(color: Colors.grey[400]),
          ),
        ), // 1st Tab
        new Tab(
          child: Text(
            'ISO',
            style: TextStyle(color: Colors.grey[400]),
          ),
        ), // 1st Tab
      ],
    ),
  );
}

class CardList2 extends StatefulWidget {
  final List<DocumentSnapshot> document;
  final int idUser;
  CardList2({this.document, this.idUser});

  @override
  _CardList2State createState() => _CardList2State();
}

class _CardList2State extends State<CardList2> {
  var tempOutput;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.document.length,
      itemBuilder: (context, index) {
        tempOutput = List<dynamic>.from(widget.document[index].data['likes']);

        return Container(
          width: MediaQuery.of(context).size.width - 100.0,
          height: 400.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 15.0,
                alignment: Alignment.topLeft,
                child: Text(
                  widget.document[index].data['problem'],
                  style: TextStyle(
                      color: Colors.black, fontSize: 13.0),
                ),
              ),
              Container(
                height: 15.0,
                padding: EdgeInsets.only(top: 3.0),
                alignment: Alignment.topLeft,
                child: Text(
                  '${widget.document[index].data['userCreated'].toString()} . ${widget.document[index].data['userDepartment'].toString()}',
                  style: TextStyle(
                      color: Colors.black38, fontSize: 12.0),
                ),
              ),
              Container(
                height: 100.0,
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: RichText(
                  overflow: TextOverflow.visible,
                  text: TextSpan(
                    text: widget.document[index].data['description'],
                    style: TextStyle(color: Colors.black38, fontSize: 11.0),
                  ),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                onTap: () {},
                title: Container(
                  height: 140.0,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      border: Border.all(
                        color: Colors.black12,
                        width: 2.0,
                      ),
                      image: DecorationImage(
                          image: NetworkImage(widget.document[index].data['image']),
                          fit: BoxFit.cover
                      )
                  ),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            tooltip: 'Like',
                            alignment: Alignment.centerRight,
                            icon: widget.document[index].data['likes'].contains(widget.idUser) ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
                            iconSize: 18.0,
                            color: widget.document[index].data['likes'].contains(widget.idUser) ? Colors.redAccent : Colors.grey,
                            onPressed: () {
                              // if (widget.document[index].data['likes'].contains(widget.idUser)) {
                              //   setState(() {
                              //     tempOutput.removeWhere((dynamic userID) => userID == widget.idUser);
                              //   });
                              //   var initialDataNoTimestamp = <String, dynamic>{
                              //     'likes': tempOutput,
                              //   };
                              //   DocumentReference docReference = Firestore.instance.collection('whats-happening').document(widget.document[index].documentID);
                              //   docReference.updateData(initialDataNoTimestamp).then((doc) {
                              //     print('not like');
                              //   }).catchError((error) {
                              //     print('error');
                              //   });
                              // } else {
                              //   setState(() {
                              //     tempOutput.add(widget.idUser);
                              //   });
                              //   var initialDataNoTimestamp = <String, dynamic>{
                              //     'likes': tempOutput,
                              //   };
                              //   DocumentReference docReference = Firestore.instance.collection('whats-happening').document(widget.document[index].documentID);
                              //   docReference.updateData(initialDataNoTimestamp).then((doc) {
                              //     print('liked');
                              //   }).catchError((error) {
                              //     print('error');
                              //   });
                              // }
                            },
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5.0),
                            child: Text(
                              widget.document[index].data['likes'].length.toString(),
                              style: TextStyle(
                                  color: Colors.grey[500]
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: GestureDetector(
                        onTap: () => Navigator.push(context,
                            MyCustomRoute(
                                builder: (context) => FormCommentIdea()
                            )
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.chat,
                              size: 18.0,
                              color: AbubaPallate.greenabuba,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 5.0),
                              margin: EdgeInsets.only(top: 5.0),
                              child: Text(
                                widget.document[index].data['comments'].length.toString(),
                                style: TextStyle(
                                    color: Colors.grey[500]
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 20.0, top: 20.0),
                      alignment: Alignment.topRight,
                      child: ButtonTheme(
                        minWidth: 50.0,
                        height: 20.0,
                        child: OutlineButton(
                          child: Text(
                            'Detail',
                            style: TextStyle(fontSize: 13.0),
                          ),
                          borderSide: BorderSide(
                              color: Colors.green, width: 1.0),
                          highlightedBorderColor: Colors.green,
                          onPressed: () => Navigator.push(context,
                              MyCustomRoute(
                                  builder: (context) => FormDetail(index: widget.document[index].documentID)
                              )
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class CardList extends StatefulWidget {
  final List<DocumentSnapshot> document;
  final int idUser;
  CardList({this.document, this.idUser});

  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  var tempOutput;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.document.length,
      itemBuilder: (context, index) {
        tempOutput = List<dynamic>.from(widget.document[index].data['likes']);

        return Container(
          width: MediaQuery.of(context).size.width - 100.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 15.0,
                alignment: Alignment.topLeft,
                child: Text(
                  widget.document[index].data['title'],
                  style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.black
                  ),
                ),
              ),
              Container(
                height: 100.0,
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: RichText(
                  overflow: TextOverflow.visible,
                  text: TextSpan(
                    text: widget.document[index].data['description'],
                    style: TextStyle(
                        color: Colors.black38,
                        fontSize: 11.0
                    ),
                  ),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                onTap: () {},
                title: Container(
                  height: 140.0,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      border: Border.all(
                        color: Colors.black12,
                        width: 2.0,
                      ),
                      image: DecorationImage(
                          image: NetworkImage(
                            widget.document[index].data['image'],
                          ),
                          fit: BoxFit.cover
                      )
                  ),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            tooltip: 'Like',
                            alignment: Alignment.centerRight,
                            icon: widget.document[index].data['likes'].contains(widget.idUser) ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
                            iconSize: 18.0,
                            color: widget.document[index].data['likes'].contains(widget.idUser) ? Colors.redAccent : Colors.grey,
                            onPressed: () {
                              // if (widget.document[index].data['likes'].contains(widget.idUser)) {
                              //   setState(() {
                              //     tempOutput.removeWhere((dynamic userID) => userID == widget.idUser);
                              //   });
                              //   var initialDataNoTimestamp = <String, dynamic>{
                              //     'likes': tempOutput,
                              //   };
                              //   DocumentReference docReference = Firestore.instance.collection('whats-happening').document(widget.document[index].documentID);
                              //   docReference.updateData(initialDataNoTimestamp).then((doc) {
                              //     print('not like');
                              //   }).catchError((error) {
                              //     print('error');
                              //   });
                              // } else {
                              //   setState(() {
                              //     tempOutput.add(widget.idUser);
                              //   });
                              //   var initialDataNoTimestamp = <String, dynamic>{
                              //     'likes': tempOutput,
                              //   };
                              //   DocumentReference docReference = Firestore.instance.collection('whats-happening').document(widget.document[index].documentID);
                              //   docReference.updateData(initialDataNoTimestamp).then((doc) {
                              //     print('liked');
                              //   }).catchError((error) {
                              //     print('error');
                              //   });
                              // }
                            },
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5.0),
                            child: Text(
                              widget.document[index].data['likes'].length.toString(),
                              style: TextStyle(
                                  color: Colors.grey[500]
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: GestureDetector(
                        onTap: () => Navigator.push(context,
                            MyCustomRoute(
                                builder: (context) => FormComment()
                            )
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.chat,
                              size: 18.0,
                              color: AbubaPallate.greenabuba,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 5.0),
                              margin: EdgeInsets.only(top: 5.0),
                              child: Text(
                                widget.document[index].data['comments'].length.toString(),
                                style: TextStyle(
                                    color: Colors.grey[500]
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
