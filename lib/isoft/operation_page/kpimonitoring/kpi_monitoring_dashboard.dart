import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/isoft/operation_page/kpimonitoring/kpi_monitoring_detail.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class DashboardKpiMonitoring extends StatefulWidget {
  DashboardKpiMonitoring({Key key}) : super(key: key);

  @override
  _DashboardKpiMonitoringState createState() =>
      new _DashboardKpiMonitoringState();
}

class _DashboardKpiMonitoringState extends State<DashboardKpiMonitoring> {
  bool _progressShow = true;
  Color _progressColor = AbubaPallate.green;
  bool _badgetingShow = false;
  Color _badgetingColor = Colors.grey;
  bool _badgetingShow2 = false;
  Color _badgetingColor2 = Colors.grey;

  String _name = 'Routine';

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
                    'Total Performance',
                    style: TextStyle(color: Colors.black87, fontSize: 20.0),
                  ),
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(
                        right: 20.0, left: 20.0, bottom: 5.0, top: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'TOTAL',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '4 Titles',
                          style:
                              TextStyle(color: Colors.black38, fontSize: 13.0),
                        )
                      ],
                    )),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                  child: Text(
                    '80%',
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
                      percent: 0.8,
                      animationDuration: 1000,
                      linearStrokeCap: LinearStrokeCap.butt,
                      progressColor: Colors.green[300],
                    )),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(
                        right: 20.0, left: 20.0, bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: Text(
                            'Done 68 of 90',
                            style: TextStyle(
                                color: Colors.black54, fontSize: 15.0),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: Text(
                            'Late 2 of 90',
                            style: TextStyle(
                                color: Colors.black54, fontSize: 15.0),
                          ),
                        ),
                      ],
                    ))
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
                  padding: const EdgeInsets.only(
                      right: 20.0, left: 20.0, bottom: 5.0, top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _progressColor = AbubaPallate.green;
                            _badgetingColor = Colors.grey;
                            _badgetingColor2 = Colors.grey;
                            _progressShow = true;
                            _badgetingShow = false;
                            _badgetingShow2 = false;
                            _name = 'Routine';
                          });
                        },
                        child: Container(
                          width: width / 4,
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Routine',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: _progressColor),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5.0),
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
                            _badgetingColor2 = Colors.grey;
                            _progressShow = false;
                            _badgetingShow = true;
                            _badgetingShow2 = false;
                            _name = 'Non-routine';
                          });
                        },
                        child: Container(
                          width: width / 4,
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Non-routine',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: _badgetingColor),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5.0),
                                child: Divider(
                                  height: 10.0,
                                  color: _badgetingColor,
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
                            _badgetingColor = Colors.grey;
                            _badgetingColor2 = AbubaPallate.green;
                            _progressShow = false;
                            _badgetingShow = false;
                            _badgetingShow2 = true;
                            _name = 'Project';
                          });
                        },
                        child: Container(
                          width: width / 4,
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Project',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: _badgetingColor2),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5.0),
                                child: Divider(
                                  height: 10.0,
                                  color: _badgetingColor2,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                  child: Text(
                    _progressShow ? '50%' : _badgetingShow ? '70%' : '90%',
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
                    percent: _progressShow ? 0.5 : _badgetingShow ? 0.7 : 0.9,
                    animationDuration: 1000,
                    linearStrokeCap: LinearStrokeCap.butt,
                    progressColor: _progressShow ? Colors.orangeAccent[100] : _badgetingShow ? Colors.green[300] : Colors.green[300],
                  )
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(
                      right: 15.0, left: 15.0, top: 20.0, bottom: 10.0),
                  child: Text(
                    '$_name Snapshot',
                    style: TextStyle(color: Colors.black87, fontSize: 20.0),
                  ),
                ),
                ExpansionTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 250.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    _progressShow ? 'Maintenance' : _badgetingShow ? 'Meeting Vendor' : 'Outlet Senopati',
                                    style: TextStyle(
                                        color: AbubaPallate.green,
                                        fontSize: 19.0),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    '90%',
                                    style: TextStyle(
                                        color: Colors.black38,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, bottom: 15.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Created by',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 14.0, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Department',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 14.0, fontWeight: FontWeight.bold),
                                  )
                                ],
                              )),
                          Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Ridwan Kareem',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 13.0),
                                  ),
                                  Text(
                                    'Operation',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 13.0),
                                  )
                                ],
                              )),
                          Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    '17 September 2018 - 20:20',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 13.0),
                                  ),
                                ],
                              )),
                          Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Team',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 14.0, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Period',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 14.0, fontWeight: FontWeight.bold),
                                  )
                                ],
                              )),
                          Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Rizal, Soni, Andi, Michael',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 13.0),
                                  ),
                                  Text(
                                    '17/08/2018 - 17/12/2018',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 13.0),
                                  )
                                ],
                              )),
                          SizedBox(
                            height: 2.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              ButtonTheme(
                                padding: EdgeInsets.all(0.0),
                                minWidth: 60.0,
                                height: 20.0,
                                child: OutlineButton(
                                  child: Text(
                                    'Detail',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: AbubaPallate.menuBluebird),
                                  ),
                                  borderSide: BorderSide(
                                      color: AbubaPallate.menuBluebird,
                                      width: 1.0),
                                  highlightedBorderColor:
                                      AbubaPallate.menuBluebird,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MyCustomRoute(
                                            builder: (context) =>
                                                new DashboardKpiMonitoringDetail(name: _progressShow ? 'Maintenance' : _badgetingShow ? 'Meeting Vendor' : 'Outlet Senopati')));
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 250.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    _progressShow ? 'Perbaikan' : _badgetingShow ? 'Training' : 'Outlet Bogor',
                                    style: TextStyle(
                                        color: AbubaPallate.green,
                                        fontSize: 19.0),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    '90%',
                                    style: TextStyle(
                                        color: Colors.black38,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, bottom: 15.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Created by',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 14.0, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Department',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 14.0, fontWeight: FontWeight.bold),
                                  )
                                ],
                              )),
                          Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Ridwan Kareem',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 13.0),
                                  ),
                                  Text(
                                    'Operation',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 13.0),
                                  )
                                ],
                              )),
                          Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    '17 September 2018 - 20:20',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 13.0),
                                  ),
                                ],
                              )),
                          Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Team',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 14.0, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Period',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 14.0, fontWeight: FontWeight.bold),
                                  )
                                ],
                              )),
                          Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Rizal, Soni, Andi, Michael',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 13.0),
                                  ),
                                  Text(
                                    '17/08/2018 - 17/12/2018',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 13.0),
                                  )
                                ],
                              )),
                          SizedBox(
                            height: 2.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              ButtonTheme(
                                padding: EdgeInsets.all(0.0),
                                minWidth: 60.0,
                                height: 20.0,
                                child: OutlineButton(
                                  child: Text(
                                    'Detail',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: AbubaPallate.menuBluebird),
                                  ),
                                  borderSide: BorderSide(
                                      color: AbubaPallate.menuBluebird,
                                      width: 1.0),
                                  highlightedBorderColor:
                                      AbubaPallate.menuBluebird,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MyCustomRoute(
                                            builder: (context) =>
                                                new DashboardKpiMonitoringDetail(name: _progressShow ? 'Perbaikan' : _badgetingShow ? 'Training' : 'Outlet Bogor')));
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 250.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    _progressShow ? 'Instalasi Jaringan' : _badgetingShow ? 'Seminar' : 'Outlet Bekasi',
                                    style: TextStyle(
                                        color: AbubaPallate.green,
                                        fontSize: 19.0),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    '90%',
                                    style: TextStyle(
                                        color: Colors.black38,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, bottom: 15.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Created by',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 14.0, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Department',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 14.0, fontWeight: FontWeight.bold),
                                  )
                                ],
                              )),
                          Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Ridwan Kareem',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 13.0),
                                  ),
                                  Text(
                                    'Operation',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 13.0),
                                  )
                                ],
                              )),
                          Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    '17 September 2018 - 20:20',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 13.0),
                                  ),
                                ],
                              )),
                          Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Team',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 14.0, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Period',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 14.0, fontWeight: FontWeight.bold),
                                  )
                                ],
                              )),
                          Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Rizal, Soni, Andi, Michael',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 13.0),
                                  ),
                                  Text(
                                    '17/08/2018 - 17/12/2018',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 13.0),
                                  )
                                ],
                              )),
                          SizedBox(
                            height: 2.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              ButtonTheme(
                                padding: EdgeInsets.all(0.0),
                                minWidth: 60.0,
                                height: 20.0,
                                child: OutlineButton(
                                  child: Text(
                                    'Detail',
                                    style: TextStyle(
                                        fontSize: 13.0,
                                        color: AbubaPallate.menuBluebird),
                                  ),
                                  borderSide: BorderSide(
                                      color: AbubaPallate.menuBluebird,
                                      width: 1.0),
                                  highlightedBorderColor:
                                      AbubaPallate.menuBluebird,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MyCustomRoute(
                                            builder: (context) =>
                                                new DashboardKpiMonitoringDetail(name: _progressShow ? 'Instalasi Jaringan' : _badgetingShow ? 'Seminar' : 'Outlet Bekasi')));
                                  },
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
