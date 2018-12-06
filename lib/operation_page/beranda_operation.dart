import 'package:flutter/material.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:flutter_abuba/operation_page/logbook/beranda_logbook.dart';
import 'package:flutter_abuba/operation_page/dailychecklist/beranda_checklist.dart';

class BerandaOperation extends StatefulWidget {
  @override
  _BerandaOperationState createState() => _BerandaOperationState();
}

class _BerandaOperationState extends State<BerandaOperation> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AbubaAppBar(),
        body: _buildOperationMenu(),
      ),
    );
  }

  Widget _buildOperationMenu() {
    return ListView(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                'Operational Process',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
            ),
            Padding(
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
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Text(
            'Lakukan aktifitas ini dimulai dari opening hingga closing outlet',
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
                  GestureDetector(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MenuLogBook())),
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
                            'LogBook',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MenuChecklist())),
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
                          child: Text('Checklist',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 12.0),
                              softWrap: false,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ),
                  Column(
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
                                border:
                                    Border.all(color: Colors.grey, width: 1.0),
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
                          'Incoming',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                  Column(
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
                                border:
                                    Border.all(color: Colors.grey, width: 1.0),
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
                          'Storing',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
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
                                border:
                                    Border.all(color: Colors.grey, width: 1.0),
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
                          'Kitchen',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                  Column(
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
                                border:
                                    Border.all(color: Colors.grey, width: 1.0),
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
                          'Event',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                  Column(
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
                                border:
                                    Border.all(color: Colors.grey, width: 1.0),
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
                          'Open Close',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                  Column(
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
                                border:
                                    Border.all(color: Colors.grey, width: 1.0),
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
        SizedBox(
          height: 15.0,
        ),
        Divider(
          height: 15.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                'ISO Requirements',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
            ),
            Padding(
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
            ),
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
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BerandaOperation())),
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
                            'KPI',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12.0),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Text(
                            'Monitoring',
                            style: TextStyle(fontSize: 10.0),
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
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
                                border:
                                    Border.all(color: Colors.grey, width: 1.0),
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
                  Column(
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
                                border:
                                    Border.all(color: Colors.grey, width: 1.0),
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
                  Column(
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
                                border:
                                    Border.all(color: Colors.grey, width: 1.0),
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
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 8.0, left: 8.0, bottom: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
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
                                border:
                                    Border.all(color: Colors.grey, width: 1.0),
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
                  Column(
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
                                border:
                                    Border.all(color: Colors.grey, width: 1.0),
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
                  ),
                  Column(
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
                                border:
                                    Border.all(color: Colors.grey, width: 1.0),
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
                          'Document',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12.0),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text(
                          'Control',
                          style: TextStyle(fontSize: 10.0),
                        ),
                      )
                    ],
                  ),
                  Column(
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
                                border:
                                    Border.all(color: Colors.grey, width: 1.0),
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
                          'MORE',
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
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
