import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'form_summary.dart';

class FormDetail extends StatefulWidget {
  @override
  _FormDetailState createState() => _FormDetailState();
}

class _FormDetailState extends State<FormDetail> {
  int _number = 1;
  int _itemCount;
  int _currentIndex;
  bool _autoplay;
  List<Map> _title = [
    {
      'title': 'COVER',
      'title_dalam': 'PEMERIKSAAN PRODUK',
      'subtitle_kiri': '',
      'subtitle_kanan': ''
    },
    {'title': '1. TUJUAN', 'title_dalam': ' '},
    {'title': '2. RUANG LINGKUP', 'title_dalam': ' '},
    {'title': '3. REFERENSI', 'title_dalam': ' '},
    {'title': '4. ISTILAH', 'title_dalam': ' '},
    {'title': '5. CATATAN REVISI', 'title_dalam': ' '},
    {'title': '6. RISIKO', 'title_dalam': ' '},
    {'title': '7. PROSEDUR', 'title_dalam': ' '},
    {'title': '7. PROSEDUR', 'title_dalam': ' '},
    {'title': '7. PROSEDUR', 'title_dalam': ' '},
    {'title': '7. PROSEDUR', 'title_dalam': ' '},
    {'title': '7. PROSEDUR', 'title_dalam': ' '},
    {'title': '7. PROSEDUR', 'title_dalam': ' '},
    {'title': '7. PROSEDUR', 'title_dalam': ' '},
    {'title': '7. PROSEDUR', 'title_dalam': ' '},
    {'title': '7. PROSEDUR', 'title_dalam': ' '},
  ];

  List<String> isiTujuan = [
    'a. Memastikan agar material dan produk diperiksa',
    'b. Menjamin spesifikasi produk yang diproses sesuai dengan standar perusahaan',
  ];

  List<String> isiRisiko = [
    'a. Risiko terjadinya ketidaksesuaian spesifikasi produk',
    'b. Penurunan kualitas produk yang akan ataupun yang sudah diproduksi',
  ];

  List<String> isiProsedurPage9 = [
    'Menerima produk',
    'Menandatangani dokument',
  ];

  int _indexBantu = 0;

  @override
  void initState() {
    _currentIndex = 0;
    _autoplay = false;
    _itemCount = _title.length;
    _controller = new SwiperController();
    super.initState();
  }

