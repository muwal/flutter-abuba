import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class FormMaterial extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  final int supplierID;

  FormMaterial({this.idUser, this.namaUser, this.departmentUser, this.supplierID});

  @override
  _FormMaterialState createState() => _FormMaterialState();
}

class _FormMaterialState extends State<FormMaterial> with TickerProviderStateMixin {

  AnimationController animationController;
  List<dynamic> idSupplierAll = [];
  
  int scoreKomunikasi = 0;
  Color colorScoreKomunikasi = Colors.black87;

  int scoreHarga = 0;
  Color colorScoreHarga = Colors.black87;

  String supplierName = '';
  String supplierKode = '';

  var incomingQuality = [];
  var incomingQuantity = [];
  var incomingWaktu = [];
  
  bool saveData = false;
  List<String> tanggal2 = [];

  bool showError = false;

  var materialQuality = [];
  List<dynamic> tanggalQuality = [];
  var materialQuantity = [];
  List<dynamic> tanggalQuantity = [];
  var materialWaktu = [];
  List<dynamic> tanggalWaktu = [];

  String scoreKomunikasiView = 'Beri Penilaian';
  String scoreHargaView = 'Beri Penilaian';

  @override
  void initState() {
    super.initState();

    CollectionReference reference = Firestore.instance.collection('incoming');
    reference.snapshots().listen((data) {
      data.documentChanges.forEach((change) {
        setState(() {
          idSupplierAll.add(change.document.data['id_supplier']);
        });
      });
    });

    CollectionReference reference2 = Firestore.instance.collection('incoming');
    reference2.where('id_supplier', isEqualTo: widget.supplierID).snapshots().listen((data3) {
      data3.documentChanges.forEach((change2) {
        setState(() {
          Timestamp tanggalbantu2 = change2.document.data['date_created'];
          tanggal2.add(tanggalbantu2.toDate().toString().substring(0, 10));

          incomingQuality.add(change2.document.data['status']);
          incomingQuantity.add(change2.document.data['jawaban_supplier_evaluation'][1]);
          incomingWaktu.add(change2.document.data['jawaban_supplier_evaluation'][0]);

          if (change2.document.data['jawaban_supplier_evaluation'][1] == 'NO') {
            Firestore.instance.collection('material').where('id', isEqualTo: change2.document.data['id_material']).snapshots().listen((data6) {
              materialQuantity.add(data6.documents[0].data['material']);
            });

            Timestamp tanggalbantu = change2.document.data['date_created'];
            tanggalQuantity.add(tanggalbantu.toDate());
          }

          if (change2.document.data['jawaban_supplier_evaluation'][0] == 'NO') {
            Timestamp tanggalbantu = change2.document.data['date_created'];
            tanggalWaktu.add(tanggalbantu.toDate());

            Firestore.instance.collection('material').where('id', isEqualTo: change2.document.data['id_material']).snapshots().listen((data7) {
              materialWaktu.add(data7.documents[0].data['material']);
            });
          }
        });
      });
    });

    CollectionReference reference3 = Firestore.instance.collection('incoming');
    reference3.where('id_supplier', isEqualTo: widget.supplierID).where('status', isEqualTo: 'REJECTED').snapshots().listen((data4) {
      data4.documentChanges.forEach((change3) {
        setState(() {
          Timestamp tanggalbantu = change3.document.data['date_created'];
          tanggalQuality.add(tanggalbantu.toDate());

          Firestore.instance.collection('material').where('id', isEqualTo: change3.document.data['id_material']).snapshots().listen((data5) {
            materialQuality.add(data5.documents[0].data['material']);
          });
        });
      });
    });

    Firestore.instance.collection('supplier').where('id', isEqualTo: widget.supplierID).snapshots().listen((data2) {
      setState(() {
        supplierName = data2.documents[0].data['supplier'];
        supplierKode = data2.documents[0].data['kode'];
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
    final _scaffoldKey = new GlobalKey<ScaffoldState>();

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: _appBar(),
        body: AnimatedBuilder(
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
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Peurchasing',
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
                              'Evaluation Material',
                              style:
                                  TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    idSupplierAll.contains(widget.supplierID)
                      ? Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Supplier Performance Evaluation',
                                        style: TextStyle(color: AbubaPallate.greenabuba),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          supplierName,
                                          style: TextStyle(fontSize: 13.0),
                                        ),
                                        SizedBox(
                                          height: 3.0,
                                        ),
                                        Text(
                                          'Code : $supplierKode',
                                          style:
                                              TextStyle(fontSize: 11.0, color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              ExpansionTile(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Quality',
                                        style: TextStyle(color: AbubaPallate.greenabuba, fontSize: 14.0),
                                      ),
                                    ),
                                    Flexible(
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 100.0,
                                        child: Text(
                                          incomingQuality.length == 0
                                            ? '0'
                                            : (incomingQuality.where((c) => c == 'APPROVED').toList().length / incomingQuality.length * 100).round() > 100 
                                                ? '100'
                                                : '${(incomingQuality.where((c) => c == 'APPROVED').toList().length / incomingQuality.length * 100).round().toString()}',
                                          style: TextStyle(fontSize: 14.0, color: Colors.redAccent, fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                children: <Widget>[
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
                                                incomingQuality.length == 0
                                                  ? '0%'
                                                  : (incomingQuality.where((c) => c == 'APPROVED').toList().length / incomingQuality.length * 100).round() > 100 
                                                      ? '100%'
                                                      : '${(incomingQuality.where((c) => c == 'APPROVED').toList().length / incomingQuality.length * 100).round().toString()}%',
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
                                          percent: incomingQuality.length == 0 ? 0 : incomingQuality.where((c) => c == 'APPROVED').toList().length / incomingQuality.length,
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
                                            incomingQuality.length.toString(),
                                            style: TextStyle(
                                                fontSize: 13.0,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            materialQuality.length.toString(),
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
                                            tooltip: "To display first name of the Name",
                                          ),
                                          DataColumn(
                                            label: Text("Material"),
                                            numeric: false,
                                            tooltip: "To display first name of the Name",
                                          ),
                                        ],
                                        rows: List.generate(materialQuality.length, (index) {
                                          return DataRow(
                                            cells: [
                                              DataCell(
                                                Text(tanggalQuality[index].toString().substring(8, 10) + '/' + tanggalQuality[index].toString().substring(5, 7) + '/' + tanggalQuality[index].toString().substring(0, 4)),
                                                showEditIcon: false,
                                                placeholder: false,
                                              ),
                                              DataCell(
                                                Text(materialQuality[index]),
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
                              ExpansionTile(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Quantity',
                                        style: TextStyle(color: AbubaPallate.greenabuba, fontSize: 14.0),
                                      ),
                                    ),
                                    Flexible(
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 100.0,
                                        child: Text(
                                          incomingQuantity.length == 0
                                            ? '0'
                                            : (incomingQuantity.where((c) => c == 'YES').toList().length / incomingQuantity.length * 100).round() > 100
                                                ? '100'
                                                : '${(incomingQuantity.where((c) => c == 'YES').toList().length / incomingQuantity.length * 100).round().toString()}',
                                          style: TextStyle(fontSize: 14.0, color: Colors.redAccent, fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                children: <Widget>[
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
                                                incomingQuantity.length == 0
                                                  ? '0%'
                                                  : (incomingQuantity.where((c) => c == 'YES').toList().length / incomingQuantity.length * 100).round() > 100 
                                                      ? '100%'
                                                      : '${(incomingQuantity.where((c) => c == 'YES').toList().length / incomingQuantity.length * 100).round().toString()}%',
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
                                          percent: incomingQuantity.length == 0 ? 0 : incomingQuantity.where((c) => c == 'YES').toList().length / incomingQuantity.length,
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
                                            incomingQuantity.length.toString(),
                                            style: TextStyle(
                                                fontSize: 13.0,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            materialQuantity.length.toString(),
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
                                            tooltip: "To display first name of the Name",
                                          ),
                                          DataColumn(
                                            label: Text("Material"),
                                            numeric: false,
                                            tooltip: "To display first name of the Name",
                                          ),
                                        ],
                                        rows: List.generate(materialQuantity.length, (index) {
                                          return DataRow(
                                            cells: [
                                              DataCell(
                                                Text(tanggalQuantity[index].toString().substring(8, 10) + '/' + tanggalQuantity[index].toString().substring(5, 7) + '/' + tanggalQuantity[index].toString().substring(0, 4)),
                                                showEditIcon: false,
                                                placeholder: false,
                                              ),
                                              DataCell(
                                                Text(materialQuantity[index]),
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
                              ExpansionTile(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Waktu',
                                        style: TextStyle(fontSize: 14.0, color: AbubaPallate.greenabuba),
                                      ),
                                    ),
                                    Flexible(
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 100.0,
                                        child: Text(
                                          incomingWaktu.length == 0
                                            ? '0'
                                            : (incomingWaktu.where((c) => c == 'YES').toList().length / incomingWaktu.length * 100).round() > 100
                                                ? '100'
                                                : '${(incomingWaktu.where((c) => c == 'YES').toList().length / incomingWaktu.length * 100).round().toString()}',
                                          style: TextStyle(fontSize: 14.0, color: Colors.redAccent, fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                children: <Widget>[
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
                                                incomingWaktu.length == 0
                                                  ? '0%'
                                                  : (incomingWaktu.where((c) => c == 'YES').toList().length / incomingWaktu.length * 100).round() > 100 
                                                      ? '100%'
                                                      : '${(incomingWaktu.where((c) => c == 'YES').toList().length / incomingWaktu.length * 100).round().toString()}%',
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
                                          percent: incomingWaktu.length == 0 ? 0 : incomingWaktu.where((c) => c == 'YES').toList().length / incomingWaktu.length,
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
                                            incomingWaktu.length.toString(),
                                            style: TextStyle(
                                                fontSize: 13.0,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            materialWaktu.length.toString(),
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
                                            tooltip: "To display first name of the Name",
                                          ),
                                          DataColumn(
                                            label: Text("Material"),
                                            numeric: false,
                                            tooltip: "To display first name of the Name",
                                          ),
                                        ],
                                        rows: List.generate(materialWaktu.length, (index) {
                                          return DataRow(
                                            cells: [
                                              DataCell(
                                                Text(tanggalWaktu[index].toString().substring(8, 10) + '/' + tanggalWaktu[index].toString().substring(5, 7) + '/' + tanggalWaktu[index].toString().substring(0, 4)),
                                                showEditIcon: false,
                                                placeholder: false,
                                              ),
                                              DataCell(
                                                Text(materialWaktu[index]),
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
                              ExpansionTile(
                                trailing: Icon(Icons.add, color: Colors.transparent),
                                onExpansionChanged: (value) {
                                  if (saveData) {
                                    print('no action');
                                  } else {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (builder) {
                                        return Container(
                                          color: Color(0xFF737373),
                                          height: MediaQuery.of(context).size.height * 0.5,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topRight: const Radius.circular(20.0),
                                                topLeft: const Radius.circular(20.0),
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                                              child: Column(
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'KOMUNIKASI',
                                                          style: TextStyle(
                                                              color: AbubaPallate.greenabuba,
                                                              fontWeight: FontWeight.w700),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 6.0,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          supplierName,
                                                          style: TextStyle(color: Colors.black54),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        child: Text(
                                                          supplierKode,
                                                          style: TextStyle(color: Colors.black54),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 15.0,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      Column(
                                                        children: <Widget>[
                                                          Container(
                                                            alignment: Alignment.center,
                                                            width: MediaQuery.of(context).size.width * 0.5,
                                                            child: ButtonTheme(
                                                              padding: EdgeInsets.all(0.0),
                                                              height: 30.0,
                                                              minWidth: MediaQuery.of(context).size.width * 0.5,
                                                              child: OutlineButton(
                                                                child: Text(
                                                                  '60',
                                                                  style: TextStyle(
                                                                      fontSize: 15.0, color: Colors.grey),
                                                                ),
                                                                borderSide:
                                                                    BorderSide(color: Colors.grey, width: 1.0),
                                                                highlightedBorderColor: Colors.grey,
                                                                onPressed: () {
                                                                  setState(() {
                                                                    scoreKomunikasi = 60;
                                                                    scoreKomunikasiView = '60';

                                                                    colorScoreKomunikasi = Colors.redAccent;
                                                                    Navigator.pop(context);
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            alignment: Alignment.center,
                                                            width: MediaQuery.of(context).size.width * 0.3,
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: <Widget>[
                                                                Flexible(
                                                                  child: Text(
                                                                    'TIDAK',
                                                                    style: TextStyle(
                                                                        color: Colors.red,
                                                                        fontSize: 10.0,
                                                                        fontWeight: FontWeight.w700),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 3.0,
                                                                ),
                                                                Flexible(
                                                                  child: Text(
                                                                    'Kompetitif',
                                                                    style: TextStyle(
                                                                        color: Colors.black54, fontSize: 10.0),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 20.0,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      Column(
                                                        children: <Widget>[
                                                          Container(
                                                            alignment: Alignment.center,
                                                            width: MediaQuery.of(context).size.width * 0.5,
                                                            child: ButtonTheme(
                                                              padding: EdgeInsets.all(0.0),
                                                              height: 30.0,
                                                              minWidth: MediaQuery.of(context).size.width * 0.5,
                                                              child: OutlineButton(
                                                                child: Text(
                                                                  '70',
                                                                  style: TextStyle(
                                                                      fontSize: 15.0, color: Colors.grey),
                                                                ),
                                                                borderSide:
                                                                    BorderSide(color: Colors.grey, width: 1.0),
                                                                highlightedBorderColor: Colors.grey,
                                                                onPressed: () {
                                                                  setState(() {
                                                                    scoreKomunikasi = 70;
                                                                    scoreKomunikasiView = '70';

                                                                    colorScoreKomunikasi = Colors.black87;
                                                                    Navigator.pop(context);
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            alignment: Alignment.center,
                                                            width: MediaQuery.of(context).size.width * 0.3,
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: <Widget>[
                                                                Flexible(
                                                                  child: Text(
                                                                    'CUKUP',
                                                                    style: TextStyle(
                                                                        color: Colors.black87,
                                                                        fontSize: 10.0,
                                                                        fontWeight: FontWeight.w700),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 3.0,
                                                                ),
                                                                Flexible(
                                                                  child: Text(
                                                                    'Kompetitif',
                                                                    style: TextStyle(
                                                                        color: Colors.black54, fontSize: 10.0),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 20.0,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      Column(
                                                        children: <Widget>[
                                                          Container(
                                                            alignment: Alignment.center,
                                                            width: MediaQuery.of(context).size.width * 0.5,
                                                            child: ButtonTheme(
                                                              padding: EdgeInsets.all(0.0),
                                                              height: 30.0,
                                                              minWidth: MediaQuery.of(context).size.width * 0.5,
                                                              child: OutlineButton(
                                                                child: Text(
                                                                  '90',
                                                                  style: TextStyle(
                                                                      fontSize: 15.0, color: Colors.grey),
                                                                ),
                                                                borderSide:
                                                                    BorderSide(color: Colors.grey, width: 1.0),
                                                                highlightedBorderColor: Colors.grey,
                                                                onPressed: () {
                                                                  setState(() {
                                                                    scoreKomunikasi = 90;
                                                                    scoreKomunikasiView = '90';

                                                                    colorScoreKomunikasi = AbubaPallate.greenabuba;
                                                                    Navigator.pop(context);
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            alignment: Alignment.center,
                                                            width: MediaQuery.of(context).size.width * 0.3,
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: <Widget>[
                                                                Flexible(
                                                                  child: Text(
                                                                    'SANGAT',
                                                                    style: TextStyle(
                                                                        color: AbubaPallate.greenabuba,
                                                                        fontSize: 10.0,
                                                                        fontWeight: FontWeight.w700),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 3.0,
                                                                ),
                                                                Flexible(
                                                                  child: Text(
                                                                    'Kompetitif',
                                                                    style: TextStyle(
                                                                        color: Colors.black54, fontSize: 10.0),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ),
                                        );
                                      },
                                    );
                                  }
                                },
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Komunikasi',
                                        style: TextStyle(fontSize: 14.0, color: AbubaPallate.greenabuba),
                                      ),
                                    ),
                                    Flexible(
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 100.0,
                                        child: Text(
                                          // scoreKomunikasi.toString(),
                                          scoreKomunikasiView,
                                          style: TextStyle(fontSize: 14.0, color: colorScoreKomunikasi, fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              ExpansionTile(
                                trailing: Icon(Icons.add, color: Colors.transparent),
                                onExpansionChanged: (value) {
                                  if (saveData) {
                                    print('no action');
                                  } else {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (builder) {
                                        return Container(
                                          color: Color(0xFF737373),
                                          height: MediaQuery.of(context).size.height * 0.5,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topRight: const Radius.circular(20.0),
                                                topLeft: const Radius.circular(20.0),
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                                              child: Column(
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'HARGA',
                                                          style: TextStyle(
                                                              color: AbubaPallate.greenabuba,
                                                              fontWeight: FontWeight.w700),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 6.0,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          supplierName,
                                                          style: TextStyle(color: Colors.black54),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        child: Text(
                                                          supplierKode,
                                                          style: TextStyle(color: Colors.black54),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 15.0,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      Column(
                                                        children: <Widget>[
                                                          Container(
                                                            alignment: Alignment.center,
                                                            width: MediaQuery.of(context).size.width * 0.5,
                                                            child: ButtonTheme(
                                                              padding: EdgeInsets.all(0.0),
                                                              height: 30.0,
                                                              minWidth: MediaQuery.of(context).size.width * 0.5,
                                                              child: OutlineButton(
                                                                child: Text(
                                                                  '60',
                                                                  style: TextStyle(
                                                                      fontSize: 15.0, color: Colors.grey),
                                                                ),
                                                                borderSide:
                                                                    BorderSide(color: Colors.grey, width: 1.0),
                                                                highlightedBorderColor: Colors.grey,
                                                                onPressed: () {
                                                                  setState(() {
                                                                    scoreHarga = 60;
                                                                    scoreHargaView = '60';

                                                                    colorScoreHarga = Colors.redAccent;
                                                                    Navigator.pop(context);
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            alignment: Alignment.center,
                                                            width: MediaQuery.of(context).size.width * 0.3,
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: <Widget>[
                                                                Flexible(
                                                                  child: Text(
                                                                    'TIDAK',
                                                                    style: TextStyle(
                                                                        color: Colors.red,
                                                                        fontSize: 10.0,
                                                                        fontWeight: FontWeight.w700),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 3.0,
                                                                ),
                                                                Flexible(
                                                                  child: Text(
                                                                    'Kompetitif',
                                                                    style: TextStyle(
                                                                        color: Colors.black54, fontSize: 10.0),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 20.0,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      Column(
                                                        children: <Widget>[
                                                          Container(
                                                            alignment: Alignment.center,
                                                            width: MediaQuery.of(context).size.width * 0.5,
                                                            child: ButtonTheme(
                                                              padding: EdgeInsets.all(0.0),
                                                              height: 30.0,
                                                              minWidth: MediaQuery.of(context).size.width * 0.5,
                                                              child: OutlineButton(
                                                                child: Text(
                                                                  '70',
                                                                  style: TextStyle(
                                                                      fontSize: 15.0, color: Colors.grey),
                                                                ),
                                                                borderSide:
                                                                    BorderSide(color: Colors.grey, width: 1.0),
                                                                highlightedBorderColor: Colors.grey,
                                                                onPressed: () {
                                                                  setState(() {
                                                                    scoreHarga = 70;
                                                                    scoreHargaView = '70';

                                                                    colorScoreHarga = Colors.black87;
                                                                    Navigator.pop(context);
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            alignment: Alignment.center,
                                                            width: MediaQuery.of(context).size.width * 0.3,
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: <Widget>[
                                                                Flexible(
                                                                  child: Text(
                                                                    'CUKUP',
                                                                    style: TextStyle(
                                                                        color: Colors.black87,
                                                                        fontSize: 10.0,
                                                                        fontWeight: FontWeight.w700),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 3.0,
                                                                ),
                                                                Flexible(
                                                                  child: Text(
                                                                    'Kompetitif',
                                                                    style: TextStyle(
                                                                        color: Colors.black54, fontSize: 10.0),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 20.0,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      Column(
                                                        children: <Widget>[
                                                          Container(
                                                            alignment: Alignment.center,
                                                            width: MediaQuery.of(context).size.width * 0.5,
                                                            child: ButtonTheme(
                                                              padding: EdgeInsets.all(0.0),
                                                              height: 30.0,
                                                              minWidth: MediaQuery.of(context).size.width * 0.5,
                                                              child: OutlineButton(
                                                                child: Text(
                                                                  '90',
                                                                  style: TextStyle(
                                                                      fontSize: 15.0, color: Colors.grey),
                                                                ),
                                                                borderSide:
                                                                    BorderSide(color: Colors.grey, width: 1.0),
                                                                highlightedBorderColor: Colors.grey,
                                                                onPressed: () {
                                                                  setState(() {
                                                                    scoreHarga = 90;
                                                                    scoreHargaView = '90';

                                                                    colorScoreHarga = AbubaPallate.greenabuba;
                                                                    Navigator.pop(context);
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            alignment: Alignment.center,
                                                            width: MediaQuery.of(context).size.width * 0.3,
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: <Widget>[
                                                                Flexible(
                                                                  child: Text(
                                                                    'SANGAT',
                                                                    style: TextStyle(
                                                                        color: AbubaPallate.greenabuba,
                                                                        fontSize: 10.0,
                                                                        fontWeight: FontWeight.w700),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 3.0,
                                                                ),
                                                                Flexible(
                                                                  child: Text(
                                                                    'Kompetitif',
                                                                    style: TextStyle(
                                                                        color: Colors.black54, fontSize: 10.0),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ),
                                        );
                                      },
                                    );
                                  }
                                },
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Harga',
                                        style: TextStyle(fontSize: 14.0, color: AbubaPallate.greenabuba),
                                      ),
                                    ),
                                    Flexible(
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 100.0,
                                        child: Text(
                                          scoreHargaView,
                                          style: TextStyle(fontSize: 14.0, color: colorScoreHarga, fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              showError
                                ? Container(
                                    padding: EdgeInsets.only(left: 10.0),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Lengkapi Data',
                                      style: TextStyle(
                                        fontSize: 11.0,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.redAccent
                                      ),
                                    ),
                                  )
                                : Container(),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                padding: EdgeInsets.all(10.0),
                                child: ButtonTheme(
                                  minWidth: 50.0,
                                  height: 40.0,
                                  child: RaisedButton(
                                    elevation: 0.0,
                                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
                                    child: saveData
                                      ? Container(
                                          padding: EdgeInsets.symmetric(vertical: 5.0),
                                          child: Center(
                                            child: SizedBox(
                                              height: 20.0,
                                              width: 20.0,
                                              child: CircularProgressIndicator(
                                                valueColor: AlwaysStoppedAnimation(Colors.white),
                                                strokeWidth: 2.0,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Text(
                                          'SAVE',
                                          style:
                                          TextStyle(fontSize: 13.0, color: Colors.white),
                                        ),
                                    color: AbubaPallate.greenabuba,
                                    onPressed: () {
                                      setState(() {
                                        if (scoreHarga == 0 || scoreKomunikasi == 0) {
                                          showError = true;
                                        } else {
                                          showError = false;
                                          saveData = true;

                                          DocumentReference docReference = Firestore.instance.collection('purchasingEvaluation_mtrl').document();
                                          
                                          docReference.setData({
                                            'userCreated': widget.idUser,
                                            'dateCreated': DateTime.now(),
                                            'idSupplier': widget.supplierID,
                                            'scoreQuality': (incomingQuality.where((c) => c == 'APPROVED').toList().length / incomingQuality.length * 100).round(),
                                            'scoreQuantity': (incomingQuantity.where((c) => c == 'YES').toList().length / incomingQuantity.length * 100).round(),
                                            'scoreWaktu': (incomingWaktu.where((c) => c == 'YES').toList().length / incomingWaktu.length * 100).round(),
                                            'scoreKomunikasi': scoreKomunikasi,
                                            'scoreHarga': scoreHarga,
                                            'totalDelivery': incomingQuality.length,
                                            'totalPerformance': (((incomingQuality.where((c) => c == 'APPROVED').toList().length / incomingQuality.length * 100).round() + (incomingQuantity.where((c) => c == 'YES').toList().length / incomingQuantity.length * 100).round() + (incomingWaktu.where((c) => c == 'YES').toList().length / incomingWaktu.length * 100).round() + scoreKomunikasi + scoreHarga) / 5).round(),
                                            'detailQualityTgl': tanggalQuality,
                                            'detailQualityMaterial': materialQuality,
                                            'detailQuantityTgl': tanggalQuantity,
                                            'detailQuantityMaterial': materialQuantity,
                                            'detailWaktuTgl': tanggalWaktu,
                                            'detailWaktuMaterial': materialWaktu,
                                            'dateStart': tanggal2.first.toString(),
                                            'dateEnd': tanggal2.last.toString()
                                          }).then((doc) {
                                            setState(() {
                                              saveData = false;
                                            });

                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) => Dialog(
                                                child: Container(
                                                  height: 180.0,
                                                  child: Column(
                                                    children: <Widget>[
                                                      Container(
                                                        color: AbubaPallate.greenabuba,
                                                        height: 50.0,
                                                        child: Center(
                                                          child: Text(
                                                            'SUCCESSFUL!',
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 17.0,
                                                              fontWeight: FontWeight.w700),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 20.0,
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                                        child: Text(
                                                          'Data Saved',
                                                          style: TextStyle(
                                                            fontSize: 16.0,
                                                          ),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: <Widget>[
                                                          FlatButton(
                                                            child: Text('OK'),
                                                            onPressed: () {
                                                              Navigator.pop(context);
                                                            },
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ).whenComplete(() {
                                              Navigator.pop(context);
                                            });
                                          }).catchError((error) {
                                            print(error);
                                          });
                                        }
                                      });
                                    },
                                  )
                                ),
                              )
                            ],
                          )
                        )
                      : Container(
                          padding: EdgeInsets.only(top: 15.0),
                          child: Center(
                            child: Text(
                              'NO DATA',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        )
                  ],
                );
          },
        )
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      elevation: 0.25,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.asset(
            'assets/images/logo2.png',
            height: 150.0,
            width: 120.0,
          ),
          new Container(
            child: new Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        color: Colors.red[500],
                        size: 20.0,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        '41 pts',
                        style: TextStyle(fontSize: 12.0, color: Colors.grey),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
