import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailQuantity extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  final int idSupplier;
  DetailQuantity({this.idUser, this.namaUser, this.departmentUser, this.idSupplier});
  @override
  _DetailQuantityState createState() => _DetailQuantityState();
}

class _DetailQuantityState extends State<DetailQuantity> with TickerProviderStateMixin {
  AnimationController animationController;
  String supplierName;
  String supplierKode;
  var incoming = [];
  var material = [];
  List<dynamic> tanggal = [];
  List<String> tanggal2 = [];

  @override
  void initState() {
    super.initState();

    Firestore.instance.collection('supplier').where('id', isEqualTo: widget.idSupplier).snapshots().listen((data) {
      setState(() {
        supplierName = data.documents[0].data['supplier'];
        supplierKode = data.documents[0].data['kode'];
      });
    });

    CollectionReference reference = Firestore.instance.collection('incoming');
    reference.where('id_supplier', isEqualTo: int.tryParse(widget.idSupplier.toString())).snapshots().listen((data2) {
      data2.documentChanges.forEach((change) {
        setState(() {
          Timestamp tanggalbantu2 = change.document.data['date_created'];
          tanggal2.add(tanggalbantu2.toDate().toString().substring(0, 10));
          incoming.add(change.document.data['jawaban_supplier_evaluation'][1]);

          if (change.document.data['jawaban_supplier_evaluation'][1] == 'NO') {
            Firestore.instance.collection('material').where('id', isEqualTo: change.document.data['id_material']).snapshots().listen((data4) {
              material.add(data4.documents[0].data['material']);
            });

            Timestamp tanggalbantu = change.document.data['date_created'];
            tanggal.add(tanggalbantu.toDate());
          }
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
        body: _buildIsoMenu(),
      ),
    );
  }

  Widget _buildIsoMenu() {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Evaluation',
                style: TextStyle(color: Colors.black12, fontSize: 12.0),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  '|',
                  style:
                      TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  'Detail Quality',
                  style:
                      TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
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
                    child: CircularProgressIndicator()
                  ) 
                )
              : Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(supplierName),
                                SizedBox(
                                  height: 3.0,
                                ),
                                Text(
                                  supplierKode,
                                  style:
                                      TextStyle(fontSize: 12.0, color: Colors.black54),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 0.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Performance',
                                style: TextStyle(color: AbubaPallate.greenabuba),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                tanggal2.length == 0
                                  ? '-'
                                  : '${tanggal2.first.toString().substring(8, 10) + '/' + tanggal2.first.toString().substring(5, 7) + '/' + tanggal2.first.toString().substring(0, 4)} - ${tanggal2.last.toString().substring(8, 10) + '/' + tanggal2.last.toString().substring(5, 7) + '/' + tanggal2.last.toString().substring(0, 4)}',
                                style: TextStyle(color: Colors.black54, fontSize: 10.0),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    incoming.length == 0
                                      ? '0%'
                                      : (incoming.where((c) => c == 'YES').toList().length / incoming.length * 100).round() > 100
                                          ? '100%'
                                          : '${(incoming.where((c) => c == 'YES').toList().length / incoming.length * 100).round().toString()}%',
                                    style: TextStyle(
                                        color: Colors.black87, fontSize: 14.0),
                                  ),
                                )
                              ],
                            ),
                            LinearPercentIndicator(
                              alignment: MainAxisAlignment.center,
                              width: 330.0,
                              animation: true,
                              lineHeight: 30.0,
                              percent: incoming.length == 0 ? 0 : incoming.where((c) => c == 'YES').toList().length / incoming.length,
                              animationDuration: 1000,
                              linearStrokeCap: LinearStrokeCap.butt,
                              progressColor: Colors.green[300],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Total delivery',
                                style: TextStyle(fontSize: 12.0, color: Colors.black38),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                '# Rejected',
                                style: TextStyle(fontSize: 12.0, color: Colors.black38),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                incoming.length.toString(),
                                style: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                material.length.toString(),
                                style: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        height: 8.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Detail Rejection',
                                style: TextStyle(color: AbubaPallate.greenabuba),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: DataTable(
                            onSelectAll: (b) {},
                            sortAscending: true,
                            columns: <DataColumn>[
                              DataColumn(
                                label: Text("Tanggal"),
                                numeric: false,
                                onSort: (i, b) {
                                  print("$i $b");
                                  setState(() {
                                    material.sort((a, b) => a.compareTo(b));
                                  });
                                },
                                tooltip: "To display first name of the Name",
                              ),
                              DataColumn(
                                label: Text("Material"),
                                numeric: false,
                                onSort: (i, b) {
                                  print("$i $b");
                                  setState(
                                    () {
                                      material.sort((a, b) => a.compareTo(b));
                                    },
                                  );
                                },
                                tooltip: "To display first name of the Name",
                              ),
                            ],
                            rows: List.generate(material.length, (index) {
                              return DataRow(
                                cells: [
                                  DataCell(
                                    Text(tanggal[index].toString().substring(8, 10) + '/' + tanggal[index].toString().substring(5, 7) + '/' + tanggal[index].toString().substring(0, 4)),
                                    showEditIcon: false,
                                    placeholder: false,
                                  ),
                                  DataCell(
                                    Text(material[index]),
                                    showEditIcon: false,
                                    placeholder: false,
                                  )
                                ],
                              );
                            }).toList()
                          ),
                        ),
                      ),
                    ],
                  ),
                );
          }
        ),
      ],
    );
  }
}