  SwiperController _controller;
  TextEditingController numberController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              child: new Text(
                "COVER",
                style: TextStyle(color: Colors.white),
              ),
            ),
            content: new Text("Alert Dialog body"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              ButtonTheme(
                minWidth: 50.0,
                child: OutlineButton(
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontSize: 13.0, color: Colors.black54),
                  ),
                  borderSide: BorderSide(color: Colors.black54, width: 1.0),
                  highlightedBorderColor: Colors.black54,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              ButtonTheme(
                minWidth: 50.0,
                child: RaisedButton(
                  child: Text(
                    'Save',
                    style: TextStyle(fontSize: 13.0, color: Colors.white),
                  ),
                  color: AbubaPallate.greenabuba,
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

    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        backgroundColor: Colors.white,
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        _indexBantu = index - 1;

                        return new Container(
                            color: Colors.white,
                            alignment: Alignment.center,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Text(
                                          _title[index]['title_dalam'],
                                          style: TextStyle(
                                              color: Color(0xFF2F592F),
                                              fontSize: 24.0,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                index == 0
                                    ? Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 20.0),
                                                  child: Text(
                                                    _title[index]
                                                        ['subtitle_kiri'],
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 18.0),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 20.0),
                                                  child: Text(
                                                    _title[index]
                                                        ['subtitle_kanan'],
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
                                            padding: const EdgeInsets.only(
                                                right: 50.0, top: 50.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[
                                                ButtonTheme(
                                                  height: 30.0,
                                                  minWidth: 50.0,
                                                  child: OutlineButton(
                                                    child: Text(
                                                      'Review',
                                                      style: TextStyle(
                                                          fontSize: 16.0,
                                                          color: AbubaPallate
                                                              .menuBluebird),
                                                    ),
                                                    borderSide: BorderSide(
                                                        color: AbubaPallate
                                                            .menuBluebird,
                                                        width: 1.0),
                                                    highlightedBorderColor:
                                                        AbubaPallate
                                                            .menuBluebird,
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
                                          )
                                        ],
                                      )
                                    : Container(),
                                index == 1
                                    ? Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Flexible(
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              physics: ScrollPhysics(),
                                              itemCount: isiTujuan.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                double top;
                                                double bottom;
                                                if (index == 0) {
                                                  top = 30.0;
                                                  bottom = 0.0;
                                                } else {
                                                  top = 20.0;
                                                  bottom = 0.0;
                                                }

                                                return Row(
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10.0,
                                                                right: 10.0,
                                                                top: top,
                                                                bottom: bottom),
                                                        child: Text(
                                                          '${isiTujuan[index]}',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 26.0),
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                          SizedBox(height: 25.0,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              ButtonTheme(
                                                height: 30.0,
                                                minWidth: 50.0,
                                                child: OutlineButton(
                                                  child: Text(
                                                    'Review',
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: AbubaPallate
                                                            .menuBluebird),
                                                  ),
                                                  borderSide: BorderSide(
                                                      color: AbubaPallate
                                                          .menuBluebird,
                                                      width: 1.0),
                                                  highlightedBorderColor:
                                                  AbubaPallate
                                                      .menuBluebird,
                                                  onPressed: () {
                                                    setState(() {
                                                      _showDialog();
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    : Container(),
                                index == 2
                                    ? Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10.0,
                                                      right: 10.0,
                                                      top: 10.0,
                                                      bottom: 10.0),
                                                  child: Text(
                                                    'Prosedur ini berlaku untuk seluruh material dari proses incoming / inproses / outgoing proses',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 26.0),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 25.0,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              ButtonTheme(
                                                height: 30.0,
                                                minWidth: 50.0,
                                                child: OutlineButton(
                                                  child: Text(
                                                    'Review',
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: AbubaPallate
                                                            .menuBluebird),
                                                  ),
                                                  borderSide: BorderSide(
                                                      color: AbubaPallate
                                                          .menuBluebird,
                                                      width: 1.0),
                                                  highlightedBorderColor:
                                                  AbubaPallate
                                                      .menuBluebird,
                                                  onPressed: () {
                                                    setState(() {
                                                      _showDialog();
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    : Container(),
                                index == 3
                                    ? Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10.0,
                                                      right: 10.0,
                                                      top: 10.0,
                                                      bottom: 10.0),
                                                  child: Text(
                                                    'ISO 9001 : 2015',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 26.0),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 25.0,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              ButtonTheme(
                                                height: 30.0,
                                                minWidth: 50.0,
                                                child: OutlineButton(
                                                  child: Text(
                                                    'Review',
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: AbubaPallate
                                                            .menuBluebird),
                                                  ),
                                                  borderSide: BorderSide(
                                                      color: AbubaPallate
                                                          .menuBluebird,
                                                      width: 1.0),
                                                  highlightedBorderColor:
                                                  AbubaPallate
                                                      .menuBluebird,
                                                  onPressed: () {
                                                    setState(() {
                                                      _showDialog();
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    : Container(),
                                index == 4
                                    ? Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10.0,
                                                      right: 10.0,
                                                      top: 10.0,
                                                      bottom: 10.0),
                                                  child: Text(
                                                    'ISO : Sistem manajemen untuk meningkatkan mutu',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 26.0),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 25.0,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              ButtonTheme(
                                                height: 30.0,
                                                minWidth: 50.0,
                                                child: OutlineButton(
                                                  child: Text(
                                                    'Review',
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: AbubaPallate
                                                            .menuBluebird),
                                                  ),
                                                  borderSide: BorderSide(
                                                      color: AbubaPallate
                                                          .menuBluebird,
                                                      width: 1.0),
                                                  highlightedBorderColor:
                                                  AbubaPallate
                                                      .menuBluebird,
                                                  onPressed: () {
                                                    setState(() {
                                                      _showDialog();
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    : Container(),
                                index == 5
                                    ? Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                                  child: Text(
                                                    'REV 01',
                                                    style: TextStyle(
                                                        color: AbubaPallate
                                                            .greenabuba,
                                                        fontSize: 16.0),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                                  child: Text(
                                                    '17 January 2018',
                                                    style: TextStyle(
                                                        color: AbubaPallate
                                                            .greenabuba,
                                                        fontSize: 16.0),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                                  child: Text(
                                                    'Bab 6',
                                                    style: TextStyle(
                                                        color: AbubaPallate
                                                            .greenabuba,
                                                        fontSize: 16.0),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                                  child: Text(
                                                    'Ridwan Kamil',
                                                    style: TextStyle(
                                                        color: AbubaPallate
                                                            .greenabuba,
                                                        fontSize: 16.0),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10.0,
                                                      right: 10.0,
                                                      top: 40.0,
                                                      bottom: 10.0),
                                                  child: Text(
                                                    'Pengukuran suhu secara manual diganti dengan thermometer otomatis',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 26.0),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    : Container(),
                                index == 6
                                    ? Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10.0,
                                                      right: 10.0,
                                                      top: 40.0,
                                                      bottom: 10.0),
                                                  child: Text(
                                                    'Kegagalan dalam penerapan procedure ini dapat menyebabkan.',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 26.0),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Flexible(
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              physics: ScrollPhysics(),
                                              itemCount: isiRisiko.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                double top;
                                                double bottom;
                                                if (index == 0) {
                                                  top = 30.0;
                                                  bottom = 0.0;
                                                } else {
                                                  top = 20.0;
                                                  bottom = 0.0;
                                                }

                                                return Row(
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10.0,
                                                                right: 10.0,
                                                                top: top,
                                                                bottom: bottom),
                                                        child: Text(
                                                          '${isiRisiko[index]}',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 26.0),
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          )
                                        ],
                                      )
                                    : Container(),
                                index == 7
                                    ? Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Center(
                                            child: Container(
                                              width: 150.0,
                                              height: 30.0,
                                              color: Colors.grey[200],
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      'MOD',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Container(
                                              width: 150.0,
                                              height: 60.0,
                                              color: Colors.grey[500],
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(''),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10.0,
                                                      right: 10.0,
                                                      top: 40.0,
                                                      bottom: 10.0),
                                                  child: Text(
                                                    'Melakukan pemeriksaan kualitas sesuai spesifikasi produk',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 26.0),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    : Container(),
                                index == 8
                                    ? Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Center(
                                            child: Container(
                                              width: 150.0,
                                              height: 100.0,
                                              color: Colors.green[200],
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Icon(
                                                      Icons.help_outline,
                                                      color: Colors.white,
                                                      size: 80.0,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          /*Transform.rotate(
                                      angle: 0.8,
                                      child: Container(
                                        height: 100.0,
                                        width: 100.0,
                                        color: Colors.pink,
                                      ),
                                    ),*/
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                                        fontSize: 26.0),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 50.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: <Widget>[
                                                ButtonTheme(
                                                  height: 30.0,
                                                  child: OutlineButton(
                                                    child: Text(
                                                      'TIDAK',
                                                      style: TextStyle(
                                                          fontSize: 16.0,
                                                          color:
                                                              Colors.redAccent),
                                                    ),
                                                    borderSide: BorderSide(
                                                        color: Colors.redAccent,
                                                        width: 1.0),
                                                    highlightedBorderColor:
                                                        Colors.redAccent,
                                                    onPressed: () {},
                                                  ),
                                                ),
                                                ButtonTheme(
                                                  height: 30.0,
                                                  child: OutlineButton(
                                                    child: Text(
                                                      'YA',
                                                      style: TextStyle(
                                                          fontSize: 16.0,
                                                          color: AbubaPallate
                                                              .greenabuba),
                                                    ),
                                                    borderSide: BorderSide(
                                                        color: AbubaPallate
                                                            .greenabuba,
                                                        width: 1.0),
                                                    highlightedBorderColor:
                                                        AbubaPallate.greenabuba,
                                                    onPressed: () {
                                                      _controller.next(
                                                          animation: true);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 25.0,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              ButtonTheme(
                                                height: 30.0,
                                                minWidth: 50.0,
                                                child: OutlineButton(
                                                  child: Text(
                                                    'Review',
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: AbubaPallate
                                                            .menuBluebird),
                                                  ),
                                                  borderSide: BorderSide(
                                                      color: AbubaPallate
                                                          .menuBluebird,
                                                      width: 1.0),
                                                  highlightedBorderColor:
                                                  AbubaPallate
                                                      .menuBluebird,
                                                  onPressed: () {
                                                    setState(() {
                                                      _showDialog();
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    : Container(),
                                index == 9
                                    ? Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Center(
                                            child: Container(
                                              width: 150.0,
                                              height: 30.0,
                                              color: Colors.grey[200],
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      'MOD',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Container(
                                              width: 150.0,
                                              height: 60.0,
                                              color: Colors.green[300],
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(''),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              physics: ScrollPhysics(),
                                              itemCount:
                                                  isiProsedurPage9.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                double top;
                                                double bottom;
                                                if (index == 0) {
                                                  top = 30.0;
                                                  bottom = 0.0;
                                                } else {
                                                  top = 20.0;
                                                  bottom = 0.0;
                                                }

                                                return Row(
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10.0,
                                                                right: 10.0,
                                                                top: top,
                                                                bottom: bottom),
                                                        child: Text(
                                                          '${index + 1}. ${isiProsedurPage9[index]}',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 26.0),
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          )
                                        ],
                                      )
                                    : Container(),
                                index == 10
                                    ? Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Center(
                                            child: Container(
                                              width: 150.0,
                                              height: 30.0,
                                              color: Colors.grey[200],
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      'MOD',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Container(
                                              width: 150.0,
                                              height: 60.0,
                                              color: Colors.red[400],
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(''),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10.0,
                                                      right: 10.0,
                                                      top: 40.0,
                                                      bottom: 10.0),
                                                  child: Text(
                                                    'Menyortir produk yang tidak sesuai spesifikasi',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 26.0),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    : Container(),
                                index == 11
                                    ? Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Center(
                                            child: Container(
                                              width: 150.0,
                                              height: 30.0,
                                              color: Colors.grey[200],
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      'MOD',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Container(
                                              width: 150.0,
                                              height: 60.0,
                                              color: Colors.grey[500],
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(''),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10.0,
                                                      right: 10.0,
                                                      top: 40.0,
                                                      bottom: 10.0),
                                                  child: Text(
                                                    'Mencatat produk yang tidak sesuai spesifikasi',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 26.0),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    : Container(),
                                index == 12
                                    ? Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Center(
                                            child: Container(
                                              width: 150.0,
                                              height: 30.0,
                                              color: Colors.grey[200],
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      'MOD',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Container(
                                              width: 150.0,
                                              height: 60.0,
                                              color: Colors.grey[500],
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(''),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10.0,
                                                      right: 10.0,
                                                      top: 40.0,
                                                      bottom: 10.0),
                                                  child: Text(
                                                    'Info produk yang disortir kepada supplier',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 26.0),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    : Container(),
                                index == 13
                                    ? Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Center(
                                            child: Container(
                                              width: 150.0,
                                              height: 30.0,
                                              color: Colors.grey[200],
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      'MOD',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Container(
                                              width: 150.0,
                                              height: 60.0,
                                              color: Colors.grey[500],
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(''),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10.0,
                                                      right: 10.0,
                                                      top: 40.0,
                                                      bottom: 10.0),
                                                  child: Text(
                                                    'Mengembalikan produk yang disortir kepada kurir',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 26.0),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    : Container(),
                                index == 14
                                    ? Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Center(
                                            child: Container(
                                              width: 150.0,
                                              height: 30.0,
                                              color: Colors.grey[200],
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      'MOD',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Container(
                                              width: 150.0,
                                              height: 60.0,
                                              color: Colors.grey[500],
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(''),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10.0,
                                                      right: 10.0,
                                                      top: 40.0,
                                                      bottom: 10.0),
                                                  child: Text(
                                                    'Mengembalikan produk yang disortir kepada kurir',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 26.0),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    : Container(),
                                index == 15
                                    ? Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Center(
                                            child: Container(
                                              width: 150.0,
                                              height: 30.0,
                                              color: Colors.grey[200],
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      'MOD',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Container(
                                              width: 150.0,
                                              height: 60.0,
                                              color: Colors.grey[500],
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(''),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              physics: ScrollPhysics(),
                                              itemCount:
                                                  isiProsedurPage9.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                double top;
                                                double bottom;
                                                if (index == 0) {
                                                  top = 30.0;
                                                  bottom = 0.0;
                                                } else {
                                                  top = 20.0;
                                                  bottom = 0.0;
                                                }

                                                return Row(
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10.0,
                                                                right: 10.0,
                                                                top: top,
                                                                bottom: bottom),
                                                        child: Text(
                                                          '${index + 1}. ${isiProsedurPage9[index]}',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 26.0),
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                          SizedBox(height: 25.0,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              ButtonTheme(
                                                height: 30.0,
                                                minWidth: 50.0,
                                                child: OutlineButton(
                                                  child: Text(
                                                    'Review',
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: AbubaPallate
                                                            .menuBluebird),
                                                  ),
                                                  borderSide: BorderSide(
                                                      color: AbubaPallate
                                                          .menuBluebird,
                                                      width: 1.0),
                                                  highlightedBorderColor:
                                                  AbubaPallate
                                                      .menuBluebird,
                                                  onPressed: () {
                                                    setState(() {
                                                      _showDialog();
                                                    });
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5.0,
                                              ),
                                              ButtonTheme(
                                                height: 30.0,
                                                minWidth: 50.0,
                                                child: RaisedButton(
                                                  child: Text(
                                                    'Save',
                                                    style: TextStyle(fontSize: 13.0, color: Colors.white),
                                                  ),
                                                  color: AbubaPallate.greenabuba,
                                                  onPressed: () {
                                                    Navigator.push(context,
                                                        MyCustomRoute(builder: (context) => FormSum()));
                                                  },
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    : Container(),
                              ],
                            ));
                      },
                      controller: _controller,
                      autoplay: _autoplay,
                      itemCount: _title.length,
                      itemWidth: MediaQuery.of(context).size.width,
                      itemHeight: MediaQuery.of(context).size.height - 250.0,
                      index: _currentIndex,
                      layout: SwiperLayout.TINDER,
                      onIndexChanged: (int index) {
                        setState(() {
                          _currentIndex = index;
                          _number = index + 1;
                        });
                      },
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                  ],
                ),
              ],
            )),
        bottomNavigationBar: _bottomBar(),
      ),
    );
  }

  _bottomBar() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 55.0,
      child: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _number - 1 == 15 || _number - 1 == 9
                    ? Container(
                        child: ButtonTheme(
                          minWidth: 50.0,
                          height: 30.0,
                          child: RaisedButton(
                            child: Text(
                              'SELESAI',
                              style: TextStyle(fontSize: 13.0),
                            ),
                            textColor: Colors.black45,
                            color: Colors.green[200],
                            onPressed: () {},
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                      )
                    : Container(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () {
                        _controller.previous(animation: true);
                      },
                      tooltip: 'Previous',
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                      onPressed: () {
                        _controller.next(animation: true);
                      },
                      tooltip: 'Next',
                    ),
                  ],
                )
              ],
            ),
          ),
          decoration: BoxDecoration(color: Color(0xFF2F592F))),
    );
  }

  Widget _appBar() {
    int _ofAll = _title.length - 1;
    int _ofDepan = _number - 1;

    return AppBar(
      elevation: 0.25,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      title: Image.asset(
        'assets/images/logo.png',
        height: 100.0,
        width: 120.0,
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(110.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 55.0,
              child: Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          _title[_currentIndex]['title'],
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                          textAlign: TextAlign.start,
                        ),
                        _ofDepan == 0
                            ? Container()
                            : Text(
                                '${_ofDepan.toString()} of ${_ofAll.toString()}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12.0),
                                textAlign: TextAlign.start,
                              ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(color: Color(0xFF2F592F))),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 55.0,
              child: Container(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Detail Review',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 16.0),
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              '',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 16.0),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Document Control ',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 12.0),
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              '',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 12.0),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
