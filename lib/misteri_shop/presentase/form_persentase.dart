import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class FormPersentase extends StatefulWidget {
  @override
  _FormPersentaseState createState() => _FormPersentaseState();
}

class _FormPersentaseState extends State<FormPersentase>
    with SingleTickerProviderStateMixin {
  String _mySelection;
  String _outlet;
  List<Map> _outletJson = [
    {"id": 1, "outlet": "All Outlet"},
    {"id": 2, "outlet": "Senopati"},
    {"id": 3, "outlet": "Bekasi"},
    {"id": 4, "outlet": "Bogor"},
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
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelStyle: TextStyle(fontSize: 14.0),
                            labelText: 'From'),
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
                            labelText: 'To'),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10.0, left: 20.0, right: 20.0),
                width: width,
                child: DropdownButtonFormField(
                  hint: Text(
                    'Outlet',
                    style: TextStyle(fontSize: 14.0),
                  ),
                  value: _mySelection,
                  onChanged: (String value) {
                    setState(() {
                      switch (int.tryParse(value)) {
                        case 1:
                          _outlet = 'BRC';
                          break;

                        case 2:
                          _outlet = 'Not BRC';
                          break;
                      }
                      _mySelection = value;
                    });
                  },
                  items: _outletJson.map((Map map) {
                    return new DropdownMenuItem(
                      value: map['id'].toString(),
                      child: Text(map['outlet']),
                    );
                  }).toList(),
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
                        '17/08/2018 – 17/08/2019',
                        style: TextStyle(fontSize: 12.0, color: Colors.black38),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: Text('Jakarta'),
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
                  percent: 0.8,
                  animationDuration: 1000,
                  linearStrokeCap: LinearStrokeCap.butt,
                  progressColor: Colors.green[300],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: Text('Bogor'),
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
                  percent: 0.8,
                  animationDuration: 1000,
                  linearStrokeCap: LinearStrokeCap.butt,
                  progressColor: Colors.green[300],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: Text('Senopati'),
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
                  percent: 0.8,
                  animationDuration: 1000,
                  linearStrokeCap: LinearStrokeCap.butt,
                  progressColor: Colors.green[300],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: Text('Bekasi'),
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
                  percent: 0.22,
                  animationDuration: 1000,
                  linearStrokeCap: LinearStrokeCap.butt,
                  progressColor: Colors.red[300],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
