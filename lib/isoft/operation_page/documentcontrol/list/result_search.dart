import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/isoft/operation_page/documentcontrol/list/detail_list.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class ResultSearch extends StatefulWidget {
  final int indexSelected;
  ResultSearch({this.indexSelected});

  @override
  _ResultSearchState createState() => _ResultSearchState();
}

class _ResultSearchState extends State<ResultSearch> {
  int _number = 1;
  int _itemCount;
  int _currentIndex = 0;
  List<Map> _title = [
    {'title': 'TUJUAN', 'title_dalam' : ' '},
    {'title': 'RUANG LINGKUP', 'title_dalam':' '},
    {'title': 'REFERENSI', 'title_dalam':' '},
    {'title': 'ISTILAH', 'title_dalam':' '},
    {'title': 'CATATAN RIVISI', 'title_dalam':' '},
    {'title': 'RISIKO', 'title_dalam':' '},
    {'title': 'PROSEDUR', 'title_dalam':' '},
    {'title': 'PROSEDUR', 'title_dalam':' '},
    {'title': 'PROSEDUR', 'title_dalam':' '},
    {'title': 'PROSEDUR', 'title_dalam':' '},
    {'title': 'PROSEDUR', 'title_dalam':' '},
    {'title': 'PROSEDUR', 'title_dalam':' '},
    {'title': 'PROSEDUR', 'title_dalam':' '},
    {'title': 'PROSEDUR', 'title_dalam':' '},
    {'title': 'PROSEDUR', 'title_dalam':' '},
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
    _itemCount = _title.length;
    _controller = new SwiperController();
    super.initState();
  }

