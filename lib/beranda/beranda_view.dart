import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_abuba/beranda/beranda_appbar.dart';
import 'package:flutter_abuba/constant.dart';

import 'package:flutter_abuba/operation_page/beranda_operation.dart';

class BerandaPage extends StatefulWidget {
  @override
  _BerandaPageState createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
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
    return ListView(
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
                              padding: EdgeInsets.only(left: 10.0, right: 10.0),
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
                                        width:
                                            MediaQuery.of(context).size.width / 2.7,
                                        animation: true,
                                        lineHeight: 30.0,
                                        percent: 0.9,
                                        center: Text(
                                          '90%',
                                          style:
                                              TextStyle(color: Colors.black45),
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
                                        width:
                                            MediaQuery.of(context).size.width / 2.7,
                                        animation: true,
                                        lineHeight: 30.0,
                                        percent: 0.9,
                                        center: Text(
                                          '90%',
                                          style:
                                              TextStyle(color: Colors.black45),
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
                                'OPERATION',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.0),
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
                              'KITCHEN',
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
                              'IT',
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
                              'AUDIT',
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
                              'HRD',
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
                              'FINANCE',
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
                              'R&D',
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
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Best Employee',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
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
              padding: EdgeInsets.only(left: 5.0, right: 5.0),
              margin: EdgeInsets.symmetric(vertical: 20.0),
              height: 138.0,
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
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
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
                'Berikan ide terbaik Anda untuk meningkatkan performance kerja atau membuat suasana kerja jadi lebih menyenangkan',
                style: TextStyle(color: Colors.black38),
              ),
            ),
            Wrap(
              spacing: 10.0,
              runSpacing: 15.0,
              direction: Axis.horizontal,
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.0, vertical: 30.0),
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
                                    border: Border.all(
                                        color: Colors.grey, width: 1.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(18.0)),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "https://www.biography.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cg_face%2Cq_auto:good%2Cw_300/MTE5NTU2MzE2NDE4MzExNjkx/jackie-chan-9542080-1-402.jpg"),
                                        fit: BoxFit.cover)),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text(
                              'AJUKAN',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 12.0),
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
                                    border: Border.all(
                                        color: Colors.grey, width: 1.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(18.0)),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "https://www.biography.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cg_face%2Cq_auto:good%2Cw_300/MTE5NTU2MzE2NDE4MzExNjkx/jackie-chan-9542080-1-402.jpg"),
                                        fit: BoxFit.cover)),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text(
                              'STATUS',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 12.0),
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
                                    border: Border.all(
                                        color: Colors.grey, width: 1.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(18.0)),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "https://www.biography.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cg_face%2Cq_auto:good%2Cw_300/MTE5NTU2MzE2NDE4MzExNjkx/jackie-chan-9542080-1-402.jpg"),
                                        fit: BoxFit.cover)),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text(
                              'PEMENANG',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 12.0),
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
                                    border: Border.all(
                                        color: Colors.grey, width: 1.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(18.0)),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "https://www.biography.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cg_face%2Cq_auto:good%2Cw_300/MTE5NTU2MzE2NDE4MzExNjkx/jackie-chan-9542080-1-402.jpg"),
                                        fit: BoxFit.cover)),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Text(
                              'GALERY',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 12.0),
                            ),
                          )
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
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'What\'s Happening in Abuba',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
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
                'Pastikan Anda tidak melewatkan berbagai informasi penting dan seru seputar aktivitas Anda di Abuba',
                style: TextStyle(color: Colors.black38),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Container(
                          height: 150.0,
                          width: MediaQuery.of(context).size.width - 33,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              border:
                                  Border.all(color: Colors.black12, width: 4.0),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://c1.staticflickr.com/5/4149/35646344915_805ee67321_b.jpg"),
                                  fit: BoxFit.cover)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Camping Night',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 5.0, bottom: 10.0),
                  child: Text(
                    'Camping night in the night night night night',
                    style: TextStyle(color: Colors.black38),
                  ),
                ),
                Container()
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: ButtonTheme(
                    minWidth: 50.0,
                    height: 20.0,
                    child: RaisedButton(
                      color: AbubaPallate.greenabuba,
                      child: Text(
                        'More',
                        style: TextStyle(fontSize: 13.0, color: Colors.white),
                      ),
                      /*borderSide: BorderSide(
                          color: Colors.green,
                          width: 1.0
                      ),
                      highlightedBorderColor: Colors.green,*/
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              height: 6.0,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Container(
                          height: 150.0,
                          width: MediaQuery.of(context).size.width - 33,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              border:
                                  Border.all(color: Colors.black12, width: 4.0),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://c1.staticflickr.com/5/4149/35646344915_805ee67321_b.jpg"),
                                  fit: BoxFit.cover)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Camping Night',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 5.0, bottom: 10.0),
                  child: Text(
                    'Camping night in the night night night night',
                    style: TextStyle(color: Colors.black38),
                  ),
                ),
                Container()
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: ButtonTheme(
                    minWidth: 50.0,
                    height: 20.0,
                    child: RaisedButton(
                      color: AbubaPallate.greenabuba,
                      child: Text(
                        'More',
                        style: TextStyle(fontSize: 13.0, color: Colors.white),
                      ),
                      /*borderSide: BorderSide(
                          color: Colors.green,
                          width: 1.0
                      ),
                      highlightedBorderColor: Colors.green,*/
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
