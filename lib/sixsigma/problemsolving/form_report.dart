import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';
import 'package:intl/intl.dart';

import 'detail_report.dart';

class FormReport extends StatefulWidget {
  @override
  _FormReportState createState() => _FormReportState();
}

class _FormReportState extends State<FormReport> {
  String _mySelection;
  String _shift;
  List<Map> _shiftJson = [
    {"id": 1, "shift": "Department A"},
    {"id": 2, "shift": "Department B"}
  ];

  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime dateStart;
  DateTime dateEnd;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AbubaAppBar(),
        body: _buildReport(width),
      ),
    );
  }

  Widget _buildReport(double width) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Problem Solving',
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
                padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: width / 2.5,
                      child: DateTimePickerFormField(
                        format: dateFormat,
                        onChanged: (dt) => setState(() => dateStart = dt),
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
                      width: width / 2.5,
                      child: DateTimePickerFormField(
                    format: dateFormat,
                    onChanged: (dt) => setState(() => dateEnd = dt),
                    dateOnly: true,
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelStyle: TextStyle(fontSize: 14.0),
                      labelText: 'To'
                    ),
                  ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                child: DropdownButtonFormField(
                  hint: Text('Department', style: TextStyle(fontSize: 14.0)),
                  value: _mySelection,
                  onChanged: (String newValue) {
                    setState(() {
                      switch (int.tryParse(newValue)) {
                        case 1:
                          _shift = 'Department A';
                          break;
                        case 2:
                          _shift = 'Department B';
                          break;
                        default:
                          _shift = '-';
                          break;
                      }
                      _mySelection = newValue;
                    });
                  },
                  items: _shiftJson.map((Map map) {
                    return new DropdownMenuItem(
                      value: map['id'].toString(),
                      child: Text(map['shift']),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 20.0),
                child: ButtonTheme(
                  minWidth: width / 2.5,
                  height: 40.0,
                  child: RaisedButton(
                    color: Colors.green,
                    child: Text(
                      'SEARCH',
                      style: TextStyle(
                          fontSize: 13.0, color: Colors.white),
                    ),
                    onPressed: () {},
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Container(
          width: width,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 100.0,
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              '17 January 2018',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black54),
                            ),
                          )
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
                              'Department A',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black54),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 100.0,
                      child: ButtonTheme(
                        padding: EdgeInsets.all(0.0),
                        height: 20.0,
                        child: OutlineButton(
                          child: Text(
                            'Report',
                            style: TextStyle(fontSize: 13.0, color: AbubaPallate.menuBluebird),
                          ),
                          borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                          highlightedBorderColor: AbubaPallate.menuBluebird,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MyCustomRoute(
                                    builder: (context) => DetailReport()));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 100.0,
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              '17 January 2018',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black54),
                            ),
                          )
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
                              'Department A',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black54),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 100.0,
                      child: ButtonTheme(
                        padding: EdgeInsets.all(0.0),
                        height: 20.0,
                        child: OutlineButton(
                          child: Text(
                            'Report',
                            style: TextStyle(fontSize: 13.0, color: AbubaPallate.menuBluebird),
                          ),
                          borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                          highlightedBorderColor: AbubaPallate.menuBluebird,
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
