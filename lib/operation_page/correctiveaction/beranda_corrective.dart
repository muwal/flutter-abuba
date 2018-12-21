import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';

import 'form_createnew.dart';
import 'form_reportcar.dart';

class MenuCorrective extends StatefulWidget {
  @override
  _MenuCorrectiveState createState() => _MenuCorrectiveState();
}

class _MenuCorrectiveState extends State<MenuCorrective> {
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

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            height: 350.0,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: new Container(
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0))),
                child: new Center(
                  child: new Text("This is a modal sheet"),
                )),
          );
        });
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
                'Home',
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
                  'Corrective Action',
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
                        MyCustomRoute(builder: (context) => FormCreateNew())),
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
                            'Create New',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            '',
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
                            MyCustomRoute(builder: (context) => ReportCar())),
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
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(18.0))),
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
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text('View Report',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12.0),
                            softWrap: false,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text(
                          '',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {},
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
                            'Verification',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            '',
                            style: TextStyle(
                                fontSize: 12.0, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
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
                            'Car Internal',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            'Audit',
                            style: TextStyle(
                                fontSize: 12.0, fontWeight: FontWeight.w500),
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
