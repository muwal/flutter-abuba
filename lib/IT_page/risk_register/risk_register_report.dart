import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';

class RiskRegisterReport extends StatefulWidget {
  RiskRegisterReport({Key key}) : super(key: key);

  _RiskRegisterReportState createState() => _RiskRegisterReportState();
}

class _RiskRegisterReportState extends State<RiskRegisterReport> with TickerProviderStateMixin {
  bool _note = false;
  var ratingChiller = 0.0;
  TextEditingController controllerNoteSatu = new TextEditingController();

  List<Map> myList = [
    {"nomor":1},
    {"nomor":2},
    {"nomor":3},
    {"nomor":4},
    {"nomor":5},
  ];

  TabController _cardController;
  TabPageSelector _tabPageSelector;

  @override
  void initState() {
    super.initState();
    _cardController = new TabController(vsync: this, length: myList.length);
    _tabPageSelector = new TabPageSelector(controller: _cardController);
  }

  @override
  void dispose() {
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    
    return SafeArea(
      child: Scaffold(
        appBar: AbubaAppBar(),
        body: Builder(
          builder: (BuildContext context) => Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Risk Register',
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
                          'Report',
                          style:
                              TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                ),
                myList.isEmpty
                ? new Container(
                    height: 30.0,
                  )
                : new Container(
                    height: 30.0,
                    child: _tabPageSelector,
                    alignment: Alignment.center,
                  ),
                Expanded(
                  child: TabBarView(
                    controller: _cardController,
                    children: myList.isEmpty
                        ? <Widget>[]
                        : myList.map((Map map) {
                          return _buildFormReport(width, map['nomor']);
                        }).toList()
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormReport(double width, int nomor) {
    return Scrollbar(
      child: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
            alignment: Alignment.center,
            color: Colors.white,
            child: Text(
              '${nomor.toString()} of ${myList.length.toString()}',
              style: TextStyle(
                fontSize: 16.0,
                color: AbubaPallate.greenabuba,
                fontWeight: FontWeight.bold
              ),
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
                      padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: width / 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Jenis',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w100),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: width / 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Kerusakan Bahan Baku',
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.left,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 2.0,
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding:
                          const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: width / 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Sumber',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w100),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: width / 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Human Error',
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.left,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 2.0,
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding:
                          const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: width / 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Dampak',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w100),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: width / 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Kerugian perusahaan',
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.left,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 2.0,
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding:
                          const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: width / 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Severity',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w100),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: width / 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'High',
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.left,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 2.0,
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding:
                      const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: width / 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Likelihood',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w100),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding:
                      const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: width / 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Medium',
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.left,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 2.0,
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding:
                      const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: width / 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Risk',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w100),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.redAccent,
                      padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: width / 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'High',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.left,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 2.0,
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding:
                      const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: width / 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Pengendalian',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w100),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding:
                      const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: width / 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Mengurangi',
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.left,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 2.0,
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding:
                      const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: width / 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Deskripsi',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w100),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding:
                      const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: width / 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Hindari penumpukan',
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.left,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 2.0,
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding:
                      const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: width / 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Pemantauan',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w100),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding:
                      const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: width / 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Setiap 5 jam',
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.left,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 2.0,
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding:
                      const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: width / 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'PIC',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w100),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding:
                      const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: width / 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Albert',
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.left,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 2.0,
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding:
                      const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: width / 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Verifikator',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w100),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding:
                      const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: width / 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Stephen',
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.left,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}