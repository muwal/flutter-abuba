import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';

class DetailCash extends StatefulWidget {
  DetailCash({this.idUser, this.namaUser, this.departmentUser, this.index});

  final int idUser;
  final String namaUser;
  final String departmentUser;
  var index;

  @override
  _DetailCashState createState() => _DetailCashState();
}

class _DetailCashState extends State<DetailCash> with TickerProviderStateMixin {
  TabController _tabController;
  bool _isProccess = false;
  AnimationController animationController;
  final formatter = new NumberFormat("#,###");

  final List<Tab> internalAuditTabs = <Tab>[
    new Tab(child: Text('Uang Kertas', style: TextStyle(color: Colors.grey[400]))),
    new Tab(child: Text('Uang Logam', style: TextStyle(color: Colors.grey[400]))),
    new Tab(child: Text('Buku Kas',style: TextStyle(color: Colors.grey[400]))),
    new Tab(child:Text('Rekonsiliasi', style: TextStyle(color: Colors.grey[400]))),
  ];

  TextEditingController controllerSeratus = TextEditingController();
  TextEditingController controllerLimaPuluh = TextEditingController();
  TextEditingController controllerDuaPuluh = TextEditingController();
  TextEditingController controllerSepuluh = TextEditingController();
  TextEditingController controllerLima = TextEditingController();
  TextEditingController controllerDua = TextEditingController();
  TextEditingController controllerSatu = TextEditingController();

  TextEditingController controllerSeribuLogam = TextEditingController();
  TextEditingController controllerLimaRatusLogam = TextEditingController();
  TextEditingController controllerDuaRatusLogam = TextEditingController();
  TextEditingController controllerSeratusLogam = TextEditingController();

  final kasBon = MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  final bukuKas = MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  final saldoAwalBuku = MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  final penerimaan = MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  final pengeluaran = MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');

  int saldoAkhir = 0;
  int perhitunganSelisihPembukuanKas = 0;
  final controllerSaldoAkhir = MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
  final controllerSelisihPembukuanKas = MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');

  String status;
  int kertasSeratus2 = 0;
  int kertasLimaPuluh2 = 0;
  int kertasDuaPuluh2 = 0;
  int kertasSepuluh2 = 0;
  int kertasLima2 = 0;
  int kertasDua2 = 0;
  int kertasSatu2 = 0;
  int logamSeribu2 = 0;
  int logamLimaRatus2 = 0;
  int logamDuaRatus2 = 0;
  int logamSeratus2 = 0;
  int kasBonPending2 = 0;
  int bukuKas2 = 0;
  int saldoAwalBuku2 = 0;
  int penerimaan2 = 0;
  int pengeluaran2 = 0;
  int saldoAkhir2 = 0;
  int selisih2 = 0;

