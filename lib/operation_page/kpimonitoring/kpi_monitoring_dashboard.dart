import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class DashboardKpiMonitoring extends StatefulWidget {
  DashboardKpiMonitoring({Key key}) : super(key: key);

  @override
  _DashboardKpiMonitoringState createState() => new _DashboardKpiMonitoringState();
}

class _DashboardKpiMonitoringState extends State<DashboardKpiMonitoring>{ 
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
                    '14 September 2018 - 28 Desember 2018',
                    style: TextStyle(color: Colors.black26, fontSize: 13.0),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding:
                      const EdgeInsets.only(right: 20.0, left: 20.0, top: 10.0),
                  child: Text(
                    'All',
                    style: TextStyle(color: Colors.black87, fontSize: 13.0),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding:
                      const EdgeInsets.only(right: 20.0, left: 20.0, top: 10.0),
                  child: Text(
                    '29%',
                    style: TextStyle(color: Colors.black87, fontSize: 24.0),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: LinearPercentIndicator(
                    padding: EdgeInsets.only(right: 20.0, left: 20.0),
                    width: width,
                    animation: true,
                    lineHeight: 30.0,
                    percent: 0.29,
                    animationDuration: 1000,
                    linearStrokeCap: LinearStrokeCap.butt,
                    progressColor: Colors.green[300],
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Done 63 of 215',
                            style: TextStyle(
                              color: Colors.black54, fontSize: 13.0
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Late 63 of 215',
                            style: TextStyle(
                              color: Colors.black54, fontSize: 13.0
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Today 0 of 0',
                            style: TextStyle(
                              color: Colors.black54, fontSize: 13.0
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ),
              ],
            ),
          ),
        ],
      )
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