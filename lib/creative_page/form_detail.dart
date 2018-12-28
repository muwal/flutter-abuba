import 'package:flutter/material.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';
import 'package:flutter_abuba/constant.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class FormDetail extends StatefulWidget {
  @override
  _FormDetailState createState() => _FormDetailState();
}

class _FormDetailState extends State<FormDetail> {
  bool _note = false;
  bool _notedua = false;
  bool _notetiga = false;
  TextEditingController controllerNoteSatu = new TextEditingController();

  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime dateStart;
  DateTime dateEnd;
  DateTime dateSchedule;

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
                    'Creative Idea',
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
                    'Detail',
                    style: TextStyle(
                        color: AbubaPallate.greenabuba, fontSize: 12.0),
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
                  padding:
                      const EdgeInsets.only(right: 20.0, left: 20.0, top: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Creative Ideas',
                          style: TextStyle(color: AbubaPallate.green),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 8.0, 20.0, 5.0),
                  child: ListTile(
                    onTap: null,
                    leading: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              "https://www.biography.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cg_face%2Cq_auto:good%2Cw_300/MTE5NTU2MzE2NDE4MzExNjkx/jackie-chan-9542080-1-402.jpg"),
                        ),
                      ),
                    ),
                    title: Text(
                      'Meningkatkan sales sebanyak 25% lewat upselling',
                      style: TextStyle(
                          color: Colors.black54, fontSize: 12.0),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        'Ridwan . Outlet Cipete . 2h',
                        style: TextStyle(
                            color: Colors.grey[500], fontSize: 10.0),
                      ),
                    ),
                    trailing: ButtonTheme(
                      minWidth: 50.0,
                      height: 20.0,
                      child: RaisedButton(
                        color: AbubaPallate.menuBluebird,
                        elevation: 0.0,
                        child: Text(
                          'Approved',
                          style: TextStyle(fontSize: 12.0, color: Colors.white),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Problem',
                          style: TextStyle(color: AbubaPallate.green),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                            'Periode January – Maret 2018, sales di outlet A hanya 60% dari target. Hal ini membuat bonus karyawan menjadi berkurang 10%',
                            style: TextStyle(
                                fontSize: 12.0, color: Colors.black38)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Akar Masalah',
                          style: TextStyle(color: AbubaPallate.green),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 6.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Man',
                              style: TextStyle(
                                  fontSize: 13.0, color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Kasir tidak menawarkan produk upselling kepada customer',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black38),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 6.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Material',
                              style: TextStyle(
                                  fontSize: 13.0, color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Tidak ada menu baru yang menarik',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black38),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 6.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Method',
                              style: TextStyle(
                                  fontSize: 13.0, color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Customer bosan dengan penawaran manual yang berulang',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black38),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Environment',
                              style: TextStyle(
                                  fontSize: 13.0, color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Kasir tidak menawarkan produk upseeling kepada customer',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black38),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Ide',
                          style: TextStyle(color: AbubaPallate.green),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 6.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Deskripsi',
                              style: TextStyle(
                                  fontSize: 13.0, color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Kasir menawarkan produk upseeling dalam bentuk pairing product kepada customer yang berulang tahun di hari kedatangan',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black38),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 6.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Financial Improvement',
                              style: TextStyle(
                                  fontSize: 13.0, color: Colors.black54),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              '27/12/2018',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black38),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'IDR 100,000,000',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black38),
                            ),
                          ),
                          Flexible(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _note = !_note;
                                });
                              },
                              child: Text(
                                'Note',
                                style: TextStyle(
                                    fontSize: 13.5,
                                    color: AbubaPallate.menuBluebird),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 3.0),
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
                Divider(
                  height: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 6.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Financial Saving',
                              style: TextStyle(
                                  fontSize: 13.0, color: Colors.black54),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              '27/12/2018',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black38),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'IDR 100,000,000',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black38),
                            ),
                          ),
                          Flexible(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _notedua = !_notedua;
                                });
                              },
                              child: Text(
                                'Note',
                                style: TextStyle(
                                    fontSize: 13.5,
                                    color: AbubaPallate.menuBluebird),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 3.0),
                  child: _notedua
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
                Divider(
                  height: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 6.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Quality',
                              style: TextStyle(
                                  fontSize: 13.0, color: Colors.black54),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              '27/12/2018',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black38),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Menurunkan jumlah customer complaint',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black38),
                            ),
                          ),
                          Flexible(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _notetiga = !_notetiga;
                                });
                              },
                              child: Text(
                                'Note',
                                style: TextStyle(
                                    fontSize: 13.5,
                                    color: AbubaPallate.menuBluebird),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                  child: _notetiga
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
              ],
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Pelaksana',
                          style: TextStyle(color: AbubaPallate.green),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 100.0,
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                '123456',
                                style: TextStyle(
                                    fontSize: 13.0, color: Colors.black54),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 100.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Sony Ramdhani',
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.black38),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 100.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'IT',
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.black38),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 3.0, 20.0, 3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 100.0,
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                '123456',
                                style: TextStyle(
                                    fontSize: 13.0, color: Colors.black54),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 100.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Ridwan Syawall',
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.black38),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 100.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'HRD',
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.black38),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 3.0, 20.0, 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 100.0,
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                '123456',
                                style: TextStyle(
                                    fontSize: 13.0, color: Colors.black54),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 100.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Rizal Muharami',
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.black38),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 100.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'QA',
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.black38),
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
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
