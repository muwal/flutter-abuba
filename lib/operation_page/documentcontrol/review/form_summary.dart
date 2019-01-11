import 'package:flutter/material.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';
import 'package:flutter_abuba/constant.dart';
import 'detail_review.dart';

class FormSum extends StatefulWidget {
  @override
  _FormSumState createState() => _FormSumState();
}

class _FormSumState extends State<FormSum> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AbubaAppBar(),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: _buildDetail(),
        ),
      ),
    );
  }

  _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          titlePadding: EdgeInsets.all(0.0),
          title: Container(
            color: Colors.blue,
            padding: EdgeInsets.all(12.0),
            child: new Text(
              "Thank You Ridwan",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          content: new Text("Revisi sudah dikirim kepada Sony Ramadhani"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            ButtonTheme(
              minWidth: 50.0,
              child: RaisedButton(
                child: Text(
                  'Close',
                  style: TextStyle(fontSize: 13.0, color: Colors.white),
                ),
                color: Colors.red,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetail() {
    return Scrollbar(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Text(
                    'E-Library',
                    style: TextStyle(color: Colors.black12, fontSize: 12.0),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    '|',
                    style: TextStyle(
                        color: AbubaPallate.greenabuba, fontSize: 12.0),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    'Operation',
                    style: TextStyle(
                        color: AbubaPallate.greenabuba, fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: ExpansionTile(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Cover',
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MyCustomRoute(builder: (context) => new FormDetail()));
                  },
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15.0, bottom: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: 200.0,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Ganti judul menjadi Pemeriksaan produk dan bahan baku',
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black54,),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              width: 100.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Page 1',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: AbubaPallate.menuBluebird,),
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
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: ExpansionTile(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Tujuan',
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, bottom: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 200.0,
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Tujuan disesuaikan dengan ruang lingkup',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.black54,),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        width: 100.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Page 1',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: AbubaPallate.menuBluebird,),
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
          ),
          Container(
            color: Colors.white,
            child: ExpansionTile(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Referensi',
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, bottom: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 200.0,
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Tujuan disesuaikan dengan ruang lingkup',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.black54,),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        width: 100.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Page 1',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: AbubaPallate.menuBluebird,),
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
          ),
          Container(
            color: Colors.white,
            child: ExpansionTile(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Daftar Istilah',
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, bottom: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 200.0,
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Tujuan disesuaikan dengan ruang lingkup',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.black54,),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        width: 100.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Page 1',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: AbubaPallate.menuBluebird,),
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
          ),
          Container(
            color: Colors.white,
            child: ExpansionTile(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Prosedur',
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, bottom: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 200.0,
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Tujuan disesuaikan dengan ruang lingkup',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.black54,),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        width: 100.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Page 1',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: AbubaPallate.menuBluebird,),
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
          ),
          Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: ButtonTheme(
                    height: 30.0,
                    minWidth: 50.0,
                    child: RaisedButton(
                      child: Text(
                        'Save',
                        style: TextStyle(fontSize: 13.0, color: Colors.white),
                      ),
                      color: AbubaPallate.greenabuba,
                      onPressed: () {
                        setState(
                              () {
                            _showDialog();
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
