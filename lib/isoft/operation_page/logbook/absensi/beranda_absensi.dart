import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';
import 'package:flutter_abuba/isoft/operation_page/logbook/absensi/form_analysis.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'form_absensi.dart';
import 'form_report.dart';

class BerandaAbsensi extends StatefulWidget {
  @override
  _BerandaAbsensiState createState() => _BerandaAbsensiState();
}

class _BerandaAbsensiState extends State<BerandaAbsensi> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AbubaAppBar(),
        body: _buildMenu(),
      ),
    );
  }

  Widget _buildMenu() {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Log Book MOD',
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
                  'Absensi',
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
                        MyCustomRoute(builder: (context) => FormAbsensi())),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Stack(
                          overflow: Overflow.visible,
                          children: <Widget>[
                            Container(
                              height: 70.0,
                              width: 70.0,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                      color: Colors.grey, width: 1.0),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(18.0))),
                            ),
                            Positioned(
                              bottom: 22.5,
                              left: 25.0,
                              child: Icon(MdiIcons.heart,
                                  size: 25.0, color: Colors.grey),
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
                          Navigator.push(
                              context,
                              MyCustomRoute(
                                  builder: (context) => FormReport()));
                        },
                        child: Stack(
                          overflow: Overflow.visible,
                          children: <Widget>[
                            Container(
                              height: 70.0,
                              width: 70.0,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                      color: Colors.grey, width: 1.0),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(18.0))),
                            ),
                            Positioned(
                              bottom: 22.5,
                              left: 25.0,
                              child: Icon(MdiIcons.heart,
                                  size: 25.0, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text('Report',
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
                          builder: (context) => new FormAnalysis()
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
                              height: 70.0,
                              width: 70.0,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                      color: Colors.grey, width: 1.0),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(18.0))),
                            ),
                            Positioned(
                              bottom: 22.5,
                              left: 25.0,
                              child: Icon(MdiIcons.heart,
                                  size: 25.0, color: Colors.grey),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            'Analysis',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12.0),
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
    );
  }
}
