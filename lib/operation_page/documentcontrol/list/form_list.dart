import 'package:flutter/material.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/operation_page/documentcontrol/list/detail_list.dart';

class FormList extends StatefulWidget {
  @override
  _FormListState createState() => _FormListState();
}

class _FormListState extends State<FormList> {
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
                          'Problem',
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                      ButtonTheme(
                        minWidth: 50.0,
                        height: 20.0,
                        child: OutlineButton(
                          child: Text(
                            'Detail',
                            style: TextStyle(fontSize: 13.0, color: AbubaPallate.menuBluebird),
                          ),
                          borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                          highlightedBorderColor: AbubaPallate.menuBluebird,
                          onPressed: () => Navigator.push(context,
                              MyCustomRoute(builder: (context) => FormDetail())),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'SOP.OPR.02',
                          style:
                              TextStyle(fontSize: 12.0, color: Colors.black38),
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Flexible(
                        child: Text(
                          'Rev 00',
                          style:
                              TextStyle(fontSize: 12.0, color: Colors.black38),
                        ),
                      )
                    ],
                  )
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
                            left: 15.0, right: 15.0, bottom: 6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: 100.0,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Dibuat',
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w700),
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
                                      'Diperiksa',
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w700),
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
                                      'Disetujui',
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w700),
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
                            left: 15.0, right: 15.0, bottom: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: 100.0,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Sony',
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500),
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
                                      'Ridwan',
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500),
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
                                      'M. Ali',
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500),
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
                            left: 15.0, right: 15.0, bottom: 0.0),
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
                                      style: TextStyle(
                                          fontSize: 10.0,
                                          color: Colors.black54),
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
                                      'Audit',
                                      style: TextStyle(
                                          fontSize: 10.0,
                                          color: Colors.black54),
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
                                      'Direktur',
                                      style: TextStyle(
                                          fontSize: 10.0,
                                          color: Colors.black54),
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
                            left: 15.0, right: 15.0, bottom: 15.0),
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
                                      '01/01/2019',
                                      style: TextStyle(
                                          fontSize: 10.0,
                                          color: Colors.black54),
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
                                      '01/01/2019',
                                      style: TextStyle(
                                          fontSize: 10.0,
                                          color: Colors.black54),
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
                                      '01/01/2019',
                                      style: TextStyle(
                                          fontSize: 10.0,
                                          color: Colors.black54),
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
                          'Menghadapi Instansi Pemerintah',
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                      ButtonTheme(
                        minWidth: 50.0,
                        height: 20.0,
                        child: OutlineButton(
                          child: Text(
                            'Detail',
                            style: TextStyle(fontSize: 13.0, color: AbubaPallate.menuBluebird),
                          ),
                          borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                          highlightedBorderColor: AbubaPallate.menuBluebird,
                          onPressed: () => Navigator.push(context,
                              MyCustomRoute(builder: (context) => FormDetail())),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'SOP.OPR.02',
                          style:
                              TextStyle(fontSize: 12.0, color: Colors.black38),
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Flexible(
                        child: Text(
                          'Rev 00',
                          style:
                              TextStyle(fontSize: 12.0, color: Colors.black38),
                        ),
                      )
                    ],
                  )
                ],
              ),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, bottom: 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 100.0,
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Dibuat',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w700),
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
                                'Diperiksa',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w700),
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
                                'Disetujui',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w700),
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
                      left: 15.0, right: 15.0, bottom: 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 100.0,
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Sony',
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500),
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
                                'Ridwan',
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500),
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
                                'M. Ali',
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500),
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
                      left: 15.0, right: 15.0, bottom: 0.0),
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
                                style: TextStyle(
                                    fontSize: 10.0, color: Colors.black54),
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
                                'Audit',
                                style: TextStyle(
                                    fontSize: 10.0, color: Colors.black54),
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
                                'Direktur',
                                style: TextStyle(
                                    fontSize: 10.0, color: Colors.black54),
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
                      left: 15.0, right: 15.0, bottom: 15.0),
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
                                '01/01/2019',
                                style: TextStyle(
                                    fontSize: 10.0, color: Colors.black54),
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
                                '01/01/2019',
                                style: TextStyle(
                                    fontSize: 10.0, color: Colors.black54),
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
                                '01/01/2019',
                                style: TextStyle(
                                    fontSize: 10.0, color: Colors.black54),
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
                          'Penerimaan bahan baku',
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                      ButtonTheme(
                        minWidth: 50.0,
                        height: 20.0,
                        child: OutlineButton(
                          child: Text(
                            'Detail',
                            style: TextStyle(fontSize: 13.0, color: AbubaPallate.menuBluebird),
                          ),
                          borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                          highlightedBorderColor: AbubaPallate.menuBluebird,
                          onPressed: () => Navigator.push(context,
                              MyCustomRoute(builder: (context) => FormDetail())),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'SOP.OPR.02',
                          style:
                              TextStyle(fontSize: 12.0, color: Colors.black38),
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Flexible(
                        child: Text(
                          'Rev 00',
                          style:
                              TextStyle(fontSize: 12.0, color: Colors.black38),
                        ),
                      )
                    ],
                  )
                ],
              ),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, bottom: 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 100.0,
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Dibuat',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w700),
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
                                'Diperiksa',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w700),
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
                                'Disetujui',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w700),
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
                      left: 15.0, right: 15.0, bottom: 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 100.0,
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Sony',
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500),
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
                                'Ridwan',
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500),
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
                                'M. Ali',
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500),
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
                      left: 15.0, right: 15.0, bottom: 0.0),
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
                                style: TextStyle(
                                    fontSize: 10.0, color: Colors.black54),
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
                                'Audit',
                                style: TextStyle(
                                    fontSize: 10.0, color: Colors.black54),
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
                                'Direktur',
                                style: TextStyle(
                                    fontSize: 10.0, color: Colors.black54),
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
                      left: 15.0, right: 15.0, bottom: 15.0),
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
                                '01/01/2019',
                                style: TextStyle(
                                    fontSize: 10.0, color: Colors.black54),
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
                                '01/01/2019',
                                style: TextStyle(
                                    fontSize: 10.0, color: Colors.black54),
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
                                '01/01/2019',
                                style: TextStyle(
                                    fontSize: 10.0, color: Colors.black54),
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
                          'Customer Handling',
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                      ButtonTheme(
                        minWidth: 50.0,
                        height: 20.0,
                        child: OutlineButton(
                          child: Text(
                            'Detail',
                            style: TextStyle(fontSize: 13.0, color: AbubaPallate.menuBluebird),
                          ),
                          borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                          highlightedBorderColor: AbubaPallate.menuBluebird,
                          onPressed: () => Navigator.push(context,
                              MyCustomRoute(builder: (context) => FormDetail())),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'SOP.OPR.02',
                          style:
                              TextStyle(fontSize: 12.0, color: Colors.black38),
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Flexible(
                        child: Text(
                          'Rev 00',
                          style:
                              TextStyle(fontSize: 12.0, color: Colors.black38),
                        ),
                      )
                    ],
                  )
                ],
              ),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, bottom: 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 100.0,
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Dibuat',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w700),
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
                                'Diperiksa',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w700),
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
                                'Disetujui',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w700),
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
                      left: 15.0, right: 15.0, bottom: 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 100.0,
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Sony',
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500),
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
                                'Ridwan',
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500),
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
                                'M. Ali',
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500),
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
                      left: 15.0, right: 15.0, bottom: 0.0),
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
                                style: TextStyle(
                                    fontSize: 10.0, color: Colors.black54),
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
                                'Audit',
                                style: TextStyle(
                                    fontSize: 10.0, color: Colors.black54),
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
                                'Direktur',
                                style: TextStyle(
                                    fontSize: 10.0, color: Colors.black54),
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
                      left: 15.0, right: 15.0, bottom: 15.0),
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
                                '01/01/2019',
                                style: TextStyle(
                                    fontSize: 10.0, color: Colors.black54),
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
                                '01/01/2019',
                                style: TextStyle(
                                    fontSize: 10.0, color: Colors.black54),
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
                                '01/01/2019',
                                style: TextStyle(
                                    fontSize: 10.0, color: Colors.black54),
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
                          'Service Sequence',
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                      ButtonTheme(
                        minWidth: 50.0,
                        height: 20.0,
                        child: OutlineButton(
                          child: Text(
                            'Detail',
                            style: TextStyle(fontSize: 13.0, color: AbubaPallate.menuBluebird),
                          ),
                          borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                          highlightedBorderColor: AbubaPallate.menuBluebird,
                          onPressed: () => Navigator.push(context,
                              MyCustomRoute(builder: (context) => FormDetail())),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'SOP.OPR.02',
                          style:
                              TextStyle(fontSize: 12.0, color: Colors.black38),
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Flexible(
                        child: Text(
                          'Rev 00',
                          style:
                              TextStyle(fontSize: 12.0, color: Colors.black38),
                        ),
                      )
                    ],
                  )
                ],
              ),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, bottom: 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 100.0,
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Dibuat',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w700),
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
                                'Diperiksa',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w700),
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
                                'Disetujui',
                                style: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w700),
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
                      left: 15.0, right: 15.0, bottom: 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 100.0,
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Sony',
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500),
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
                                'Ridwan',
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500),
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
                                'M. Ali',
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500),
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
                      left: 15.0, right: 15.0, bottom: 0.0),
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
                                style: TextStyle(
                                    fontSize: 10.0, color: Colors.black54),
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
                                'Audit',
                                style: TextStyle(
                                    fontSize: 10.0, color: Colors.black54),
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
                                'Direktur',
                                style: TextStyle(
                                    fontSize: 10.0, color: Colors.black54),
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
                      left: 15.0, right: 15.0, bottom: 15.0),
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
                                '01/01/2019',
                                style: TextStyle(
                                    fontSize: 10.0, color: Colors.black54),
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
                                '01/01/2019',
                                style: TextStyle(
                                    fontSize: 10.0, color: Colors.black54),
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
                                '01/01/2019',
                                style: TextStyle(
                                    fontSize: 10.0, color: Colors.black54),
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
    );
  }
}
