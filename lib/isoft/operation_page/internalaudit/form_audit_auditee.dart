import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/isoft/operation_page/internalaudit/form_jadwal_start.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class FormAuditAuditee extends StatefulWidget {
  var index;
  final int idUser;
  final String namaUser;
  final String departmentUser;
  List<dynamic> auditor;
  final String statusLogin;
  FormAuditAuditee({this.idUser, this.namaUser, this.departmentUser, this.index, this.auditor, this.statusLogin});

  @override
  _FormAuditAuditeeState createState() => _FormAuditAuditeeState();
}

class _FormAuditAuditeeState extends State<FormAuditAuditee> with TickerProviderStateMixin {
  AnimationController animationController;

  List<String> namaAuditor = [];
  String status;
  String department;
  String object;
  Timestamp tanggal;

  List<bool> noteAreaLuarShow = [];
  List<bool> imageAreaLuarShow = [];
  List<bool> noteDinningAreaShow = [];
  List<bool> imageDinningAreaShow = [];
  List<bool> noteServiceShow = [];
  List<bool> imageServiceShow = [];
  List<bool> noteCashierShow = [];
  List<bool> imageCashierShow = [];
  List<bool> noteCashierAccuracyShow = [];
  List<bool> imageCashierAccuracyShow = [];
  List<bool> noteBohShow = [];
  List<bool> imageBohShow = [];
  List<bool> noteWarehouseShow = [];
  List<bool> imageWarehouseShow = [];
  List<bool> noteSocialBlockShow = [];
  List<bool> imageSocialBlockShow = [];
  List<bool> notePersonalShow = [];
  List<bool> imagePersonalShow = [];
  List<bool> noteFoodCookedShow = [];
  List<bool> imageFoodCookedShow = [];

  Color colorAreaLuar = Colors.black;
  Color colorDinningArea = Colors.black;
  Color colorService = Colors.black;
  Color colorCashier = Colors.black;
  Color colorCashierAccuracy = Colors.black;
  Color colorBoh = Colors.black;
  Color colorWarehouse = Colors.black;
  Color colorSocialBlock = Colors.black;
  Color colorPersonal = Colors.black;
  Color colorFoodCooked = Colors.black;

  bool isProcess = false;

