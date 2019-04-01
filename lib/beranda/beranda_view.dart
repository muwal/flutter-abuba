import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_abuba/beranda/accountPage.dart';
import 'package:flutter_abuba/creative_page/form_comment.dart';
import 'package:flutter_abuba/misteri_shop/beranda_mg.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_abuba/constant.dart';

import 'package:flutter_abuba/isoft/more_page/beranda_more.dart';
import 'package:flutter_abuba/whats_page/form_comment.dart';
import 'package:flutter_abuba/whats_page/form_create_happening.dart';
import 'package:flutter_abuba/creative_page/form_detail.dart';
import 'package:flutter_abuba/creative_page/form_create.dart';
import 'package:flutter_abuba/sixsigma/beranda_sigma.dart';

import 'package:flutter_abuba/isoft/beranda_isoft.dart';

class BerandaPage extends StatefulWidget {
  final int idUser;
  final String aksesStatus;
  final String namaUser;
  final String departmentUser;
  BerandaPage({this.idUser, this.aksesStatus, this.namaUser, this.departmentUser});

  @override
  _BerandaPageState createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> with TickerProviderStateMixin {
  AnimationController animationController;

  Future<bool> onWillPop() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to exit Abuba Steak App ?'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          FlatButton(
            onPressed: () => SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
            child: Text('Yes'),
          )
        ],
      )
    ) ?? false;
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(
      from: animationController.value == 0.0
        ? 1.0
        : animationController.value
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.25,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            title: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Image.asset(
                    'assets/images/logo2.png',
                    height: 150.0,
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
            ),
            automaticallyImplyLeading: false,
          ),
          body: Scrollbar(
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
                                        builder: (context) => BerandaIsoft(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser,))),
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
                                          builder: (context) => BerandaSigma(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)));
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
                                          builder: (context) => BerandaMG(idUser: widget.idUser, aksesStatus: widget.aksesStatus)));
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Stack(
                                      overflow: Overflow.visible,
                                      children: <Widget>[
                                        Container(
                                          height: 50.0,
                                          width: 50.0,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                'assets/images/mg.png',
                                              ),
                                              fit: BoxFit.cover
                                            )
                                          ),
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
                                          top: 0.0,
                                          right: 4.0,
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
                      padding: EdgeInsets.only(right: 20.0),
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
                            child: AnimatedBuilder(
                              animation: animationController,
                              builder: (_, Widget child) {
                                return animationController.isAnimating
                                  ? Container(
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  : StreamBuilder(
                                      stream: Firestore.instance.collection('user').where('aksesStatus', isEqualTo: 'owner').limit(10).snapshots(),
                                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (!snapshot.hasData)
                                          return Container(
                                            child: Center(
                                              child: CircularProgressIndicator(),
                                            ),
                                          );
                                        
                                        return ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: snapshot.data.documents.length,
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
                                                          color: Colors.white,
                                                          shape: BoxShape.circle,
                                                          border: Border.all(
                                                            color: Colors.grey[300],
                                                            width: 3.0,
                                                          ),
                                                          image: DecorationImage(
                                                            image: NetworkImage("https://image.flaticon.com/icons/png/512/149/149071.png"),
                                                            fit: BoxFit.cover
                                                          )
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: 10.0),
                                                  child: Text(
                                                    snapshot.data.documents[index].data['nama'],
                                                    style: TextStyle(fontSize: 13.0),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: 10.0),
                                                  child: Text(
                                                    snapshot.data.documents[index].data['department'],
                                                    style: TextStyle(fontSize: 12.0),
                                                  ),
                                                )
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    );
                              },
                            )
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
                                  MyCustomRoute(builder: (context) => FormCreate(idUser: widget.idUser, departmentUser: widget.departmentUser, namaUser: widget.namaUser))),
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
                            child: AnimatedBuilder(
                              animation: animationController,
                              builder: (_, Widget child) {
                                return animationController.isAnimating
                                  ? Container(
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  : StreamBuilder(
                                      stream: Firestore.instance.collection('creative-idea').orderBy('dateCreated', descending: true).snapshots(),
                                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (!snapshot.hasData)
                                          return Container(
                                            child: Center(
                                              child: CircularProgressIndicator(),
                                            ),
                                          );

                                        if (snapshot.data.documents.length == 0) {
                                          return Container();
                                        } else {
                                          return CardList2(document: snapshot.data.documents, idUser: widget.idUser);
                                        }
                                      },
                                    );
                              },
                            )
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
                                      builder: (context) => FormCreateHappening(idUser: widget.idUser))),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // taro sini
                    Container(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      height: 350.0,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: <Widget>[
                          Flexible(
                            child: AnimatedBuilder(
                              animation: animationController,
                              builder: (_, Widget child) {
                                return animationController.isAnimating
                                  ? Container(
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  : StreamBuilder(
                                      stream: Firestore.instance.collection('whats-happening').orderBy('dateCreated', descending: true).snapshots(),
                                      builder: (BuildContext contex, AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (!snapshot.hasData)
                                          return Container(
                                            child: Center(
                                              child: CircularProgressIndicator(),
                                            ),
                                          );

                                        if (snapshot.data.documents.length == 0) {
                                          return Container();
                                        } else {
                                          return CardList(document: snapshot.data.documents, idUser: widget.idUser,);
                                        }
                                      },
                                    );
                              },
                            )
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          bottomNavigationBar: _buildBottomNavigation(),
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: null,
      items: [
        BottomNavigationBarItem(
          activeIcon: new Icon(
            Icons.home,
            color: AbubaPallate.green,
          ),
          icon: new Icon(
            Icons.home,
            color: Colors.grey,
          ),
          title: new Text(
            'Home',
          ),
        ),
        BottomNavigationBarItem(
          activeIcon: new Icon(
            Icons.timeline,
            color: AbubaPallate.green,
          ),
          icon: new Icon(
            Icons.timeline,
            color: Colors.grey,
          ),
          title: new Text('What\'s New'),
        ),
        BottomNavigationBarItem(
          activeIcon: new Icon(
            Icons.mail,
            color: AbubaPallate.green,
          ),
          icon: new Icon(
            Icons.mail,
            color: Colors.grey,
          ),
          title: new Text('Inbox'),
        ),
        BottomNavigationBarItem(
          activeIcon: new Icon(
            Icons.person,
            color: AbubaPallate.green,
          ),
          icon: FlatButton(
            splashColor: Colors.transparent,
            color: Colors.transparent,
            disabledColor: Colors.transparent,
            disabledTextColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              Navigator.push(context, 
                MaterialPageRoute(
                  builder: (_) => AccountPage(idUser: widget.idUser)
                )
              );
            },
            padding: EdgeInsets.only(top: 10.0),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 2.0,
                ),
                Text('Account', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 11.5))
              ],
            ),
          ),
          title: Text(''),
        ),
      ],
    );
  }
}

