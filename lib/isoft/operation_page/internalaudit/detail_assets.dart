import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';

class DetailAssets extends StatefulWidget {
  DetailAssets({this.idUser, this.namaUser, this.departmentUser, this.index});

  final int idUser;
  final String namaUser;
  final String departmentUser;
  var index;

  @override
  _DetailAssetsState createState() => _DetailAssetsState();
}

class _DetailAssetsState extends State<DetailAssets> with TickerProviderStateMixin {
  bool _isProccess = false;
  int value1 = 0;
  TabController tabController;
  AnimationController animationController;

  final List<Tab> internalAuditTabs = <Tab>[
    new Tab(child: Text('Create', style: TextStyle(color: Colors.grey[400]))),
    new Tab(child: Text('Report', style: TextStyle(color: Colors.grey[400])))
  ];

  TextEditingController controllerAssets = TextEditingController();

  TextEditingController saldoAwal = TextEditingController();
  TextEditingController penambahan = TextEditingController();
  TextEditingController pengurangan = TextEditingController();
  TextEditingController saldoAkhir = TextEditingController();
  TextEditingController saldoFisik = TextEditingController();
  TextEditingController selisih = TextEditingController();

  int perhitunganSaldoAkhir = 0;
  int perhitunganSelisih = 0;
  
  List<String> assetsArray = [];
  List<int> saldoAwalArray = [];
  List<int> penambahanArray = [];
  List<int> penguranganArray = [];
  List<int> saldoAkhirArray = [];
  List<int> saldoFisikArray = [];
  List<int> selisihArray = [];
  List<String> arrayKualitas = [];

  String status;
  List<dynamic> assetsArray2 = [];
  List<dynamic> saldoAwalArray2 = [];
  List<dynamic> penambahanArray2 = [];
  List<dynamic> penguranganArray2 = [];
  List<dynamic> saldoAkhirArray2 = [];
  List<dynamic> saldoFisikArray2 = [];
  List<dynamic> selisihArray2 = [];
  List<dynamic> arrayKualitas2 = [];

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
    tabController = TabController(vsync: this, length: internalAuditTabs.length);

    animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(from: animationController.value == 0.0 ? 1.0 : animationController.value);

