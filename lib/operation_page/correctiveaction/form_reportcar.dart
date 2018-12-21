import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

class ReportCar extends StatefulWidget {
  @override
  _ReportCarState createState() => _ReportCarState();
}

class _ReportCarState extends State<ReportCar> {
  final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();

  bool _note = false;
  var ratingChiller = 0.0;
  TextEditingController controllerNoteSatu = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double size = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AbubaAppBar(),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: _bodyForm(size),
        ),
      ),
    );
  }

  Widget _bodyForm(double size) {
    return Scrollbar(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Corrective Action',
                  style: TextStyle(color: Colors.black12, fontSize: 12.0),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    '|',
                    style: TextStyle(
                        color: AbubaPallate.greenabuba, fontSize: 12.0),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    'Report',
                    style: TextStyle(
                        color: AbubaPallate.greenabuba, fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Center(
                child: new AnimatedCircularChart(
                  key: _chartKey,
                  size: Size(size / 2, size / 2),
                  initialChartData: <CircularStackEntry>[
                    new CircularStackEntry(
                      <CircularSegmentEntry>[
                        new CircularSegmentEntry(
                          30.0,
                          Colors.blue[400],
                          rankKey: 'completed',
                        ),
                        new CircularSegmentEntry(
                          70.0,
                          Colors.blueGrey[600],
                          rankKey: 'remaining',
                        ),
                      ],
                      rankKey: 'progress',
                    ),
                  ],
                  chartType: CircularChartType.Radial,
                  percentageValues: true,
                  holeLabel: '30%',
                  labelStyle: new TextStyle(
                    color: Colors.blueGrey[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0,),
          Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                    child: Text(
                      'CAR# 001',
                      style: TextStyle(
                          fontSize: 16.0,
                          color: AbubaPallate.greenabuba,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Departemen',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w100),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'FSTL',
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.right,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 2.0,
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding:
                          const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Auditor',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w100),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              '-',
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.right,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 2.0,
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding:
                          const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Auditee',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w100),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              '-',
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.right,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 2.0,
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding:
                          const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Issue by',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w100),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Superadmin',
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.right,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 2.0,
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding:
                      const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Verificator',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w100),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding:
                      const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Superadmin',
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.right,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 2.0,
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding:
                      const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Verification Date',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w100),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding:
                      const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              '-',
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.right,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 2.0,
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding:
                      const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Date',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w100),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding:
                      const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              '20 Desember 2018',
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.right,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 2.0,
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding:
                      const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Problem',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w100),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding:
                      const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              '-',
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.right,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 2.0,
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding:
                      const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Root Cause',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w100),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding:
                      const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              '-',
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.right,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 2.0,
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding:
                      const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Immediate action',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w100),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding:
                      const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              '-',
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.right,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 2.0,
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding:
                      const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Action Plan',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w100),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding:
                      const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              '-',
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.right,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 2.0,
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding:
                      const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Target Date',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w100),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding:
                      const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              '-',
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.right,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 2.0,
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding:
                      const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Status',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w100),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding:
                      const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Open',
                              style: TextStyle(color: Colors.red),
                              textAlign: TextAlign.right,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
//        itemCount: 10,
      ),
    );
  }
}
