import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';

class FormAbsensi extends StatefulWidget {
  @override
  _FormAbsensiState createState() => _FormAbsensiState();
}

class _FormAbsensiState extends State<FormAbsensi> {
  String _mySelection;
  String _jenisAcara;
  List<Map> _jenisAcaraJson = [
    {"id": 1, "jenis": "Pernikahan"},
    {"id": 2, "jenis": "Ulang tahun"}
  ];

  TextEditingController controller = new TextEditingController();
  List<String> textList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AbubaAppBar(),
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: _buildFormMenu()),
      ),
    );
  }

  Widget _buildFormMenu() {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Log Book MOD',
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
                  'Absensi',
                  style:
                      TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalDirection: VerticalDirection.up,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Sakit',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  Container(
                    width: 150.0,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isDense: true,
                        hint: Text('Jenis Acara'),
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
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalDirection: VerticalDirection.up,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Izin',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  Container(
                    width: 150.0,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isDense: true,
                        hint: Text('Jenis Acara'),
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
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalDirection: VerticalDirection.up,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Alpha',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  Container(
                    width: 150.0,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isDense: true,
                        hint: Text('Jenis Acara'),
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
              SizedBox(
                height: 10.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalDirection: VerticalDirection.up,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Libur',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  Container(
                    width: 150.0,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isDense: true,
                        hint: Text('Jenis Acara'),
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
              SizedBox(
                height: 15.0,
              ),
              ButtonTheme(
                minWidth: 50.0,
                height: 30.0,
                child: RaisedButton(
                  child: Text(
                    'SAVE',
                    style: TextStyle(fontSize: 13.0),
                  ),
                  textColor: Colors.white,
                  color: Colors.green,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
