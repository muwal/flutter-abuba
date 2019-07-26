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

class _FormReportState extends State<FormReport> with TickerProviderStateMixin {
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

  List<dynamic> scoreParkingLobbyBantu = [];
  List<dynamic> scoreDinningAreaLobbyBantu = [];
  List<dynamic> scoreRestroomLobbyBantu = [];
  List<dynamic> scoreGrillAreaDinningBantu = [];
  List<dynamic> scoreBarDinningBantu = [];
  List<dynamic> scoreProductionDinningBantu = [];
  List<dynamic> scoreWarehouseDinningBantu = [];
  List<dynamic> scoreMenuBoardPelayananBantu = [];
  List<dynamic> scoreServiceAreaPelayananBantu = [];
  List<dynamic> scoreGroomingPelayananBantu = [];
  List<dynamic> scoreKeamananPelayananBantu = [];
  List<dynamic> scoreKesiapanBisnisBantu = [];
  List<dynamic> scoreSteakCookBantu = [];
  List<dynamic> scoreBatterMixCookBantu = [];
  List<dynamic> scoreMixVegetablesCookBantu = [];
  List<dynamic> scorePotatoCookBantu = [];
  List<dynamic> scoreGrillerCookBantu = [];
  List<dynamic> scoreKeamananMakananCookBantu = [];
  List<dynamic> scoreAreaCookBantu = [];
  List<dynamic> scoreKitchenCookBantu = [];
  List<dynamic> scoreDishwasherWashBantu = [];
  List<dynamic> scoreChillerWashBantu = [];
  List<dynamic> scoreKeamananWashBantu = [];
  List<dynamic> scoreAlatWashBantu = [];
  List<dynamic> pertanyaanParkingLobbyBantu = [];
  List<dynamic> pertanyaanDinningAreaLobbyBantu = [];
  List<dynamic> pertanyaanRestroomLobbyBantu = [];
  List<dynamic> pertanyaanGrillAreaDinningBantu = [];
  List<dynamic> pertanyaanBarDinningBantu = [];
  List<dynamic> pertanyaanProductionDinningBantu = [];
  List<dynamic> pertanyaanWarehouseDinningBantu = [];
  List<dynamic> pertanyaanMenuBoardPelayananBantu = [];
  List<dynamic> pertanyaanServiceAreaPelayananBantu = [];
  List<dynamic> pertanyaanGroomingPelayananBantu = [];
  List<dynamic> pertanyaanKeamananPelayananBantu = [];
  List<dynamic> pertanyaanKesiapanBisnisBantu = [];
  List<dynamic> pertanyaanSteakCookBantu = [];
  List<dynamic> pertanyaanBatterMixCookBantu = [];
  List<dynamic> pertanyaanMixVegetablesCookBantu = [];
  List<dynamic> pertanyaanPotatoCookBantu = [];
  List<dynamic> pertanyaanGrillerCookBantu = [];
  List<dynamic> pertanyaanKeamananMakananCookBantu = [];
  List<dynamic> pertanyaanAreaCookBantu = [];
  List<dynamic> pertanyaanKitchenCookBantu = [];
  List<dynamic> pertanyaanDishwasherWashBantu = [];
  List<dynamic> pertanyaanChillerWashBantu = [];
  List<dynamic> pertanyaanKeamananWashBantu = [];
  List<dynamic> pertanyaanAlatWashBantu = [];

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
  List<dynamic> scoreChillerWash     = [];
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
  List<dynamic> pertanyaanChillerWash        = [];
  List<dynamic> pertanyaanKeamananWash       = [];
  List<dynamic> pertanyaanAlatWash           = [];

