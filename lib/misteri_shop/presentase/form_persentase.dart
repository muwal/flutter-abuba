import 'dart:async';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

class FormPersentase extends StatefulWidget {
  @override
  _FormPersentaseState createState() => _FormPersentaseState();
}

class _FormPersentaseState extends State<FormPersentase> with TickerProviderStateMixin {
  final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();
  
  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime dateStart;
  DateTime dateEnd;

  bool showDataFiltered = false;
  bool showHelper = false;
  String helperText = '';

  AnimationController animationController;

  var document = [];
  List<double> dataGrafik = [];
  double allPerformance = 0.0;
  int count = 0;
  Color colorGrafik;
  String isProcess = 'blank';

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

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
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Mystery Shopper',
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
                      'Report',
                      style:
                          TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              width: width,
              child: ExpansionTile(
                title: Text(
                  'Search',
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 0.0, left: 20.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: width / 2.5,
                          child: DateTimePickerFormField(
                            format: dateFormat,
                            onChanged: (dt) => setState(() => dateStart = dt),
                            dateOnly: true,
                            editable: false,
                            resetIcon: null,
                            style: TextStyle(fontSize: 16.0, color: Colors.black),
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelStyle: TextStyle(fontSize: 14.0),
                              labelText: 'From',
                              helperText: helperText,
                              helperStyle: TextStyle(
                                color: showHelper ? Colors.redAccent : Colors.black38,
                                fontStyle: showHelper ? FontStyle.italic : FontStyle.normal,
                                fontSize: 14.0
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: width / 2.5,
                          child: DateTimePickerFormField(
                            format: dateFormat,
                            onChanged: (dt) => setState(() => dateEnd = dt),
                            dateOnly: true,
                            editable: false,
                            resetIcon: null,
                            style: TextStyle(fontSize: 16.0, color: Colors.black),
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelStyle: TextStyle(fontSize: 14.0),
                              labelText: 'To',
                              helperText: '',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 20.0, right: 20.0, bottom: 15.0),
                    child: ButtonTheme(
                      minWidth: width / 2.5,
                      height: 40.0,
                      child: RaisedButton(
                        color: Colors.green,
                        child: Text(
                          'SEARCH',
                          style: TextStyle(fontSize: 13.0, color: Colors.white),
                        ),
                        onPressed: () async {
                          if (dateStart != null && dateEnd != null) {
                            if (dateStart.isAfter(dateEnd) == false) {
                              setState(() {
                                showDataFiltered = true;
                                showHelper = false;
                                helperText = '';

                                isProcess = 'loading';
                                document.clear();
                                dataGrafik.clear();
                                count = 0;

                                Firestore.instance.collection('mystery_shopper').where('checkIn', isGreaterThanOrEqualTo: dateStart).getDocuments().then((data) async {
                                  document = data.documents;

                                  for (int i = 0; i < document.length; i++) {
                                    Timestamp tanggalTS = document[i].data['checkIn'];
                                    DateTime tanggalBantu = DateTime.tryParse(tanggalTS.toDate().toString());

                                    if (tanggalBantu.isAfter(dateEnd.subtract(Duration(days: -1))) == true || document[i].data['checkOut'] == null) {
                                      
                                    } else {
                                      if (document[i].data['hasilGrafik'] != null) {
                                        count += 1;
                                        dataGrafik.add(document[i].data['hasilGrafik']);
                                      }
                                    }
                                  }

                                  allPerformance = (dataGrafik.reduce((a, b) => a + b)) / count;
                                  allPerformance > 85.0 ? colorGrafik = Colors.green : allPerformance < 70.0 ? colorGrafik = Colors.redAccent : colorGrafik = Colors.orangeAccent;

                                  print(dataGrafik);
                                  print(count);
                                  print(allPerformance);
                                });
                              });
                              await new Future.delayed(Duration(
                                seconds: 5
                              ));
                              setState(() {
                                isProcess = 'view';
                              });
                            } else {
                              setState(() {
                                showDataFiltered = false;
                                showHelper = true;
                                helperText = "can\'t back date";

                                isProcess = 'blank'; 
                              });
                            }
                          } else {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => Dialog(
                                child: Container(
                                  height: 180.0,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        color: AbubaPallate.greenabuba,
                                        height: 50.0,
                                        child: Center(
                                          child: Text(
                                            'OOPS!',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                        child: Text(
                                          'Date from and date to can\'t be empty',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          FlatButton(
                                            child: Text('OK'),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            );
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            isProcess == 'loading'
              ? Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : isProcess == 'view'
                  ? Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(vertical:10.0, horizontal: 10.0),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal:10.0),
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'OUTLET PERFORMANCE',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w700,
                                        color: AbubaPallate.greenabuba),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal:10.0),
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    '${dateStart.toString().substring(8, 10) + '/' + dateStart.toString().substring(5, 7) + '/' + dateStart.toString().substring(0, 4)} – ${dateEnd.toString().substring(8, 10) + '/' + dateEnd.toString().substring(5, 7) + '/' + dateEnd.toString().substring(0, 4)}',
                                    style: TextStyle(fontSize: 12.0, color: Colors.black38),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Center(
                              child: new AnimatedCircularChart(
                                key: _chartKey,
                                size: Size(MediaQuery.of(context).size.width / 4, MediaQuery.of(context).size.width / 3),
                                initialChartData: <CircularStackEntry>[
                                  new CircularStackEntry(
                                    <CircularSegmentEntry>[
                                      new CircularSegmentEntry(
                                        allPerformance,
                                        Colors.green,
                                        rankKey: 'completed',
                                      ),
                                      new CircularSegmentEntry(
                                        100.0 - allPerformance,
                                        Colors.blueGrey[600],
                                        rankKey: 'remaining',
                                      ),
                                    ],
                                    rankKey: 'progress',
                                  ),
                                ],
                                chartType: CircularChartType.Radial,
                                percentageValues: true,
                                holeLabel: allPerformance > 100.0 ? '100%' : '${allPerformance.toString().substring(0,2)}%',
                                labelStyle: new TextStyle(
                                  color: Colors.blueGrey[600],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24.0,
                                ),
                              ),
                            ),
                          ),
                          StreamBuilder(
                            stream: Firestore.instance.collection('mystery_shopper').where('checkIn', isGreaterThanOrEqualTo: dateStart).snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData)
                                return Container(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );

                              var document = snapshot.data.documents;

                              return Column(
                                children: List.generate(document.length, (index) {
                                  Timestamp tanggalBantuTS = snapshot.data.documents[index].data['checkIn'];
                                  DateTime tanggalBantu = DateTime.tryParse(tanggalBantuTS.toDate().toString());
                                  if (showDataFiltered && dateEnd != null && dateStart != null) {
                                    if (tanggalBantu.isAfter(dateEnd.subtract(Duration(days: -1))) == true || snapshot.data.documents[index].data['checkOut'] == null) {
                                      return Container();
                                    } else {
                                      return Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(top: 12.0, left: 10.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(document[index].data['outlet']),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: LinearPercentIndicator(
                                              width: MediaQuery.of(context).size.width / 1.1,
                                              animation: true,
                                              lineHeight: 30.0,
                                              percent: document[index].data['hasilGrafik'] > 100.0 ? 1.0 : document[index].data['hasilGrafik'] / 100,
                                              center: Text(
                                                document[index].data['hasilGrafik'] > 100.0 ? '100%' : '${(document[index].data['hasilGrafik']).toString().substring(0, 2)}%'
                                              ),
                                              animationDuration: 1000,
                                              linearStrokeCap: LinearStrokeCap.butt,
                                              progressColor: document[index].data['hasilGrafik'] > 85.0 ? Colors.green : document[index].data['hasilGrafik'] < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                                            ),
                                          )
                                        ],
                                      );
                                    }
                                  }
                                }).toList()
                              );
                            },
                          )

                        ],
                      ),
                    )
                  : Container()
          ],
        ),
      ),
    );
  }
}