    Firestore.instance.collection('audit_internalDetail-assets').where('docRef', isEqualTo: widget.index).snapshots().listen((data2) {
      setState(() {
        if (data2.documents.length == 0) {
          status = 'open';
        } else {
          assetsArray2 = data2.documents[data2.documents.length - 1].data['assets'];
          saldoAwalArray2 = data2.documents[data2.documents.length - 1].data['saldoAwal'];
          penambahanArray2 = data2.documents[data2.documents.length - 1].data['penambahan'];
          penguranganArray2 = data2.documents[data2.documents.length - 1].data['pengurangan'];
          saldoAkhirArray2 = data2.documents[data2.documents.length - 1].data['saldoAkhir'];
          saldoFisikArray2 = data2.documents[data2.documents.length - 1].data['saldoFisik'];
          selisihArray2 = data2.documents[data2.documents.length - 1].data['selisih'];
          arrayKualitas2 = data2.documents[data2.documents.length - 1].data['kualitas'];
          status = 'close';
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
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
                          'Inventory Fixed Asset',
                          style: TextStyle(fontSize: 16.0, color: Colors.black54, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                actions: <Widget>[
                  assetsArray.length == 0
                    ? Container()
                    : Container(
                    height: 25.0,
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
                              height: 25.0,
                              child: RaisedButton(
                                child: Text(
                                  'SAVE',
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.white),
                                ),
                                color: AbubaPallate.greenabuba,
                                splashColor: AbubaPallate.greenabuba,
                                textColor: Colors.white,
                                onPressed: () {
                                  if (assetsArray.length == 0 ||saldoAwalArray.length == 0 ||penambahanArray.length == 0 ||penguranganArray.length == 0 ||saldoAkhirArray.length == 0 ||saldoFisikArray.length == 0 ||selisihArray.length == 0 || arrayKualitas.length == 0) {
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
                                      });
                                      DocumentReference docReference = Firestore.instance.collection('audit_internalDetail-assets').document();

                                      docReference.setData({
                                        'docRef': widget.index,
                                        'assets': assetsArray,
                                        'saldoAwal': saldoAwalArray,
                                        'penambahan': penambahanArray,
                                        'pengurangan': penguranganArray,
                                        'saldoAkhir': saldoAkhirArray,
                                        'saldoFisik': saldoFisikArray,
                                        'selisih': selisihArray,
                                        'kualitas': arrayKualitas,
                                        'dateCraeted': DateTime.now(),
                                        'userCreated': widget.idUser
                                      }).then((doc) {
                                        setState(() {
                                          _isProccess = false;
                                        });
                                        Navigator.pop(context);
                                      }).catchError((error) {
                                        print(error);
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
                bottom: TabBar(
                  controller: tabController,
                  isScrollable: false,
                  onTap: null,
                  indicatorColor: AbubaPallate.greenabuba,
                  tabs: internalAuditTabs,
                )
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
                          controller: tabController,
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
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(child: Text('1. Fixed Asset', style: TextStyle(fontSize: 16.0, color: Colors.black38),),),
                                          Flexible(
                                            child: Container(
                                              height: 35.0,
                                              child: TextField(
                                                keyboardType: TextInputType.text,
                                                textCapitalization: TextCapitalization.sentences,
                                                controller: controllerAssets,
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
                                          Flexible(child: Text('2. Saldo Awal', style: TextStyle(fontSize: 16.0, color: Colors.black38),),),
                                          Flexible(
                                            child: Container(
                                              height: 35.0,
                                              child: TextField(
                                                keyboardType: TextInputType.number,
                                                controller: saldoAwal,
                                                onEditingComplete: () {
                                                  FocusScope.of(context).requestFocus(FocusNode());
                                                },
                                                onChanged: (val) {
                                                  setState(() {
                                                    perhitunganSaldoAkhir = int.tryParse(saldoAwal.text.toString())+ int.tryParse(penambahan.text.toString()) - int.tryParse(pengurangan.text.toString());
                                                    perhitunganSelisih = perhitunganSaldoAkhir - int.tryParse(saldoFisik.text.toString());
                                                    saldoAkhir.text = perhitunganSaldoAkhir.toString();
                                                    selisih.text = perhitunganSelisih.toString();
                                                  });
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
                                          Flexible(child: Text('3. Penambahan', style: TextStyle(fontSize: 16.0, color: Colors.black38),),),
                                          Flexible(
                                            child: Container(
                                              height: 35.0,
                                              child: TextField(
                                                keyboardType: TextInputType.number,
                                                controller: penambahan,
                                                onEditingComplete: () {
                                                  FocusScope.of(context).requestFocus(FocusNode());
                                                },
                                                onChanged: (val) {
                                                  setState(() {
                                                    perhitunganSaldoAkhir = int.tryParse(saldoAwal.text.toString())+ int.tryParse(penambahan.text.toString()) - int.tryParse(pengurangan.text.toString());
                                                    perhitunganSelisih = perhitunganSaldoAkhir - int.tryParse(saldoFisik.text.toString());
                                                    saldoAkhir.text = perhitunganSaldoAkhir.toString();
                                                    selisih.text = perhitunganSelisih.toString();
                                                  });
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
                                          Flexible(child: Text('4. Pengurangan', style: TextStyle(fontSize: 16.0, color: Colors.black38),),),
                                          Flexible(
                                            child: Container(
                                              height: 35.0,
                                              child: TextField(
                                                keyboardType: TextInputType.number,
                                                controller: pengurangan,
                                                onChanged: (val) {
                                                  setState(() {
                                                    perhitunganSaldoAkhir = int.tryParse(saldoAwal.text.toString()) + int.tryParse(penambahan.text.toString()) - int.tryParse(pengurangan.text.toString());
                                                    perhitunganSelisih = perhitunganSaldoAkhir - int.tryParse(saldoFisik.text.toString());
                                                    saldoAkhir.text = perhitunganSaldoAkhir.toString();
                                                    selisih.text = perhitunganSelisih.toString();
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
                                          Flexible(child: Text('5. Saldo Akhir', style: TextStyle(fontSize: 16.0, color: Colors.black38),),),
                                          Flexible(
                                            child: Container(
                                              height: 35.0,
                                              child: TextField(
                                                enabled: false,
                                                controller: saldoAkhir,
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
                                          Flexible(child: Text('6. Saldo Fisik', style: TextStyle(fontSize: 16.0, color: Colors.black38),),),
                                          Flexible(
                                            child: Container(
                                              height: 35.0,
                                              child: TextField(
                                                keyboardType: TextInputType.number,
                                                controller: saldoFisik,
                                                onEditingComplete: () {
                                                  FocusScope.of(context).requestFocus(FocusNode());
                                                },
                                                onChanged: (val) {
                                                  setState(() {
                                                    perhitunganSaldoAkhir = int.tryParse(saldoAwal.text.toString())+ int.tryParse(penambahan.text.toString()) - int.tryParse(pengurangan.text.toString());
                                                    perhitunganSelisih = perhitunganSaldoAkhir - int.tryParse(saldoFisik.text.toString());
                                                    saldoAkhir.text = perhitunganSaldoAkhir.toString();
                                                    selisih.text = perhitunganSelisih.toString();
                                                  });
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
                                          Flexible(child: Text('7. Selisih', style: TextStyle(fontSize: 16.0, color: Colors.black38),),),
                                          Flexible(
                                            child: Container(
                                              height: 35.0,
                                              child: TextField(
                                                enabled: false,
                                                controller: selisih,
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
                                          Flexible(child: Text('8. Kualitas', style: TextStyle(fontSize: 16.0, color: Colors.black38),),),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child:  Padding(
                                      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                  width: MediaQuery.of(context).size.width * 0.3,
                                                  child: RadioListTile(
                                                    value: 1,
                                                    groupValue: value1,
                                                    onChanged: (int newValue) {
                                                      setState(() {
                                                        value1 = newValue;
                                                      });
                                                    },
                                                    activeColor: Colors.green,
                                                    controlAffinity: ListTileControlAffinity.leading,
                                                    title: Text('BAIK', style: TextStyle(fontSize: 14.0)),
                                                  ),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context).size.width * 0.3,
                                                  child: RadioListTile(
                                                    value: 2,
                                                    groupValue: value1,
                                                    onChanged: (int newValue) {
                                                      setState(() {
                                                        value1 = newValue;
                                                      });
                                                    },
                                                    activeColor: Colors.green,
                                                    controlAffinity: ListTileControlAffinity.leading,
                                                    title: Text('TIDAK', style: TextStyle(fontSize: 14.0)),
                                                  ),
                                                )
                                              ],
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
                                            'ADD',
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              color: AbubaPallate.menuBluebird),
                                          ),
                                          borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                                          highlightedBorderColor: AbubaPallate.menuBluebird,
                                          onPressed: () {
                                            setState(() {
                                              assetsArray.add(controllerAssets.text);
                                              saldoAwalArray.add(int.tryParse(saldoAwal.text.toString()));
                                              penambahanArray.add(int.tryParse(penambahan.text.toString()));
                                              penguranganArray.add(int.tryParse(pengurangan.text.toString()));
                                              saldoAkhirArray.add(int.tryParse(saldoAkhir.text.toString()));
                                              saldoFisikArray.add(int.tryParse(saldoFisik.text.toString()));
                                              selisihArray.add(int.tryParse(selisih.text.toString()));
                                              arrayKualitas.add(value1 == 1 ? 'BAIK' : 'TIDAK');

                                              controllerAssets.clear();
                                              saldoAwal.clear();
                                              penambahan.clear();
                                              pengurangan.clear();
                                              saldoAkhir.clear();
                                              saldoFisik.clear();
                                              selisih.clear();
                                              perhitunganSaldoAkhir = 0;
                                              perhitunganSelisih = 0;
                                              value1 = 1;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            // inventory opname report
                            assetsArray.length == 0
                              ? ListView(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                                      child: Center(
                                        child: Text(
                                          'No Data',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              : Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 17.0, right: 17.0, top: 20.0, bottom: 15.0),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                          left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                          right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                          bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                        ),
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.symmetric(vertical: 5),
                                            alignment: Alignment.center,
                                            color: AbubaPallate.menuBluebird,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Kesimpulan',
                                                    style: TextStyle(fontSize: 17.0, color: Colors.white, fontWeight: FontWeight.w700),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Flexible(child: Text('Baik', style: TextStyle(fontSize: 16.0, color: Colors.black87, fontWeight: FontWeight.w700), textAlign: TextAlign.center)),
                                                Flexible(child: Text('Tidak Baik', style: TextStyle(fontSize: 16.0, color: Colors.black87, fontWeight: FontWeight.w700), textAlign: TextAlign.center)),
                                                Flexible(child: Text('Selisih', style: TextStyle(fontSize: 16.0, color: Colors.black87, fontWeight: FontWeight.w700), textAlign: TextAlign.center)),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Flexible(child: Text(arrayKualitas.where((test) => test == 'BAIK').length.toString(), style: TextStyle(fontSize: 16.0, color: Colors.black87), textAlign: TextAlign.center)),
                                                Flexible(child: Text(arrayKualitas.where((test) => test == 'TIDAK').length.toString(), style: TextStyle(fontSize: 16.0, color: Colors.redAccent), textAlign: TextAlign.center)),
                                                Flexible(child: Text(selisihArray.reduce((a, b) => a + b).toString(), style: TextStyle(fontSize: 16.0, color: Colors.redAccent), textAlign: TextAlign.center)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: ListView.builder(
                                      itemCount: assetsArray.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return ExpansionTile(
                                          title: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                width: MediaQuery.of(context).size.width * 0.6,
                                                child: Text(
                                                  '${index + 1}. ${assetsArray[index]}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w700
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.bottomRight,
                                                width: MediaQuery.of(context).size.width * 0.2,
                                                child: IconButton(
                                                  icon: Icon(Icons.delete, color: Colors.black54),
                                                  onPressed: () {
                                                    setState(() {
                                                      assetsArray.removeAt(index);
                                                      saldoAwalArray.removeAt(index);
                                                      penambahanArray.removeAt(index);
                                                      penguranganArray.removeAt(index);
                                                      saldoAkhirArray.removeAt(index);
                                                      saldoFisikArray.removeAt(index);
                                                      selisihArray.removeAt(index);
                                                      arrayKualitas.removeAt(index);
                                                    });
                                                  },
                                                )
                                              ),
                                            ],
                                          ),
                                          children: <Widget>[
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
                                                      Flexible(child: Text('1. Fixed Asset', style: TextStyle(fontSize: 16.0, color: Colors.black38, fontWeight: FontWeight.w700),),),
                                                      Flexible(child: Text(assetsArray[index], style: TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.w700),),),
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
                                                      Flexible(child: Text('2. Saldo Awal', style: TextStyle(fontSize: 16.0, color: Colors.black38),),),
                                                      Flexible(child: Text(saldoAwalArray[index].toString(), style: TextStyle(fontSize: 16.0, color: Colors.black),),),
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
                                                      Flexible(child: Text('3. Penambahan', style: TextStyle(fontSize: 16.0, color: Colors.black38),),),
                                                      Flexible(child: Text(penambahanArray[index].toString(), style: TextStyle(fontSize: 16.0, color: Colors.black),),),
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
                                                      Flexible(child: Text('4. Pengurangan', style: TextStyle(fontSize: 16.0, color: Colors.black38),),),
                                                      Flexible(child: Text(penguranganArray[index].toString(), style: TextStyle(fontSize: 16.0, color: Colors.black),),),
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
                                                      Flexible(child: Text('5. Saldo Akhir', style: TextStyle(fontSize: 16.0, color: Colors.black38),),),
                                                      Flexible(child: Text(saldoAkhirArray[index].toString(), style: TextStyle(fontSize: 16.0, color: Colors.black),),),
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
                                                      Flexible(child: Text('6. Saldo Fisik', style: TextStyle(fontSize: 16.0, color: Colors.black38),),),
                                                      Flexible(child: Text(saldoFisikArray[index].toString(), style: TextStyle(fontSize: 16.0, color: Colors.black),),),
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
                                                      Flexible(child: Text('7. Selisih', style: TextStyle(fontSize: 16.0, color: Colors.black38),),),
                                                      Flexible(child: Text(selisihArray[index].toString(), style: TextStyle(fontSize: 16.0, color: Colors.black),),),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                                              child: Container(
                                                width: MediaQuery.of(context).size.width,
                                                padding: const EdgeInsets.only(top: 15.0),
                                                child:  Padding(
                                                  padding: const EdgeInsets.all(10.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Flexible(child: Text('8. Kualitas', style: TextStyle(fontSize: 16.0, color: Colors.black38),),),
                                                      Flexible(child: Text(arrayKualitas[index].toString(), style: TextStyle(fontSize: 16.0, color: Colors.black),),),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              )
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
                      'Report Inventory Fixed Asset',
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
                  : ListView.builder(
                      itemCount: assetsArray2.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ExpansionTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: Text(
                                  '${index + 1}. ${assetsArray2[index]}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700
                                  ),
                                ),
                              ),
                            ],
                          ),
                          children: <Widget>[
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
                                      Flexible(child: Text('1. Fixed Asset', style: TextStyle(fontSize: 16.0, color: Colors.black38, fontWeight: FontWeight.w700),),),
                                      Flexible(child: Text(assetsArray2[index], style: TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.w700),),),
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
                                      Flexible(child: Text('2. Saldo Awal', style: TextStyle(fontSize: 16.0, color: Colors.black38),),),
                                      Flexible(child: Text(saldoAwalArray2[index].toString(), style: TextStyle(fontSize: 16.0, color: Colors.black),),),
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
                                      Flexible(child: Text('3. Penambahan', style: TextStyle(fontSize: 16.0, color: Colors.black38),),),
                                      Flexible(child: Text(penambahanArray2[index].toString(), style: TextStyle(fontSize: 16.0, color: Colors.black),),),
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
                                      Flexible(child: Text('4. Pengurangan', style: TextStyle(fontSize: 16.0, color: Colors.black38),),),
                                      Flexible(child: Text(penguranganArray2[index].toString(), style: TextStyle(fontSize: 16.0, color: Colors.black),),),
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
                                      Flexible(child: Text('5. Saldo Akhir', style: TextStyle(fontSize: 16.0, color: Colors.black38),),),
                                      Flexible(child: Text(saldoAkhirArray2[index].toString(), style: TextStyle(fontSize: 16.0, color: Colors.black),),),
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
                                      Flexible(child: Text('6. Saldo Fisik', style: TextStyle(fontSize: 16.0, color: Colors.black38),),),
                                      Flexible(child: Text(saldoFisikArray2[index].toString(), style: TextStyle(fontSize: 16.0, color: Colors.black),),),
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
                                      Flexible(child: Text('7. Selisih', style: TextStyle(fontSize: 16.0, color: Colors.black38),),),
                                      Flexible(child: Text(selisihArray2[index].toString(), style: TextStyle(fontSize: 16.0, color: Colors.black),),),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.only(top: 15.0),
                                child:  Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(child: Text('8. Kualitas', style: TextStyle(fontSize: 16.0, color: Colors.black38),),),
                                      Flexible(child: Text(arrayKualitas2[index].toString(), style: TextStyle(fontSize: 16.0, color: Colors.black),),),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
              },
            )
          ),
        ),
      );
    }
  }
}
