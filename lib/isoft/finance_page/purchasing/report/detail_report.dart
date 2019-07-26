import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class DetailReport extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  var index;
  final int idSupplier;

  DetailReport({this.idUser, this.namaUser, this.departmentUser, this.index, this.idSupplier});

  @override
  _DetailReportState createState() => _DetailReportState();
}

class _DetailReportState extends State<DetailReport> with TickerProviderStateMixin {
  AnimationController animationController;

  String supplierName;
  String supplierKode;
  Timestamp tglTerdaftar;
  String alamat;
  String kontak;
  String telp;
  String email;
  List<String> material = [];

  int finalScore;
  int scoreQuality;
  int scoreQuantity;
  int scoreWaktu;
  int scoreKomunikasi;
  int scoreHarga;

  String tglStart;
  String tglEnd;
  int totalDelivery;

  var detailQuality = [];
  List<dynamic> tglQuality = [];
  var detailQuantity = [];
  List<dynamic> tglQuantity = [];
  var detailWaktu = [];
  List<dynamic> tglWaktu = [];

  @override
  void initState() {
    super.initState();

    Firestore.instance.collection('supplier').where('id', isEqualTo: widget.idSupplier).snapshots().listen((data) {
      setState(() {
        supplierName = data.documents[0].data['supplier'];
        supplierKode = data.documents[0].data['kode'];
        tglTerdaftar = data.documents[0].data['tglTerdaftar'];
        alamat = data.documents[0].data['alamat'];
        kontak = data.documents[0].data['namaKontak'];
        telp = data.documents[0].data['telp'];
        email = data.documents[0].data['email'];

        CollectionReference reference = Firestore.instance.collection('material');
        reference.where('id_supplier', isEqualTo: widget.idSupplier).snapshots().listen((data2) {
          data2.documentChanges.forEach((change) {
            setState(() {
              material.add(change.document.data['material']);
            });
          });
        });
      });
    });

    Firestore.instance.collection('purchasingEvaluation_mtrl').document(widget.index).snapshots().listen((data3) {
      setState(() {
        finalScore = data3.data['totalPerformance'];
        scoreQuality = data3.data['scoreQuality'];
        scoreQuantity = data3.data['scoreQuantity'];
        scoreWaktu = data3.data['scoreWaktu'];
        scoreKomunikasi = data3.data['scoreKomunikasi'];
        scoreHarga = data3.data['scoreHarga'];

        detailQuality = data3.data['detailQualityMaterial'];
        tglQuality = data3.data['detailQualityTgl'];
        detailQuantity = data3.data['detailQuantityMaterial'];
        tglQuantity = data3.data['detailQuantityTgl'];
        detailWaktu = data3.data['detailWaktuMaterial'];
        tglWaktu = data3.data['detailWaktuTgl'];

        totalDelivery = data3.data['totalDelivery'];
        tglStart = data3.data['dateStart'].toString().substring(8, 10) + '/' + data3.data['dateStart'].toString().substring(5, 7) + '/' +data3.data['dateStart'].toString().substring(0, 4);
        tglEnd = data3.data['dateEnd'].toString().substring(8, 10) + '/' + data3.data['dateEnd'].toString().substring(5, 7) + '/' +data3.data['dateEnd'].toString().substring(0, 4);
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
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Report',
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
                  'Detail',
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
                    child: CircularProgressIndicator(),
                  ),
                )
              : Container(
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
                                  style: TextStyle(fontSize: 14.0),
                                ),
                                SizedBox(
                                  height: 3.0,
                                ),
                                Text(
                                  'Code : $supplierKode',
                                  style:
                                      TextStyle(fontSize: 12.0, color: Colors.black54),
                                ),
                              ],
                            ),
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: <Widget>[
                            //     ButtonTheme(
                            //       minWidth: 50.0,
                            //       height: 20.0,
                            //       child: RaisedButton(
                            //         color: AbubaPallate.greenabuba,
                            //         child: Text(
                            //           'Send Email',
                            //           style: TextStyle(
                            //               fontSize: 12.0, color: Colors.white),
                            //         ),
                            //         onPressed: () {},
                            //       ),
                            //     ),
                            //     Text(''),
                            //   ],
                            // )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Informasi Umum',
                                style: TextStyle(color: AbubaPallate.greenabuba),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Tanggal Terdaftar',
                                    style: TextStyle(
                                        color: Colors.black38, fontSize: 12.0),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 3.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    tglTerdaftar.toDate().toString().substring(8, 10) + '/' + tglTerdaftar.toDate().toString().substring(5, 7) + '/' +tglTerdaftar.toDate().toString().substring(0, 4),
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 14.0),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 8.0,),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Alamat',
                                    style: TextStyle(
                                        color: Colors.black38, fontSize: 12.0),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 3.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    alamat,
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 14.0),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 8.0),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Nama Kontak',
                                    style: TextStyle(
                                        color: Colors.black38, fontSize: 12.0),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 3.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    kontak,
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 14.0),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 8.0,),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Telepon',
                                    style: TextStyle(
                                        color: Colors.black38, fontSize: 12.0),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 3.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    telp,
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 14.0),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 8.0,),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Email',
                                    style: TextStyle(
                                        color: Colors.black38, fontSize: 12.0),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 3.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    email,
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 14.0),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 8.0,),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Material',
                                    style: TextStyle(
                                        color: Colors.black38, fontSize: 12.0),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 3.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    material.join(', ').toString(),
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 14.0),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(height: 6.0,),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Total Performance',
                                style: TextStyle(color: AbubaPallate.greenabuba),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                '$tglStart - $tglEnd',
                                style: TextStyle(color: Colors.black54, fontSize: 12.0),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    '${finalScore.toString()}%',
                                    style: TextStyle(
                                        color: Colors.black87, fontSize: 14.0),
                                  ),
                                ),
                                RichText(
                                  softWrap: true,
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Total delivery : ',
                                        style: TextStyle(fontSize: 12.0, color: Colors.black38),
                                      ),
                                      TextSpan(
                                        text: totalDelivery.toString(),
                                        style: TextStyle(fontSize: 13.0, color: Colors.black54, fontWeight: FontWeight.w600),
                                      )
                                    ]
                                  ),
                                )
                              ],
                            ),
                            LinearPercentIndicator(
                              alignment: MainAxisAlignment.center,
                              width: 330.0,
                              animation: true,
                              lineHeight: 30.0,
                              percent: finalScore > 100 ? 1.0 : finalScore / 100,
                              animationDuration: 1000,
                              linearStrokeCap: LinearStrokeCap.butt,
                              progressColor: Colors.green[300],
                            ),
                          ],
                        ),
                      ),
                      ExpansionTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Quality Performance',
                                style: TextStyle(color: AbubaPallate.greenabuba, fontSize: 14.0),
                              ),
                            ),
                          ],
                        ),
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        '${scoreQuality.toString()}%',
                                        style: TextStyle(
                                            color: Colors.black87, fontSize: 14.0),
                                      ),
                                    ),
                                    RichText(
                                      softWrap: true,
                                      text: TextSpan(
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: '# Rejected : ',
                                            style: TextStyle(fontSize: 10.0, color: Colors.black38),
                                          ),
                                          TextSpan(
                                            text: detailQuality.length.toString(),
                                            style: TextStyle(fontSize: 11.0, color: Colors.black54, fontWeight: FontWeight.w600),
                                          )
                                        ]
                                      ),
                                    )
                                  ],
                                ),
                                LinearPercentIndicator(
                                  alignment: MainAxisAlignment.center,
                                  width: 330.0,
                                  animation: true,
                                  lineHeight: 30.0,
                                  percent: scoreQuality > 100 ? 1.0 : scoreQuality / 100,
                                  animationDuration: 1000,
                                  linearStrokeCap: LinearStrokeCap.butt,
                                  progressColor: Colors.green[300],
                                ),
                              ],
                            ),
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
                                rows: List.generate(detailQuality.length, (index) {
                                  Timestamp tglBantu = tglQuality[index];
                                  return DataRow(
                                    cells: [
                                      DataCell(
                                        Text(tglBantu.toDate().toString().substring(8, 10) + '/' + tglBantu.toDate().toString().substring(5, 7) + '/' + tglBantu.toDate().toString().substring(0, 4)),
                                        showEditIcon: false,
                                        placeholder: false,
                                      ),
                                      DataCell(
                                        Text(detailQuality[index]),
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Quantity Performance',
                                style: TextStyle(color: AbubaPallate.greenabuba, fontSize: 14.0),
                              ),
                            ),
                          ],
                        ),
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        '${scoreQuantity.toString()}%',
                                        style: TextStyle(
                                            color: Colors.black87, fontSize: 14.0),
                                      ),
                                    ),
                                    RichText(
                                      softWrap: true,
                                      text: TextSpan(
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: '# Rejected : ',
                                            style: TextStyle(fontSize: 10.0, color: Colors.black38),
                                          ),
                                          TextSpan(
                                            text: detailQuantity.length.toString(),
                                            style: TextStyle(fontSize: 11.0, color: Colors.black54, fontWeight: FontWeight.w600),
                                          )
                                        ]
                                      ),
                                    )
                                  ],
                                ),
                                LinearPercentIndicator(
                                  alignment: MainAxisAlignment.center,
                                  width: 330.0,
                                  animation: true,
                                  lineHeight: 30.0,
                                  percent: scoreQuantity > 100 ? 1.0 : scoreQuantity / 100,
                                  animationDuration: 1000,
                                  linearStrokeCap: LinearStrokeCap.butt,
                                  progressColor: Colors.green[300],
                                ),
                              ],
                            ),
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
                                rows: List.generate(detailQuantity.length, (index) {
                                  Timestamp tglBantu = tglQuantity[index];
                                  return DataRow(
                                    cells: [
                                      DataCell(
                                        Text(tglBantu.toDate().toString().substring(8, 10) + '/' + tglBantu.toDate().toString().substring(5, 7) + '/' + tglBantu.toDate().toString().substring(0, 4)),
                                        showEditIcon: false,
                                        placeholder: false,
                                      ),
                                      DataCell(
                                        Text(detailQuantity[index]),
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Time Performance',
                                style: TextStyle(color: AbubaPallate.greenabuba, fontSize: 14.0),
                              ),
                            ),
                          ],
                        ),
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        '${scoreWaktu.toString()}%',
                                        style: TextStyle(
                                            color: Colors.black87, fontSize: 14.0),
                                      ),
                                    ),
                                    RichText(
                                      softWrap: true,
                                      text: TextSpan(
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: '# Rejected : ',
                                            style: TextStyle(fontSize: 10.0, color: Colors.black38),
                                          ),
                                          TextSpan(
                                            text: detailWaktu.length.toString(),
                                            style: TextStyle(fontSize: 11.0, color: Colors.black54, fontWeight: FontWeight.w600),
                                          )
                                        ]
                                      ),
                                    )
                                  ],
                                ),
                                LinearPercentIndicator(
                                  alignment: MainAxisAlignment.center,
                                  width: 330.0,
                                  animation: true,
                                  lineHeight: 30.0,
                                  percent: scoreWaktu > 100 ? 1.0 : scoreWaktu / 100,
                                  animationDuration: 1000,
                                  linearStrokeCap: LinearStrokeCap.butt,
                                  progressColor: Colors.green[300],
                                ),
                              ],
                            ),
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
                                rows: List.generate(detailWaktu.length, (index) {
                                  Timestamp tglBantu = tglWaktu[index];
                                  return DataRow(
                                    cells: [
                                      DataCell(
                                        Text(tglBantu.toDate().toString().substring(8, 10) + '/' + tglBantu.toDate().toString().substring(5, 7) + '/' + tglBantu.toDate().toString().substring(0, 4)),
                                        showEditIcon: false,
                                        placeholder: false,
                                      ),
                                      DataCell(
                                        Text(detailWaktu[index]),
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Komunikasi Performance',
                                style: TextStyle(color: AbubaPallate.greenabuba, fontSize: 14.0),
                              ),
                            ),
                          ],
                        ),
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        '${scoreKomunikasi.toString()}%',
                                        style: TextStyle(
                                            color: Colors.black87, fontSize: 14.0),
                                      ),
                                    ),
                                  ],
                                ),
                                LinearPercentIndicator(
                                  alignment: MainAxisAlignment.center,
                                  width: 330.0,
                                  animation: true,
                                  lineHeight: 30.0,
                                  percent: scoreKomunikasi > 100 ? 1.0 : scoreKomunikasi / 100,
                                  animationDuration: 1000,
                                  linearStrokeCap: LinearStrokeCap.butt,
                                  progressColor: Colors.green[300],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Harga Performance',
                                style: TextStyle(color: AbubaPallate.greenabuba, fontSize: 14.0),
                              ),
                            ),
                          ],
                        ),
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        '${scoreHarga.toString()}%',
                                        style: TextStyle(
                                            color: Colors.black87, fontSize: 14.0),
                                      ),
                                    ),
                                  ],
                                ),
                                LinearPercentIndicator(
                                  alignment: MainAxisAlignment.center,
                                  width: 330.0,
                                  animation: true,
                                  lineHeight: 30.0,
                                  percent: scoreHarga > 100 ? 1.0 : scoreHarga / 100,
                                  animationDuration: 1000,
                                  linearStrokeCap: LinearStrokeCap.butt,
                                  progressColor: Colors.green[300],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
          },
        )
      ],
    );
  }
}
