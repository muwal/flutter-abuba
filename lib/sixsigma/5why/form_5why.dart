import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:datetime_picker_formfield/time_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:intl/intl.dart';

class FormFiveWhy extends StatefulWidget {
  @override
  _FormFiveWhyState createState() => _FormFiveWhyState();
}

class _FormFiveWhyState extends State<FormFiveWhy> with TickerProviderStateMixin {
  List<Map> _listData = [ {'nomor': '1'}, {'nomor': '2'}, {'nomor': '3'}, {'nomor': '4'}, {'nomor': '5'}, {'nomor': '6'}];

  bool _noteWhen = false;
  TextEditingController _controllerNoteWhen = new TextEditingController();
  bool _noteWhere = false;
  TextEditingController _controllerNoteWhere = new TextEditingController();

  String _whoSelection;
  String _who;
  List<Map> _whoJson = [
    {"id": 1, "who": "Robert - Cashier"},
    {"id": 2, "who": "Susan - Cashier"},
    {"id": 3, "who": "Alberto - Cashier"},
  ];
  List<String> _whoSelected = [];

  String _pelaksanaSelection;
  String _pelaksana;
  List<Map> _pelaksanaJson = [
    {"id": 1, "pelaksana": "Robert - Cashier"},
    {"id": 2, "pelaksana": "Susan - Cashier"},
    {"id": 3, "pelaksana": "Alberto - Cashier"},
  ];
  List<String> _pelaksanaSelected = [];

  String _shiftSelection;
  String _shift;
  List<Map> _shiftJson = [
    {"id": 1, "shift": "Shift Pagi"},
    {"id": 2, "shift": "Shift Siang"},
  ];

  String _departmentSelection;
  String _department;
  List<Map> _departmentJson = [
    {"id": 1, "department": "HRD"},
    {"id": 2, "department": "Operation"},
    {"id": 3, "department": "Marketing"},
  ];

  String _divisiSelection;
  String _divisi;
  List<Map> _divisiJson = [
    {"id": 1, "divisi": "Divisi 1"},
    {"id": 2, "divisi": "Divisi 2"},
    {"id": 3, "divisi": "Divisi 3"},
  ];

  String _areaSelection;
  String _area;
  List<Map> _areaJson = [
    {"id": 1, "area": "Dapur"},
    {"id": 2, "area": "Cashier"},
    {"id": 3, "area": "Ruang VIP"},
  ];

  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime dateWhen;
  final timeFormat = DateFormat("h:mm a");
  TimeOfDay timeWhen;
  TimeOfDay timeWhy1;

