import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:intl/intl.dart';

class ManagementCreate extends StatefulWidget {
  ManagementCreate({Key key}) : super(key: key);

  _ManagementCreateState createState() => _ManagementCreateState();
}

class _ManagementCreateState extends State<ManagementCreate> {
  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime tglImplementasi;

  String _selectionKatergori;
  String _kategori;
  List<Map> _kategoriJSON = [
    {"id":1, "kategori":"Food Safety"},
    {"id":2, "kategori":"Quality"},
    {"id":3, "kategori":"Safety"},
    {"id":4, "kategori":"Lingkungan"},
    {"id":5, "kategori":"Formula"},
  ];

  String _selectionPIC;
  String _pic;
  List<Map> _picJSON = [
    {"id":1, "pic":"Ironman"},
    {"id":2, "pic":"Spiderman"},
  ];

  String _selectionVerifikator;
  String _verifikator;
  List<Map> _verifikatorJSON = [
    {"id":1, "verifikator":"Hulk"},
    {"id":2, "verifikator":"Thor"},
  ];

  Color _colorLowSe = Colors.grey;
  Color _colorMedSe = Colors.grey;
  Color _colorHighSe = Colors.grey;

  List<Map> myList = [
    {"nomor":1},
    {"nomor":2},
    {"nomor":3},
    {"nomor":4},
    {"nomor":5},
  ];

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.25,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Image.asset(
            'assets/images/logo2.png',
            height: 150.0,
            width: 120.0,
          ),
        ),
        body: _buildFormRisk(width)
      ),
    );
  }

  Widget _buildFormRisk(double width) {
    return Scrollbar(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Change Management',
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
                    'Create',
                    style:
                        TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
            child: Column(
              mainAxisAlignment:
              MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  padding:
                  EdgeInsets.only(bottom: 10.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Change #',
                    style: TextStyle(
                        color: Colors.black54),
                    textAlign: TextAlign.start,
                  ),
                ),
                Stack(
                  alignment: AlignmentDirectional
                      .centerStart,
                  children: <Widget>[
                    Container(
                      color: Colors.grey[400],
                      height: 40.0,
                    ),
                    Container(
                      child: Text(
                        '012345',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16.0),
                      ),
                      alignment: Alignment.center,
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
            child: DateTimePickerFormField(
              format: dateFormat,
              onChanged: (dt) => setState(() => tglImplementasi = dt),
              dateOnly: true,
              style: TextStyle(fontSize: 16.0, color: Colors.black),
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelStyle: TextStyle(fontSize: 14.0),
                labelText: 'Tanggal Implementasi Perubahan'
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Prioritas',
                    style: TextStyle(
                        color: Colors.black54),
                    textAlign: TextAlign.start,
                  ),
                ),
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
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Kategori Perubahan',
                labelStyle: TextStyle(fontSize: 14.0),
              ),
              value: _selectionKatergori,
              onChanged: (String value) {
                setState(() {
                  switch (int.tryParse(value)) {
                    case 1:
                      _kategori = 'Food Safety';
                      break;
                    case 2:
                      _kategori = 'Quality';
                      break;
                    case 3:
                      _kategori = 'Safety';
                      break;
                    case 4:
                      _kategori = 'Lingkungan';
                      break;
                    case 5:
                      _kategori = 'Formula';
                      break;
                    default:
                      _kategori = '-';
                      break;
                  }
                  _selectionKatergori = value;
                });
              },
              items: _kategoriJSON.map((Map map) {
                return DropdownMenuItem(
                  value: map['id'].toString(),
                  child: Text(map['kategori']),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
            child: TextFormField(
              maxLines: 3,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Alasan Perubahan',
                labelStyle: TextStyle(fontSize: 14.0),
              ),
              style: TextStyle(
                fontStyle: FontStyle.normal,
                color: Colors.black87,
                fontSize: 14.0
              ),
              onSaved: null,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
            child: TextFormField(
              maxLines: 3,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Deskripsi Perubahan',
                labelStyle: TextStyle(fontSize: 14.0),
              ),
              style: TextStyle(
                fontStyle: FontStyle.normal,
                color: Colors.black87,
                fontSize: 14.0
              ),
              onSaved: null,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
            child: ListTile(
              title: Container(
                width: 250,
                child: DropdownButtonFormField<
                    String>(
                  decoration: InputDecoration(
                    labelText: 'Kirim Kepada',
                    labelStyle:
                    TextStyle(fontSize: 14.0),
                  ),
                  value: _selectionPIC,
                  onChanged: (String value) {
                    setState(() {
                      switch (
                      int.tryParse(value)) {
                        case 1:
                          _pic = 'Ironman';
                          break;
                        case 2:
                          _pic = 'Spiderman';
                          break;
                        default:
                          _pic = '-';
                          break;
                      }
                      _selectionPIC = value;
                    });
                  },
                  items: _picJSON.map((Map map) {
                    return DropdownMenuItem(
                      value: map['id'].toString(),
                      child: Text(map['pic']),
                    );
                  }).toList(),
                ),
              ),
              trailing: Container(
                width: 50.0,
                child: IconButton(
                  icon: Icon(Icons.add),
                  color: Colors.blue,
                  onPressed: () {},
                )
              )
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0, left: 60.0, right: 60.0, bottom: 20.0),
            child: RaisedButton(
              child: Text(
                'SEND',
              ),
              onPressed: () {},
              textColor: Colors.white,
              color: Colors.green,
            )
          ),
        ],
      ),
    );
  }
}