import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'form_project_charter.dart';
import 'form_report.dart';

class BerandaProject extends StatefulWidget {
  @override
  _BerandaProjectState createState() => _BerandaProjectState();
}

class _BerandaProjectState extends State<BerandaProject> {
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
                'Six Sigma',
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
                  'Project Charter',
                  style:
                  TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MyCustomRoute(
                          builder: (context) => FormProjectCharter()));
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
                        'Create New',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MyCustomRoute(
                          builder: (context) => FormReport()));
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
        ),
      ],
    );
  }
}
