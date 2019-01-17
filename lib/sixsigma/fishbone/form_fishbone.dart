import 'package:datetime_picker_formfield/time_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/sixsigma/fishbone/fishbone_material.dart';
import 'package:intl/intl.dart';

class FormFishbone extends StatefulWidget {
  @override
  _FormFishboneState createState() => _FormFishboneState();
}

class _FormFishboneState extends State<FormFishbone> with TickerProviderStateMixin {
  bool _noteWhat = false;
  TextEditingController _controllerNoteWhat = new TextEditingController();
  
  bool _noteWhen = false;
  TextEditingController _controllerNoteWhen = new TextEditingController();

  bool _noteWhere = false;
  TextEditingController _controllerNoteWhere = new TextEditingController();

  bool _noteWhy = false;
  TextEditingController _controllerNoteWhy = new TextEditingController();

  bool _noteHowServe = false;
  TextEditingController _controllerNoteHowServe = new TextEditingController();

  String _whatSelection;
  String _what;
  List<Map> _whatJson = [
    {"id": 1, "what": "Customer Complain"},
    {"id": 2, "what": "Alat Rusak"},
    {"id": 3, "what": "Disiplin Karyawan"},
  ];

  String _whoSelection;
  String _who;
  List<Map> _whoJson = [
    {"id": 1, "who": "Robert - Cashier"},
    {"id": 2, "who": "Susan - Cashier"},
    {"id": 3, "who": "Alberto - Cashier"},
  ];

  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime dateWhen;
  final timeFormat = DateFormat("h:mm a");
  TimeOfDay timeWhen;

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

  String _whySelection;
  String _why;
  List<Map> _whyJson = [
    {"id": 1, "why": "Loss Revenue"},
    {"id": 2, "why": "High Turnover"},
  ];

  Color _colorLowSe = Colors.grey;
  Color _colorMedSe = Colors.grey;
  Color _colorHighSe = Colors.grey;