  int jmlNoParkingLobby = 0;
  int jmlNoDinningAreaLobby = 0;
  int jmlNoRestroomLobby = 0;
  int jmlNoGrillAreaDinning = 0;
  int jmlNoBarDinning = 0;
  int jmlNoProductionDinning = 0;
  int jmlNoWarehouseDinning = 0;
  int jmlNoMenuBoardPelayanan = 0;
  int jmlNoServiceAreaPelayanan = 0;
  int jmlNoGroomingPelayanan = 0;
  int jmlNoKeamananPelayanan = 0;
  int jmlNoKesiapanBisnis = 0;
  int jmlNoSteakCook = 0;
  int jmlNoBatterMixCook = 0;
  int jmlNoMixVegetablesCook = 0;
  int jmlNoPotatoCook = 0;
  int jmlNoGrillerCook = 0;
  int jmlNoKeamananMakananCook = 0;
  int jmlNoAreaCook = 0;
  int jmlNoKitchenCook = 0;
  int jmlNoDishwasherWash = 0;
  int jmlNoChillerWash = 0;
  int jmlNoKeamananWash = 0;
  int jmlNoAlatWash = 0;

  int hasilLobby = 0;
  int hasilDinning = 0;
  int hasilPelayanan = 0;
  int hasilAreaCook = 0;
  int hasilWash = 0;

  int jmlYesParkingLobby = 0;
  int jmlYesDinningAreaLobby = 0;
  int jmlYesRestroomLobby = 0;
  int jmlYesGrillAreaDinning = 0;
  int jmlYesBarDinning = 0;
  int jmlYesProductionDinning = 0;
  int jmlYesWarehouseDinning = 0;
  int jmlYesMenuBoardPelayanan = 0;
  int jmlYesServiceAreaPelayanan = 0;
  int jmlYesGroomingPelayanan = 0;
  int jmlYesKeamananPelayanan = 0;
  int jmlYesKesiapanBisnis = 0;
  int jmlYesSteakCook = 0;
  int jmlYesBatterMixCook = 0;
  int jmlYesMixVegetablesCook = 0;
  int jmlYesPotatoCook = 0;
  int jmlYesGrillerCook = 0;
  int jmlYesKeamananMakananCook = 0;
  int jmlYesAreaCook = 0;
  int jmlYesKitchenCook = 0;
  int jmlYesDishwasherWash = 0;
  int jmlYesChillerWash = 0;
  int jmlYesKeamananWash = 0;
  int jmlYesAlatWash = 0;

  int jmlPertanyaan = 0;

  int hasilYesLobby = 0;
  int hasilYesDinning = 0;
  int hasilYesPelayanan = 0;
  int hasilYesAreaCook = 0;
  int hasilYesWash = 0;

  int hasilPertama = 0;
  double hasilKedua = 0.0;
  Color colorGrafik = Colors.green;

  List<bool> buttonView = [];
  bool showDataFiltered = false;
  bool showHelper = false;
  String helperText = '';
  String outlet;

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(
        from:
        animationController.value == 0.0 ? 1.0 : animationController.value);
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
        body: AnimatedBuilder(
        animation: animationController,
        builder: (_, Widget child) {
    return animationController.isAnimating
    ? Container(
    child: Center(
    child: CircularProgressIndicator(),
    ),
    )
        : _buildReport(width); }),
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
                            Timestamp tanggalStart = snapshot.data.documents[index].data['timeStart'];
                            Timestamp tanggalDone = snapshot.data.documents[index].data['timeDone'];
                            DateTime tanggalBantu = DateTime.tryParse(tanggalStart.toDate().toString());

                            /*for (var i = 0; i < snapshot.data.documents[index].data['parkingLot_score'].length; i++) {
                              if (snapshot.data.documents[index].data['parkingLot_score'][i] == 0) {
                                jmlNoParkingLobby++;
                              } else if (snapshot.data.documents[index].data['parkingLot_score'][i] == 2) {
                                jmlYesParkingLobby++;
                              }
                            }*/

