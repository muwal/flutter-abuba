import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';

class DetailReportCash extends StatefulWidget {
  DetailReportCash({this.idUser, this.namaUser, this.departmentUser, this.index});

  final int idUser;
  final String namaUser;
  final String departmentUser;
  var index;

  @override
  _DetailReportCashState createState() => _DetailReportCashState();
}

class _DetailReportCashState extends State<DetailReportCash> with TickerProviderStateMixin {
  AnimationController animationController;
  final formatter = new NumberFormat("#,###");

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
  String status;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(from: animationController.value == 0.0 ? 1.0 : animationController.value);

    Firestore.instance.collection('audit_internalDetail-cash').where('docRef', isEqualTo: widget.index).snapshots().listen((data2) {
      setState(() {
        if (data2.documents.length == 0) {
          status = 'no';
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
          status = 'yes';
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (status == 'no') {
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
                  : Container(
                      child: Center(
                        child: Text(
                          'No Data'
                        ),
                      ),
                    );
              },
            )
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
