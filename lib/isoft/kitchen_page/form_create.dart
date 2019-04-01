import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';

class FormCreate extends StatefulWidget {
  @override
  _FormCreateState createState() => _FormCreateState();
}

class _FormCreateState extends State<FormCreate> {
  String _selectionSumber;
  String _sumber;
  List<Map> _sumberJSON = [
    {"id": 1, "sumber": "A"},
    {"id": 2, "sumber": "B"},
  ];

  Color _colorLowLi = Colors.grey;
  Color _colorHighLi = Colors.grey;

  String _risk = ' ';
  Color _colorRisk = Colors.grey;

  @override
  Widget build(BuildContext context) {
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
        body: _buildCreate(),
      ),
    );
  }

  Widget _buildCreate() {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: Text(
                  'Kitchen',
                  style: TextStyle(color: Colors.black12, fontSize: 12.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  '|',
                  style:
                      TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                ),
              ),
              Flexible(
                child: Text(
                  'Create New',
                  style:
                      TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: <Widget>[
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'No. Polisi',
                  labelStyle: TextStyle(fontSize: 14.0),
                ),
                value: _selectionSumber,
                onChanged: (String value) {
                  setState(() {
                    switch (int.tryParse(value)) {
                      case 1:
                        _sumber = 'A';
                        break;
                      case 2:
                        _sumber = 'B';
                        break;
                      default:
                        _sumber = '-';
                        break;
                    }
                    _selectionSumber = value;
                  });
                },
                items: _sumberJSON.map((Map map) {
                  return DropdownMenuItem(
                    value: map['id'].toString(),
                    child: Text(map['sumber']),
                  );
                }).toList(),
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Nama Sopir',
                  labelStyle: TextStyle(fontSize: 14.0),
                ),
                value: _selectionSumber,
                onChanged: (String value) {
                  setState(() {
                    switch (int.tryParse(value)) {
                      case 1:
                        _sumber = 'A';
                        break;
                      case 2:
                        _sumber = 'B';
                        break;
                      default:
                        _sumber = '-';
                        break;
                    }
                    _selectionSumber = value;
                  });
                },
                items: _sumberJSON.map((Map map) {
                  return DropdownMenuItem(
                    value: map['id'].toString(),
                    child: Text(map['sumber']),
                  );
                }).toList(),
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Nama Customer',
                  labelStyle: TextStyle(fontSize: 14.0),
                ),
                value: _selectionSumber,
                onChanged: (String value) {
                  setState(() {
                    switch (int.tryParse(value)) {
                      case 1:
                        _sumber = 'A';
                        break;
                      case 2:
                        _sumber = 'B';
                        break;
                      default:
                        _sumber = '-';
                        break;
                    }
                    _selectionSumber = value;
                  });
                },
                items: _sumberJSON.map((Map map) {
                  return DropdownMenuItem(
                    value: map['id'].toString(),
                    child: Text(map['sumber']),
                  );
                }).toList(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Divider(
                  height: 5.0,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      'Parameter',
                      style: TextStyle(
                          color: AbubaPallate.greenabuba,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            '1. Bagian luar kendaraan secara umum dalam keadaan bersih',
                            style: TextStyle(color: Colors.black54),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ButtonTheme(
                            minWidth: 150.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                'NO',
                                style: TextStyle(color: _colorHighLi),
                              ),
                              borderSide:
                                  BorderSide(color: _colorHighLi, width: 1.0),
                              highlightedBorderColor: _colorHighLi,
                              onPressed: () {
                                setState(() {
                                  _colorLowLi = Colors.grey;
                                  _colorHighLi = Colors.redAccent;

                                  _risk = 'NO';
                                  _colorRisk = Colors.redAccent;
                                });
                              },
                            ),
                          ),
                          ButtonTheme(
                            minWidth: 150.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                'YES',
                                style: TextStyle(color: _colorLowLi),
                              ),
                              borderSide:
                              BorderSide(color: _colorLowLi, width: 1.0),
                              highlightedBorderColor: _colorLowLi,
                              onPressed: () {
                                setState(() {
                                  _colorLowLi = Colors.green[400];
                                  _colorHighLi = Colors.grey;

                                  _risk = 'YES';
                                  _colorRisk = Colors.green[400];
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
                padding: EdgeInsets.only(top: 10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            '2. Produk tersusun dengan sesuai',
                            style: TextStyle(color: Colors.black54),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ButtonTheme(
                            minWidth: 150.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                'NO',
                                style: TextStyle(color: _colorHighLi),
                              ),
                              borderSide:
                                  BorderSide(color: _colorHighLi, width: 1.0),
                              highlightedBorderColor: _colorHighLi,
                              onPressed: () {
                                setState(() {
                                  _colorLowLi = Colors.grey;
                                  _colorHighLi = Colors.redAccent;

                                  _risk = 'NO';
                                  _colorRisk = Colors.redAccent;
                                });
                              },
                            ),
                          ),
                          ButtonTheme(
                            minWidth: 150.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                'YES',
                                style: TextStyle(color: _colorLowLi),
                              ),
                              borderSide:
                              BorderSide(color: _colorLowLi, width: 1.0),
                              highlightedBorderColor: _colorLowLi,
                              onPressed: () {
                                setState(() {
                                  _colorLowLi = Colors.green[400];
                                  _colorHighLi = Colors.grey;

                                  _risk = 'YES';
                                  _colorRisk = Colors.green[400];
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
                padding: EdgeInsets.only(top: 10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            '3. Tidak ada lubang / retak body dari bak kendaraan',
                            style: TextStyle(color: Colors.black54),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ButtonTheme(
                            minWidth: 150.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                'NO',
                                style: TextStyle(color: _colorHighLi),
                              ),
                              borderSide:
                                  BorderSide(color: _colorHighLi, width: 1.0),
                              highlightedBorderColor: _colorHighLi,
                              onPressed: () {
                                setState(() {
                                  _colorLowLi = Colors.grey;
                                  _colorHighLi = Colors.redAccent;

                                  _risk = 'NO';
                                  _colorRisk = Colors.redAccent;
                                });
                              },
                            ),
                          ),
                          ButtonTheme(
                            minWidth: 150.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                'YES',
                                style: TextStyle(color: _colorLowLi),
                              ),
                              borderSide:
                              BorderSide(color: _colorLowLi, width: 1.0),
                              highlightedBorderColor: _colorLowLi,
                              onPressed: () {
                                setState(() {
                                  _colorLowLi = Colors.green[400];
                                  _colorHighLi = Colors.grey;

                                  _risk = 'YES';
                                  _colorRisk = Colors.green[400];
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
                padding: EdgeInsets.only(top: 10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            '4. Tidak ada paku / baut dari bak kendaraan yang lepas',
                            style: TextStyle(color: Colors.black54),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ButtonTheme(
                            minWidth: 150.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                'NO',
                                style: TextStyle(color: _colorHighLi),
                              ),
                              borderSide:
                                  BorderSide(color: _colorHighLi, width: 1.0),
                              highlightedBorderColor: _colorHighLi,
                              onPressed: () {
                                setState(() {
                                  _colorLowLi = Colors.grey;
                                  _colorHighLi = Colors.redAccent;

                                  _risk = 'NO';
                                  _colorRisk = Colors.redAccent;
                                });
                              },
                            ),
                          ),
                          ButtonTheme(
                            minWidth: 150.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                'YES',
                                style: TextStyle(color: _colorLowLi),
                              ),
                              borderSide:
                              BorderSide(color: _colorLowLi, width: 1.0),
                              highlightedBorderColor: _colorLowLi,
                              onPressed: () {
                                setState(() {
                                  _colorLowLi = Colors.green[400];
                                  _colorHighLi = Colors.grey;

                                  _risk = 'YES';
                                  _colorRisk = Colors.green[400];
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
                padding: EdgeInsets.only(top: 10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            '5. Tidak ada bau asing (bau bahan kimia, makanan, binatang, dll)',
                            style: TextStyle(color: Colors.black54),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ButtonTheme(
                            minWidth: 150.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                'NO',
                                style: TextStyle(color: _colorHighLi),
                              ),
                              borderSide:
                                  BorderSide(color: _colorHighLi, width: 1.0),
                              highlightedBorderColor: _colorHighLi,
                              onPressed: () {
                                setState(() {
                                  _colorLowLi = Colors.grey;
                                  _colorHighLi = Colors.redAccent;

                                  _risk = 'NO';
                                  _colorRisk = Colors.redAccent;
                                });
                              },
                            ),
                          ),
                          ButtonTheme(
                            minWidth: 150.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                'YES',
                                style: TextStyle(color: _colorLowLi),
                              ),
                              borderSide:
                              BorderSide(color: _colorLowLi, width: 1.0),
                              highlightedBorderColor: _colorLowLi,
                              onPressed: () {
                                setState(() {
                                  _colorLowLi = Colors.green[400];
                                  _colorHighLi = Colors.grey;

                                  _risk = 'YES';
                                  _colorRisk = Colors.green[400];
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
                padding: EdgeInsets.only(top: 10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            '6. Bak kendaraan dalam keadaan kering dan tidak berminyak',
                            style: TextStyle(color: Colors.black54),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ButtonTheme(
                            minWidth: 150.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                'NO',
                                style: TextStyle(color: _colorHighLi),
                              ),
                              borderSide:
                                  BorderSide(color: _colorHighLi, width: 1.0),
                              highlightedBorderColor: _colorHighLi,
                              onPressed: () {
                                setState(() {
                                  _colorLowLi = Colors.grey;
                                  _colorHighLi = Colors.redAccent;

                                  _risk = 'NO';
                                  _colorRisk = Colors.redAccent;
                                });
                              },
                            ),
                          ),
                          ButtonTheme(
                            minWidth: 150.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                'YES',
                                style: TextStyle(color: _colorLowLi),
                              ),
                              borderSide:
                              BorderSide(color: _colorLowLi, width: 1.0),
                              highlightedBorderColor: _colorLowLi,
                              onPressed: () {
                                setState(() {
                                  _colorLowLi = Colors.green[400];
                                  _colorHighLi = Colors.grey;

                                  _risk = 'YES';
                                  _colorRisk = Colors.green[400];
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
                padding: EdgeInsets.only(top: 10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            '7. Tidak ada serangga (kecoa, kutu, lalat, dll) dalam bak kendaraan',
                            style: TextStyle(color: Colors.black54),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ButtonTheme(
                            minWidth: 150.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                'NO',
                                style: TextStyle(color: _colorHighLi),
                              ),
                              borderSide:
                                  BorderSide(color: _colorHighLi, width: 1.0),
                              highlightedBorderColor: _colorHighLi,
                              onPressed: () {
                                setState(() {
                                  _colorLowLi = Colors.grey;
                                  _colorHighLi = Colors.redAccent;

                                  _risk = 'NO';
                                  _colorRisk = Colors.redAccent;
                                });
                              },
                            ),
                          ),
                          ButtonTheme(
                            minWidth: 150.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                'YES',
                                style: TextStyle(color: _colorLowLi),
                              ),
                              borderSide:
                              BorderSide(color: _colorLowLi, width: 1.0),
                              highlightedBorderColor: _colorLowLi,
                              onPressed: () {
                                setState(() {
                                  _colorLowLi = Colors.green[400];
                                  _colorHighLi = Colors.grey;

                                  _risk = 'YES';
                                  _colorRisk = Colors.green[400];
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
                padding: EdgeInsets.only(top: 10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            '8. Lantai bak kendaraan menggunakan alas yang bersih',
                            style: TextStyle(color: Colors.black54),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ButtonTheme(
                            minWidth: 150.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                'NO',
                                style: TextStyle(color: _colorHighLi),
                              ),
                              borderSide:
                                  BorderSide(color: _colorHighLi, width: 1.0),
                              highlightedBorderColor: _colorHighLi,
                              onPressed: () {
                                setState(() {
                                  _colorLowLi = Colors.grey;
                                  _colorHighLi = Colors.redAccent;

                                  _risk = 'NO';
                                  _colorRisk = Colors.redAccent;
                                });
                              },
                            ),
                          ),
                          ButtonTheme(
                            minWidth: 150.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                'YES',
                                style: TextStyle(color: _colorLowLi),
                              ),
                              borderSide:
                              BorderSide(color: _colorLowLi, width: 1.0),
                              highlightedBorderColor: _colorLowLi,
                              onPressed: () {
                                setState(() {
                                  _colorLowLi = Colors.green[400];
                                  _colorHighLi = Colors.grey;

                                  _risk = 'YES';
                                  _colorRisk = Colors.green[400];
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
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Divider(
                  height: 5.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ButtonTheme(
                      minWidth: 150.0,
                      height: 30.0,
                      child: RaisedButton(
                        color: AbubaPallate.greenabuba,
                        child: Text(
                          'SAVE',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {

                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
