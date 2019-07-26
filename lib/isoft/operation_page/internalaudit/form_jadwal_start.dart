import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/isoft/operation_page/internalaudit/beranda_audit.dart';
import 'package:flutter_abuba/isoft/operation_page/internalaudit/form_audit.dart';
import 'package:flutter_abuba/isoft/operation_page/internalaudit/form_audit_auditee.dart';

class StartAudit extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;

  StartAudit({this.idUser, this.departmentUser, this.namaUser});
  
  @override
  _StartAuditState createState() => _StartAuditState();
}

class _StartAuditState extends State<StartAudit> with TickerProviderStateMixin {
  AnimationController animationController;
  DateTime now = DateTime.now();

  List<String> department = [];
  List<String> object = [];
  List<Timestamp> tanggal = [];
  List<int> auditee = [];
  List<List<dynamic>> auditor = [];
  List<int> leadAuditor = [];
  List<Timestamp> auditEnd = [];
  List<bool> showDetail = [];
  List<List<dynamic>> subArea = [];
  List<String> auditeeName = [];
  List<String> leadAuditorName = [];

  List<dynamic> auditorName = [];
  int indexShowDetail = 0;
  List<List<dynamic>> auditorConfirm = [];
  List<List<dynamic>> auditorConfirmStatus = [];
  List<String> auditeeConfirm = [];
  List<String> auditeeStatus = [];
  List<String> leadAuditorConfirm = [];
  List<String> leadAuditorStatus = [];
  var indexx = [];

  bool isProcess = false;
  List<String> statusIA = [];
  List<dynamic> auditStart = [];
  List<bool> checkIn = [];
  List<List<dynamic>> pesertaHadirArray = [];
  List<List<dynamic>> bab = [];
  List<List<dynamic>> pesertaStatusArray = [];
  List<dynamic> leadAuditorCheckin = [];
  List<dynamic> auditeeCheckin = [];

  // batas
  List<dynamic> criticalAreaLuar = [];
  List<dynamic> systemAreaLuar = [];
  List<dynamic> pertanyaanAreaLuar = [];
  double bobotAreaLuar = 0;
  List<dynamic> bobotPertanyaanAreaLuar = [];

  List<dynamic> criticalDinningArea = [];
  List<dynamic> systemDinningArea = [];
  List<dynamic> pertanyaanDinningArea = [];
  double bobotDinningArea = 0;
  List<dynamic> bobotPertanyaanDinningArea = [];

  List<dynamic> criticalService = [];
  List<dynamic> systemService = [];
  List<dynamic> pertanyaanService = [];
  double bobotService = 0;
  List<dynamic> bobotPertanyaanService = [];

  List<dynamic> criticalCashier = [];
  List<dynamic> systemCashier = [];
  List<dynamic> pertanyaanCashier = [];
  double bobotCashier = 0;
  List<dynamic> bobotPertanyaanCashier = [];

  List<dynamic> criticalCashierAccuracy = [];
  List<dynamic> systemCashierAccuracy = [];
  List<dynamic> pertanyaanCashierAccuracy = [];
  double bobotCashierAccuracy = 0;
  List<dynamic> bobotPertanyaanCashierAccuracy = [];
  List<dynamic> templateCount = [];

  List<dynamic> criticalBoh = [];
  List<dynamic> systemBoh = [];
  List<dynamic> pertanyaanBoh = [];
  double bobotBoh = 0;
  List<dynamic> bobotPertanyaanBoh = [];

  List<dynamic> criticalWarehouse = [];
  List<dynamic> systemWarehouse = [];
  List<dynamic> pertanyaanWarehouse = [];
  double bobotWarehouse = 0;
  List<dynamic> bobotPertanyaanWarehouse = [];

  List<dynamic> criticalSocialBlock = [];
  List<dynamic> systemSocialBlock = [];
  List<dynamic> pertanyaanSocialBlock = [];
  double bobotSocialBlock = 0;
  List<dynamic> bobotPertanyaanSocialBlock = [];
  
  List<dynamic> criticalPersonal = [];
  List<dynamic> systemPersonal = [];
  List<dynamic> pertanyaanPersonal = [];
  double bobotPersonal = 0;
  List<dynamic> bobotPertanyaanPersonal = [];

  List<dynamic> criticalFoodCooked = [];
  List<dynamic> systemFoodCooked = [];
  List<dynamic> pertanyaanFoodCooked = [];
  double bobotFoodCooked = 0;
  List<dynamic> bobotPertanyaanFoodCooked = [];

