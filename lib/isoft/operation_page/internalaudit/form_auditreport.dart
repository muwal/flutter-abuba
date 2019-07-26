import 'dart:async';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_abuba/isoft/operation_page/internalaudit/detail_report.dart';

class FormAuditReport extends StatefulWidget {
  @override
  _FormAuditReportState createState() => _FormAuditReportState();

  final int idUser;
  final String namaUser;
  final String departmentUser;
  FormAuditReport({this.idUser, this.namaUser, this.departmentUser});
}

class _FormAuditReportState extends State<FormAuditReport> with TickerProviderStateMixin {
  AnimationController animationController;
  String _mySelection;
  String _shift;
  List<Map> _shiftJson = [
    {"id": 1, "shift": "Shift A"},
    {"id": 2, "shift": "Shift B"}
  ];

  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime dateStart;
  DateTime dateEnd;

  var idCollection;

  String userName = '';
  String tanggal = '';
  String waktuStart = '';
  String waktuEnd = '';

  List<dynamic> AreaLuarScore = [];
  List<dynamic> AreaLuarNote = [];
  List<dynamic> criticalAreaLuar = [];
  List<dynamic> systemAreaLuar = [];
  List<dynamic> DinningAreaScore = [];
  List<dynamic> DinningAreaNote = [];
  List<dynamic> criticalDinningArea = [];
  List<dynamic> systemDinningArea = [];
  List<dynamic> ServiceScore = [];
  List<dynamic> ServiceNote = [];
  List<dynamic> criticalService = [];
  List<dynamic> systemService = [];
  List<dynamic> CashierScore = [];
  List<dynamic> CashierNote = [];
  List<dynamic> criticalCashier = [];
  List<dynamic> systemCashier = [];
  List<dynamic> CashierAccuracyScore = [];
  List<dynamic> CashierAccuracyNote = [];
  List<dynamic> criticalCashierAccuracy = [];
  List<dynamic> systemCashierAccuracy = [];
  List<dynamic> BohScore = [];
  List<dynamic> BohNote = [];
  List<dynamic> criticalBoh = [];
  List<dynamic> systemBoh = [];
  List<dynamic> WarehouseScore = [];
  List<dynamic> WarehouseNote = [];
  List<dynamic> criticalWarehouse = [];
  List<dynamic> systemWarehouse = [];
  List<dynamic> SocialBlockScore = [];
  List<dynamic> SocialBlockNote = [];
  List<dynamic> criticalSocialBlock = [];
  List<dynamic> systemSocialBlock = [];
  List<dynamic> PersonalScore = [];
  List<dynamic> PersonalNote = [];
  List<dynamic> criticalPersonal = [];
  List<dynamic> systemPersonal = [];
  List<dynamic> FoodCookedScore = [];
  List<dynamic> FoodCookedNote = [];
  List<dynamic> criticalFoodCooked = [];
  List<dynamic> systemFoodCooked = [];

  List<dynamic> pertanyaanAreaLuar = [];
  List<dynamic> pertanyaanDinningRoom = [];
  List<dynamic> pertanyaanService = [];
  List<dynamic> pertanyaanCashier = [];
  List<dynamic> pertanyaanCashierAccuracy = [];
  List<dynamic> pertanyaanBOH = [];
  List<dynamic> pertanyaanWareHouse = [];
  List<dynamic> pertanyaanSocialBlock = [];
  List<dynamic> pertanyaanPersonalHygiene = [];
  List<dynamic> pertanyaanFoodCompletely = [];

  double hasilAreaLuar = 0.0;
  double hasilDinningArea = 0.0;
  double hasilService = 0.0;
  double hasilCashier = 0.0;
  double hasilCashierAccuracy = 0.0;
  double hasilBoh = 0.0;
  double hasilWarehouse = 0.0;
  double hasilSocialBlock = 0.0;
  double hasilPersonal = 0.0;
  double hasilFoodCooked = 0.0;
  double hasilGrafik = 0.0;

  List<dynamic> auditor = [];
  int auditee = 0;
  int leadAuditor = 0;

  List<bool> buttonView = [];
  bool showDataFiltered = false;
  bool showHelper = false;
  String helperText = '';
  String outlet;

  List<String> object = [];