                            /*for (var i = 0; i < snapshot.data.documents[index].data['dinningArea_score'].length; i++) {
                              if (snapshot.data.documents[index].data['dinningArea_score'][i] == 0) {
                                jmlNoDinningAreaLobby++;
                              } else if (snapshot.data.documents[index].data['dinningArea_score'][i] == 2) {
                                jmlYesDinningAreaLobby++;
                              }
                            }

                            for (var i = 0; i < snapshot.data.documents[index].data['restroom_score'].length; i++) {
                              if (snapshot.data.documents[index].data['restroom_score'][i] == 0) {
                                jmlNoRestroomLobby++;
                              } else if (snapshot.data.documents[index].data['restroom_score'][i] == 2) {
                                jmlYesRestroomLobby++;
                              }
                            }

                            for (var i = 0; i < snapshot.data.documents[index].data['grillArea_score'].length; i++) {
                              if (snapshot.data.documents[index].data['grillArea_score'][i] == 0) {
                                jmlNoGrillAreaDinning++;
                              } else if (snapshot.data.documents[index].data['grillArea_score'][i] == 2) {
                                jmlYesGrillAreaDinning++;
                              }
                            }

                            for (var i = 0; i < snapshot.data.documents[index].data['bar_score'].length; i++) {
                              if (snapshot.data.documents[index].data['bar_score'][i] == 0) {
                                jmlNoBarDinning++;
                              } else if (snapshot.data.documents[index].data['bar_score'][i] == 2) {
                                jmlYesBarDinning++;
                              }
                            }

                            for (var i = 0; i < snapshot.data.documents[index].data['production_score'].length; i++) {
                              if (snapshot.data.documents[index].data['production_score'][i] == 0) {
                                jmlNoProductionDinning++;
                              } else if (snapshot.data.documents[index].data['production_score'][i] == 2) {
                                jmlYesProductionDinning++;
                              }
                            }

                            for (var i = 0; i < snapshot.data.documents[index].data['warehouse_score'].length; i++) {
                              if (snapshot.data.documents[index].data['warehouse_score'][i] == 0) {
                                jmlNoWarehouseDinning++;
                              } else if (snapshot.data.documents[index].data['warehouse_score'][i] == 2) {
                                jmlYesWarehouseDinning++;
                              }
                            }

                            for (var i = 0; i < snapshot.data.documents[index].data['menuBoard_score'].length; i++) {
                              if (snapshot.data.documents[index].data['menuBoard_score'][i] == 0) {
                                jmlNoMenuBoardPelayanan++;
                              } else if (snapshot.data.documents[index].data['menuBoard_score'][i] == 2) {
                                jmlYesMenuBoardPelayanan++;
                              }
                            }

                            for (var i = 0; i < snapshot.data.documents[index].data['serviceArea_score'].length; i++) {
                              if (snapshot.data.documents[index].data['serviceArea_score'][i] == 0) {
                                jmlNoServiceAreaPelayanan++;
                              } else if (snapshot.data.documents[index].data['serviceArea_score'][i] == 2) {
                                jmlYesServiceAreaPelayanan++;
                              }
                            }

                            for (var i = 0; i < snapshot.data.documents[index].data['grooming_score'].length; i++) {
                              if (snapshot.data.documents[index].data['grooming_score'][i] == 0) {
                                jmlNoGroomingPelayanan++;
                              } else if (snapshot.data.documents[index].data['grooming_score'][i] == 2) {
                                jmlYesGroomingPelayanan++;
                              }
                            }

                            for (var i = 0; i < snapshot.data.documents[index].data['keamananPelayanan_score'].length; i++) {
                              if (snapshot.data.documents[index].data['keamananPelayanan_score'][i] == 0) {
                                jmlNoKeamananPelayanan++;
                              } else if (snapshot.data.documents[index].data['keamananPelayanan_score'][i] == 2) {
                                jmlYesKeamananPelayanan++;
                              }
                            }

                            for (var i = 0; i < snapshot.data.documents[index].data['kesiapanBisnis_score'].length; i++) {
                              if (snapshot.data.documents[index].data['kesiapanBisnis_score'][i] == 0) {
                                jmlNoKesiapanBisnis++;
                              } else if (snapshot.data.documents[index].data['kesiapanBisnis_score'][i] == 2) {
                                jmlYesKesiapanBisnis++;
                              }
                            }

                            for (var i = 0; i < snapshot.data.documents[index].data['steak_score'].length; i++) {
                              if (snapshot.data.documents[index].data['steak_score'][i] == 0) {
                                jmlNoSteakCook++;
                              } else if (snapshot.data.documents[index].data['steak_score'][i] == 2) {
                                jmlYesSteakCook++;
                              }
                            }

                            for (var i = 0; i < snapshot.data.documents[index].data['batterMix_score'].length; i++) {
                              if (snapshot.data.documents[index].data['batterMix_score'][i] == 0) {
                                jmlNoBatterMixCook++;
                              } else if (snapshot.data.documents[index].data['batterMix_score'][i] == 2) {
                                jmlYesBatterMixCook++;
                              }
                            }

                            for (var i = 0; i < snapshot.data.documents[index].data['mixVegetables_score'].length; i++) {
                              if (snapshot.data.documents[index].data['mixVegetables_score'][i] == 0) {
                                jmlNoMixVegetablesCook++;
                              } else if (snapshot.data.documents[index].data['mixVegetables_score'][i] == 2) {
                                jmlYesMixVegetablesCook++;
                              }
                            }

                            for (var i = 0; i < snapshot.data.documents[index].data['potatoWedges_score'].length; i++) {
                              if (snapshot.data.documents[index].data['potatoWedges_score'][i] == 0) {
                                jmlNoPotatoCook++;
                              } else if (snapshot.data.documents[index].data['potatoWedges_score'][i] == 2) {
                                jmlYesPotatoCook++;
                              }
                            }

                            for (var i = 0; i < snapshot.data.documents[index].data['griller_score'].length; i++) {
                              if (snapshot.data.documents[index].data['griller_score'][i] == 0) {
                                jmlNoGrillerCook++;
                              } else if (snapshot.data.documents[index].data['griller_score'][i] == 2) {
                                jmlYesGrillerCook++;
                              }
                            }

                            for (var i = 0; i < snapshot.data.documents[index].data['keamananCook_score'].length; i++) {
                              if (snapshot.data.documents[index].data['keamananCook_score'][i] == 0) {
                                jmlNoKeamananMakananCook++;
                              } else if (snapshot.data.documents[index].data['keamananCook_score'][i] == 2) {
                                jmlYesKeamananMakananCook++;
                              }
                            }

                            for (var i = 0; i < snapshot.data.documents[index].data['cookArea_score'].length; i++) {
                              if (snapshot.data.documents[index].data['cookArea_score'][i] == 0) {
                                jmlNoAreaCook++;
                              } else if (snapshot.data.documents[index].data['cookArea_score'][i] == 2) {
                                jmlYesAreaCook++;
                              }
                            }

                            for (var i = 0; i < snapshot.data.documents[index].data['kitchenEquipment_score'].length; i++) {
                              if (snapshot.data.documents[index].data['kitchenEquipment_score'][i] == 0) {
                                jmlNoKitchenCook++;
                              }else if (snapshot.data.documents[index].data['kitchenEquipment_score'][i] == 2) {
                                jmlYesKitchenCook++;
                              }
                            }

                            for (var i = 0; i < snapshot.data.documents[index].data['dishwasherArea_score'].length; i++) {
                              if (snapshot.data.documents[index].data['dishwasherArea_score'][i] == 0) {
                                jmlNoDishwasherWash++;
                              } else if (snapshot.data.documents[index].data['dishwasherArea_score'][i] == 2) {
                                jmlYesDishwasherWash++;
                              }
                            }

                            for (var i = 0; i < snapshot.data.documents[index].data['chiller_score'].length; i++) {
                              if (snapshot.data.documents[index].data['chiller_score'][i] == 0) {
                                jmlNoChillerWash++;
                              } else if (snapshot.data.documents[index].data['chiller_score'][i] == 2) {
                                jmlYesChillerWash++;
                              }
                            }

                            for (var i = 0; i < snapshot.data.documents[index].data['keamananWash_score'].length; i++) {
                              if (snapshot.data.documents[index].data['keamananWash_score'][i] == 0) {
                                jmlNoKeamananWash++;
                              } else if (snapshot.data.documents[index].data['keamananWash_score'][i] == 2) {
                                jmlYesKeamananWash++;
                              }
                            }

                            for (var i = 0; i < snapshot.data.documents[index].data['alatKeamanan_score'].length; i++) {
                              if (snapshot.data.documents[index].data['alatKeamanan_score'][i] == 0) {
                                jmlNoAlatWash++;
                              } else if (snapshot.data.documents[index].data['alatKeamanan_score'][i] == 2) {
                                jmlYesAlatWash++;
                              }
                            }*/

