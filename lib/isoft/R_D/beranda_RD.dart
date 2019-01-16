import 'package:flutter/material.dart';
import 'package:flutter_abuba/isoft/R_D/beranda_RD_dua.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/creative_page/form_comment.dart';
import 'package:flutter_abuba/creative_page/form_create.dart';
import 'package:flutter_abuba/creative_page/form_detail.dart';
import 'package:flutter_abuba/isoft/operation_page/changemanagement/beranda_management.dart';
import 'package:flutter_abuba/isoft/operation_page/correctiveaction/beranda_corrective.dart';
import 'package:flutter_abuba/isoft/operation_page/internalaudit/beranda_audit.dart';
import 'package:flutter_abuba/isoft/operation_page/kpimonitoring/kpi_monitoring_beranda.dart';
import 'package:flutter_abuba/isoft/operation_page/meeting/beranda_meeting.dart';
import 'package:flutter_abuba/whats_page/form_comment.dart';
import 'package:flutter_abuba/whats_page/form_create_happening.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MenuRD extends StatefulWidget {
  @override
  _MenuRDState createState() => _MenuRDState();
}

class _MenuRDState extends State<MenuRD> {
  List<bool> _alreadyOKHappening = [false, false, true];
  List<int> _counterOKHappening = [200, 150, 500];
  List<bool> _likeHappening = [false, true, false];
  List<int> _counterLikeHappening = [0, 20, 100];

