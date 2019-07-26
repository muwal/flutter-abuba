import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'detail_report.dart';

class Report extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;

  Report({this.idUser, this.namaUser, this.departmentUser});
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> with TickerProviderStateMixin {
  AnimationController animationController;

  List<String> supplierName = [];
  List<String> supplierKode = [];
  List<dynamic> finalScore = [];
  List<dynamic> quality = [];
  List<dynamic> quantity = [];
  List<dynamic> waktu = [];
  List<dynamic> komunikasi = [];
  List<dynamic> harga = [];
  var indexx = [];
  List<dynamic> idSupplier = [];

  @override
  void initState() {
    super.initState();

    CollectionReference reference = Firestore.instance.collection('purchasingEvaluation_mtrl');
    reference.snapshots().listen((data4) {
      data4.documentChanges.forEach((change) {
        setState(() {
          indexx.add(change.document.documentID);
          finalScore.add(change.document.data['totalPerformance']);
          quality.add(change.document.data['scoreQuality']);
          quantity.add(change.document.data['scoreQuantity']);
          waktu.add(change.document.data['scoreWaktu']);
          komunikasi.add(change.document.data['scoreKomunikasi']);
          harga.add(change.document.data['scoreHarga']);
          idSupplier.add(change.document.data['idSupplier']);

          Firestore.instance.collection('supplier').where('id', isEqualTo: change.document.data['idSupplier']).snapshots().listen((data2) {
            supplierName.add(data2.documents[0].data['supplier']);
            supplierKode.add(data2.documents[0].data['kode']);
          });
        });
      });
    });

    animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(
      from: animationController.value == 0.0
        ? 1.0
        : animationController.value
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: _appBar(),
          body: AnimatedBuilder(
            animation: animationController,
            builder: (_, Widget child) {
              return animationController.isAnimating
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator()
                    )
                  )
                : TabBarView(
                    children: <Widget>[
                      ListView(
                        children: <Widget>[
                          Container(
                            color: Colors.white,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: 200.0,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                'Supplier',
                                                style: TextStyle(color: AbubaPallate.greenabuba),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 125.0,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                'Score',
                                                style: TextStyle(color: AbubaPallate.greenabuba),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: List.generate(indexx.length, (index) {
                                    return ExpansionTile(
                                      title: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: 200.0,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        supplierName[index],
                                                        style: TextStyle(
                                                            color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w600),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        'Code : ${supplierKode[index]}',
                                                        style: TextStyle(
                                                            color: Colors.black38, fontSize: 12.0, fontWeight: FontWeight.w600),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 50.0,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    finalScore[index].toString(),
                                                    style: TextStyle(
                                                        color: Colors.black54, fontSize: 14.0, fontWeight: FontWeight.w600),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15.0, right: 15.0, bottom: 15.0),
                                          child: Column(
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                    width: 60.0,
                                                    child: Row(
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            'Quality',
                                                            style:
                                                                TextStyle(fontSize: 13.0, color: Colors.black54, fontWeight: FontWeight.w700),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 60.0,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            'Quantity',
                                                            style:
                                                            TextStyle(fontSize: 13.0, color: Colors.black54, fontWeight: FontWeight.w700),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 60.0,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            'Waktu',
                                                            style:
                                                            TextStyle(fontSize: 13.0, color: Colors.black54, fontWeight: FontWeight.w700),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 60.0,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            'Komunikasi',
                                                            style:
                                                            TextStyle(fontSize: 13.0, color: Colors.black54, fontWeight: FontWeight.w700),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 60.0,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            'Harga',
                                                            style:
                                                            TextStyle(fontSize: 13.0, color: Colors.black54, fontWeight: FontWeight.w700),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2.0,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                    width: 60.0,
                                                    child: Row(
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            quality[index].toString(),
                                                            style:
                                                            TextStyle(fontSize: 14.0, color: Colors.black38, fontWeight: FontWeight.w600),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 60.0,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            quantity[index].toString(),
                                                            style:
                                                            TextStyle(fontSize: 14.0, color: Colors.black38, fontWeight: FontWeight.w600),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 60.0,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            waktu[index].toString(),
                                                            style:
                                                            TextStyle(fontSize: 14.0, color: Colors.black38, fontWeight: FontWeight.w600),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 60.0,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            komunikasi[index].toString(),
                                                            style:
                                                            TextStyle(fontSize: 14.0, color: Colors.black38, fontWeight: FontWeight.w600),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 60.0,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            harga[index].toString(),
                                                            style:
                                                            TextStyle(fontSize: 14.0, color: Colors.black38, fontWeight: FontWeight.w600),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2.0,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: <Widget>[
                                                  ButtonTheme(
                                                    padding: EdgeInsets.all(0.0),
                                                    minWidth: 60.0,
                                                    height: 20.0,
                                                    child: OutlineButton(
                                                      child: Text(
                                                        'Detail',
                                                        style: TextStyle(
                                                          fontSize: 13.0,
                                                          color: AbubaPallate.menuBluebird
                                                        ),
                                                      ),
                                                      borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                                                      highlightedBorderColor: AbubaPallate.menuBluebird,
                                                      onPressed: () {
                                                        Navigator.push(context,
                                                          MyCustomRoute(
                                                            builder: (context) => DetailReport(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser, index: indexx[index], idSupplier: idSupplier[index]))
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      ListView(
                        children: <Widget>[
                          Container(
                            color: Colors.white,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: 125.0,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                'Supplier',
                                                style: TextStyle(color: AbubaPallate.greenabuba),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 175.0,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                'Score',
                                                style: TextStyle(color: AbubaPallate.greenabuba),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ExpansionTile(
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: 100.0,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'IT Supplier A',
                                                    style: TextStyle(
                                                        color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w600),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    '0123456',
                                                    style: TextStyle(
                                                        color: Colors.black38, fontSize: 12.0, fontWeight: FontWeight.w600),
                                                  ),
                                                ),
                                              ],
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
                                                '90',
                                                style: TextStyle(
                                                    color: Colors.black54, fontSize: 14.0, fontWeight: FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15.0, right: 15.0, bottom: 15.0),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                width: 60.0,
                                                child: Row(
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        'Quality',
                                                        style:
                                                        TextStyle(fontSize: 13.0, color: Colors.black54, fontWeight: FontWeight.w700),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 60.0,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        'Quantity',
                                                        style:
                                                        TextStyle(fontSize: 13.0, color: Colors.black54, fontWeight: FontWeight.w700),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 60.0,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        'Waktu',
                                                        style:
                                                        TextStyle(fontSize: 13.0, color: Colors.black54, fontWeight: FontWeight.w700),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 60.0,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        'Komunikasi',
                                                        style:
                                                        TextStyle(fontSize: 13.0, color: Colors.black54, fontWeight: FontWeight.w700),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 60.0,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        'Harga',
                                                        style:
                                                        TextStyle(fontSize: 13.0, color: Colors.black54, fontWeight: FontWeight.w700),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 2.0,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                width: 60.0,
                                                child: Row(
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        '70',
                                                        style:
                                                        TextStyle(fontSize: 14.0, color: Colors.black38, fontWeight: FontWeight.w600),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 60.0,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        '70',
                                                        style:
                                                        TextStyle(fontSize: 14.0, color: Colors.black38, fontWeight: FontWeight.w600),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 60.0,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        '70',
                                                        style:
                                                        TextStyle(fontSize: 14.0, color: Colors.black38, fontWeight: FontWeight.w600),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 60.0,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        '90',
                                                        style:
                                                        TextStyle(fontSize: 14.0, color: Colors.black38, fontWeight: FontWeight.w600),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 60.0,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        '60',
                                                        style:
                                                        TextStyle(fontSize: 14.0, color: Colors.black38, fontWeight: FontWeight.w600),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 2.0,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              ButtonTheme(
                                                padding: EdgeInsets.all(0.0),
                                                minWidth: 60.0,
                                                height: 20.0,
                                                child: OutlineButton(
                                                  child: Text(
                                                    'Detail',
                                                    style: TextStyle(
                                                        fontSize: 13.0,
                                                        color: AbubaPallate.menuBluebird),
                                                  ),
                                                  borderSide: BorderSide(
                                                      color: AbubaPallate.menuBluebird, width: 1.0),
                                                  highlightedBorderColor: AbubaPallate.menuBluebird,
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MyCustomRoute(
                                                            builder: (context) => DetailReport()));
                                                  },
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  );
            },
          )
        ),
      ),
    );
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
              'Material',
              style: TextStyle(color: Colors.grey[400]),
            ),
          ), // 1st Tab
          new Tab(
            child: Text(
              'Jasa',
              style: TextStyle(color: Colors.grey[400]),
            ),
          ), // 1st Tab
        ],
      ),
    );
  }
}
