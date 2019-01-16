import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:math' as math;

import 'review_revisi.dart';

class FormDetail extends StatefulWidget {
  @override
  _FormDetailState createState() => _FormDetailState();
}

class _FormDetailState extends State<FormDetail> with TickerProviderStateMixin {
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
    {
      'title': '1. TUJUAN',
      'title_dalam': ' ',
      'isi':
          'a. Memastikan agar material dan produk diperiksa\n\nb. Menjamin spesifikasi produk yang diproses sesuai dengan standar perusahaan'
    },
    {
      'title': '2. RUANG LINGKUP',
      'title_dalam': ' ',
      'isi':
          'Prosedur ini berlaku untuk seluruh material dari proses incoming / inproses / outgoing proses'
    },
    {'title': '3. REFERENSI', 'title_dalam': ' ', 'isi': 'ISO 9001 : 2015'},
    {
      'title': '4. ISTILAH',
      'title_dalam': ' ',
      'isi': 'ISO : Sistem manajemen untuk meningkatkan mutu'
    },
    {
      'title': '5. CATATAN REVISI',
      'title_dalam': ' ',
      'isi':
          'Pengukuran suhu secara manual diganti dengan thermometer otomatis',
      'revisi': 'REV 01',
      'tgl_revisi': '17 January 2018',
      'bab': 'Bab 6',
      'oleh': 'Ridwan Kamil'
    },
    {
      'title': '6. RISIKO',
      'title_dalam': ' ',
      'isi':
          'Kegagalan dalam penerapan procedure ini dapat menyebabkan.\n\na. Risiko terjadinya ketidaksesuaian spesifikasi produk\n\nb. Penurunan kualitas produk yang akan ataupun yang sudah diproduksi'
    },
    {
      'title': '7. PROSEDUR',
      'title_dalam': ' ',
      'isi': 'Melakukan pemeriksaan kualitas sesuai spesifikasi produk'
    },
    {
      'title': '7. PROSEDUR',
      'title_dalam': ' ',
      'isi': 'Apakah produk sesuai spesifikasi'
    },
    {
      'title': '7. PROSEDUR',
      'title_dalam': ' ',
      'isi': '1. Menerima produk\n\n2. Menandatangani dokumen'
    },
    {
      'title': '7. PROSEDUR',
      'title_dalam': ' ',
      'isi': 'Menyortir produk yang tidak sesuai spesifikasi'
    },
    {
      'title': '7. PROSEDUR',
      'title_dalam': ' ',
      'isi': 'Mencatat produk yang tidak sesuai spesifikasi'
    },
    {
      'title': '7. PROSEDUR',
      'title_dalam': ' ',
      'isi': 'Info produk yang disortir kepada supplier'
    },
    {
      'title': '7. PROSEDUR',
      'title_dalam': ' ',
      'isi': 'Mengembalikan produk yang disortir kepada kurir'
    },
    {
      'title': '7. PROSEDUR',
      'title_dalam': ' ',
      'isi': 'Mengembalikan produk yang disortir kepada kurir'
    },
    {
      'title': '7. PROSEDUR',
      'title_dalam': ' ',
      'isi': '1. Menerima produk\n\n2. Menandatangani dokumen'
    },
  ];

  AnimationController _controller2;
  static const List<IconData> iconsEdit = const [Icons.save, Icons.cancel];
  static const List<String> iconsEditTooltip = const ['Update', 'Cancel'];

  bool _editCover = false;
  TextEditingController _controllerCover = TextEditingController();
  TextEditingController _controllerTujuan = TextEditingController();
  TextEditingController _controllerRuangLingkup = TextEditingController();
  TextEditingController _controllerReferensi = TextEditingController();
  TextEditingController _controllerIstilah = TextEditingController();
  TextEditingController _controllerCatatanRevisi = TextEditingController();
  TextEditingController _controllerRevisi = TextEditingController();
  TextEditingController _controllerTglRevisi = TextEditingController();
  TextEditingController _controllerBab = TextEditingController();
  TextEditingController _controllerOleh = TextEditingController();
  TextEditingController _controllerRisiko = TextEditingController();
  TextEditingController _controllerProsedur1 = TextEditingController();
  TextEditingController _controllerProsedur2 = TextEditingController();
  TextEditingController _controllerProsedur3 = TextEditingController();
  TextEditingController _controllerProsedur4 = TextEditingController();
  TextEditingController _controllerProsedur5 = TextEditingController();
  TextEditingController _controllerProsedur6 = TextEditingController();
  TextEditingController _controllerProsedur7 = TextEditingController();
  TextEditingController _controllerProsedur8 = TextEditingController();
  TextEditingController _controllerProsedur9 = TextEditingController();

  int _indexBantu = 0;

  @override
  void initState() {
    _controllerCover.text = _title[0]['title_dalam'];
    _controllerTujuan.text = _title[1]['isi'];
    _controllerRuangLingkup.text = _title[2]['isi'];
    _controllerReferensi.text = _title[3]['isi'];
    _controllerIstilah.text = _title[4]['isi'];
    _controllerCatatanRevisi.text = _title[5]['isi'];
    _controllerRevisi.text = _title[5]['revisi'];
    _controllerTglRevisi.text = _title[5]['tgl_revisi'];
    _controllerBab.text = _title[5]['bab'];
    _controllerOleh.text = _title[5]['oleh'];
    _controllerRisiko.text = _title[6]['isi'];
    _controllerProsedur1.text = _title[7]['isi'];
    _controllerProsedur2.text = _title[8]['isi'];
    _controllerProsedur3.text = _title[9]['isi'];
    _controllerProsedur4.text = _title[10]['isi'];
    _controllerProsedur5.text = _title[11]['isi'];
    _controllerProsedur6.text = _title[12]['isi'];
    _controllerProsedur7.text = _title[13]['isi'];
    _controllerProsedur8.text = _title[14]['isi'];
    _controllerProsedur9.text = _title[15]['isi'];

    _controller2 = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

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
    Color backgroundColor = Theme.of(context).cardColor;
    Color foregroundColor = Theme.of(context).accentColor;

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
                "REVIEW",
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
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(iconsEdit.length, (int index) {
            Widget child = Container(
              height: 70.0,
              width: 56.0,
              alignment: FractionalOffset.topCenter,
              child: ScaleTransition(
                scale: CurvedAnimation(
                  parent: _controller2,
                  curve: Interval(0.0, 1.0 - index / (iconsEdit.length) / 2.0,
                      curve: Curves.easeOut),
                ),
                child: FloatingActionButton(
                  heroTag: null,
                  tooltip: iconsEditTooltip[index],
                  backgroundColor: backgroundColor,
                  mini: true,
                  child: Icon(iconsEdit[index], color: foregroundColor),
                  onPressed: () {
                    if (_editCover) {
                      if (iconsEditTooltip[index] == 'Cancel') {
                        setState(() {
                          _controller2.reverse();
                          _editCover = !_editCover;
                        });
                      } else if (iconsEditTooltip[index] == 'Update') {
                        setState(() {
                          _controller2.reverse();
                          _title[0]['title_dalam'] = _controllerCover.text;
                          _title[1]['isi'] = _controllerTujuan.text;
                          _title[2]['isi'] = _controllerRuangLingkup.text;
                          _title[3]['isi'] = _controllerReferensi.text;
                          _title[4]['isi'] = _controllerIstilah.text;
                          _title[5]['isi'] = _controllerCatatanRevisi.text;
                          _title[5]['revisi'] = _controllerRevisi.text;
                          _title[5]['tgl_revisi'] = _controllerTglRevisi.text;
                          _title[5]['bab'] = _controllerBab.text;
                          _title[5]['oleh'] = _controllerOleh.text;
                          _title[6]['isi'] = _controllerRisiko.text;
                          _title[7]['isi'] = _controllerProsedur1.text;
                          _title[8]['isi'] = _controllerProsedur2.text;
                          _title[9]['isi'] = _controllerProsedur3.text;
                          _title[10]['isi'] = _controllerProsedur4.text;
                          _title[11]['isi'] = _controllerProsedur5.text;
                          _title[12]['isi'] = _controllerProsedur6.text;
                          _title[13]['isi'] = _controllerProsedur7.text;
                          _title[14]['isi'] = _controllerProsedur8.text;
                          _title[15]['isi'] = _controllerProsedur9.text;
                          _editCover = !_editCover;
                        });
                      }
                    }
                  },
                ),
              ),
            );
            return child;
          }).toList()
            ..add(
              FloatingActionButton(
                heroTag: null,
                child: AnimatedBuilder(
                  animation: _controller2,
                  builder: (BuildContext context, Widget child) {
                    return Transform(
                      transform:
                          Matrix4.rotationZ(_controller2.value * 0.5 * math.pi),
                      alignment: FractionalOffset.center,
                      child: _controller2.isDismissed
                          ? Text('REVISI', style: TextStyle(fontSize: 12.0))
                          : Icon(Icons.close),
                    );
                  },
                ),
                onPressed: () {
                  if (_editCover) {
                    if (_controller2.isDismissed) {
                      _controller2.forward();
                    } else {
                      _controller2.reverse();
                    }
                  } else {
                    setState(() {
                      _controller2.reverse();
                      _editCover = !_editCover;
                    });
                  }
                },
              ),
            ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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

                      return Container(
                        color: Colors.white,
                        alignment: Alignment.topCenter,
                        child: ListView(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    _editCover && index == 0
                                        ? Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                border: UnderlineInputBorder(),
                                                hintText: 'Title Cover',
                                                hintStyle:
                                                    TextStyle(fontSize: 14.0),
                                              ),
                                              controller: _controllerCover,
                                              style: TextStyle(
                                                  fontStyle: FontStyle.normal,
                                                  color: Colors.black87,
                                                  fontSize: 14.0),
                                              onSaved: null,
                                            ),
                                          )
                                        : Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0),
                                              child: Text(
                                                _title[index]['title_dalam'],
                                                style: TextStyle(
                                                    color: Color(0xFF2F592F),
                                                    fontSize: 24.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                                index == 1
                                    ? Row(
                                        children: <Widget>[
                                          _editCover
                                              ? Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10.0,
                                                          left: 20.0,
                                                          right: 20.0),
                                                  child: TextFormField(
                                                    maxLines: 5,
                                                    keyboardType:
                                                        TextInputType.multiline,
                                                    decoration: InputDecoration(
                                                      border:
                                                          UnderlineInputBorder(),
                                                      labelText: 'Tujuan',
                                                      labelStyle: TextStyle(
                                                          fontSize: 14.0),
                                                    ),
                                                    style: TextStyle(
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        color: Colors.black87,
                                                        fontSize: 14.0),
                                                    onSaved: null,
                                                    controller:
                                                        _controllerTujuan,
                                                  ),
                                                )
                                              : Flexible(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10.0,
                                                        right: 10.0,
                                                        top: 10.0,
                                                        bottom: 10.0),
                                                    child: Text(
                                                      _title[index]['isi'],
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 26.0),
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                  ),
                                                ),
                                        ],
                                      )
                                    : Container(),
                                index == 2
                                    ? Row(
                                        children: <Widget>[
                                          _editCover
                                              ? Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10.0,
                                                          left: 20.0,
                                                          right: 20.0),
                                                  child: TextFormField(
                                                    maxLines: 5,
                                                    decoration: InputDecoration(
                                                      border:
                                                          UnderlineInputBorder(),
                                                      hintText:
                                                          'Isi Ruang Lingkup',
                                                      hintStyle: TextStyle(
                                                          fontSize: 14.0),
                                                    ),
                                                    controller:
                                                        _controllerRuangLingkup,
                                                    style: TextStyle(
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        color: Colors.black87,
                                                        fontSize: 14.0),
                                                    onSaved: null,
                                                  ),
                                                )
                                              : Flexible(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10.0,
                                                        right: 10.0,
                                                        top: 10.0,
                                                        bottom: 10.0),
                                                    child: Text(
                                                      _title[index]['isi'],
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 26.0),
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                  ),
                                                ),
                                        ],
                                      )
                                    : Container(),
                                index == 3
                                    ? Row(
                                        children: <Widget>[
                                          _editCover
                                              ? Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10.0,
                                                          left: 20.0,
                                                          right: 20.0),
                                                  child: TextFormField(
                                                    maxLines: 5,
                                                    decoration: InputDecoration(
                                                      border:
                                                          UnderlineInputBorder(),
                                                      hintText: 'Referensi',
                                                      hintStyle: TextStyle(
                                                          fontSize: 14.0),
                                                    ),
                                                    controller:
                                                        _controllerReferensi,
                                                    style: TextStyle(
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        color: Colors.black87,
                                                        fontSize: 14.0),
                                                    onSaved: null,
                                                  ),
                                                )
                                              : Flexible(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10.0,
                                                        right: 10.0,
                                                        top: 10.0,
                                                        bottom: 10.0),
                                                    child: Text(
                                                      _title[index]['isi'],
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 26.0),
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                  ),
                                                ),
                                        ],
                                      )
                                    : Container(),
                                index == 4
                                    ? Row(
                                        children: <Widget>[
                                          _editCover
                                              ? Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10.0,
                                                          left: 20.0,
                                                          right: 20.0),
                                                  child: TextFormField(
                                                    maxLines: 5,
                                                    decoration: InputDecoration(
                                                      border:
                                                          UnderlineInputBorder(),
                                                      hintText: 'Istilah',
                                                      hintStyle: TextStyle(
                                                          fontSize: 14.0),
                                                    ),
                                                    controller:
                                                        _controllerIstilah,
                                                    style: TextStyle(
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        color: Colors.black87,
                                                        fontSize: 14.0),
                                                    onSaved: null,
                                                  ),
                                                )
                                              : Flexible(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10.0,
                                                        right: 10.0,
                                                        top: 10.0,
                                                        bottom: 10.0),
                                                    child: Text(
                                                      _title[index]['isi'],
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 26.0),
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                  ),
                                                ),
                                        ],
                                      )
                                    : Container(),
                                index == 5
                                    ? _editCover
                                        ? Column(
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 15.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.5,
                                                      child: TextFormField(
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              UnderlineInputBorder(),
                                                          hintText: 'REV 01',
                                                          hintStyle: TextStyle(
                                                              fontSize: 14.0),
                                                        ),
                                                        controller:
                                                            _controllerRevisi,
                                                        style: TextStyle(
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 14.0),
                                                        onSaved: null,
                                                      ),
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.5,
                                                      child: TextFormField(
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              UnderlineInputBorder(),
                                                          hintText:
                                                              'Tanggal Revisi',
                                                          hintStyle: TextStyle(
                                                              fontSize: 14.0),
                                                        ),
                                                        controller:
                                                            _controllerTglRevisi,
                                                        style: TextStyle(
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 14.0),
                                                        onSaved: null,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 15.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.5,
                                                      child: TextFormField(
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              UnderlineInputBorder(),
                                                          hintText: 'Bab',
                                                          hintStyle: TextStyle(
                                                              fontSize: 14.0),
                                                        ),
                                                        controller:
                                                            _controllerBab,
                                                        style: TextStyle(
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 14.0),
                                                        onSaved: null,
                                                      ),
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.5,
                                                      child: TextFormField(
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              UnderlineInputBorder(),
                                                          hintText:
                                                              'Revisi Oleh',
                                                          hintStyle: TextStyle(
                                                              fontSize: 14.0),
                                                        ),
                                                        controller:
                                                            _controllerOleh,
                                                        style: TextStyle(
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 14.0),
                                                        onSaved: null,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                padding: const EdgeInsets.only(
                                                    top: 10.0,
                                                    left: 20.0,
                                                    right: 20.0),
                                                child: TextFormField(
                                                  maxLines: 5,
                                                  decoration: InputDecoration(
                                                    border:
                                                        UnderlineInputBorder(),
                                                    hintText: 'Catatan Revisi',
                                                    hintStyle: TextStyle(
                                                        fontSize: 14.0),
                                                  ),
                                                  controller:
                                                      _controllerCatatanRevisi,
                                                  style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      color: Colors.black87,
                                                      fontSize: 14.0),
                                                  onSaved: null,
                                                ),
                                              )
                                            ],
                                          )
                                        : Column(
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10.0),
                                                      child: Text(
                                                        _title[index]['revisi'],
                                                        style: TextStyle(
                                                            color: AbubaPallate
                                                                .greenabuba,
                                                            fontSize: 16.0),
                                                        textAlign:
                                                            TextAlign.start,
                                                      ),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10.0),
                                                      child: Text(
                                                        _title[index]
                                                            ['tgl_revisi'],
                                                        style: TextStyle(
                                                            color: AbubaPallate
                                                                .greenabuba,
                                                            fontSize: 16.0),
                                                        textAlign:
                                                            TextAlign.start,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10.0),
                                                      child: Text(
                                                        _title[index]['bab'],
                                                        style: TextStyle(
                                                            color: AbubaPallate
                                                                .greenabuba,
                                                            fontSize: 16.0),
                                                        textAlign:
                                                            TextAlign.start,
                                                      ),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10.0),
                                                      child: Text(
                                                        _title[index]['oleh'],
                                                        style: TextStyle(
                                                            color: AbubaPallate
                                                                .greenabuba,
                                                            fontSize: 16.0),
                                                        textAlign:
                                                            TextAlign.start,
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
                                                        _title[index]['isi'],
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 26.0),
                                                        textAlign:
                                                            TextAlign.start,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                                    : Container(),
                                index == 6
                                    ? Row(
                                        children: <Widget>[
                                          _editCover
                                              ? Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10.0,
                                                          left: 20.0,
                                                          right: 20.0),
                                                  child: TextFormField(
                                                    maxLines: 5,
                                                    decoration: InputDecoration(
                                                      border:
                                                          UnderlineInputBorder(),
                                                      hintText: 'Risiko',
                                                      hintStyle: TextStyle(
                                                          fontSize: 14.0),
                                                    ),
                                                    controller:
                                                        _controllerRisiko,
                                                    style: TextStyle(
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        color: Colors.black87,
                                                        fontSize: 14.0),
                                                    onSaved: null,
                                                  ),
                                                )
                                              : Flexible(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10.0,
                                                        right: 10.0,
                                                        top: 40.0,
                                                        bottom: 10.0),
                                                    child: Text(
                                                      _title[index]['isi'],
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 26.0),
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                  ),
                                                ),
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
                                              _editCover
                                                  ? Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10.0,
                                                              left: 20.0,
                                                              right: 20.0),
                                                      child: TextFormField(
                                                        maxLines: 5,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              UnderlineInputBorder(),
                                                          hintText: 'Prosedur',
                                                          hintStyle: TextStyle(
                                                              fontSize: 14.0),
                                                        ),
                                                        controller:
                                                            _controllerProsedur1,
                                                        style: TextStyle(
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 14.0),
                                                        onSaved: null,
                                                      ),
                                                    )
                                                  : Flexible(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10.0,
                                                                right: 10.0,
                                                                top: 40.0,
                                                                bottom: 10.0),
                                                        child: Text(
                                                          _title[index]['isi'],
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
                                              width: 130.0,
                                              height: 130.0,
                                              color: Colors.transparent,
                                              child: FloatingActionButton(
                                                backgroundColor:
                                                    Colors.green[200],
                                                shape: _DiamondBorder(),
                                                onPressed: () {},
                                                child: Icon(Icons.help_outline,
                                                    color: Colors.white,
                                                    size: 80.0),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              _editCover
                                                  ? Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10.0,
                                                              left: 20.0,
                                                              right: 20.0),
                                                      child: TextFormField(
                                                        maxLines: 5,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              UnderlineInputBorder(),
                                                          hintText: 'Prosedur',
                                                          hintStyle: TextStyle(
                                                              fontSize: 14.0),
                                                        ),
                                                        controller:
                                                            _controllerProsedur2,
                                                        style: TextStyle(
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 14.0),
                                                        onSaved: null,
                                                      ),
                                                    )
                                                  : Flexible(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10.0,
                                                                right: 10.0,
                                                                top: 40.0,
                                                                bottom: 10.0),
                                                        child: Text(
                                                          _title[index]['isi'],
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
                                          Row(
                                            children: <Widget>[
                                              _editCover
                                                  ? Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10.0,
                                                              left: 20.0,
                                                              right: 20.0),
                                                      child: TextFormField(
                                                        maxLines: 5,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              UnderlineInputBorder(),
                                                          hintText: 'Prosedur',
                                                          hintStyle: TextStyle(
                                                              fontSize: 14.0),
                                                        ),
                                                        controller:
                                                            _controllerProsedur3,
                                                        style: TextStyle(
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 14.0),
                                                        onSaved: null,
                                                      ),
                                                    )
                                                  : Flexible(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10.0,
                                                                right: 10.0,
                                                                top: 10.0,
                                                                bottom: 10.0),
                                                        child: Text(
                                                          _title[index]['isi'],
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
                                          ),
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
                                              _editCover
                                                  ? Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10.0,
                                                              left: 20.0,
                                                              right: 20.0),
                                                      child: TextFormField(
                                                        maxLines: 5,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              UnderlineInputBorder(),
                                                          hintText: 'Prosedur',
                                                          hintStyle: TextStyle(
                                                              fontSize: 14.0),
                                                        ),
                                                        controller:
                                                            _controllerProsedur4,
                                                        style: TextStyle(
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 14.0),
                                                        onSaved: null,
                                                      ),
                                                    )
                                                  : Flexible(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10.0,
                                                                right: 10.0,
                                                                top: 40.0,
                                                                bottom: 10.0),
                                                        child: Text(
                                                          _title[index]['isi'],
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
                                              _editCover
                                                  ? Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10.0,
                                                              left: 20.0,
                                                              right: 20.0),
                                                      child: TextFormField(
                                                        maxLines: 5,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              UnderlineInputBorder(),
                                                          hintText: 'Prosedur',
                                                          hintStyle: TextStyle(
                                                              fontSize: 14.0),
                                                        ),
                                                        controller:
                                                            _controllerProsedur5,
                                                        style: TextStyle(
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 14.0),
                                                        onSaved: null,
                                                      ),
                                                    )
                                                  : Flexible(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10.0,
                                                                right: 10.0,
                                                                top: 40.0,
                                                                bottom: 10.0),
                                                        child: Text(
                                                          _title[index]['isi'],
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
                                              _editCover
                                                  ? Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10.0,
                                                              left: 20.0,
                                                              right: 20.0),
                                                      child: TextFormField(
                                                        maxLines: 5,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              UnderlineInputBorder(),
                                                          hintText: 'Prosedur',
                                                          hintStyle: TextStyle(
                                                              fontSize: 14.0),
                                                        ),
                                                        controller:
                                                            _controllerProsedur6,
                                                        style: TextStyle(
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 14.0),
                                                        onSaved: null,
                                                      ),
                                                    )
                                                  : Flexible(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10.0,
                                                                right: 10.0,
                                                                top: 40.0,
                                                                bottom: 10.0),
                                                        child: Text(
                                                          _title[index]['isi'],
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
                                              _editCover
                                                  ? Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10.0,
                                                              left: 20.0,
                                                              right: 20.0),
                                                      child: TextFormField(
                                                        maxLines: 5,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              UnderlineInputBorder(),
                                                          hintText: 'Prosedur',
                                                          hintStyle: TextStyle(
                                                              fontSize: 14.0),
                                                        ),
                                                        controller:
                                                            _controllerProsedur7,
                                                        style: TextStyle(
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 14.0),
                                                        onSaved: null,
                                                      ),
                                                    )
                                                  : Flexible(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10.0,
                                                                right: 10.0,
                                                                top: 40.0,
                                                                bottom: 10.0),
                                                        child: Text(
                                                          _title[index]['isi'],
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
                                              _editCover
                                                  ? Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10.0,
                                                              left: 20.0,
                                                              right: 20.0),
                                                      child: TextFormField(
                                                        maxLines: 5,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              UnderlineInputBorder(),
                                                          hintText: 'Prosedur',
                                                          hintStyle: TextStyle(
                                                              fontSize: 14.0),
                                                        ),
                                                        controller:
                                                            _controllerProsedur8,
                                                        style: TextStyle(
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 14.0),
                                                        onSaved: null,
                                                      ),
                                                    )
                                                  : Flexible(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10.0,
                                                                right: 10.0,
                                                                top: 40.0,
                                                                bottom: 10.0),
                                                        child: Text(
                                                          _title[index]['isi'],
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
                                          Row(
                                            children: <Widget>[
                                              _editCover
                                                  ? Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10.0,
                                                              left: 20.0,
                                                              right: 20.0),
                                                      child: TextFormField(
                                                        maxLines: 5,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              UnderlineInputBorder(),
                                                          hintText: 'Prosedur',
                                                          hintStyle: TextStyle(
                                                              fontSize: 14.0),
                                                        ),
                                                        controller:
                                                            _controllerProsedur9,
                                                        style: TextStyle(
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 14.0),
                                                        onSaved: null,
                                                      ),
                                                    )
                                                  : Flexible(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10.0,
                                                                right: 10.0,
                                                                top: 40.0,
                                                                bottom: 10.0),
                                                        child: Text(
                                                          _title[index]['isi'],
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
                                          ),
                                          Row(
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
                                                      AbubaPallate.menuBluebird,
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MyCustomRoute(
                                                            builder: (context) =>
                                                                ReviewRevisi()));
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
                                                    style: TextStyle(
                                                        fontSize: 13.0,
                                                        color: Colors.white),
                                                  ),
                                                  color:
                                                      AbubaPallate.greenabuba,
                                                  onPressed: () {},
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    : Container(),
                              ],
                            ),
                          ],
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                        ),
                      );
                    },
                    controller: _controller,
                    autoplay: _autoplay,
                    itemCount: _title.length,
                    itemWidth: MediaQuery.of(context).size.width,
                    itemHeight: MediaQuery.of(context).size.height - 250.0,
                    index: _currentIndex,
                    layout: SwiperLayout.TINDER,
                    onIndexChanged: (int index) {
                      setState(
                        () {
                          _currentIndex = index;
                          _number = index + 1;
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                ],
              ),
            ],
          ),
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
