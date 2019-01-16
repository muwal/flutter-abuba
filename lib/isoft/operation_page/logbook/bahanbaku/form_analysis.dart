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
  bool _soldShow = true;
  Color _soldColor = AbubaPallate.menuBluebird;
  String _titleAnalisa = 'Sold';
  bool _limitShow = false;
  Color _limitColor = Colors.grey;
  bool _suggestShow = false;
  Color _suggestColor = Colors.grey;

  String _mySelection;
  String _shift;
  List<Map> _shiftJson = [
    {"id": 1, "shift": "Shift A"},
    {"id": 2, "shift": "Shift B"}
  ];

  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime dateStart;
  DateTime dateEnd;

  List<String> _stock = [
    'Aqua',
    'Fanta',
    'Aqua',
    'Wagyu',
    'Tenderloin',
    'Sirloin',
    'Wagyu 2',
    'Wagyu 3',
  ];

  List<double> _valueStock = [
    0.3,
    0.4,
    0.5,
    0.6,
    0.7,
    0.75,
    0.95,
    0.85,
  ];

  List<String> _valueTextStock = [
    '100',
    '200',
    '300',
    '400',
    '500',
    '600',
    '700',
    '650',
  ];

  List<Color> _colorStock = [
    Colors.redAccent,
    Colors.black12,
    Colors.black12,
    Colors.black12,
    Colors.black12,
    Colors.black12,
    Colors.green[200],
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
                'Bahan Baku',
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
                padding:
                    const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
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
              Padding(
                padding:
                    const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
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
                padding: const EdgeInsets.only(
                    top: 10.0, left: 20.0, right: 20.0, bottom: 20.0),
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
                                      fontSize: 12.0,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: ButtonTheme(
                          minWidth: width / 4,
                          height: 25.0,
                          child: RaisedButton(
                            color: _soldColor,
                            child: Text(
                              'Sold',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.white),
                            ),
                            onPressed: () {
                              setState(() {
                                _soldShow = true;
                                _limitShow = false;
                                _suggestShow = false;
                                _soldColor = AbubaPallate.menuBluebird;
                                _limitColor = Colors.grey;
                                _suggestColor = Colors.grey;
                                _titleAnalisa = 'Stock';
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
                            color: _limitColor,
                            child: Text(
                              'Limit',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.white),
                            ),
                            onPressed: () {
                              setState(() {
                                _soldShow = false;
                                _limitShow = true;
                                _suggestShow = false;
                                _soldColor = Colors.grey;
                                _limitColor = AbubaPallate.menuBluebird;
                                _suggestColor = Colors.grey;
                                _titleAnalisa = 'Limit';
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
                            color: _suggestColor,
                            child: Text(
                              'Suggest',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.white),
                            ),
                            onPressed: () {
                              setState(() {
                                _soldShow = false;
                                _limitShow = false;
                                _suggestShow = true;
                                _soldColor = Colors.grey;
                                _limitColor = Colors.grey;
                                _suggestColor = AbubaPallate.menuBluebird;
                                _titleAnalisa = 'Suggest';
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  )),
              Column(
                verticalDirection: VerticalDirection.down,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _stock.length,
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
                                          _stock[index],
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 13.0),
                                        ),
                                      )
                                    ],
                                  )),
                              trailing: Container(
                                  width: 30.0,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: Text(
                                          _valueTextStock[index],
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 13.0),
                                        ),
                                      )
                                    ],
                                  )),
                              title: LinearPercentIndicator(
                                  width: width / 1.7,
                                  animation: true,
                                  lineHeight: 25.0,
                                  percent: _valueStock[index],
                                  backgroundColor: Colors.transparent,
                                  animationDuration: 1000,
                                  linearStrokeCap: LinearStrokeCap.butt,
                                  progressColor: _colorStock[index]),
                            ));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 6.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                            alignment: Alignment.centerRight,
                            padding:
                                const EdgeInsets.only(left: 12.0, bottom: 6.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: ButtonTheme(
                                    minWidth: 50.0,
                                    height: 30.0,
                                    child: OutlineButton(
                                      child: Text(
                                        'MIN',
                                        style: TextStyle(
                                            fontSize: 13.0, color: Colors.grey),
                                      ),
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 1.0),
                                      highlightedBorderColor: Colors.grey,
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 5.0, left: 5.0),
                                  child: ButtonTheme(
                                    minWidth: 50.0,
                                    height: 30.0,
                                    child: OutlineButton(
                                      child: Text(
                                        'AVG',
                                        style: TextStyle(
                                            fontSize: 13.0, color: Colors.grey),
                                      ),
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 1.0),
                                      highlightedBorderColor: Colors.grey,
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: ButtonTheme(
                                    minWidth: 50.0,
                                    height: 30.0,
                                    child: OutlineButton(
                                      child: Text(
                                        'MAX',
                                        style: TextStyle(
                                            fontSize: 13.0, color: Colors.grey),
                                      ),
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 1.0),
                                      highlightedBorderColor: Colors.grey,
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
