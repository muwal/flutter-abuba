import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';

class ReviewRevisi extends StatefulWidget {
  @override
  _ReviewRevisiState createState() => _ReviewRevisiState();
}

class _ReviewRevisiState extends State<ReviewRevisi>
    with TickerProviderStateMixin {
  TabController _cardController;
  TabPageSelector _tabPageSelector;

  List<Map> myList = [
    {"nomor": 1},
    {"nomor": 2},
    {"nomor": 3},
    {"nomor": 4},
  ];

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
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                color: AbubaPallate.greenabuba,
                padding: EdgeInsets.all(12.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Review Revisi',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
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
                child:
                    TabBarView(controller: _cardController, children: <Widget>[
                  _buildForm1(),
                  _buildForm2(),
                  _buildForm3(),
                  _buildForm4(),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm1() {
    void _showDialog() {
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
              child: Center(
                child: new Text(
                  "Thank You Ridwan",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            content: new Text("Alert Dialog body"),
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

    return Scrollbar(
      child: ListView(
        children: <Widget>[
          Container(
            color: Colors.grey[200],
            margin: EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.border_color,
                        color: AbubaPallate.greenabuba,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Flexible(
                        child: Text(
                          'Edit Halaman',
                          style: TextStyle(color: AbubaPallate.greenabuba),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Text('BEFORE'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        color: AbubaPallate.greenabuba,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'COVER',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                '1 of 15',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12.0),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        height: 150.0,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(12.0),
                        child: Center(child: Text('PEMERIKSAAN PRODUK')),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 15.0,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Text('AFTER'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        color: AbubaPallate.greenabuba,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'COVER',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                '1 of 15',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12.0),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        height: 150.0,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(12.0),
                        child: Center(
                          child: Text(
                            'PEMERIKSAAN MAKANAN',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ButtonTheme(
                        minWidth: 50.0,
                        child: OutlineButton(
                          child: Text(
                            'SUBMIT',
                            style: TextStyle(
                                fontSize: 13.0, color: AbubaPallate.greenabuba),
                          ),
                          borderSide: BorderSide(
                              color: AbubaPallate.greenabuba, width: 1.0),
                          highlightedBorderColor: AbubaPallate.greenabuba,
                          onPressed: () {
                            setState(
                              () {
                                _showDialog();
                              },
                            );
                          },
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

  Widget _buildForm2() {
    void _showDialog() {
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
              child: Center(
                child: new Text(
                  "Thank You Ridwan",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            content: new Text("Alert Dialog body"),
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

    return Scrollbar(
      child: ListView(
        children: <Widget>[
          Container(
            color: Colors.grey[200],
            margin: EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.chrome_reader_mode,
                        color: AbubaPallate.greenabuba,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Flexible(
                        child: Text(
                          'Tambah Proses',
                          style: TextStyle(color: AbubaPallate.greenabuba),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Text('BEFORE'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        color: AbubaPallate.greenabuba,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'COVER',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                '1 of 15',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12.0),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        height: 150.0,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(12.0),
                        child: Center(child: Text('PEMERIKSAAN PRODUK')),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 15.0,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Text('AFTER'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        color: AbubaPallate.greenabuba,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'COVER',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                '1 of 15',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12.0),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        height: 150.0,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(12.0),
                        child: Center(
                          child: Text(
                            'PEMERIKSAAN MAKANAN',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ButtonTheme(
                        minWidth: 50.0,
                        child: OutlineButton(
                          child: Text(
                            'SUBMIT',
                            style: TextStyle(
                                fontSize: 13.0, color: AbubaPallate.greenabuba),
                          ),
                          borderSide: BorderSide(
                              color: AbubaPallate.greenabuba, width: 1.0),
                          highlightedBorderColor: AbubaPallate.greenabuba,
                          onPressed: () {
                            setState(
                              () {
                                _showDialog();
                              },
                            );
                          },
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

  Widget _buildForm3() {
    void _showDialog() {
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
              child: Center(
                child: new Text(
                  "Thank You Ridwan",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            content: new Text("Alert Dialog body"),
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

    return Scrollbar(
      child: ListView(
        children: <Widget>[
          Container(
            color: Colors.grey[200],
            margin: EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.help_outline,
                        color: AbubaPallate.greenabuba,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Flexible(
                        child: Text(
                          'Tambah Option',
                          style: TextStyle(color: AbubaPallate.greenabuba),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Text('BEFORE'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        color: AbubaPallate.greenabuba,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                '7. PROSEDUR',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                '7 of 15',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12.0),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        height: 300.0,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(12.0),
                        child: Column(
                          children: <Widget>[
                            Center(
                              child: Container(
                                width: 120.0,
                                height: 120.0,
                                color: Colors.transparent,
                                child: FloatingActionButton(
                                  backgroundColor: Colors.green[200],
                                  shape: _DiamondBorder(),
                                  onPressed: () {},
                                  child: Icon(Icons.help_outline,
                                      color: Colors.white, size: 80.0),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 10.0,
                                        right: 10.0,
                                        top: 40.0,
                                        bottom: 10.0),
                                    child: Text(
                                      'Apakah produk sesuai spesifikasi',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18.0),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 0.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  ButtonTheme(
                                    height: 20.0,
                                    child: OutlineButton(
                                      child: Text(
                                        'TIDAK',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.redAccent),
                                      ),
                                      borderSide: BorderSide(
                                          color: Colors.redAccent, width: 1.0),
                                      highlightedBorderColor: Colors.redAccent,
                                      onPressed: () {},
                                    ),
                                  ),
                                  ButtonTheme(
                                    height: 20.0,
                                    child: OutlineButton(
                                      child: Text(
                                        'YA',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: AbubaPallate.greenabuba),
                                      ),
                                      borderSide: BorderSide(
                                          color: AbubaPallate.greenabuba,
                                          width: 1.0),
                                      highlightedBorderColor:
                                          AbubaPallate.greenabuba,
                                      onPressed: () {},
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
                Divider(
                  height: 15.0,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Text('AFTER'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        color: AbubaPallate.greenabuba,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'COVER',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                '1 of 15',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12.0),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        height: 300.0,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(12.0),
                        child: Column(
                          children: <Widget>[
                            Center(
                              child: Container(
                                width: 120.0,
                                height: 120.0,
                                color: Colors.transparent,
                                child: FloatingActionButton(
                                  backgroundColor: Colors.green[200],
                                  shape: _DiamondBorder(),
                                  onPressed: () {},
                                  child: Icon(Icons.help_outline,
                                      color: Colors.white, size: 80.0),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 10.0,
                                        right: 10.0,
                                        top: 40.0,
                                        bottom: 10.0),
                                    child: Text(
                                      'Apakah produk dapat diterima?',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18.0),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 0.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  ButtonTheme(
                                    height: 20.0,
                                    child: OutlineButton(
                                      child: Text(
                                        'TIDAK',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.redAccent),
                                      ),
                                      borderSide: BorderSide(
                                          color: Colors.redAccent, width: 1.0),
                                      highlightedBorderColor: Colors.redAccent,
                                      onPressed: () {},
                                    ),
                                  ),
                                  ButtonTheme(
                                    height: 20.0,
                                    child: OutlineButton(
                                      child: Text(
                                        'YA',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: AbubaPallate.greenabuba),
                                      ),
                                      borderSide: BorderSide(
                                          color: AbubaPallate.greenabuba,
                                          width: 1.0),
                                      highlightedBorderColor:
                                          AbubaPallate.greenabuba,
                                      onPressed: () {},
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
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ButtonTheme(
                        minWidth: 50.0,
                        child: OutlineButton(
                          child: Text(
                            'SUBMIT',
                            style: TextStyle(
                                fontSize: 13.0, color: AbubaPallate.greenabuba),
                          ),
                          borderSide: BorderSide(
                              color: AbubaPallate.greenabuba, width: 1.0),
                          highlightedBorderColor: AbubaPallate.greenabuba,
                          onPressed: () {
                            setState(
                              () {
                                _showDialog();
                              },
                            );
                          },
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

  Widget _buildForm4() {
    void _showDialog() {
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
              child: Center(
                child: new Text(
                  "Thank You Ridwan",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            content: new Text("Alert Dialog body"),
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

    return Scrollbar(
      child: ListView(
        children: <Widget>[
          Container(
            color: Colors.grey[200],
            margin: EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Flexible(
                        child: Text(
                          'Delete Halaman',
                          style: TextStyle(color: AbubaPallate.greenabuba),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Text('BEFORE'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        color: AbubaPallate.greenabuba,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                '7. PROSEDUR',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                '7 of 15',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12.0),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        height: 300.0,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(12.0),
                        child: Column(
                          children: <Widget>[
                            Center(
                              child: Container(
                                width: 120.0,
                                height: 120.0,
                                color: Colors.transparent,
                                child: FloatingActionButton(
                                  backgroundColor: Colors.green[200],
                                  shape: _DiamondBorder(),
                                  onPressed: () {},
                                  child: Icon(Icons.help_outline,
                                      color: Colors.white, size: 80.0),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 10.0,
                                        right: 10.0,
                                        top: 40.0,
                                        bottom: 10.0),
                                    child: Text(
                                      'Apakah produk sesuai spesifikasi',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18.0),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 0.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  ButtonTheme(
                                    height: 20.0,
                                    child: OutlineButton(
                                      child: Text(
                                        'TIDAK',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.redAccent),
                                      ),
                                      borderSide: BorderSide(
                                          color: Colors.redAccent, width: 1.0),
                                      highlightedBorderColor: Colors.redAccent,
                                      onPressed: () {},
                                    ),
                                  ),
                                  ButtonTheme(
                                    height: 20.0,
                                    child: OutlineButton(
                                      child: Text(
                                        'YA',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: AbubaPallate.greenabuba),
                                      ),
                                      borderSide: BorderSide(
                                          color: AbubaPallate.greenabuba,
                                          width: 1.0),
                                      highlightedBorderColor:
                                          AbubaPallate.greenabuba,
                                      onPressed: () {},
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
                Divider(
                  height: 15.0,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Text('AFTER'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        color: AbubaPallate.greenabuba,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'COVER',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                '1 of 15',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12.0),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        height: 300.0,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(12.0),
                        child: Column(
                          children: <Widget>[
                            Center(
                              child: Container(
                                width: 120.0,
                                height: 120.0,
                                color: Colors.transparent,
                                child: FloatingActionButton(
                                  backgroundColor: Colors.green[200],
                                  shape: _DiamondBorder(),
                                  onPressed: () {},
                                  child: Icon(Icons.help_outline,
                                      color: Colors.white, size: 80.0),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 10.0,
                                        right: 10.0,
                                        top: 40.0,
                                        bottom: 10.0),
                                    child: Text(
                                      'Apakah produk dapat diterima?',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 18.0),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 0.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  ButtonTheme(
                                    height: 20.0,
                                    child: OutlineButton(
                                      child: Text(
                                        'TIDAK',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.redAccent),
                                      ),
                                      borderSide: BorderSide(
                                          color: Colors.redAccent, width: 1.0),
                                      highlightedBorderColor: Colors.redAccent,
                                      onPressed: () {},
                                    ),
                                  ),
                                  ButtonTheme(
                                    height: 20.0,
                                    child: OutlineButton(
                                      child: Text(
                                        'YA',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: AbubaPallate.greenabuba),
                                      ),
                                      borderSide: BorderSide(
                                          color: AbubaPallate.greenabuba,
                                          width: 1.0),
                                      highlightedBorderColor:
                                          AbubaPallate.greenabuba,
                                      onPressed: () {},
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
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ButtonTheme(
                        minWidth: 50.0,
                        child: OutlineButton(
                          child: Text(
                            'SUBMIT',
                            style: TextStyle(
                                fontSize: 13.0, color: AbubaPallate.greenabuba),
                          ),
                          borderSide: BorderSide(
                              color: AbubaPallate.greenabuba, width: 1.0),
                          highlightedBorderColor: AbubaPallate.greenabuba,
                          onPressed: () {
                            setState(
                              () {
                                _showDialog();
                              },
                            );
                          },
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

class _DiamondBorder extends ShapeBorder {
  const _DiamondBorder();

  @override
  EdgeInsetsGeometry get dimensions {
    return const EdgeInsets.only();
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    return getOuterPath(rect, textDirection: textDirection);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    return Path()
      ..moveTo(rect.left + rect.width / 2.0, rect.top)
      ..lineTo(rect.right, rect.top + rect.height / 2.0)
      ..lineTo(rect.left + rect.width / 2.0, rect.bottom)
      ..lineTo(rect.left, rect.top + rect.height / 2.0)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {}

  // This border doesn't support scaling.
  @override
  ShapeBorder scale(double t) {
    return null;
  }
}