  List<bool> _likeIdea = [false, true, false];
  List<int> _counterLikeIdea = [0, 20, 100];
  List<int> _counterViewIdea = [100, 50, 33];

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
                    onTap: () {
                      Navigator.push(context,
                        MaterialPageRoute(
                          builder: (context) => new BerandaKpiMonitoring()
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
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MyCustomRoute(
                            builder: (context) => MenuCorrective())),
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
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MyCustomRoute(
                            builder: (context) => MenuMeeting())),
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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MyCustomRoute(builder: (context) => BerandaManagement()));
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
                  'R&D',
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
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
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
                padding: EdgeInsets.only(right: 20.0, left: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                          MyCustomRoute(
                            builder: (context) => new MenuRDdua()
                          )
                        );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            height: 70.0,
                            width: 70.0,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(18.0)
                              )
                            ),
                            child: Icon(
                              MdiIcons.heart,
                              size: 25.0,
                              color: Colors.grey
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text(
                              'Eksperimen',
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
                            MyCustomRoute(builder: (context) => FormCreate())),
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
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _counterLikeIdea.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: MediaQuery.of(context).size.width - 100.0,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Meningkatkan sales sebanyak 25% lewat upselling',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 13.0),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 3.0),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Ridwan . HRD . 2h',
                                    style: TextStyle(
                                        color: Colors.black38, fontSize: 12.0),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding:
                                      EdgeInsets.only(top: 10.0, bottom: 10.0),
                                  child: Text(
                                    'Dengan menjalankan ide ini, sales di outlet A berhasil meningkat sebesar 50% selama 1 minggu sejak implementasi',
                                    style: TextStyle(
                                        color: Colors.black38, fontSize: 13.0),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(right: 20.0),
                                  alignment: Alignment.topRight,
                                  child: ButtonTheme(
                                    minWidth: 50.0,
                                    height: 20.0,
                                    child: OutlineButton(
                                      child: Text(
                                        'Detail',
                                        style: TextStyle(fontSize: 13.0),
                                      ),
                                      borderSide: BorderSide(color: Colors.green, width: 1.0),
                                      highlightedBorderColor: Colors.green,
                                      onPressed: () => Navigator.push(context,
                                          MyCustomRoute(builder: (context) => FormDetail())),
                                    ),
                                    ),
                                ),
                                ListTile(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  onTap: null,
                                  title: Container(
                                    height: 140.0,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        border: Border.all(
                                            color: Colors.black12, width: 2.0),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                "https://c1.staticflickr.com/5/4149/35646344915_805ee67321_b.jpg"),
                                            fit: BoxFit.cover)),
                                  ),
                                  subtitle: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            IconButton(
                                              tooltip: 'VIEWS',
                                              alignment: Alignment.centerRight,
                                              icon: Icon(Icons.visibility),
                                              iconSize: 18.0,
                                              color: _alreadyOKHappening[index]
                                                  ? AbubaPallate.green
                                                  : Colors.grey,
                                              onPressed: null
                                            ),
                                            _counterViewIdea[index] == 0
                                                ? Container()
                                                : Container(
                                                    margin: EdgeInsets.only(
                                                        top: 5.0),
                                                    child: Text(
                                                      _counterViewIdea[index]
                                                          .toString(),
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[500]),
                                                    ),
                                                  )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: GestureDetector(
                                          onTap: () => Navigator.push(
                                              context,
                                              MyCustomRoute(
                                                  builder: (context) =>
                                                      FormCommentIdea())),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(Icons.chat,
                                                  size: 18.0,
                                                  color: AbubaPallate.green),
                                              Container(
                                                padding:
                                                    EdgeInsets.only(left: 5.0),
                                                margin:
                                                    EdgeInsets.only(top: 5.0),
                                                child: Text(
                                                  '${index + 1}',
                                                  style: TextStyle(
                                                      color: Colors.grey[500]),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            IconButton(
                                              tooltip: 'Like',
                                              alignment: Alignment.centerRight,
                                              icon: _counterLikeIdea[
                                                          index] ==
                                                      0
                                                  ? Icon(_likeIdea[index]
                                                      ? Icons.favorite
                                                      : Icons.favorite_border)
                                                  : Icon(_likeIdea[index]
                                                      ? Icons.favorite
                                                      : Icons.favorite_border),
                                              iconSize: 18.0,
                                              color: _likeIdea[index]
                                                  ? Colors.redAccent
                                                  : Colors.grey,
                                              onPressed: () {
                                                setState(() {
                                                  if (_likeIdea[index] ==
                                                      false) {
                                                    _counterLikeIdea[
                                                        index]++;
                                                  } else {
                                                    _counterLikeIdea[
                                                        index]--;
                                                  }
                                                  _likeIdea[index] =
                                                      !_likeIdea[index];
                                                });
                                              },
                                            ),
                                            _counterLikeIdea[index] == 0
                                                ? Container(
                                                    padding: EdgeInsets.only(
                                                        right: 20.0),
                                                  )
                                                : Container(
                                                    padding: EdgeInsets.only(
                                                        right: 20.0),
                                                    margin: EdgeInsets.only(
                                                        top: 5.0),
                                                    child: Text(
                                                      _counterLikeIdea[index]
                                                          .toString(),
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[500]),
                                                    ),
                                                  )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
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
                                builder: (context) => FormCreateHappening())),
                      ),
                    ),
                  ),
                ],
              ),
              // taro sini
              Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                height: 300.0,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Flexible(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _counterLikeHappening.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            width: MediaQuery.of(context).size.width - 100.0,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Ulang tahun ABUBA ke - 100',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 13.0),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding:
                                      EdgeInsets.only(top: 10.0, bottom: 10.0),
                                  child: Text(
                                    'Jangan lupa besok tanggal 17 Agustus 2118 kita merayakan ulang tahun ABUBA yang ke 100. Datang dengan kostum yang seru ya !',
                                    style: TextStyle(
                                        color: Colors.black38, fontSize: 13.0),
                                  ),
                                ),
                                ListTile(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  onTap: null,
                                  title: Container(
                                    height: 140.0,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        border: Border.all(
                                            color: Colors.black12, width: 2.0),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                "https://c1.staticflickr.com/5/4149/35646344915_805ee67321_b.jpg"),
                                            fit: BoxFit.cover)),
                                  ),
                                  subtitle: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            IconButton(
                                              tooltip: 'OK',
                                              alignment: Alignment.centerRight,
                                              icon: _counterOKHappening[
                                                          index] ==
                                                      0
                                                  ? Icon(_alreadyOKHappening[
                                                          index]
                                                      ? Icons.check_circle
                                                      : Icons
                                                          .check_circle_outline)
                                                  : Icon(_alreadyOKHappening[
                                                          index]
                                                      ? Icons.check_circle
                                                      : Icons
                                                          .check_circle_outline),
                                              iconSize: 18.0,
                                              color: _alreadyOKHappening[index]
                                                  ? AbubaPallate.green
                                                  : Colors.grey,
                                              onPressed: () {
                                                setState(() {
                                                  if (_alreadyOKHappening[
                                                          index] ==
                                                      false) {
                                                    _counterOKHappening[
                                                        index]++;
                                                  } else {
                                                    _counterOKHappening[
                                                        index]--;
                                                  }
                                                  _alreadyOKHappening[index] =
                                                      !_alreadyOKHappening[
                                                          index];
                                                });
                                              },
                                            ),
                                            _counterOKHappening[index] == 0
                                                ? Container()
                                                : Container(
                                                    margin: EdgeInsets.only(
                                                        top: 5.0),
                                                    child: Text(
                                                      _counterOKHappening[index]
                                                          .toString(),
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[500]),
                                                    ),
                                                  )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: GestureDetector(
                                          onTap: () => Navigator.push(
                                              context,
                                              MyCustomRoute(
                                                  builder: (context) =>
                                                      FormComment())),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(Icons.chat,
                                                  size: 18.0,
                                                  color: AbubaPallate.green),
                                              Container(
                                                padding:
                                                    EdgeInsets.only(left: 5.0),
                                                margin:
                                                    EdgeInsets.only(top: 5.0),
                                                child: Text(
                                                  '${index + 1}',
                                                  style: TextStyle(
                                                      color: Colors.grey[500]),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            IconButton(
                                              tooltip: 'Like',
                                              alignment: Alignment.centerRight,
                                              icon: _counterLikeHappening[
                                                          index] ==
                                                      0
                                                  ? Icon(_likeHappening[index]
                                                      ? Icons.favorite
                                                      : Icons.favorite_border)
                                                  : Icon(_likeHappening[index]
                                                      ? Icons.favorite
                                                      : Icons.favorite_border),
                                              iconSize: 18.0,
                                              color: _likeHappening[index]
                                                  ? Colors.redAccent
                                                  : Colors.grey,
                                              onPressed: () {
                                                setState(() {
                                                  if (_likeHappening[index] ==
                                                      false) {
                                                    _counterLikeHappening[
                                                        index]++;
                                                  } else {
                                                    _counterLikeHappening[
                                                        index]--;
                                                  }
                                                  _likeHappening[index] =
                                                      !_likeHappening[index];
                                                });
                                              },
                                            ),
                                            _counterLikeHappening[index] == 0
                                                ? Container(
                                                    padding: EdgeInsets.only(
                                                        right: 20.0),
                                                  )
                                                : Container(
                                                    padding: EdgeInsets.only(
                                                        right: 20.0),
                                                    margin: EdgeInsets.only(
                                                        top: 5.0),
                                                    child: Text(
                                                      _counterLikeHappening[index]
                                                          .toString(),
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[500]),
                                                    ),
                                                  )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
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
              'R&D',
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
}
