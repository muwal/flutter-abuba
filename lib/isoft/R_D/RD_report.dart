import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_abuba/isoft/R_D/RD_report_detail.dart';
import 'package:flutter_abuba/constant.dart';

class RDreport extends StatefulWidget {
  RDreport({Key key}) : super(key: key);

  _RDreportState createState() => _RDreportState();
}

class _RDreportState extends State<RDreport>{
  final material = [
    {"tanggal": "17/08/2018", "nama_produk": "Daging Ayam", "status": "APPROVED"},
    {"tanggal": "17/08/2018", "nama_produk": "Daging Sapi", "status": "REJECTED"},
    {"tanggal": "17/08/2018", "nama_produk": "Daging Kambing", "status": "REJECTED"},
    {"tanggal": "17/08/2018", "nama_produk": "Telur", "status": "APPROVED"},
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
                  'R&D',
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
                    'Daftar',
                    style:
                        TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 100.0,
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Tanggal',
                                style: TextStyle(color: Colors.green),
                              ),
                            )
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
                                'Nama Produk',
                                style: TextStyle(color: Colors.green),
                              ),
                            )
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
                                'Category',
                                style: TextStyle(color: Colors.green),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 100.0,
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                '17/09/2018',
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.black38),
                              ),
                            )
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
                                'Steak Wagyu Premium',
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.black38),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 100.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Flexible(
                              child: ButtonTheme(
                                minWidth: 50.0,
                                height: 30.0,
                                splashColor: AbubaPallate.menuBluebird,
                                child: OutlineButton(
                                  borderSide: BorderSide(
                                      color: AbubaPallate.menuBluebird),
                                  child: Text(
                                    'APPROVED',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        color: AbubaPallate.menuBluebird),
                                    textAlign: TextAlign.center,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MyCustomRoute(
                                            builder: (context) =>
                                                RDreportDetail()));
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          /*Container(
            color: Colors.white,
            padding: const EdgeInsets.only(right: 20.0, left: 20.0),
            child: ListTile(
              onTap: () {},
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Tanggal',
                      style: TextStyle(
                        color: AbubaPallate.green
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Nama Produk',
                      style: TextStyle(
                        color: AbubaPallate.green
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Category',
                      style: TextStyle(
                        color: AbubaPallate.green
                      ),
                    ),
                  ),
                ],
              )
            )
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(right: 20.0, left: 20.0),
            height: MediaQuery.of(context).size.height / 1.5,
            child: Column(
              children: <Widget>[
                material.length == 0
                  ? Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          'No Data'
                        ),
                      )
                    )
                  : Flexible(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: material.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            onTap: null,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    material[index]['tanggal'],
                                    style: TextStyle(
                                      color: Colors.black45
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    material[index]['nama_produk'],
                                    style: TextStyle(
                                      color: Colors.black45
                                    ),
                                  ),
                                ),
                                ButtonTheme(
                                  height: 30.0,
                                  minWidth: 100.0,
                                  child: OutlineButton(
                                    child: Text(
                                      material[index]['status'],
                                      style: TextStyle(
                                        color: material[index]['status'] == 'REJECTED' ? Colors.redAccent : Colors.blue
                                      ),
                                    ),
                                    borderSide: BorderSide(
                                      color: material[index]['status'] == 'REJECTED' ? Colors.redAccent : Colors.blue,
                                      width: 1.0),
                                    highlightedBorderColor: material[index]['status'] == 'REJECTED' ? Colors.redAccent : Colors.blue,
                                    onPressed: () {
                                      Navigator.push(context,
                                        MyCustomRoute(
                                          builder: (context) => RDreportDetail()
                                        )
                                      );
                                    },
                                  ),
                                ),
                              ],
                            )
                          );
                        },
                      ),
                    ),
              ],
            ),
          )*/
        ],
      ),
    );
  }
}