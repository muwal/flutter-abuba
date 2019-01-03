import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'detail_quality.dart';
import 'detail_quantity.dart';
import 'detail_waktu.dart';

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
    return SafeArea(
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: _appBar(),
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              _QualityForm(),
              _QuantityForm(),
              _WaktuForm(),
              _KomunikasiForm(),
              _HargaForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _QualityForm() {
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

  Widget _QuantityForm() {
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
                          MyCustomRoute(builder: (context) => DetailQuantity()));
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

  Widget _WaktuForm() {
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

  Widget _KomunikasiForm() {
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
                      style: TextStyle(fontSize: 13.0, color: AbubaPallate.menuBluebird),
                    ),
                    borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                    highlightedBorderColor: AbubaPallate.menuBluebird,
                    onPressed: () {

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
                    'SAVE',
                    style: TextStyle(fontSize: 13.0, color: AbubaPallate.greenabuba),
                  ),
                  borderSide: BorderSide(color: AbubaPallate.greenabuba, width: 1.0),
                  highlightedBorderColor: AbubaPallate.greenabuba,
                  onPressed: () {

                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _HargaForm() {
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
                      style: TextStyle(fontSize: 13.0, color: AbubaPallate.menuBluebird),
                    ),
                    borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                    highlightedBorderColor: AbubaPallate.menuBluebird,
                    onPressed: () {
                      Navigator.push(context,
                          MyCustomRoute(builder: (context) => DetailWaktu()));
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
                    'SAVE',
                    style: TextStyle(fontSize: 13.0, color: AbubaPallate.greenabuba),
                  ),
                  borderSide: BorderSide(color: AbubaPallate.greenabuba, width: 1.0),
                  highlightedBorderColor: AbubaPallate.greenabuba,
                  onPressed: () {

                  },
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
            'assets/images/logo.png',
            height: 100.0,
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
