import 'dart:async';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'detail_report.dart';

class FormReport extends StatefulWidget {
  @override
  _FormReportState createState() => _FormReportState();

  final int idUser;
  final String namaUser;
  final String departmentUser;
  FormReport({this.idUser, this.namaUser, this.departmentUser});
}

class _FormReportState extends State<FormReport> {
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

  List<bool> buttonView = [];
  bool showDataFiltered = false;
  bool showHelper = false;
  String helperText = '';
  String outlet;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 1.0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Text('Report', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black),),
              ),
              /*Stack(
                children: <Widget>[
                  Icon(Icons.notifications, color: Colors.grey[400],)
                ],
              )*/
            ],
          ),
        ),
        body: _buildReport(width),
      ),
    );
  }

  Widget _buildReport(double width) {
    return ListView(
      children: <Widget>[
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
              /*Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                child: DropdownButtonFormField(
                  hint: Text('Shift', style: TextStyle(fontSize: 14.0)),
                  value: _mySelection,
                  onChanged: (String newValue) {
                    setState(() {
                      switch (int.tryParse(newValue)) {
                        case 1:
                          _shift = 'Shift A';
                          break;
                        case 2:
                          _shift = 'Shift B';
                          break;
                        default:
                          _shift = '-';
                          break;
                      }
                      _mySelection = newValue;
                    });
                  },
                  items: _shiftJson.map((Map map) {
                    return new DropdownMenuItem(
                      value: map['id'].toString(),
                      child: Text(map['shift']),
                    );
                  }).toList(),
                ),
              ),*/
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
        Container(
          width: width,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              StreamBuilder(
                  stream: showDataFiltered ? Firestore.instance.collection('linecheck').where('timeStart', isGreaterThanOrEqualTo: dateStart).orderBy('timeStart', descending: false).snapshots()
                      : Firestore.instance.collection('linecheck').orderBy('timeStart', descending: false).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData && snapshot.data == null)
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
                        Timestamp tglbantu = snapshot.data.documents[index].data['timeStart'];
                        DateTime tanggalBantu = DateTime.tryParse(tglbantu.toDate().toString());
                        if (showDataFiltered && dateEnd != null && dateStart != null) {
                          if (tanggalBantu.isAfter(dateEnd.subtract(Duration(days: -1))) == true || snapshot.data.documents[index].data['timeDone'] == null) {
                            return Container ();
                          }else{
                            return ListTile(
                              onTap: null,
                              title: Container(
                                width: 150.0,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        snapshot
                                            .data.documents[index].data['outlet']
                                            .toString(),
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
                                  Firestore.instance
                                      .collection('linecheck')
                                      .document(
                                      snapshot.data.documents[index].documentID)
                                      .snapshots()
                                      .listen((data) {
                                    setState(() {
                                      pertanyaanAreaLuar = data.data['pertanyaanAreaLuar'];
                                      pertanyaanBOH = data.data['pertanyaanBoh'];
                                      pertanyaanCashier = data.data['pertanyaanCashier'];
                                      pertanyaanCashierAccuracy = data.data['pertanyaanCashierAccuracy'];
                                      pertanyaanDinningRoom = data.data['pertanyaanCashierAccuracy'];
                                      pertanyaanFoodCompletely = data.data['pertanyaanFoodCooked'];
                                      pertanyaanPersonalHygiene = data.data['pertanyaanPersonal'];
                                      pertanyaanService = data.data['pertanyaanService'];
                                      pertanyaanSocialBlock = data.data['pertanyaanSocialBlock'];
                                      pertanyaanWareHouse = data.data['pertanyaanWarehouse'];

                                      idCollection = data.documentID;
                                      hasilAreaLuar = data.data['hasilAreaLuar'];
                                      hasilDinningArea =
                                      data.data['hasilDinningArea'];
                                      hasilService = data.data['hasilService'];
                                      hasilCashier = data.data['hasilCashier'];
                                      hasilCashierAccuracy =
                                      data.data['hasilCashierAccuracy'];
                                      hasilBoh = data.data['hasilBoh'];
                                      hasilWarehouse = data.data['hasilWarehouse'];
                                      hasilSocialBlock =
                                      data.data['hasilSocialBlock'];
                                      hasilPersonal = data.data['hasilPersonal'];
                                      hasilFoodCooked =
                                      data.data['hasilFoodCooked'];
                                      hasilGrafik = data.data['hasilGrafik'];

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
                                      outlet = data.data['outlet'];
                                      Timestamp tanggalbantu = data['timeStart'];
                                      tanggal = tanggalbantu.toDate().toString().substring(8, 10) + '/' + tanggalbantu.toDate().toString().substring(5, 7) + '/' + tanggalbantu.toDate().toString().substring(0, 4);
                                      waktuStart = tanggalbantu.toDate().toString().substring(11, 16);
                                      if (data['timeDone'] == null) {
                                        waktuEnd = '00.00';
                                      } else {
                                        Timestamp waktuEndBantu = data['timeDone'];
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
                          }
                        }else{
                          if (snapshot.data.documents[index].data['timeDone'] == null) {
                            return Container();
                          }else{
                            return ListTile(
                              onTap: null,
                              title: Container(
                                width: 150.0,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        snapshot
                                            .data.documents[index].data['outlet']
                                            .toString(),
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
                                  Firestore.instance
                                      .collection('linecheck')
                                      .document(
                                      snapshot.data.documents[index].documentID)
                                      .snapshots()
                                      .listen((data) {
                                    setState(() {
                                      pertanyaanAreaLuar = data.data['pertanyaanAreaLuar'];
                                      pertanyaanBOH = data.data['pertanyaanBoh'];
                                      pertanyaanCashier = data.data['pertanyaanCashier'];
                                      pertanyaanCashierAccuracy = data.data['pertanyaanCashierAccuracy'];
                                      pertanyaanDinningRoom = data.data['pertanyaanCashierAccuracy'];
                                      pertanyaanFoodCompletely = data.data['pertanyaanFoodCooked'];
                                      pertanyaanPersonalHygiene = data.data['pertanyaanPersonal'];
                                      pertanyaanService = data.data['pertanyaanService'];
                                      pertanyaanSocialBlock = data.data['pertanyaanSocialBlock'];
                                      pertanyaanWareHouse = data.data['pertanyaanWarehouse'];

                                      idCollection = data.documentID;
                                      hasilAreaLuar = data.data['hasilAreaLuar'];
                                      hasilDinningArea =
                                      data.data['hasilDinningArea'];
                                      hasilService = data.data['hasilService'];
                                      hasilCashier = data.data['hasilCashier'];
                                      hasilCashierAccuracy =
                                      data.data['hasilCashierAccuracy'];
                                      hasilBoh = data.data['hasilBoh'];
                                      hasilWarehouse = data.data['hasilWarehouse'];
                                      hasilSocialBlock =
                                      data.data['hasilSocialBlock'];
                                      hasilPersonal = data.data['hasilPersonal'];
                                      hasilFoodCooked =
                                      data.data['hasilFoodCooked'];
                                      hasilGrafik = data.data['hasilGrafik'];

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
                                      outlet = data.data['outlet'];
                                      Timestamp tanggalbantu = data['timeStart'];
                                      tanggal = tanggalbantu.toDate().toString().substring(8, 10) + '/' + tanggalbantu.toDate().toString().substring(5, 7) + '/' + tanggalbantu.toDate().toString().substring(0, 4);
                                      waktuStart = tanggalbantu.toDate().toString().substring(11, 16);
                                      if (data['timeDone'] == null) {
                                        waktuEnd = '00.00';
                                      } else {
                                        Timestamp waktuEndBantu = data['timeDone'];
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
                                          pertanyaanWareHouse: pertanyaanWareHouse,
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
                          }
                        }
                      }),
                    );
                  })
            ],
          ),
        )
      ],
    );
  }
}
