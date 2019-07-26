import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'evaluation/beranda_evaluation.dart';
import 'report/report.dart';
import 'grafik.dart';

class BerandaPurchasing extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;

  BerandaPurchasing({this.idUser, this.namaUser, this.departmentUser});

  @override
  _BerandaPurchasingState createState() => _BerandaPurchasingState();
}

class _BerandaPurchasingState extends State<BerandaPurchasing> {
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
        body: _buildIsoMenu(),
      ),
    );
  }

  Widget _buildIsoMenu() {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Finance',
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
                  'Purchasing',
                  style:
                      TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MyCustomRoute(builder: (context) => BerandaEvaluation(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)));
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
                                    'assets/images/incoming/inspection.png',
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
                        'Evaluation',
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
                      MyCustomRoute(builder: (context) => Report(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)));
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
                        'Report',
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
                      MyCustomRoute(builder: (context) => Grafik()));
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
                                    'assets/images/iso/kpi.png',
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
                        'Grafik',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
              /*GestureDetector(
                onTap: () {},
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 70.0,
                      width: 70.0,
                      child:
                          Icon(MdiIcons.heart, size: 25.0, color: Colors.grey),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.grey, width: 1.0),
                          borderRadius:
                              BorderRadius.all(Radius.circular(18.0))),
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
              ),*/
            ],
          ),
        ),
      ],
    );
  }
}