class CardList2 extends StatefulWidget {
  final List<DocumentSnapshot> document;
  final int idUser;
  CardList2({this.document, this.idUser});

  @override
  _CardList2State createState() => _CardList2State();
}

class _CardList2State extends State<CardList2> {
  var tempOutput;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.document.length,
      itemBuilder: (context, index) {
        tempOutput = List<dynamic>.from(widget.document[index].data['likes']);

        return Container(
          width: MediaQuery.of(context).size.width - 100.0,
          height: 400.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 15.0,
                alignment: Alignment.topLeft,
                child: Text(
                  widget.document[index].data['problem'],
                  style: TextStyle(
                      color: Colors.black, fontSize: 13.0),
                ),
              ),
              Container(
                height: 15.0,
                padding: EdgeInsets.only(top: 3.0),
                alignment: Alignment.topLeft,
                child: Text(
                  '${widget.document[index].data['userCreated'].toString()} . ${widget.document[index].data['userDepartment'].toString()}',
                  style: TextStyle(
                      color: Colors.black38, fontSize: 12.0),
                ),
              ),
              Container(
                height: 100.0,
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: RichText(
                  overflow: TextOverflow.visible,
                  text: TextSpan(
                    text: widget.document[index].data['description'],
                    style: TextStyle(color: Colors.black38, fontSize: 11.0),
                  ),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                onTap: () {},
                title: Container(
                  height: 140.0,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(
                      color: Colors.black12,
                      width: 2.0,
                    ),
                    image: DecorationImage(
                      image: NetworkImage("https://c1.staticflickr.com/5/4149/35646344915_805ee67321_b.jpg"),
                      fit: BoxFit.cover
                    )
                  ),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            tooltip: 'Like',
                            alignment: Alignment.centerRight,
                            icon: widget.document[index].data['likes'].contains(widget.idUser) ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
                            iconSize: 18.0,
                            color: widget.document[index].data['likes'].contains(widget.idUser) ? Colors.redAccent : Colors.grey,
                            onPressed: () {
                              // if (widget.document[index].data['likes'].contains(widget.idUser)) {
                              //   setState(() {
                              //     tempOutput.removeWhere((dynamic userID) => userID == widget.idUser);
                              //   });
                              //   var initialDataNoTimestamp = <String, dynamic>{
                              //     'likes': tempOutput,
                              //   };
                              //   DocumentReference docReference = Firestore.instance.collection('whats-happening').document(widget.document[index].documentID);
                              //   docReference.updateData(initialDataNoTimestamp).then((doc) {
                              //     print('not like');
                              //   }).catchError((error) {
                              //     print('error');
                              //   });
                              // } else {
                              //   setState(() {
                              //     tempOutput.add(widget.idUser);
                              //   });
                              //   var initialDataNoTimestamp = <String, dynamic>{
                              //     'likes': tempOutput,
                              //   };
                              //   DocumentReference docReference = Firestore.instance.collection('whats-happening').document(widget.document[index].documentID);
                              //   docReference.updateData(initialDataNoTimestamp).then((doc) {
                              //     print('liked');
                              //   }).catchError((error) {
                              //     print('error');
                              //   });
                              // }
                            },
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5.0),
                            child: Text(
                              widget.document[index].data['likes'].length.toString(),
                              style: TextStyle(
                                color: Colors.grey[500]
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: GestureDetector(
                        onTap: () => Navigator.push(context,
                          MyCustomRoute(
                            builder: (context) => FormCommentIdea()
                          )
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.chat,
                              size: 18.0,
                              color: AbubaPallate.greenabuba,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 5.0),
                              margin: EdgeInsets.only(top: 5.0),
                              child: Text(
                                widget.document[index].data['comments'].length.toString(),
                                style: TextStyle(
                                  color: Colors.grey[500]
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 20.0, top: 20.0),
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
                          onPressed: () => Navigator.push(context,
                            MyCustomRoute(
                              builder: (context) => FormDetail(index: widget.document[index].documentID)
                            )
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class CardList extends StatefulWidget {
  final List<DocumentSnapshot> document;
  final int idUser;
  CardList({this.document, this.idUser});

  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  var tempOutput;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.document.length,
      itemBuilder: (context, index) {
        tempOutput = List<dynamic>.from(widget.document[index].data['likes']);

        return Container(
          width: MediaQuery.of(context).size.width - 100.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 15.0,
                alignment: Alignment.topLeft,
                child: Text(
                  widget.document[index].data['title'],
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.black
                  ),
                ),
              ),
              Container(
                height: 100.0,
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: RichText(
                  overflow: TextOverflow.visible,
                  text: TextSpan(
                    text: widget.document[index].data['description'],
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 11.0
                    ),
                  ),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                onTap: () {},
                title: Container(
                  height: 140.0,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(
                      color: Colors.black12,
                      width: 2.0,
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                        widget.document[index].data['image'],
                      ),
                      fit: BoxFit.cover
                    )
                  ),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            tooltip: 'Like',
                            alignment: Alignment.centerRight,
                            icon: widget.document[index].data['likes'].contains(widget.idUser) ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
                            iconSize: 18.0,
                            color: widget.document[index].data['likes'].contains(widget.idUser) ? Colors.redAccent : Colors.grey,
                            onPressed: () {
                              // if (widget.document[index].data['likes'].contains(widget.idUser)) {
                              //   setState(() {
                              //     tempOutput.removeWhere((dynamic userID) => userID == widget.idUser);
                              //   });
                              //   var initialDataNoTimestamp = <String, dynamic>{
                              //     'likes': tempOutput,
                              //   };
                              //   DocumentReference docReference = Firestore.instance.collection('whats-happening').document(widget.document[index].documentID);
                              //   docReference.updateData(initialDataNoTimestamp).then((doc) {
                              //     print('not like');
                              //   }).catchError((error) {
                              //     print('error');
                              //   });
                              // } else {
                              //   setState(() {
                              //     tempOutput.add(widget.idUser);
                              //   });
                              //   var initialDataNoTimestamp = <String, dynamic>{
                              //     'likes': tempOutput,
                              //   };
                              //   DocumentReference docReference = Firestore.instance.collection('whats-happening').document(widget.document[index].documentID);
                              //   docReference.updateData(initialDataNoTimestamp).then((doc) {
                              //     print('liked');
                              //   }).catchError((error) {
                              //     print('error');
                              //   });
                              // }
                            },
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5.0),
                            child: Text(
                              widget.document[index].data['likes'].length.toString(),
                              style: TextStyle(
                                color: Colors.grey[500]
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: GestureDetector(
                        onTap: () => Navigator.push(context,
                          MyCustomRoute(
                            builder: (context) => FormComment()
                          )
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.chat,
                              size: 18.0,
                              color: AbubaPallate.greenabuba,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 5.0),
                              margin: EdgeInsets.only(top: 5.0),
                              child: Text(
                                widget.document[index].data['comments'].length.toString(),
                                style: TextStyle(
                                  color: Colors.grey[500]
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}