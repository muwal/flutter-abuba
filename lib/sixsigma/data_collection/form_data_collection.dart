import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:intl/intl.dart';

class FormDataCollection extends StatefulWidget {
  @override
  _FormDataCollectionState createState() => _FormDataCollectionState();
}

class _FormDataCollectionState extends State<FormDataCollection> with TickerProviderStateMixin {
  List<Map> _listData = [ {'nomor': '1'}, {'nomor': '2'}, {'nomor': '3'}];

  bool _note1 = false;
  bool _note2 = false;
  bool _note3 = false;
  bool _note4 = false;
  bool _note5 = false;
  bool _note6 = false;

  String _dibuatOlehSelection;
  String _dibuatOleh;
  List<Map> _dibuatOlehJson = [
    {"id": 1, "dibuatOleh": "Ridwan"},
    {"id": 2, "dibuatOleh": "Jessica"},
  ];

  String _dataSourceSelection;
  String _dataSource;
  List<Map> _dataSourceJson = [
    {"id": 1, "dataSource": "Source 1"},
    {"id": 2, "dataSource": "Source 2"},
  ];

  String _dataLocationSelection;
  String _dataLocation;
  List<Map> _dataLocationJson = [
    {"id": 1, "dataLocation": "Location 1"},
    {"id": 2, "dataLocation": "Location 2"},
  ];

  String _whoCollectDataSelection;
  String _whoCollectData;
  List<Map> _whoCollectDataJson = [
    {"id": 1, "whoCollectData": "Ridwan"},
    {"id": 2, "whoCollectData": "Sony"},
  ];

  String _howDataCollectedSelection;
  String _howDataCollected;
  List<Map> _howDataCollectedJson = [
    {"id": 1, "howDataCollected": "Daily"},
    {"id": 2, "howDataCollected": "Weekly"},
  ];

  String _dataUsedSelection;
  String _dataUsed;
  List<Map> _dataUsedJson = [
    {"id": 1, "dataUsed": "Statistically"},
    {"id": 2, "dataUsed": "Random"},
  ];

  String _additionalDataCollectedSelection;
  String _additionalDataCollected;
  List<Map> _additionalDataCollectedJson = [
    {"id": 1, "additionalDataCollected": "Revenue"},
    {"id": 2, "additionalDataCollected": "Cost Saving"},
  ];

  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime dateStart;
  DateTime dateCollected;

  TabController _cardController;

  @override
  void initState() {
    super.initState();
    _cardController = new TabController(vsync: this, length: _listData.length);
  }

