import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/operation_page/kpimonitoring/kpi_monitoring_detail.dart';
import 'package:intl/intl.dart';
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

  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime dateFrom;
  DateTime dateTo;

  String _categorySelection;
  String _category;
  List<Map> _categoryJSON = [
    {"id":"1", "category":"All"},
    {"id":"2", "category":"BRC"},
  ];

  String _titleSelection;
  String _title;
  List<Map> _titleJSON = [
    {"id":"1", "title":"All"},
    {"id":"2", "title":"Title BRC 1"},
  ];

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
                Padding(
                  padding:
                      const EdgeInsets.only(right: 20.0, left: 20.0, top: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Grafik',
                          style: TextStyle(color: AbubaPallate.green),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 8.0, 20.0, 5.0),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(bottom: 20.0),
                                  width: width / 2.5,
                                  child: DateTimePickerFormField(
                                    format: dateFormat,
                                    onChanged: (dt) => setState(() => dateFrom = dt),
                                    dateOnly: true,
                                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelStyle: TextStyle(fontSize: 14.0),
                                      labelText: 'From'
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(bottom: 20.0),
                                  width: width / 2.5,
                                  child: DateTimePickerFormField(
                                    format: dateFormat,
                                    onChanged: (dt) => setState(() => dateTo = dt),
                                    dateOnly: true,
                                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelStyle: TextStyle(fontSize: 14.0),
                                      labelText: 'To'
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 10.0),
                              width: width,
                              child: DropdownButtonFormField(
                                hint: Text(
                                  'Category',
                                  style: TextStyle(
                                    fontSize: 14.0
                                  ),
                                ),
                                value: _categorySelection,
                                onChanged: (String value) {
                                  setState(() {
                                    switch (int.tryParse(value)) {
                                      case 1:
                                        _category = 'BRC';
                                        break;
                                      
                                      case 2:
                                        _category = 'Not BRC';
                                        break;
                                    }
                                    _categorySelection = value;
                                  });
                                },
                                items: _categoryJSON.map((Map map) {
                                  return new DropdownMenuItem(
                                    value: map['id'].toString(),
                                    child: Text(map['category']),
                                  );
                                }).toList(),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 10.0),
                              width: width,
                              child: DropdownButtonFormField(
                                hint: Text(
                                  'Title',
                                  style: TextStyle(
                                    fontSize: 14.0
                                  ),
                                ),
                                value: _titleSelection,
                                onChanged: (String value) {
                                  setState(() {
                                    switch (int.tryParse(value)) {
                                      case 1:
                                        _title = 'BRC';
                                        break;
                                      
                                      case 2:
                                        _title = 'Not BRC';
                                        break;
                                    }
                                    _titleSelection = value;
                                  });
                                },
                                items: _titleJSON.map((Map map) {
                                  return new DropdownMenuItem(
                                    value: map['id'].toString(),
                                    child: Text(map['title']),
                                  );
                                }).toList(),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(top: 10.0),
                              child: ButtonTheme(
                                minWidth: 50.0,
                                height: 30.0,
                                child: OutlineButton(
                                  child: Text(
                                    'Search',
                                    style: TextStyle(
                                        fontSize: 13.0, color: Colors.blue),
                                  ),
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 1.0),
                                  highlightedBorderColor: Colors.blue,
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    )
                ),
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
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                      MyCustomRoute(
                        builder: (context) => new DashboardKpiMonitoringDetail()
                      )
                    );
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding:
                        const EdgeInsets.only(right: 20.0, left: 20.0, top: 15.0),
                    child: Text(
                      'Outlet Senopati',
                      style: TextStyle(color: AbubaPallate.green, fontSize: 20.0),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 5.0, top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Created by',
                            style: TextStyle(
                              color: Colors.black54, fontSize: 13.0
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Department',
                            style: TextStyle(
                              color: Colors.black54, fontSize: 13.0
                            ),
                          ),
                        ],
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
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Ridwan Kareem',
                            style: TextStyle(
                              color: Colors.black38, fontSize: 13.0
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Operation',
                            style: TextStyle(
                              color: Colors.black38, fontSize: 13.0
                            ),
                          ),
                        ],
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
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '17 September 2018 - 20:20',
                            style: TextStyle(
                              color: Colors.black38, fontSize: 13.0
                            ),
                          ),
                        ],
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
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Team',
                            style: TextStyle(
                              color: Colors.black54, fontSize: 13.0
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Period',
                            style: TextStyle(
                              color: Colors.black54, fontSize: 13.0
                            ),
                          ),
                        ],
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
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Rizal, Soni, Andi, Michael',
                            style: TextStyle(
                              color: Colors.black38, fontSize: 13.0
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '17/08/2018 - 17/12/2018',
                            style: TextStyle(
                              color: Colors.black38, fontSize: 13.0
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 5.0, top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ButtonTheme(
                        minWidth: width / 2.5,
                        height: 40.0,
                        child: RaisedButton(
                          color: _progressColor,
                          child: Text(
                            'Progress',
                            style: TextStyle(
                                fontSize: 13.0, color: Colors.white),
                          ),
                          onPressed: () {
                            setState(() {
                              _progressColor = AbubaPallate.green;
                              _badgetingColor = Colors.grey;
                              _progressShow = true;
                              _badgetingShow = false;
                            });
                          },
                        ),
                      ),
                      ButtonTheme(
                        minWidth: width / 2.5,
                        height: 40.0,
                        child: RaisedButton(
                          color: _badgetingColor,
                          child: Text(
                            'Badgeting',
                            style: TextStyle(
                                fontSize: 13.0, color: Colors.white),
                          ),
                          onPressed: () {
                            setState(() {
                              _progressColor = Colors.grey;
                              _badgetingColor = AbubaPallate.green;
                              _progressShow = false;
                              _badgetingShow = true;
                            });
                          },
                        ),
                      ),
                    ],
                  )
                ),
                _progressShow
                  ? Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          padding:
                              const EdgeInsets.only(right: 20.0, left: 20.0, top: 10.0),
                          child: Text(
                            'Progress'
                          )
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding:
                              const EdgeInsets.only(right: 20.0, left: 20.0, top: 5.0),
                          child: Text(
                            '90%',
                            style: TextStyle(color: Colors.black54, fontSize: 24.0),
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
                          'Badgeting'
                        )
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding:
                            const EdgeInsets.only(right: 20.0, left: 20.0, top: 5.0),
                        child: Text(
                          '90%',
                          style: TextStyle(color: Colors.black54, fontSize: 24.0),
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