  List<dynamic> bobotPertanyaanSocial = [];
  List<dynamic> bobotSocial = [];
  List<dynamic> bobotPertanyaanAreaLuar = [];
  List<dynamic> bobotAreaLuar = [];
  List<dynamic> bobotPertanyaanDinningArea = [];
  List<dynamic> bobotDinningArea = [];
  List<dynamic> bobotPertanyaanService = [];
  List<dynamic> bobotService = [];
  List<dynamic> bobotPertanyaanCashier = [];
  List<dynamic> bobotCashier = [];
  List<dynamic> bobotPertanyaanCashierAccuracy = [];
  List<dynamic> bobotCashierAccuracy = [];
  List<dynamic> bobotPertanyaanBoh = [];
  List<dynamic> bobotBoh = [];
  List<dynamic> bobotPertanyaanWarehouse = [];
  List<dynamic> bobotWarehouse = [];
  List<dynamic> bobotPertanyaanPersonal = [];
  List<dynamic> bobotPersonal = [];
  List<dynamic> bobotPertanyaanFood = [];
  List<dynamic> bobotFood = [];

  int totalCP = 0;
  
  @override
  void initState() {
    super.initState();

    CollectionReference reference2 = Firestore.instance.collection('audit_internal');
    reference2.snapshots().listen((data3) {
      data3.documentChanges.forEach((change2) {
        setState(() {
          bobotPertanyaanSocial.add(change2.document.data['bobotPertanyaan_SocialBlock']);
          bobotSocial.add(double.tryParse(change2.document.data['bobot_SocialBlock'].toString()));
          bobotPertanyaanAreaLuar.add(change2.document.data['bobotPertanyaan_AreaLuar']);
          bobotAreaLuar.add(double.tryParse(change2.document.data['bobot_AreaLuar'].toString()));
          bobotPertanyaanDinningArea.add(change2.document.data['bobotPertanyaan_DinningArea']);
          bobotDinningArea.add(double.tryParse(change2.document.data['bobot_DinningArea'].toString()));
          bobotPertanyaanService.add(change2.document.data['bobotPertanyaan_Service']);
          bobotService.add(double.tryParse(change2.document.data['bobot_Service'].toString()));
          bobotPertanyaanCashier.add(change2.document.data['bobotPertanyaan_Cashier']);
          bobotCashier.add(double.tryParse(change2.document.data['bobot_Cashier'].toString()));
          bobotPertanyaanCashierAccuracy.add(change2.document.data['bobotPertanyaan_CashierAccuracy']);
          bobotCashierAccuracy.add(double.tryParse(change2.document.data['bobot_CashierAccuracy'].toString()));
          bobotPertanyaanBoh.add(change2.document.data['bobotPertanyaan_Boh']);
          bobotBoh.add(double.tryParse(change2.document.data['bobot_Boh'].toString()));
          bobotPertanyaanWarehouse.add(change2.document.data['bobotPertanyaan_Warehouse']);
          bobotWarehouse.add(double.tryParse(change2.document.data['bobot_Warehouse'].toString()));
          bobotPertanyaanPersonal.add(change2.document.data['bobotPertanyaan_Personal']);
          bobotPersonal.add(double.tryParse(change2.document.data['bobot_Personal'].toString()));
          bobotPertanyaanFood.add(change2.document.data['bobotPertanyaan_FoodCooked']);
          bobotFood.add(double.tryParse(change2.document.data['bobot_FoodCooked'].toString()));
        });
        Firestore.instance.collection('audit_object').where('id', isEqualTo: change2.document.data['object']).snapshots().listen((data) {
          setState(() {
            object.add(data.documents[0].data['object']);
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
    final double width = MediaQuery.of(context).size.width;

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
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Internal Audit',
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
                      'Report',
                      style:
                          TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              width: width,
              child: ExpansionTile(
                title: Text(
                  'Search',
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: width / 2.5,
                          child: DateTimePickerFormField(
                            format: dateFormat,
                            onChanged: (dt) => setState(() => dateStart = dt),
                            dateOnly: true,
                            style: TextStyle(fontSize: 16.0, color: Colors.black),
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelStyle: TextStyle(fontSize: 14.0),
                              labelText: 'From',
                              helperText: helperText,
                              helperStyle: TextStyle(
                                  color: showHelper
                                      ? Colors.redAccent
                                      : Colors.black38,
                                  fontStyle: showHelper
                                      ? FontStyle.italic
                                      : FontStyle.normal,
                                  fontSize: 14.0),
                            ),
                          ),
                        ),
                        Container(
                          width: width / 2.5,
                          child: DateTimePickerFormField(
                            format: dateFormat,
                            onChanged: (dt) => setState(() => dateEnd = dt),
                            dateOnly: true,
                            style: TextStyle(fontSize: 16.0, color: Colors.black),
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelStyle: TextStyle(fontSize: 14.0),
                              labelText: 'To',
                              helperText: '',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 20.0, right: 20.0, bottom: 20.0),
                    child: ButtonTheme(
                      minWidth: width / 2.5,
                      height: 40.0,
                      child: RaisedButton(
                        color: Colors.green,
                        child: Text(
                          'SEARCH',
                          style: TextStyle(fontSize: 13.0, color: Colors.white),
                        ),
                        onPressed: () {
                          setState(() {
                            if (dateStart.isAfter(dateEnd) == false) {
                              showDataFiltered = true;
                              showHelper = false;
                              helperText = '';
                            } else {
                              showDataFiltered = false;
                              showHelper = true;
                              helperText = "can\'t back date";
                            }
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
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
                      width: width,
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          StreamBuilder(
                              stream: Firestore.instance.collection('audit_internal').snapshots(),
                              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData)
                                  return Container(
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                
                                for (int i = 0; i < snapshot.data.documents.length; i++) {
                                  buttonView.add(false);
                                }

                                return Column(
                                  children: List.generate(snapshot.data.documents.length, (index) {
                                    if (snapshot.data.documents[index].data['status'] == 'DONE') {
                                      Timestamp tglbantu = snapshot.data.documents[index].data['auditStart'];
                                      return ListTile(
                                        onTap: null,
                                        title: Container(
                                          width: 150.0,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  object[index],
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        trailing: GestureDetector(
                                          onTap: () async {
                                            var iaNo;
                                            Firestore.instance.collection('audit_internal').document(snapshot.data.documents[index].documentID).snapshots().listen((data) {
                                              setState(() {
                                                totalCP = data.data['total_cp'];
                                                iaNo = data.data['iaNo'];
                                                auditee = data.data['auditee'];
                                                leadAuditor = data.data['leadAuditor'];
                                                auditor = data.data['subAreaAuditor'];
                                                pertanyaanAreaLuar = data.data['pertanyaanAreaLuar'];
                                                pertanyaanBOH = data.data['pertanyaanBoh'];
                                                pertanyaanCashier = data.data['pertanyaanCashier'];
                                                pertanyaanCashierAccuracy = data.data['pertanyaanCashierAccuracy'];
                                                pertanyaanDinningRoom = data.data['pertanyaanDinningArea'];
                                                pertanyaanFoodCompletely = data.data['pertanyaanFoodCooked'];
                                                pertanyaanPersonalHygiene = data.data['pertanyaanPersonal'];
                                                pertanyaanService = data.data['pertanyaanService'];
                                                pertanyaanSocialBlock = data.data['pertanyaanSocialBlock'];
                                                pertanyaanWareHouse = data.data['pertanyaanWarehouse'];

                                                idCollection = data.documentID;
                                                hasilAreaLuar = data.data['hasilAreaLuar'];
                                                hasilDinningArea = data.data['hasilDinningArea'];
                                                hasilService = data.data['hasilService'];
                                                hasilCashier = data.data['hasilCashier'];
                                                hasilCashierAccuracy = data.data['hasilCashierAccuracy'];
                                                hasilBoh = data.data['hasilBoh'];
                                                hasilWarehouse = data.data['hasilWarehouse'];
                                                hasilSocialBlock = data.data['hasilSocialBlock'];
                                                hasilPersonal = data.data['hasilPersonal'];
                                                hasilFoodCooked = data.data['hasilFoodCooked'];
                                                hasilGrafik = hasilAreaLuar + hasilDinningArea + hasilService + hasilCashier + hasilCashierAccuracy + hasilBoh + hasilWarehouse + hasilSocialBlock + hasilPersonal + hasilFoodCooked;

                                                AreaLuarScore = data.data['AreaLuar_score'];
                                                DinningAreaScore =
                                                data.data['DinningArea_score'];
                                                ServiceScore = data.data['Service_score'];
                                                CashierScore = data.data['Cashier_score'];
                                                CashierAccuracyScore =
                                                data.data['CashierAccuracy_score'];
                                                BohScore = data.data['Boh_score'];
                                                WarehouseScore = data.data['Warehouse_score'];
                                                SocialBlockScore =
                                                data.data['SocialBlock_score'];
                                                PersonalScore = data.data['Personal_score'];
                                                FoodCookedScore =
                                                data.data['FoodCooked_score'];

                                                criticalAreaLuar =
                                                data.data['criticalAreaLuar'];
                                                systemAreaLuar = data.data['sistemAreaLuar'];
                                                criticalDinningArea =
                                                data.data['criticalDinningArea'];
                                                systemDinningArea =
                                                data.data['sistemDinningArea'];
                                                criticalService =
                                                data.data['criticalService'];
                                                systemService = data.data['sistemService'];
                                                criticalCashier =
                                                data.data['criticalCashier'];
                                                systemCashier = data.data['sistemCashier'];
                                                criticalCashierAccuracy =
                                                data.data['criticalCashierAccuracy'];
                                                systemCashierAccuracy =
                                                data.data['sistemCashierAccuracy'];
                                                criticalBoh = data.data['criticalBoh'];
                                                systemBoh = data.data['sistemBoh'];
                                                criticalWarehouse =
                                                data.data['criticalWarehouse'];
                                                systemWarehouse =
                                                data.data['sistemWarehouse'];
                                                criticalSocialBlock =
                                                data.data['criticalSocialBlock'];
                                                systemSocialBlock =
                                                data.data['sistemSocialBlock'];
                                                criticalPersonal =
                                                data.data['criticalPersonal'];
                                                systemPersonal = data.data['sistemPersonal'];
                                                criticalFoodCooked =
                                                data.data['criticalFoodCooked'];
                                                systemFoodCooked =
                                                data.data['sistemFoodCooked'];
                                                outlet = object[index];
                                                Timestamp tanggalbantu = data['auditStart'];
                                                tanggal = tanggalbantu.toDate().toString().substring(8, 10) + '/' + tanggalbantu.toDate().toString().substring(5, 7) + '/' + tanggalbantu.toDate().toString().substring(0, 4);
                                                waktuStart = tanggalbantu.toDate().toString().substring(11, 16);
                                                if (data['auditEnd'] == null) {
                                                  waktuEnd = '00.00';
                                                } else {
                                                  Timestamp waktuEndBantu = data['auditEnd'];
                                                  waktuEnd = waktuEndBantu.toDate().toString().substring(11, 16);
                                                }
                                              });
                                            });

                                            setState(() {
                                              buttonView.removeAt(index);
                                              buttonView.insert(index, true);
                                            });
                                            await new Future.delayed(Duration(seconds: 3));
                                            setState(() {
                                              buttonView.removeAt(index);
                                              buttonView.insert(index, false);
                                            });

                                            Navigator.push(
                                              context,
                                              MyCustomRoute(
                                                builder: (context) => DetailReport(
                                                  totalCP: totalCP,
                                                  bobotPertanyaanAreaLuar: bobotPertanyaanAreaLuar[index],
                                                  bobotAreaLuar: bobotAreaLuar[index],
                                                  bobotPertanyaanDinningArea: bobotPertanyaanDinningArea[index],
                                                  bobotDinningArea: bobotDinningArea[index],
                                                  bobotPertanyaanService: bobotPertanyaanService[index],
                                                  bobotService: bobotService[index],
                                                  bobotPertanyaanCashier: bobotPertanyaanCashier[index],
                                                  bobotCashier: bobotCashier[index],
                                                  bobotPertanyaanCashierAccuracy: bobotPertanyaanCashierAccuracy[index],
                                                  bobotCashierAccuracy: bobotCashierAccuracy[index],
                                                  bobotPertanyaanBoh: bobotPertanyaanBoh[index],
                                                  bobotBoh: bobotBoh[index],
                                                  bobotPertanyaanWarehouse: bobotPertanyaanWarehouse[index],
                                                  bobotWarehouse: bobotWarehouse[index],
                                                  bobotPertanyaanPersonal: bobotPertanyaanPersonal[index],
                                                  bobotPersonal: bobotPersonal[index],
                                                  bobotPertanyaanFood: bobotPertanyaanFood[index],
                                                  bobotFood: bobotFood[index],
                                                  bobotSocial: bobotSocial[index],
                                                  bobotPertanyaanSocial: bobotPertanyaanSocial[index],
                                                  iaNo: iaNo,
                                                  departmentUser: widget.departmentUser,
                                                  auditee: auditee,
                                                  auditor: auditor,
                                                  leadauditor: leadAuditor,
                                                  idCollection: idCollection,
                                                  idUser: widget.idUser,
                                                  namaUser: widget.namaUser,
                                                  hasilGrafik: hasilGrafik,
                                                  hasilAreaLuar: hasilAreaLuar,
                                                  hasilDinningArea: hasilDinningArea,
                                                  hasilService: hasilService,
                                                  hasilCashier: hasilCashier,
                                                  hasilCashierAccuracy:
                                                  hasilCashierAccuracy,
                                                  hasilBoh: hasilBoh,
                                                  hasilWarehouse: hasilWarehouse,
                                                  hasilSocialBlock: hasilSocialBlock,
                                                  hasilPersonal: hasilPersonal,
                                                  hasilFoodCooked: hasilFoodCooked,
                                                  AreaLuarScore: AreaLuarScore,
                                                  DinningAreaScore: DinningAreaScore,
                                                  ServiceScore: ServiceScore,
                                                  CashierScore: CashierScore,
                                                  CashierAccuracyScore:
                                                  CashierAccuracyScore,
                                                  BohScore: BohScore,
                                                  WarehouseScore: WarehouseScore,
                                                  SocialBlockScore: SocialBlockScore,
                                                  PersonalScore: PersonalScore,
                                                  FoodCookedScore: FoodCookedScore,
                                                  criticalAreaLuar: criticalAreaLuar,
                                                  systemAreaLuar: systemAreaLuar,
                                                  criticalDinningArea: criticalDinningArea,
                                                  systemDinningArea: systemDinningArea,
                                                  criticalService: criticalService,
                                                  systemService: systemService,
                                                  criticalCashier: criticalCashier,
                                                  systemCashier: systemCashier,
                                                  criticalCashierAccuracy:
                                                  criticalCashierAccuracy,
                                                  systemCashierAccuracy:
                                                  systemCashierAccuracy,
                                                  criticalBoh: criticalBoh,
                                                  systemBoh: systemBoh,
                                                  criticalWarehouse: criticalWarehouse,
                                                  systemWarehouse: systemWarehouse,
                                                  criticalSocialBlock: criticalSocialBlock,
                                                  systemSocialBlock: systemSocialBlock,
                                                  criticalPersonal: criticalPersonal,
                                                  systemPersonal: systemPersonal,
                                                  criticalFoodCooked: criticalFoodCooked,
                                                  systemFoodCooked: systemFoodCooked,
                                                  outlet: outlet,
                                                  waktuStart: waktuStart,
                                                  waktuEnd: waktuEnd,
                                                  tanggal: tanggal,
                                                  pertanyaanAreaLuar: pertanyaanAreaLuar,
                                                  pertanyaanBOH: pertanyaanBOH,
                                                  pertanyaanCashier: pertanyaanCashier,
                                                  pertanyaanCashierAccuracy: pertanyaanCashierAccuracy,
                                                  pertanyaanDinningRoom: pertanyaanDinningRoom,
                                                  pertanyaanFoodCompletely: pertanyaanFoodCompletely,
                                                  pertanyaanPersonalHygiene: pertanyaanPersonalHygiene,
                                                  pertanyaanService: pertanyaanService,
                                                  pertanyaanSocialBlock: pertanyaanSocialBlock,
                                                  pertanyaanWareHouse: pertanyaanWareHouse
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            width: 150.0,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    buttonView[index]
                                                        ? 'Preparing data ...'
                                                        : tglbantu.toDate().toString().substring(8, 10) + '/' + tglbantu.toDate().toString().substring(5, 7) + '/' + tglbantu.toDate().toString().substring(0, 4),
                                                    style: TextStyle(
                                                        fontSize: 13.0,
                                                        color: buttonView[index]
                                                            ? Colors.black54
                                                            : Colors.blue),
                                                    textAlign: TextAlign.right,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  }),
                                );
                              })
                        ],
                      ),
                    );
              },
            )
          ],
        ),
      ),
    );
  }
}