  @override
  void dispose() {
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _appBar(),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TabBarView(
                    controller: _cardController,
                    physics: ScrollPhysics(),
                    children: <Widget>[
                      ListView(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        children: <Widget>[
                          PreferredSize(
                            preferredSize: Size.fromHeight(55.0),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 55.0,
                                  child: Container(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            '1. General Information',
                                            style: TextStyle(color: Colors.white, fontSize: 14.0),
                                            textAlign: TextAlign.start,
                                          ),
                                          Text(
                                            '1 of ${_listData.length.toString()}',
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 14.0),
                                            textAlign: TextAlign.start,
                                          ),
                                        ],
                                      ),
                                    ),
                                    decoration: BoxDecoration(color: Color(0xFF2F592F))
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Nama Project',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                color: Colors.black87,
                                fontSize: 16.0),
                              onSaved: null,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                            child: DateTimePickerFormField(
                              format: dateFormat,
                              onChanged: (dt) =>
                                  setState(() => dateStart = dt),
                              dateOnly: true,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black87,
                              ),
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelStyle: TextStyle(fontSize: 16.0),
                                labelText: 'Tanggal'
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'Dibuat Oleh',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              value: _dibuatOlehSelection,
                              onChanged: (String value) {
                                setState(() {
                                  switch (int.tryParse(value)) {
                                    case 1:
                                      _dibuatOleh = 'Ridwan';
                                      break;
                                    case 2:
                                      _dibuatOleh = 'Jessica';
                                      break;
                                    default:
                                      _dibuatOleh = '-';
                                      break;
                                  }
                                  _dibuatOlehSelection = value;
                                });
                              },
                              items: _dibuatOlehJson.map((Map map) {
                                return DropdownMenuItem(
                                  value: map['id'].toString(),
                                  child: Text(map['dibuatOleh'], style: TextStyle(fontSize: 16.0, color: Colors.black87, fontStyle: FontStyle.normal)),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        children: <Widget>[
                          PreferredSize(
                            preferredSize: Size.fromHeight(55.0),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 55.0,
                                  child: Container(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            '1. General Information',
                                            style: TextStyle(color: Colors.white, fontSize: 14.0),
                                            textAlign: TextAlign.start,
                                          ),
                                          Text(
                                            '2 of ${_listData.length.toString()}',
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 14.0),
                                            textAlign: TextAlign.start,
                                          ),
                                        ],
                                      ),
                                    ),
                                    decoration: BoxDecoration(color: Color(0xFF2F592F))
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: TextFormField(
                                textCapitalization: TextCapitalization.sentences,
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Performance Measure',
                                  labelStyle: TextStyle(fontSize: 16.0),
                                ),
                                style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  color: Colors.black87,
                                  fontSize: 16.0),
                                onSaved: null,
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.add, color: Colors.white),
                              onPressed: null,
                            ),
                          ),
                          ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: TextFormField(
                                textCapitalization: TextCapitalization.sentences,
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Operaional Definition',
                                  labelStyle: TextStyle(fontSize: 16.0),
                                ),
                                style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  color: Colors.black87,
                                  fontSize: 16.0),
                                onSaved: null,
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.add, color: Colors.white),
                              onPressed: null,
                            ),
                          ),
                          ListTile(
                            title: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'Data Source',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              value: _dataSourceSelection,
                              onChanged: (String value) {
                                setState(() {
                                  switch (int.tryParse(value)) {
                                    case 1:
                                      _dataSource = 'Source 1';
                                      break;
                                    case 2:
                                      _dataSource = 'Source 2';
                                      break;
                                    default:
                                      _dataSource = '-';
                                      break;
                                  }
                                  _dataSourceSelection = value;
                                });
                              },
                              items: _dataSourceJson.map((Map map) {
                                return DropdownMenuItem(
                                  value: map['id'].toString(),
                                  child: Text(map['dataSource'], style: TextStyle(fontSize: 16.0, color: Colors.black87, fontStyle: FontStyle.normal)),
                                );
                              }).toList(),
                            ),
                          ),
                            trailing: ButtonTheme(
                              minWidth: 50.0,
                              height: 25.0,
                              child: RaisedButton(
                                color: AbubaPallate.menuBluebird,
                                elevation: 0.0,
                                child: Text(
                                  'Note',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.white),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _note2 = !_note2;
                                  });
                                },
                              ),
                            ),
                          ),
                          _note2
                            ? Container(
                                padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                                width: MediaQuery.of(context).size.width,
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Note',
                                    labelStyle: TextStyle(fontSize: 16.0)),
                                  maxLines: 3,
                                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                                ),
                              )
                            : Container(),
                          ListTile(
                            title: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'Data Location',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              value: _dataLocationSelection,
                              onChanged: (String value) {
                                setState(() {
                                  switch (int.tryParse(value)) {
                                    case 1:
                                      _dataLocation = 'Location 1';
                                      break;
                                    case 2:
                                      _dataLocation = 'Location 2';
                                      break;
                                    default:
                                      _dataLocation = '-';
                                      break;
                                  }
                                  _dataLocationSelection = value;
                                });
                              },
                              items: _dataLocationJson.map((Map map) {
                                return DropdownMenuItem(
                                  value: map['id'].toString(),
                                  child: Text(map['dataLocation'], style: TextStyle(fontSize: 16.0, color: Colors.black87, fontStyle: FontStyle.normal)),
                                );
                              }).toList(),
                            ),
                          ),
                            trailing: ButtonTheme(
                              minWidth: 50.0,
                              height: 25.0,
                              child: RaisedButton(
                                color: AbubaPallate.menuBluebird,
                                elevation: 0.0,
                                child: Text(
                                  'Note',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.white),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _note1 = !_note1;
                                  });
                                },
                              ),
                            ),
                          ),
                          _note1
                            ? Container(
                                padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                                width: MediaQuery.of(context).size.width,
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Note',
                                    labelStyle: TextStyle(fontSize: 16.0)),
                                  maxLines: 3,
                                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                                ),
                              )
                            : Container(),
                        ],
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        children: <Widget>[
                          PreferredSize(
                            preferredSize: Size.fromHeight(55.0),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 55.0,
                                  child: Container(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            '2. Detail Information',
                                            style: TextStyle(color: Colors.white, fontSize: 14.0),
                                            textAlign: TextAlign.start,
                                          ),
                                          Text(
                                            '3 of ${_listData.length.toString()}',
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 14.0),
                                            textAlign: TextAlign.start,
                                          ),
                                        ],
                                      ),
                                    ),
                                    decoration: BoxDecoration(color: Color(0xFF2F592F))
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Sample Size',
                                  labelStyle: TextStyle(fontSize: 16.0),
                                ),
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  color: Colors.black87,
                                  fontSize: 16.0),
                                onSaved: null,
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.add, color: Colors.white),
                              onPressed: null,
                            ),
                          ),
                          ListTile(
                            title: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'Who will collect data',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              value: _whoCollectDataSelection,
                              onChanged: (String value) {
                                setState(() {
                                  switch (int.tryParse(value)) {
                                    case 1:
                                      _whoCollectData = 'Ridwan';
                                      break;
                                    case 2:
                                      _whoCollectData = 'Sony';
                                      break;
                                    default:
                                      _whoCollectData = '-';
                                      break;
                                  }
                                  _whoCollectDataSelection = value;
                                });
                              },
                              items: _whoCollectDataJson.map((Map map) {
                                return DropdownMenuItem(
                                  value: map['id'].toString(),
                                  child: Text(map['whoCollectData'], style: TextStyle(fontSize: 16.0, color: Colors.black87, fontStyle: FontStyle.normal)),
                                );
                              }).toList(),
                            ),
                          ),
                            trailing: ButtonTheme(
                              minWidth: 50.0,
                              height: 25.0,
                              child: RaisedButton(
                                color: AbubaPallate.menuBluebird,
                                elevation: 0.0,
                                child: Text(
                                  'Note',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.white),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _note3 = !_note3;
                                  });
                                },
                              ),
                            ),
                          ),
                          _note3
                            ? Container(
                                padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                                width: MediaQuery.of(context).size.width,
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Note',
                                    labelStyle: TextStyle(fontSize: 16.0)),
                                  maxLines: 3,
                                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                                ),
                              )
                            : Container(),
                          ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: DateTimePickerFormField(
                                format: dateFormat,
                                onChanged: (dt) =>
                                    setState(() => dateCollected = dt),
                                dateOnly: true,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black87,
                                ),
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelStyle: TextStyle(fontSize: 16.0),
                                  labelText: 'When will data be collected'
                                ),
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.add, color: Colors.white),
                              onPressed: null,
                            ),
                          ),
                          ListTile(
                            title: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'How will data be collected',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              value: _howDataCollectedSelection,
                              onChanged: (String value) {
                                setState(() {
                                  switch (int.tryParse(value)) {
                                    case 1:
                                      _howDataCollected = 'Daily';
                                      break;
                                    case 2:
                                      _howDataCollected = 'Weekly';
                                      break;
                                    default:
                                      _howDataCollected = '-';
                                      break;
                                  }
                                  _howDataCollectedSelection = value;
                                });
                              },
                              items: _howDataCollectedJson.map((Map map) {
                                return DropdownMenuItem(
                                  value: map['id'].toString(),
                                  child: Text(map['howDataCollected'], style: TextStyle(fontSize: 16.0, color: Colors.black87, fontStyle: FontStyle.normal)),
                                );
                              }).toList(),
                            ),
                          ),
                            trailing: ButtonTheme(
                              minWidth: 50.0,
                              height: 25.0,
                              child: RaisedButton(
                                color: AbubaPallate.menuBluebird,
                                elevation: 0.0,
                                child: Text(
                                  'Note',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.white),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _note4 = !_note4;
                                  });
                                },
                              ),
                            ),
                          ),
                          _note4
                            ? Container(
                                padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                                width: MediaQuery.of(context).size.width,
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Note',
                                    labelStyle: TextStyle(fontSize: 16.0)),
                                  maxLines: 3,
                                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                                ),
                              )
                            : Container(),
                          ListTile(
                            title: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'How will data be used',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              value: _dataUsedSelection,
                              onChanged: (String value) {
                                setState(() {
                                  switch (int.tryParse(value)) {
                                    case 1:
                                      _dataUsed = 'Statistically';
                                      break;
                                    case 2:
                                      _dataUsed = 'Random';
                                      break;
                                    default:
                                      _dataUsed = '-';
                                      break;
                                  }
                                  _dataUsedSelection = value;
                                });
                              },
                              items: _dataUsedJson.map((Map map) {
                                return DropdownMenuItem(
                                  value: map['id'].toString(),
                                  child: Text(map['dataUsed'], style: TextStyle(fontSize: 16.0, color: Colors.black87, fontStyle: FontStyle.normal)),
                                );
                              }).toList(),
                            ),
                          ),
                            trailing: ButtonTheme(
                              minWidth: 50.0,
                              height: 25.0,
                              child: RaisedButton(
                                color: AbubaPallate.menuBluebird,
                                elevation: 0.0,
                                child: Text(
                                  'Note',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.white),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _note5 = !_note5;
                                  });
                                },
                              ),
                            ),
                          ),
                          _note5
                            ? Container(
                                padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                                width: MediaQuery.of(context).size.width,
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Note',
                                    labelStyle: TextStyle(fontSize: 16.0)),
                                  maxLines: 3,
                                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                                ),
                              )
                            : Container(),
                          ListTile(
                            title: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'Additional data to be collected',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              value: _additionalDataCollectedSelection,
                              onChanged: (String value) {
                                setState(() {
                                  switch (int.tryParse(value)) {
                                    case 1:
                                      _additionalDataCollected = 'Revenue';
                                      break;
                                    case 2:
                                      _additionalDataCollected = 'Cost Saving';
                                      break;
                                    default:
                                      _additionalDataCollected = '-';
                                      break;
                                  }
                                  _additionalDataCollectedSelection = value;
                                });
                              },
                              items: _additionalDataCollectedJson.map((Map map) {
                                return DropdownMenuItem(
                                  value: map['id'].toString(),
                                  child: Text(map['additionalDataCollected'], style: TextStyle(fontSize: 16.0, color: Colors.black87, fontStyle: FontStyle.normal)),
                                );
                              }).toList(),
                            ),
                          ),
                            trailing: ButtonTheme(
                              minWidth: 50.0,
                              height: 25.0,
                              child: RaisedButton(
                                color: AbubaPallate.menuBluebird,
                                elevation: 0.0,
                                child: Text(
                                  'Note',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.white),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _note6 = !_note6;
                                  });
                                },
                              ),
                            ),
                          ),
                          _note6
                            ? Container(
                                padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                                width: MediaQuery.of(context).size.width,
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Note',
                                    labelStyle: TextStyle(fontSize: 16.0)),
                                  maxLines: 3,
                                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                                ),
                              )
                            : Container(),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                RaisedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'SAVE',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  textColor: Colors.white,
                                  color: AbubaPallate.greenabuba,
                                )
                              ],
                            )
                          ),
                        ],
                      ),
                    ]
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _bottomBar(),
      ),
    );
  }

  Widget _bottomBar() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 55.0,
      child: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () {
                      _cardController.animateTo(_cardController.index - 1);
                    },
                    tooltip: 'Previous',
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                    onPressed: () {
                      _cardController.animateTo(_cardController.index + 1);
                    },
                    tooltip: 'Next',
                  ),
                ],
              )
            ],
          ),
        ),
        decoration: BoxDecoration(color: Color(0xFF2F592F))
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      elevation: 0.25,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      title: Image.asset(
        'assets/images/logo.png',
        height: 100.0,
        width: 120.0,
      ),
    );
  }
}