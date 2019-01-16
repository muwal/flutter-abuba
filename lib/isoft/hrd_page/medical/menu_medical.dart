import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';

import 'form_jadwal.dart';
import 'form_hasil.dart';

class MenuMedical extends StatefulWidget {
  @override
  _MenuMedicalState createState() => _MenuMedicalState();
}

class _MenuMedicalState extends State<MenuMedical> {
  final _scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldState,
        appBar: AbubaAppBar(),
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
                'HRD',
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
                  'Medical',
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
                          MyCustomRoute(builder: (context) => FormJadwal()));
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
                              top: -1.0,
                              right: 3.0,
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
                            'Jadwal',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MyCustomRoute(builder: (context) => FormHasil()));
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
                              top: -1.0,
                              right: 3.0,
                              child: Text(
                                '2',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text('Hasil',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 12.0),
                              softWrap: false,
                              overflow: TextOverflow.ellipsis),
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
