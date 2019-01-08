import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/operation_page/kpimonitoring/kpi_monitoring_detail.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class DashboardKpiMonitoring extends StatefulWidget {
  DashboardKpiMonitoring({Key key}) : super(key: key);

  @override
  _DashboardKpiMonitoringState createState() => new _DashboardKpiMonitoringState();
}

class _DashboardKpiMonitoringState extends State<DashboardKpiMonitoring>{
  bool _progressShow = true;
  Color _progressColor = AbubaPallate.green;
  bool _badgetingShow = false;
  Color _badgetingColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: _appBar(),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Text(
                    'KPI Monitoring',
                    style: TextStyle(color: Colors.black12, fontSize: 12.0),
                  ),
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
                    'Dashboard',
                    style: TextStyle(
                        color: AbubaPallate.greenabuba, fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  padding:
                      const EdgeInsets.only(right: 20.0, left: 20.0, top: 15.0),
                  child: Text(
                    'The Current Chart',
                    style: TextStyle(color: Colors.black87, fontSize: 20.0),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 5.0, top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'TOTAL',
                        style: TextStyle(
                          color: Colors.black54, fontSize: 13.0, fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        '4 Titles',
                        style: TextStyle(
                          color: Colors.black38, fontSize: 13.0
                        ),
                      )
                    ],
                  )
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding:
                      const EdgeInsets.only(right: 20.0, left: 20.0),
                  child: Text(
                    '47%',
                    style: TextStyle(color: Colors.black54, fontSize: 26.0),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: LinearPercentIndicator(
                    padding: EdgeInsets.only(right: 20.0, left: 20.0),
                    width: width,
                    animation: true,
                    lineHeight: 30.0,
                    percent: 0.47,
                    animationDuration: 1000,
                    linearStrokeCap: LinearStrokeCap.butt,
                    progressColor: Colors.orangeAccent[100],
                  )
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Text(
                          'Done 68 of 90',
                          style: TextStyle(
                            color: Colors.black54, fontSize: 15.0
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Text(
                          'Late 2 of 90',
                          style: TextStyle(
                            color: Colors.black54, fontSize: 15.0
                          ),
                        ),
                      ),
                    ],
                  )
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  padding:
                      const EdgeInsets.only(right: 20.0, left: 20.0, top: 20.0),
                  child: Text(
                    'Project Snapshot',
                    style: TextStyle(color: Colors.black87, fontSize: 20.0),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      padding:
                          const EdgeInsets.only(right: 20.0, left: 20.0, top: 15.0),
                      child: Text(
                        'Outlet Senopati',
                        style: TextStyle(color: AbubaPallate.green, fontSize: 19.0),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 15.0),
                      child: ButtonTheme(
                        minWidth: 50.0,
                        height: 25.0,
                        child: OutlineButton(
                          child: Text(
                            'Detail',
                            style: TextStyle(
                                fontSize: 13.0,
                                color: Colors.green
                            ),
                          ),
                          borderSide: BorderSide(
                              color: Colors.green,
                              width: 1.0
                          ),
                          highlightedBorderColor: Colors.green,
                          onPressed: () {
                            Navigator.push(context,
                              MyCustomRoute(
                                builder: (context) => new DashboardKpiMonitoringDetail()
                              )
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Created by',
                        style: TextStyle(
                          color: Colors.black54, fontSize: 13.0
                        ),
                      ),
                      Text(
                        'Department',
                        style: TextStyle(
                          color: Colors.black54, fontSize: 13.0
                        ),
                      )
                    ],
                  )
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Ridwan Kareem',
                        style: TextStyle(
                          color: Colors.black54, fontSize: 13.0
                        ),
                      ),
                      Text(
                        'Operation',
                        style: TextStyle(
                          color: Colors.black54, fontSize: 13.0
                        ),
                      )
                    ],
                  )
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '17 September 2018 - 20:20',
                        style: TextStyle(
                          color: Colors.black54, fontSize: 13.0
                        ),
                      ),
                    ],
                  )
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Team',
                        style: TextStyle(
                          color: Colors.black54, fontSize: 13.0
                        ),
                      ),
                      Text(
                        'Period',
                        style: TextStyle(
                          color: Colors.black54, fontSize: 13.0
                        ),
                      )
                    ],
                  )
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Rizal, Soni, Andi, Michael',
                        style: TextStyle(
                          color: Colors.black54, fontSize: 13.0
                        ),
                      ),
                      Text(
                        '17/08/2018 - 17/12/2018',
                        style: TextStyle(
                          color: Colors.black54, fontSize: 13.0
                        ),
                      )
                    ],
                  )
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 5.0, top: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _progressColor = AbubaPallate.green;
                            _badgetingColor = Colors.grey;
                            _progressShow = true;
                            _badgetingShow = false;
                          });
                        },
                        child: Container(
                          width: width / 4,
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Progress',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: _progressColor
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5.0),
                                child: Divider(
                                  height: 10.0,
                                  color: _progressColor,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _progressColor = Colors.grey;
                            _badgetingColor = AbubaPallate.green;
                            _progressShow = false;
                            _badgetingShow = true;
                          });
                        },
                        child: Container(
                          width: width / 4,
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Badgeting',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: _badgetingColor
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5.0),
                                child: Divider(
                                  height: 10.0,
                                  color: _badgetingColor,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ),
                // Container(
                //   alignment: Alignment.centerLeft,
                //   padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 5.0, top: 20.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: <Widget>[
                //       ButtonTheme(
                //         minWidth: width / 2.5,
                //         height: 40.0,
                //         child: RaisedButton(
                //           color: _progressColor,
                //           child: Text(
                //             'Progress',
                //             style: TextStyle(
                //               fontSize: 13.0, color: Colors.white
                //             ),
                //           ),
                //           onPressed: () {
                //             setState(() {
                //               _progressColor = AbubaPallate.green;
                //               _badgetingColor = Colors.grey;
                //               _progressShow = true;
                //               _badgetingShow = false;
                //             });
                //           },
                //         ),
                //       ),
                //       ButtonTheme(
                //         minWidth: width / 2.5,
                //         height: 40.0,
                //         child: RaisedButton(
                //           color: _badgetingColor,
                //           child: Text(
                //             'Badgeting',
                //             style: TextStyle(
                //                 fontSize: 13.0, color: Colors.white),
                //           ),
                //           onPressed: () {
                //             setState(() {
                //               _progressColor = Colors.grey;
                //               _badgetingColor = AbubaPallate.green;
                //               _progressShow = false;
                //               _badgetingShow = true;
                //             });
                //           },
                //         ),
                //       ),
                //     ],
                //   )
                // ),
                _progressShow
                  ? Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          padding:
                              const EdgeInsets.only(right: 20.0, left: 20.0, top: 10.0),
                          child: Text(
                            'PROGRESS',
                            style: TextStyle(
                              color: Colors.black54, fontSize: 13.0, fontWeight: FontWeight.bold
                            ),
                          )
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding:
                              const EdgeInsets.only(right: 20.0, left: 20.0, top: 5.0),
                          child: Text(
                            '90%',
                            style: TextStyle(color: Colors.black54, fontSize: 26.0),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: LinearPercentIndicator(
                            padding: EdgeInsets.only(right: 20.0, left: 20.0),
                            width: width,
                            animation: true,
                            lineHeight: 30.0,
                            percent: 0.9,
                            animationDuration: 1000,
                            linearStrokeCap: LinearStrokeCap.butt,
                            progressColor: Colors.green[300],
                          )
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2.0),
                                    child: Text(
                                      'Plan',
                                      style: TextStyle(
                                        color: Colors.black54, fontSize: 15.0
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3.0),
                                    child: Text(
                                      '80%',
                                      style: TextStyle(
                                        color: Colors.black38, fontSize: 17.0
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3.0),
                                    child: Text(
                                      '3 of 5',
                                      style: TextStyle(
                                        color: Colors.black38, fontSize: 13.0
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2.0),
                                    child: Text(
                                      'Do',
                                      style: TextStyle(
                                        color: Colors.black54, fontSize: 15.0
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3.0),
                                    child: Text(
                                      '70%',
                                      style: TextStyle(
                                        color: Colors.black38, fontSize: 17.0
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3.0),
                                    child: Text(
                                      '3 of 5',
                                      style: TextStyle(
                                        color: Colors.black38, fontSize: 13.0
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2.0),
                                    child: Text(
                                      'Check',
                                      style: TextStyle(
                                        color: Colors.black54, fontSize: 15.0
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3.0),
                                    child: Text(
                                      '70%',
                                      style: TextStyle(
                                        color: Colors.black38, fontSize: 17.0
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3.0),
                                    child: Text(
                                      '3 of 5',
                                      style: TextStyle(
                                        color: Colors.black38, fontSize: 13.0
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2.0),
                                    child: Text(
                                      'Adjust',
                                      style: TextStyle(
                                        color: Colors.black54, fontSize: 15.0
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3.0),
                                    child: Text(
                                      '60%',
                                      style: TextStyle(
                                        color: Colors.orange, fontSize: 17.0
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 3.0),
                                    child: Text(
                                      '3 of 5',
                                      style: TextStyle(
                                        color: Colors.black38, fontSize: 13.0
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ),
                      ],
                    )
                : Container(),
                _badgetingShow
                  ? Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        padding:
                            const EdgeInsets.only(right: 20.0, left: 20.0, top: 10.0),
                        child: Text(
                          'BADGETING',
                          style: TextStyle(
                            color: Colors.black54, fontSize: 13.0, fontWeight: FontWeight.bold
                          ),
                        )
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding:
                            const EdgeInsets.only(right: 20.0, left: 20.0, top: 5.0),
                        child: Text(
                          '90%',
                          style: TextStyle(color: Colors.black54, fontSize: 26.0),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: LinearPercentIndicator(
                          padding: EdgeInsets.only(right: 20.0, left: 20.0),
                          width: width,
                          center: Text(
                            'Good',
                            style: TextStyle(
                              color: Colors.grey[50]
                            ),
                          ),
                          animation: true,
                          lineHeight: 30.0,
                          percent: 0.9,
                          animationDuration: 1000,
                          linearStrokeCap: LinearStrokeCap.butt,
                          progressColor: Colors.green[300],
                        )
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 2.0),
                                  child: Text(
                                    'Labor',
                                    style: TextStyle(
                                      color: Colors.black54, fontSize: 15.0
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 3.0),
                                  child: Text(
                                    '80%',
                                    style: TextStyle(
                                      color: Colors.black38, fontSize: 17.0
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 3.0),
                                  child: Text(
                                    '2M vs 3M',
                                    style: TextStyle(
                                      color: Colors.black38, fontSize: 13.0
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 2.0),
                                  child: Text(
                                    'Material',
                                    style: TextStyle(
                                      color: Colors.black54, fontSize: 15.0
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 3.0),
                                  child: Text(
                                    '70%',
                                    style: TextStyle(
                                      color: Colors.black38, fontSize: 17.0
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 3.0),
                                  child: Text(
                                    '2M vs 3M',
                                    style: TextStyle(
                                      color: Colors.black38, fontSize: 13.0
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 2.0),
                                  child: Text(
                                    'Travel',
                                    style: TextStyle(
                                      color: Colors.black54, fontSize: 15.0
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 3.0),
                                  child: Text(
                                    '70%',
                                    style: TextStyle(
                                      color: Colors.black38, fontSize: 17.0
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 3.0),
                                  child: Text(
                                    '2M vs 3M',
                                    style: TextStyle(
                                      color: Colors.black38, fontSize: 13.0
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 2.0),
                                  child: Text(
                                    'Service',
                                    style: TextStyle(
                                      color: Colors.black54, fontSize: 15.0
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 3.0),
                                  child: Text(
                                    '110%',
                                    style: TextStyle(
                                      color: Colors.orange, fontSize: 17.0
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 3.0),
                                  child: Text(
                                    '2M vs 3M',
                                    style: TextStyle(
                                      color: Colors.black38, fontSize: 13.0
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      )
                    ],
                  )
                  : Container()
              ],
            ),
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
            child: Container(
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
            ),
          )
        ],
      ),
    );
  }
}