                            hasilLobby = jmlNoParkingLobby + jmlNoDinningAreaLobby + jmlNoRestroomLobby;
                            hasilDinning = jmlNoGrillAreaDinning + jmlNoBarDinning + jmlNoProductionDinning + jmlNoWarehouseDinning;
                            hasilPelayanan = jmlNoMenuBoardPelayanan + jmlNoServiceAreaPelayanan + jmlNoGroomingPelayanan + jmlNoKeamananPelayanan + jmlNoKesiapanBisnis;
                            hasilAreaCook = jmlNoSteakCook + jmlNoBatterMixCook + jmlNoMixVegetablesCook + jmlNoPotatoCook + jmlNoGrillerCook + jmlNoKeamananMakananCook + jmlNoAreaCook + jmlNoKitchenCook;
                            hasilWash = jmlNoDishwasherWash + jmlNoChillerWash + jmlNoKeamananWash + jmlNoAlatWash;

                            hasilYesLobby = jmlYesParkingLobby + jmlYesDinningAreaLobby + jmlYesRestroomLobby;
                            hasilYesDinning = jmlYesGrillAreaDinning + jmlYesBarDinning + jmlYesProductionDinning + jmlYesWarehouseDinning;
                            hasilYesPelayanan = jmlYesMenuBoardPelayanan + jmlYesServiceAreaPelayanan + jmlYesGroomingPelayanan + jmlYesKeamananPelayanan + jmlYesKesiapanBisnis;
                            hasilYesAreaCook = jmlYesSteakCook + jmlYesBatterMixCook + jmlYesMixVegetablesCook + jmlYesPotatoCook + jmlYesGrillerCook + jmlYesKeamananMakananCook + jmlYesAreaCook + jmlYesKitchenCook;
                            hasilYesWash = jmlYesDishwasherWash + jmlYesChillerWash + jmlYesKeamananWash + jmlYesAlatWash;

