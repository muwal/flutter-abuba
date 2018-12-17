import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:flutter_abuba/operation_page/logbook/beranda_logbook.dart';
import 'package:flutter_abuba/operation_page/dailychecklist/beranda_checklist.dart';
import 'incoming/search.dart';
import 'kitchen/form_inspection.dart';
import 'internalaudit/beranda_audit.dart';
import 'form_temperature.dart';

class BerandaOperation extends StatefulWidget {
  @override
  _BerandaOperationState createState() => _BerandaOperationState();
}

class _BerandaOperationState extends State<BerandaOperation> {
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
                  GestureDetector(
                    onTap: () => Navigator.push(context,
                        MyCustomRoute(builder: (context) => MenuAudit())),
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

  Widget _buildOperationMenu() {
    return Scrollbar(
      child: ListView(
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
                      onTap: () => Navigator.push(
                          context,
                          MyCustomRoute(
                              builder: (context) => MenuLogBook())),
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
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text(
                              'Log Book',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 12.0),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Text(
                              'MOD',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 12.0),
                            ),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MyCustomRoute(
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
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text('BOH Daily',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.0),
                                softWrap: false,
                                overflow: TextOverflow.ellipsis),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Text(
                              'Checklist',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 12.0),
                            ),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showSearch(context: context, delegate: DataSearch());
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
                              '',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 12.0),
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
                                builder: (context) => FormTemperature()));
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
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text(
                              'Storage',
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
                          )
                        ],
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
                      onTap: () => Navigator.push(
                          context,
                          MyCustomRoute(
                              builder: (context) => Inspection())),
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
              Divider(
                height: 5.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Best Employee',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                        ButtonTheme(
                          minWidth: 50.0,
                          height: 20.0,
                          child: RaisedButton(
                            color: AbubaPallate.greenabuba,
                            child: Text(
                              'More',
                              style: TextStyle(
                                  fontSize: 13.0, color: Colors.white),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Selamat kepada 10 besar karyawan dengan performance terbaik',
                      style: TextStyle(color: Colors.black38),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                height: 140.0,
                child: Column(
                  children: <Widget>[
                    Flexible(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
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
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black26,
                                              offset: Offset(3.0, 3.0),
                                              blurRadius: 5.0,
                                              spreadRadius: 2.0),
                                        ],
                                        border: Border.all(
                                            color: Colors.white, width: 6.0),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(18.0),
                                          bottomRight: Radius.circular(18.0),
                                        ),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                "https://www.biography.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cg_face%2Cq_auto:good%2Cw_300/MTE5NTU2MzE2NDE4MzExNjkx/jackie-chan-9542080-1-402.jpg"),
                                            fit: BoxFit.cover),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text(
                                  'Dewi $index',
                                  style: TextStyle(fontSize: 12.0),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text('Operation'),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 5.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'What\'s Happening in Abuba',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                        ButtonTheme(
                          minWidth: 50.0,
                          height: 20.0,
                          child: RaisedButton(
                            color: AbubaPallate.greenabuba,
                            child: Text(
                              'More',
                              style: TextStyle(
                                  fontSize: 13.0, color: Colors.white),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Pastikan Anda tidak melewatkan berbagai informasi penting dan seru seputar aktivitas Anda di Abuba',
                      style: TextStyle(color: Colors.black38),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          Container(
                            height: 150.0,
                            width: MediaQuery.of(context).size.width - 10,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                border: Border.all(
                                    color: Colors.black12, width: 4.0),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://c1.staticflickr.com/5/4149/35646344915_805ee67321_b.jpg"),
                                    fit: BoxFit.cover)),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Camping Night',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.0),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Camping night in the night night night night',
                            style: TextStyle(color: Colors.black38),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        ButtonTheme(
                          minWidth: 50.0,
                          height: 20.0,
                          child: RaisedButton(
                            color: AbubaPallate.greenabuba,
                            child: Text(
                              'More',
                              style: TextStyle(
                                  fontSize: 13.0, color: Colors.white),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
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
          'assets/images/logo.png',
          height: 100.0,
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
