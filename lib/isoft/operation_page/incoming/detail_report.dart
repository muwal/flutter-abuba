import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';

class DetailReport extends StatefulWidget {
  DetailReport({this.idUser, this.namaUser, this.departmentUser, this.index});

  final int idUser;
  final String namaUser;
  final String departmentUser;
  var index;

  @override
  _DetailReportState createState() => _DetailReportState();
}

class _DetailReportState extends State<DetailReport> with TickerProviderStateMixin {
  AnimationController animationController;

  Timestamp tglDatang;
  String material;
  String supplier;
  String resourceCode;
  List<dynamic> supplierEvaluation = [];
  Timestamp alasanWaktu;
  String alasanJumlah;
  String lot;
  Timestamp tglProduksi;
  Timestamp tglExpired;
  String status;
  String qty;
  String unit;

  List<dynamic> detailAttr = [];
  List<dynamic> detailVar = [];
  List<dynamic> jawabanAttr = [];
  List<dynamic> jawabanVar = [];
  List<dynamic> stdAttr = [];
  List<dynamic> stdVar = [];

  String userCreated;
  Timestamp dateCreated;

  @override
  void initState() {
    super.initState();
    
    Firestore.instance.collection('incoming').document(widget.index).snapshots().listen((data) {
      setState(() {
        tglDatang = data.data['tglDatang'];
        supplierEvaluation = data.data['jawaban_supplier_evaluation'];
        alasanWaktu = data.data['alasan_supplier_evaluation'][0];
        alasanJumlah = data.data['alasan_supplier_evaluation'][1];
        tglProduksi = data.data['production_date'];
        tglExpired = data.data['expired_date'];
        lot = data.data['internal_lot'];
        status = data.data['status'];
        
        if (data.data.containsKey('unit')) {
          unit = data.data['unit'];
        }else{
          unit = "-";
        }

        detailAttr = data.data['detailAttrName'];
        detailVar = data.data['detailVarName'];
        jawabanAttr = data.data['jawaban_parameter_atribut'];
        jawabanVar = data.data['jawaban_parameter_variable'];
        stdVar = data.data['stdVar'];
        stdAttr = data.data['stdAttr'];

        qty = data.data['qty'].toString();

        dateCreated = data.data['date_created'];

        Firestore.instance.collection('user').where('id', isEqualTo: data.data['pic']).snapshots().listen((data4) {
          userCreated = data4.documents[0].data['nama'];
        });

        Firestore.instance.collection('material').where('id', isEqualTo: data.data['id_material']).snapshots().listen((data2) {
          material = data2.documents[0].data['material'];
          resourceCode = data2.documents[0].data['resource_code'];

          Firestore.instance.collection('supplier').where('id', isEqualTo: data2.documents[0].data['id_supplier']).snapshots().listen((data3) {
            supplier = data3.documents[0].data['supplier'];
          });
        });
      });  
    });

    animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(
      from: animationController.value == 0.0
        ? 1.0
        : animationController.value
    );
  }