                            hasilPertama = hasilYesLobby + hasilYesDinning + hasilYesPelayanan + hasilYesAreaCook + hasilYesWash;

                            /*jmlPertanyaan = snapshot.data.documents[index].data['parkingLot_pertanyaan'].length + snapshot.data.documents[index].data['dinningArea_pertanyaan'].length + snapshot.data.documents[index].data['restroom_pertanyaan'].length + snapshot.data.documents[index].data['grillArea_pertanyaan'].length + snapshot.data.documents[index].data['bar_pertanyaan'].length + snapshot.data.documents[index].data['production_pertanyaan'].length + snapshot.data.documents[index].data['warehouse_pertanyaan'].length + snapshot.data.documents[index].data['menuBoard_pertanyaan'].length + snapshot.data.documents[index].data['serviceArea_pertanyaan'].length + snapshot.data.documents[index].data['grooming_pertanyaan'].length + snapshot.data.documents[index].data['keamananPelayanan_pertanyaan'].length + snapshot.data.documents[index].data['kesiapanBisnis_pertanyaan'].length + snapshot.data.documents[index].data['steak_pertanyaan'].length + snapshot.data.documents[index].data['batterMix_pertanyaan'].length + snapshot.data.documents[index].data['mixVegetables_pertanyaan'].length + snapshot.data.documents[index].data['potatoWedges_pertanyaan'].length + snapshot.data.documents[index].data['griller_pertanyaan'].length + snapshot.data.documents[index].data['keamananCook_pertanyaan'].length + snapshot.data.documents[index].data['cookArea_pertanyaan'].length + snapshot.data.documents[index].data['kitchenEquipment_pertanyaan'].length + snapshot.data.documents[index].data['dishwasherArea_pertanyaan'].length + snapshot.data.documents[index].data['chiller_pertanyaan'].length + snapshot.data.documents[index].data['keamananWash_pertanyaan'].length + snapshot.data.documents[index].data['alatKeamanan_pertanyaan'].length;*/