  final FocusNode _persediaanFocus = FocusNode();
  final FocusNode _saldoAwalFocus = FocusNode();
  final FocusNode _penambahanFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    CollectionReference reference = Firestore.instance.collection('audit_internal');
    reference.snapshots().listen((querySnapshot) {
      querySnapshot.documentChanges.forEach((change) {
        setState(() {
          tanggal.add(change.document.data['dateAudit']);
          auditee.add(change.document.data['auditee']);
          leadAuditor.add(change.document.data['leadAuditor']);
          auditor.add(change.document.data['subAreaAuditor']);
          auditEnd.add(change.document.data['auditEnd']);
          showDetail.add(false);
          subArea.add(change.document.data['subArea']);
          auditorConfirm.add(change.document.data['auditorConfirm']);
          auditorConfirmStatus.add(change.document.data['auditorConfirm']);
          auditeeConfirm.add(change.document.data['auditeeConfirm'].toString());
          leadAuditorConfirm.add(change.document.data['leadAuditorConfirm'].toString());
          indexx.add(change.document.documentID);
          auditStart.add(change.document.data['auditStart']);
          statusIA.add(change.document.data['status']);
          checkIn.add(false);
          pesertaHadirArray.add(change.document.data['pesertaHadir']);
          pesertaStatusArray.add(change.document.data['pesertaStatus']);
          bab.add([]);
          leadAuditorCheckin.add(change.document.data['leadAuditorCheckIn']);
          leadAuditorStatus.add(change.document.data['leadAuditorStatus']);
          auditeeCheckin.add(change.document.data['auditeeCheckIn']);
          auditeeStatus.add(change.document.data['auditeeStatus']);

          Firestore.instance.collection('department').where('id', isEqualTo: change.document.data['department']).snapshots().listen((data3) {
            department.add(data3.documents[0].data['name']);
          });

          Firestore.instance.collection('user').where('id', isEqualTo: change.document.data['auditee']).snapshots().listen((data5) {
            auditeeName.add(data5.documents[0].data['nama']);
          });

          Firestore.instance.collection('user').where('id', isEqualTo: change.document.data['leadAuditor']).snapshots().listen((data6) {
            leadAuditorName.add(data6.documents[0].data['nama']);
          });

          Firestore.instance.collection('audit_object').where('id', isEqualTo: change.document.data['object']).snapshots().listen((data4) {
            object.add(data4.documents[0].data['object']);
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
  void dispose() {
    super.dispose();
  }

  Future<bool> onWillPop(context) {
    Navigator.pushReplacement(context,
      MaterialPageRoute(
        builder: (_) => MenuAudit(departmentUser: widget.departmentUser, idUser: widget.idUser, namaUser: widget.namaUser)
      )
    );
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          onWillPop(context);
        },
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            elevation: 0.25,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacement(context,
                  MaterialPageRoute(
                    builder: (_) => MenuAudit(idUser: widget.idUser, departmentUser: widget.departmentUser, namaUser: widget.namaUser)
                  )
                );
              },
            ),
            title: Image.asset(
              'assets/images/logo2.png',
              height: 150.0,
              width: 120.0,
            ),
            actions: <Widget>[
              // RaisedButton(
              //   onPressed: () => _showModalSheet(context),
              //   child: const Text('Show Modal Bottom Sheet')
              // ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: IconButton(
                  icon: Icon(Icons.refresh, color: Colors.black54),
                  tooltip: 'Resfresh',
                  onPressed: () {
                    Navigator.pushReplacement(context,
                      MaterialPageRoute(
                        builder: (_) => StartAudit(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)
                      )
                    );
                  },
                ),
              )
            ],
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
                        Container(
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
                                children: List.generate(snapshot.data.documents.length, (index) {
                                  Timestamp tanggalAudit = snapshot.data.documents[index].data['dateAudit'];
                                  String status = '';
                                  String buttonText = '';
                                  if (snapshot.data.documents[index].data['auditee'] == widget.idUser) {
                                    status = 'AUDITEE';
                                  } else if (snapshot.data.documents[index].data['leadAuditor'] == widget.idUser) {
                                    // if (snapshot.data.documents[index].data['subAreaAuditor'].contains(widget.idUser.toString())) {
                                      // status = 'AUDITOR';
                                    // } else {
                                      status = 'LEAD AUDITOR';
                                    // }
                                  } else if (snapshot.data.documents[index].data['subAreaAuditor'].contains(widget.idUser.toString())) {
                                    status = 'AUDITOR';
                                  } else {
                                    status = '-';
                                  }

                                  var lengthBantu = snapshot.data.documents[index].data['auditorConfirm'].where((result) => result != 'CONFIRM');
                                  if (lengthBantu.length > 0 || snapshot.data.documents[index].data['leadAuditorConfirm'] != 'CONFIRM' || snapshot.data.documents[index].data['auditeeConfirm'] != 'CONFIRM') {
                                    buttonText = 'UNREADY';
                                  } else {
                                    buttonText = 'CHECK IN';
                                  }
                                  if (snapshot.data.documents[index].data['auditee'] == widget.idUser || snapshot.data.documents[index].data['leadAuditor'] == widget.idUser || snapshot.data.documents[index].data['subAreaAuditor'].contains(widget.idUser.toString())) {
                                    if (snapshot.data.documents[index].data['auditEnd'] == null) {
                                      return Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              verticalDirection: VerticalDirection.down,
                                              children: <Widget>[
                                                Container(
                                                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                                                  color: Colors.transparent,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(30.0),
                                                      border: Border.all(
                                                        width: 1.0,
                                                        color: Colors.black12
                                                      )
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.all(25.0),
                                                      child: Column(
                                                        children: <Widget>[
                                                          Padding(
                                                            padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: <Widget>[
                                                                Flexible(
                                                                  child: Text(
                                                                    tanggalAudit == null ? '-' : tanggalAudit.toDate().toString().substring(8, 10) + '/' + tanggalAudit.toDate().toString().substring(5, 7) + '/' +tanggalAudit.toDate().toString().substring(0, 4),
                                                                    style: TextStyle(
                                                                      fontSize: 15.0,
                                                                      fontWeight: FontWeight.w400,
                                                                      color: Colors.black45
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 20.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: <Widget>[
                                                                Flexible(
                                                                  child: Text(
                                                                    object[index] == null ? '-' : object[index],
                                                                    style: TextStyle(
                                                                      fontSize: 20.0,
                                                                      fontWeight: FontWeight.w700,
                                                                      color: AbubaPallate.greenabuba
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: <Widget>[
                                                              Flexible(
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: <Widget>[
                                                                      Flexible(
                                                                        child: Text(
                                                                          department[index] == null ? '-' : department[index],
                                                                          style: TextStyle(
                                                                            fontSize: 15.0,
                                                                            fontWeight: FontWeight.w800,
                                                                            color: Colors.black45,
                                                                            letterSpacing: 1.0
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              Flexible(
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                    children: <Widget>[
                                                                      Flexible(
                                                                        child: Text(
                                                                          status,
                                                                          style: TextStyle(
                                                                            fontSize: 15.0,
                                                                            fontWeight: FontWeight.w800,
                                                                            color: tanggalAudit.toDate().toString().substring(8, 10) + '/' + tanggalAudit.toDate().toString().substring(5, 7) + '/' +tanggalAudit.toDate().toString().substring(0, 4) == DateTime.now().toString().substring(8, 10) + '/' + DateTime.now().toString().substring(5, 7) + '/' +DateTime.now().toString().substring(0, 4) || tanggalAudit.toDate().isBefore(DateTime.now()) ? AbubaPallate.menuBluebird : Colors.grey,
                                                                            letterSpacing: 1.0
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: <Widget>[
                                                              showDetail[index]
                                                                ? ButtonTheme(
                                                                    minWidth: MediaQuery.of(context).size.width * 0.35,
                                                                    height: 30.0,
                                                                    child: OutlineButton(
                                                                      child: Row(
                                                                        children: <Widget>[
                                                                          Container(
                                                                            width: MediaQuery.of(context).size.width * 0.15,
                                                                            alignment: Alignment.centerLeft,
                                                                            child: Text(
                                                                              'CLOSE',
                                                                              style: TextStyle(
                                                                                fontSize: 13.0,
                                                                                color: AbubaPallate.menuBluebird,
                                                                                fontWeight: FontWeight.bold
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            width: MediaQuery.of(context).size.width * 0.15,
                                                                            alignment: Alignment.centerRight,
                                                                            child: Icon(Icons.visibility, color: AbubaPallate.menuBluebird, size: 18.0),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 2.0),
                                                                      highlightedBorderColor: AbubaPallate.menuBluebird,
                                                                      splashColor: Colors.white,
                                                                      onPressed: () {
                                                                        setState(() {
                                                                          auditorName.clear();
                                                                          showDetail[index] = false;
                                                                        });
                                                                      },
                                                                    ),
                                                                  )
                                                                : ButtonTheme(
                                                                    minWidth: MediaQuery.of(context).size.width * 0.35,
                                                                    height: 30.0,
                                                                    child: OutlineButton(
                                                                      child: Row(
                                                                        children: <Widget>[
                                                                          Container(
                                                                            width: MediaQuery.of(context).size.width * 0.15,
                                                                            alignment: Alignment.centerLeft,
                                                                            child: Text(
                                                                              'VIEW',
                                                                              style: TextStyle(
                                                                                fontSize: 13.0,
                                                                                color: tanggalAudit.toDate().toString().substring(8, 10) + '/' + tanggalAudit.toDate().toString().substring(5, 7) + '/' +tanggalAudit.toDate().toString().substring(0, 4) == DateTime.now().toString().substring(8, 10) + '/' + DateTime.now().toString().substring(5, 7) + '/' +DateTime.now().toString().substring(0, 4) || tanggalAudit.toDate().isBefore(DateTime.now()) ? AbubaPallate.menuBluebird : Colors.grey,
                                                                                fontWeight: FontWeight.bold
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            width: MediaQuery.of(context).size.width * 0.15,
                                                                            alignment: Alignment.centerRight,
                                                                            child: Icon(Icons.visibility, color: tanggalAudit.toDate().toString().substring(8, 10) + '/' + tanggalAudit.toDate().toString().substring(5, 7) + '/' +tanggalAudit.toDate().toString().substring(0, 4) == DateTime.now().toString().substring(8, 10) + '/' + DateTime.now().toString().substring(5, 7) + '/' +DateTime.now().toString().substring(0, 4) || tanggalAudit.toDate().isBefore(DateTime.now()) ? AbubaPallate.menuBluebird : Colors.grey, size: 18.0),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      borderSide: BorderSide(color: tanggalAudit.toDate().toString().substring(8, 10) + '/' + tanggalAudit.toDate().toString().substring(5, 7) + '/' +tanggalAudit.toDate().toString().substring(0, 4) == DateTime.now().toString().substring(8, 10) + '/' + DateTime.now().toString().substring(5, 7) + '/' +DateTime.now().toString().substring(0, 4) || tanggalAudit.toDate().isBefore(DateTime.now()) ? AbubaPallate.menuBluebird : Colors.grey, width: 2.0),

                                                                      highlightedBorderColor: tanggalAudit.toDate().toString().substring(8, 10) + '/' + tanggalAudit.toDate().toString().substring(5, 7) + '/' +tanggalAudit.toDate().toString().substring(0, 4) == DateTime.now().toString().substring(8, 10) + '/' + DateTime.now().toString().substring(5, 7) + '/' +DateTime.now().toString().substring(0, 4) || tanggalAudit.toDate().isBefore(DateTime.now()) ? AbubaPallate.menuBluebird : Colors.grey,

                                                                      splashColor: tanggalAudit.toDate().toString().substring(8, 10) + '/' + tanggalAudit.toDate().toString().substring(5, 7) + '/' +tanggalAudit.toDate().toString().substring(0, 4) == DateTime.now().toString().substring(8, 10) + '/' + DateTime.now().toString().substring(5, 7) + '/' +DateTime.now().toString().substring(0, 4) || tanggalAudit.toDate().isBefore(DateTime.now()) ? AbubaPallate.menuBluebird : Colors.grey,

                                                                      onPressed: () {
                                                                        showDialog(
                                                                          barrierDismissible: false,
                                                                          context: context,
                                                                          builder: (BuildContext context) {
                                                                            return DialogView(
                                                                              auditor: snapshot.data.documents[index].data['subAreaAuditor'],
                                                                              indexx: snapshot.data.documents[index].documentID,
                                                                            );
                                                                          }
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                              SizedBox(
                                                                width: 5.0,
                                                              ),
                                                              // mulai check in button
                                                              tanggalAudit.toDate().toString().substring(8, 10) + '/' + tanggalAudit.toDate().toString().substring(5, 7) + '/' +tanggalAudit.toDate().toString().substring(0, 4) == DateTime.now().toString().substring(8, 10) + '/' + DateTime.now().toString().substring(5, 7) + '/' +DateTime.now().toString().substring(0, 4) || tanggalAudit.toDate().isBefore(DateTime(now.year, now.month, now.day))
                                                                ? status == 'AUDITEE'
                                                                  ? snapshot.data.documents[index].data['auditeeCheckIn'] == null
                                                                      ? ButtonTheme(
                                                                          minWidth: MediaQuery.of(context).size.width * 0.35,
                                                                          height: 30.0,
                                                                          child: RaisedButton(
                                                                            child: checkIn[index]
                                                                              ? SizedBox(
                                                                                  child: CircularProgressIndicator(
                                                                                    valueColor: AlwaysStoppedAnimation(Colors.white),
                                                                                    strokeWidth: 2.0
                                                                                  ),
                                                                                  height: 20.0,
                                                                                  width: 20.0
                                                                                )
                                                                              : Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                  children: <Widget>[
                                                                                    Container(
                                                                                      width: MediaQuery.of(context).size.width * 0.25,
                                                                                      alignment: Alignment.centerLeft,
                                                                                      child: Text(
                                                                                        buttonText,
                                                                                        style: TextStyle(
                                                                                          fontSize: 13.0,
                                                                                          color: Colors.white,
                                                                                          fontWeight: FontWeight.bold
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                            elevation: 0.0,
                                                                            color: buttonText == 'UNREADY' ? Colors.grey : tanggalAudit.toDate().isBefore(DateTime(now.year, now.month, now.day)) == false ? AbubaPallate.greenabuba : Colors.orangeAccent,
                                                                            splashColor: buttonText == 'UNREADY' ? Colors.grey : tanggalAudit.toDate().isBefore(DateTime(now.year, now.month, now.day)) == false ? AbubaPallate.greenabuba : Colors.orangeAccent,
                                                                            onPressed: () async {
                                                                              if (buttonText == 'UNREADY') {
                                                                                print('UNREADY');
                                                                              } else {
                                                                                setState(() {
                                                                                  checkIn[index] = !checkIn[index];
                                                                                });

                                                                                var pesertaHadir = [];
                                                                                var pesertaStatus = [];

                                                                                Firestore.instance.collection('audit_internal').document(snapshot.data.documents[index].documentID).snapshots().listen((data10) {
                                                                                  if (mounted) {
                                                                                    setState(() {
                                                                                      pesertaHadir = List<dynamic>.from(data10.data['pesertaHadir']);

                                                                                      if (pesertaHadir.contains(widget.idUser)) {

                                                                                      } else {
                                                                                        pesertaStatus.add('OPEN');
                                                                                        pesertaHadir.add(widget.idUser);
                                                                                      }
                                                                                    });
                                                                                  }
                                                                                });

                                                                                await new Future.delayed(Duration(
                                                                                  seconds: 3
                                                                                ));

                                                                                // taro sini dong
                                                                                setState(() {
                                                                                  Firestore.instance.collection('area_luar').snapshots().listen((data) {
                                                                                    criticalAreaLuar = data.documents[0].data['critical_point'];
                                                                                    systemAreaLuar = data.documents[0].data['integrated_system'];
                                                                                    pertanyaanAreaLuar = data.documents[0].data['pertanyaan'];
                                                                                    bobotAreaLuar = double.tryParse(data.documents[0].data['bobot'].toString());
                                                                                    bobotPertanyaanAreaLuar = data.documents[0].data['bobot_pertanyaan'];
                                                                                  });

                                                                                  Firestore.instance.collection('dinning_area').snapshots().listen((data) {
                                                                                    criticalDinningArea = data.documents[0].data['critical_point'];
                                                                                    systemDinningArea = data.documents[0].data['integrated_system'];
                                                                                    pertanyaanDinningArea = data.documents[0].data['pertanyaan'];
                                                                                    bobotDinningArea = double.tryParse(data.documents[0].data['bobot'].toString());
                                                                                    bobotPertanyaanDinningArea = data.documents[0].data['bobot_pertanyaan'];
                                                                                  });

                                                                                  Firestore.instance.collection('service').snapshots().listen((data) {
                                                                                    criticalService = data.documents[0].data['critical_point'];
                                                                                    systemService = data.documents[0].data['integrated_system'];
                                                                                    pertanyaanService = data.documents[0].data['pertanyaan'];
                                                                                    bobotService = double.tryParse(data.documents[0].data['bobot'].toString());
                                                                                    bobotPertanyaanService = data.documents[0].data['bobot_pertanyaan'];
                                                                                  });

                                                                                  Firestore.instance.collection('cashier').snapshots().listen((data) {
                                                                                    criticalCashier = data.documents[0].data['critical_point'];
                                                                                    systemCashier = data.documents[0].data['integrated_system'];
                                                                                    pertanyaanCashier = data.documents[0].data['pertanyaan'];
                                                                                    bobotCashier = double.tryParse(data.documents[0].data['bobot'].toString());
                                                                                    bobotPertanyaanCashier = data.documents[0].data['bobot_pertanyaan'];
                                                                                  });

                                                                                  Firestore.instance.collection('cashier_accuracy').snapshots().listen((data) {
                                                                                    criticalCashierAccuracy = data.documents[0].data['critical_point'];
                                                                                    systemCashierAccuracy = data.documents[0].data['integrated_system'];
                                                                                    pertanyaanCashierAccuracy = data.documents[0].data['pertanyaan'];
                                                                                    bobotCashierAccuracy = double.tryParse(data.documents[0].data['bobot'].toString());
                                                                                    bobotPertanyaanCashierAccuracy = data.documents[0].data['bobot_pertanyaan'];
                                                                                    templateCount = data.documents[0].data['templateCount'];
                                                                                  });

                                                                                  Firestore.instance.collection('boh').snapshots().listen((data) {
                                                                                    criticalBoh = data.documents[0].data['critical_point'];
                                                                                    systemBoh = data.documents[0].data['integrated_system'];
                                                                                    pertanyaanBoh = data.documents[0].data['pertanyaan'];
                                                                                    bobotBoh = double.tryParse(data.documents[0].data['bobot'].toString());
                                                                                    bobotPertanyaanBoh = data.documents[0].data['bobot_pertanyaan'];
                                                                                  });

                                                                                  Firestore.instance.collection('warehouse').snapshots().listen((data) {
                                                                                    criticalWarehouse = data.documents[0].data['critical_point'];
                                                                                    systemWarehouse = data.documents[0].data['integrated_system'];
                                                                                    pertanyaanWarehouse = data.documents[0].data['pertanyaan'];
                                                                                    bobotWarehouse = double.tryParse(data.documents[0].data['bobot'].toString());
                                                                                    bobotPertanyaanWarehouse = data.documents[0].data['bobot_pertanyaan'];
                                                                                  });

                                                                                  Firestore.instance.collection('social_block').snapshots().listen((data) {
                                                                                    criticalSocialBlock = data.documents[0].data['critical_point'];
                                                                                    systemSocialBlock = data.documents[0].data['integrated_system'];
                                                                                    pertanyaanSocialBlock = data.documents[0].data['pertanyaan'];
                                                                                    bobotSocialBlock = double.tryParse(data.documents[0].data['bobot'].toString());
                                                                                    bobotPertanyaanSocialBlock = data.documents[0].data['bobot_pertanyaan'];
                                                                                  });

                                                                                  Firestore.instance.collection('personal_hygiene').snapshots().listen((data) {
                                                                                    criticalPersonal = data.documents[0].data['critical_point'];
                                                                                    systemPersonal = data.documents[0].data['integrated_system'];
                                                                                    pertanyaanPersonal = data.documents[0].data['pertanyaan'];
                                                                                    bobotPersonal = double.tryParse(data.documents[0].data['bobot'].toString());
                                                                                    bobotPertanyaanPersonal = data.documents[0].data['bobot_pertanyaan'];
                                                                                  });

                                                                                  Firestore.instance.collection('food_cooked').snapshots().listen((data) {
                                                                                    criticalFoodCooked = data.documents[0].data['critical_point'];
                                                                                    systemFoodCooked = data.documents[0].data['integrated_system'];
                                                                                    pertanyaanFoodCooked = data.documents[0].data['pertanyaan'];
                                                                                    bobotFoodCooked = double.tryParse(data.documents[0].data['bobot'].toString());
                                                                                    bobotPertanyaanFoodCooked = data.documents[0].data['bobot_pertanyaan'];
                                                                                  });
                                                                                });
                                                                                // end taro sini dong

                                                                                await new Future.delayed(Duration(
                                                                                  seconds: 3
                                                                                ));

                                                                                DocumentReference docReference = Firestore.instance.collection('audit_internal').document(snapshot.data.documents[index].documentID);

                                                                                docReference.updateData({
                                                                                  'templateCount': templateCount,
                                                                                  'bobot_AreaLuar': bobotAreaLuar,
                                                                                  'bobot_DinningArea': bobotDinningArea,
                                                                                  'bobot_Service': bobotService,
                                                                                  'bobot_Cashier': bobotCashier,
                                                                                  'bobot_CashierAccuracy': bobotCashierAccuracy,
                                                                                  'bobot_Boh': bobotBoh,
                                                                                  'bobot_Warehouse': bobotWarehouse,
                                                                                  'bobot_SocialBlock': bobotSocialBlock,
                                                                                  'bobot_Personal': bobotPersonal,
                                                                                  'bobot_FoodCooked': bobotFoodCooked,
                                                                                  'bobotPertanyaan_AreaLuar': bobotPertanyaanAreaLuar,
                                                                                  'bobotPertanyaan_DinningArea': bobotPertanyaanDinningArea,
                                                                                  'bobotPertanyaan_Service': bobotPertanyaanService,
                                                                                  'bobotPertanyaan_Cashier': bobotPertanyaanCashier,
                                                                                  'bobotPertanyaan_CashierAccuracy': bobotPertanyaanCashierAccuracy,
                                                                                  'bobotPertanyaan_Boh': bobotPertanyaanBoh,
                                                                                  'bobotPertanyaan_Warehouse': bobotPertanyaanWarehouse,
                                                                                  'bobotPertanyaan_SocialBlock': bobotPertanyaanSocialBlock,
                                                                                  'bobotPertanyaan_Personal': bobotPertanyaanPersonal,
                                                                                  'bobotPertanyaan_FoodCooked': bobotPertanyaanFoodCooked,
                                                                                  'auditStart': DateTime.now(),
                                                                                  'status': 'ONGOING',
                                                                                  'auditeeCheckIn': DateTime.now(),
                                                                                  'auditeeStatus': 'OPEN',
                                                                                  'pesertaHadir': pesertaHadir,
                                                                                  'pesertaStatus': pesertaStatus,
                                                                                  'pertanyaanAreaLuar': pertanyaanAreaLuar,
                                                                                  'criticalAreaLuar': criticalAreaLuar,
                                                                                  'sistemAreaLuar': systemAreaLuar,
                                                                                  'pertanyaanDinningArea': pertanyaanDinningArea,
                                                                                  'criticalDinningArea': criticalDinningArea,
                                                                                  'sistemDinningArea': systemDinningArea,
                                                                                  'pertanyaanService': pertanyaanService,
                                                                                  'criticalService': criticalService,
                                                                                  'sistemService': systemService,
                                                                                  'pertanyaanCashier': pertanyaanCashier,
                                                                                  'criticalCashier': criticalCashier,
                                                                                  'sistemCashier': systemCashier,
                                                                                  'pertanyaanCashierAccuracy': pertanyaanCashierAccuracy,
                                                                                  'criticalCashierAccuracy': criticalCashierAccuracy,
                                                                                  'sistemCashierAccuracy': systemCashierAccuracy,
                                                                                  'pertanyaanBoh': pertanyaanBoh,
                                                                                  'criticalBoh': criticalBoh,
                                                                                  'sistemBoh': systemBoh,
                                                                                  'pertanyaanWarehouse': pertanyaanWarehouse,
                                                                                  'criticalWarehouse': criticalWarehouse,
                                                                                  'sistemWarehouse': systemWarehouse,
                                                                                  'pertanyaanSocialBlock': pertanyaanSocialBlock,
                                                                                  'criticalSocialBlock': criticalSocialBlock,
                                                                                  'sistemSocialBlock': systemSocialBlock,
                                                                                  'pertanyaanPersonal': pertanyaanPersonal,
                                                                                  'criticalPersonal': criticalPersonal,
                                                                                  'sistemPersonal': systemPersonal,
                                                                                  'pertanyaanFoodCooked': pertanyaanFoodCooked,
                                                                                  'criticalFoodCooked': criticalFoodCooked,
                                                                                  'sistemFoodCooked': systemFoodCooked,
                                                                                }).then((doc) {
                                                                                  setState(() {
                                                                                    checkIn[index] = !checkIn[index];
                                                                                  });
                                                                                  Navigator.pushReplacement(context, 
                                                                                    MaterialPageRoute(
                                                                                      builder: (_) => FormAuditAuditee(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser, index: snapshot.data.documents[index].documentID, auditor: snapshot.data.documents[index].data['subAreaAuditor'], statusLogin: 'Auditee')
                                                                                    )
                                                                                  );
                                                                                }).catchError((error) {
                                                                                  print(error);
                                                                                });
                                                                              }
                                                                            },
                                                                          ),
                                                                        )
                                                                      : ButtonTheme(
                                                                          minWidth: MediaQuery.of(context).size.width * 0.35,
                                                                          height: 30.0,
                                                                          child: RaisedButton(
                                                                            child: checkIn[index]
                                                                              ? SizedBox(
                                                                                  child: CircularProgressIndicator(
                                                                                    valueColor: AlwaysStoppedAnimation(Colors.white),
                                                                                    strokeWidth: 2.0
                                                                                  ),
                                                                                  height: 20.0,
                                                                                  width: 20.0
                                                                                )
                                                                              : Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                  children: <Widget>[
                                                                                    Container(
                                                                                      width: MediaQuery.of(context).size.width * 0.25,
                                                                                      alignment: Alignment.centerLeft,
                                                                                      child: Text(
                                                                                        'CONTINUE',
                                                                                        style: TextStyle(
                                                                                          fontSize: 13.0,
                                                                                          color: Colors.white,
                                                                                          fontWeight: FontWeight.bold
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    // Container(
                                                                                    //   width: MediaQuery.of(context).size.width * 0.12,
                                                                                    //   alignment: Alignment.centerRight,
                                                                                    //   child: Icon(Icons.arrow_forward, color: Colors.white, size: 16.0),
                                                                                    // )
                                                                                  ],
                                                                                ),
                                                                            elevation: 0.0,
                                                                            color: buttonText == 'UNREADY' ? Colors.grey : tanggalAudit.toDate().isBefore(DateTime(now.year, now.month, now.day)) == false ? AbubaPallate.greenabuba : Colors.orangeAccent,
                                                                            splashColor: buttonText == 'UNREADY' ? Colors.grey : tanggalAudit.toDate().isBefore(DateTime(now.year, now.month, now.day)) == false ? AbubaPallate.greenabuba : Colors.orangeAccent,
                                                                            onPressed: () async {
                                                                              Navigator.pushReplacement(context, 
                                                                                MaterialPageRoute(
                                                                                  builder: (_) => FormAuditAuditee(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser, index: snapshot.data.documents[index].documentID, auditor: snapshot.data.documents[index].data['subAreaAuditor'], statusLogin: 'Auditee')
                                                                                )
                                                                              );
                                                                            },
                                                                          ),
                                                                        )
                                                                  : status == 'LEAD AUDITOR'
                                                                      ? snapshot.data.documents[index].data['leadAuditorCheckIn'] == null
                                                                          ? ButtonTheme(
                                                                              minWidth: MediaQuery.of(context).size.width * 0.35,
                                                                              height: 30.0,
                                                                              child: RaisedButton(
                                                                                child: checkIn[index]
                                                                                  ? SizedBox(
                                                                                      child: CircularProgressIndicator(
                                                                                        valueColor: AlwaysStoppedAnimation(Colors.white),
                                                                                        strokeWidth: 2.0
                                                                                      ),
                                                                                      height: 20.0,
                                                                                      width: 20.0
                                                                                    )
                                                                                  : Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                      children: <Widget>[
                                                                                        Container(
                                                                                          width: MediaQuery.of(context).size.width * 0.25,
                                                                                          alignment: Alignment.centerLeft,
                                                                                          child: Text(
                                                                                            buttonText,
                                                                                            style: TextStyle(
                                                                                              fontSize: 13.0,
                                                                                              color: Colors.white,
                                                                                              fontWeight: FontWeight.bold
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        // Container(
                                                                                        //   width: MediaQuery.of(context).size.width * 0.12,
                                                                                        //   alignment: Alignment.centerRight,
                                                                                        //   child: Icon(Icons.arrow_forward, color: Colors.white, size: 16.0),
                                                                                        // )
                                                                                      ],
                                                                                    ),
                                                                                elevation: 0.0,
                                                                                color: buttonText == 'UNREADY' ? Colors.grey : tanggalAudit.toDate().isBefore(DateTime(now.year, now.month, now.day)) == false ? AbubaPallate.greenabuba : Colors.orangeAccent,
                                                                                splashColor: buttonText == 'UNREADY' ? Colors.grey : tanggalAudit.toDate().isBefore(DateTime(now.year, now.month, now.day)) == false ? AbubaPallate.greenabuba : Colors.orangeAccent,
                                                                                onPressed: () async {
                                                                                  if (buttonText == 'UNREADY') {
                                                                                    print('UNREADY');
                                                                                  } else {
                                                                                    if (snapshot.data.documents[index].data['auditStart'] == null || snapshot.data.documents[index].data['status'] == 'OPEN') {
                                                                                      showDialog(
                                                                                        barrierDismissible: false,
                                                                                        context: context,
                                                                                        builder: (context) => Dialog(
                                                                                          child: Container(
                                                                                            height: 180.0,
                                                                                            child: Column(
                                                                                              children: <Widget>[
                                                                                                Container(
                                                                                                  color: Colors.orangeAccent,
                                                                                                  height: 50.0,
                                                                                                  child: Center(
                                                                                                    child: Text(
                                                                                                      'ALERT!',
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
                                                                                                    'Auditee belum check in',
                                                                                                    style: TextStyle(
                                                                                                      fontSize: 16.0,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Row(
                                                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                                                  children: <Widget>[
                                                                                                    FlatButton(
                                                                                                      child: Text('OK', style: TextStyle(color: Colors.grey)),
                                                                                                      onPressed: () {
                                                                                                        Navigator.pop(context);
                                                                                                      },
                                                                                                    ),
                                                                                                  ],
                                                                                                )
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        )
                                                                                      );
                                                                                    } else {
                                                                                      setState(() {
                                                                                        checkIn[index] = !checkIn[index];
                                                                                      });
                                                                                      if (snapshot.data.documents[index].data['subAreaAuditor'].contains(widget.idUser.toString())) {
                                                                                        var pesertaHadir = [];
                                                                                        var pesertaStatus = [];
                                                                                        var checkInPesertaSave = [];
                                                                                        Firestore.instance.collection('audit_internal').document(snapshot.data.documents[index].documentID).snapshots().listen((data10) {
                                                                                          if (mounted) {
                                                                                            setState(() {
                                                                                              pesertaHadir = List<dynamic>.from(data10.data['pesertaHadir']);
                                                                                              pesertaStatus = List<dynamic>.from(data10.data['pesertaStatus']);

                                                                                              if (pesertaHadir.contains(widget.idUser)) {

                                                                                              } else {
                                                                                                pesertaStatus.add('OPEN');
                                                                                                pesertaHadir.add(widget.idUser);
                                                                                              }

                                                                                              for (int au = 0; au < data10.data['checkInPeserta'].length; au++) {
                                                                                                if (int.tryParse(snapshot.data.documents[index].data['subAreaAuditor'][au].toString()) == widget.idUser) {
                                                                                                  checkInPesertaSave.add(DateTime.now());
                                                                                                } else {
                                                                                                  Timestamp bantu = data10.data['checkInPeserta'][au];
                                                                                                  if (bantu == null) {
                                                                                                    checkInPesertaSave.add(null);
                                                                                                  } else {
                                                                                                    checkInPesertaSave.add(bantu.toDate());
                                                                                                  }
                                                                                                }
                                                                                              }
                                                                                            });
                                                                                          }
                                                                                        });

                                                                                        for (int subAreaa = 0; subAreaa < snapshot.data.documents[index].data['subArea'].length; subAreaa++) {
                                                                                          if (snapshot.data.documents[index].data['subAreaAuditor'][subAreaa] == widget.idUser.toString()) {
                                                                                            setState(() {
                                                                                              bab[index].add(snapshot.data.documents[index].data['subArea'][subAreaa]);
                                                                                            });
                                                                                          } else {}
                                                                                        }

                                                                                        await new Future.delayed(Duration(
                                                                                          seconds: 3
                                                                                        ));

                                                                                        DocumentReference docReference = Firestore.instance.collection('audit_internal').document(snapshot.data.documents[index].documentID);

                                                                                        docReference.updateData({
                                                                                          'pesertaHadir': pesertaHadir,
                                                                                          'pesertaStatus': pesertaStatus,
                                                                                          'checkInPeserta': checkInPesertaSave,
                                                                                          'leadAuditorCheckIn': DateTime.now(),
                                                                                          'leadAuditorStatus': 'OPEN',
                                                                                        }).then((doc) {
                                                                                          setState(() {
                                                                                            checkIn[index] = !checkIn[index];
                                                                                          });

                                                                                          print('check in auditor success');

                                                                                          Navigator.pushReplacement(context, 
                                                                                            MaterialPageRoute(
                                                                                              builder: (_) => FormAudit(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser, index: snapshot.data.documents[index].documentID, subArea: bab[index], auditor: snapshot.data.documents[index].data['subAreaAuditor'])
                                                                                            )
                                                                                          );
                                                                                        }).catchError((error) {
                                                                                          print(error);
                                                                                        });
                                                                                      } else {
                                                                                        var pesertaHadir = [];
                                                                                        var pesertaStatus = [];
                                                                                        Firestore.instance.collection('audit_internal').document(snapshot.data.documents[index].documentID).snapshots().listen((data10) {
                                                                                          if (mounted) {
                                                                                            setState(() {
                                                                                              pesertaHadir = List<dynamic>.from(data10.data['pesertaHadir']);
                                                                                              pesertaStatus = List<dynamic>.from(data10.data['pesertaStatus']);

                                                                                              if (pesertaHadir.contains(widget.idUser)) {

                                                                                              } else {
                                                                                                pesertaStatus.add('OPEN');
                                                                                                pesertaHadir.add(widget.idUser);
                                                                                              }
                                                                                            });
                                                                                          }
                                                                                        });

                                                                                        await new Future.delayed(Duration(
                                                                                          seconds: 3
                                                                                        ));

                                                                                        DocumentReference docReference = Firestore.instance.collection('audit_internal').document(snapshot.data.documents[index].documentID);

                                                                                        docReference.updateData({
                                                                                          'leadAuditorCheckIn': DateTime.now(),
                                                                                          'leadAuditorStatus': 'OPEN',
                                                                                          'pesertaHadir': pesertaHadir,
                                                                                          'pesertaStatus': pesertaStatus
                                                                                        }).then((doc) {
                                                                                          setState(() {
                                                                                            checkIn[index] = !checkIn[index];
                                                                                          });
                                                                                          Navigator.pushReplacement(context, 
                                                                                            MaterialPageRoute(
                                                                                              builder: (_) => FormAuditAuditee(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser, index: snapshot.data.documents[index].documentID, auditor: snapshot.data.documents[index].data['subAreaAuditor'], statusLogin: 'Lead Auditor')
                                                                                            )
                                                                                          );
                                                                                        }).catchError((error) {
                                                                                          print(error);
                                                                                        });
                                                                                      }
                                                                                    }
                                                                                  }
                                                                                },
                                                                              ),
                                                                            )
                                                                          : snapshot.data.documents[index].data['leadAuditorStatus'] == 'OPEN'
                                                                              ? ButtonTheme(
                                                                                  minWidth: MediaQuery.of(context).size.width * 0.35,
                                                                                  height: 30.0,
                                                                                  child: RaisedButton(
                                                                                    child: checkIn[index]
                                                                                      ? SizedBox(
                                                                                          child: CircularProgressIndicator(
                                                                                            valueColor: AlwaysStoppedAnimation(Colors.white),
                                                                                            strokeWidth: 2.0
                                                                                          ),
                                                                                          height: 20.0,
                                                                                          width: 20.0
                                                                                        )
                                                                                      : Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                                                          children: <Widget>[
                                                                                            Container(
                                                                                              width: MediaQuery.of(context).size.width * 0.25,
                                                                                              alignment: Alignment.centerLeft,
                                                                                              child: Text(
                                                                                                'CONTINUE',
                                                                                                style: TextStyle(
                                                                                                  fontSize: 13.0,
                                                                                                  color: Colors.white,
                                                                                                  fontWeight: FontWeight.bold
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            // Container(
                                                                                            //   width: MediaQuery.of(context).size.width * 0.12,
                                                                                            //   alignment: Alignment.centerRight,
                                                                                            //   child: Icon(Icons.arrow_forward, color: Colors.white, size: 16.0),
                                                                                            // )
                                                                                          ],
                                                                                        ),
                                                                                    elevation: 0.0,
                                                                                    color: AbubaPallate.greenabuba,
                                                                                    splashColor: AbubaPallate.greenabuba,
                                                                                    onPressed: () {
                                                                                      if (snapshot.data.documents[index].data['subAreaAuditor'].contains(widget.idUser.toString())) {
                                                                                        for (int subAreaa = 0; subAreaa < snapshot.data.documents[index].data['subArea'].length; subAreaa++) {
                                                                                          if (snapshot.data.documents[index].data['subAreaAuditor'][subAreaa] == widget.idUser.toString()) {
                                                                                            setState(() {
                                                                                              bab[index].add(snapshot.data.documents[index].data['subArea'][subAreaa]);
                                                                                            });
                                                                                          } else {}
                                                                                        }
                                                                                        
                                                                                        Navigator.pushReplacement(context, 
                                                                                          MaterialPageRoute(
                                                                                            builder: (_) => FormAudit(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser, index: snapshot.data.documents[index].documentID, subArea: bab[index], auditor: snapshot.data.documents[index].data['subAreaAuditor'])
                                                                                          )
                                                                                        );
                                                                                      } else {
                                                                                        Navigator.pushReplacement(context, 
                                                                                          MaterialPageRoute(
                                                                                            builder: (_) => FormAuditAuditee(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser, index: snapshot.data.documents[index].documentID, auditor: snapshot.data.documents[index].data['subAreaAuditor'], statusLogin: 'Lead Auditor')
                                                                                          )
                                                                                        );
                                                                                      }
                                                                                    },
                                                                                  ),
                                                                                )
                                                                              : Container()
                                                                      : status == 'AUDITOR'
                                                                          ? snapshot.data.documents[index].data['pesertaHadir'].indexWhere((dynamic test) => int.tryParse(test.toString())== widget.idUser) >= 0
                                                                              ? snapshot.data.documents[index].data['pesertaStatus'][snapshot.data.documents[index].data['pesertaHadir'].indexWhere((dynamic test) => int.tryParse(test.toString())== widget.idUser)] == 'OPEN'
                                                                                  ? ButtonTheme(
                                                                                      minWidth: MediaQuery.of(context).size.width * 0.35,
                                                                                      height: 30.0,
                                                                                      child: RaisedButton(
                                                                                        child: checkIn[index]
                                                                                          ? SizedBox(
                                                                                              child: CircularProgressIndicator(
                                                                                                valueColor: AlwaysStoppedAnimation(Colors.white),
                                                                                                strokeWidth: 2.0
                                                                                              ),
                                                                                              height: 20.0,
                                                                                              width: 20.0
                                                                                            )
                                                                                          : Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                                              children: <Widget>[
                                                                                                Container(
                                                                                                  width: MediaQuery.of(context).size.width * 0.25,
                                                                                                  alignment: Alignment.centerLeft,
                                                                                                  child: Text(
                                                                                                    'CONTINUE',
                                                                                                    style: TextStyle(
                                                                                                      fontSize: 13.0,
                                                                                                      color: Colors.white,
                                                                                                      fontWeight: FontWeight.bold
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                // Container(
                                                                                                //   width: MediaQuery.of(context).size.width * 0.12,
                                                                                                //   alignment: Alignment.centerRight,
                                                                                                //   child: Icon(Icons.arrow_forward, color: Colors.white, size: 16.0),
                                                                                                // )
                                                                                              ],
                                                                                            ),
                                                                                        elevation: 0.0,
                                                                                        color: buttonText == 'UNREADY' ? Colors.grey : tanggalAudit.toDate().isBefore(DateTime(now.year, now.month, now.day)) == false ? AbubaPallate.greenabuba : Colors.orangeAccent,
                                                                                        splashColor: buttonText == 'UNREADY' ? Colors.grey : tanggalAudit.toDate().isBefore(DateTime(now.year, now.month, now.day)) == false ? AbubaPallate.greenabuba : Colors.orangeAccent,
                                                                                        onPressed: () async {
                                                                                          if (buttonText == 'UNREADY') {
                                                                                            print('UNREADY'); 
                                                                                          } else {
                                                                                            print('continue');
                                                                                            setState(() {
                                                                                              checkIn[index] = !checkIn[index];
                                                                                            });
                                                                                            for (int subAreaa = 0; subAreaa < snapshot.data.documents[index].data['subArea'].length; subAreaa++) {
                                                                                              if (snapshot.data.documents[index].data['subAreaAuditor'][subAreaa] == widget.idUser.toString()) {
                                                                                                setState(() {
                                                                                                  bab[index].add(snapshot.data.documents[index].data['subArea'][subAreaa]);
                                                                                                });
                                                                                              } else {}
                                                                                            }
                                                                                            setState(() {
                                                                                              checkIn[index] = !checkIn[index];
                                                                                            });

                                                                                            Navigator.pushReplacement(context, 
                                                                                              MaterialPageRoute(
                                                                                                builder: (_) => FormAudit(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser, index: snapshot.data.documents[index].documentID, subArea: bab[index], auditor: snapshot.data.documents[index].data['subAreaAuditor'])
                                                                                              )
                                                                                            );
                                                                                          }
                                                                                        },
                                                                                      ),
                                                                                    )
                                                                                  : Container()
                                                                              // batas sini
                                                                              : snapshot.data.documents[index].data['leadAuditor'] != widget.idUser
                                                                                  ? ButtonTheme(
                                                                                      minWidth: MediaQuery.of(context).size.width * 0.35,
                                                                                      height: 30.0,
                                                                                      child: RaisedButton(
                                                                                        child: checkIn[index]
                                                                                          ? SizedBox(
                                                                                              child: CircularProgressIndicator(
                                                                                                valueColor: AlwaysStoppedAnimation(Colors.white),
                                                                                                strokeWidth: 2.0
                                                                                              ),
                                                                                              height: 20.0,
                                                                                              width: 20.0
                                                                                            )
                                                                                          : Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                                              children: <Widget>[
                                                                                                Container(
                                                                                                  width: MediaQuery.of(context).size.width * 0.25,
                                                                                                  alignment: Alignment.centerLeft,
                                                                                                  child: Text(
                                                                                                    buttonText,
                                                                                                    style: TextStyle(
                                                                                                      fontSize: 13.0,
                                                                                                      color: Colors.white,
                                                                                                      fontWeight: FontWeight.bold
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                // Container(
                                                                                                //   width: MediaQuery.of(context).size.width * 0.12,
                                                                                                //   alignment: Alignment.centerRight,
                                                                                                //   child: Icon(Icons.arrow_forward, color: Colors.white, size: 16.0),
                                                                                                // )
                                                                                              ],
                                                                                            ),
                                                                                        elevation: 0.0,
                                                                                        color: buttonText == 'UNREADY' ? Colors.grey : tanggalAudit.toDate().isBefore(DateTime(now.year, now.month, now.day)) == false ? AbubaPallate.greenabuba : Colors.orangeAccent,
                                                                                        splashColor: buttonText == 'UNREADY' ? Colors.grey : tanggalAudit.toDate().isBefore(DateTime(now.year, now.month, now.day)) == false ? AbubaPallate.greenabuba : Colors.orangeAccent,
                                                                                        onPressed: () async {
                                                                                          if (buttonText == 'UNREADY') {
                                                                                            print('UNREADY'); 
                                                                                          } else {
                                                                                            print('continue');
                                                                                            if (snapshot.data.documents[index].data['pesertaHadir'].contains(widget.idUser)) {
                                                                                              for (int subAreaa = 0; subAreaa < snapshot.data.documents[index].data['subArea'].length; subAreaa++) {
                                                                                                if (snapshot.data.documents[index].data['subAreaAuditor'][subAreaa] == widget.idUser.toString()) {
                                                                                                  setState(() {
                                                                                                    bab[index].add(snapshot.data.documents[index].data['subArea'][subAreaa]);
                                                                                                  });
                                                                                                } else {}
                                                                                              }

                                                                                              Navigator.pushReplacement(context, 
                                                                                                MaterialPageRoute(
                                                                                                  builder: (_) => FormAudit(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser, index: snapshot.data.documents[index].documentID, subArea: bab[index], auditor: snapshot.data.documents[index].data['subAreaAuditor'])
                                                                                                )
                                                                                              );
                                                                                            } else {
                                                                                              for (int subAreaa = 0; subAreaa < snapshot.data.documents[index].data['subArea'].length; subAreaa++) {
                                                                                                if (snapshot.data.documents[index].data['subAreaAuditor'][subAreaa] == widget.idUser.toString()) {
                                                                                                  setState(() {
                                                                                                    bab[index].add(snapshot.data.documents[index].data['subArea'] [subAreaa]);
                                                                                                  });
                                                                                                } else {}
                                                                                              }
                                                                                              if (snapshot.data.documents[index].data['auditStart'] == null || snapshot.data.documents[index].data['status'] == 'OPEN') {
                                                                                                showDialog(
                                                                                                  barrierDismissible: false,
                                                                                                  context: context,
                                                                                                  builder: (context) => Dialog(
                                                                                                    child: Container(
                                                                                                      height: 180.0,
                                                                                                      child: Column(
                                                                                                        children: <Widget>[
                                                                                                          Container(
                                                                                                            color: Colors.orangeAccent,
                                                                                                            height: 50.0,
                                                                                                            child: Center(
                                                                                                              child: Text(
                                                                                                                'ALERT!',
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
                                                                                                              'Auditee belum check in',
                                                                                                              style: TextStyle(
                                                                                                                fontSize: 16.0,
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                          Row(
                                                                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                                                                            children: <Widget>[
                                                                                                              FlatButton(
                                                                                                                child: Text('OK', style: TextStyle(color: Colors.grey)),
                                                                                                                onPressed: () {
                                                                                                                  Navigator.pop(context);
                                                                                                                },
                                                                                                              ),
                                                                                                            ],
                                                                                                          )
                                                                                                        ],
                                                                                                      ),
                                                                                                    ),
                                                                                                  )
                                                                                                );
                                                                                              } else {
                                                                                                setState(() {
                                                                                                  checkIn[index] = !checkIn[index];
                                                                                                });
                                                                                                var pesertaHadir = [];
                                                                                                var pesertaStatus = [];
                                                                                                var checkInPesertaSave = [];
                                                                                                Firestore.instance.collection('audit_internal').document(snapshot.data.documents[index].documentID).snapshots().listen((data10) {
                                                                                                  if (mounted) {
                                                                                                    setState(() {
                                                                                                      pesertaHadir = List<dynamic>.from(data10.data['pesertaHadir']);
                                                                                                      pesertaStatus = List<dynamic>.from(data10.data['pesertaStatus']);

                                                                                                      if (pesertaHadir.contains(widget.idUser)) {

                                                                                                      } else {
                                                                                                        pesertaStatus.add('OPEN');
                                                                                                        pesertaHadir.add(widget.idUser);
                                                                                                      }

                                                                                                      for (int au = 0; au < data10.data['checkInPeserta'].length; au++) {
                                                                                                        if (int.tryParse(snapshot.data.documents[index].data['subAreaAuditor'][au].toString()) == widget.idUser) {
                                                                                                          checkInPesertaSave.add(DateTime.now());
                                                                                                        } else {
                                                                                                          Timestamp bantu = data10.data['checkInPeserta'][au];
                                                                                                          if (bantu == null) {
                                                                                                            checkInPesertaSave.add(null);
                                                                                                          } else {
                                                                                                            checkInPesertaSave.add(bantu.toDate());
                                                                                                          }
                                                                                                        }
                                                                                                      }
                                                                                                    });
                                                                                                  }
                                                                                                });

                                                                                                await new Future.delayed(Duration(
                                                                                                  seconds: 3
                                                                                                ));

                                                                                                DocumentReference docReference = Firestore.instance.collection('audit_internal').document(snapshot.data.documents[index].documentID);

                                                                                                docReference.updateData({
                                                                                                  'pesertaHadir': pesertaHadir,
                                                                                                  'pesertaStatus': pesertaStatus,
                                                                                                  'checkInPeserta': checkInPesertaSave,
                                                                                                }).then((doc) {
                                                                                                  setState(() {
                                                                                                    checkIn[index] = !checkIn[index];
                                                                                                  });

                                                                                                  print('check in auditor success');

                                                                                                  Navigator.pushReplacement(context, 
                                                                                                    MaterialPageRoute(
                                                                                                      builder: (_) => FormAudit(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser, index: snapshot.data.documents[index].documentID, subArea: bab[index], auditor: snapshot.data.documents[index].data['subAreaAuditor'])
                                                                                                    )
                                                                                                  );
                                                                                                }).catchError((error) {
                                                                                                  print(error);
                                                                                                });
                                                                                              }
                                                                                            }
                                                                                          }
                                                                                        },
                                                                                      ),
                                                                                    )
                                                                                : Container()
                                                                          : Container()
                                                              : Container()
                                                              // selesai check in button
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: <Widget>[
                                                              showDetail[index]
                                                                ? Container(
                                                                    width: MediaQuery.of(context).size.width * 0.75,
                                                                    padding: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                                    child: Container(
                                                                      decoration: const BoxDecoration(
                                                                        border: Border(
                                                                          top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                          left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                          right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                          bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                                                        ),
                                                                      ),
                                                                      padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
                                                                      child: Column(
                                                                        children: <Widget>[
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 5.0, top: 10.0),
                                                                            child: Container(
                                                                              width: MediaQuery.of(context).size.width * 0.7,
                                                                              height: 35.0,
                                                                              decoration: new BoxDecoration(
                                                                                color: Colors.grey,
                                                                                shape: BoxShape.rectangle,
                                                                              ),
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: <Widget>[
                                                                                  Flexible(
                                                                                    child: Container(
                                                                                      padding: EdgeInsets.only(left: 10.0),
                                                                                      alignment: Alignment.centerLeft,
                                                                                      child: Text(
                                                                                        'Department',
                                                                                        style: TextStyle(
                                                                                            color: Colors.white, fontSize: 12.0),
                                                                                        textAlign: TextAlign.center,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Flexible(
                                                                                    child: Container(
                                                                                      alignment: Alignment.centerLeft,
                                                                                      child: Text(
                                                                                        'Sub Area - Auditor',
                                                                                        style: TextStyle(
                                                                                            color: Colors.white, fontSize: 12.0),
                                                                                        textAlign: TextAlign.center,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            )
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(left: 20.0, right: 12.0, top: 10.0),
                                                                            child: Column(
                                                                              children: <Widget>[
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: <Widget>[
                                                                                    Container(
                                                                                      alignment: Alignment.topLeft,
                                                                                      width: MediaQuery.of(context).size.width * 0.3,
                                                                                      child: Column( 
                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                        children: <Widget>[
                                                                                          Row(
                                                                                            children: <Widget>[
                                                                                              Flexible(
                                                                                                child: Text(
                                                                                                  'Auditee',
                                                                                                  style: TextStyle(color: AbubaPallate.greenabuba, fontSize: 13.0, fontWeight: FontWeight.w700)
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                          SizedBox(
                                                                                            height: 3.0,
                                                                                          ),
                                                                                          Row(
                                                                                            children: <Widget>[
                                                                                              Flexible(
                                                                                                child: Text(
                                                                                                  auditeeName[index],
                                                                                                  // 'asd',
                                                                                                  style: TextStyle(color: Colors.grey[500], fontSize: 13.0, fontWeight: FontWeight.w700)
                                                                                                ),
                                                                                              ),
                                                                                              SizedBox(
                                                                                                width: 3.0,
                                                                                              ),
                                                                                              snapshot.data.documents[index].data['auditeeConfirm'].toString() != 'CONFIRM'
                                                                                                ? Container()
                                                                                                : Flexible(
                                                                                                    child: Tooltip(
                                                                                                      child: Icon(Icons.check, size: 16.0, color: Colors.green),
                                                                                                      message: 'CONFIRMED',
                                                                                                    )
                                                                                                  )
                                                                                            ],
                                                                                          ),
                                                                                          SizedBox(
                                                                                            height: 15.0,
                                                                                          ),
                                                                                          Row(
                                                                                            children: <Widget>[
                                                                                              Flexible(
                                                                                                child: Text(
                                                                                                  'Lead Auditor',
                                                                                                  style: TextStyle(color: AbubaPallate.greenabuba, fontSize: 13.0, fontWeight: FontWeight.w700)
                                                                                                ),
                                                                                              ),
                                                                                              SizedBox(
                                                                                                width: 3.0,
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                          SizedBox(
                                                                                            height: 3.0,
                                                                                          ),
                                                                                          Row(
                                                                                            children: <Widget>[
                                                                                              Flexible(
                                                                                                child: Text(
                                                                                                  leadAuditorName[index],
                                                                                                  // 'asd',
                                                                                                  style: TextStyle(color: Colors.grey[500], fontSize: 13.0, fontWeight: FontWeight.w700)
                                                                                                ),
                                                                                              ),
                                                                                              SizedBox(
                                                                                                width: 3.0,
                                                                                              ),
                                                                                              snapshot.data.documents[index].data['leadAuditorConfirm'].toString() != 'CONFIRM'
                                                                                                ? Container()
                                                                                                : Flexible(
                                                                                                    child: Tooltip(
                                                                                                      child: Icon(Icons.check, size: 16.0, color: Colors.green),
                                                                                                      message: 'CONFIRMED',
                                                                                                    )
                                                                                                  )
                                                                                            ],
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    Container(
                                                                                      width: MediaQuery.of(context).size.width * 0.3,
                                                                                      child: Column(
                                                                                        children: List.generate(snapshot.data.documents[index].data['subArea'].length, (index2) {
                                                                                          return Column(
                                                                                            children: <Widget>[
                                                                                              Row(
                                                                                                children: <Widget>[
                                                                                                  Flexible(
                                                                                                    child: Text(
                                                                                                      snapshot.data.documents[index].data['subArea'][index2],
                                                                                                      // 'asd',
                                                                                                      style: TextStyle(color: Colors.grey[500], fontSize: 13.0, fontWeight: FontWeight.w700)
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                              Row(
                                                                                                children: <Widget>[
                                                                                                  Flexible(
                                                                                                    child: Text(
                                                                                                      auditorName[index2].toString(),
                                                                                                      // 'asd',
                                                                                                      style: TextStyle(color: Colors.grey[500], fontSize: 13.0)
                                                                                                    ),
                                                                                                  ),
                                                                                                  SizedBox(
                                                                                                    width: 5.0,
                                                                                                  ),
                                                                                                  snapshot.data.documents[index].data['auditorConfirm'][index2] != 'CONFIRM'
                                                                                                    ? Container()
                                                                                                    : Flexible(
                                                                                                        child: Tooltip(
                                                                                                          child: Icon(Icons.check, size: 16.0, color: Colors.green),
                                                                                                          message: 'CONFIRMED',
                                                                                                        )
                                                                                                      )
                                                                                                ],
                                                                                              ),
                                                                                              SizedBox(
                                                                                                height: 10.0,
                                                                                              )
                                                                                            ],
                                                                                          );
                                                                                        }).toList(),
                                                                                      )
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            )
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  )
                                                                : Container()
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            );
                                    } else {
                                      return Container();
                                    }
                                  } else {
                                    return Container();
                                  }
                                }).toList()
                              );
                            }
                          ),
                        )
                      ],
                    );
              },
            ),
          )
        ),
      ),
    );
  }
}

class DialogView extends StatefulWidget {
  var indexx;
  List<dynamic> auditor;

  DialogView({this.indexx, this.auditor});
  @override
  _DialogViewState createState() => _DialogViewState();
}

class _DialogViewState extends State<DialogView> with TickerProviderStateMixin {
  AnimationController animationController;
  String department;
  String object;
  String tanggal;
  String auditeeName;
  String auditeeConfirm;
  String leadAuditorName;
  String leadAuditorConfirm;
  List<dynamic> subArea = [];
  List<dynamic> auditorName = [];
  List<dynamic> auditorConfirm = [];
  bool isProcess = false;
  
  @override
  void initState() {
    Firestore.instance.collection('audit_internal').document(widget.indexx).snapshots().listen((data) {
      setState(() {
        Timestamp tanggalBantu = data.data['dateAudit'];
        tanggal = tanggalBantu.toDate().toString().substring(8, 10) + '/' + tanggalBantu.toDate().toString().substring(5, 7) + '/' + tanggalBantu.toDate().toString().substring(0, 4);
        auditeeConfirm = data.data['auditeeConfirm'].toString();
        leadAuditorConfirm = data.data['leadAuditorConfirm'].toString();
        subArea = data.data['subArea'];
        auditorConfirm = data.data['auditorConfirm'];

        Firestore.instance.collection('department').where('id', isEqualTo: data.data['department']).snapshots().listen((data2) {
          department = data2.documents[0].data['name'];
        });

        Firestore.instance.collection('audit_object').where('id', isEqualTo: data.data['object']).snapshots().listen((data3) {
          object = data3.documents[0].data['object'];
        });

        Firestore.instance.collection('user').where('id', isEqualTo: data.data['auditee']).snapshots().listen((data4) {
          auditeeName = data4.documents[0].data['nama'];
        });

        Firestore.instance.collection('user').where('id', isEqualTo: data.data['leadAuditor']).snapshots().listen((data5) {
          leadAuditorName = data5.documents[0].data['nama'];
        });
      });
    });

    for (int a = 0; a < widget.auditor.length; a++) {
      Firestore.instance.collection('user').where('id', isEqualTo: int.tryParse(widget.auditor[a].toString())).snapshots().listen((data) {
        setState(() {
          auditorName.add(data.documents[0].data['nama']);
        });
      });
    }
    
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(
      from: animationController.value == 0.0
        ? 1.0
        : animationController.value
    );

    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
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
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 5.0, top: 10.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 35.0,
                        decoration: new BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.rectangle,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.only(left: 10.0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Department',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12.0),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Sub Area - Auditor',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12.0),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ),
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                            child: Container(
                              padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0, right: 12.0, top: 10.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              alignment: Alignment.topLeft,
                                              width: MediaQuery.of(context).size.width * 0.2,
                                              child: Column( 
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          department,
                                                          style: TextStyle(color: Colors.grey[500], fontSize: 13.0, fontWeight: FontWeight.w700)
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 3.0,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          object,
                                                          style: TextStyle(color: Colors.grey[500], fontSize: 13.0, fontWeight: FontWeight.w700)
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 3.0,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          tanggal,
                                                          style: TextStyle(color: Colors.grey[500], fontSize: 13.0, fontWeight: FontWeight.w700)
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 15.0,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'Auditee',
                                                          style: TextStyle(color: AbubaPallate.greenabuba, fontSize: 13.0, fontWeight: FontWeight.w700)
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 3.0,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          auditeeName,
                                                          style: TextStyle(color: Colors.grey[500], fontSize: 13.0, fontWeight: FontWeight.w700)
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 3.0,
                                                      ),
                                                      auditeeConfirm.toString() != 'CONFIRM'
                                                        ? Container()
                                                        : Flexible(
                                                            child: Tooltip(
                                                              child: Icon(Icons.check, size: 16.0, color: Colors.green),
                                                              message: 'CONFIRMED',
                                                            )
                                                          )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 15.0,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'Lead Auditor',
                                                          style: TextStyle(color: AbubaPallate.greenabuba, fontSize: 13.0, fontWeight: FontWeight.w700)
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 3.0,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 3.0,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          leadAuditorName,
                                                          style: TextStyle(color: Colors.grey[500], fontSize: 13.0, fontWeight: FontWeight.w700)
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 3.0,
                                                      ),
                                                      leadAuditorConfirm.toString() != 'CONFIRM'
                                                        ? Container()
                                                        : Flexible(
                                                            child: Tooltip(
                                                              child: Icon(Icons.check, size: 16.0, color: Colors.green),
                                                              message: 'CONFIRMED',
                                                            )
                                                          )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.45,
                                              child: Column(
                                                children: List.generate(subArea.length, (index2) {
                                                  return Column(
                                                    children: <Widget>[
                                                      Row(
                                                        children: <Widget>[
                                                          Flexible(
                                                            child: Text(
                                                              subArea[index2],
                                                              style: TextStyle(color: Colors.grey[500], fontSize: 13.0, fontWeight: FontWeight.w700)
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: <Widget>[
                                                          Flexible(
                                                            child: Text(
                                                              auditorName[index2],
                                                              style: TextStyle(color: Colors.grey[500], fontSize: 13.0)
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 5.0,
                                                          ),
                                                          auditorConfirm[index2] != 'CONFIRM'
                                                            ? Container()
                                                            : Flexible(
                                                                child: Tooltip(
                                                                  child: Icon(Icons.check, size: 16.0, color: Colors.green),
                                                                  message: 'CONFIRMED',
                                                                )
                                                              )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10.0,
                                                      )
                                                    ],
                                                  );
                                                }).toList(),
                                              )
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                          child: Text('Close', style: TextStyle(color: Colors.black45)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    )
                  ],
                );
          },
        )
      ),
    );
  }
}