  @override
  void initState() {
    super.initState();

    Firestore.instance.collection('audit_internal').document(widget.index).snapshots().listen((data) {
      setState(() {
        for (int a = 0; a < data.data['pertanyaanAreaLuar'].length; a++) {
          noteAreaLuarShow.add(false);
          imageAreaLuarShow.add(false);
        }

        for (int a = 0; a < data.data['pertanyaanBoh'].length; a++) {
          noteBohShow.add(false);
          imageBohShow.add(false);
        }

        for (int a = 0; a < data.data['pertanyaanCashier'].length; a++) {
          noteCashierShow.add(false);
          imageCashierShow.add(false);
        }

        for (int a = 0; a < data.data['pertanyaanCashierAccuracy'].length; a++) {
          noteCashierAccuracyShow.add(false);
          imageCashierAccuracyShow.add(false);
        }

        for (int a = 0; a < data.data['pertanyaanDinningArea'].length; a++) {
          noteDinningAreaShow.add(false);
          imageDinningAreaShow.add(false);
        }

        for (int a = 0; a < data.data['pertanyaanFoodCooked'].length; a++) {
          noteFoodCookedShow.add(false);
          imageFoodCookedShow.add(false);
        }

        for (int a = 0; a < data.data['pertanyaanPersonal'].length; a++) {
          notePersonalShow.add(false);
          imagePersonalShow.add(false);
        }

        for (int a = 0; a < data.data['pertanyaanService'].length; a++) {
          noteServiceShow.add(false);
          imageServiceShow.add(false);
        }

        for (int a = 0; a < data.data['pertanyaanSocialBlock'].length; a++) {
          noteSocialBlockShow.add(false);
          imageSocialBlockShow.add(false);
        }

        for (int a = 0; a < data.data['pertanyaanWarehouse'].length; a++) {
          noteWarehouseShow.add(false);
          imageWarehouseShow.add(false);
        }

        if (data.data['auditee'] == widget.idUser) {
          status = 'AUDITEE';
        } else if (data.data['leadAuditor'] == widget.idUser) {
          status = 'LEAD AUDITOR';
        } else if (data.data['subAreaAuditor'].contains(widget.idUser.toString())) {
          status = 'AUDITOR';
        } else {
          status = '-';
        }

        tanggal = data.data['dateAudit'];

        Firestore.instance.collection('department').where('id', isEqualTo: data.data['department']).snapshots().listen((data3) {
          department = data3.documents[0].data['name'];
        });

        Firestore.instance.collection('audit_object').where('id', isEqualTo: data.data['object']).snapshots().listen((data4) {
          object = data4.documents[0].data['object'];
        });
      });
    });

    for (int i = 0; i < widget.auditor.length; i++) {
      Firestore.instance.collection('user').where('id', isEqualTo: int.tryParse(widget.auditor[i].toString())).snapshots().listen((data2) {
        setState(() {
          namaAuditor.add(data2.documents[0].data['nama']);
        });
      });
    }

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
          actions: <Widget>[
            AnimatedBuilder(
              animation: animationController,
              builder: (_, Widget child) {
                return animationController.isAnimating
                  ? Container()
                  : Row(
                      children: <Widget>[
                        Container(
                          child: IconButton(
                            icon: Icon(Icons.refresh, color: Colors.black54),
                            tooltip: 'Resfresh',
                            onPressed: () {
                              Navigator.pushReplacement(context,
                                MaterialPageRoute(
                                  builder: (_) => FormAuditAuditee(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser, statusLogin: widget.statusLogin, index: widget.index, auditor: widget.auditor)
                                )
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: ButtonTheme(
                            minWidth: 50.0,
                            height: 40.0,
                            child: RaisedButton(
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                              child: Text(
                                'CHECK OUT',
                                style:
                                TextStyle(fontSize: 13.0, color: Colors.white),
                              ),
                              color: Colors.redAccent,
                              onPressed: () {
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return CheckOutDialog(
                                      index: widget.index,
                                      statusLogin: widget.statusLogin,
                                      idUser: widget.idUser,
                                      departmentUser: widget.departmentUser,
                                      namaUser: widget.namaUser,
                                    );
                                  }
                                );
                              },
                            )
                          ),
                        )
                      ],
                    );
              },
            )
          ],
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scrollbar(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Internal Audit',
                          style: TextStyle(color: Colors.black12, fontSize: 12.0),
                        ),
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
                          'Audit',
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
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Column(
                          children: <Widget>[
                            Container(
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(5.0, 8.0, 20.0, 5.0),
                                    child: ListTile(
                                      onTap: null,
                                      title: Text(
                                        '$department - $object',
                                        style: TextStyle(
                                            color: Colors.black54, fontSize: 14.0, fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.only(top: 5.0),
                                        child: Text(
                                          tanggal.toDate().toString().substring(8, 10) + '/' + tanggal.toDate().toString().substring(5, 7) + '/' +tanggal.toDate().toString().substring(0, 4),
                                          // 'tanggal',
                                          style: TextStyle(
                                              color: Colors.grey[500], fontSize: 13.0),
                                        ),
                                      ),
                                      trailing: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: AbubaPallate.menuBluebird)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Text(
                                            status,
                                            style: TextStyle(fontSize: 12.0, color: AbubaPallate.menuBluebird, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      )
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Container(
                              color: Colors.white,
                              child: StreamBuilder(
                                stream: Firestore.instance.collection('audit_internal').snapshots(),
                                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData)
                                    return Container(
                                      child: Center(
                                        child: CircularProgressIndicator()
                                      )
                                    );
                                  
                                  return Column(
                                    children: List.generate(snapshot.data.documents.length, (indexDoc) {
                                      if (snapshot.data.documents[indexDoc].documentID == widget.index) {

                                        if (snapshot.data.documents[indexDoc].data.containsKey('hasilAreaLuar')) {
                                          if ((snapshot.data.documents[indexDoc].data['hasilAreaLuar'] * 100).round() > 85.0) {
                                            colorAreaLuar = Colors.green;
                                          } else if ((snapshot.data.documents[indexDoc].data['hasilAreaLuar'] * 100).round() < 70.0) {
                                            colorAreaLuar = Colors.redAccent;
                                          } else {
                                            colorAreaLuar = Colors.orangeAccent;
                                          }
                                        }
                                        if (snapshot.data.documents[indexDoc].data.containsKey('hasilDinningArea')) {
                                          if ((snapshot.data.documents[indexDoc].data['hasilDinningArea'] * 100).round() > 85.0) {
                                            colorDinningArea = Colors.green;
                                          } else if ((snapshot.data.documents[indexDoc].data['hasilDinningArea'] * 100).round() < 70.0) {
                                            colorDinningArea = Colors.redAccent;
                                          } else {
                                            colorDinningArea = Colors.orangeAccent;
                                          }
                                        }
                                        if (snapshot.data.documents[indexDoc].data.containsKey('hasilService')) {
                                          if ((snapshot.data.documents[indexDoc].data['hasilService'] * 100).round() > 85.0) {
                                            colorService = Colors.green;
                                          } else if ((snapshot.data.documents[indexDoc].data['hasilService'] * 100).round() < 70.0) {
                                            colorService = Colors.redAccent;
                                          } else {
                                            colorService = Colors.orangeAccent;
                                          }
                                        }
                                        if (snapshot.data.documents[indexDoc].data.containsKey('hasilCashier')) {
                                          if ((snapshot.data.documents[indexDoc].data['hasilCashier'] * 100).round() > 85.0) {
                                            colorCashier = Colors.green;
                                          } else if ((snapshot.data.documents[indexDoc].data['hasilCashier'] * 100).round() < 70.0) {
                                            colorCashier = Colors.redAccent;
                                          } else {
                                            colorCashier = Colors.orangeAccent;
                                          }
                                        }
                                        if (snapshot.data.documents[indexDoc].data.containsKey('hasilCashierAccuracy')) {
                                          if ((snapshot.data.documents[indexDoc].data['hasilCashierAccuracy'] * 100).round() > 85.0) {
                                            colorCashierAccuracy = Colors.green;
                                          } else if ((snapshot.data.documents[indexDoc].data['hasilCashierAccuracy'] * 100).round() < 70.0) {
                                            colorCashierAccuracy = Colors.redAccent;
                                          } else {
                                            colorCashierAccuracy = Colors.orangeAccent;
                                          }
                                        }
                                        if (snapshot.data.documents[indexDoc].data.containsKey('hasilBoh')) {
                                          if ((snapshot.data.documents[indexDoc].data['hasilBoh'] * 100).round() > 85.0) {
                                            colorBoh = Colors.green;
                                          } else if ((snapshot.data.documents[indexDoc].data['hasilBoh'] * 100).round() < 70.0) {
                                            colorBoh = Colors.redAccent;
                                          } else {
                                            colorBoh = Colors.orangeAccent;
                                          }
                                        }
                                        if (snapshot.data.documents[indexDoc].data.containsKey('hasilWarehouse')) {
                                          if ((snapshot.data.documents[indexDoc].data['hasilWarehouse'] * 100).round() > 85.0) {
                                            colorWarehouse = Colors.green;
                                          } else if ((snapshot.data.documents[indexDoc].data['hasilWarehouse'] * 100).round() < 70.0) {
                                            colorWarehouse = Colors.redAccent;
                                          } else {
                                            colorWarehouse = Colors.orangeAccent;
                                          }
                                        }
                                        if (snapshot.data.documents[indexDoc].data.containsKey('hasilSocialBlock')) {
                                          if ((snapshot.data.documents[indexDoc].data['hasilSocialBlock'] * 100).round() > 85.0) {
                                            colorSocialBlock = Colors.green;
                                          } else if ((snapshot.data.documents[indexDoc].data['hasilSocialBlock'] * 100).round() < 70.0) {
                                            colorSocialBlock = Colors.redAccent;
                                          } else {
                                            colorSocialBlock = Colors.orangeAccent;
                                          }
                                        }
                                        if (snapshot.data.documents[indexDoc].data.containsKey('hasilPersonal')) {
                                          if ((snapshot.data.documents[indexDoc].data['hasilPersonal'] * 100).round() > 85.0) {
                                            colorPersonal = Colors.green;
                                          } else if ((snapshot.data.documents[indexDoc].data['hasilPersonal'] * 100).round() < 70.0) {
                                            colorPersonal = Colors.redAccent;
                                          } else {
                                            colorPersonal = Colors.orangeAccent;
                                          }
                                        }
                                        if (snapshot.data.documents[indexDoc].data.containsKey('hasilFoodCooked')) {
                                          if ((snapshot.data.documents[indexDoc].data['hasilFoodCooked'] * 100).round() > 85.0) {
                                            colorFoodCooked = Colors.green;
                                          } else if ((snapshot.data.documents[indexDoc].data['hasilFoodCooked'] * 100).round() < 70.0) {
                                            colorFoodCooked = Colors.redAccent;
                                          } else {
                                            colorFoodCooked = Colors.orangeAccent;
                                          }
                                        }

                                        return Column(
                                          children: List.generate(snapshot.data.documents[indexDoc].data['subArea'].length, (index) {
                                            return ExpansionTile(
                                              title: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(
                                                      snapshot.data.documents[indexDoc].data['subArea'][index].toString(),
                                                      style: TextStyle(
                                                        fontSize: 14.0,
                                                        fontWeight: FontWeight.w600,
                                                        color: snapshot.data.documents[indexDoc].data['subArea'][index] == 'Area Luar'
                                                            ? colorAreaLuar
                                                            : snapshot.data.documents[indexDoc].data['subArea'][index] == 'Dinning Area'
                                                            ? colorDinningArea
                                                            : snapshot.data.documents[indexDoc].data['subArea'][index] == 'Service'
                                                            ? colorService
                                                            : snapshot.data.documents[indexDoc].data['subArea'][index] == 'Cashier'
                                                            ? colorCashier
                                                            : snapshot.data.documents[indexDoc].data['subArea'][index] == 'Administrasi Keuangan'
                                                            ? colorCashierAccuracy
                                                            : snapshot.data.documents[indexDoc].data['subArea'][index] == 'Back of The House (BOH)'
                                                            ? colorBoh
                                                            : snapshot.data.documents[indexDoc].data['subArea'][index] == 'Warehouse'
                                                            ? colorWarehouse
                                                            : snapshot.data.documents[indexDoc].data['subArea'][index] == 'Social Block'
                                                            ? colorSocialBlock
                                                            : snapshot.data.documents[indexDoc].data['subArea'][index] == 'Personal Hygiene'
                                                            ? colorPersonal
                                                            : snapshot.data.documents[indexDoc].data['subArea'][index] == 'Product Handling'
                                                            ? colorFoodCooked
                                                            : Colors.black
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment: Alignment.centerLeft,
                                                    child: Row(
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            'Auditor : ${namaAuditor[index]}',
                                                            style: TextStyle(
                                                              fontSize: 14.0
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ),
                                                ],
                                              ),
                                              children: <Widget>[
                                                snapshot.data.documents[indexDoc].data['subArea'][index] == 'Area Luar'
                                                  ? Column(
                                                      children: <Widget>[
                                                        snapshot.data.documents[indexDoc].data.containsKey('hasilAreaLuar')
                                                          ? Container(
                                                              alignment: Alignment.centerLeft,
                                                              child: LinearPercentIndicator(
                                                                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                                                                width: MediaQuery.of(context).size.width,
                                                                animation: true,
                                                                lineHeight: 30.0,
                                                                percent: snapshot.data.documents[indexDoc].data['hasilAreaLuar'] * 100 > 100.0
                                                                    ? 1.0
                                                                    : snapshot.data.documents[indexDoc].data['hasilAreaLuar'] ,
                                                                center: Text(snapshot.data.documents[indexDoc].data['hasilAreaLuar'] * 100 >=
                                                                    100.0
                                                                        ? '100%'
                                                                        : '${(snapshot.data.documents[indexDoc].data['hasilAreaLuar'] * 100).round().toString()}%'),
                                                                animationDuration: 1000,
                                                                linearStrokeCap: LinearStrokeCap.butt,
                                                                progressColor:
                                                                (snapshot.data.documents[indexDoc].data['hasilAreaLuar'] * 100).round() > 85.0
                                                                    ? Colors.green
                                                                    : (snapshot.data.documents[indexDoc].data['hasilAreaLuar'] * 100).round() < 70.0
                                                                        ? Colors.redAccent
                                                                        : Colors.orangeAccent,
                                                              ),
                                                            )
                                                          : Container(),
                                                        Column(
                                                          children: List.generate(snapshot.data.documents[indexDoc].data['pertanyaanAreaLuar'].length, (index2) {
                                                            return Column(
                                                              children: <Widget>[
                                                                ListTile(
                                                                  title: Container(
                                                                    width: 270.0,
                                                                    child: Column(
                                                                      children: <Widget>[
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: <Widget>[
                                                                            Flexible(
                                                                              child: Text(
                                                                                snapshot.data.documents[indexDoc].data['sistemAreaLuar'][index2],
                                                                                style: TextStyle(
                                                                                  color: Colors.green,
                                                                                  fontWeight: FontWeight.w700,
                                                                                  fontSize: 14.0
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Flexible(
                                                                              child: Text(
                                                                                snapshot.data.documents[indexDoc].data['criticalAreaLuar'][index2] == 'false'
                                                                                  ? ''
                                                                                  : 'CRITICAL',
                                                                                style: TextStyle(
                                                                                    color: Colors.red,
                                                                                    fontWeight:
                                                                                    FontWeight.w700,
                                                                                    fontSize: 14.0),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          children: <Widget>[
                                                                            Flexible(
                                                                              child: Text(
                                                                                '${index2 + 1}. ${snapshot.data.documents[indexDoc].data['pertanyaanAreaLuar'][index2]}',
                                                                                style: TextStyle(
                                                                                  color: Colors.black54,
                                                                                  fontSize: 14.0
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  trailing: Container(
                                                                    width: 30.0,
                                                                    child: Row(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                      children: <Widget>[
                                                                        Flexible(
                                                                          child: snapshot.data.documents[indexDoc].data.containsKey('AreaLuar_score')
                                                                            ? Text(
                                                                                snapshot.data.documents[indexDoc].data['AreaLuar_score'][index2].toString(),
                                                                                style: TextStyle(
                                                                                  color: snapshot.data.documents[indexDoc].data['AreaLuar_score'][index2] == 0
                                                                                      ? Colors.redAccent
                                                                                      : snapshot.data.documents[indexDoc].data['AreaLuar_score'][index2] == 1
                                                                                          ? Colors.orangeAccent
                                                                                          : Colors.green,
                                                                                  fontWeight: FontWeight.w700 
                                                                                ),
                                                                              )
                                                                            : Text(
                                                                                '-',
                                                                                style: TextStyle(
                                                                                  color: Colors.black54,
                                                                                  fontWeight: FontWeight.w700 
                                                                                ),
                                                                              )
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.only(left: 0.0, right: 15.0, bottom: 10.0),
                                                                  child: Container(
                                                                    width: 270.0,
                                                                    child: Row(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                      children: <Widget>[
                                                                        snapshot.data.documents[indexDoc].data.containsKey('imageAreaLuar')
                                                                          ? snapshot.data.documents[indexDoc].data['imageAreaLuar'][index2] == null
                                                                              ? Container()
                                                                              : GestureDetector(
                                                                                  onTap: () {
                                                                                    setState(() {
                                                                                      var bantuGambarAreaLuar = imageAreaLuarShow[index2];
                                                                                      imageAreaLuarShow.removeAt(index2);
                                                                                      imageAreaLuarShow.insert(index2, !bantuGambarAreaLuar);
                                                                                      noteAreaLuarShow.removeAt(index2);
                                                                                      noteAreaLuarShow.insert(index2, false);
                                                                                    });
                                                                                  },
                                                                                  child: Icon(Icons.image, color: AbubaPallate.menuBluebird),
                                                                                )
                                                                          : Container(),
                                                                        snapshot.data.documents[indexDoc].data.containsKey('AreaLuar_note')
                                                                          ? snapshot.data.documents[indexDoc].data['AreaLuar_note'][index2] == null
                                                                              ? Container()
                                                                              : GestureDetector(
                                                                                  onTap: () {
                                                                                    setState(() {
                                                                                      var bantuNoteAreaLuar = noteAreaLuarShow[index2];
                                                                                      noteAreaLuarShow.removeAt(index2);
                                                                                      noteAreaLuarShow.insert(index2, !bantuNoteAreaLuar);
                                                                                      imageAreaLuarShow.removeAt(index2);
                                                                                      imageAreaLuarShow.insert(index2, false);
                                                                                    });
                                                                                  },
                                                                                  child: Icon(Icons.note_add, color: AbubaPallate.menuBluebird),
                                                                                )
                                                                          : Container(),
                                                                      ]
                                                                    ),
                                                                  )
                                                                ),
                                                                imageAreaLuarShow[index2]
                                                                  ? snapshot.data.documents[indexDoc].data['imageAreaLuar'][index2] == null
                                                                      ? Padding(
                                                                          padding: EdgeInsets.only(left: 17.0, right: 17.0, bottom: 10.0),
                                                                          child: Container(
                                                                            decoration: const BoxDecoration(
                                                                              border: Border(
                                                                                top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                                left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                                right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                                bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                              ),
                                                                            ),
                                                                            padding: EdgeInsets.all(10.0),
                                                                            child: Column(
                                                                              children: <Widget>[
                                                                                Row(
                                                                                  children: <Widget>[
                                                                                    Flexible(
                                                                                      child: Text(
                                                                                        'No Image',
                                                                                        style: TextStyle(
                                                                                            color: Colors.black54,
                                                                                            fontWeight: FontWeight.w700),
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        )
                                                                      : Container(
                                                                          child: GridView.count(
                                                                            padding: const EdgeInsets.only(right: 17.0, left: 17.0, bottom: 10.0),
                                                                            crossAxisCount: 2,
                                                                            childAspectRatio: 1.0,
                                                                            mainAxisSpacing: 4.0,
                                                                            crossAxisSpacing: 4.0,
                                                                            shrinkWrap: true,
                                                                            children: <Widget>[
                                                                              GridTile(
                                                                                child: Image.network(
                                                                                  snapshot.data.documents[indexDoc].data['imageAreaLuar'][index2].toString(),
                                                                                  fit: BoxFit.cover,
                                                                                )
                                                                              ),
                                                                            ]
                                                                          ),
                                                                        )
                                                                  : Container(),
                                                                noteAreaLuarShow[index2]
                                                                  ? Padding(
                                                                      padding: EdgeInsets.only(left: 17.0, right: 17.0, bottom: 10.0),
                                                                      child: Container(
                                                                        decoration: BoxDecoration(
                                                                          border: Border(
                                                                            top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                            left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                            right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                            bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                          ),
                                                                        ),
                                                                        padding: EdgeInsets.all(10.0),
                                                                        child: Column(
                                                                          children: <Widget>[
                                                                            Row(
                                                                              children: <Widget>[
                                                                                Flexible(
                                                                                  child: Text(
                                                                                    'Catatan',
                                                                                    style: TextStyle(
                                                                                        color: Colors.black54,
                                                                                        fontWeight: FontWeight.w700
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                            SizedBox(
                                                                              height: 5.0,
                                                                            ),
                                                                            noteAreaLuarShow[index2] == null
                                                                              ? Container()
                                                                              : Row(
                                                                                  children: <Widget>[
                                                                                    Flexible(
                                                                                      child: Text(
                                                                                        '- ${snapshot.data.documents[indexDoc].data['AreaLuar_note'][index2].toString()}',
                                                                                        style: TextStyle(
                                                                                          color: Colors.black38,
                                                                                        ),
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : Container()
                                                              ],
                                                            );
                                                          }).toList(),
                                                        )
                                                      ],
                                                    )
                                                : snapshot.data.documents[indexDoc].data['subArea'][index] == 'Dinning Area'
                                                    ? Column(
                                                        children: <Widget>[
                                                          snapshot.data.documents[indexDoc].data.containsKey('hasilDinningArea')
                                                            ? Container(
                                                                alignment: Alignment.centerLeft,
                                                                child: LinearPercentIndicator(
                                                                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                                                                  width: MediaQuery.of(context).size.width,
                                                                  animation: true,
                                                                  lineHeight: 30.0,
                                                                  percent: snapshot.data.documents[indexDoc].data['hasilDinningArea'] * 100 > 100.0
                                                                      ? 1.0
                                                                      : snapshot.data.documents[indexDoc].data['hasilDinningArea'] ,
                                                                  center: Text(snapshot.data.documents[indexDoc].data['hasilDinningArea'] * 100 >=
                                                                      100.0
                                                                          ? '100%'
                                                                          : '${(snapshot.data.documents[indexDoc].data['hasilDinningArea'] * 100).round().toString()}%'),
                                                                  animationDuration: 1000,
                                                                  linearStrokeCap: LinearStrokeCap.butt,
                                                                  progressColor:
                                                                  (snapshot.data.documents[indexDoc].data['hasilDinningArea'] * 100).round() > 85.0
                                                                      ? Colors.green
                                                                      : (snapshot.data.documents[indexDoc].data['hasilDinningArea'] * 100).round() < 70.0
                                                                          ? Colors.redAccent
                                                                          : Colors.orangeAccent,
                                                                ),
                                                              )
                                                            : Container(),
                                                          Column(
                                                            children: List.generate(snapshot.data.documents[indexDoc].data['pertanyaanDinningArea'].length, (index2) {
                                                              return Column(
                                                                children: <Widget>[
                                                                  ListTile(
                                                                    title: Container(
                                                                      width: 270.0,
                                                                      child: Column(
                                                                        children: <Widget>[
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: <Widget>[
                                                                              Flexible(
                                                                                child: Text(
                                                                                  snapshot.data.documents[indexDoc].data['sistemDinningArea'][index2],
                                                                                  style: TextStyle(
                                                                                    color: Colors.green,
                                                                                    fontWeight: FontWeight.w700,
                                                                                    fontSize: 14.0
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Flexible(
                                                                                child: Text(
                                                                                  snapshot.data.documents[indexDoc].data['criticalDinningArea'][index2] == 'false'
                                                                                    ? ''
                                                                                    : 'CRITICAL',
                                                                                  style: TextStyle(
                                                                                      color: Colors.red,
                                                                                      fontWeight:
                                                                                      FontWeight.w700,
                                                                                      fontSize: 14.0),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            children: <Widget>[
                                                                              Flexible(
                                                                                child: Text(
                                                                                  '${index2 + 1}. ${snapshot.data.documents[indexDoc].data['pertanyaanDinningArea'][index2]}',
                                                                                  style: TextStyle(
                                                                                    color: Colors.black54,
                                                                                    fontSize: 14.0
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    trailing: Container(
                                                                      width: 30.0,
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: <Widget>[
                                                                          Flexible(
                                                                            child: snapshot.data.documents[indexDoc].data.containsKey('DinningArea_score')
                                                                              ? Text(
                                                                                  snapshot.data.documents[indexDoc].data['DinningArea_score'][index2].toString(),
                                                                                  style: TextStyle(
                                                                                    color: snapshot.data.documents[indexDoc].data['DinningArea_score'][index2] == 0
                                                                                        ? Colors.redAccent
                                                                                        : snapshot.data.documents[indexDoc].data['DinningArea_score'][index2] == 1
                                                                                            ? Colors.orangeAccent
                                                                                            : Colors.green,
                                                                                    fontWeight: FontWeight.w700 
                                                                                  ),
                                                                                )
                                                                              : Text(
                                                                                  '-',
                                                                                  style: TextStyle(
                                                                                    color: Colors.black54,
                                                                                    fontWeight: FontWeight.w700 
                                                                                  ),
                                                                                )
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(left: 0.0, right: 15.0, bottom: 10.0),
                                                                    child: Container(
                                                                      width: 270.0,
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: <Widget>[
                                                                          snapshot.data.documents[indexDoc].data.containsKey('imageDinningArea')
                                                                          ? snapshot.data.documents[indexDoc].data['imageDinningArea'][index2] == null
                                                                              ? Container()
                                                                              : GestureDetector(
                                                                                  onTap: () {
                                                                                    setState(() {
                                                                                      var bantuGambarDinningArea = imageDinningAreaShow[index2];
                                                                                      imageDinningAreaShow.removeAt(index2);
                                                                                      imageDinningAreaShow.insert(index2, !bantuGambarDinningArea);
                                                                                      noteDinningAreaShow.removeAt(index2);
                                                                                      noteDinningAreaShow.insert(index2, false);
                                                                                    });
                                                                                  },
                                                                                  child: Icon(Icons.image, color: AbubaPallate.menuBluebird),
                                                                                )
                                                                          : Container(),
                                                                        snapshot.data.documents[indexDoc].data.containsKey('DinningArea_note')
                                                                          ? snapshot.data.documents[indexDoc].data['DinningArea_note'][index2] == null
                                                                              ? Container()
                                                                              : GestureDetector(
                                                                                  onTap: () {
                                                                                    setState(() {
                                                                                      var bantuNoteDinningArea = noteDinningAreaShow[index2];
                                                                                      noteDinningAreaShow.removeAt(index2);
                                                                                      noteDinningAreaShow.insert(index2, !bantuNoteDinningArea);
                                                                                      imageDinningAreaShow.removeAt(index2);
                                                                                      imageDinningAreaShow.insert(index2, false);
                                                                                    });
                                                                                  },
                                                                                  child: Icon(Icons.note_add, color: AbubaPallate.menuBluebird),
                                                                                )
                                                                          : Container(),
                                                                        ]
                                                                      ),
                                                                    )
                                                                  ),
                                                                  imageDinningAreaShow[index2]
                                                                    ? snapshot.data.documents[indexDoc].data['imageDinningArea'][index2] == null
                                                                        ? Padding(
                                                                            padding: EdgeInsets.only(left: 17.0, right: 17.0, bottom: 10.0),
                                                                            child: Container(
                                                                              decoration: const BoxDecoration(
                                                                                border: Border(
                                                                                  top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                                  left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                                  right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                                  bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                                ),
                                                                              ),
                                                                              padding: EdgeInsets.all(10.0),
                                                                              child: Column(
                                                                                children: <Widget>[
                                                                                  Row(
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          'No Image',
                                                                                          style: TextStyle(
                                                                                              color: Colors.black54,
                                                                                              fontWeight: FontWeight.w700),
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          )
                                                                        : Container(
                                                                            child: GridView.count(
                                                                              padding: const EdgeInsets.only(right: 17.0, left: 17.0, bottom: 10.0),
                                                                              crossAxisCount: 2,
                                                                              childAspectRatio: 1.0,
                                                                              mainAxisSpacing: 4.0,
                                                                              crossAxisSpacing: 4.0,
                                                                              shrinkWrap: true,
                                                                              children: <Widget>[
                                                                                GridTile(
                                                                                  child: Image.network(
                                                                                    snapshot.data.documents[indexDoc].data['imageDinningArea'][index2].toString(),
                                                                                    fit: BoxFit.cover,
                                                                                  )
                                                                                ),
                                                                              ]
                                                                            ),
                                                                          )
                                                                    : Container(),
                                                                  noteDinningAreaShow[index2]
                                                                    ? Padding(
                                                                        padding: EdgeInsets.only(left: 17.0, right: 17.0, bottom: 10.0),
                                                                        child: Container(
                                                                          decoration: BoxDecoration(
                                                                            border: Border(
                                                                              top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                              left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                              right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                              bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                            ),
                                                                          ),
                                                                          padding: EdgeInsets.all(10.0),
                                                                          child: Column(
                                                                            children: <Widget>[
                                                                              Row(
                                                                                children: <Widget>[
                                                                                  Flexible(
                                                                                    child: Text(
                                                                                      'Catatan',
                                                                                      style: TextStyle(
                                                                                          color: Colors.black54,
                                                                                          fontWeight: FontWeight.w700
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 5.0,
                                                                              ),
                                                                              noteDinningAreaShow[index2] == null
                                                                                ? Container()
                                                                                : Row(
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          '- ${snapshot.data.documents[indexDoc].data['DinningArea_note'][index2].toString()}',
                                                                                          style: TextStyle(
                                                                                            color: Colors.black38,
                                                                                          ),
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                  )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : Container()
                                                                ],
                                                              );
                                                            }).toList(),
                                                          )
                                                        ],
                                                      )
                                                    : snapshot.data.documents[indexDoc].data['subArea'][index] == 'Service'
                                                    ? Column(
                                                        children: <Widget>[
                                                          snapshot.data.documents[indexDoc].data.containsKey('hasilService')
                                                            ? Container(
                                                                alignment: Alignment.centerLeft,
                                                                child: LinearPercentIndicator(
                                                                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                                                                  width: MediaQuery.of(context).size.width,
                                                                  animation: true,
                                                                  lineHeight: 30.0,
                                                                  percent: snapshot.data.documents[indexDoc].data['hasilService'] * 100 > 100.0
                                                                      ? 1.0
                                                                      : snapshot.data.documents[indexDoc].data['hasilService'] ,
                                                                  center: Text(snapshot.data.documents[indexDoc].data['hasilService'] * 100 >=
                                                                      100.0
                                                                          ? '100%'
                                                                          : '${(snapshot.data.documents[indexDoc].data['hasilService'] * 100).round().toString()}%'),
                                                                  animationDuration: 1000,
                                                                  linearStrokeCap: LinearStrokeCap.butt,
                                                                  progressColor:
                                                                  (snapshot.data.documents[indexDoc].data['hasilService'] * 100).round() > 85.0
                                                                      ? Colors.green
                                                                      : (snapshot.data.documents[indexDoc].data['hasilService'] * 100).round() < 70.0
                                                                          ? Colors.redAccent
                                                                          : Colors.orangeAccent,
                                                                ),
                                                              )
                                                            : Container(),
                                                          Column(
                                                            children: List.generate(snapshot.data.documents[indexDoc].data['pertanyaanService'].length, (index2) {
                                                              return Column(
                                                                children: <Widget>[
                                                                  ListTile(
                                                                    title: Container(
                                                                      width: 270.0,
                                                                      child: Column(
                                                                        children: <Widget>[
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: <Widget>[
                                                                              Flexible(
                                                                                child: Text(
                                                                                  snapshot.data.documents[indexDoc].data['sistemService'][index2],
                                                                                  style: TextStyle(
                                                                                    color: Colors.green,
                                                                                    fontWeight: FontWeight.w700,
                                                                                    fontSize: 14.0
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Flexible(
                                                                                child: Text(
                                                                                  snapshot.data.documents[indexDoc].data['criticalService'][index2] == 'false'
                                                                                    ? ''
                                                                                    : 'CRITICAL',
                                                                                  style: TextStyle(
                                                                                      color: Colors.red,
                                                                                      fontWeight:
                                                                                      FontWeight.w700,
                                                                                      fontSize: 14.0),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            children: <Widget>[
                                                                              Flexible(
                                                                                child: Text(
                                                                                  '${index2 + 1}. ${snapshot.data.documents[indexDoc].data['pertanyaanService'][index2]}',
                                                                                  style: TextStyle(
                                                                                    color: Colors.black54,
                                                                                    fontSize: 14.0
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    trailing: Container(
                                                                      width: 30.0,
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: <Widget>[
                                                                          Flexible(
                                                                            child: snapshot.data.documents[indexDoc].data.containsKey('Service_score')
                                                                              ? Text(
                                                                                  snapshot.data.documents[indexDoc].data['Service_score'][index2].toString(),
                                                                                  style: TextStyle(
                                                                                    color: snapshot.data.documents[indexDoc].data['Service_score'][index2] == 0
                                                                                        ? Colors.redAccent
                                                                                        : snapshot.data.documents[indexDoc].data['Service_score'][index2] == 1
                                                                                            ? Colors.orangeAccent
                                                                                            : Colors.green,
                                                                                    fontWeight: FontWeight.w700 
                                                                                  ),
                                                                                )
                                                                              : Text(
                                                                                  '-',
                                                                                  style: TextStyle(
                                                                                    color: Colors.black54,
                                                                                    fontWeight: FontWeight.w700 
                                                                                  ),
                                                                                )
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(left: 0.0, right: 15.0, bottom: 10.0),
                                                                    child: Container(
                                                                      width: 270.0,
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: <Widget>[
                                                                          snapshot.data.documents[indexDoc].data.containsKey('imageService')
                                                                            ? snapshot.data.documents[indexDoc].data['imageService'][index2] == null
                                                                                ? Container()
                                                                                : GestureDetector(
                                                                                    onTap: () {
                                                                                      setState(() {
                                                                                        var bantuGambarService = imageServiceShow[index2];
                                                                                        imageServiceShow.removeAt(index2);
                                                                                        imageServiceShow.insert(index2, !bantuGambarService);
                                                                                        noteServiceShow.removeAt(index2);
                                                                                        noteServiceShow.insert(index2, false);
                                                                                      });
                                                                                    },
                                                                                    child: Icon(Icons.image, color: AbubaPallate.menuBluebird),
                                                                                  )
                                                                            : Container(),
                                                                          snapshot.data.documents[indexDoc].data.containsKey('Service_note')
                                                                            ? snapshot.data.documents[indexDoc].data['Service_note'][index2] == null
                                                                                ? Container()
                                                                                : GestureDetector(
                                                                                    onTap: () {
                                                                                      setState(() {
                                                                                        var bantuNoteService = noteServiceShow[index2];
                                                                                        noteServiceShow.removeAt(index2);
                                                                                        noteServiceShow.insert(index2, !bantuNoteService);
                                                                                        imageServiceShow.removeAt(index2);
                                                                                        imageServiceShow.insert(index2, false);
                                                                                      });
                                                                                    },
                                                                                    child: Icon(Icons.note_add, color: AbubaPallate.menuBluebird),
                                                                                  )
                                                                            : Container(),
                                                                        ]
                                                                      ),
                                                                    )
                                                                  ),
                                                                  imageServiceShow[index2]
                                                                    ? snapshot.data.documents[indexDoc].data['imageService'][index2] == null
                                                                        ? Padding(
                                                                            padding: EdgeInsets.only(left: 17.0, right: 17.0, bottom: 10.0),
                                                                            child: Container(
                                                                              decoration: const BoxDecoration(
                                                                                border: Border(
                                                                                  top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                                  left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                                  right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                                  bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                                ),
                                                                              ),
                                                                              padding: EdgeInsets.all(10.0),
                                                                              child: Column(
                                                                                children: <Widget>[
                                                                                  Row(
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          'No Image',
                                                                                          style: TextStyle(
                                                                                              color: Colors.black54,
                                                                                              fontWeight: FontWeight.w700),
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          )
                                                                        : Container(
                                                                            child: GridView.count(
                                                                              padding: const EdgeInsets.only(right: 17.0, left: 17.0, bottom: 10.0),
                                                                              crossAxisCount: 2,
                                                                              childAspectRatio: 1.0,
                                                                              mainAxisSpacing: 4.0,
                                                                              crossAxisSpacing: 4.0,
                                                                              shrinkWrap: true,
                                                                              children: <Widget>[
                                                                                GridTile(
                                                                                  child: Image.network(
                                                                                    snapshot.data.documents[indexDoc].data['imageService'][index2].toString(),
                                                                                    fit: BoxFit.cover,
                                                                                  )
                                                                                ),
                                                                              ]
                                                                            ),
                                                                          )
                                                                    : Container(),
                                                                  noteServiceShow[index2]
                                                                    ? Padding(
                                                                        padding: EdgeInsets.only(left: 17.0, right: 17.0, bottom: 10.0),
                                                                        child: Container(
                                                                          decoration: BoxDecoration(
                                                                            border: Border(
                                                                              top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                              left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                              right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                              bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                            ),
                                                                          ),
                                                                          padding: EdgeInsets.all(10.0),
                                                                          child: Column(
                                                                            children: <Widget>[
                                                                              Row(
                                                                                children: <Widget>[
                                                                                  Flexible(
                                                                                    child: Text(
                                                                                      'Catatan',
                                                                                      style: TextStyle(
                                                                                          color: Colors.black54,
                                                                                          fontWeight: FontWeight.w700
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 5.0,
                                                                              ),
                                                                              noteServiceShow[index2] == null
                                                                                ? Container()
                                                                                : Row(
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          '- ${snapshot.data.documents[indexDoc].data['Service_note'][index2].toString()}',
                                                                                          style: TextStyle(
                                                                                            color: Colors.black38,
                                                                                          ),
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                  )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : Container()
                                                                ],
                                                              );
                                                            }).toList(),
                                                          )
                                                        ],
                                                      )
                                                    : snapshot.data.documents[indexDoc].data['subArea'][index] == 'Cashier'
                                                    ? Column(
                                                        children: <Widget>[
                                                          snapshot.data.documents[indexDoc].data.containsKey('hasilCashier')
                                                            ? Container(
                                                                alignment: Alignment.centerLeft,
                                                                child: LinearPercentIndicator(
                                                                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                                                                  width: MediaQuery.of(context).size.width,
                                                                  animation: true,
                                                                  lineHeight: 30.0,
                                                                  percent: snapshot.data.documents[indexDoc].data['hasilCashier'] * 100 > 100.0
                                                                      ? 1.0
                                                                      : snapshot.data.documents[indexDoc].data['hasilCashier'] ,
                                                                  center: Text(snapshot.data.documents[indexDoc].data['hasilCashier'] * 100 >=
                                                                      100.0
                                                                          ? '100%'
                                                                          : '${(snapshot.data.documents[indexDoc].data['hasilCashier'] * 100).round().toString()}%'),
                                                                  animationDuration: 1000,
                                                                  linearStrokeCap: LinearStrokeCap.butt,
                                                                  progressColor:
                                                                  (snapshot.data.documents[indexDoc].data['hasilCashier'] * 100).round() > 85.0
                                                                      ? Colors.green
                                                                      : (snapshot.data.documents[indexDoc].data['hasilCashier'] * 100).round() < 70.0
                                                                          ? Colors.redAccent
                                                                          : Colors.orangeAccent,
                                                                ),
                                                              )
                                                            : Container(),
                                                          Column(
                                                            children: List.generate(snapshot.data.documents[indexDoc].data['pertanyaanCashier'].length, (index2) {
                                                              return Column(
                                                                children: <Widget>[
                                                                  ListTile(
                                                                    title: Container(
                                                                      width: 270.0,
                                                                      child: Column(
                                                                        children: <Widget>[
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: <Widget>[
                                                                              Flexible(
                                                                                child: Text(
                                                                                  snapshot.data.documents[indexDoc].data['sistemCashier'][index2],
                                                                                  style: TextStyle(
                                                                                    color: Colors.green,
                                                                                    fontWeight: FontWeight.w700,
                                                                                    fontSize: 14.0
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Flexible(
                                                                                child: Text(
                                                                                  snapshot.data.documents[indexDoc].data['criticalCashier'][index2] == 'false'
                                                                                    ? ''
                                                                                    : 'CRITICAL',
                                                                                  style: TextStyle(
                                                                                      color: Colors.red,
                                                                                      fontWeight:
                                                                                      FontWeight.w700,
                                                                                      fontSize: 14.0),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            children: <Widget>[
                                                                              Flexible(
                                                                                child: Text(
                                                                                  '${index2 + 1}. ${snapshot.data.documents[indexDoc].data['pertanyaanCashier'][index2]}',
                                                                                  style: TextStyle(
                                                                                    color: Colors.black54,
                                                                                    fontSize: 14.0
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    trailing: Container(
                                                                      width: 30.0,
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: <Widget>[
                                                                          Flexible(
                                                                            child: snapshot.data.documents[indexDoc].data.containsKey('Cashier_score')
                                                                              ? Text(
                                                                                  snapshot.data.documents[indexDoc].data['Cashier_score'][index2].toString(),
                                                                                  style: TextStyle(
                                                                                    color: snapshot.data.documents[indexDoc].data['Cashier_score'][index2] == 0
                                                                                        ? Colors.redAccent
                                                                                        : snapshot.data.documents[indexDoc].data['Cashier_score'][index2] == 1
                                                                                            ? Colors.orangeAccent
                                                                                            : Colors.green,
                                                                                    fontWeight: FontWeight.w700 
                                                                                  ),
                                                                                )
                                                                              : Text(
                                                                                  '-',
                                                                                  style: TextStyle(
                                                                                    color: Colors.black54,
                                                                                    fontWeight: FontWeight.w700 
                                                                                  ),
                                                                                )
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(left: 0.0, right: 15.0, bottom: 10.0),
                                                                    child: Container(
                                                                      width: 270.0,
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: <Widget>[
                                                                          snapshot.data.documents[indexDoc].data.containsKey('imageCashier')
                                                                            ? snapshot.data.documents[indexDoc].data['imageCashier'][index2] == null
                                                                                ? Container()
                                                                                : GestureDetector(
                                                                                    onTap: () {
                                                                                      setState(() {
                                                                                        var bantuGambarCashier = imageCashierShow[index2];
                                                                                        imageCashierShow.removeAt(index2);
                                                                                        imageCashierShow.insert(index2, !bantuGambarCashier);
                                                                                        noteCashierShow.removeAt(index2);
                                                                                        noteCashierShow.insert(index2, false);
                                                                                      });
                                                                                    },
                                                                                    child: Icon(Icons.image, color: AbubaPallate.menuBluebird),
                                                                                  )
                                                                            : Container(),
                                                                          snapshot.data.documents[indexDoc].data.containsKey('Cashier_note')
                                                                            ? snapshot.data.documents[indexDoc].data['Cashier_note'][index2] == null
                                                                                ? Container()
                                                                                : GestureDetector(
                                                                                    onTap: () {
                                                                                      setState(() {
                                                                                        var bantuNoteCashier = noteCashierShow[index2];
                                                                                        noteCashierShow.removeAt(index2);
                                                                                        noteCashierShow.insert(index2, !bantuNoteCashier);
                                                                                        imageCashierShow.removeAt(index2);
                                                                                        imageCashierShow.insert(index2, false);
                                                                                      });
                                                                                    },
                                                                                    child: Icon(Icons.note_add, color: AbubaPallate.menuBluebird),
                                                                                  )
                                                                            : Container(),
                                                                        ]
                                                                      ),
                                                                    )
                                                                  ),
                                                                  imageCashierShow[index2]
                                                                    ? snapshot.data.documents[indexDoc].data['imageCashier'][index2] == null
                                                                        ? Padding(
                                                                            padding: EdgeInsets.only(left: 17.0, right: 17.0, bottom: 10.0),
                                                                            child: Container(
                                                                              decoration: const BoxDecoration(
                                                                                border: Border(
                                                                                  top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                                  left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                                  right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                                  bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                                ),
                                                                              ),
                                                                              padding: EdgeInsets.all(10.0),
                                                                              child: Column(
                                                                                children: <Widget>[
                                                                                  Row(
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          'No Image',
                                                                                          style: TextStyle(
                                                                                              color: Colors.black54,
                                                                                              fontWeight: FontWeight.w700),
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          )
                                                                        : Container(
                                                                            child: GridView.count(
                                                                              padding: const EdgeInsets.only(right: 17.0, left: 17.0, bottom: 10.0),
                                                                              crossAxisCount: 2,
                                                                              childAspectRatio: 1.0,
                                                                              mainAxisSpacing: 4.0,
                                                                              crossAxisSpacing: 4.0,
                                                                              shrinkWrap: true,
                                                                              children: <Widget>[
                                                                                GridTile(
                                                                                  child: Image.network(
                                                                                    snapshot.data.documents[indexDoc].data['imageCashier'][index2].toString(),
                                                                                    fit: BoxFit.cover,
                                                                                  )
                                                                                ),
                                                                              ]
                                                                            ),
                                                                          )
                                                                    : Container(),
                                                                  noteCashierShow[index2]
                                                                    ? Padding(
                                                                        padding: EdgeInsets.only(left: 17.0, right: 17.0, bottom: 10.0),
                                                                        child: Container(
                                                                          decoration: BoxDecoration(
                                                                            border: Border(
                                                                              top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                              left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                              right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                              bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                            ),
                                                                          ),
                                                                          padding: EdgeInsets.all(10.0),
                                                                          child: Column(
                                                                            children: <Widget>[
                                                                              Row(
                                                                                children: <Widget>[
                                                                                  Flexible(
                                                                                    child: Text(
                                                                                      'Catatan',
                                                                                      style: TextStyle(
                                                                                          color: Colors.black54,
                                                                                          fontWeight: FontWeight.w700
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 5.0,
                                                                              ),
                                                                              noteCashierShow[index2] == null
                                                                                ? Container()
                                                                                : Row(
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          '- ${snapshot.data.documents[indexDoc].data['Cashier_note'][index2].toString()}',
                                                                                          style: TextStyle(
                                                                                            color: Colors.black38,
                                                                                          ),
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                  )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : Container()
                                                                ],
                                                              );
                                                            }).toList(),
                                                          )
                                                        ],
                                                      )
                                                    // end cashier
                                                    : snapshot.data.documents[indexDoc].data['subArea'][index] == 'Administrasi Keuangan'
                                                    ? Column(
                                                        children: <Widget>[
                                                          snapshot.data.documents[indexDoc].data.containsKey('hasilCashierAccuracy')
                                                            ? Container(
                                                                alignment: Alignment.centerLeft,
                                                                child: LinearPercentIndicator(
                                                                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                                                                  width: MediaQuery.of(context).size.width,
                                                                  animation: true,
                                                                  lineHeight: 30.0,
                                                                  percent: snapshot.data.documents[indexDoc].data['hasilCashierAccuracy'] * 100 > 100.0
                                                                      ? 1.0
                                                                      : snapshot.data.documents[indexDoc].data['hasilCashierAccuracy'] ,
                                                                  center: Text(snapshot.data.documents[indexDoc].data['hasilCashierAccuracy'] * 100 >=
                                                                      100.0
                                                                          ? '100%'
                                                                          : '${(snapshot.data.documents[indexDoc].data['hasilCashierAccuracy'] * 100).round().toString()}%'),
                                                                  animationDuration: 1000,
                                                                  linearStrokeCap: LinearStrokeCap.butt,
                                                                  progressColor:
                                                                  (snapshot.data.documents[indexDoc].data['hasilCashierAccuracy'] * 100).round() > 85.0
                                                                      ? Colors.green
                                                                      : (snapshot.data.documents[indexDoc].data['hasilCashierAccuracy'] * 100).round() < 70.0
                                                                          ? Colors.redAccent
                                                                          : Colors.orangeAccent,
                                                                ),
                                                              )
                                                            : Container(),
                                                          Column(
                                                            children: List.generate(snapshot.data.documents[indexDoc].data['pertanyaanCashierAccuracy'].length, (index2) {
                                                              return Column(
                                                                children: <Widget>[
                                                                  ListTile(
                                                                    title: Container(
                                                                      width: 270.0,
                                                                      child: Column(
                                                                        children: <Widget>[
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: <Widget>[
                                                                              Flexible(
                                                                                child: Text(
                                                                                  snapshot.data.documents[indexDoc].data['sistemCashierAccuracy'][index2],
                                                                                  style: TextStyle(
                                                                                    color: Colors.green,
                                                                                    fontWeight: FontWeight.w700,
                                                                                    fontSize: 14.0
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Flexible(
                                                                                child: Text(
                                                                                  snapshot.data.documents[indexDoc].data['criticalCashierAccuracy'][index2] == 'false'
                                                                                    ? ''
                                                                                    : 'CRITICAL',
                                                                                  style: TextStyle(
                                                                                      color: Colors.red,
                                                                                      fontWeight:
                                                                                      FontWeight.w700,
                                                                                      fontSize: 14.0),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            children: <Widget>[
                                                                              Flexible(
                                                                                child: Text(
                                                                                  '${index2 + 1}. ${snapshot.data.documents[indexDoc].data['pertanyaanCashierAccuracy'][index2]}',
                                                                                  style: TextStyle(
                                                                                    color: Colors.black54,
                                                                                    fontSize: 14.0
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    trailing: Container(
                                                                      width: 30.0,
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: <Widget>[
                                                                          Flexible(
                                                                            child: snapshot.data.documents[indexDoc].data.containsKey('CashierAccuracy_score')
                                                                              ? Text(
                                                                                  snapshot.data.documents[indexDoc].data['CashierAccuracy_score'][index2].toString(),
                                                                                  style: TextStyle(
                                                                                    color: snapshot.data.documents[indexDoc].data['CashierAccuracy_score'][index2] == 0
                                                                                        ? Colors.redAccent
                                                                                        : snapshot.data.documents[indexDoc].data['CashierAccuracy_score'][index2] == 1
                                                                                            ? Colors.orangeAccent
                                                                                            : Colors.green,
                                                                                    fontWeight: FontWeight.w700 
                                                                                  ),
                                                                                )
                                                                              : Text(
                                                                                  '-',
                                                                                  style: TextStyle(
                                                                                    color: Colors.black54,
                                                                                    fontWeight: FontWeight.w700 
                                                                                  ),
                                                                                )
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(left: 0.0, right: 15.0, bottom: 10.0),
                                                                    child: Container(
                                                                      width: 270.0,
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: <Widget>[
                                                                          snapshot.data.documents[indexDoc].data.containsKey('imageCashierAccuracy')
                                                                            ? snapshot.data.documents[indexDoc].data['imageCashierAccuracy'][index2] == null
                                                                                ? Container()
                                                                                : GestureDetector(
                                                                                    onTap: () {
                                                                                      setState(() {
                                                                                        var bantuGambarCashierAccuracy = imageCashierAccuracyShow[index2];
                                                                                        imageCashierAccuracyShow.removeAt(index2);
                                                                                        imageCashierAccuracyShow.insert(index2, !bantuGambarCashierAccuracy);
                                                                                        noteCashierAccuracyShow.removeAt(index2);
                                                                                        noteCashierAccuracyShow.insert(index2, false);
                                                                                      });
                                                                                    },
                                                                                    child: Icon(Icons.image, color: AbubaPallate.menuBluebird),
                                                                                  )
                                                                            : Container(),
                                                                          snapshot.data.documents[indexDoc].data.containsKey('CashierAccuracy_note')
                                                                            ? snapshot.data.documents[indexDoc].data['CashierAccuracy_note'][index2] == null
                                                                                ? Container()
                                                                                : GestureDetector(
                                                                                    onTap: () {
                                                                                      setState(() {
                                                                                        var bantuNoteCashierAccuracy = noteCashierAccuracyShow[index2];
                                                                                        noteCashierAccuracyShow.removeAt(index2);
                                                                                        noteCashierAccuracyShow.insert(index2, !bantuNoteCashierAccuracy);
                                                                                        imageCashierAccuracyShow.removeAt(index2);
                                                                                        imageCashierAccuracyShow.insert(index2, false);
                                                                                      });
                                                                                    },
                                                                                    child: Icon(Icons.note_add, color: AbubaPallate.menuBluebird),
                                                                                  )
                                                                            : Container(),
                                                                        ]
                                                                      ),
                                                                    )
                                                                  ),
                                                                  imageCashierAccuracyShow[index2]
                                                                    ? snapshot.data.documents[indexDoc].data['imageCashierAccuracy'][index2] == null
                                                                        ? Padding(
                                                                            padding: EdgeInsets.only(left: 17.0, right: 17.0, bottom: 10.0),
                                                                            child: Container(
                                                                              decoration: const BoxDecoration(
                                                                                border: Border(
                                                                                  top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                                  left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                                  right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                                  bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                                ),
                                                                              ),
                                                                              padding: EdgeInsets.all(10.0),
                                                                              child: Column(
                                                                                children: <Widget>[
                                                                                  Row(
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          'No Image',
                                                                                          style: TextStyle(
                                                                                              color: Colors.black54,
                                                                                              fontWeight: FontWeight.w700),
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          )
                                                                        : Container(
                                                                            child: GridView.count(
                                                                              padding: const EdgeInsets.only(right: 17.0, left: 17.0, bottom: 10.0),
                                                                              crossAxisCount: 2,
                                                                              childAspectRatio: 1.0,
                                                                              mainAxisSpacing: 4.0,
                                                                              crossAxisSpacing: 4.0,
                                                                              shrinkWrap: true,
                                                                              children: <Widget>[
                                                                                GridTile(
                                                                                  child: Image.network(
                                                                                    snapshot.data.documents[indexDoc].data['imageCashierAccuracy'][index2].toString(),
                                                                                    fit: BoxFit.cover,
                                                                                  )
                                                                                ),
                                                                              ]
                                                                            ),
                                                                          )
                                                                    : Container(),
                                                                  noteCashierAccuracyShow[index2]
                                                                    ? Padding(
                                                                        padding: EdgeInsets.only(left: 17.0, right: 17.0, bottom: 10.0),
                                                                        child: Container(
                                                                          decoration: BoxDecoration(
                                                                            border: Border(
                                                                              top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                              left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                              right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                              bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                            ),
                                                                          ),
                                                                          padding: EdgeInsets.all(10.0),
                                                                          child: Column(
                                                                            children: <Widget>[
                                                                              Row(
                                                                                children: <Widget>[
                                                                                  Flexible(
                                                                                    child: Text(
                                                                                      'Catatan',
                                                                                      style: TextStyle(
                                                                                          color: Colors.black54,
                                                                                          fontWeight: FontWeight.w700
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 5.0,
                                                                              ),
                                                                              noteCashierAccuracyShow[index2] == null
                                                                                ? Container()
                                                                                : Row(
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          '- ${snapshot.data.documents[indexDoc].data['CashierAccuracy_note'][index2].toString()}',
                                                                                          style: TextStyle(
                                                                                            color: Colors.black38,
                                                                                          ),
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                  )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : Container()
                                                                ],
                                                              );
                                                            }).toList(),
                                                          )
                                                        ],
                                                      )
                                                    // end accuracy
                                                    : snapshot.data.documents[indexDoc].data['subArea'][index] == 'Back of The House (BOH)'
                                                    ? Column(
                                                        children: <Widget>[
                                                          snapshot.data.documents[indexDoc].data.containsKey('hasilBoh')
                                                            ? Container(
                                                                alignment: Alignment.centerLeft,
                                                                child: LinearPercentIndicator(
                                                                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                                                                  width: MediaQuery.of(context).size.width,
                                                                  animation: true,
                                                                  lineHeight: 30.0,
                                                                  percent: snapshot.data.documents[indexDoc].data['hasilBoh'] * 100 > 100.0
                                                                      ? 1.0
                                                                      : snapshot.data.documents[indexDoc].data['hasilBoh'] ,
                                                                  center: Text(snapshot.data.documents[indexDoc].data['hasilBoh'] * 100 >=
                                                                      100.0
                                                                          ? '100%'
                                                                          : '${(snapshot.data.documents[indexDoc].data['hasilBoh'] * 100).round().toString()}%'),
                                                                  animationDuration: 1000,
                                                                  linearStrokeCap: LinearStrokeCap.butt,
                                                                  progressColor:
                                                                  (snapshot.data.documents[indexDoc].data['hasilBoh'] * 100).round() > 85.0
                                                                      ? Colors.green
                                                                      : (snapshot.data.documents[indexDoc].data['hasilBoh'] * 100).round() < 70.0
                                                                          ? Colors.redAccent
                                                                          : Colors.orangeAccent,
                                                                ),
                                                              )
                                                            : Container(),
                                                          Column(
                                                            children: List.generate(snapshot.data.documents[indexDoc].data['pertanyaanBoh'].length, (index2) {
                                                              return Column(
                                                                children: <Widget>[
                                                                  ListTile(
                                                                    title: Container(
                                                                      width: 270.0,
                                                                      child: Column(
                                                                        children: <Widget>[
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: <Widget>[
                                                                              Flexible(
                                                                                child: Text(
                                                                                  snapshot.data.documents[indexDoc].data['sistemBoh'][index2],
                                                                                  style: TextStyle(
                                                                                    color: Colors.green,
                                                                                    fontWeight: FontWeight.w700,
                                                                                    fontSize: 14.0
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Flexible(
                                                                                child: Text(
                                                                                  snapshot.data.documents[indexDoc].data['criticalBoh'][index2] == 'false'
                                                                                    ? ''
                                                                                    : 'CRITICAL',
                                                                                  style: TextStyle(
                                                                                      color: Colors.red,
                                                                                      fontWeight:
                                                                                      FontWeight.w700,
                                                                                      fontSize: 14.0),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            children: <Widget>[
                                                                              Flexible(
                                                                                child: Text(
                                                                                  '${index2 + 1}. ${snapshot.data.documents[indexDoc].data['pertanyaanBoh'][index2]}',
                                                                                  style: TextStyle(
                                                                                    color: Colors.black54,
                                                                                    fontSize: 14.0
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    trailing: Container(
                                                                      width: 30.0,
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: <Widget>[
                                                                          Flexible(
                                                                            child: snapshot.data.documents[indexDoc].data.containsKey('Boh_score')
                                                                              ? Text(
                                                                                  snapshot.data.documents[indexDoc].data['Boh_score'][index2].toString(),
                                                                                  style: TextStyle(
                                                                                    color: snapshot.data.documents[indexDoc].data['Boh_score'][index2] == 0
                                                                                        ? Colors.redAccent
                                                                                        : snapshot.data.documents[indexDoc].data['Boh_score'][index2] == 1
                                                                                            ? Colors.orangeAccent
                                                                                            : Colors.green,
                                                                                    fontWeight: FontWeight.w700 
                                                                                  ),
                                                                                )
                                                                              : Text(
                                                                                  '-',
                                                                                  style: TextStyle(
                                                                                    color: Colors.black54,
                                                                                    fontWeight: FontWeight.w700 
                                                                                  ),
                                                                                )
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(left: 0.0, right: 15.0, bottom: 10.0),
                                                                    child: Container(
                                                                      width: 270.0,
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: <Widget>[
                                                                          snapshot.data.documents[indexDoc].data.containsKey('imageBoh')
                                                                            ? snapshot.data.documents[indexDoc].data['imageBoh'][index2] == null
                                                                                ? Container()
                                                                                : GestureDetector(
                                                                                    onTap: () {
                                                                                      setState(() {
                                                                                        var bantuGambarBoh = imageBohShow[index2];
                                                                                        imageBohShow.removeAt(index2);
                                                                                        imageBohShow.insert(index2, !bantuGambarBoh);
                                                                                        noteBohShow.removeAt(index2);
                                                                                        noteBohShow.insert(index2, false);
                                                                                      });
                                                                                    },
                                                                                    child: Icon(Icons.image, color: AbubaPallate.menuBluebird),
                                                                                  )
                                                                            : Container(),
                                                                          snapshot.data.documents[indexDoc].data.containsKey('Boh_note')
                                                                            ? snapshot.data.documents[indexDoc].data['Boh_note'][index2] == null
                                                                                ? Container()
                                                                                : GestureDetector(
                                                                                    onTap: () {
                                                                                      setState(() {
                                                                                        var bantuNoteBoh = noteBohShow[index2];
                                                                                        noteBohShow.removeAt(index2);
                                                                                        noteBohShow.insert(index2, !bantuNoteBoh);
                                                                                        imageBohShow.removeAt(index2);
                                                                                        imageBohShow.insert(index2, false);
                                                                                      });
                                                                                    },
                                                                                    child: Icon(Icons.note_add, color: AbubaPallate.menuBluebird),
                                                                                  )
                                                                            : Container(),
                                                                        ]
                                                                      ),
                                                                    )
                                                                  ),
                                                                  imageBohShow[index2]
                                                                    ? snapshot.data.documents[indexDoc].data['imageBoh'][index2] == null
                                                                        ? Padding(
                                                                            padding: EdgeInsets.only(left: 17.0, right: 17.0, bottom: 10.0),
                                                                            child: Container(
                                                                              decoration: const BoxDecoration(
                                                                                border: Border(
                                                                                  top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                                  left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                                  right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                                  bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                                ),
                                                                              ),
                                                                              padding: EdgeInsets.all(10.0),
                                                                              child: Column(
                                                                                children: <Widget>[
                                                                                  Row(
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          'No Image',
                                                                                          style: TextStyle(
                                                                                              color: Colors.black54,
                                                                                              fontWeight: FontWeight.w700),
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          )
                                                                        : Container(
                                                                            child: GridView.count(
                                                                              padding: const EdgeInsets.only(right: 17.0, left: 17.0, bottom: 10.0),
                                                                              crossAxisCount: 2,
                                                                              childAspectRatio: 1.0,
                                                                              mainAxisSpacing: 4.0,
                                                                              crossAxisSpacing: 4.0,
                                                                              shrinkWrap: true,
                                                                              children: <Widget>[
                                                                                GridTile(
                                                                                  child: Image.network(
                                                                                    snapshot.data.documents[indexDoc].data['imageBoh'][index2].toString(),
                                                                                    fit: BoxFit.cover,
                                                                                  )
                                                                                ),
                                                                              ]
                                                                            ),
                                                                          )
                                                                    : Container(),
                                                                  noteBohShow[index2]
                                                                    ? Padding(
                                                                        padding: EdgeInsets.only(left: 17.0, right: 17.0, bottom: 10.0),
                                                                        child: Container(
                                                                          decoration: BoxDecoration(
                                                                            border: Border(
                                                                              top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                              left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                              right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                              bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                            ),
                                                                          ),
                                                                          padding: EdgeInsets.all(10.0),
                                                                          child: Column(
                                                                            children: <Widget>[
                                                                              Row(
                                                                                children: <Widget>[
                                                                                  Flexible(
                                                                                    child: Text(
                                                                                      'Catatan',
                                                                                      style: TextStyle(
                                                                                          color: Colors.black54,
                                                                                          fontWeight: FontWeight.w700
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 5.0,
                                                                              ),
                                                                              noteBohShow[index2] == null
                                                                                ? Container()
                                                                                : Row(
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          '- ${snapshot.data.documents[indexDoc].data['Boh_note'][index2].toString()}',
                                                                                          style: TextStyle(
                                                                                            color: Colors.black38,
                                                                                          ),
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                  )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : Container()
                                                                ],
                                                              );
                                                            }).toList(),
                                                          )
                                                        ],
                                                      )
                                                    // end boh
                                                    : snapshot.data.documents[indexDoc].data['subArea'][index] == 'Warehouse'
                                                    ? Column(
                                                        children: <Widget>[
                                                          snapshot.data.documents[indexDoc].data.containsKey('hasilWarehouse')
                                                            ? Container(
                                                                alignment: Alignment.centerLeft,
                                                                child: LinearPercentIndicator(
                                                                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                                                                  width: MediaQuery.of(context).size.width,
                                                                  animation: true,
                                                                  lineHeight: 30.0,
                                                                  percent: snapshot.data.documents[indexDoc].data['hasilWarehouse'] * 100 > 100.0
                                                                      ? 1.0
                                                                      : snapshot.data.documents[indexDoc].data['hasilWarehouse'] ,
                                                                  center: Text(snapshot.data.documents[indexDoc].data['hasilWarehouse'] * 100 >=
                                                                      100.0
                                                                          ? '100%'
                                                                          : '${(snapshot.data.documents[indexDoc].data['hasilWarehouse'] * 100).round().toString()}%'),
                                                                  animationDuration: 1000,
                                                                  linearStrokeCap: LinearStrokeCap.butt,
                                                                  progressColor:
                                                                  (snapshot.data.documents[indexDoc].data['hasilWarehouse'] * 100).round() > 85.0
                                                                      ? Colors.green
                                                                      : (snapshot.data.documents[indexDoc].data['hasilWarehouse'] * 100).round() < 70.0
                                                                          ? Colors.redAccent
                                                                          : Colors.orangeAccent,
                                                                ),
                                                              )
                                                            : Container(),
                                                          Column(
                                                            children: List.generate(snapshot.data.documents[indexDoc].data['pertanyaanWarehouse'].length, (index2) {
                                                              return Column(
                                                                children: <Widget>[
                                                                  ListTile(
                                                                    title: Container(
                                                                      width: 270.0,
                                                                      child: Column(
                                                                        children: <Widget>[
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: <Widget>[
                                                                              Flexible(
                                                                                child: Text(
                                                                                  snapshot.data.documents[indexDoc].data['sistemWarehouse'][index2],
                                                                                  style: TextStyle(
                                                                                    color: Colors.green,
                                                                                    fontWeight: FontWeight.w700,
                                                                                    fontSize: 14.0
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Flexible(
                                                                                child: Text(
                                                                                  snapshot.data.documents[indexDoc].data['criticalWarehouse'][index2] == 'false'
                                                                                    ? ''
                                                                                    : 'CRITICAL',
                                                                                  style: TextStyle(
                                                                                      color: Colors.red,
                                                                                      fontWeight:
                                                                                      FontWeight.w700,
                                                                                      fontSize: 14.0),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            children: <Widget>[
                                                                              Flexible(
                                                                                child: Text(
                                                                                  '${index2 + 1}. ${snapshot.data.documents[indexDoc].data['pertanyaanWarehouse'][index2]}',
                                                                                  style: TextStyle(
                                                                                    color: Colors.black54,
                                                                                    fontSize: 14.0
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    trailing: Container(
                                                                      width: 30.0,
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: <Widget>[
                                                                          Flexible(
                                                                            child: snapshot.data.documents[indexDoc].data.containsKey('Warehouse_score')
                                                                              ? Text(
                                                                                  snapshot.data.documents[indexDoc].data['Warehouse_score'][index2].toString(),
                                                                                  style: TextStyle(
                                                                                    color: snapshot.data.documents[indexDoc].data['Warehouse_score'][index2] == 0
                                                                                        ? Colors.redAccent
                                                                                        : snapshot.data.documents[indexDoc].data['Warehouse_score'][index2] == 1
                                                                                            ? Colors.orangeAccent
                                                                                            : Colors.green,
                                                                                    fontWeight: FontWeight.w700 
                                                                                  ),
                                                                                )
                                                                              : Text(
                                                                                  '-',
                                                                                  style: TextStyle(
                                                                                    color: Colors.black54,
                                                                                    fontWeight: FontWeight.w700 
                                                                                  ),
                                                                                )
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(left: 0.0, right: 15.0, bottom: 10.0),
                                                                    child: Container(
                                                                      width: 270.0,
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: <Widget>[
                                                                          snapshot.data.documents[indexDoc].data.containsKey('imageWarehouse')
                                                                            ? snapshot.data.documents[indexDoc].data['imageWarehouse'][index2] == null
                                                                                ? Container()
                                                                                : GestureDetector(
                                                                                    onTap: () {
                                                                                      setState(() {
                                                                                        var bantuGambarWarehouse = imageWarehouseShow[index2];
                                                                                        imageWarehouseShow.removeAt(index2);
                                                                                        imageWarehouseShow.insert(index2, !bantuGambarWarehouse);
                                                                                        noteWarehouseShow.removeAt(index2);
                                                                                        noteWarehouseShow.insert(index2, false);
                                                                                      });
                                                                                    },
                                                                                    child: Icon(Icons.image, color: AbubaPallate.menuBluebird),
                                                                                  )
                                                                            : Container(),
                                                                          snapshot.data.documents[indexDoc].data.containsKey('Warehouse_note')
                                                                            ? snapshot.data.documents[indexDoc].data['Warehouse_note'][index2] == null
                                                                                ? Container()
                                                                                : GestureDetector(
                                                                                    onTap: () {
                                                                                      setState(() {
                                                                                        var bantuNoteWarehouse = noteWarehouseShow[index2];
                                                                                        noteWarehouseShow.removeAt(index2);
                                                                                        noteWarehouseShow.insert(index2, !bantuNoteWarehouse);
                                                                                        imageWarehouseShow.removeAt(index2);
                                                                                        imageWarehouseShow.insert(index2, false);
                                                                                      });
                                                                                    },
                                                                                    child: Icon(Icons.note_add, color: AbubaPallate.menuBluebird),
                                                                                  )
                                                                            : Container(),
                                                                        ]
                                                                      ),
                                                                    )
                                                                  ),
                                                                  imageWarehouseShow[index2]
                                                                    ? snapshot.data.documents[indexDoc].data['imageWarehouse'][index2] == null
                                                                        ? Padding(
                                                                            padding: EdgeInsets.only(left: 17.0, right: 17.0, bottom: 10.0),
                                                                            child: Container(
                                                                              decoration: const BoxDecoration(
                                                                                border: Border(
                                                                                  top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                                  left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                                  right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                                  bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                                ),
                                                                              ),
                                                                              padding: EdgeInsets.all(10.0),
                                                                              child: Column(
                                                                                children: <Widget>[
                                                                                  Row(
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          'No Image',
                                                                                          style: TextStyle(
                                                                                              color: Colors.black54,
                                                                                              fontWeight: FontWeight.w700),
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          )
                                                                        : Container(
                                                                            child: GridView.count(
                                                                              padding: const EdgeInsets.only(right: 17.0, left: 17.0, bottom: 10.0),
                                                                              crossAxisCount: 2,
                                                                              childAspectRatio: 1.0,
                                                                              mainAxisSpacing: 4.0,
                                                                              crossAxisSpacing: 4.0,
                                                                              shrinkWrap: true,
                                                                              children: <Widget>[
                                                                                GridTile(
                                                                                  child: Image.network(
                                                                                    snapshot.data.documents[indexDoc].data['imageWarehouse'][index2].toString(),
                                                                                    fit: BoxFit.cover,
                                                                                  )
                                                                                ),
                                                                              ]
                                                                            ),
                                                                          )
                                                                    : Container(),
                                                                  noteWarehouseShow[index2]
                                                                    ? Padding(
                                                                        padding: EdgeInsets.only(left: 17.0, right: 17.0, bottom: 10.0),
                                                                        child: Container(
                                                                          decoration: BoxDecoration(
                                                                            border: Border(
                                                                              top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                              left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                              right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                              bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                            ),
                                                                          ),
                                                                          padding: EdgeInsets.all(10.0),
                                                                          child: Column(
                                                                            children: <Widget>[
                                                                              Row(
                                                                                children: <Widget>[
                                                                                  Flexible(
                                                                                    child: Text(
                                                                                      'Catatan',
                                                                                      style: TextStyle(
                                                                                          color: Colors.black54,
                                                                                          fontWeight: FontWeight.w700
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 5.0,
                                                                              ),
                                                                              noteWarehouseShow[index2] == null
                                                                                ? Container()
                                                                                : Row(
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          '- ${snapshot.data.documents[indexDoc].data['Warehouse_note'][index2].toString()}',
                                                                                          style: TextStyle(
                                                                                            color: Colors.black38,
                                                                                          ),
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                  )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : Container()
                                                                ],
                                                              );
                                                            }).toList(),
                                                          )
                                                        ],
                                                      )
                                                    // end warehouse
                                                    : snapshot.data.documents[indexDoc].data['subArea'][index] == 'Social Block'
                                                    ? Column(
                                                        children: <Widget>[
                                                          snapshot.data.documents[indexDoc].data.containsKey('hasilSocialBlock')
                                                            ? Container(
                                                                alignment: Alignment.centerLeft,
                                                                child: LinearPercentIndicator(
                                                                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                                                                  width: MediaQuery.of(context).size.width,
                                                                  animation: true,
                                                                  lineHeight: 30.0,
                                                                  percent: snapshot.data.documents[indexDoc].data['hasilSocialBlock'] * 100 > 100.0
                                                                      ? 1.0
                                                                      : snapshot.data.documents[indexDoc].data['hasilSocialBlock'] ,
                                                                  center: Text(snapshot.data.documents[indexDoc].data['hasilSocialBlock'] * 100 >=
                                                                      100.0
                                                                          ? '100%'
                                                                          : '${(snapshot.data.documents[indexDoc].data['hasilSocialBlock'] * 100).round().toString()}%'),
                                                                  animationDuration: 1000,
                                                                  linearStrokeCap: LinearStrokeCap.butt,
                                                                  progressColor:
                                                                  (snapshot.data.documents[indexDoc].data['hasilSocialBlock'] * 100).round() > 85.0
                                                                      ? Colors.green
                                                                      : (snapshot.data.documents[indexDoc].data['hasilSocialBlock'] * 100).round() < 70.0
                                                                          ? Colors.redAccent
                                                                          : Colors.orangeAccent,
                                                                ),
                                                              )
                                                            : Container(),
                                                          Column(
                                                            children: List.generate(snapshot.data.documents[indexDoc].data['pertanyaanSocialBlock'].length, (index2) {
                                                              return Column(
                                                                children: <Widget>[
                                                                  ListTile(
                                                                    title: Container(
                                                                      width: 270.0,
                                                                      child: Column(
                                                                        children: <Widget>[
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: <Widget>[
                                                                              Flexible(
                                                                                child: Text(
                                                                                  snapshot.data.documents[indexDoc].data['sistemSocialBlock'][index2],
                                                                                  style: TextStyle(
                                                                                    color: Colors.green,
                                                                                    fontWeight: FontWeight.w700,
                                                                                    fontSize: 14.0
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Flexible(
                                                                                child: Text(
                                                                                  snapshot.data.documents[indexDoc].data['criticalSocialBlock'][index2] == 'false'
                                                                                    ? ''
                                                                                    : 'CRITICAL',
                                                                                  style: TextStyle(
                                                                                      color: Colors.red,
                                                                                      fontWeight:
                                                                                      FontWeight.w700,
                                                                                      fontSize: 14.0),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            children: <Widget>[
                                                                              Flexible(
                                                                                child: Text(
                                                                                  '${index2 + 1}. ${snapshot.data.documents[indexDoc].data['pertanyaanSocialBlock'][index2]}',
                                                                                  style: TextStyle(
                                                                                    color: Colors.black54,
                                                                                    fontSize: 14.0
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    trailing: Container(
                                                                      width: 30.0,
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: <Widget>[
                                                                          Flexible(
                                                                            child: snapshot.data.documents[indexDoc].data.containsKey('SocialBlock_score')
                                                                              ? Text(
                                                                                  snapshot.data.documents[indexDoc].data['SocialBlock_score'][index2].toString(),
                                                                                  style: TextStyle(
                                                                                    color: snapshot.data.documents[indexDoc].data['SocialBlock_score'][index2] == 0
                                                                                        ? Colors.redAccent
                                                                                        : snapshot.data.documents[indexDoc].data['SocialBlock_score'][index2] == 1
                                                                                            ? Colors.orangeAccent
                                                                                            : Colors.green,
                                                                                    fontWeight: FontWeight.w700 
                                                                                  ),
                                                                                )
                                                                              : Text(
                                                                                  '-',
                                                                                  style: TextStyle(
                                                                                    color: Colors.black54,
                                                                                    fontWeight: FontWeight.w700 
                                                                                  ),
                                                                                )
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(left: 0.0, right: 15.0, bottom: 10.0),
                                                                    child: Container(
                                                                      width: 270.0,
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: <Widget>[
                                                                          snapshot.data.documents[indexDoc].data.containsKey('imageSocialBlock')
                                                                            ? snapshot.data.documents[indexDoc].data['imageSocialBlock'][index2] == null
                                                                                ? Container()
                                                                                : GestureDetector(
                                                                                    onTap: () {
                                                                                      setState(() {
                                                                                        var bantuGambarSocialBlock = imageSocialBlockShow[index2];
                                                                                        imageSocialBlockShow.removeAt(index2);
                                                                                        imageSocialBlockShow.insert(index2, !bantuGambarSocialBlock);
                                                                                        noteSocialBlockShow.removeAt(index2);
                                                                                        noteSocialBlockShow.insert(index2, false);
                                                                                      });
                                                                                    },
                                                                                    child: Icon(Icons.image, color: AbubaPallate.menuBluebird),
                                                                                  )
                                                                            : Container(),
                                                                          snapshot.data.documents[indexDoc].data.containsKey('SocialBlock_note')
                                                                            ? snapshot.data.documents[indexDoc].data['SocialBlock_note'][index2] == null
                                                                                ? Container()
                                                                                : GestureDetector(
                                                                                    onTap: () {
                                                                                      setState(() {
                                                                                        var bantuNoteSocialBlock = noteSocialBlockShow[index2];
                                                                                        noteSocialBlockShow.removeAt(index2);
                                                                                        noteSocialBlockShow.insert(index2, !bantuNoteSocialBlock);
                                                                                        imageSocialBlockShow.removeAt(index2);
                                                                                        imageSocialBlockShow.insert(index2, false);
                                                                                      });
                                                                                    },
                                                                                    child: Icon(Icons.note_add, color: AbubaPallate.menuBluebird),
                                                                                  )
                                                                            : Container(),
                                                                        ]
                                                                      ),
                                                                    )
                                                                  ),
                                                                  imageSocialBlockShow[index2]
                                                                    ? snapshot.data.documents[indexDoc].data['imageSocialBlock'][index2] == null
                                                                        ? Padding(
                                                                            padding: EdgeInsets.only(left: 17.0, right: 17.0, bottom: 10.0),
                                                                            child: Container(
                                                                              decoration: const BoxDecoration(
                                                                                border: Border(
                                                                                  top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                                  left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                                  right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                                  bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                                ),
                                                                              ),
                                                                              padding: EdgeInsets.all(10.0),
                                                                              child: Column(
                                                                                children: <Widget>[
                                                                                  Row(
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          'No Image',
                                                                                          style: TextStyle(
                                                                                              color: Colors.black54,
                                                                                              fontWeight: FontWeight.w700),
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          )
                                                                        : Container(
                                                                            child: GridView.count(
                                                                              padding: const EdgeInsets.only(right: 17.0, left: 17.0, bottom: 10.0),
                                                                              crossAxisCount: 2,
                                                                              childAspectRatio: 1.0,
                                                                              mainAxisSpacing: 4.0,
                                                                              crossAxisSpacing: 4.0,
                                                                              shrinkWrap: true,
                                                                              children: <Widget>[
                                                                                GridTile(
                                                                                  child: Image.network(
                                                                                    snapshot.data.documents[indexDoc].data['imageSocialBlock'][index2].toString(),
                                                                                    fit: BoxFit.cover,
                                                                                  )
                                                                                ),
                                                                              ]
                                                                            ),
                                                                          )
                                                                    : Container(),
                                                                  noteSocialBlockShow[index2]
                                                                    ? Padding(
                                                                        padding: EdgeInsets.only(left: 17.0, right: 17.0, bottom: 10.0),
                                                                        child: Container(
                                                                          decoration: BoxDecoration(
                                                                            border: Border(
                                                                              top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                              left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                              right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                              bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                            ),
                                                                          ),
                                                                          padding: EdgeInsets.all(10.0),
                                                                          child: Column(
                                                                            children: <Widget>[
                                                                              Row(
                                                                                children: <Widget>[
                                                                                  Flexible(
                                                                                    child: Text(
                                                                                      'Catatan',
                                                                                      style: TextStyle(
                                                                                          color: Colors.black54,
                                                                                          fontWeight: FontWeight.w700
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 5.0,
                                                                              ),
                                                                              noteSocialBlockShow[index2] == null
                                                                                ? Container()
                                                                                : Row(
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          '- ${snapshot.data.documents[indexDoc].data['SocialBlock_note'][index2].toString()}',
                                                                                          style: TextStyle(
                                                                                            color: Colors.black38,
                                                                                          ),
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                  )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : Container()
                                                                ],
                                                              );
                                                            }).toList(),
                                                          )
                                                        ],
                                                      )
                                                    // end Social
                                                    : snapshot.data.documents[indexDoc].data['subArea'][index] == 'Personal Hygiene'
                                                    ? Column(
                                                        children: <Widget>[
                                                          snapshot.data.documents[indexDoc].data.containsKey('hasilPersonal')
                                                            ? Container(
                                                                alignment: Alignment.centerLeft,
                                                                child: LinearPercentIndicator(
                                                                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                                                                  width: MediaQuery.of(context).size.width,
                                                                  animation: true,
                                                                  lineHeight: 30.0,
                                                                  percent: snapshot.data.documents[indexDoc].data['hasilPersonal'] * 100 > 100.0
                                                                      ? 1.0
                                                                      : snapshot.data.documents[indexDoc].data['hasilPersonal'] ,
                                                                  center: Text(snapshot.data.documents[indexDoc].data['hasilPersonal'] * 100 >=
                                                                      100.0
                                                                          ? '100%'
                                                                          : '${(snapshot.data.documents[indexDoc].data['hasilPersonal'] * 100).round().toString()}%'),
                                                                  animationDuration: 1000,
                                                                  linearStrokeCap: LinearStrokeCap.butt,
                                                                  progressColor:
                                                                  (snapshot.data.documents[indexDoc].data['hasilPersonal'] * 100).round() > 85.0
                                                                      ? Colors.green
                                                                      : (snapshot.data.documents[indexDoc].data['hasilPersonal'] * 100).round() < 70.0
                                                                          ? Colors.redAccent
                                                                          : Colors.orangeAccent,
                                                                ),
                                                              )
                                                            : Container(),
                                                          Column(
                                                            children: List.generate(snapshot.data.documents[indexDoc].data['pertanyaanPersonal'].length, (index2) {
                                                              return Column(
                                                                children: <Widget>[
                                                                  ListTile(
                                                                    title: Container(
                                                                      width: 270.0,
                                                                      child: Column(
                                                                        children: <Widget>[
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: <Widget>[
                                                                              Flexible(
                                                                                child: Text(
                                                                                  snapshot.data.documents[indexDoc].data['sistemPersonal'][index2],
                                                                                  style: TextStyle(
                                                                                    color: Colors.green,
                                                                                    fontWeight: FontWeight.w700,
                                                                                    fontSize: 14.0
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Flexible(
                                                                                child: Text(
                                                                                  snapshot.data.documents[indexDoc].data['criticalPersonal'][index2] == 'false'
                                                                                    ? ''
                                                                                    : 'CRITICAL',
                                                                                  style: TextStyle(
                                                                                      color: Colors.red,
                                                                                      fontWeight:
                                                                                      FontWeight.w700,
                                                                                      fontSize: 14.0),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            children: <Widget>[
                                                                              Flexible(
                                                                                child: Text(
                                                                                  '${index2 + 1}. ${snapshot.data.documents[indexDoc].data['pertanyaanPersonal'][index2]}',
                                                                                  style: TextStyle(
                                                                                    color: Colors.black54,
                                                                                    fontSize: 14.0
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    trailing: Container(
                                                                      width: 30.0,
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: <Widget>[
                                                                          Flexible(
                                                                            child: snapshot.data.documents[indexDoc].data.containsKey('Personal_score')
                                                                              ? Text(
                                                                                  snapshot.data.documents[indexDoc].data['Personal_score'][index2].toString(),
                                                                                  style: TextStyle(
                                                                                    color: snapshot.data.documents[indexDoc].data['Personal_score'][index2] == 0
                                                                                        ? Colors.redAccent
                                                                                        : snapshot.data.documents[indexDoc].data['Personal_score'][index2] == 1
                                                                                            ? Colors.orangeAccent
                                                                                            : Colors.green,
                                                                                    fontWeight: FontWeight.w700 
                                                                                  ),
                                                                                )
                                                                              : Text(
                                                                                  '-',
                                                                                  style: TextStyle(
                                                                                    color: Colors.black54,
                                                                                    fontWeight: FontWeight.w700 
                                                                                  ),
                                                                                )
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(left: 0.0, right: 15.0, bottom: 10.0),
                                                                    child: Container(
                                                                      width: 270.0,
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: <Widget>[
                                                                          snapshot.data.documents[indexDoc].data.containsKey('imagePersonal')
                                                                            ? snapshot.data.documents[indexDoc].data['imagePersonal'][index2] == null
                                                                                ? Container()
                                                                                : GestureDetector(
                                                                                    onTap: () {
                                                                                      setState(() {
                                                                                        var bantuGambarPersonal = imagePersonalShow[index2];
                                                                                        imagePersonalShow.removeAt(index2);
                                                                                        imagePersonalShow.insert(index2, !bantuGambarPersonal);
                                                                                        notePersonalShow.removeAt(index2);
                                                                                        notePersonalShow.insert(index2, false);
                                                                                      });
                                                                                    },
                                                                                    child: Icon(Icons.image, color: AbubaPallate.menuBluebird),
                                                                                  )
                                                                            : Container(),
                                                                          snapshot.data.documents[indexDoc].data.containsKey('Personal_note')
                                                                            ? snapshot.data.documents[indexDoc].data['Personal_note'][index2] == null
                                                                                ? Container()
                                                                                : GestureDetector(
                                                                                    onTap: () {
                                                                                      setState(() {
                                                                                        var bantuNotePersonal = notePersonalShow[index2];
                                                                                        notePersonalShow.removeAt(index2);
                                                                                        notePersonalShow.insert(index2, !bantuNotePersonal);
                                                                                        imagePersonalShow.removeAt(index2);
                                                                                        imagePersonalShow.insert(index2, false);
                                                                                      });
                                                                                    },
                                                                                    child: Icon(Icons.note_add, color: AbubaPallate.menuBluebird),
                                                                                  )
                                                                            : Container(),
                                                                        ]
                                                                      ),
                                                                    )
                                                                  ),
                                                                  imagePersonalShow[index2]
                                                                    ? snapshot.data.documents[indexDoc].data['imagePersonal'][index2] == null
                                                                        ? Padding(
                                                                            padding: EdgeInsets.only(left: 17.0, right: 17.0, bottom: 10.0),
                                                                            child: Container(
                                                                              decoration: const BoxDecoration(
                                                                                border: Border(
                                                                                  top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                                  left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                                  right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                                  bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                                ),
                                                                              ),
                                                                              padding: EdgeInsets.all(10.0),
                                                                              child: Column(
                                                                                children: <Widget>[
                                                                                  Row(
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          'No Image',
                                                                                          style: TextStyle(
                                                                                              color: Colors.black54,
                                                                                              fontWeight: FontWeight.w700),
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          )
                                                                        : Container(
                                                                            child: GridView.count(
                                                                              padding: const EdgeInsets.only(right: 17.0, left: 17.0, bottom: 10.0),
                                                                              crossAxisCount: 2,
                                                                              childAspectRatio: 1.0,
                                                                              mainAxisSpacing: 4.0,
                                                                              crossAxisSpacing: 4.0,
                                                                              shrinkWrap: true,
                                                                              children: <Widget>[
                                                                                GridTile(
                                                                                  child: Image.network(
                                                                                    snapshot.data.documents[indexDoc].data['imagePersonal'][index2].toString(),
                                                                                    fit: BoxFit.cover,
                                                                                  )
                                                                                ),
                                                                              ]
                                                                            ),
                                                                          )
                                                                    : Container(),
                                                                  notePersonalShow[index2]
                                                                    ? Padding(
                                                                        padding: EdgeInsets.only(left: 17.0, right: 17.0, bottom: 10.0),
                                                                        child: Container(
                                                                          decoration: BoxDecoration(
                                                                            border: Border(
                                                                              top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                              left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                              right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                              bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                            ),
                                                                          ),
                                                                          padding: EdgeInsets.all(10.0),
                                                                          child: Column(
                                                                            children: <Widget>[
                                                                              Row(
                                                                                children: <Widget>[
                                                                                  Flexible(
                                                                                    child: Text(
                                                                                      'Catatan',
                                                                                      style: TextStyle(
                                                                                          color: Colors.black54,
                                                                                          fontWeight: FontWeight.w700
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 5.0,
                                                                              ),
                                                                              notePersonalShow[index2] == null
                                                                                ? Container()
                                                                                : Row(
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          '- ${snapshot.data.documents[indexDoc].data['Personal_note'][index2].toString()}',
                                                                                          style: TextStyle(
                                                                                            color: Colors.black38,
                                                                                          ),
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                  )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : Container()
                                                                ],
                                                              );
                                                            }).toList(),
                                                          )
                                                        ],
                                                      )
                                                    // end personal
                                                    : snapshot.data.documents[indexDoc].data['subArea'][index] == 'Product Handling'
                                                    ? Column(
                                                        children: <Widget>[
                                                          snapshot.data.documents[indexDoc].data.containsKey('hasilFoodCooked')
                                                            ? Container(
                                                                alignment: Alignment.centerLeft,
                                                                child: LinearPercentIndicator(
                                                                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                                                                  width: MediaQuery.of(context).size.width,
                                                                  animation: true,
                                                                  lineHeight: 30.0,
                                                                  percent: snapshot.data.documents[indexDoc].data['hasilFoodCooked'] * 100 > 100.0
                                                                      ? 1.0
                                                                      : snapshot.data.documents[indexDoc].data['hasilFoodCooked'] ,
                                                                  center: Text(snapshot.data.documents[indexDoc].data['hasilFoodCooked'] * 100 >=
                                                                      100.0
                                                                          ? '100%'
                                                                          : '${(snapshot.data.documents[indexDoc].data['hasilFoodCooked'] * 100).round().toString()}%'),
                                                                  animationDuration: 1000,
                                                                  linearStrokeCap: LinearStrokeCap.butt,
                                                                  progressColor:
                                                                  (snapshot.data.documents[indexDoc].data['hasilFoodCooked'] * 100).round() > 85.0
                                                                      ? Colors.green
                                                                      : (snapshot.data.documents[indexDoc].data['hasilFoodCooked'] * 100).round() < 70.0
                                                                          ? Colors.redAccent
                                                                          : Colors.orangeAccent,
                                                                ),
                                                              )
                                                            : Container(),
                                                          Column(
                                                            children: List.generate(snapshot.data.documents[indexDoc].data['pertanyaanFoodCooked'].length, (index2) {
                                                              return Column(
                                                                children: <Widget>[
                                                                  ListTile(
                                                                    title: Container(
                                                                      width: 270.0,
                                                                      child: Column(
                                                                        children: <Widget>[
                                                                          Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: <Widget>[
                                                                              Flexible(
                                                                                child: Text(
                                                                                  snapshot.data.documents[indexDoc].data['sistemFoodCooked'][index2],
                                                                                  style: TextStyle(
                                                                                    color: Colors.green,
                                                                                    fontWeight: FontWeight.w700,
                                                                                    fontSize: 14.0
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Flexible(
                                                                                child: Text(
                                                                                  snapshot.data.documents[indexDoc].data['criticalFoodCooked'][index2] == 'false'
                                                                                    ? ''
                                                                                    : 'CRITICAL',
                                                                                  style: TextStyle(
                                                                                      color: Colors.red,
                                                                                      fontWeight:
                                                                                      FontWeight.w700,
                                                                                      fontSize: 14.0),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            children: <Widget>[
                                                                              Flexible(
                                                                                child: Text(
                                                                                  '${index2 + 1}. ${snapshot.data.documents[indexDoc].data['pertanyaanFoodCooked'][index2]}',
                                                                                  style: TextStyle(
                                                                                    color: Colors.black54,
                                                                                    fontSize: 14.0
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    trailing: Container(
                                                                      width: 30.0,
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: <Widget>[
                                                                          Flexible(
                                                                            child: snapshot.data.documents[indexDoc].data.containsKey('FoodCooked_score')
                                                                              ? Text(
                                                                                  snapshot.data.documents[indexDoc].data['FoodCooked_score'][index2].toString(),
                                                                                  style: TextStyle(
                                                                                    color: snapshot.data.documents[indexDoc].data['FoodCooked_score'][index2] == 0
                                                                                        ? Colors.redAccent
                                                                                        : snapshot.data.documents[indexDoc].data['FoodCooked_score'][index2] == 1
                                                                                            ? Colors.orangeAccent
                                                                                            : Colors.green,
                                                                                    fontWeight: FontWeight.w700 
                                                                                  ),
                                                                                )
                                                                              : Text(
                                                                                  '-',
                                                                                  style: TextStyle(
                                                                                    color: Colors.black54,
                                                                                    fontWeight: FontWeight.w700 
                                                                                  ),
                                                                                )
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(left: 0.0, right: 15.0, bottom: 10.0),
                                                                    child: Container(
                                                                      width: 270.0,
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: <Widget>[
                                                                          snapshot.data.documents[indexDoc].data.containsKey('imageFoodCooked')
                                                                            ? snapshot.data.documents[indexDoc].data['imageFoodCooked'][index2] == null
                                                                                ? Container()
                                                                                : GestureDetector(
                                                                                    onTap: () {
                                                                                      setState(() {
                                                                                        var bantuGambarFoodCooked = imageFoodCookedShow[index2];
                                                                                        imageFoodCookedShow.removeAt(index2);
                                                                                        imageFoodCookedShow.insert(index2, !bantuGambarFoodCooked);
                                                                                        noteFoodCookedShow.removeAt(index2);
                                                                                        noteFoodCookedShow.insert(index2, false);
                                                                                      });
                                                                                    },
                                                                                    child: Icon(Icons.image, color: AbubaPallate.menuBluebird),
                                                                                  )
                                                                            : Container(),
                                                                          snapshot.data.documents[indexDoc].data.containsKey('FoodCooked_note')
                                                                            ? snapshot.data.documents[indexDoc].data['FoodCooked_note'][index2] == null
                                                                                ? Container()
                                                                                : GestureDetector(
                                                                                    onTap: () {
                                                                                      setState(() {
                                                                                        var bantuNoteFoodCooked = noteFoodCookedShow[index2];
                                                                                        noteFoodCookedShow.removeAt(index2);
                                                                                        noteFoodCookedShow.insert(index2, !bantuNoteFoodCooked);
                                                                                        imageFoodCookedShow.removeAt(index2);
                                                                                        imageFoodCookedShow.insert(index2, false);
                                                                                      });
                                                                                    },
                                                                                    child: Icon(Icons.note_add, color: AbubaPallate.menuBluebird),
                                                                                  )
                                                                            : Container(),
                                                                        ]
                                                                      ),
                                                                    )
                                                                  ),
                                                                  imageFoodCookedShow[index2]
                                                                    ? snapshot.data.documents[indexDoc].data['imageFoodCooked'][index2] == null
                                                                        ? Padding(
                                                                            padding: EdgeInsets.only(left: 17.0, right: 17.0, bottom: 10.0),
                                                                            child: Container(
                                                                              decoration: const BoxDecoration(
                                                                                border: Border(
                                                                                  top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                                  left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                                  right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                                  bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                                ),
                                                                              ),
                                                                              padding: EdgeInsets.all(10.0),
                                                                              child: Column(
                                                                                children: <Widget>[
                                                                                  Row(
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          'No Image',
                                                                                          style: TextStyle(
                                                                                              color: Colors.black54,
                                                                                              fontWeight: FontWeight.w700),
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          )
                                                                        : Container(
                                                                            child: GridView.count(
                                                                              padding: const EdgeInsets.only(right: 17.0, left: 17.0, bottom: 10.0),
                                                                              crossAxisCount: 2,
                                                                              childAspectRatio: 1.0,
                                                                              mainAxisSpacing: 4.0,
                                                                              crossAxisSpacing: 4.0,
                                                                              shrinkWrap: true,
                                                                              children: <Widget>[
                                                                                GridTile(
                                                                                  child: Image.network(
                                                                                    snapshot.data.documents[indexDoc].data['imageFoodCooked'][index2].toString(),
                                                                                    fit: BoxFit.cover,
                                                                                  )
                                                                                ),
                                                                              ]
                                                                            ),
                                                                          )
                                                                    : Container(),
                                                                  noteFoodCookedShow[index2]
                                                                    ? Padding(
                                                                        padding: EdgeInsets.only(left: 17.0, right: 17.0, bottom: 10.0),
                                                                        child: Container(
                                                                          decoration: BoxDecoration(
                                                                            border: Border(
                                                                              top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                              left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                              right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                              bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                            ),
                                                                          ),
                                                                          padding: EdgeInsets.all(10.0),
                                                                          child: Column(
                                                                            children: <Widget>[
                                                                              Row(
                                                                                children: <Widget>[
                                                                                  Flexible(
                                                                                    child: Text(
                                                                                      'Catatan',
                                                                                      style: TextStyle(
                                                                                          color: Colors.black54,
                                                                                          fontWeight: FontWeight.w700
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: 5.0,
                                                                              ),
                                                                              noteFoodCookedShow[index2] == null
                                                                                ? Container()
                                                                                : Row(
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          '- ${snapshot.data.documents[indexDoc].data['FoodCooked_note'][index2].toString()}',
                                                                                          style: TextStyle(
                                                                                            color: Colors.black38,
                                                                                          ),
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                  )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : Container()
                                                                ],
                                                              );
                                                            }).toList(),
                                                          )
                                                        ],
                                                      )
                                                    : Container()
                                              ],
                                            );
                                          }).toList()
                                        );
                                      } else {
                                        return Container();
                                      }
                                    }).toList()
                                  );
                                },
                              ),
                            )
                          ],
                        );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CheckOutDialog extends StatefulWidget {
  final String statusLogin;
  var index;
  final int idUser;
  final String departmentUser;
  final String namaUser;

  CheckOutDialog({this.departmentUser, this.idUser, this.index, this.namaUser, this.statusLogin});

  @override
  _CheckOutDialogState createState() => _CheckOutDialogState();
}

class _CheckOutDialogState extends State<CheckOutDialog> with TickerProviderStateMixin {
  bool isProcess = false;
  int nilaiCP = 0;
  double finalBantu = 0;
  double hasilGrafik = 0;
  String response;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: null,
      content: Text("Check out audit ?"),
      actions: <Widget>[  
        FlatButton(
          child: Text(
            'NO',
            style: TextStyle(
              color: Colors.grey
            ),
          ),
          onPressed: () {
            setState(() {
              isProcess = false; 
            });
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: isProcess
            ? SizedBox(
                width: 15.0,
                height: 15.0,
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                ),
              )
            : Text(
                'YES',
                style: TextStyle(
                  color: AbubaPallate.greenabuba
                ),
              ),
          onPressed: () async {
            setState(() {
              isProcess = true; 
            });
            if (widget.statusLogin == 'Auditee') {
              var pesertaHadir = [];
              var pesertaStatus = [];
              Firestore.instance.collection('audit_internal').document(widget.index).snapshots().listen((data10) {
                if (mounted) {
                  setState(() {
                    pesertaHadir = List<dynamic>.from(data10.data['pesertaHadir']);
                    pesertaStatus = List<dynamic>.from(data10.data['pesertaStatus']);

                    pesertaStatus[pesertaHadir.indexWhere((dynamic test) => int.tryParse(test.toString()) == widget.idUser)] = 'DONE';
                  });
                  if (data10.data.containsKey('hasilAreaLuar') && data10.data.containsKey('hasilBoh') && data10.data.containsKey('hasilCashier') && data10.data.containsKey('hasilCashierAccuracy') && data10.data.containsKey('hasilDinningArea') && data10.data.containsKey('hasilFoodCooked') && data10.data.containsKey('hasilPersonal') && data10.data.containsKey('hasilService') && data10.data.containsKey('hasilSocialBlock') && data10.data.containsKey('hasilWarehouse') && data10.data.containsKey('total_cp')) {
                    setState(() {
                      if (data10.data['total_cp'] >= 1 && data10.data['total_cp'] <= 5) {
                        nilaiCP = 2;
                      } else if (data10.data['total_cp'] >= 6 && data10.data['total_cp'] <= 11) {
                        nilaiCP = 4;
                      } else if (data10.data['total_cp'] >= 12 && data10.data['total_cp'] <= 20) {
                        nilaiCP = 8;
                      }

                      finalBantu = data10.data['hasilAreaLuar'] + data10.data['hasilBoh'] + data10.data['hasilCashier'] + data10.data['hasilCashierAccuracy'] + data10.data['hasilDinningArea'] + data10.data['hasilFoodCooked'] + data10.data['hasilPersonal'] + data10.data['hasilService'] + data10.data['hasilSocialBlock'] + data10.data['hasilWarehouse'];

                      hasilGrafik = finalBantu - (finalBantu * nilaiCP / 100);
                      response = 'done';
                    });

                    print(hasilGrafik * 10.0);
                  } else {
                    Navigator.pop(context);
                    setState(() {
                      isProcess = false;
                      response = 'not';
                    });
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => AlertDialog(
                        title: null,
                        content: Text('Data belum lengkap'),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'OK',
                              style: TextStyle(
                                color: Colors.grey
                              ),
                            ),
                          )
                        ],
                      )
                    );
                  }
                }
              });

              await new Future.delayed(Duration(
                seconds: 3
              ));
              if (response == 'done') {
                DocumentReference docReference = Firestore.instance.collection('audit_internal').document(widget.index);

                docReference.updateData({
                  'auditeeCheckOut': DateTime.now(),
                  'auditeeStatus': 'DONE',
                  'auditEnd': DateTime.now(),
                  'status': 'DONE',
                  'pesertaStatus': pesertaStatus,
                  'hasilGrafik': hasilGrafik
                }).then((doc) {
                  setState(() {
                    isProcess = false;
                  });
                  Navigator.pop(context);
                  Navigator.pushReplacement(context,
                    MaterialPageRoute(
                      builder: (_) => StartAudit(departmentUser: widget.departmentUser, idUser: widget.idUser, namaUser: widget.namaUser)
                    )
                  );
                }).catchError((error) {
                  print(error);
                });
              }
            } else {
              var pesertaHadir = [];
              var pesertaStatus = [];
              Firestore.instance.collection('audit_internal').document(widget.index).snapshots().listen((data10) {
                if (mounted) {
                  setState(() {
                    pesertaHadir = List<dynamic>.from(data10.data['pesertaHadir']);
                    pesertaStatus = List<dynamic>.from(data10.data['pesertaStatus']);

                    pesertaStatus[pesertaHadir.indexWhere((dynamic test) => int.tryParse(test.toString()) == widget.idUser)] = 'DONE';
                  });
                }
              });

              await new Future.delayed(Duration(
                seconds: 3
              ));

              DocumentReference docReference = Firestore.instance.collection('audit_internal').document(widget.index);

              docReference.updateData({
                'leadAuditorCheckOut': DateTime.now(),
                'leadAuditorStatus': 'DONE',
                'pesertaStatus': pesertaStatus
              }).then((doc) {
                setState(() {
                  isProcess = false;
                });
                Navigator.pushReplacement(context,
                  MaterialPageRoute(
                    builder: (_) => StartAudit(departmentUser: widget.departmentUser, idUser: widget.idUser, namaUser: widget.namaUser)
                  )
                );
              }).catchError((error) {
                print(error);
              });
            }
          },
        ),
      ],
    );
  }
}