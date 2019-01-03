import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class FormCreateNew extends StatefulWidget {
  FormCreateNew({Key key}) : super(key: key);

  @override
  _FormCreateNewState createState() => _FormCreateNewState();
}

class _FormCreateNewState extends State<FormCreateNew> with SingleTickerProviderStateMixin {
  TabController _tabController;

  final List<Tab> internalAuditTabs = <Tab>[
    new Tab(child: Text('Period', style: TextStyle(color: Colors.grey[400]))),
    new Tab(child: Text('Schedule', style: TextStyle(color: Colors.grey[400]))),
    new Tab(child: Text('Team', style: TextStyle(color: Colors.grey[400]))),
    new Tab(child: Text('Preview', style: TextStyle(color: Colors.grey[400]))),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: internalAuditTabs.length);
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
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 125.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 250.0,
                        child: DateTimePickerFormField(
                          format: dateFormat,
                          onChanged: (dt) => setState(() => dateStart = dt),
                          dateOnly: true,
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelStyle: TextStyle(fontSize: 14.0),
                              labelText: 'Start'),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        child: DateTimePickerFormField(
                          format: dateFormat,
                          onChanged: (dt) => setState(() => dateEnd = dt),
                          dateOnly: true,
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelStyle: TextStyle(fontSize: 14.0),
                              labelText: 'End'),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, right: 60.0),
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
                                  _tabController.animateTo((_tabController.index + 1) % 2);
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          width: 100.0,
                          height: 35.0,
                          child: Container(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Department',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12.0),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFF2F592F),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100.0,
                          height: 35.0,
                          child: Container(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Process',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12.0),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFF2F592F),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100.0,
                          height: 35.0,
                          child: Container(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Date',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12.0),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFF2F592F),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 20.0, left: 20.0, bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 100.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'HRD',
                                  style: TextStyle(color: Colors.grey[500]),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 100.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Payroll',
                                  style: TextStyle(
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                              Radio(
                                  value: 0, groupValue: null, onChanged: null),
                            ],
                          ),
                        ),
                        Container(
                          width: 100.0,
                          child: DateTimePickerFormField(
                            format: DateFormat("d/M/yyyy"),
                            editable: false,
                            onChanged: (dt) =>
                                setState(() => dateSchedule = dt),
                            dateOnly: true,
                            style:
                                TextStyle(fontSize: 12.0, color: Colors.black),
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelStyle: TextStyle(fontSize: 12.0),
                                labelText: 'Calendar'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.green,
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 20.0, left: 20.0, bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 100.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Operation',
                                  style: TextStyle(color: Colors.grey[500]),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 100.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Outlet',
                                  style: TextStyle(
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                              Radio(
                                  value: 0, groupValue: null, onChanged: null),
                            ],
                          ),
                        ),
                        Container(
                          width: 100.0,
                          child: DateTimePickerFormField(
                            format: DateFormat("d/M/yyyy"),
                            editable: false,
                            onChanged: (dt) =>
                                setState(() => dateSchedule = dt),
                            dateOnly: true,
                            style:
                                TextStyle(fontSize: 12.0, color: Colors.black),
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelStyle: TextStyle(fontSize: 12.0),
                                labelText: 'Calendar'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, right: 20.0),
                        child: ButtonTheme(
                          minWidth: 50.0,
                          height: 30.0,
                          child: OutlineButton(
                            child: Text(
                              'NEXT',
                              style:
                                  TextStyle(fontSize: 13.0, color: Colors.blue),
                            ),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 1.0),
                            highlightedBorderColor: Colors.blue,
                            onPressed: () {
                              _tabController.animateTo((_tabController.index + 1));
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
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          width: 100.0,
                          height: 35.0,
                          child: Container(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Department',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12.0),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFF2F592F),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100.0,
                          height: 35.0,
                          child: Container(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Auditee',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12.0),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFF2F592F),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100.0,
                          height: 35.0,
                          child: Container(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Auditor',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12.0),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFF2F592F),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 20.0, left: 20.0, bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 100.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'HRD',
                                  style: TextStyle(color: Colors.grey[500]),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 100.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Bryan',
                                  style: TextStyle(
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                              Radio(
                                  value: 0, groupValue: null, onChanged: null),
                            ],
                          ),
                        ),
                        Container(
                          width: 100.0,
                          child: DropdownButton<String>(
                            isDense: true,
                            hint: Text(
                              'Search',
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
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.green,
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 20.0, left: 20.0, bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 100.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'IT',
                                  style: TextStyle(color: Colors.grey[500]),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 100.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Smith',
                                  style: TextStyle(
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                              Radio(
                                  value: 0, groupValue: null, onChanged: null),
                            ],
                          ),
                        ),
                        Container(
                          width: 100.0,
                          child: DropdownButton<String>(
                            isDense: true,
                            hint: Text(
                              'Search',
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
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, right: 20.0),
                        child: ButtonTheme(
                          minWidth: 50.0,
                          height: 30.0,
                          child: OutlineButton(
                            child: Text(
                              'SAVE',
                              style: TextStyle(
                                  fontSize: 13.0, color: Colors.green),
                            ),
                            borderSide:
                                BorderSide(color: Colors.green, width: 1.0),
                            highlightedBorderColor: Colors.green,
                            onPressed: () {},
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
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          width: 100.0,
                          height: 35.0,
                          child: Container(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Process',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12.0),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFF2F592F),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100.0,
                          height: 35.0,
                          child: Container(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Auditee',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12.0),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFF2F592F),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100.0,
                          height: 35.0,
                          child: Container(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Auditor',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12.0),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFF2F592F),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 20.0, left: 20.0, bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'HRD',
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 20.0, left: 20.0, bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 100.0,
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Payroll',
                                  style: TextStyle(color: Colors.grey[500]),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 100.0,
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Bryan',
                                  style: TextStyle(color: Colors.green),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 100.0,
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Ridwan',
                                  style: TextStyle(color: Colors.green),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 20.0, left: 20.0, bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 100.0,
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  '17/09/2019',
                                  style: TextStyle(color: Colors.grey[400]),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 100.0,
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  '',
                                  style: TextStyle(color: Colors.grey[400]),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 100.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Kamil',
                                  style: TextStyle(
                                    color: Colors.green,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 20.0, left: 20.0, bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 100.0,
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Training',
                                  style: TextStyle(color: Colors.grey[500]),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 100.0,
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Yani',
                                  style: TextStyle(color: Colors.green),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 100.0,
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Gilbert',
                                  style: TextStyle(color: Colors.green),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 20.0, left: 20.0, bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 100.0,
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  '17/09/2019',
                                  style: TextStyle(color: Colors.grey[400]),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 100.0,
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  '',
                                  style: TextStyle(color: Colors.grey[400]),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 100.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Toshiba',
                                  style: TextStyle(
                                    color: Colors.green,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    height: 15.0,
                    color: AbubaPallate.green,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 20.0, left: 20.0, bottom: 10.0, top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Operation',
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 20.0, left: 20.0, bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 100.0,
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Outlet',
                                  style: TextStyle(color: Colors.grey[500]),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 100.0,
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Yaser',
                                  style: TextStyle(color: Colors.green),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 100.0,
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Ridwan',
                                  style: TextStyle(color: Colors.green),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 20.0, left: 20.0, bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 100.0,
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  '17/09/2019',
                                  style: TextStyle(color: Colors.grey[400]),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 100.0,
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  '',
                                  style: TextStyle(color: Colors.grey[400]),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 100.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Sony',
                                  style: TextStyle(
                                    color: Colors.green,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, right: 20.0),
                        child: ButtonTheme(
                          minWidth: 50.0,
                          height: 30.0,
                          child: OutlineButton(
                            child: Text(
                              'SUBMIT',
                              style: TextStyle(
                                  fontSize: 13.0, color: Colors.green),
                            ),
                            borderSide:
                                BorderSide(color: Colors.green, width: 1.0),
                            highlightedBorderColor: Colors.green,
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: new Text("Success",
                                        style: TextStyle(color: Colors.green)),
                                    content: new Text(
                                        "Jadwal Audit sudah terkirim ke Auditee dan  Auditor. \n\nUntuk Mengetahui status jadwal audit yang Anda buat, klik disini",
                                        style: TextStyle(fontSize: 13.0)),
                                    actions: <Widget>[
                                      new FlatButton(
                                        child: new Text(
                                          'OK',
                                          style: TextStyle(color: Colors.green),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
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
    );
  }
}
