import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter/cupertino.dart';
import 'detail_perbaikan.dart';

class FormPerbaikan extends StatefulWidget {
  FormPerbaikan({Key key}) : super(key: key);

  _FormPerbaikanState createState() => _FormPerbaikanState();
}

class _FormPerbaikanState extends State<FormPerbaikan> {
  bool _note = false;

  TextEditingController controllerNoteSatu = new TextEditingController();

  String _mySelection;
  String _mySelectionDua;
  String _mySelectionTiga;
  String _jenisAcara;
  List<Map> _jenisAcaraJson = [
    {"id": 1, "jenis": "Hardware"},
    {"id": 2, "jenis": "Software"}
  ];

  List<Map> _lokasiJson = [
    {"id": 1, "jenis": "Lokasi A"},
    {"id": 2, "jenis": "Lokasi B"}
  ];

  List<Map> _itemJson = [
    {"id": 1, "jenis": "Item A"},
    {"id": 2, "jenis": "Item B"}
  ];

  void _showDialogChiller() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("# 001"),
          content: Container(
            height: 100.0,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Flexible(child: Text('Terima Kasih !!')),
                  ],
                ),
                SizedBox(height: 5.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                        child: Text(
                      'Permintaan perbaikan sudah diterima oleh system IT.',
                      style: TextStyle(color: Colors.grey, fontSize: 13.0),
                    )),
                  ],
                ),
                SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                        child: Text(
                          'Akan segera di follow up dalam waktu maximal 1x24 jam',
                          style: TextStyle(color: Colors.grey, fontSize: 13.0),
                        )),
                  ],
                ),
              ],
            ),
          ),
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
              children: <Widget>[
                _buildStatusForm(),
                _buildCreateForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusForm() {
    return ListView(
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
                            '# Perbaikan',
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.0),
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
                            'Tanggal',
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.0),
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
                            'Item',
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.0),
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
        GestureDetector(
          onTap: () => Navigator.push(
              context, MyCustomRoute(builder: (context) => DetailPerbaikan())),
          child: Padding(
            padding:
                const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 100.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Icon(
                        Icons.remove_circle,
                        color: Colors.grey,
                      ),
                      Flexible(
                        child: Text(
                          '001',
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
                          '18/09/2018',
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
                          'Lenovo',
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 15.0,
        ),
      ],
    );
  }

  Widget _buildCreateForm() {
    return Scrollbar(
      child: ListView(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                    child: Text(
                      'Item',
                      style: TextStyle(
                          fontSize: 16.0,
                          color: AbubaPallate.greenabuba,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Category',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w100),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isDense: true,
                              hint: Text('Hardware'),
                              value: _mySelection,
                              onChanged: (String newValue) {
                                setState(() {
                                  switch (int.tryParse(newValue)) {
                                    case 1:
                                      _jenisAcara = 'Har';
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
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  verticalDirection: VerticalDirection.up,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 6.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Lokasi',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w100),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isDense: true,
                              hint: Text('Lokasi'),
                              value: _mySelectionDua,
                              onChanged: (String newValue) {
                                setState(() {
                                  switch (int.tryParse(newValue)) {
                                    case 1:
                                      _jenisAcara = 'Har';
                                      break;
                                    case 2:
                                      _jenisAcara = 'Ulang tahun';
                                      break;
                                    default:
                                      _jenisAcara = '-';
                                      break;
                                  }
                                  _mySelectionDua = newValue;
                                });
                              },
                              items: _lokasiJson.map((Map map) {
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
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  verticalDirection: VerticalDirection.up,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 6.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Item',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w100),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isDense: true,
                              hint: Text('Item'),
                              value: _mySelectionTiga,
                              onChanged: (String newValue) {
                                setState(() {
                                  switch (int.tryParse(newValue)) {
                                    case 1:
                                      _jenisAcara = 'Har';
                                      break;
                                    case 2:
                                      _jenisAcara = 'Ulang tahun';
                                      break;
                                    default:
                                      _jenisAcara = '-';
                                      break;
                                  }
                                  _mySelectionTiga = newValue;
                                });
                              },
                              items: _itemJson.map((Map map) {
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
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  verticalDirection: VerticalDirection.up,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'No. Identitas',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w100),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
                      width: 150.0,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        /*decoration: InputDecoration(
                      hintText: 'Rp', hintStyle: TextStyle(fontSize: 12.0)),*/
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                    child: Text(
                      'Masalah',
                      style: TextStyle(
                          fontSize: 16.0,
                          color: AbubaPallate.greenabuba,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(6.0, 12.0, 12.0, 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 150.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Radio(value: 0, groupValue: null, onChanged: null),
                            Flexible(
                              child: Text(
                                'Virus',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w100),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ButtonTheme(
                        minWidth: 30.0,
                        height: 25.0,
                        child: RaisedButton(
                          color: AbubaPallate.menuBluebird,
                          child: Text(
                            'Detail',
                            style:
                                TextStyle(fontSize: 12.0, color: Colors.white),
                          ),
                          onPressed: () {
                            setState(() {
                              _note = !_note;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(6.0, 0.0, 6.0, 6.0),
                  child: _note
                      ? Container(
                          width: 330.0,
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            controller: controllerNoteSatu,
                            maxLines: 3,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        )
                      : Container(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ButtonTheme(
                        minWidth: 30.0,
                        height: 25.0,
                        child: OutlineButton(
                          color: AbubaPallate.greenabuba,
                          child: Text(
                            'Submit',
                            style: TextStyle(
                                fontSize: 12.0, color: AbubaPallate.greenabuba),
                          ),
                          onPressed: () {
                            _showDialogChiller();
                          },
                          borderSide:
                              BorderSide(color: AbubaPallate.greenabuba),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
      isScrollable: false,
      indicatorColor: AbubaPallate.greenabuba,
      tabs: <Widget>[
        new Tab(
          child: Text(
            'Status',
            style: TextStyle(color: Colors.grey[400]),
          ),
        ), // 1st Tab
        new Tab(
          child: Text(
            'Create New',
            style: TextStyle(color: Colors.grey[400]),
          ),
        ), // 1st Tab
      ],
    ),
  );
}