                            hasilKedua = hasilPertama / jmlPertanyaan * 100;

                            Color colorGrafik = Colors.green;

                            hasilKedua > 85.0
                                ? colorGrafik = Colors.green
                                : hasilKedua < 70.0
                                ? colorGrafik = Colors.redAccent
                                : colorGrafik = Colors.orangeAccent;

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
                                            snapshot.data.documents[index].data['outlet'].toString(),
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.black87,
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
                                          pertanyaanParkingLobby = data.data['parkingLot_pertanyaan'];
                                          pertanyaanDinningAreaLobby = data.data['dinningArea_pertanyaan'];
                                          pertanyaanRestroomLobby = data.data['restroom_pertanyaan'];
                                          pertanyaanGrillAreaDinning = data.data['grillArea_pertanyaan'];
                                          pertanyaanBarDinning = data.data['bar_pertanyaan'];
                                          pertanyaanProductionDinning = data.data['production_pertanyaan'];
                                          pertanyaanWarehouseDinning = data.data['warehouse_pertanyaan'];
                                          pertanyaanMenuBoardPelayanan = data.data['menuBoard_pertanyaan'];
                                          pertanyaanServiceAreaPelayanan = data.data['serviceArea_pertanyaan'];
                                          pertanyaanGroomingPelayanan = data.data['grooming_pertanyaan'];
                                          pertanyaanKeamananPelayanan = data.data['keamananPelayanan_pertanyaan'];
                                          pertanyaanKesiapanBisnis = data.data['kesiapanBisnis_pertanyaan'];
                                          pertanyaanSteakCook = data.data['steak_pertanyaan'];
                                          pertanyaanBatterMixCook = data.data['batterMix_pertanyaan'];
                                          pertanyaanMixVegetablesCook = data.data['mixVegetables_pertanyaan'];
                                          pertanyaanPotatoCook = data.data['potatoWedges_pertanyaan'];
                                          pertanyaanGrillerCook = data.data['griller_pertanyaan'];
                                          pertanyaanKeamananMakananCook = data.data['keamananCook_pertanyaan'];
                                          pertanyaanAreaCook = data.data['cookArea_pertanyaan'];
                                          pertanyaanKitchenCook = data.data['kitchenEquipment_pertanyaan'];
                                          pertanyaanDishwasherWash = data.data['dishwasherArea_pertanyaan'];
                                          pertanyaanChillerWash = data.data['chiller_pertanyaan'];
                                          pertanyaanKeamananWash = data.data['keamananWash_pertanyaan'];
                                          pertanyaanAlatWash = data.data['alatKeamanan_pertanyaan'];
                                          outlet = data.data['outlet'];
                                          idCollection = data.documentID;
                                          scoreParkingLobby = data.data['parkingLot_score'];
                                          scoreDinningAreaLobby = data.data['dinningArea_score'];
                                          scoreRestroomLobby = data.data['restroom_score'];
                                          scoreGrillAreaDinning = data.data['grillArea_score'];
                                          scoreBarDinning = data.data['bar_score'];
                                          scoreProductionDinning = data.data['production_score'];
                                          scoreWarehouseDinning = data.data['warehouse_score'];
                                          scoreMenuBoardPelayanan = data.data['menuBoard_score'];
                                          scoreServiceAreaPelayanan = data.data['serviceArea_score'];
                                          scoreGroomingPelayanan = data.data['grooming_score'];
                                          scoreKeamananPelayanan = data.data['keamananPelayanan_score'];
                                          scoreKesiapanBisnis = data.data['kesiapanBisnis_score'];
                                          scoreSteakCook = data.data['steak_score'];
                                          scoreBatterMixCook = data.data['batterMix_score'];
                                          scoreMixVegetablesCook = data.data['mixVegetables_score'];
                                          scorePotatoCook = data.data['potatoWedges_score'];
                                          scoreGrillerCook = data.data['griller_score'];
                                          scoreKeamananMakananCook = data.data['keamananCook_score'];
                                          scoreAreaCook = data.data['cookArea_score'];
                                          scoreKitchenCook = data.data['kitchenEquipment_score'];
                                          scoreDishwasherWash = data.data['dishwasherArea_score'];
                                          scoreChillerWash = data.data['chiller_score'];
                                          scoreKeamananWash = data.data['keamananWash_score'];
                                          scoreAlatWash = data.data['alatKeamanan_score'];
                                          tanggal = tanggalStart.toDate().toString().substring(8, 10) + '/' + tanggalStart.toDate().toString().substring(5, 7) + '/' + tanggalStart.toDate().toString().substring(0, 4);
                                          waktuStart = tanggalStart.toDate().toString().substring(11, 16);
                                          if (data['timeDone'] == null) {
                                            waktuEnd = '00.00';
                                          } else {
                                            waktuEnd = tanggalDone.toDate().toString().substring(11, 16);
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
                                            scoreChillerWash: scoreChillerWash,
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
                                            pertanyaanChillerWash: pertanyaanChillerWash,
                                            pertanyaanKeamananWash: pertanyaanKeamananWash,
                                            pertanyaanAlatWash: pertanyaanAlatWash,
                                            counter: counter,
                                            outlet: outlet,
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
                                                  : tanggalStart.toDate().toString().substring(8, 10) + '/' + tanggalStart.toDate().toString().substring(5, 7) + '/' + tanggalStart.toDate().toString().substring(0, 4),
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
                                            snapshot.data.documents[index].data['outlet'].toString(),
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.black87,
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
                                          pertanyaanParkingLobby = data.data['parkingLot_pertanyaan'];
                                          pertanyaanDinningAreaLobby = data.data['dinningArea_pertanyaan'];
                                          pertanyaanRestroomLobby = data.data['restroom_pertanyaan'];
                                          pertanyaanGrillAreaDinning = data.data['grillArea_pertanyaan'];
                                          pertanyaanBarDinning = data.data['bar_pertanyaan'];
                                          pertanyaanProductionDinning = data.data['production_pertanyaan'];
                                          pertanyaanWarehouseDinning = data.data['warehouse_pertanyaan'];
                                          pertanyaanMenuBoardPelayanan = data.data['menuBoard_pertanyaan'];
                                          pertanyaanServiceAreaPelayanan = data.data['serviceArea_pertanyaan'];
                                          pertanyaanGroomingPelayanan = data.data['grooming_pertanyaan'];
                                          pertanyaanKeamananPelayanan = data.data['keamananPelayanan_pertanyaan'];
                                          pertanyaanKesiapanBisnis = data.data['kesiapanBisnis_pertanyaan'];
                                          pertanyaanSteakCook = data.data['steak_pertanyaan'];
                                          pertanyaanBatterMixCook = data.data['batterMix_pertanyaan'];
                                          pertanyaanMixVegetablesCook = data.data['mixVegetables_pertanyaan'];
                                          pertanyaanPotatoCook = data.data['potatoWedges_pertanyaan'];
                                          pertanyaanGrillerCook = data.data['griller_pertanyaan'];
                                          pertanyaanKeamananMakananCook = data.data['keamananCook_pertanyaan'];
                                          pertanyaanAreaCook = data.data['cookArea_pertanyaan'];
                                          pertanyaanKitchenCook = data.data['kitchenEquipment_pertanyaan'];
                                          pertanyaanDishwasherWash = data.data['dishwasherArea_pertanyaan'];
                                          pertanyaanChillerWash = data.data['chiller_pertanyaan'];
                                          pertanyaanKeamananWash = data.data['keamananWash_pertanyaan'];
                                          pertanyaanAlatWash = data.data['alatKeamanan_pertanyaan'];

                                          idCollection = data.documentID;
                                          outlet = data.data['outlet'];

                                          scoreParkingLobby = data.data['parkingLot_score'];
                                          scoreDinningAreaLobby = data.data['dinningArea_score'];
                                          scoreRestroomLobby = data.data['restroom_score'];
                                          scoreGrillAreaDinning = data.data['grillArea_score'];
                                          scoreBarDinning = data.data['bar_score'];
                                          scoreProductionDinning = data.data['production_score'];
                                          scoreWarehouseDinning = data.data['warehouse_score'];
                                          scoreMenuBoardPelayanan = data.data['menuBoard_score'];
                                          scoreServiceAreaPelayanan = data.data['serviceArea_score'];
                                          scoreGroomingPelayanan = data.data['grooming_score'];
                                          scoreKeamananPelayanan = data.data['keamananPelayanan_score'];
                                          scoreKesiapanBisnis = data.data['kesiapanBisnis_score'];
                                          scoreSteakCook = data.data['steak_score'];
                                          scoreBatterMixCook = data.data['batterMix_score'];
                                          scoreMixVegetablesCook = data.data['mixVegetables_score'];
                                          scorePotatoCook = data.data['potatoWedges_score'];
                                          scoreGrillerCook = data.data['griller_score'];
                                          scoreKeamananMakananCook = data.data['keamananCook_score'];
                                          scoreAreaCook = data.data['cookArea_score'];
                                          scoreKitchenCook = data.data['kitchenEquipment_score'];
                                          scoreDishwasherWash = data.data['dishwasherArea_score'];
                                          scoreChillerWash = data.data['chiller_score'];
                                          scoreKeamananWash = data.data['keamananWash_score'];
                                          scoreAlatWash = data.data['alatKeamanan_score'];

                                          tanggal = tanggalStart.toDate().toString().substring(8, 10) + '/' + tanggalStart.toDate().toString().substring(5, 7) + '/' + tanggalStart.toDate().toString().substring(0, 4);
                                          waktuStart = tanggalStart.toDate().toString().substring(11, 16);
                                          if (data['timeDone'] == null) {
                                            waktuEnd = '00.00';
                                          } else {
                                            waktuEnd = tanggalDone.toDate().toString().substring(11, 16);
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
                                            scoreChillerWash: scoreChillerWash,
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
                                            pertanyaanChillerWash: pertanyaanChillerWash,
                                            pertanyaanKeamananWash: pertanyaanKeamananWash,
                                            pertanyaanAlatWash: pertanyaanAlatWash,
                                            counter: counter,
                                            outlet: outlet,
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
                                                  : tanggalStart.toDate().toString().substring(8, 10) + '/' + tanggalStart.toDate().toString().substring(5, 7) + '/' + tanggalStart.toDate().toString().substring(0, 4),
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