  Future<bool> onWillPop(context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => new AlertDialog(
        title: new Text('Yakin akan keluar dari Abuba 4.0?'),
        content: new Text('Semua progres pada halaman ini akan hilang'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('Cancel'),
          ),
          new FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: new Text('Ya'),
          ),
        ],
      ),
    ).whenComplete(() {
      Navigator.pop(context);
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: internalAuditTabs.length);

    animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(from: animationController.value == 0.0 ? 1.0 : animationController.value);

    Firestore.instance.collection('audit_internalDetail-cash').where('docRef', isEqualTo: widget.index).snapshots().listen((data2) {
      setState(() {
        if (data2.documents.length == 0) {
          status = 'open';
        } else {
          kertasSeratus2 = data2.documents[data2.documents.length - 1].data['kertasSeratus'];
          kertasLimaPuluh2 = data2.documents[data2.documents.length - 1].data['kertasLimaPuluh'];
          kertasDuaPuluh2 = data2.documents[data2.documents.length - 1].data['kertasDuaPuluh'];
          kertasSepuluh2 = data2.documents[data2.documents.length - 1].data['kertasSepuluh'];
          kertasLima2 = data2.documents[data2.documents.length - 1].data['kertasLima'];
          kertasDua2 = data2.documents[data2.documents.length - 1].data['kertasDua'];
          kertasSatu2 = data2.documents[data2.documents.length - 1].data['kertasSatu'];
          logamSeribu2 = data2.documents[data2.documents.length - 1].data['logamSeribu'];
          logamLimaRatus2 = data2.documents[data2.documents.length - 1].data['logamLimaRatus'];
          logamDuaRatus2 = data2.documents[data2.documents.length - 1].data['logamDuaRatus'];
          logamSeratus2 = data2.documents[data2.documents.length - 1].data['logamSeratus'];
          kasBonPending2 = data2.documents[data2.documents.length - 1].data['kasBonPending'];
          bukuKas2 = data2.documents[data2.documents.length - 1].data['bukuKas'];
          saldoAwalBuku2 = data2.documents[data2.documents.length - 1].data['saldoAwalBuku'];
          penerimaan2 = data2.documents[data2.documents.length - 1].data['penerimaan'];
          pengeluaran2 = data2.documents[data2.documents.length - 1].data['pengeluaran'];
          saldoAkhir2 = data2.documents[data2.documents.length - 1].data['saldoAkhir'];
          selisih2 = data2.documents[data2.documents.length - 1].data['selisih'];
          status = 'close';
        }
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (status == 'open') {
      return SafeArea(
        child: DefaultTabController(
          length: internalAuditTabs.length,
          child: WillPopScope(
            onWillPop: () {
              onWillPop(context);
            },
            child: Scaffold(
              appBar: AppBar(
                elevation: 0.25,
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(color: Colors.black),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    onWillPop(context);
                  },
                ),
                title: Container(
                  child: new Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 15.0),
                        child: Text(
                          'Cash Opname',
                          style: TextStyle(fontSize: 16.0, color: Colors.black54, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                bottom: new TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  onTap: null,
                  indicatorColor: AbubaPallate.greenabuba,
                  tabs: internalAuditTabs,
                ),
              ),
              body: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: AnimatedBuilder(
                  animation: animationController,
                  builder: (_, Widget child) {
                    return animationController.isAnimating
                      ? Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ), 
                        )
                      : TabBarView(
                          physics: NeverScrollableScrollPhysics(),
                          controller: _tabController,
                          children: <Widget>[
                            ListView(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child:  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Flexible(child: Text('Pecahan', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0, color: Colors.black54),),),
                                          Flexible(child: Text('Jumlah', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0, color: Colors.black54),),)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child:  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(child: Text('Rp 100.000', style: TextStyle(fontSize: 16.0, color: Colors.black38),),),
                                          Flexible(
                                            child: Container(
                                              height: 35.0,
                                              child: TextField(
                                                controller: controllerSeratus,
                                                onChanged: (val) {
                                                  setState(() {
                                                    perhitunganSelisihPembukuanKas = ((100000 * int.tryParse(controllerSeratus.text.toString()) + 50000 * int.tryParse(controllerLimaPuluh.text.toString()) + 20000 * int.tryParse(controllerDuaPuluh.text.toString()) + 10000 * int.tryParse(controllerSepuluh.text.toString()) + 5000 * int.tryParse(controllerLima.text.toString()) + 2000 * int.tryParse(controllerDua.text.toString()) + 1000 * int.tryParse(controllerSatu.text.toString())) + (1000 * int.tryParse(controllerSeribuLogam.text.toString()) + 500 * int.tryParse(controllerLimaRatusLogam.text.toString()) + 200 * int.tryParse(controllerDuaRatusLogam.text.toString()) + 100 * int.tryParse(controllerSeratusLogam.text.toString())) + kasBon.numberValue.toInt()) - bukuKas.numberValue.toInt() - (saldoAwalBuku.numberValue.toInt() + penerimaan.numberValue.toInt() - pengeluaran.numberValue.toInt());
                                                    controllerSelisihPembukuanKas.updateValue(double.tryParse(perhitunganSelisihPembukuanKas.toString()));
                                                  });
                                                },
                                                onEditingComplete: () {
                                                  FocusScope.of(context).requestFocus(FocusNode());
                                                },
                                                keyboardType: TextInputType.number,
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder()
                                                )
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child:  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(child: Text('Rp 50.000', style: TextStyle(fontSize: 16.0, color: Colors.black38),),),
                                          Flexible(
                                            child: Container(
                                              height: 35.0,
                                              child: TextField(
                                                controller: controllerLimaPuluh,
                                                keyboardType: TextInputType.number,
                                                onChanged: (val) {
                                                  setState(() {
                                                    perhitunganSelisihPembukuanKas = ((100000 * int.tryParse(controllerSeratus.text.toString()) + 50000 * int.tryParse(controllerLimaPuluh.text.toString()) + 20000 * int.tryParse(controllerDuaPuluh.text.toString()) + 10000 * int.tryParse(controllerSepuluh.text.toString()) + 5000 * int.tryParse(controllerLima.text.toString()) + 2000 * int.tryParse(controllerDua.text.toString()) + 1000 * int.tryParse(controllerSatu.text.toString())) + (1000 * int.tryParse(controllerSeribuLogam.text.toString()) + 500 * int.tryParse(controllerLimaRatusLogam.text.toString()) + 200 * int.tryParse(controllerDuaRatusLogam.text.toString()) + 100 * int.tryParse(controllerSeratusLogam.text.toString())) + kasBon.numberValue.toInt()) - bukuKas.numberValue.toInt() - (saldoAwalBuku.numberValue.toInt() + penerimaan.numberValue.toInt() - pengeluaran.numberValue.toInt());
                                                    controllerSelisihPembukuanKas.updateValue(double.tryParse(perhitunganSelisihPembukuanKas.toString()));
                                                  });
                                                },
                                                onEditingComplete: () {
                                                  FocusScope.of(context).requestFocus(FocusNode());
                                                },
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder()
                                                )
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child:  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(child: Text('Rp 20.000', style: TextStyle(fontSize: 16.0, color: Colors.black38))),
                                          Flexible(
                                            child: Container(
                                              height: 35.0,
                                              child: TextField(
                                                controller: controllerDuaPuluh,
                                                keyboardType: TextInputType.number,
                                                onChanged: (val) {
                                                  setState(() {
                                                    perhitunganSelisihPembukuanKas = ((100000 * int.tryParse(controllerSeratus.text.toString()) + 50000 * int.tryParse(controllerLimaPuluh.text.toString()) + 20000 * int.tryParse(controllerDuaPuluh.text.toString()) + 10000 * int.tryParse(controllerSepuluh.text.toString()) + 5000 * int.tryParse(controllerLima.text.toString()) + 2000 * int.tryParse(controllerDua.text.toString()) + 1000 * int.tryParse(controllerSatu.text.toString())) + (1000 * int.tryParse(controllerSeribuLogam.text.toString()) + 500 * int.tryParse(controllerLimaRatusLogam.text.toString()) + 200 * int.tryParse(controllerDuaRatusLogam.text.toString()) + 100 * int.tryParse(controllerSeratusLogam.text.toString())) + kasBon.numberValue.toInt()) - bukuKas.numberValue.toInt() - (saldoAwalBuku.numberValue.toInt() + penerimaan.numberValue.toInt() - pengeluaran.numberValue.toInt());
                                                    controllerSelisihPembukuanKas.updateValue(double.tryParse(perhitunganSelisihPembukuanKas.toString()));
                                                  });
                                                },
                                                onEditingComplete: () {
                                                  FocusScope.of(context).requestFocus(FocusNode());
                                                },
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder()
                                                )
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child:  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(child: Text('Rp 10.000', style: TextStyle(fontSize: 16.0, color: Colors.black38),),),
                                          Flexible(
                                            child: Container(
                                              height: 35.0,
                                              child: TextField(
                                                controller: controllerSepuluh,
                                                keyboardType: TextInputType.number,
                                                onChanged: (val) {
                                                  setState(() {
                                                    perhitunganSelisihPembukuanKas = ((100000 * int.tryParse(controllerSeratus.text.toString()) + 50000 * int.tryParse(controllerLimaPuluh.text.toString()) + 20000 * int.tryParse(controllerDuaPuluh.text.toString()) + 10000 * int.tryParse(controllerSepuluh.text.toString()) + 5000 * int.tryParse(controllerLima.text.toString()) + 2000 * int.tryParse(controllerDua.text.toString()) + 1000 * int.tryParse(controllerSatu.text.toString())) + (1000 * int.tryParse(controllerSeribuLogam.text.toString()) + 500 * int.tryParse(controllerLimaRatusLogam.text.toString()) + 200 * int.tryParse(controllerDuaRatusLogam.text.toString()) + 100 * int.tryParse(controllerSeratusLogam.text.toString())) + kasBon.numberValue.toInt()) - bukuKas.numberValue.toInt() - (saldoAwalBuku.numberValue.toInt() + penerimaan.numberValue.toInt() - pengeluaran.numberValue.toInt());
                                                    controllerSelisihPembukuanKas.updateValue(double.tryParse(perhitunganSelisihPembukuanKas.toString()));
                                                  });
                                                },
                                                onEditingComplete: () {
                                                  FocusScope.of(context).requestFocus(FocusNode());
                                                },
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder()
                                                )
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child:  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(child: Text('Rp 5.000', style: TextStyle(fontSize: 16.0, color: Colors.black38),),),
                                          Flexible(
                                            child: Container(
                                              height: 35.0,
                                              child: TextField(
                                                controller: controllerLima,
                                                keyboardType: TextInputType.number,
                                                onChanged: (val) {
                                                  setState(() {
                                                    perhitunganSelisihPembukuanKas = ((100000 * int.tryParse(controllerSeratus.text.toString()) + 50000 * int.tryParse(controllerLimaPuluh.text.toString()) + 20000 * int.tryParse(controllerDuaPuluh.text.toString()) + 10000 * int.tryParse(controllerSepuluh.text.toString()) + 5000 * int.tryParse(controllerLima.text.toString()) + 2000 * int.tryParse(controllerDua.text.toString()) + 1000 * int.tryParse(controllerSatu.text.toString())) + (1000 * int.tryParse(controllerSeribuLogam.text.toString()) + 500 * int.tryParse(controllerLimaRatusLogam.text.toString()) + 200 * int.tryParse(controllerDuaRatusLogam.text.toString()) + 100 * int.tryParse(controllerSeratusLogam.text.toString())) + kasBon.numberValue.toInt()) - bukuKas.numberValue.toInt() - (saldoAwalBuku.numberValue.toInt() + penerimaan.numberValue.toInt() - pengeluaran.numberValue.toInt());
                                                    controllerSelisihPembukuanKas.updateValue(double.tryParse(perhitunganSelisihPembukuanKas.toString()));
                                                  });
                                                },
                                                onEditingComplete: () {
                                                  FocusScope.of(context).requestFocus(FocusNode());
                                                },
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder()
                                                )
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child:  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(child: Text('Rp 2.000', style: TextStyle(fontSize: 16.0, color: Colors.black38),),),
                                          Flexible(
                                            child: Container(
                                              height: 35.0,
                                              child: TextField(
                                                controller: controllerDua,
                                                keyboardType: TextInputType.number,
                                                onChanged: (val) {
                                                  setState(() {
                                                    perhitunganSelisihPembukuanKas = ((100000 * int.tryParse(controllerSeratus.text.toString()) + 50000 * int.tryParse(controllerLimaPuluh.text.toString()) + 20000 * int.tryParse(controllerDuaPuluh.text.toString()) + 10000 * int.tryParse(controllerSepuluh.text.toString()) + 5000 * int.tryParse(controllerLima.text.toString()) + 2000 * int.tryParse(controllerDua.text.toString()) + 1000 * int.tryParse(controllerSatu.text.toString())) + (1000 * int.tryParse(controllerSeribuLogam.text.toString()) + 500 * int.tryParse(controllerLimaRatusLogam.text.toString()) + 200 * int.tryParse(controllerDuaRatusLogam.text.toString()) + 100 * int.tryParse(controllerSeratusLogam.text.toString())) + kasBon.numberValue.toInt()) - bukuKas.numberValue.toInt() - (saldoAwalBuku.numberValue.toInt() + penerimaan.numberValue.toInt() - pengeluaran.numberValue.toInt());
                                                    controllerSelisihPembukuanKas.updateValue(double.tryParse(perhitunganSelisihPembukuanKas.toString()));
                                                  });
                                                },
                                                onEditingComplete: () {
                                                  FocusScope.of(context).requestFocus(FocusNode());
                                                },
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder()
                                                )
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child:  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(child: Text('Rp 1.000', style: TextStyle(fontSize: 16.0, color: Colors.black38),),),
                                          Flexible(
                                            child: Container(
                                              height: 35.0,
                                              child: TextField(
                                                controller: controllerSatu,
                                                keyboardType: TextInputType.number,
                                                onChanged: (val) {
                                                  setState(() {
                                                    perhitunganSelisihPembukuanKas = ((100000 * int.tryParse(controllerSeratus.text.toString()) + 50000 * int.tryParse(controllerLimaPuluh.text.toString()) + 20000 * int.tryParse(controllerDuaPuluh.text.toString()) + 10000 * int.tryParse(controllerSepuluh.text.toString()) + 5000 * int.tryParse(controllerLima.text.toString()) + 2000 * int.tryParse(controllerDua.text.toString()) + 1000 * int.tryParse(controllerSatu.text.toString())) + (1000 * int.tryParse(controllerSeribuLogam.text.toString()) + 500 * int.tryParse(controllerLimaRatusLogam.text.toString()) + 200 * int.tryParse(controllerDuaRatusLogam.text.toString()) + 100 * int.tryParse(controllerSeratusLogam.text.toString())) + kasBon.numberValue.toInt()) - bukuKas.numberValue.toInt() - (saldoAwalBuku.numberValue.toInt() + penerimaan.numberValue.toInt() - pengeluaran.numberValue.toInt());
                                                    controllerSelisihPembukuanKas.updateValue(double.tryParse(perhitunganSelisihPembukuanKas.toString()));
                                                  });
                                                },
                                                onEditingComplete: () {
                                                  FocusScope.of(context).requestFocus(FocusNode());
                                                },
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder()
                                                )
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0, right: 20.0),
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 30.0,
                                        child: OutlineButton(
                                          child: Text(
                                            'NEXT',
                                            style: TextStyle(
                                              fontSize: 13.0, color: Colors.blue
                                            ),
                                          ),
                                          borderSide: BorderSide(color: Colors.blue, width: 1.0),
                                          highlightedBorderColor: Colors.blue,
                                          onPressed: () {
                                            _tabController.animateTo((_tabController.index + 1) % 2);
                                            FocusScope.of(context).requestFocus(FocusNode());
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            // start uang logam
                            ListView(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child:  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Flexible(child: Text('Pecahan', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0, color: Colors.black54),),),
                                          Flexible(child: Text('Jumlah', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0, color: Colors.black54),),)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child:  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(child: Text('Rp 1.000', style: TextStyle(fontSize: 16.0, color: Colors.black38),),),
                                          Flexible(
                                            child: Container(
                                              height: 35.0,
                                              child: TextField(
                                                controller: controllerSeribuLogam,
                                                keyboardType: TextInputType.number,
                                                onChanged: (val) {
                                                  setState(() {
                                                    perhitunganSelisihPembukuanKas = ((100000 * int.tryParse(controllerSeratus.text.toString()) + 50000 * int.tryParse(controllerLimaPuluh.text.toString()) + 20000 * int.tryParse(controllerDuaPuluh.text.toString()) + 10000 * int.tryParse(controllerSepuluh.text.toString()) + 5000 * int.tryParse(controllerLima.text.toString()) + 2000 * int.tryParse(controllerDua.text.toString()) + 1000 * int.tryParse(controllerSatu.text.toString())) + (1000 * int.tryParse(controllerSeribuLogam.text.toString()) + 500 * int.tryParse(controllerLimaRatusLogam.text.toString()) + 200 * int.tryParse(controllerDuaRatusLogam.text.toString()) + 100 * int.tryParse(controllerSeratusLogam.text.toString())) + kasBon.numberValue.toInt()) - bukuKas.numberValue.toInt() - (saldoAwalBuku.numberValue.toInt() + penerimaan.numberValue.toInt() - pengeluaran.numberValue.toInt());
                                                    controllerSelisihPembukuanKas.updateValue(double.tryParse(perhitunganSelisihPembukuanKas.toString()));
                                                  });
                                                },
                                                onEditingComplete: () {
                                                  FocusScope.of(context).requestFocus(FocusNode());
                                                },
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder()
                                                )
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child:  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(child: Text('Rp 500', style: TextStyle(fontSize: 16.0, color: Colors.black38),),),
                                          Flexible(
                                            child: Container(
                                              height: 35.0,
                                              child: TextField(
                                                controller: controllerLimaRatusLogam,
                                                keyboardType: TextInputType.number,
                                                onChanged: (val) {
                                                  setState(() {
                                                    perhitunganSelisihPembukuanKas = ((100000 * int.tryParse(controllerSeratus.text.toString()) + 50000 * int.tryParse(controllerLimaPuluh.text.toString()) + 20000 * int.tryParse(controllerDuaPuluh.text.toString()) + 10000 * int.tryParse(controllerSepuluh.text.toString()) + 5000 * int.tryParse(controllerLima.text.toString()) + 2000 * int.tryParse(controllerDua.text.toString()) + 1000 * int.tryParse(controllerSatu.text.toString())) + (1000 * int.tryParse(controllerSeribuLogam.text.toString()) + 500 * int.tryParse(controllerLimaRatusLogam.text.toString()) + 200 * int.tryParse(controllerDuaRatusLogam.text.toString()) + 100 * int.tryParse(controllerSeratusLogam.text.toString())) + kasBon.numberValue.toInt()) - bukuKas.numberValue.toInt() - (saldoAwalBuku.numberValue.toInt() + penerimaan.numberValue.toInt() - pengeluaran.numberValue.toInt());
                                                    controllerSelisihPembukuanKas.updateValue(double.tryParse(perhitunganSelisihPembukuanKas.toString()));
                                                  });
                                                },
                                                onEditingComplete: () {
                                                  FocusScope.of(context).requestFocus(FocusNode());
                                                },
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder()
                                                )
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child:  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(child: Text('Rp 200', style: TextStyle(fontSize: 16.0, color: Colors.black38),),),
                                          Flexible(
                                            child: Container(
                                              height: 35.0,
                                              child: TextField(
                                                controller: controllerDuaRatusLogam,
                                                keyboardType: TextInputType.number,
                                                onChanged: (val) {
                                                  setState(() {
                                                    perhitunganSelisihPembukuanKas = ((100000 * int.tryParse(controllerSeratus.text.toString()) + 50000 * int.tryParse(controllerLimaPuluh.text.toString()) + 20000 * int.tryParse(controllerDuaPuluh.text.toString()) + 10000 * int.tryParse(controllerSepuluh.text.toString()) + 5000 * int.tryParse(controllerLima.text.toString()) + 2000 * int.tryParse(controllerDua.text.toString()) + 1000 * int.tryParse(controllerSatu.text.toString())) + (1000 * int.tryParse(controllerSeribuLogam.text.toString()) + 500 * int.tryParse(controllerLimaRatusLogam.text.toString()) + 200 * int.tryParse(controllerDuaRatusLogam.text.toString()) + 100 * int.tryParse(controllerSeratusLogam.text.toString())) + kasBon.numberValue.toInt()) - bukuKas.numberValue.toInt() - (saldoAwalBuku.numberValue.toInt() + penerimaan.numberValue.toInt() - pengeluaran.numberValue.toInt());
                                                    controllerSelisihPembukuanKas.updateValue(double.tryParse(perhitunganSelisihPembukuanKas.toString()));
                                                  });
                                                },
                                                onEditingComplete: () {
                                                  FocusScope.of(context).requestFocus(FocusNode());
                                                },
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder()
                                                )
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child:  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(child: Text('Rp 100', style: TextStyle(fontSize: 16.0, color: Colors.black38),),),
                                          Flexible(
                                            child: Container(
                                              height: 35.0,
                                              child: TextField(
                                                controller: controllerSeratusLogam,
                                                keyboardType: TextInputType.number,
                                                onChanged: (val) {
                                                  setState(() {
                                                    perhitunganSelisihPembukuanKas = ((100000 * int.tryParse(controllerSeratus.text.toString()) + 50000 * int.tryParse(controllerLimaPuluh.text.toString()) + 20000 * int.tryParse(controllerDuaPuluh.text.toString()) + 10000 * int.tryParse(controllerSepuluh.text.toString()) + 5000 * int.tryParse(controllerLima.text.toString()) + 2000 * int.tryParse(controllerDua.text.toString()) + 1000 * int.tryParse(controllerSatu.text.toString())) + (1000 * int.tryParse(controllerSeribuLogam.text.toString()) + 500 * int.tryParse(controllerLimaRatusLogam.text.toString()) + 200 * int.tryParse(controllerDuaRatusLogam.text.toString()) + 100 * int.tryParse(controllerSeratusLogam.text.toString())) + kasBon.numberValue.toInt()) - bukuKas.numberValue.toInt() - (saldoAwalBuku.numberValue.toInt() + penerimaan.numberValue.toInt() - pengeluaran.numberValue.toInt());
                                                    controllerSelisihPembukuanKas.updateValue(double.tryParse(perhitunganSelisihPembukuanKas.toString()));
                                                  });
                                                },
                                                onEditingComplete: () {
                                                  FocusScope.of(context).requestFocus(FocusNode());
                                                },
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder()
                                                )
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 30.0,
                                        child: OutlineButton(
                                          child: Text(
                                            'PREV',
                                            style: TextStyle(
                                              fontSize: 13.0, color: Colors.grey
                                            ),
                                          ),
                                          borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                          highlightedBorderColor: Colors.grey,
                                          onPressed: () {
                                            _tabController.animateTo((_tabController.index - 1));
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(top: 10.0, right: 20.0),
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 30.0,
                                        child: OutlineButton(
                                          child: Text(
                                            'NEXT',
                                            style: TextStyle(
                                                fontSize: 13.0, color: Colors.blue),
                                          ),
                                          borderSide:
                                              BorderSide(color: Colors.blue, width: 1.0),
                                          highlightedBorderColor: Colors.blue,
                                          onPressed: () {
                                            _tabController.animateTo((_tabController.index + 1));
                                            FocusScope.of(context).requestFocus(FocusNode());
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            ListView(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child:  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Flexible(child: Text('Parameter', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0, color: Colors.black54),),),
                                          Flexible(child: Text('Jumlah', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0, color: Colors.black54),),)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child:  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(child: Text('Kas bon / pending', style: TextStyle(fontSize: 16.0, color: Colors.black38),),),
                                          Flexible(
                                            child: Container(
                                              height: 35.0,
                                              child: TextField(
                                                controller: kasBon,
                                                keyboardType: TextInputType.number,
                                                onChanged: (val) {
                                                  setState(() {
                                                    perhitunganSelisihPembukuanKas = ((100000 * int.tryParse(controllerSeratus.text.toString()) + 50000 * int.tryParse(controllerLimaPuluh.text.toString()) + 20000 * int.tryParse(controllerDuaPuluh.text.toString()) + 10000 * int.tryParse(controllerSepuluh.text.toString()) + 5000 * int.tryParse(controllerLima.text.toString()) + 2000 * int.tryParse(controllerDua.text.toString()) + 1000 * int.tryParse(controllerSatu.text.toString())) + (1000 * int.tryParse(controllerSeribuLogam.text.toString()) + 500 * int.tryParse(controllerLimaRatusLogam.text.toString()) + 200 * int.tryParse(controllerDuaRatusLogam.text.toString()) + 100 * int.tryParse(controllerSeratusLogam.text.toString())) + kasBon.numberValue.toInt()) - bukuKas.numberValue.toInt() - (saldoAwalBuku.numberValue.toInt() + penerimaan.numberValue.toInt() - pengeluaran.numberValue.toInt());
                                                    controllerSelisihPembukuanKas.updateValue(double.tryParse(perhitunganSelisihPembukuanKas.toString()));
                                                  });
                                                },
                                                onEditingComplete: () {
                                                  FocusScope.of(context).requestFocus(FocusNode());
                                                },
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder()
                                                )
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child:  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(child: Text('Jumlah buku kas', style: TextStyle(fontSize: 16.0, color: Colors.black38),),),
                                          Flexible(
                                            child: Container(
                                              height: 35.0,
                                              child: TextField(
                                                controller: bukuKas,
                                                keyboardType: TextInputType.number,
                                                onChanged: (val) {
                                                  setState(() {
                                                    perhitunganSelisihPembukuanKas = ((100000 * int.tryParse(controllerSeratus.text.toString()) + 50000 * int.tryParse(controllerLimaPuluh.text.toString()) + 20000 * int.tryParse(controllerDuaPuluh.text.toString()) + 10000 * int.tryParse(controllerSepuluh.text.toString()) + 5000 * int.tryParse(controllerLima.text.toString()) + 2000 * int.tryParse(controllerDua.text.toString()) + 1000 * int.tryParse(controllerSatu.text.toString())) + (1000 * int.tryParse(controllerSeribuLogam.text.toString()) + 500 * int.tryParse(controllerLimaRatusLogam.text.toString()) + 200 * int.tryParse(controllerDuaRatusLogam.text.toString()) + 100 * int.tryParse(controllerSeratusLogam.text.toString())) + kasBon.numberValue.toInt()) - bukuKas.numberValue.toInt() - (saldoAwalBuku.numberValue.toInt() + penerimaan.numberValue.toInt() - pengeluaran.numberValue.toInt());
                                                    controllerSelisihPembukuanKas.updateValue(double.tryParse(perhitunganSelisihPembukuanKas.toString()));
                                                  });
                                                },
                                                onEditingComplete: () {
                                                  FocusScope.of(context).requestFocus(FocusNode());
                                                },
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder()
                                                )
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 30.0,
                                        child: OutlineButton(
                                          child: Text(
                                            'PREV',
                                            style: TextStyle(
                                                fontSize: 13.0, color: Colors.grey),
                                          ),
                                          borderSide:
                                              BorderSide(color: Colors.grey, width: 1.0),
                                          highlightedBorderColor: Colors.grey,
                                          onPressed: () {
                                            _tabController.animateTo((_tabController.index - 1));
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(top: 10.0, right: 20.0),
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 30.0,
                                        child: OutlineButton(
                                          child: Text(
                                            'NEXT',
                                            style: TextStyle(
                                                fontSize: 13.0, color: Colors.blue),
                                          ),
                                          borderSide:
                                              BorderSide(color: Colors.blue, width: 1.0),
                                          highlightedBorderColor: Colors.blue,
                                          onPressed: () {
                                            _tabController.animateTo((_tabController.index + 1));
                                            FocusScope.of(context).requestFocus(FocusNode());
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            ListView(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child:  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Flexible(child: Text('Parameter', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0, color: Colors.black54),),),
                                          Flexible(child: Text('Jumlah', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16.0, color: Colors.black54),),)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child:  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(child: Text('Saldo awal buku', style: TextStyle(fontSize: 16.0, color: Colors.black38),),),
                                          Flexible(
                                            child: Container(
                                              height: 35.0,
                                              child: TextField(
                                                controller: saldoAwalBuku,
                                                keyboardType: TextInputType.number,
                                                onChanged: (val) {
                                                  setState(() {
                                                    saldoAkhir = saldoAwalBuku.numberValue.toInt() + penerimaan.numberValue.toInt() - pengeluaran.numberValue.toInt();

                                                    perhitunganSelisihPembukuanKas = ((100000 * int.tryParse(controllerSeratus.text.toString()) + 50000 * int.tryParse(controllerLimaPuluh.text.toString()) + 20000 * int.tryParse(controllerDuaPuluh.text.toString()) + 10000 * int.tryParse(controllerSepuluh.text.toString()) + 5000 * int.tryParse(controllerLima.text.toString()) + 2000 * int.tryParse(controllerDua.text.toString()) + 1000 * int.tryParse(controllerSatu.text.toString())) + (1000 * int.tryParse(controllerSeribuLogam.text.toString()) + 500 * int.tryParse(controllerLimaRatusLogam.text.toString()) + 200 * int.tryParse(controllerDuaRatusLogam.text.toString()) + 100 * int.tryParse(controllerSeratusLogam.text.toString())) + kasBon.numberValue.toInt()) - bukuKas.numberValue.toInt() - (saldoAwalBuku.numberValue.toInt() + penerimaan.numberValue.toInt() - pengeluaran.numberValue.toInt());
                                                    controllerSelisihPembukuanKas.updateValue(double.tryParse(perhitunganSelisihPembukuanKas.toString()));

                                                    controllerSaldoAkhir.updateValue(double.tryParse(saldoAkhir.toString()));
                                                  });
                                                },
                                                onEditingComplete: () {
                                                  FocusScope.of(context).requestFocus(FocusNode());
                                                },
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder()
                                                )
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child:  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(child: Text('Penerimaan', style: TextStyle(fontSize: 16.0, color: Colors.black38),),),
                                          Flexible(
                                            child: Container(
                                              height: 35.0,
                                              child: TextField(
                                                controller: penerimaan,
                                                onChanged: (val) {
                                                  setState(() {
                                                    saldoAkhir = saldoAwalBuku.numberValue.toInt() + penerimaan.numberValue.toInt() - pengeluaran.numberValue.toInt();

                                                    perhitunganSelisihPembukuanKas = ((100000 * int.tryParse(controllerSeratus.text.toString()) + 50000 * int.tryParse(controllerLimaPuluh.text.toString()) + 20000 * int.tryParse(controllerDuaPuluh.text.toString()) + 10000 * int.tryParse(controllerSepuluh.text.toString()) + 5000 * int.tryParse(controllerLima.text.toString()) + 2000 * int.tryParse(controllerDua.text.toString()) + 1000 * int.tryParse(controllerSatu.text.toString())) + (1000 * int.tryParse(controllerSeribuLogam.text.toString()) + 500 * int.tryParse(controllerLimaRatusLogam.text.toString()) + 200 * int.tryParse(controllerDuaRatusLogam.text.toString()) + 100 * int.tryParse(controllerSeratusLogam.text.toString())) + kasBon.numberValue.toInt()) - bukuKas.numberValue.toInt() - (saldoAwalBuku.numberValue.toInt() + penerimaan.numberValue.toInt() - pengeluaran.numberValue.toInt());
                                                    controllerSelisihPembukuanKas.updateValue(double.tryParse(perhitunganSelisihPembukuanKas.toString()));

                                                    controllerSaldoAkhir.updateValue(double.tryParse(saldoAkhir.toString()));
                                                  });
                                                },
                                                onEditingComplete: () {
                                                  FocusScope.of(context).requestFocus(FocusNode());
                                                },
                                                keyboardType: TextInputType.number,
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder()
                                                )
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child:  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(child: Text('Pengeluaran', style: TextStyle(fontSize: 16.0, color: Colors.black38),),),
                                          Flexible(
                                            child: Container(
                                              height: 35.0,
                                              child: TextField(
                                                controller: pengeluaran,
                                                onChanged: (val) {
                                                  setState(() {
                                                    saldoAkhir = saldoAwalBuku.numberValue.toInt() + penerimaan.numberValue.toInt() - pengeluaran.numberValue.toInt();

                                                    perhitunganSelisihPembukuanKas = ((100000 * int.tryParse(controllerSeratus.text.toString()) + 50000 * int.tryParse(controllerLimaPuluh.text.toString()) + 20000 * int.tryParse(controllerDuaPuluh.text.toString()) + 10000 * int.tryParse(controllerSepuluh.text.toString()) + 5000 * int.tryParse(controllerLima.text.toString()) + 2000 * int.tryParse(controllerDua.text.toString()) + 1000 * int.tryParse(controllerSatu.text.toString())) + (1000 * int.tryParse(controllerSeribuLogam.text.toString()) + 500 * int.tryParse(controllerLimaRatusLogam.text.toString()) + 200 * int.tryParse(controllerDuaRatusLogam.text.toString()) + 100 * int.tryParse(controllerSeratusLogam.text.toString())) + kasBon.numberValue.toInt()) - bukuKas.numberValue.toInt() - (saldoAwalBuku.numberValue.toInt() + penerimaan.numberValue.toInt() - pengeluaran.numberValue.toInt());
                                                    controllerSelisihPembukuanKas.updateValue(double.tryParse(perhitunganSelisihPembukuanKas.toString()));

                                                    controllerSaldoAkhir.updateValue(double.tryParse(saldoAkhir.toString()));
                                                  });
                                                },
                                                onEditingComplete: () {
                                                  FocusScope.of(context).requestFocus(FocusNode());
                                                },
                                                keyboardType: TextInputType.number,
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder()
                                                )
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child:  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(child: Text('Saldo akhir', style: TextStyle(fontSize: 16.0, color: Colors.black38),),),
                                          Flexible(
                                            child: Container(
                                              height: 35.0,
                                              child: TextField(
                                                enabled: false,
                                                controller: controllerSaldoAkhir,
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder()
                                                )
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child:  Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(child: Text('Selisih Pembukuan Kas', style: TextStyle(fontSize: 16.0, color: Colors.black38, fontWeight: FontWeight.bold))),
                                          Flexible(
                                            child: Container(
                                              height: 35.0,
                                              child: TextField(
                                                enabled: false,
                                                // readOnly: true,
                                                // controller: controllerSelisihPembukuanKas,
                                                decoration: InputDecoration(
                                                  labelStyle: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.redAccent
                                                  ),
                                                  labelText: 'Rp ' + controllerSelisihPembukuanKas.text,
                                                  border: InputBorder.none
                                                )
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 30.0,
                                        child: OutlineButton(
                                          child: Text(
                                            'PREV',
                                            style: TextStyle(
                                                fontSize: 13.0, color: Colors.grey),
                                          ),
                                          borderSide:
                                              BorderSide(color: Colors.grey, width: 1.0),
                                          highlightedBorderColor: Colors.grey,
                                          onPressed: () {
                                            _tabController.animateTo((_tabController.index - 1));
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0, right: 20.0),
                                      child: _isProccess
                                        ? Container(
                                            child: Center(
                                              child: CircularProgressIndicator(),
                                            ),
                                          )
                                        : Builder(
                                            builder: (context) {
                                              return ButtonTheme(
                                                minWidth: 50.0,
                                                height: 30.0,
                                                child: OutlineButton(
                                                  child: Text(
                                                    'SAVE',
                                                    style: TextStyle(
                                                      fontSize: 13.0,
                                                      color: AbubaPallate.greenabuba),
                                                  ),
                                                  borderSide: BorderSide(color: AbubaPallate.greenabuba, width: 1.0),
                                                  highlightedBorderColor: AbubaPallate.greenabuba,
                                                  onPressed: () {
                                                    if (controllerSeratus.text == '' ||controllerLimaPuluh.text == '' ||controllerDuaPuluh.text == '' ||controllerSepuluh.text == '' ||controllerLima.text == '' ||controllerDua.text == '' ||controllerSatu.text == '' ||controllerSeribuLogam.text == '' ||controllerLimaRatusLogam.text == '' ||controllerDuaRatusLogam.text == '' ||controllerSeratusLogam.text == '') {
                                                      Scaffold.of(context).showSnackBar(
                                                        SnackBar(
                                                          content: Text('Data Belum Lengkap'),
                                                          duration: Duration(seconds: 2),
                                                          action: SnackBarAction(
                                                            label: 'OK',
                                                            onPressed: () {
                                                              Scaffold.of(context).removeCurrentSnackBar();
                                                            },
                                                          ),
                                                        )
                                                      );
                                                    } else {
                                                      if (_isProccess == false) {
                                                        setState(() {
                                                          _isProccess = true;
                                                          DocumentReference docReference = Firestore.instance.collection('audit_internalDetail-cash').document();

                                                          docReference.setData({
                                                            'docRef': widget.index,
                                                            'dateCraeted': DateTime.now(),
                                                            'userCreated': widget.idUser,
                                                            'kertasSeratus': int.tryParse(controllerSeratus.text.toString()),
                                                            'kertasLimaPuluh': int.tryParse(controllerLimaPuluh.text.toString()),
                                                            'kertasDuaPuluh': int.tryParse(controllerDuaPuluh.text.toString()),
                                                            'kertasSepuluh': int.tryParse(controllerSepuluh.text.toString()),
                                                            'kertasLima': int.tryParse(controllerLima.text.toString()),
                                                            'kertasDua': int.tryParse(controllerDua.text.toString()),
                                                            'kertasSatu': int.tryParse(controllerSatu.text.toString()),
                                                            'logamSeribu': int.tryParse(controllerSeribuLogam.text.toString()),
                                                            'logamLimaRatus': int.tryParse(controllerLimaRatusLogam.text.toString()),
                                                            'logamDuaRatus': int.tryParse(controllerDuaRatusLogam.text.toString()),
                                                            'logamSeratus': int.tryParse(controllerSeratusLogam.text.toString()),
                                                            'kasBonPending': kasBon.numberValue.toInt(),
                                                            'bukuKas': bukuKas.numberValue.toInt(),
                                                            'saldoAwalBuku': saldoAwalBuku.numberValue.toInt(),
                                                            'penerimaan': penerimaan.numberValue.toInt(),
                                                            'pengeluaran': pengeluaran.numberValue.toInt(),
                                                            'saldoAkhir': controllerSaldoAkhir.numberValue.toInt(),
                                                            'selisih': controllerSelisihPembukuanKas.numberValue.toInt()
                                                          }).then((doc) {
                                                            _isProccess = false;
                                                            Navigator.pop(context);
                                                          }).catchError((error) {
                                                            print(error);
                                                          });
                                                        });
                                                      }
                                                    }
                                                  },
                                                ),
                                              );
                                            },
                                          )
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        );
                  },
                )
              ),
            ),
          ),
        ),
      );
    } else {
      // show report
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.25,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            title: Container(
              child: new Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Text(
                      'Report Cash Opname',
                      style: TextStyle(fontSize: 16.0, color: Colors.black54, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: AnimatedBuilder(
              animation: animationController,
              builder: (_, Widget child) {
                return animationController.isAnimating
                  ? Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ), 
                    )
                  : ListView(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(top: 15.0),
                            child:  Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      alignment: Alignment.center,
                                      child: Text(
                                        'NOMINAL',
                                        style: TextStyle(fontSize: 16.0, color: Colors.black38, fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      alignment: Alignment.center,
                                      child: Text(
                                        'JUMLAH',
                                        style: TextStyle(fontSize: 16.0, color: Colors.black38, fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      alignment: Alignment.center,
                                      child: Text(
                                        'SALDO',
                                        style: TextStyle(fontSize: 16.0, color: Colors.black38, fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          color: Colors.grey,
                          height: 30.0,
                          padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 15.0, right: 5.0),
                            child: Text('Uang Kertas', style: TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.w700),
                          )
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(top: 15.0),
                            child:  Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Rp 100.000',
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      alignment: Alignment.center,
                                      child: Text(
                                        kertasSeratus2.toString(),
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'Rp ' + formatter.format(100000 * kertasSeratus2).toString(),
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(top: 15.0),
                            child:  Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Rp 50.000',
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      alignment: Alignment.center,
                                      child: Text(
                                        kertasLimaPuluh2.toString(),
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'Rp ' + formatter.format(50000 * kertasLimaPuluh2).toString(),
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(top: 15.0),
                            child:  Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Rp 20.000',
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      alignment: Alignment.center,
                                      child: Text(
                                        kertasDuaPuluh2.toString(),
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'Rp ' + formatter.format(20000 * kertasDuaPuluh2).toString(),
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(top: 15.0),
                            child:  Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Rp 10.000',
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      alignment: Alignment.center,
                                      child: Text(
                                        kertasSepuluh2.toString(),
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'Rp ' + formatter.format(10000 * kertasSepuluh2).toString(),
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(top: 15.0),
                            child:  Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Rp 5.000',
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      alignment: Alignment.center,
                                      child: Text(
                                        kertasLima2.toString(),
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'Rp ' + formatter.format(5000 * kertasLima2).toString(),
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(top: 15.0),
                            child:  Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Rp 2.000',
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      alignment: Alignment.center,
                                      child: Text(
                                        kertasDua2.toString(),
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'Rp ' + formatter.format(2000 * kertasDua2).toString(),
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(top: 15.0),
                            child:  Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Rp 1.000',
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      alignment: Alignment.center,
                                      child: Text(
                                        kertasSatu2.toString(),
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'Rp ' + formatter.format(1000 * kertasSatu2).toString(),
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          color: Colors.grey,
                          height: 30.0,
                          padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 15.0, right: 5.0),
                            child: Text('Uang Logam', style: TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.w700),
                          )
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(top: 15.0),
                            child:  Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Rp 1.000',
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      alignment: Alignment.center,
                                      child: Text(
                                        logamSeribu2.toString(),
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'Rp ' + formatter.format(1000 * logamSeribu2).toString(),
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(top: 15.0),
                            child:  Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Rp 500',
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      alignment: Alignment.center,
                                      child: Text(
                                        logamLimaRatus2.toString(),
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'Rp ' + formatter.format(500 * logamLimaRatus2).toString(),
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(top: 15.0),
                            child:  Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Rp 200',
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      alignment: Alignment.center,
                                      child: Text(
                                        logamDuaRatus2.toString(),
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'Rp ' + formatter.format(200 * logamDuaRatus2).toString(),
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(top: 15.0),
                            child:  Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Rp 100',
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      alignment: Alignment.center,
                                      child: Text(
                                        logamSeratus2.toString(),
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'Rp ' + formatter.format(100 * logamSeratus2).toString(),
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          color: Colors.grey,
                          height: 30.0,
                          padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 15.0, right: 5.0),
                            child: Text('Jumlah', style: TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.w700),
                          )
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(top: 15.0),
                            child:  Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Kas Tunai',
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'Rp ' + formatter.format((100000 * kertasSeratus2) + (50000 * kertasLimaPuluh2) + (20000 * kertasDuaPuluh2) + (10000 * kertasSepuluh2) + (5000 * kertasLima2) + (2000 * kertasDua2) + (1000 * kertasSatu2) + (1000 * logamSeribu2) + (500 * logamLimaRatus2) + (200 * logamDuaRatus2) + (100 * logamSeratus2)).toString(),
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(top: 15.0),
                            child:  Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Kas Bon / Pending',
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'Rp ' + formatter.format(kasBonPending2).toString(),
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(top: 15.0),
                            child:  Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Kas Tunai dan Bon Sementara',
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'Rp ' + formatter.format((100000 * kertasSeratus2) + (50000 * kertasLimaPuluh2) + (20000 * kertasDuaPuluh2) + (10000 * kertasSepuluh2) + (5000 * kertasLima2) + (2000 * kertasDua2) + (1000 * kertasSatu2) + (1000 * logamSeribu2) + (500 * logamLimaRatus2) + (200 * logamDuaRatus2) + (100 * logamSeratus2) + kasBonPending2).toString(),
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(top: 15.0),
                            child:  Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Menurut Buku Kas',
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'Rp ' + formatter.format(bukuKas2).toString(),
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(top: 15.0),
                            child:  Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Selisih Fisik Kas',
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'Rp ' + formatter.format((100000 * kertasSeratus2) + (50000 * kertasLimaPuluh2) + (20000 * kertasDuaPuluh2) + (10000 * kertasSepuluh2) + (5000 * kertasLima2) + (2000 * kertasDua2) + (1000 * kertasSatu2) + (1000 * logamSeribu2) + (500 * logamLimaRatus2) + (200 * logamDuaRatus2) + (100 * logamSeratus2) + kasBonPending2 - bukuKas2).toString(),
                                        style: TextStyle(fontSize: 16.0, color: Colors.redAccent),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          color: AbubaPallate.menuBluebird,
                          height: 30.0,
                          padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 15.0, right: 5.0),
                            child: Text('Rekonsiliasi Kas', style: TextStyle(fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.w700),
                          )
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(top: 15.0),
                            child:  Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Saldo Awal Buku',
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'Rp ' + formatter.format(saldoAwalBuku2).toString(),
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(top: 15.0),
                            child:  Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Penerimaan',
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'Rp ' + formatter.format(penerimaan2).toString(),
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(top: 15.0),
                            child:  Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Pengeluaran',
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'Rp ' + formatter.format(pengeluaran2).toString(),
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(top: 15.0),
                            child:  Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Saldo Akhir',
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'Rp ' + formatter.format(saldoAkhir2).toString(),
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(top: 15.0),
                            child:  Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Selisih Pembukuan Kas',
                                        style: TextStyle(fontSize: 16.0, color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'Rp ' + formatter.format(selisih2).toString(),
                                        style: TextStyle(fontSize: 16.0, color: Colors.redAccent),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
              },
            )
          ),
        ),
      );
    }
  }
}
