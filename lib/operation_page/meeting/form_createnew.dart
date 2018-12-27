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
    new Tab(
        child: Text('General',
            style: TextStyle(color: Colors.grey[400]))),
    new Tab(
        child:
            Text('Peserta', style: TextStyle(color: Colors.grey[400]))),
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
        isScrollable: false,
        indicatorColor: AbubaPallate.greenabuba,
        tabs: internalAuditTabs,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
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
                      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(child: Text('General'))
                        ],
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
                            labelText: 'Start'),
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
                            labelText: 'End'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                      child: TextField(
                        maxLines: null,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Agenda',
                          labelStyle: TextStyle(fontSize: 12.0),
                        ),
                        textCapitalization: TextCapitalization.sentences,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: DropdownButtonFormField<String>(
                          hint: Text(
                            'Location',
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
                      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(child: Text('Peserta'))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                      child: TextField(
                        maxLines: null,
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: DropdownButton<String>(
                          isDense: true,
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: DropdownButton<String>(
                          isDense: true,
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
                                'INVITE',
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
