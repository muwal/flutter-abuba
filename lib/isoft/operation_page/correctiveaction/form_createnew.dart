import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class FormCreateNew extends StatefulWidget {
  FormCreateNew({Key key}) : super(key: key);

  @override
  _FormCreateNewState createState() => _FormCreateNewState();
}

class _FormCreateNewState extends State<FormCreateNew>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  final List<Tab> internalAuditTabs = <Tab>[
    new Tab(child: Text('Problem', style: TextStyle(color: Colors.grey[400]))),
    new Tab(
        child: Text('Root Cause', style: TextStyle(color: Colors.grey[400]))),
    new Tab(
        child: Text('Immediate Action',
            style: TextStyle(color: Colors.grey[400]))),
    new Tab(
        child:
            Text('Recommendation', style: TextStyle(color: Colors.grey[400]))),
  ];

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(vsync: this, length: internalAuditTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime dateStart;
  DateTime dateEnd;
  DateTime dateSchedule;

  String _mySelection;
  String _jenisAcara;
  List<Map> _jenisAcaraJson = [
    {"id": 1, "jenis": "One"},
    {"id": 2, "jenis": "Two"}
  ];

  Color _colorLowSe = Colors.grey;
  Color _colorMedSe = Colors.grey;
  Color _colorHighSe = Colors.grey;

  Widget _appBar() {
    return AppBar(
      elevation: 0.25,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.asset(
            'assets/images/logo2.png',
            height: 150.0,
            width: 120.0,
          ),
          new Container(
            child: new Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 15.0),
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
                )
              ],
            ),
          )
        ],
      ),
      bottom: new TabBar(
        controller: _tabController,
        isScrollable: true,
        indicatorColor: AbubaPallate.greenabuba,
        tabs: internalAuditTabs,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: _appBar(),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: DropdownButtonFormField(
                          hint: Text(
                            'Category',
                            style: TextStyle(fontSize: 12.0),
                          ),
                          value: _mySelection,
                          onChanged: (String newValue) {
                            setState(() {
                              switch (int.tryParse(newValue)) {
                                case 1:
                                  _jenisAcara = 'Pernikahan';
                                  break;
                                case 2:
                                  _jenisAcara = 'Ulang tahun';
                                  break;
                                default:
                                  _jenisAcara = '-';
                                  break;
                              }
                              _mySelection = newValue;
                            });
                          },
                          items: _jenisAcaraJson.map((Map map) {
                            return new DropdownMenuItem(
                              value: map['id'].toString(),
                              child: Text(map['jenis']),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                      child: TextField(
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          labelText: 'Problem',
                          labelStyle: TextStyle(fontSize: 12.0),
                        ),
                        textCapitalization: TextCapitalization.sentences,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                      child: DateTimePickerFormField(
                        format: dateFormat,
                        onChanged: (dt) => setState(() => dateStart = dt),
                        dateOnly: true,
                        style: TextStyle(fontSize: 14.0, color: Colors.black),
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelStyle: TextStyle(fontSize: 12.0),
                            labelText: 'When'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Text(
                                'How Severe',
                                style: new TextStyle(
                                  fontSize: 14.0,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                ButtonTheme(
                                  height: 30.0,
                                  child: OutlineButton(
                                    child: Text(
                                      'Low',
                                      style: TextStyle(
                                          color: _colorLowSe),
                                    ),
                                    borderSide: BorderSide(
                                        color: _colorLowSe,
                                        width: 1.0),
                                    highlightedBorderColor:
                                    _colorLowSe,
                                    onPressed: () {
                                      setState(() {
                                        _colorLowSe =
                                        Colors.green[400];
                                        _colorMedSe =
                                            Colors.grey;
                                        _colorHighSe =
                                            Colors.grey;
                                      });
                                    },
                                  ),
                                ),
                                ButtonTheme(
                                  height: 30.0,
                                  child: OutlineButton(
                                    child: Text(
                                      'Medium',
                                      style: TextStyle(
                                          color: _colorMedSe),
                                    ),
                                    borderSide: BorderSide(
                                        color: _colorMedSe,
                                        width: 1.0),
                                    highlightedBorderColor:
                                    _colorMedSe,
                                    onPressed: () {
                                      setState(() {
                                        _colorLowSe =
                                            Colors.grey;
                                        _colorMedSe = Colors
                                            .orangeAccent;
                                        _colorHighSe =
                                            Colors.grey;
                                      });
                                    },
                                  ),
                                ),
                                ButtonTheme(
                                  height: 30.0,
                                  child: OutlineButton(
                                    child: Text(
                                      'High',
                                      style: TextStyle(
                                          color:
                                          _colorHighSe),
                                    ),
                                    borderSide: BorderSide(
                                        color: _colorHighSe,
                                        width: 1.0),
                                    highlightedBorderColor:
                                    _colorHighSe,
                                    onPressed: () {
                                      setState(() {
                                        _colorLowSe =
                                            Colors.grey;
                                        _colorMedSe =
                                            Colors.grey;
                                        _colorHighSe =
                                            Colors.redAccent;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                      child: TextField(
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          labelText: 'Remarks (optional)',
                          labelStyle: TextStyle(fontSize: 12.0),
                        ),
                        textCapitalization: TextCapitalization.sentences,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 10.0, right: 20.0),
                          child: ButtonTheme(
                            minWidth: 50.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                'NEXT',
                                style: TextStyle(
                                    fontSize: 13.0, color: Colors.blue),
                              ),
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 1.0),
                              highlightedBorderColor: Colors.blue,
                              onPressed: () {
                                _tabController
                                    .animateTo((_tabController.index + 1) % 2);
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: DropdownButtonFormField(
                          hint: Text(
                            'What',
                            style: TextStyle(fontSize: 12.0),
                          ),
                          value: _mySelection,
                          onChanged: (String newValue) {
                            setState(() {
                              switch (int.tryParse(newValue)) {
                                case 1:
                                  _jenisAcara = 'Pernikahan';
                                  break;
                                case 2:
                                  _jenisAcara = 'Ulang tahun';
                                  break;
                                default:
                                  _jenisAcara = '-';
                                  break;
                              }
                              _mySelection = newValue;
                            });
                          },
                          items: _jenisAcaraJson.map((Map map) {
                            return new DropdownMenuItem(
                              value: map['id'].toString(),
                              child: Text(map['jenis']),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                      child: TextField(
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          labelText: 'Remarks (optional)',
                          labelStyle: TextStyle(fontSize: 12.0),
                        ),
                        textCapitalization: TextCapitalization.sentences,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                          child: ButtonTheme(
                            minWidth: 50.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                'PREV',
                                style: TextStyle(
                                    fontSize: 13.0, color: Colors.grey),
                              ),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                              highlightedBorderColor: Colors.grey,
                              onPressed: () {
                                _tabController
                                    .animateTo((_tabController.index - 1));
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 10.0, right: 20.0),
                          child: ButtonTheme(
                            minWidth: 50.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                'NEXT',
                                style: TextStyle(
                                    fontSize: 13.0, color: Colors.blue),
                              ),
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 1.0),
                              highlightedBorderColor: Colors.blue,
                              onPressed: () {
                                _tabController
                                    .animateTo((_tabController.index + 1));
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                      child: TextField(
                        maxLines: null,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'What',
                          labelStyle: TextStyle(fontSize: 12.0),
                        ),
                        textCapitalization: TextCapitalization.sentences,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                      child: DateTimePickerFormField(
                        format: dateFormat,
                        onChanged: (dt) => setState(() => dateStart = dt),
                        dateOnly: true,
                        style: TextStyle(fontSize: 14.0, color: Colors.black),
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelStyle: TextStyle(fontSize: 12.0),
                            labelText: 'Date'),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                          child: ButtonTheme(
                            minWidth: 50.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                'PREV',
                                style: TextStyle(
                                    fontSize: 13.0, color: Colors.grey),
                              ),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                              highlightedBorderColor: Colors.grey,
                              onPressed: () {
                                _tabController
                                    .animateTo((_tabController.index - 1));
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 10.0, right: 20.0),
                          child: ButtonTheme(
                            minWidth: 50.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                'NEXT',
                                style: TextStyle(
                                    fontSize: 13.0, color: Colors.blue),
                              ),
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 1.0),
                              highlightedBorderColor: Colors.blue,
                              onPressed: () {
                                _tabController
                                    .animateTo((_tabController.index + 1));
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                      child: TextField(
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          labelText: 'What',
                          labelStyle: TextStyle(fontSize: 12.0),
                        ),
                        textCapitalization: TextCapitalization.sentences,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                      child: DateTimePickerFormField(
                        format: dateFormat,
                        onChanged: (dt) => setState(() => dateStart = dt),
                        dateOnly: true,
                        style: TextStyle(fontSize: 14.0, color: Colors.black),
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelStyle: TextStyle(fontSize: 12.0),
                            labelText: 'Due Date'),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: DropdownButtonFormField(
                              hint: Text(
                                'Status',
                                style: TextStyle(fontSize: 12.0),
                              ),
                              value: _mySelection,
                              onChanged: (String newValue) {
                                setState(() {
                                  switch (int.tryParse(newValue)) {
                                    case 1:
                                      _jenisAcara = 'Pernikahan';
                                      break;
                                    case 2:
                                      _jenisAcara = 'Ulang tahun';
                                      break;
                                    default:
                                      _jenisAcara = '-';
                                      break;
                                  }
                                  _mySelection = newValue;
                                });
                              },
                              items: _jenisAcaraJson.map((Map map) {
                                return new DropdownMenuItem(
                                  value: map['id'].toString(),
                                  child: Text(map['jenis']),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: DropdownButtonFormField(
                              hint: Text(
                                'Send to',
                                style: TextStyle(fontSize: 12.0),
                              ),
                              value: _mySelection,
                              onChanged: (String newValue) {
                                setState(() {
                                  switch (int.tryParse(newValue)) {
                                    case 1:
                                      _jenisAcara = 'Pernikahan';
                                      break;
                                    case 2:
                                      _jenisAcara = 'Ulang tahun';
                                      break;
                                    default:
                                      _jenisAcara = '-';
                                      break;
                                  }
                                  _mySelection = newValue;
                                });
                              },
                              items: _jenisAcaraJson.map((Map map) {
                                return new DropdownMenuItem(
                                  value: map['id'].toString(),
                                  child: Text(map['jenis']),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                          child: ButtonTheme(
                            minWidth: 50.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                'PREV',
                                style: TextStyle(
                                    fontSize: 13.0, color: Colors.grey),
                              ),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                              highlightedBorderColor: Colors.grey,
                              onPressed: () {
                                _tabController
                                    .animateTo((_tabController.index - 1));
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 10.0, right: 20.0),
                          child: ButtonTheme(
                            minWidth: 50.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                'SAVE',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    color: AbubaPallate.greenabuba),
                              ),
                              borderSide: BorderSide(
                                  color: AbubaPallate.greenabuba, width: 1.0),
                              highlightedBorderColor: AbubaPallate.greenabuba,
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
