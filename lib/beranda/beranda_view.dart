import 'package:flutter/material.dart';
import 'package:flutter_abuba/creative_page/form_comment.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_abuba/beranda/beranda_appbar.dart';
import 'package:flutter_abuba/constant.dart';

import 'package:flutter_abuba/isoft/more_page/beranda_more.dart';
import 'package:flutter_abuba/whats_page/form_comment.dart';
import 'package:flutter_abuba/whats_page/form_create_happening.dart';
import 'package:flutter_abuba/creative_page/form_detail.dart';
import 'package:flutter_abuba/creative_page/form_create.dart';
import 'package:flutter_abuba/sixsigma/beranda_sigma.dart';

import 'package:flutter_abuba/isoft/beranda_isoft.dart';
import 'package:flutter_abuba/misteri_shop/form_carilokasi.dart';
import 'package:flutter_abuba/misteri_shop/grid_data_search.dart';

class BerandaPage extends StatefulWidget {
  @override
  _BerandaPageState createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
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
      child: Scaffold(
        appBar: AbubaAppBar(),
        body: _buildAbubaMenu(),
      ),
    );
  }

  Widget _buildAbubaMenu() {
    return Scrollbar(
      child: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Card(
                  elevation: 2.0,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 42.0,
                          child: Container(
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Your Performance',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14.0),
                                      textAlign: TextAlign.start,
                                    ),
                                    Text(
                                      '90%',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14.0),
                                      textAlign: TextAlign.start,
                                    )
                                  ],
                                ),
                              ),
                              decoration:
                                  BoxDecoration(color: Color(0xFF2F592F))),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 103.0,
                          child: Container(
                            child: Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(right: 15.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Text(
                                          'Goal Departement',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 11.0),
                                        ),
                                        LinearPercentIndicator(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.7,
                                          animation: true,
                                          lineHeight: 30.0,
                                          percent: 0.9,
                                          center: Text(
                                            '90%',
                                            style: TextStyle(
                                                color: Colors.black45),
                                          ),
                                          linearStrokeCap:
                                              LinearStrokeCap.roundAll,
                                          progressColor: Colors.green[300],
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 15.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Text(
                                          'Goal Individu',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 11.0),
                                        ),
                                        LinearPercentIndicator(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.7,
                                          animation: true,
                                          lineHeight: 30.0,
                                          percent: 0.9,
                                          center: Text(
                                            '90%',
                                            style: TextStyle(
                                                color: Colors.black45),
                                          ),
                                          linearStrokeCap:
                                              LinearStrokeCap.roundAll,
                                          progressColor: Colors.green[300],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(color: Color(0xFF376D37)),
                          ),
                        )
                      ],
                    ),
                  ),
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
                                  builder: (context) => BerandaIsoft())),
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
                                  'Isoft',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.0),
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
                          onTap: () {
                            Navigator.push(
                                context,
                                MyCustomRoute(
                                    builder: (context) => BerandaSigma()));
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
                                  'Six Sigma',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.0),
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
                          onTap: () {
                            Navigator.push(
                                context,
                                MyCustomRoute(
                                    builder: (context) => FormCariLokasi()));
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
                                  'Mystery',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.0),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5.0),
                                child: Text(
                                  'Shopper',
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
                                'Inventory',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.0),
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
                                  'Online',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.0),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5.0),
                                child: Text(
                                  'Training',
                                  style: TextStyle(fontSize: 10.0),
                                ),
                              )
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
                                  'Appraisal',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.0),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5.0),
                                child: Text(
                                  'Performance',
                                  style: TextStyle(fontSize: 10.0),
                                ),
                              )
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
                                            color: Colors.transparent,
                                            width: 1.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(18.0))),
                                  ),
                                  Positioned(
                                    bottom: 22.5,
                                    left: 25.0,
                                    child: Icon(MdiIcons.heart,
                                        size: 25.0, color: Colors.transparent),
                                  ),
                                  Positioned(
                                    top: -5.0,
                                    right: -5.0,
                                    child: Icon(
                                      Icons.brightness_1,
                                      size: 25.0,
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  Positioned(
                                    top: -1.0,
                                    right: 3.0,
                                    child: Text(
                                      '2',
                                      style:
                                          TextStyle(color: Colors.transparent),
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text(
                                  '',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.0),
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
                          onTap: () => Navigator.push(
                              context,
                              MyCustomRoute(
                                  builder: (context) => BerandaMore())),
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
                                            color: Colors.transparent,
                                            width: 1.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(18.0))),
                                  ),
                                  Positioned(
                                    bottom: 22.5,
                                    left: 25.0,
                                    child: Icon(MdiIcons.heart,
                                        size: 25.0, color: Colors.transparent),
                                  ),
                                  Positioned(
                                    top: -5.0,
                                    right: -5.0,
                                    child: Icon(
                                      Icons.brightness_1,
                                      size: 25.0,
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  Positioned(
                                    top: -1.0,
                                    right: 3.0,
                                    child: Text(
                                      '2',
                                      style:
                                          TextStyle(color: Colors.transparent),
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: Text(
                                  '',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.0),
                                ),
                              ),
                            ],
                          ),
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
                height: 5.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Best Employee',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                  ),
                  Padding(
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
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Text(
                  'Selamat kepada 10 besar karyawan dengan performance terbaik',
                  style: TextStyle(color: Colors.black38),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                margin: EdgeInsets.symmetric(vertical: 20.0),
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
                                              fit: BoxFit.cover)),
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
                                      borderSide: BorderSide(
                                          color: Colors.green, width: 1.0),
                                      highlightedBorderColor: Colors.green,
                                      onPressed: () => Navigator.push(
                                          context,
                                          MyCustomRoute(
                                              builder: (context) =>
                                                  FormDetail())),
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
                                                alignment:
                                                    Alignment.centerRight,
                                                icon: Icon(Icons.visibility),
                                                iconSize: 18.0,
                                                color:
                                                    _alreadyOKHappening[index]
                                                        ? AbubaPallate.green
                                                        : Colors.grey,
                                                onPressed: null),
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
                                              icon: _counterLikeIdea[index] == 0
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
                                                    _counterLikeIdea[index]++;
                                                  } else {
                                                    _counterLikeIdea[index]--;
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
                                                      _counterLikeHappening[
                                                              index]
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
          )
        ],
      ),
    );
  }
}
