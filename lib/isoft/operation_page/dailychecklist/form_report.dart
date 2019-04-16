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

  List<dynamic> scoreParkingLobby       = [];
  List<dynamic> scoreDinningAreaLobby   = [];
  List<dynamic> scoreRestroomLobby      = [];
  List<dynamic> scoreGrillAreaDinning   = [];
  List<dynamic> scoreBarDinning         = [];
  List<dynamic> scoreProductionDinning  = [];
  List<dynamic> scoreWarehouseDinning   = [];
  List<dynamic> scoreMenuBoardPelayanan = [];
  List<dynamic> scoreServiceAreaPelayanan = [];
  List<dynamic> scoreGroomingPelayanan  = [];
  List<dynamic> scoreKeamananPelayanan  = [];
  List<dynamic> scoreKesiapanBisnis     = [];
  List<dynamic> scoreSteakCook          = [];
  List<dynamic> scoreBatterMixCook      = [];
  List<dynamic> scoreMixVegetablesCook  = [];
  List<dynamic> scorePotatoCook         = [];
  List<dynamic> scoreGrillerCook        = [];
  List<dynamic> scoreKeamananMakananCook = [];
  List<dynamic> scoreAreaCook           = [];
  List<dynamic> scoreKitchenCook        = [];
  List<dynamic> scoreDishwasherWash     = [];
  List<dynamic> scoreKeamananWash       = [];
  List<dynamic> scoreAlatWash           = [];

  List<dynamic> pertanyaanParkingLobby       = [];
  List<dynamic> pertanyaanDinningAreaLobby   = [];
  List<dynamic> pertanyaanRestroomLobby      = [];
  List<dynamic> pertanyaanGrillAreaDinning   = [];
  List<dynamic> pertanyaanBarDinning         = [];
  List<dynamic> pertanyaanProductionDinning  = [];
  List<dynamic> pertanyaanWarehouseDinning   = [];
  List<dynamic> pertanyaanMenuBoardPelayanan = [];
  List<dynamic> pertanyaanServiceAreaPelayanan = [];
  List<dynamic> pertanyaanGroomingPelayanan  = [];
  List<dynamic> pertanyaanKeamananPelayanan  = [];
  List<dynamic> pertanyaanKesiapanBisnis     = [];
  List<dynamic> pertanyaanSteakCook          = [];
  List<dynamic> pertanyaanBatterMixCook      = [];
  List<dynamic> pertanyaanMixVegetablesCook  = [];
  List<dynamic> pertanyaanPotatoCook         = [];
  List<dynamic> pertanyaanGrillerCook        = [];
  List<dynamic> pertanyaanKeamananMakananCook = [];
  List<dynamic> pertanyaanAreaCook           = [];
  List<dynamic> pertanyaanKitchenCook        = [];
  List<dynamic> pertanyaanDishwasherWash     = [];
  List<dynamic> pertanyaanKeamananWash       = [];
  List<dynamic> pertanyaanAlatWash           = [];

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
          elevation: 0.25,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Image.asset(
            'assets/images/logo2.png',
            height: 150.0,
            width: 120.0,
          ),
        ),
        body: _buildReport(width),
      ),
    );
  }

  Widget _buildReport(double width) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Daily Checklist',
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
                        /*print(dateStart);
                        print(dateEnd);*/
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
                  stream: showDataFiltered ? Firestore.instance.collection('dailychecklist').where('timeStart', isGreaterThanOrEqualTo: dateStart).orderBy('timeStart', descending: false).snapshots()
                      : Firestore.instance.collection('dailychecklist').orderBy('timeStart', descending: false).snapshots(),
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
                      children: List.generate(snapshot.data.documents.length,
                              (index) {
                            String counter = (index + 1).toString();
                            DateTime tanggalBantu = DateTime.tryParse(snapshot
                                .data.documents[index].data['timeStart']
                                .toString());
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
                                            counter,
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
                                          .collection('dailychecklist')
                                          .document(
                                          snapshot.data.documents[index].documentID)
                                          .snapshots()
                                          .listen((data) {
                                        setState(() {
                                          pertanyaanParkingLobby          = data.data['parkingLot_pertanyaan'];
                                          pertanyaanDinningAreaLobby      = data.data['dinningArea_pertanyaan'];
                                          pertanyaanRestroomLobby         = data.data['restroom_pertanyaan'];
                                          pertanyaanGrillAreaDinning      = data.data['grillArea_pertanyaan'];
                                          pertanyaanBarDinning            = data.data['bar_pertanyaan'];
                                          pertanyaanProductionDinning     = data.data['production_pertanyaan'];
                                          pertanyaanWarehouseDinning      = data.data['warehouse_pertanyaan'];
                                          pertanyaanMenuBoardPelayanan    = data.data['menuBoard_pertanyaan'];
                                          pertanyaanServiceAreaPelayanan  = data.data['serviceArea_pertanyaan'];
                                          pertanyaanGroomingPelayanan     = data.data['keamananPelayanan_pertanyaan'];
                                          pertanyaanKeamananPelayanan     = data.data['kesiapanBisnis_pertanyaan'];
                                          pertanyaanKesiapanBisnis        = data.data['steak_pertanyaan'];
                                          pertanyaanSteakCook             = data.data['batterMix_pertanyaan'];
                                          pertanyaanBatterMixCook         = data.data['mixVegetables_pertanyaan'];
                                          pertanyaanMixVegetablesCook     = data.data['potatoWedges_pertanyaan'];
                                          pertanyaanPotatoCook            = data.data['griller_pertanyaan'];
                                          pertanyaanGrillerCook           = data.data['keamananCook_pertanyaan'];
                                          pertanyaanKeamananMakananCook   = data.data['cookArea_pertanyaan'];
                                          pertanyaanAreaCook              = data.data['kitchenEquipment_pertanyaan'];
                                          pertanyaanKitchenCook           = data.data['dishwasherArea_pertanyaan'];
                                          pertanyaanDishwasherWash        = data.data['chiller_pertanyaan'];
                                          pertanyaanKeamananWash          = data.data['keamananWash_pertanyaan'];
                                          pertanyaanAlatWash              = data.data['alatKeamanan_pertanyaan'];

                                          idCollection = data.documentID;
                                          scoreParkingLobby         = data.data['parkingLot_score'];
                                          scoreDinningAreaLobby     = data.data['dinningArea_score'];
                                          scoreRestroomLobby        = data.data['restroom_score'];
                                          scoreGrillAreaDinning     = data.data['grillArea_score'];
                                          scoreBarDinning           = data.data['bar_score'];
                                          scoreProductionDinning    = data.data['production_score'];
                                          scoreWarehouseDinning     = data.data['warehouse_score'];
                                          scoreMenuBoardPelayanan   = data.data['menuBoard_score'];
                                          scoreServiceAreaPelayanan = data.data['serviceArea_score'];
                                          scoreGroomingPelayanan    = data.data['keamananPelayanan_score'];
                                          scoreKeamananPelayanan    = data.data['kesiapanBisnis_score'];
                                          scoreKesiapanBisnis       = data.data['steak_score'];
                                          scoreSteakCook            = data.data['batterMix_score'];
                                          scoreBatterMixCook        = data.data['mixVegetables_score'];
                                          scoreMixVegetablesCook    = data.data['potatoWedges_score'];
                                          scorePotatoCook           = data.data['griller_score'];
                                          scoreGrillerCook          = data.data['keamananCook_score'];
                                          scoreKeamananMakananCook  = data.data['cookArea_score'];
                                          scoreAreaCook             = data.data['kitchenEquipment_score'];
                                          scoreKitchenCook          = data.data['dishwasherArea_score'];
                                          scoreDishwasherWash       = data.data['chiller_score'];
                                          scoreKeamananWash         = data.data['keamananWash_score'];
                                          scoreAlatWash             = data.data['alatKeamanan_score'];
                                          tanggal = data['timeStart'].toString().substring(8, 10) + '/' + data['timeStart'].toString().substring(5, 7) + '/' + data['timeStart'].toString().substring(0, 4);
                                          waktuStart = data['timeStart'].toString().substring(11, 16);
                                          if (data['timeDone'] == null) {
                                            waktuEnd = '00.00';
                                          } else {
                                            waktuEnd = data['timeDone'].toString().substring(11, 16);
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
                                              waktuStart: waktuStart,
                                              waktuEnd: waktuEnd,
                                              tanggal: tanggal,
                                              scoreParkingLobby: scoreParkingLobby,
                                              scoreDinningAreaLobby: scoreDinningAreaLobby,
                                              scoreRestroomLobby: scoreRestroomLobby,
                                              scoreGrillAreaDinning: scoreGrillAreaDinning,
                                              scoreBarDinning: scoreBarDinning,
                                              scoreProductionDinning: scoreProductionDinning,
                                              scoreWarehouseDinning: scoreWarehouseDinning,
                                              scoreMenuBoardPelayanan: scoreMenuBoardPelayanan,
                                              scoreServiceAreaPelayanan: scoreServiceAreaPelayanan,
                                              scoreGroomingPelayanan: scoreGroomingPelayanan,
                                              scoreKeamananPelayanan: scoreKeamananPelayanan,
                                              scoreKesiapanBisnis: scoreKesiapanBisnis,
                                              scoreSteakCook: scoreSteakCook,
                                              scoreBatterMixCook: scoreBatterMixCook,
                                              scoreMixVegetablesCook: scoreMixVegetablesCook,
                                              scorePotatoCook: scorePotatoCook,
                                              scoreGrillerCook: scoreGrillerCook,
                                              scoreKeamananMakananCook: scoreKeamananMakananCook,
                                              scoreAreaCook: scoreAreaCook,
                                              scoreKitchenCook: scoreKitchenCook,
                                              scoreDishwasherWash: scoreDishwasherWash,
                                              scoreKeamananWash: scoreKeamananWash,
                                              scoreAlatWash: scoreAlatWash,
                                              pertanyaanParkingLobby: pertanyaanParkingLobby,
                                              pertanyaanDinningAreaLobby: pertanyaanDinningAreaLobby,
                                              pertanyaanRestroomLobby: pertanyaanRestroomLobby,
                                              pertanyaanGrillAreaDinning: pertanyaanGrillAreaDinning,
                                              pertanyaanBarDinning: pertanyaanBarDinning,
                                              pertanyaanProductionDinning: pertanyaanProductionDinning,
                                              pertanyaanWarehouseDinning: pertanyaanWarehouseDinning,
                                              pertanyaanMenuBoardPelayanan: pertanyaanMenuBoardPelayanan,
                                              pertanyaanServiceAreaPelayanan: pertanyaanServiceAreaPelayanan,
                                              pertanyaanGroomingPelayanan: pertanyaanGroomingPelayanan,
                                              pertanyaanKeamananPelayanan: pertanyaanKeamananPelayanan,
                                              pertanyaanKesiapanBisnis: pertanyaanKesiapanBisnis,
                                              pertanyaanSteakCook: pertanyaanSteakCook,
                                              pertanyaanBatterMixCook: pertanyaanBatterMixCook,
                                              pertanyaanMixVegetablesCook: pertanyaanMixVegetablesCook,
                                              pertanyaanPotatoCook: pertanyaanPotatoCook,
                                              pertanyaanGrillerCook: pertanyaanGrillerCook,
                                              pertanyaanKeamananMakananCook: pertanyaanKeamananMakananCook,
                                              pertanyaanAreaCook: pertanyaanAreaCook,
                                              pertanyaanKitchenCook: pertanyaanKitchenCook,
                                              pertanyaanDishwasherWash: pertanyaanDishwasherWash,
                                              pertanyaanKeamananWash: pertanyaanKeamananWash,
                                              pertanyaanAlatWash: pertanyaanAlatWash,
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
                                                  : snapshot.data.documents[index].data['timeStart'].toString().substring(8, 10) + '/' + snapshot.data.documents[index].data['timeStart'].toString().substring(5, 7) + '/' + snapshot.data.documents[index].data['timeStart'].toString().substring(0, 4),
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
                                            counter,
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
                                          .collection('dailychecklist')
                                          .document(
                                          snapshot.data.documents[index].documentID)
                                          .snapshots()
                                          .listen((data) {
                                        setState(() {
                                          pertanyaanParkingLobby          = data.data['parkingLot_pertanyaan'];
                                          pertanyaanDinningAreaLobby      = data.data['dinningArea_pertanyaan'];
                                          pertanyaanRestroomLobby         = data.data['restroom_pertanyaan'];
                                          pertanyaanGrillAreaDinning      = data.data['grillArea_pertanyaan'];
                                          pertanyaanBarDinning            = data.data['bar_pertanyaan'];
                                          pertanyaanProductionDinning     = data.data['production_pertanyaan'];
                                          pertanyaanWarehouseDinning      = data.data['warehouse_pertanyaan'];
                                          pertanyaanMenuBoardPelayanan    = data.data['menuBoard_pertanyaan'];
                                          pertanyaanServiceAreaPelayanan  = data.data['serviceArea_pertanyaan'];
                                          pertanyaanGroomingPelayanan     = data.data['keamananPelayanan_pertanyaan'];
                                          pertanyaanKeamananPelayanan     = data.data['kesiapanBisnis_pertanyaan'];
                                          pertanyaanKesiapanBisnis        = data.data['steak_pertanyaan'];
                                          pertanyaanSteakCook             = data.data['batterMix_pertanyaan'];
                                          pertanyaanBatterMixCook         = data.data['mixVegetables_pertanyaan'];
                                          pertanyaanMixVegetablesCook     = data.data['potatoWedges_pertanyaan'];
                                          pertanyaanPotatoCook            = data.data['griller_pertanyaan'];
                                          pertanyaanGrillerCook           = data.data['keamananCook_pertanyaan'];
                                          pertanyaanKeamananMakananCook   = data.data['cookArea_pertanyaan'];
                                          pertanyaanAreaCook              = data.data['kitchenEquipment_pertanyaan'];
                                          pertanyaanKitchenCook           = data.data['dishwasherArea_pertanyaan'];
                                          pertanyaanDishwasherWash        = data.data['chiller_pertanyaan'];
                                          pertanyaanKeamananWash          = data.data['keamananWash_pertanyaan'];
                                          pertanyaanAlatWash              = data.data['alatKeamanan_pertanyaan'];

                                          idCollection = data.documentID;
                                          scoreParkingLobby         = data.data['parkingLot_score'];
                                          scoreDinningAreaLobby     = data.data['dinningArea_score'];
                                          scoreRestroomLobby        = data.data['restroom_score'];
                                          scoreGrillAreaDinning     = data.data['grillArea_score'];
                                          scoreBarDinning           = data.data['bar_score'];
                                          scoreProductionDinning    = data.data['production_score'];
                                          scoreWarehouseDinning     = data.data['warehouse_score'];
                                          scoreMenuBoardPelayanan   = data.data['menuBoard_score'];
                                          scoreServiceAreaPelayanan = data.data['serviceArea_score'];
                                          scoreGroomingPelayanan    = data.data['keamananPelayanan_score'];
                                          scoreKeamananPelayanan    = data.data['kesiapanBisnis_score'];
                                          scoreKesiapanBisnis       = data.data['steak_score'];
                                          scoreSteakCook            = data.data['batterMix_score'];
                                          scoreBatterMixCook        = data.data['mixVegetables_score'];
                                          scoreMixVegetablesCook    = data.data['potatoWedges_score'];
                                          scorePotatoCook           = data.data['griller_score'];
                                          scoreGrillerCook          = data.data['keamananCook_score'];
                                          scoreKeamananMakananCook  = data.data['cookArea_score'];
                                          scoreAreaCook             = data.data['kitchenEquipment_score'];
                                          scoreKitchenCook          = data.data['dishwasherArea_score'];
                                          scoreDishwasherWash       = data.data['chiller_score'];
                                          scoreKeamananWash         = data.data['keamananWash_score'];
                                          scoreAlatWash             = data.data['alatKeamanan_score'];
                                          tanggal = data['timeStart'].toString().substring(8, 10) + '/' + data['timeStart'].toString().substring(5, 7) + '/' + data['timeStart'].toString().substring(0, 4);
                                          waktuStart = data['timeStart'].toString().substring(11, 16);
                                          if (data['timeDone'] == null) {
                                            waktuEnd = '00.00';
                                          } else {
                                            waktuEnd = data['timeDone'].toString().substring(11, 16);
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
                                            waktuStart: waktuStart,
                                            waktuEnd: waktuEnd,
                                            tanggal: tanggal,
                                            scoreParkingLobby: scoreParkingLobby,
                                            scoreDinningAreaLobby: scoreDinningAreaLobby,
                                            scoreRestroomLobby: scoreRestroomLobby,
                                            scoreGrillAreaDinning: scoreGrillAreaDinning,
                                            scoreBarDinning: scoreBarDinning,
                                            scoreProductionDinning: scoreProductionDinning,
                                            scoreWarehouseDinning: scoreWarehouseDinning,
                                            scoreMenuBoardPelayanan: scoreMenuBoardPelayanan,
                                            scoreServiceAreaPelayanan: scoreServiceAreaPelayanan,
                                            scoreGroomingPelayanan: scoreGroomingPelayanan,
                                            scoreKeamananPelayanan: scoreKeamananPelayanan,
                                            scoreKesiapanBisnis: scoreKesiapanBisnis,
                                            scoreSteakCook: scoreSteakCook,
                                            scoreBatterMixCook: scoreBatterMixCook,
                                            scoreMixVegetablesCook: scoreMixVegetablesCook,
                                            scorePotatoCook: scorePotatoCook,
                                            scoreGrillerCook: scoreGrillerCook,
                                            scoreKeamananMakananCook: scoreKeamananMakananCook,
                                            scoreAreaCook: scoreAreaCook,
                                            scoreKitchenCook: scoreKitchenCook,
                                            scoreDishwasherWash: scoreDishwasherWash,
                                            scoreKeamananWash: scoreKeamananWash,
                                            scoreAlatWash: scoreAlatWash,
                                            pertanyaanParkingLobby: pertanyaanParkingLobby,
                                            pertanyaanDinningAreaLobby: pertanyaanDinningAreaLobby,
                                            pertanyaanRestroomLobby: pertanyaanRestroomLobby,
                                            pertanyaanGrillAreaDinning: pertanyaanGrillAreaDinning,
                                            pertanyaanBarDinning: pertanyaanBarDinning,
                                            pertanyaanProductionDinning: pertanyaanProductionDinning,
                                            pertanyaanWarehouseDinning: pertanyaanWarehouseDinning,
                                            pertanyaanMenuBoardPelayanan: pertanyaanMenuBoardPelayanan,
                                            pertanyaanServiceAreaPelayanan: pertanyaanServiceAreaPelayanan,
                                            pertanyaanGroomingPelayanan: pertanyaanGroomingPelayanan,
                                            pertanyaanKeamananPelayanan: pertanyaanKeamananPelayanan,
                                            pertanyaanKesiapanBisnis: pertanyaanKesiapanBisnis,
                                            pertanyaanSteakCook: pertanyaanSteakCook,
                                            pertanyaanBatterMixCook: pertanyaanBatterMixCook,
                                            pertanyaanMixVegetablesCook: pertanyaanMixVegetablesCook,
                                            pertanyaanPotatoCook: pertanyaanPotatoCook,
                                            pertanyaanGrillerCook: pertanyaanGrillerCook,
                                            pertanyaanKeamananMakananCook: pertanyaanKeamananMakananCook,
                                            pertanyaanAreaCook: pertanyaanAreaCook,
                                            pertanyaanKitchenCook: pertanyaanKitchenCook,
                                            pertanyaanDishwasherWash: pertanyaanDishwasherWash,
                                            pertanyaanKeamananWash: pertanyaanKeamananWash,
                                            pertanyaanAlatWash: pertanyaanAlatWash,
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
                                                  : snapshot.data.documents[index].data['timeStart'].toString().substring(8, 10) + '/' + snapshot.data.documents[index].data['timeStart'].toString().substring(5, 7) + '/' + snapshot.data.documents[index].data['timeStart'].toString().substring(0, 4),
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
