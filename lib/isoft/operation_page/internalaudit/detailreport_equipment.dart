import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';

class DetailReportEquipment extends StatefulWidget {
  DetailReportEquipment({this.idUser, this.namaUser, this.departmentUser, this.index});

  final int idUser;
  final String namaUser;
  final String departmentUser;
  var index;

  @override
  _DetailReportEquipmentState createState() => _DetailReportEquipmentState();
}

class _DetailReportEquipmentState extends State<DetailReportEquipment> with TickerProviderStateMixin {
  AnimationController animationController;

  String status;
  List<dynamic> cutleriesArray2 = [];
  List<dynamic> saldoAwalArray2 = [];
  List<dynamic> penambahanArray2 = [];
  List<dynamic> penguranganArray2 = [];
  List<dynamic> saldoAkhirArray2 = [];
  List<dynamic> saldoFisikArray2 = [];
  List<dynamic> selisihArray2 = [];
  List<dynamic> arrayKualitas2 = [];

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(from: animationController.value == 0.0 ? 1.0 : animationController.value);

    Firestore.instance.collection('audit_internalDetail-cutleries').where('docRef', isEqualTo: widget.index).snapshots().listen((data2) {
      setState(() {
        if (data2.documents.length == 0) {
          status = 'no';
        } else {
          cutleriesArray2 = data2.documents[data2.documents.length - 1].data['cutleries'];
          saldoAwalArray2 = data2.documents[data2.documents.length - 1].data['saldoAwal'];
          penambahanArray2 = data2.documents[data2.documents.length - 1].data['penambahan'];
          penguranganArray2 = data2.documents[data2.documents.length - 1].data['pengurangan'];
          saldoAkhirArray2 = data2.documents[data2.documents.length - 1].data['saldoAkhir'];
          saldoFisikArray2 = data2.documents[data2.documents.length - 1].data['saldoFisik'];
          selisihArray2 = data2.documents[data2.documents.length - 1].data['selisih'];
          arrayKualitas2 = data2.documents[data2.documents.length - 1].data['kualitas'];
          status = 'yes';
        }
      });
    });
    super.initState();
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
                      'Report Inventory Cutleries',
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
                      'Report Inventory Cutleries',
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
                                      Flexible(child: Text(arrayKualitas2.where((test) => test == 'BAIK').length.toString(), style: TextStyle(fontSize: 16.0, color: Colors.black87), textAlign: TextAlign.center)),
                                      Flexible(child: Text(arrayKualitas2.where((test) => test == 'TIDAK').length.toString(), style: TextStyle(fontSize: 16.0, color: Colors.redAccent), textAlign: TextAlign.center)),
                                      Flexible(child: Text(selisihArray2.reduce((a, b) => a + b).toString(), style: TextStyle(fontSize: 16.0, color: Colors.redAccent), textAlign: TextAlign.center)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          child: ListView.builder(
                            itemCount: cutleriesArray2.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ExpansionTile(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.75,
                                      child: Text(
                                        '${index + 1}. ${cutleriesArray2[index]}',
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
                                            Flexible(child: Text('1. Cutleries', style: TextStyle(fontSize: 16.0, color: Colors.black38, fontWeight: FontWeight.w700),),),
                                            Flexible(child: Text(cutleriesArray2[index], style: TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.w700),),),
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
                          ),
                        )
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
