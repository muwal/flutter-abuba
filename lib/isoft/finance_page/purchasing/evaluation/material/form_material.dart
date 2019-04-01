import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';

import 'detail_quality.dart';
import 'detail_quantity.dart';

class FormMaterial extends StatefulWidget {
  @override
  _FormMaterialState createState() => _FormMaterialState();
}

class _FormMaterialState extends State<FormMaterial>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  final List<Tab> internalAuditTabs = <Tab>[
    new Tab(child: Text('Quality', style: TextStyle(color: Colors.grey[400]))),
    new Tab(child: Text('Quantity', style: TextStyle(color: Colors.grey[400]))),
    new Tab(child: Text('Waktu', style: TextStyle(color: Colors.grey[400]))),
    new Tab(
        child: Text('Komunikasi', style: TextStyle(color: Colors.grey[400]))),
    new Tab(child: Text('Harga', style: TextStyle(color: Colors.grey[400]))),
  ];

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(vsync: this, length: internalAuditTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = new GlobalKey<ScaffoldState>();

    return SafeArea(
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: _appBar(),
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              _qualityForm(),
              _quantityForm(),
              _waktuForm(),
              _komunikasiForm(),
              _hargaForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _qualityForm() {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 100.0,
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Kode Supplier',
                        style: TextStyle(color: AbubaPallate.greenabuba),
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
                        'Nama Supplier',
                        style: TextStyle(color: AbubaPallate.greenabuba),
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
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
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
                        style: TextStyle(color: Colors.black54, fontSize: 12.0),
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
                        'PT A',
                        style: TextStyle(color: Colors.black54, fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 100.0,
                child: ButtonTheme(
                  padding: EdgeInsets.all(0.0),
                  height: 30.0,
                  child: OutlineButton(
                    child: Text(
                      '80',
                      style: TextStyle(fontSize: 13.0, color: Colors.grey),
                    ),
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    highlightedBorderColor: Colors.grey,
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
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
                        style: TextStyle(color: Colors.black54, fontSize: 12.0),
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
                        'PT A',
                        style: TextStyle(color: Colors.black54, fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 100.0,
                child: ButtonTheme(
                  padding: EdgeInsets.all(0.0),
                  height: 30.0,
                  child: OutlineButton(
                    child: Text(
                      '60',
                      style: TextStyle(fontSize: 13.0, color: Colors.red),
                    ),
                    borderSide: BorderSide(color: Colors.red, width: 1.0),
                    highlightedBorderColor: Colors.red,
                    onPressed: () {
                      Navigator.push(context,
                          MyCustomRoute(builder: (context) => DetailQuality()));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 5.0, 20.0, 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ButtonTheme(
                minWidth: 50.0,
                height: 30.0,
                child: OutlineButton(
                  child: Text(
                    'NEXT',
                    style: TextStyle(fontSize: 13.0, color: Colors.blue),
                  ),
                  borderSide: BorderSide(color: Colors.blue, width: 1.0),
                  highlightedBorderColor: Colors.blue,
                  onPressed: () {
                    _tabController.animateTo((_tabController.index + 1) % 2);
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _quantityForm() {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 100.0,
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Kode Supplier',
                        style: TextStyle(color: AbubaPallate.greenabuba),
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
                        'Nama Supplier',
                        style: TextStyle(color: AbubaPallate.greenabuba),
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
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
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
                        style: TextStyle(color: Colors.black54, fontSize: 12.0),
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
                        'PT A',
                        style: TextStyle(color: Colors.black54, fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 100.0,
                child: ButtonTheme(
                  padding: EdgeInsets.all(0.0),
                  height: 30.0,
                  child: OutlineButton(
                    child: Text(
                      '80',
                      style: TextStyle(fontSize: 13.0, color: Colors.grey),
                    ),
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    highlightedBorderColor: Colors.grey,
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
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
                        style: TextStyle(color: Colors.black54, fontSize: 12.0),
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
                        'PT A',
                        style: TextStyle(color: Colors.black54, fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 100.0,
                child: ButtonTheme(
                  padding: EdgeInsets.all(0.0),
                  height: 30.0,
                  child: OutlineButton(
                    child: Text(
                      '60',
                      style: TextStyle(fontSize: 13.0, color: Colors.red),
                    ),
                    borderSide: BorderSide(color: Colors.red, width: 1.0),
                    highlightedBorderColor: Colors.red,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MyCustomRoute(
                              builder: (context) => DetailQuantity()));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 5.0, 20.0, 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ButtonTheme(
                minWidth: 50.0,
                height: 30.0,
                child: OutlineButton(
                  child: Text(
                    'NEXT',
                    style: TextStyle(fontSize: 13.0, color: Colors.blue),
                  ),
                  borderSide: BorderSide(color: Colors.blue, width: 1.0),
                  highlightedBorderColor: Colors.blue,
                  onPressed: () {
                    _tabController.animateTo((_tabController.index + 1));
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _waktuForm() {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 100.0,
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Kode Supplier',
                        style: TextStyle(color: AbubaPallate.greenabuba),
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
                        'Nama Supplier',
                        style: TextStyle(color: AbubaPallate.greenabuba),
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
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
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
                        style: TextStyle(color: Colors.black54, fontSize: 12.0),
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
                        'PT A',
                        style: TextStyle(color: Colors.black54, fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 100.0,
                child: ButtonTheme(
                  padding: EdgeInsets.all(0.0),
                  height: 30.0,
                  child: OutlineButton(
                    child: Text(
                      '80',
                      style: TextStyle(fontSize: 13.0, color: Colors.grey),
                    ),
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    highlightedBorderColor: Colors.grey,
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
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
                        style: TextStyle(color: Colors.black54, fontSize: 12.0),
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
                        'PT A',
                        style: TextStyle(color: Colors.black54, fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 100.0,
                child: ButtonTheme(
                  padding: EdgeInsets.all(0.0),
                  height: 30.0,
                  child: OutlineButton(
                    child: Text(
                      '60',
                      style: TextStyle(fontSize: 13.0, color: Colors.red),
                    ),
                    borderSide: BorderSide(color: Colors.red, width: 1.0),
                    highlightedBorderColor: Colors.red,
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 5.0, 20.0, 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ButtonTheme(
                minWidth: 50.0,
                height: 30.0,
                child: OutlineButton(
                  child: Text(
                    'NEXT',
                    style: TextStyle(fontSize: 13.0, color: Colors.blue),
                  ),
                  borderSide: BorderSide(color: Colors.blue, width: 1.0),
                  highlightedBorderColor: Colors.blue,
                  onPressed: () {
                    _tabController.animateTo((_tabController.index + 1));
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _komunikasiForm() {
    void _showModalSheet() {
      showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            color: Color(0xFF737373),
            height: 130.0,
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: const Radius.circular(20.0),
                    topLeft: const Radius.circular(20.0),
                  ),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'HARGA',
                              style: TextStyle(
                                  color: AbubaPallate.greenabuba,
                                  fontWeight: FontWeight.w700),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 6.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'PT Supplier A',
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              '0123456',
                              style: TextStyle(color: Colors.black54),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 100.0,
                            child: ButtonTheme(
                              padding: EdgeInsets.all(0.0),
                              height: 30.0,
                              child: OutlineButton(
                                child: Text(
                                  '60',
                                  style: TextStyle(
                                      fontSize: 13.0, color: Colors.grey),
                                ),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1.0),
                                highlightedBorderColor: Colors.grey,
                                onPressed: () {},
                              ),
                            ),
                          ),
                          Container(
                            width: 100.0,
                            child: ButtonTheme(
                              padding: EdgeInsets.all(0.0),
                              height: 30.0,
                              child: OutlineButton(
                                child: Text(
                                  '70',
                                  style: TextStyle(
                                      fontSize: 13.0, color: Colors.grey),
                                ),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1.0),
                                highlightedBorderColor: Colors.grey,
                                onPressed: () {},
                              ),
                            ),
                          ),
                          Container(
                            width: 100.0,
                            child: ButtonTheme(
                              padding: EdgeInsets.all(0.0),
                              height: 30.0,
                              child: OutlineButton(
                                child: Text(
                                  '90',
                                  style: TextStyle(
                                      fontSize: 13.0, color: Colors.grey),
                                ),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1.0),
                                highlightedBorderColor: Colors.grey,
                                onPressed: () {},
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 100.0,
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'TIDAK',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                SizedBox(
                                  width: 3.0,
                                ),
                                Flexible(
                                  child: Text(
                                    'Kompetitif',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 10.0),
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
                                    'CUKUP',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                SizedBox(
                                  width: 3.0,
                                ),
                                Flexible(
                                  child: Text(
                                    'Kompetitif',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 10.0),
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
                                    'SANGAT',
                                    style: TextStyle(
                                        color: AbubaPallate.greenabuba,
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                SizedBox(
                                  width: 3.0,
                                ),
                                Flexible(
                                  child: Text(
                                    'Kompetitif',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 10.0),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )),
          );
        },
      );
    }

    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 100.0,
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Kode Supplier',
                        style: TextStyle(color: AbubaPallate.greenabuba),
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
                        'Nama Supplier',
                        style: TextStyle(color: AbubaPallate.greenabuba),
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
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
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
                        style: TextStyle(color: Colors.black54, fontSize: 12.0),
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
                        'PT A',
                        style: TextStyle(color: Colors.black54, fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 100.0,
                child: ButtonTheme(
                  padding: EdgeInsets.all(0.0),
                  height: 30.0,
                  child: OutlineButton(
                    child: Text(
                      '80',
                      style: TextStyle(fontSize: 13.0, color: Colors.grey),
                    ),
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    highlightedBorderColor: Colors.grey,
                    onPressed: _showModalSheet,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
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
                        style: TextStyle(color: Colors.black54, fontSize: 12.0),
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
                        'PT A',
                        style: TextStyle(color: Colors.black54, fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 100.0,
                child: ButtonTheme(
                  padding: EdgeInsets.all(0.0),
                  height: 30.0,
                  child: OutlineButton(
                    child: Text(
                      '60',
                      style: TextStyle(
                          fontSize: 13.0, color: AbubaPallate.menuBluebird),
                    ),
                    borderSide: BorderSide(
                        color: AbubaPallate.menuBluebird, width: 1.0),
                    highlightedBorderColor: AbubaPallate.menuBluebird,
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 5.0, 20.0, 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ButtonTheme(
                minWidth: 50.0,
                height: 30.0,
                child: OutlineButton(
                  child: Text(
                    'SAVE',
                    style: TextStyle(
                        fontSize: 13.0, color: AbubaPallate.greenabuba),
                  ),
                  borderSide:
                      BorderSide(color: AbubaPallate.greenabuba, width: 1.0),
                  highlightedBorderColor: AbubaPallate.greenabuba,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _hargaForm() {
    void _showModalSheetHarga() {
      showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            color: Color(0xFF737373),
            height: 130.0,
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: const Radius.circular(20.0),
                    topLeft: const Radius.circular(20.0),
                  ),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'PT Supplier A',
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              '0123456',
                              style: TextStyle(color: Colors.black54),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 100.0,
                            child: ButtonTheme(
                              padding: EdgeInsets.all(0.0),
                              height: 30.0,
                              child: OutlineButton(
                                child: Text(
                                  '60',
                                  style: TextStyle(
                                      fontSize: 13.0, color: Colors.grey),
                                ),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1.0),
                                highlightedBorderColor: Colors.grey,
                                onPressed: () {},
                              ),
                            ),
                          ),
                          Container(
                            width: 100.0,
                            child: ButtonTheme(
                              padding: EdgeInsets.all(0.0),
                              height: 30.0,
                              child: OutlineButton(
                                child: Text(
                                  '70',
                                  style: TextStyle(
                                      fontSize: 13.0, color: Colors.grey),
                                ),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1.0),
                                highlightedBorderColor: Colors.grey,
                                onPressed: () {},
                              ),
                            ),
                          ),
                          Container(
                            width: 100.0,
                            child: ButtonTheme(
                              padding: EdgeInsets.all(0.0),
                              height: 30.0,
                              child: OutlineButton(
                                child: Text(
                                  '90',
                                  style: TextStyle(
                                      fontSize: 13.0, color: Colors.grey),
                                ),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1.0),
                                highlightedBorderColor: Colors.grey,
                                onPressed: () {},
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 100.0,
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'TIDAK',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                SizedBox(
                                  width: 3.0,
                                ),
                                Flexible(
                                  child: Text(
                                    'Kompetitif',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 10.0),
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
                                    'CUKUP',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                SizedBox(
                                  width: 3.0,
                                ),
                                Flexible(
                                  child: Text(
                                    'Kompetitif',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 10.0),
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
                                    'SANGAT',
                                    style: TextStyle(
                                        color: AbubaPallate.greenabuba,
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                SizedBox(
                                  width: 3.0,
                                ),
                                Flexible(
                                  child: Text(
                                    'Kompetitif',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 10.0),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )),
          );
        },
      );
    }

    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 100.0,
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Kode Supplier',
                        style: TextStyle(color: AbubaPallate.greenabuba),
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
                        'Nama Supplier',
                        style: TextStyle(color: AbubaPallate.greenabuba),
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
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
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
                        style: TextStyle(color: Colors.black54, fontSize: 12.0),
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
                        'PT A',
                        style: TextStyle(color: Colors.black54, fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 100.0,
                child: ButtonTheme(
                  padding: EdgeInsets.all(0.0),
                  height: 30.0,
                  child: OutlineButton(
                    child: Text(
                      '80',
                      style: TextStyle(fontSize: 13.0, color: Colors.grey),
                    ),
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    highlightedBorderColor: Colors.grey,
                    onPressed: _showModalSheetHarga,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
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
                        style: TextStyle(color: Colors.black54, fontSize: 12.0),
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
                        'PT A',
                        style: TextStyle(color: Colors.black54, fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 100.0,
                child: ButtonTheme(
                  padding: EdgeInsets.all(0.0),
                  height: 30.0,
                  child: OutlineButton(
                    child: Text(
                      '60',
                      style: TextStyle(
                          fontSize: 13.0, color: AbubaPallate.menuBluebird),
                    ),
                    borderSide: BorderSide(
                        color: AbubaPallate.menuBluebird, width: 1.0),
                    highlightedBorderColor: AbubaPallate.menuBluebird,
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 5.0, 20.0, 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ButtonTheme(
                minWidth: 50.0,
                height: 30.0,
                child: OutlineButton(
                  child: Text(
                    'SAVE',
                    style: TextStyle(
                        fontSize: 13.0, color: AbubaPallate.greenabuba),
                  ),
                  borderSide:
                      BorderSide(color: AbubaPallate.greenabuba, width: 1.0),
                  highlightedBorderColor: AbubaPallate.greenabuba,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        )
      ],
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
        controller: _tabController,
        isScrollable: true,
        indicatorColor: AbubaPallate.greenabuba,
        tabs: internalAuditTabs,
      ),
    );
  }
}