  @override
  Widget build(BuildContext context) {
    final double size = MediaQuery.of(context).size.width;

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
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: _bodyForm(size),
        ),
      ),
    );
  }

  Widget _bodyForm(double size) {
    return Scrollbar(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Incoming',
                  style: TextStyle(color: Colors.black12, fontSize: 12.0),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    '|',
                    style: TextStyle(
                        color: AbubaPallate.greenabuba, fontSize: 12.0),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    'Detail Report',
                    style: TextStyle(
                        color: AbubaPallate.greenabuba, fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
          AnimatedBuilder(
            animation: animationController,
            builder: (_, Widget child) {
              return animationController.isAnimating
                ? Container(
                    child: Center(
                      child:CircularProgressIndicator()
                    ),
                  )
                : Container(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0, top: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: ButtonTheme(
                                  minWidth: 50.0,
                                  height: 30.0,
                                  splashColor: status == 'APPROVED' 
                                      ? AbubaPallate.greenabuba 
                                      : status == 'REJECTED'
                                          ? Colors.red
                                          : Colors.blue,
                                  child: FlatButton(
                                    color: status == 'APPROVED' 
                                      ? AbubaPallate.greenabuba 
                                      : status == 'REJECTED'
                                          ? Colors.red
                                          : Colors.blue,
                                    textColor: Colors.white,
                                    onPressed: () {},
                                    child: Text(
                                      status
                                    ),
                                  )
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Data Permintaan',
                                        style: TextStyle(
                                          fontSize: 15.0, color: Colors.black87, fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Material',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        material,
                                        // 'asd',
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Resource#',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        '#$resourceCode',
                                        // 'asd',
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Supplier',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.40,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        supplier,
                                        // 'asd',
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.40,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Tanggal Kedatangan',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        tglDatang.toDate().toString().substring(8, 10) + '/' + tglDatang.toDate().toString().substring(5, 7) + '/' +tglDatang.toDate().toString().substring(0, 4),
                                        // 'asd',
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Jam',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        // '15:00',
                                        tglDatang.toDate().toString().substring(11, 16),
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Divider(
                            height: 6.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Data Akurasi',
                                        style: TextStyle(
                                          fontSize: 15.0, color: Colors.black87, fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.50,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Barang Datang Tepat Waktu',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        supplierEvaluation[0] == 'NO' ? '${supplierEvaluation[0]}   |   ${alasanWaktu.toDate().toString().substring(11, 16)}' : supplierEvaluation[0],
                                        // 'asd',
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: supplierEvaluation[0] == 'NO' ? Colors.redAccent : AbubaPallate.greenabuba,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.40,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Barang Datang Tepat Jumlah',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.40,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        supplierEvaluation[1] == 'NO' ? '${supplierEvaluation[1]}   |   $alasanJumlah' : supplierEvaluation[1],
                                        // 'asd',
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: supplierEvaluation[1] == 'NO' ? Colors.redAccent : AbubaPallate.greenabuba,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.end,
                        //     children: <Widget>[
                        //       Container(
                        //         padding: EdgeInsets.only(right: 15.0),
                        //         alignment: Alignment.centerRight,
                        //         child: ButtonTheme(
                        //           minWidth: 50.0,
                        //           height: 30.0,
                        //           splashColor: AbubaPallate.menuBluebird,
                        //           child: OutlineButton(
                        //             borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                        //             highlightedBorderColor: AbubaPallate.menuBluebird,
                        //             onPressed: () {
                        //               setState(() {
                        //                 showNote = !showNote;
                        //               });
                        //             },
                        //             child: Text(
                        //               'NOTE',
                        //               style: TextStyle(color: AbubaPallate.menuBluebird, fontSize: 12.0),
                        //             ),
                        //           ),
                        //         )
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // showNote
                        //   ? Padding(
                        //       padding: EdgeInsets.only(left: 17.0, right: 17.0),
                        //       child: Container(
                        //         decoration: const BoxDecoration(
                        //           border: Border(
                        //             top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                        //             left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                        //             right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                        //             bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                        //           ),
                        //         ),
                        //         padding: EdgeInsets.all(10.0),
                        //         child: Column(
                        //           children: <Widget>[
                        //             Row(
                        //               children: <Widget>[
                        //                 Flexible(
                        //                   child: Text(
                        //                     'Note',
                        //                     style: TextStyle(
                        //                         color: Colors.black54,
                        //                         fontWeight: FontWeight.w700),
                        //                   ),
                        //                 )
                        //               ],
                        //             ),
                        //             SizedBox(
                        //               height: 5.0,
                        //             ),
                        //             Row(
                        //                 children: <Widget>[
                        //                   Flexible(
                        //                     child: Text(
                        //                       // note == null ? '-' : note,
                        //                       'asd',
                        //                       style: TextStyle(
                        //                         color: Colors.black38,
                        //                       ),
                        //                     ),
                        //                   )
                        //                 ],
                        //               )
                        //           ],
                        //         ),
                        //       ),
                        //     )
                        //   : Container(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Divider(
                            height: 6.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Data Barang',
                                        style: TextStyle(
                                          fontSize: 15.0, color: Colors.black87, fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.50,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Nomor Internal Lot',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        lot,
                                        // 'asd',
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.50,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Tanggal Produksi',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        tglProduksi.toDate().toString().substring(8, 10) + '/' + tglProduksi.toDate().toString().substring(5, 7) + '/' +tglProduksi.toDate().toString().substring(0, 4),
                                        // 'asd',
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.50,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Tanggal Expired',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        tglExpired.toDate().toString().substring(8, 10) + '/' + tglExpired.toDate().toString().substring(5, 7) + '/' +tglExpired.toDate().toString().substring(0, 4),
                                        // 'asd',
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.50,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Quantity',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        qty,
                                        // 'asd',
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.50,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Unit',
                                        style: TextStyle(
                                            fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        unit,
                                        // 'asd',
                                        style: TextStyle(
                                            fontSize: 13.0,
                                            color: Colors.black38,
                                            fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0, top: 10.0),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.end,
                        //     children: <Widget>[
                        //       Container(
                        //         padding: EdgeInsets.only(right: 15.0),
                        //         alignment: Alignment.centerRight,
                        //         child: ButtonTheme(
                        //           minWidth: 50.0,
                        //           height: 30.0,
                        //           splashColor: AbubaPallate.menuBluebird,
                        //           child: OutlineButton(
                        //             borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                        //             highlightedBorderColor: AbubaPallate.menuBluebird,
                        //             onPressed: () {
                        //               setState(() {
                        //                 showNote2 = !showNote2;
                        //               });
                        //             },
                        //             child: Text(
                        //               'NOTE',
                        //               style: TextStyle(color: AbubaPallate.menuBluebird, fontSize: 12.0),
                        //             ),
                        //           ),
                        //         )
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // showNote2
                        //   ? Padding(
                        //       padding: EdgeInsets.only(left: 17.0, right: 17.0),
                        //       child: Container(
                        //         decoration: const BoxDecoration(
                        //           border: Border(
                        //             top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                        //             left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                        //             right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                        //             bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                        //           ),
                        //         ),
                        //         padding: EdgeInsets.all(10.0),
                        //         child: Column(
                        //           children: <Widget>[
                        //             Row(
                        //               children: <Widget>[
                        //                 Flexible(
                        //                   child: Text(
                        //                     'Note',
                        //                     style: TextStyle(
                        //                         color: Colors.black54,
                        //                         fontWeight: FontWeight.w700),
                        //                   ),
                        //                 )
                        //               ],
                        //             ),
                        //             SizedBox(
                        //               height: 5.0,
                        //             ),
                        //             Row(
                        //                 children: <Widget>[
                        //                   Flexible(
                        //                     child: Text(
                        //                       // note2 == null ? '-' : note2,
                        //                       'asd',
                        //                       style: TextStyle(
                        //                         color: Colors.black38,
                        //                       ),
                        //                     ),
                        //                   )
                        //                 ],
                        //               )
                        //           ],
                        //         ),
                        //       ),
                        //     )
                        //   : Container(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Divider(
                            height: 6.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Data Analisa',
                                        style: TextStyle(
                                          fontSize: 15.0, color: Colors.black87, fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        detailAttr.length > 0
                          ? Column(
                              children: List.generate(detailAttr.length, (index) {
                                return Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.50,
                                            child: Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    detailAttr[index],
                                                    style: TextStyle(
                                                      fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.35,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    // '${suhu} ℃',
                                                    jawabanAttr[index].toString(),
                                                    style: TextStyle(
                                                      fontSize: 13.0,
                                                      color: jawabanAttr[index] == 'NO' ? Colors.redAccent : AbubaPallate.greenabuba,
                                                      fontWeight: FontWeight.w700
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.5,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    // '${suhu} ℃',
                                                    stdAttr[index].toString(),
                                                    style: TextStyle(
                                                      fontSize: 13.0,
                                                      color: Colors.black38,
                                                      fontWeight: FontWeight.w700
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              }).toList(),
                            )
                          : Container(),
                        detailVar.length > 0
                          ? Column(
                              children: List.generate(detailVar.length, (index) {
                                return Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.50,
                                            child: Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    detailVar[index],
                                                    style: TextStyle(
                                                      fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.35,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    // '${suhu} ℃',
                                                    jawabanVar[index].toString(),
                                                    style: TextStyle(
                                                      fontSize: 13.0,
                                                      color: Colors.black38,
                                                      fontWeight: FontWeight.w700
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.50,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    // '${suhu} ℃',
                                                    stdVar[index].toString(),
                                                    style: TextStyle(
                                                      fontSize: 13.0,
                                                      color: Colors.black38,
                                                      fontWeight: FontWeight.w700
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              }).toList(),
                            )
                          : Container(),
                        
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0, top: 10.0),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.end,
                        //     children: <Widget>[
                        //       Container(
                        //         padding: EdgeInsets.only(right: 15.0),
                        //         alignment: Alignment.centerRight,
                        //         child: ButtonTheme(
                        //           minWidth: 50.0,
                        //           height: 30.0,
                        //           splashColor: AbubaPallate.menuBluebird,
                        //           child: OutlineButton(
                        //             borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                        //             highlightedBorderColor: AbubaPallate.menuBluebird,
                        //             onPressed: () {
                        //               setState(() {
                        //                 showNote3 = !showNote3;
                        //               });
                        //             },
                        //             child: Text(
                        //               'NOTE',
                        //               style: TextStyle(color: AbubaPallate.menuBluebird, fontSize: 12.0),
                        //             ),
                        //           ),
                        //         )
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // showNote3
                        //   ? Padding(
                        //       padding: EdgeInsets.only(left: 17.0, right: 17.0),
                        //       child: Container(
                        //         decoration: const BoxDecoration(
                        //           border: Border(
                        //             top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                        //             left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                        //             right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                        //             bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                        //           ),
                        //         ),
                        //         padding: EdgeInsets.all(10.0),
                        //         child: Column(
                        //           children: <Widget>[
                        //             Row(
                        //               children: <Widget>[
                        //                 Flexible(
                        //                   child: Text(
                        //                     'Note',
                        //                     style: TextStyle(
                        //                         color: Colors.black54,
                        //                         fontWeight: FontWeight.w700),
                        //                   ),
                        //                 )
                        //               ],
                        //             ),
                        //             SizedBox(
                        //               height: 5.0,
                        //             ),
                        //             Row(
                        //                 children: <Widget>[
                        //                   Flexible(
                        //                     child: Text(
                        //                       // note3 == null ? '-' : note3,
                        //                       'asd',
                        //                       style: TextStyle(
                        //                         color: Colors.black38,
                        //                       ),
                        //                     ),
                        //                   )
                        //                 ],
                        //               )
                        //           ],
                        //         ),
                        //       ),
                        //     )
                        //   : Container(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Divider(
                            height: 0.5,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Data Inspeksi',
                                        style: TextStyle(
                                          fontSize: 15.0, color: Colors.black87, fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.50,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Pelaksana',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        userCreated,
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.50,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Jam',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        dateCreated.toDate().toString().substring(11, 16),
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.50,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Tanggal',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        dateCreated.toDate().toString().substring(8, 10) + '/' + dateCreated.toDate().toString().substring(5, 7) + '/' +dateCreated.toDate().toString().substring(0, 4),
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.50,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Status',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        status,
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: status == 'APPROVED' 
                                              ? AbubaPallate.greenabuba 
                                              : status == 'REJECTED'
                                                  ? Colors.red
                                                  : Colors.blue,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
            },
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
//        itemCount: 10,
      ),
    );
  }
}
