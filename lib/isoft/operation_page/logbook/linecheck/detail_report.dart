import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailReport extends StatefulWidget {
  @override
  _DetailReportState createState() => _DetailReportState();

  final int idUser;
  final String namaUser;
  final String idCollection;
  DetailReport({this.idUser, this.namaUser, this.idCollection});
}

class _DetailReportState extends State<DetailReport>
    with TickerProviderStateMixin {
  AnimationController animationController;
  final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();

  List<dynamic> AreaLuarScore = [];
  List<dynamic> AreaLuarNote = [];
  List<dynamic> DinningAreaScore = [];
  List<dynamic> DinningAreaNote = [];
  List<dynamic> ServiceScore = [];
  List<dynamic> ServiceNote = [];
  List<dynamic> CashierScore = [];
  List<dynamic> CashierNote = [];
  List<dynamic> CashierAccuracyScore = [];
  List<dynamic> CashierAccuracyNote = [];
  List<dynamic> BohScore = [];
  List<dynamic> BohNote = [];
  List<dynamic> WarehouseScore = [];
  List<dynamic> WarehouseNote = [];
  List<dynamic> SocialBlockScore = [];
  List<dynamic> SocialBlockNote = [];
  List<dynamic> PersonalScore = [];
  List<dynamic> PersonalNote = [];
  List<dynamic> FoodCookedScore = [];
  List<dynamic> FoodCookedNote = [];

  double hasilAreaLuar = 0.0;
  double hasilDinningArea = 0.0;
  double hasilService = 0.0;
  double hasilCashier = 0.0;
  double hasilCashierAccuracy = 0.0;
  double hasilBoh = 0.0;
  double hasilWarehouse = 0.0;
  double hasilSocialBlock = 0.0;
  double hasilPersonal = 0.0;
  double hasilFoodCooked = 0.0;
  double hasilGrafik = 0.0;

  String tanggal;
  String userCreated;

  double hasilKedua = 0.0;
  Color colorGrafik = Colors.green;

  @override
  void initState() {
    super.initState();
    setState(() {

      Firestore.instance
        .collection('linecheck')
        .document(widget.idCollection)
        .snapshots()
        .listen((data) {
        tanggal = data.data['timeDone'].toString().substring(8, 10) +
            '/' +
            data.data['timeDone'].toString().substring(5, 7) +
            '/' +
            data.data['timeDone'].toString().substring(0, 4);

        hasilAreaLuar = data.data['hasilAreaLuar'];
        hasilDinningArea = data.data['hasilDinningArea'];
        hasilService = data.data['hasilService'];
        hasilCashier = data.data['hasilCashier'];
        hasilCashierAccuracy = data.data['hasilCashierAccuracy'];
        hasilBoh = data.data['hasilBoh'];
        hasilWarehouse = data.data['hasilWarehouse'];
        hasilSocialBlock = data.data['hasilSocialBlock'];
        hasilPersonal = data.data['hasilPersonal'];
        hasilFoodCooked = data.data['hasilFoodCooked'];
        hasilGrafik = data.data['hasilGrafik'];

        Firestore.instance
            .collection('user')
            .where('id', isEqualTo: data.data['idUser'])
            .snapshots()
            .listen((data2) {
          userCreated = data2.documents[0].data['nama'];
        });
      });
    });
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(
        from:
        animationController.value == 0.0 ? 1.0 : animationController.value);
  }

  @override
  Widget build(BuildContext context) {
    final double size = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.25,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Image.asset(
            'assets/images/logo2.png',
            height: 150.0,
            width: 120.0,
          ),
        ),
        body: _formDetail(size, context),
      ),
    );
  }

  Widget _formDetail(double size, BuildContext context) {
    if (hasilAreaLuar == 1 && hasilDinningArea == 1 && hasilService == 1 && hasilCashier == 1 && hasilCashierAccuracy == 1 && hasilBoh == 1 && hasilWarehouse == 1 && hasilSocialBlock == 1 && hasilPersonal == 1 && hasilFoodCooked == 1) {
      hasilKedua = 100.0;
    } else {
      hasilKedua = hasilGrafik * 100.0;
    }

    hasilKedua > 85.0 ? colorGrafik = Colors.green : hasilKedua < 70.0 ? colorGrafik = Colors.redAccent : colorGrafik = Colors.orangeAccent;

    return Scrollbar(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Report',
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
                    'QC Report',
                    style:
                        TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
          AnimatedBuilder(
            animation: animationController,
            builder: (_, Widget child) {
              return animationController.isAnimating
                  ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
                  : Container(
                padding: EdgeInsets.all(12.0),
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Restaurant Centre',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black54),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            tanggal,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            userCreated,
                            style: TextStyle(
                                color: Colors.black54, fontSize: 13.0),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            '-',
                            style: TextStyle(
                                color: Colors.black54, fontSize: 13.0),
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Divider(
                        height: 6.0,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Center(
                        child: new AnimatedCircularChart(
                          key: _chartKey,
                          size: Size(size / 4, size / 3),
                          initialChartData: <CircularStackEntry>[
                            new CircularStackEntry(
                              <CircularSegmentEntry>[
                                new CircularSegmentEntry(
                                  hasilKedua,
                                  colorGrafik,
                                  rankKey: 'completed',
                                ),
                                new CircularSegmentEntry(
                                  100.0 - hasilKedua,
                                  Colors.blueGrey[600],
                                  rankKey: 'remaining',
                                ),
                              ],
                              rankKey: 'progress',
                            ),
                          ],
                          chartType: CircularChartType.Radial,
                          percentageValues: true,
                          holeLabel: hasilKedua >= 100.0 ? '100%' : '${hasilKedua.toString().substring(0,2)}%',
                          labelStyle: new TextStyle(
                            color: Colors.blueGrey[600],
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                          ),
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 100.0,
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  hasilKedua.toString(),
                                  style: TextStyle(
                                      fontSize: 14.0, color: AbubaPallate.green),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 100.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Pack',
                                  style: TextStyle(
                                      fontSize: 14.0, color: AbubaPallate.green),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 100.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Waktu',
                                  style: TextStyle(
                                      fontSize: 14.0, color: AbubaPallate.green),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 100.0,
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Customer',
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.black38),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 100.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  '167',
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 100.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  '16:00 - 18:00',
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.black38),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 6.0,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 100.0,
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Reuni',
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.black38),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 100.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  '167',
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 100.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  '16:00 - 18:00',
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.black38),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 6.0,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 100.0,
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Arisan',
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.black38),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 100.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  '167',
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.black38),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 100.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  '16:00 - 18:00',
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.black38),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 6.0,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 100.0,
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Reuni',
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.black38),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 100.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  '761',
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.green),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 100.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  '16:00 - 18:00',
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.black38),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