  TextEditingController _controllerWhy1 = TextEditingController();
  TextEditingController _controllerWhy2 = TextEditingController();
  TextEditingController _controllerWhy3 = TextEditingController();
  TextEditingController _controllerWhy4 = TextEditingController();
  TextEditingController _controllerWhy5 = TextEditingController();
  String _textWhy1 = '';
  String _textWhy2 = '';
  String _textWhy3 = '';
  String _textWhy4 = '';
  String _textWhy5 = '';

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
                                            '1. Define The Problem',
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
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 75.0),
                            color: Colors.white,
                            alignment: Alignment.center,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Text(
                                          'WHAT',
                                          style: TextStyle(
                                            color: Color(0xFF2F592F),
                                            fontSize: 32.0,
                                            fontWeight: FontWeight.bold
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 10.0, left: 20.0, top: 20.0, bottom: 20.0),
                                        child: Text(
                                          'Apa masalah yang sedang terjadi ?',
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 24.0
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                                  child: TextFormField(
                                    textCapitalization: TextCapitalization.sentences,
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Customer Complaint',
                                      labelStyle: TextStyle(fontSize: 16.0),
                                    ),
                                    maxLines: 3,
                                    keyboardType: TextInputType.multiline,
                                    style: TextStyle(
                                      fontStyle: FontStyle.normal,
                                      color: Colors.black87,
                                      fontSize: 16.0),
                                    onSaved: null,
                                  ),
                                ),
                              ],
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
                                            '1. Define The Problem',
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
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 75.0),
                            color: Colors.white,
                            alignment: Alignment.center,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Text(
                                          'WHO',
                                          style: TextStyle(
                                            color: Color(0xFF2F592F),
                                            fontSize: 32.0,
                                            fontWeight: FontWeight.bold
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Flexible(
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 10.0, left: 20.0, top: 20.0, bottom: 20.0),
                                          child: Text(
                                            'Siapa yang terlibat dengan masalah ini ?',
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 24.0
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ListTile(
                                  title: Padding(
                                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0),
                                    child: DropdownButtonFormField(
                                      value: _whoSelection,
                                      onChanged: (String newValue) {
                                        setState(() {
                                          switch (int.tryParse(newValue)) {
                                            case 1:
                                              _who = 'Robert - Cashier';
                                              break;
                                            case 2:
                                              _who = 'Susan - Cashier';
                                              break;
                                            case 3:
                                              _who = 'Alberto - Cashier';
                                              break;
                                            default:
                                              _who = '-';
                                              break;
                                          }
                                          _whoSelection = newValue;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Who',
                                        labelStyle: TextStyle(fontSize: 16.0),
                                      ),
                                      items: _whoJson.map((Map map) {
                                        return new DropdownMenuItem(
                                          value: map['id'].toString(),
                                          child: Text(map['who'], style: TextStyle(fontSize: 16.0)),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.add, color: AbubaPallate.greenabuba),
                                    onPressed: () {
                                      setState(() {
                                        _whoSelected.add(_who);
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
                                  child: Wrap(
                                    spacing: 4.0,
                                    runSpacing: 2.0,
                                    runAlignment: WrapAlignment.start,
                                    direction: Axis.horizontal,
                                    children: _whoSelected.map((String name) => Chip(
                                      label: Text(name),
                                      onDeleted: () {
                                        setState(() {
                                          _whoSelected.remove(name);
                                        });
                                      },
                                    )).toList(),
                                  ),
                                ),
                              ],
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
                                            '1. Define The Problem',
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
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 75.0),
                            color: Colors.white,
                            alignment: Alignment.center,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Text(
                                          'WHEN',
                                          style: TextStyle(
                                            color: Color(0xFF2F592F),
                                            fontSize: 32.0,
                                            fontWeight: FontWeight.bold
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 10.0, left: 20.0, top: 20.0, bottom: 20.0),
                                        child: Text(
                                          'Kapan masalah ini terjadi ?',
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 24.0
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
                                  child: DateTimePickerFormField(
                                    format: dateFormat,
                                    onChanged: (dt) => setState(() => dateWhen = dt),
                                    dateOnly: true,
                                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelStyle: TextStyle(fontSize: 16.0),
                                      labelText: 'Calendar'
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
                                  child: TimePickerFormField(
                                    format: timeFormat,
                                    onChanged: (t) => setState(() => timeWhen = t),
                                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Jam',
                                      labelStyle: TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
                                  child: DropdownButtonFormField(
                                    value: _shiftSelection,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        switch (int.tryParse(newValue)) {
                                          case 1:
                                            _shift = 'Shift Page';
                                            break;
                                          case 2:
                                            _shift = 'Shift Siang';
                                            break;
                                          default:
                                            _shift = '-';
                                            break;
                                        }
                                        _shiftSelection = newValue;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Shift',
                                      labelStyle: TextStyle(fontSize: 16.0),
                                    ),
                                    items: _shiftJson.map((Map map) {
                                      return new DropdownMenuItem(
                                        value: map['id'].toString(),
                                        child: Text(map['shift'], style: TextStyle(fontSize: 16.0)),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(right: 20.0),
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 35.0,
                                        child: RaisedButton(
                                          color: AbubaPallate.menuBluebird,
                                          child: Text(
                                            'Note',
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.white),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _noteWhen = !_noteWhen;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                _noteWhen
                                  ? Container(
                                      padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                                      width: MediaQuery.of(context).size.width,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Note',
                                          labelStyle: TextStyle(fontSize: 16.0)),
                                        maxLines: 3,
                                        controller: _controllerNoteWhen,
                                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                                      ),
                                    )
                                  : Container()
                              ],
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
                                            '1. Define The Problem',
                                            style: TextStyle(color: Colors.white, fontSize: 14.0),
                                            textAlign: TextAlign.start,
                                          ),
                                          Text(
                                            '4 of ${_listData.length.toString()}',
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
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 75.0),
                            color: Colors.white,
                            alignment: Alignment.center,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Text(
                                          'WHERE',
                                          style: TextStyle(
                                            color: Color(0xFF2F592F),
                                            fontSize: 32.0,
                                            fontWeight: FontWeight.bold
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 10.0, left: 20.0, top: 20.0, bottom: 20.0),
                                        child: Text(
                                          'Dimana lokasi masalah ditemukan ?',
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 24.0
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
                                  child: DropdownButtonFormField(
                                    value: _departmentSelection,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        switch (int.tryParse(newValue)) {
                                          case 1:
                                            _department = 'HRD';
                                            break;
                                          case 2:
                                            _department = 'Operation';
                                            break;
                                          case 3:
                                            _department = 'Marketing';
                                            break;
                                          default:
                                            _department = '-';
                                            break;
                                        }
                                        _departmentSelection = newValue;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Department',
                                      labelStyle: TextStyle(fontSize: 16.0),
                                    ),
                                    items: _departmentJson.map((Map map) {
                                      return new DropdownMenuItem(
                                        value: map['id'].toString(),
                                        child: Text(map['department'], style: TextStyle(fontSize: 16.0)),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
                                  child: DropdownButtonFormField(
                                    value: _divisiSelection,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        switch (int.tryParse(newValue)) {
                                          case 1:
                                            _divisi = 'Divisi 1';
                                            break;
                                          case 2:
                                            _divisi = 'Divisi 2';
                                            break;
                                          case 3:
                                            _divisi = 'Divisi 3';
                                            break;
                                          default:
                                            _divisi = '-';
                                            break;
                                        }
                                        _divisiSelection = newValue;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Divisi',
                                      labelStyle: TextStyle(fontSize: 16.0),
                                    ),
                                    items: _divisiJson.map((Map map) {
                                      return new DropdownMenuItem(
                                        value: map['id'].toString(),
                                        child: Text(map['divisi'], style: TextStyle(fontSize: 16.0)),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
                                  child: DropdownButtonFormField(
                                    value: _areaSelection,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        switch (int.tryParse(newValue)) {
                                          case 1:
                                            _area = 'Dapur';
                                            break;
                                          case 2:
                                            _area = 'Cashier';
                                            break;
                                          case 3:
                                            _area = 'Ruang VIP';
                                            break;
                                          default:
                                            _area = '-';
                                            break;
                                        }
                                        _areaSelection = newValue;
                                      });
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Area',
                                      labelStyle: TextStyle(fontSize: 16.0),
                                    ),
                                    items: _areaJson.map((Map map) {
                                      return new DropdownMenuItem(
                                        value: map['id'].toString(),
                                        child: Text(map['area'], style: TextStyle(fontSize: 16.0)),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(right: 20.0),
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 35.0,
                                        child: RaisedButton(
                                          color: AbubaPallate.menuBluebird,
                                          child: Text(
                                            'Note',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.white),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _noteWhere = !_noteWhere;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                _noteWhere
                                  ? Container(
                                      padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                                      width: MediaQuery.of(context).size.width,
                                      child: TextField(
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Note',
                                            labelStyle: TextStyle(fontSize: 16.0)),
                                        maxLines: 3,
                                        controller: _controllerNoteWhere,
                                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                                      ),
                                    )
                                  : Container()
                              ],
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
                                            '2. Primary Cause',
                                            style: TextStyle(color: Colors.white, fontSize: 14.0),
                                            textAlign: TextAlign.start,
                                          ),
                                          Text(
                                            '5 of ${_listData.length.toString()}',
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
                            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'WHY 1 - Mengapa hal tersebut bisa terjadi ?',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              maxLines: 3,
                              keyboardType: TextInputType.multiline,
                              controller: _controllerWhy1,
                              onEditingComplete: () {
                                setState(() {
                                  _textWhy1 = _controllerWhy1.text;
                                });
                              },
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                color: Colors.black87,
                                fontSize: 16.0),
                              onSaved: null,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'WHY 2 - Mengapa begitu ?',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              maxLines: 3,
                              keyboardType: TextInputType.multiline,
                              controller: _controllerWhy2,
                              onEditingComplete: () {
                                setState(() {
                                  _textWhy1 = _controllerWhy2.text;
                                });
                              },
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                color: Colors.black87,
                                fontSize: 16.0),
                              onSaved: null,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'WHY 3 - Mengapa begitu ?',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              maxLines: 3,
                              keyboardType: TextInputType.multiline,
                              controller: _controllerWhy3,
                              onEditingComplete: () {
                                setState(() {
                                  _textWhy1 = _controllerWhy3.text;
                                });
                              },
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                color: Colors.black87,
                                fontSize: 16.0),
                              onSaved: null,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'WHY 4 - Mengapa begitu ?',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              maxLines: 3,
                              keyboardType: TextInputType.multiline,
                              controller: _controllerWhy4,
                              onEditingComplete: () {
                                setState(() {
                                  _textWhy1 = _controllerWhy4.text;
                                });
                              },
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                color: Colors.black87,
                                fontSize: 16.0),
                              onSaved: null,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'WHY 5 - Mengapa begitu ?',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              maxLines: 3,
                              keyboardType: TextInputType.multiline,
                              controller: _controllerWhy5,
                              onEditingComplete: () {
                                setState(() {
                                  _textWhy1 = _controllerWhy5.text;
                                });
                              },
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                color: Colors.black87,
                                fontSize: 16.0),
                              onSaved: null,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0, bottom: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                RaisedButton(
                                  onPressed: () {
                                    setState(() {
                                      _textWhy1 = _controllerWhy1.text;
                                      _textWhy2 = _controllerWhy2.text;
                                      _textWhy3 = _controllerWhy3.text;
                                      _textWhy4 = _controllerWhy4.text;
                                      _textWhy5 = _controllerWhy5.text;
                                    });
                                    _cardController.animateTo(_cardController.index + 1);
                                  },
                                  child: Text(
                                    'CONFIRM',
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
                                            '3. Corrective Action',
                                            style: TextStyle(color: Colors.white, fontSize: 14.0),
                                            textAlign: TextAlign.start,
                                          ),
                                          Text(
                                            '6 of ${_listData.length.toString()}',
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
                          Container(
                            color: Colors.white,
                            child: ExpansionTile(
                              title: Text(
                                'WHY 1',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
                                  child: Text(
                                    _textWhy1.isEmpty ? 'Keterangan Why 1' : _textWhy1,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black38
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                  child: TextFormField(
                                    textCapitalization: TextCapitalization.sentences,
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Tindakan Perbaikan',
                                      labelStyle: TextStyle(fontSize: 16.0),
                                    ),
                                    maxLines: 3,
                                    keyboardType: TextInputType.multiline,
                                    style: TextStyle(
                                      fontStyle: FontStyle.normal,
                                      color: Colors.black87,
                                      fontSize: 16.0),
                                    onSaved: null,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 15.0, left: 15.0, right: 15.0),
                                  child: TimePickerFormField(
                                    format: timeFormat,
                                    onChanged: (t) => setState(() => timeWhy1 = t),
                                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Waktu',
                                      labelStyle: TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  title: Padding(
                                    padding: EdgeInsets.only(bottom: 10.0),
                                    child: DropdownButtonFormField(
                                      value: _pelaksanaSelection,
                                      onChanged: (String newValue) {
                                        setState(() {
                                          switch (int.tryParse(newValue)) {
                                            case 1:
                                              _pelaksana = 'Robert - Cashier';
                                              break;
                                            case 2:
                                              _pelaksana = 'Susan - Cashier';
                                              break;
                                            case 3:
                                              _pelaksana = 'Alberto - Cashier';
                                              break;
                                            default:
                                              _pelaksana = '-';
                                              break;
                                          }
                                          _pelaksanaSelection = newValue;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Pelaksana',
                                        labelStyle: TextStyle(fontSize: 16.0),
                                      ),
                                      items: _pelaksanaJson.map((Map map) {
                                        return new DropdownMenuItem(
                                          value: map['id'].toString(),
                                          child: Text(map['pelaksana'], style: TextStyle(fontSize: 16.0)),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.add, color: AbubaPallate.greenabuba),
                                    onPressed: () {
                                      setState(() {
                                        _pelaksanaSelected.add(_pelaksana);
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
                                  child: Wrap(
                                    spacing: 4.0,
                                    runSpacing: 2.0,
                                    runAlignment: WrapAlignment.start,
                                    direction: Axis.horizontal,
                                    children: _pelaksanaSelected.map((String name) => Chip(
                                      label: Text(name),
                                      onDeleted: () {
                                        setState(() {
                                          _pelaksanaSelected.remove(name);
                                        });
                                      },
                                    )).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            child: ExpansionTile(
                              title: Text(
                                'WHY 2',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
                                  child: Text(
                                    _textWhy2.isEmpty ? 'Keterangan Why 2' : _textWhy2,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black38
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                  child: TextFormField(
                                    textCapitalization: TextCapitalization.sentences,
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Tindakan Perbaikan',
                                      labelStyle: TextStyle(fontSize: 16.0),
                                    ),
                                    maxLines: 3,
                                    keyboardType: TextInputType.multiline,
                                    style: TextStyle(
                                      fontStyle: FontStyle.normal,
                                      color: Colors.black87,
                                      fontSize: 16.0),
                                    onSaved: null,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 15.0, left: 15.0, right: 15.0),
                                  child: TimePickerFormField(
                                    format: timeFormat,
                                    onChanged: (t) => setState(() => timeWhy1 = t),
                                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Waktu',
                                      labelStyle: TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  title: Padding(
                                    padding: EdgeInsets.only(bottom: 10.0),
                                    child: DropdownButtonFormField(
                                      value: _pelaksanaSelection,
                                      onChanged: (String newValue) {
                                        setState(() {
                                          switch (int.tryParse(newValue)) {
                                            case 1:
                                              _pelaksana = 'Robert - Cashier';
                                              break;
                                            case 2:
                                              _pelaksana = 'Susan - Cashier';
                                              break;
                                            case 3:
                                              _pelaksana = 'Alberto - Cashier';
                                              break;
                                            default:
                                              _pelaksana = '-';
                                              break;
                                          }
                                          _pelaksanaSelection = newValue;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Pelaksana',
                                        labelStyle: TextStyle(fontSize: 16.0),
                                      ),
                                      items: _pelaksanaJson.map((Map map) {
                                        return new DropdownMenuItem(
                                          value: map['id'].toString(),
                                          child: Text(map['pelaksana'], style: TextStyle(fontSize: 16.0)),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.add, color: AbubaPallate.greenabuba),
                                    onPressed: () {
                                      setState(() {
                                        _pelaksanaSelected.add(_pelaksana);
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
                                  child: Wrap(
                                    spacing: 4.0,
                                    runSpacing: 2.0,
                                    runAlignment: WrapAlignment.start,
                                    direction: Axis.horizontal,
                                    children: _pelaksanaSelected.map((String name) => Chip(
                                      label: Text(name),
                                      onDeleted: () {
                                        setState(() {
                                          _pelaksanaSelected.remove(name);
                                        });
                                      },
                                    )).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            child: ExpansionTile(
                              title: Text(
                                'WHY 3',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
                                  child: Text(
                                    _textWhy3.isEmpty ? 'Keterangan Why 3' : _textWhy3,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black38
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                  child: TextFormField(
                                    textCapitalization: TextCapitalization.sentences,
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Tindakan Perbaikan',
                                      labelStyle: TextStyle(fontSize: 16.0),
                                    ),
                                    maxLines: 3,
                                    keyboardType: TextInputType.multiline,
                                    style: TextStyle(
                                      fontStyle: FontStyle.normal,
                                      color: Colors.black87,
                                      fontSize: 16.0),
                                    onSaved: null,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 15.0, left: 15.0, right: 15.0),
                                  child: TimePickerFormField(
                                    format: timeFormat,
                                    onChanged: (t) => setState(() => timeWhy1 = t),
                                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Waktu',
                                      labelStyle: TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  title: Padding(
                                    padding: EdgeInsets.only(bottom: 10.0),
                                    child: DropdownButtonFormField(
                                      value: _pelaksanaSelection,
                                      onChanged: (String newValue) {
                                        setState(() {
                                          switch (int.tryParse(newValue)) {
                                            case 1:
                                              _pelaksana = 'Robert - Cashier';
                                              break;
                                            case 2:
                                              _pelaksana = 'Susan - Cashier';
                                              break;
                                            case 3:
                                              _pelaksana = 'Alberto - Cashier';
                                              break;
                                            default:
                                              _pelaksana = '-';
                                              break;
                                          }
                                          _pelaksanaSelection = newValue;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Pelaksana',
                                        labelStyle: TextStyle(fontSize: 16.0),
                                      ),
                                      items: _pelaksanaJson.map((Map map) {
                                        return new DropdownMenuItem(
                                          value: map['id'].toString(),
                                          child: Text(map['pelaksana'], style: TextStyle(fontSize: 16.0)),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.add, color: AbubaPallate.greenabuba),
                                    onPressed: () {
                                      setState(() {
                                        _pelaksanaSelected.add(_pelaksana);
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
                                  child: Wrap(
                                    spacing: 4.0,
                                    runSpacing: 2.0,
                                    runAlignment: WrapAlignment.start,
                                    direction: Axis.horizontal,
                                    children: _pelaksanaSelected.map((String name) => Chip(
                                      label: Text(name),
                                      onDeleted: () {
                                        setState(() {
                                          _pelaksanaSelected.remove(name);
                                        });
                                      },
                                    )).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            child: ExpansionTile(
                              title: Text(
                                'WHY 4',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
                                  child: Text(
                                    _textWhy4.isEmpty ? 'Keterangan Why 4' : _textWhy4,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black38
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                  child: TextFormField(
                                    textCapitalization: TextCapitalization.sentences,
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Tindakan Perbaikan',
                                      labelStyle: TextStyle(fontSize: 16.0),
                                    ),
                                    maxLines: 3,
                                    keyboardType: TextInputType.multiline,
                                    style: TextStyle(
                                      fontStyle: FontStyle.normal,
                                      color: Colors.black87,
                                      fontSize: 16.0),
                                    onSaved: null,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 15.0, left: 15.0, right: 15.0),
                                  child: TimePickerFormField(
                                    format: timeFormat,
                                    onChanged: (t) => setState(() => timeWhy1 = t),
                                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Waktu',
                                      labelStyle: TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  title: Padding(
                                    padding: EdgeInsets.only(bottom: 10.0),
                                    child: DropdownButtonFormField(
                                      value: _pelaksanaSelection,
                                      onChanged: (String newValue) {
                                        setState(() {
                                          switch (int.tryParse(newValue)) {
                                            case 1:
                                              _pelaksana = 'Robert - Cashier';
                                              break;
                                            case 2:
                                              _pelaksana = 'Susan - Cashier';
                                              break;
                                            case 3:
                                              _pelaksana = 'Alberto - Cashier';
                                              break;
                                            default:
                                              _pelaksana = '-';
                                              break;
                                          }
                                          _pelaksanaSelection = newValue;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Pelaksana',
                                        labelStyle: TextStyle(fontSize: 16.0),
                                      ),
                                      items: _pelaksanaJson.map((Map map) {
                                        return new DropdownMenuItem(
                                          value: map['id'].toString(),
                                          child: Text(map['pelaksana'], style: TextStyle(fontSize: 16.0)),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.add, color: AbubaPallate.greenabuba),
                                    onPressed: () {
                                      setState(() {
                                        _pelaksanaSelected.add(_pelaksana);
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
                                  child: Wrap(
                                    spacing: 4.0,
                                    runSpacing: 2.0,
                                    runAlignment: WrapAlignment.start,
                                    direction: Axis.horizontal,
                                    children: _pelaksanaSelected.map((String name) => Chip(
                                      label: Text(name),
                                      onDeleted: () {
                                        setState(() {
                                          _pelaksanaSelected.remove(name);
                                        });
                                      },
                                    )).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            child: ExpansionTile(
                              title: Text(
                                'WHY 5',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
                                  child: Text(
                                    _textWhy5.isEmpty ? 'Keterangan Why 5' : _textWhy5,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black38
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                  child: TextFormField(
                                    textCapitalization: TextCapitalization.sentences,
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Tindakan Perbaikan',
                                      labelStyle: TextStyle(fontSize: 16.0),
                                    ),
                                    maxLines: 3,
                                    keyboardType: TextInputType.multiline,
                                    style: TextStyle(
                                      fontStyle: FontStyle.normal,
                                      color: Colors.black87,
                                      fontSize: 16.0),
                                    onSaved: null,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 15.0, left: 15.0, right: 15.0),
                                  child: TimePickerFormField(
                                    format: timeFormat,
                                    onChanged: (t) => setState(() => timeWhy1 = t),
                                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Waktu',
                                      labelStyle: TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  title: Padding(
                                    padding: EdgeInsets.only(bottom: 10.0),
                                    child: DropdownButtonFormField(
                                      value: _pelaksanaSelection,
                                      onChanged: (String newValue) {
                                        setState(() {
                                          switch (int.tryParse(newValue)) {
                                            case 1:
                                              _pelaksana = 'Robert - Cashier';
                                              break;
                                            case 2:
                                              _pelaksana = 'Susan - Cashier';
                                              break;
                                            case 3:
                                              _pelaksana = 'Alberto - Cashier';
                                              break;
                                            default:
                                              _pelaksana = '-';
                                              break;
                                          }
                                          _pelaksanaSelection = newValue;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Pelaksana',
                                        labelStyle: TextStyle(fontSize: 16.0),
                                      ),
                                      items: _pelaksanaJson.map((Map map) {
                                        return new DropdownMenuItem(
                                          value: map['id'].toString(),
                                          child: Text(map['pelaksana'], style: TextStyle(fontSize: 16.0)),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.add, color: AbubaPallate.greenabuba),
                                    onPressed: () {
                                      setState(() {
                                        _pelaksanaSelected.add(_pelaksana);
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
                                  child: Wrap(
                                    spacing: 4.0,
                                    runSpacing: 2.0,
                                    runAlignment: WrapAlignment.start,
                                    direction: Axis.horizontal,
                                    children: _pelaksanaSelected.map((String name) => Chip(
                                      label: Text(name),
                                      onDeleted: () {
                                        setState(() {
                                          _pelaksanaSelected.remove(name);
                                        });
                                      },
                                    )).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0, bottom: 20.0),
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