  TabController _cardController;
  TabPageSelector _tabPageSelector;

  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    _cardController = new TabController(vsync: this, length: 8);
    _tabPageSelector = new TabPageSelector(controller: _cardController);
  }

  @override
  void dispose() {
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Step> steps = [
      Step(
        title: Text('Material'),
        isActive: true,
        state: StepState.indexed,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Text(
                'Material',
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ),
            ButtonTheme(
              minWidth: 50.0,
              height: 35.0,
              child: RaisedButton(
                color: Colors.white,
                child: Text(
                  'Detail',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: AbubaPallate.greenabuba
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) => FishBone()
                    )
                  );
                },
              ),
            ),
          ],
        )
      ),
      Step(
        title: Text('Method'),
        isActive: true,
        state: StepState.indexed,
        content: Row(
          children: <Widget>[
            Flexible(
              child: Text(
                'Method',
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            )
          ],
        )
      ),
      Step(
        title: Text('Machine'),
        isActive: true,
        state: StepState.indexed,
        content: Row(
          children: <Widget>[
            Flexible(
              child: Text(
                'Machine',
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            )
          ],
        )
      ),
      Step(
        title: Text('Measurement'),
        isActive: true,
        state: StepState.indexed,
        content: Row(
          children: <Widget>[
            Flexible(
              child: Text(
                'Measurement',
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            )
          ],
        )
      ),
      Step(
        title: Text('Man'),
        isActive: true,
        state: StepState.indexed,
        content: Row(
          children: <Widget>[
            Flexible(
              child: Text(
                'Man',
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            )
          ],
        )
      ),
      Step(
        title: Text('Environment'),
        isActive: true,
        state: StepState.indexed,
        content: Row(
          children: <Widget>[
            Flexible(
              child: Text(
                'Environment',
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            )
          ],
        )
      ),
    ];

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
                                Column(
                                  children: <Widget>[
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
                                                  fontSize: 24.0),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 30.0, bottom: 10.0, left: 20.0, right: 20.0),
                                      child: DropdownButtonFormField(
                                        value: _whatSelection,
                                        onChanged: (String newValue) {
                                          setState(() {
                                            switch (int.tryParse(newValue)) {
                                              case 1:
                                                _what = 'Customer Complaint';
                                                break;
                                              case 2:
                                                _what = 'Alat Rusak';
                                                break;
                                              case 3:
                                                _what = 'Disiplin Karyawan';
                                                break;
                                              default:
                                                _what = '-';
                                                break;
                                            }
                                            _whatSelection = newValue;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'What',
                                          labelStyle: TextStyle(fontSize: 14.0),
                                        ),
                                        items: _whatJson.map((Map map) {
                                          return new DropdownMenuItem(
                                            value: map['id'].toString(),
                                            child: Text(map['what']),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    Column(
                                      children: <Widget>[
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
                                                      _noteWhat = !_noteWhat;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        _noteWhat
                                          ? Container(
                                              padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                                              width: MediaQuery.of(context).size.width,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(),
                                                    hintText: 'Note',
                                                    hintStyle: TextStyle(fontSize: 12.0)),
                                                maxLines: 3,
                                                controller: _controllerNoteWhat,
                                                style: TextStyle(color: Colors.black),
                                              ),
                                            )
                                          : Container()
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        children: <Widget>[
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
                                Column(
                                  children: <Widget>[
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
                                                  fontSize: 24.0),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 30.0, bottom: 10.0, left: 20.0, right: 20.0),
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
                                          labelStyle: TextStyle(fontSize: 14.0),
                                        ),
                                        items: _whoJson.map((Map map) {
                                          return new DropdownMenuItem(
                                            value: map['id'].toString(),
                                            child: Text(map['who']),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        children: <Widget>[
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
                                Column(
                                  children: <Widget>[
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
                                                  fontSize: 24.0),
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
                                          labelStyle: TextStyle(fontSize: 14.0),
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
                                          labelStyle: TextStyle(fontSize: 14.0),
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
                                          labelStyle: TextStyle(fontSize: 14.0),
                                        ),
                                        items: _shiftJson.map((Map map) {
                                          return new DropdownMenuItem(
                                            value: map['id'].toString(),
                                            child: Text(map['shift']),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    Column(
                                      children: <Widget>[
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
                                                    hintText: 'Note',
                                                    hintStyle: TextStyle(fontSize: 12.0)),
                                                maxLines: 3,
                                                controller: _controllerNoteWhen,
                                                style: TextStyle(color: Colors.black),
                                              ),
                                            )
                                          : Container()
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        children: <Widget>[
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
                                Column(
                                  children: <Widget>[
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
                                                  fontSize: 24.0),
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
                                          labelStyle: TextStyle(fontSize: 14.0),
                                        ),
                                        items: _departmentJson.map((Map map) {
                                          return new DropdownMenuItem(
                                            value: map['id'].toString(),
                                            child: Text(map['department']),
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
                                          labelStyle: TextStyle(fontSize: 14.0),
                                        ),
                                        items: _divisiJson.map((Map map) {
                                          return new DropdownMenuItem(
                                            value: map['id'].toString(),
                                            child: Text(map['divisi']),
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
                                          labelStyle: TextStyle(fontSize: 14.0),
                                        ),
                                        items: _areaJson.map((Map map) {
                                          return new DropdownMenuItem(
                                            value: map['id'].toString(),
                                            child: Text(map['area']),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    Column(
                                      children: <Widget>[
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
                                                    hintText: 'Note',
                                                    hintStyle: TextStyle(fontSize: 12.0)),
                                                maxLines: 3,
                                                controller: _controllerNoteWhere,
                                                style: TextStyle(color: Colors.black),
                                              ),
                                            )
                                          : Container()
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        children: <Widget>[
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
                                          'WHY',
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
                                Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Flexible(
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 10.0, left: 20.0, top: 20.0, bottom: 20.0),
                                            child: Text(
                                              'Mengapa temuan / issue ini bisa menjadi masalah ? Apa konsekuensi dari masalah ini ?',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 24.0),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 30.0, bottom: 10.0, left: 20.0, right: 20.0),
                                      child: DropdownButtonFormField(
                                        value: _whySelection,
                                        onChanged: (String newValue) {
                                          setState(() {
                                            switch (int.tryParse(newValue)) {
                                              case 1:
                                                _why = 'Loss Revenue';
                                                break;
                                              case 2:
                                                _why = 'High Turnover';
                                                break;
                                              default:
                                                _why = '-';
                                                break;
                                            }
                                            _whySelection = newValue;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Why',
                                          labelStyle: TextStyle(fontSize: 14.0),
                                        ),
                                        items: _whyJson.map((Map map) {
                                          return new DropdownMenuItem(
                                            value: map['id'].toString(),
                                            child: Text(map['why']),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    Column(
                                      children: <Widget>[
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
                                                      _noteWhy = !_noteWhy;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        _noteWhy
                                          ? Container(
                                              padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                                              width: MediaQuery.of(context).size.width,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(),
                                                    hintText: 'Note',
                                                    hintStyle: TextStyle(fontSize: 12.0)),
                                                maxLines: 3,
                                                controller: _controllerNoteWhy,
                                                style: TextStyle(color: Colors.black),
                                              ),
                                            )
                                          : Container()
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        children: <Widget>[
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
                                          'HOW SEVERE',
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
                                Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Flexible(
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 10.0, left: 20.0, top: 20.0, bottom: 20.0),
                                            child: Text(
                                              'Seberapa parah akibat yang ditimbulkan dari masalah ini ?',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 24.0),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0, bottom: 10.0),
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            padding:
                                            EdgeInsets.only(top: 5.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceAround,
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
                                      )
                                    ),
                                    Column(
                                      children: <Widget>[
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
                                                      _noteHowServe = !_noteHowServe;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        _noteHowServe
                                          ? Container(
                                              padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                                              width: MediaQuery.of(context).size.width,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(),
                                                    hintText: 'Note',
                                                    hintStyle: TextStyle(fontSize: 12.0)),
                                                maxLines: 3,
                                                controller: _controllerNoteHowServe,
                                                style: TextStyle(color: Colors.black),
                                              ),
                                            )
                                          : Container()
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        children: <Widget>[
                          Container(
                            color: Colors.white,
                            alignment: Alignment.center,
                            child: Column(
                              children: <Widget>[
                                Stepper(
                                  steps: steps,
                                  type: StepperType.vertical,
                                  currentStep: this._currentStep,
                                  onStepContinue: () {
                                    setState(() {
                                      if (_currentStep < steps.length - 1) {
                                        _currentStep = _currentStep + 1;
                                      } else {
                                        _currentStep = 0;
                                      }
                                    });
                                  },
                                  onStepCancel: () {
                                    setState(() {
                                      if (_currentStep > 0) {
                                        _currentStep = _currentStep - 1;
                                      } else {
                                        _currentStep = 0;
                                      }
                                    });
                                  },
                                  onStepTapped: (step) {
                                    setState(() {
                                      _currentStep = step;
                                    });
                                  },
                                ),
                              ],
                            )
                          ),
                        ],
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        children: <Widget>[
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
                                          'HOW SEVERE',
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
                                Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Flexible(
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 10.0, left: 20.0, top: 20.0, bottom: 20.0),
                                            child: Text(
                                              'Seberapa parah akibat yang ditimbulkan dari masalah ini ?',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 24.0),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0, bottom: 10.0),
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            padding:
                                            EdgeInsets.only(top: 5.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceAround,
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
                                      )
                                    ),
                                    Column(
                                      children: <Widget>[
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
                                                      _noteHowServe = !_noteHowServe;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        _noteHowServe
                                          ? Container(
                                              padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                                              width: MediaQuery.of(context).size.width,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(),
                                                    hintText: 'Note',
                                                    hintStyle: TextStyle(fontSize: 12.0)),
                                                maxLines: 3,
                                                controller: _controllerNoteHowServe,
                                                style: TextStyle(color: Colors.black),
                                              ),
                                            )
                                          : Container()
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ]
                  ),
                ),
                // myList.isEmpty
                //   ? new Container(
                //       margin: EdgeInsets.only(bottom: 15.0),
                //       height: 17.0,
                //     )
                //   : new Container(
                //       margin: EdgeInsets.only(bottom: 15.0),
                //       height: 17.0,
                //       child: _tabPageSelector,
                //       alignment: Alignment.center,
                //     ),
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
          decoration: BoxDecoration(color: Color(0xFF2F592F))),
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
      bottom: PreferredSize(
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
                          '1. Identity Problem',
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                          textAlign: TextAlign.start,
                        ),
                        // Text(
                        //   '${_cardController.index.toString()} of 8',
                        //   style: TextStyle(
                        //       color: Colors.white, fontSize: 12.0),
                        //   textAlign: TextAlign.start,
                        // ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(color: Color(0xFF2F592F))),
            ),
          ],
        ),
      ),
    );
  }
}