import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class FormAnalysis extends StatefulWidget {
  @override
  _FormAnalysisState createState() => _FormAnalysisState();
}

class _FormAnalysisState extends State<FormAnalysis> {
  bool _pesertaShow = true;
  Color _pesertaColor = AbubaPallate.menuBluebird;
  String _titleAnalisa = 'Briefing';
  bool _materiShow = false;
  Color _materiColor = Colors.grey;
  bool _durasiShow = false;
  Color _durasiColor = Colors.grey;

  String _mySelection;
  String _shift;
  List<Map> _shiftJson = [
    {"id": 1, "shift": "Shift A"},
    {"id": 2, "shift": "Shift B"}
  ];

  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime dateStart;
  DateTime dateEnd;

  List<String> _peserta = [
    'Min',
    'Average',
    'Max',
    'Std',
  ];

  List<double> _valuePeserta = [
    0.3,
    0.4,
    0.5,
    0.3,
  ];

  List<String> _valueTextPeserta = [
    '3',
    '4',
    '5',
    '3',
  ];

  List<Color> _colorPeserta = [
    Colors.redAccent,
    Colors.black12,
    Colors.black12,
    Colors.blue[100],
  ];

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
                'Briefing',
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
                  'Analysis',
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
                  hint: Text('Shift', style: TextStyle(fontSize: 14.0)),
                  value: _mySelection,
                  onChanged: (String newValue) {
                    setState(() {
                      switch (int.tryParse(newValue)) {
                        case 1:
                          _shift = 'Shift A';
                          break;
                        case 2:
                          _shift = 'Shift B';
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
                padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          width: 150.0,
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Analisa ${_titleAnalisa}',
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.black54, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 150.0,
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  '1 July 2019 - 6 July 2019',
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.black38),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: ButtonTheme(
                        minWidth: width / 4,
                        height: 25.0,
                        child: RaisedButton(
                          color: _pesertaColor,
                          child: Text(
                            'Peserta',
                            style: TextStyle(
                              fontSize: 12.0, color: Colors.white
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _pesertaShow = true;
                              _materiShow = false;
                              _durasiShow = false;
                              _pesertaColor = AbubaPallate.menuBluebird;
                              _materiColor = Colors.grey;
                              _durasiColor = Colors.grey;
                              _titleAnalisa = 'Briefing';
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                      child: ButtonTheme(
                        minWidth: width / 4,
                        height: 25.0,
                        child: RaisedButton(
                          color: _materiColor,
                          child: Text(
                            'Materi',
                            style: TextStyle(
                              fontSize: 12.0, color: Colors.white
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _pesertaShow = false;
                              _materiShow = true;
                              _durasiShow = false;
                              _pesertaColor = Colors.grey;
                              _materiColor = AbubaPallate.menuBluebird;
                              _durasiColor = Colors.grey;
                              _titleAnalisa = 'Briefing';
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: ButtonTheme(
                        minWidth: width / 4,
                        height: 25.0,
                        child: RaisedButton(
                          color: _durasiColor,
                          child: Text(
                            'Durasi',
                            style: TextStyle(
                              fontSize: 12.0, color: Colors.white
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _pesertaShow = false;
                              _materiShow = false;
                              _durasiShow = true;
                              _pesertaColor = Colors.grey;
                              _materiColor = Colors.grey;
                              _durasiColor = AbubaPallate.menuBluebird;
                              _titleAnalisa = 'Briefing';
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                )
              ),
              Column(
                verticalDirection: VerticalDirection.down,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _peserta.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          alignment: Alignment.centerLeft,
                          child: ListTile(
                            leading: Container(
                              width: 50.0,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: Text(
                                      _peserta[index],
                                      style: TextStyle(
                                        color: Colors.black54, fontSize: 13.0
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ),
                            trailing: Container(
                              width: 30.0,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: Text(
                                      _valueTextPeserta[index],
                                      style: TextStyle(
                                        color: Colors.black54, fontSize: 13.0
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ),
                            title: LinearPercentIndicator(
                              width: width / 1.7,
                              animation: true,
                              lineHeight: 25.0,
                              percent: _valuePeserta[index],
                              backgroundColor: Colors.transparent,
                              animationDuration: 1000,
                              linearStrokeCap: LinearStrokeCap.butt,
                              progressColor: _colorPeserta[index]
                            ),
                          )
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