  SwiperController _controller;
  TextEditingController numberController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).cardColor;
    Color foregroundColor = Theme.of(context).accentColor;

    return SafeArea(
      child: Scaffold(
        appBar: _appBar(widget.indexSelected),
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
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Text(
                                      _title[widget.indexSelected]['title_dalam'],
                                      style: TextStyle(
                                          color: Color(0xFF2F592F),
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.bold
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            widget.indexSelected == 0
                                ? Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                                        child: Text(
                                          _title[widget.indexSelected]['subtitle_kiri'],
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 18.0
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                                        child: Text(
                                          _title[widget.indexSelected]['subtitle_kanan'],
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 18.0
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 80.0, top: 50.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      ButtonTheme(
                                        height: 30.0,
                                        minWidth: 50.0,
                                        child: OutlineButton(
                                          child: Text(
                                            'PROSEDUR',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: AbubaPallate.menuBluebird),
                                          ),
                                          borderSide: BorderSide(
                                              color: AbubaPallate.menuBluebird,
                                              width: 1.0),
                                          highlightedBorderColor: AbubaPallate.menuBluebird,
                                          onPressed: () {
                                            _controller.next(animation: true);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                                : Container(),
                            widget.indexSelected == 1
                                ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Flexible(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    itemCount: isiTujuan.length,
                                    itemBuilder: (BuildContext context, int index) {
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
                                              padding: EdgeInsets.only(left: 10.0, right: 10.0, top: top, bottom: bottom),
                                              child: Text(
                                                '${isiTujuan[index]}',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 22.0
                                                ),
                                                textAlign: TextAlign.start,
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
                            widget.indexSelected == 2
                                ? Row(
                              children: <Widget>[
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                                    child: Text(
                                      'Prosedur ini berlaku untuk seluruh material dari proses incoming / inproses / outgoing proses',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 22.0
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                              ],
                            )
                                : Container(),
                            widget.indexSelected == 3
                                ? Row(
                              children: <Widget>[
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                                    child: Text(
                                      'ISO 9001 : 2015',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 22.0
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                              ],
                            )
                                : Container(),
                            widget.indexSelected == 4
                                ? Row(
                              children: <Widget>[
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                                    child: Text(
                                      'ISO : Sistem manajemen untuk meningkatkan mutu',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 22.0
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                              ],
                            )
                                : Container(),
                            widget.indexSelected == 5
                                ? Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Text(
                                          'REV 01',
                                          style: TextStyle(
                                              color: AbubaPallate.greenabuba,
                                              fontSize: 14.0
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Text(
                                          '17 January 2018',
                                          style: TextStyle(
                                              color: AbubaPallate.greenabuba,
                                              fontSize: 14.0
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Text(
                                          'Bab 6',
                                          style: TextStyle(
                                              color: AbubaPallate.greenabuba,
                                              fontSize: 14.0
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Text(
                                          'Ridwan Kamil',
                                          style: TextStyle(
                                              color: AbubaPallate.greenabuba,
                                              fontSize: 14.0
                                          ),
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
                                        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 40.0, bottom: 10.0),
                                        child: Text(
                                          'Pengukuran suhu secara manual diganti dengan thermometer otomatis',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 22.0
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                                : Container(),
                            widget.indexSelected == 6
                                ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 40.0, bottom: 10.0),
                                        child: Text(
                                          'Kegagalan dalam penerapan procedure ini dapat menyebabkan.',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 22.0
                                          ),
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
                                    itemBuilder: (BuildContext context, int index) {
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
                                              padding: EdgeInsets.only(left: 10.0, right: 10.0, top: top, bottom: bottom),
                                              child: Text(
                                                '${isiRisiko[index]}',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 22.0
                                                ),
                                                textAlign: TextAlign.start,
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
                            widget.indexSelected == 7
                                ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 40.0, bottom: 10.0),
                                        child: Text(
                                          'Melakukan pemeriksaan kualitas sesuai spesifikasi produk',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 22.0
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                                : Container(),
                            widget.indexSelected == 8
                                ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Center(
                                  child: Container(
                                      width: 130.0,
                                      height: 130.0,
                                      color: Colors.transparent,
                                      child: FloatingActionButton(
                                        backgroundColor: Colors.green[200],
                                        shape: _DiamondBorder(),
                                        onPressed: () {},
                                        child: Icon(Icons.help_outline, color: Colors.white, size: 80.0),
                                      )
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 40.0, bottom: 10.0),
                                        child: Text(
                                          'Apakah produk sesuai spesifikasi',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 26.0
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 50.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      ButtonTheme(
                                        height: 30.0,
                                        child: OutlineButton(
                                          child: Text(
                                            'TIDAK',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Colors.redAccent),
                                          ),
                                          borderSide: BorderSide(
                                              color: Colors.redAccent,
                                              width: 1.0),
                                          highlightedBorderColor: Colors.redAccent,
                                          onPressed: () {

                                          },
                                        ),
                                      ),
                                      ButtonTheme(
                                        height: 30.0,
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
                                          highlightedBorderColor: AbubaPallate.greenabuba,
                                          onPressed: () {
                                            _controller.next(animation: true);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                                : Container(),
                            widget.indexSelected == 9
                                ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Flexible(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    itemCount: isiProsedurPage9.length,
                                    itemBuilder: (BuildContext context, int index) {
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
                                              padding: EdgeInsets.only(left: 10.0, right: 10.0, top: top, bottom: bottom),
                                              child: Text(
                                                '${index + 1}. ${isiProsedurPage9[index]}',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 22.0
                                                ),
                                                textAlign: TextAlign.start,
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
                            widget.indexSelected == 10
                                ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 40.0, bottom: 10.0),
                                        child: Text(
                                          'Menyortir produk yang tidak sesuai spesifikasi',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 22.0
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                                : Container(),
                            widget.indexSelected == 11
                                ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 40.0, bottom: 10.0),
                                        child: Text(
                                          'Mencatat produk yang tidak sesuai spesifikasi',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 22.0
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                                : Container(),
                            widget.indexSelected == 12
                                ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 40.0, bottom: 10.0),
                                        child: Text(
                                          'Info produk yang disortir kepada supplier',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 22.0
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                                : Container(),
                            widget.indexSelected == 13
                                ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 40.0, bottom: 10.0),
                                        child: Text(
                                          'Mengembalikan produk yang disortir kepada kurir',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 22.0
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                                : Container(),
                            widget.indexSelected == 14
                                ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 40.0, bottom: 10.0),
                                        child: Text(
                                          'Mengembalikan produk yang disortir kepada kurir',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 22.0
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                                : Container(),
                            widget.indexSelected == 15
                                ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Flexible(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    itemCount: isiProsedurPage9.length,
                                    itemBuilder: (BuildContext context, int index) {
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
                                              padding: EdgeInsets.only(left: 10.0, right: 10.0, top: top, bottom: bottom),
                                              child: Text(
                                                '${index + 1}. ${isiProsedurPage9[index]}',
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 22.0
                                                ),
                                                textAlign: TextAlign.start,
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
                          ],
                        )
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                  ],
                ),
              ],
            )
        ),
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
              child: Center()
          ),
          decoration: BoxDecoration(
              color: Color(0xFF2F592F)
          )
      ),
    );
  }

  Widget _appBar(int indexSelected) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          Navigator.pushReplacement(context,
              MyCustomRoute(
                  builder: (context) => FormDetail()
              )
          );
        },
      ),
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
                          '${widget.indexSelected}. ${_title[widget.indexSelected]['title']}',
                          style:
                          TextStyle(color: Colors.white, fontSize: 12.0),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Color(0xFF2F592F)
                  )
              ),
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
                              'Detail List',
                              style:
                              TextStyle(color: Colors.black54, fontSize: 16.0),
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              '',
                              style:
                              TextStyle(color: Colors.black54, fontSize: 16.0),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Document Control ',
                              style:
                              TextStyle(color: Colors.black54, fontSize: 12.0),
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              '',
                              style:
                              TextStyle(color: Colors.black54, fontSize: 12.0),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ],
                    )
                ),
              ),
            ),
          ],
        ),
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
  Path getInnerPath(Rect rect, { TextDirection textDirection }) {
    return getOuterPath(rect, textDirection: textDirection);
  }

  @override
  Path getOuterPath(Rect rect, { TextDirection textDirection }) {
    return Path()
      ..moveTo(rect.left + rect.width / 2.0, rect.top)
      ..lineTo(rect.right, rect.top + rect.height / 2.0)
      ..lineTo(rect.left + rect.width  / 2.0, rect.bottom)
      ..lineTo(rect.left, rect.top + rect.height / 2.0)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, { TextDirection textDirection }) {}

  // This border doesn't support scaling.
  @override
  ShapeBorder scale(double t) {
    return null;
  }
}