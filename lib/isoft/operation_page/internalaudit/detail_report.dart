import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/isoft/operation_page/correctiveaction/form_createLanjutIA.dart';
import 'package:flutter_abuba/isoft/operation_page/correctiveaction/verifikasiPage.dart';
import 'package:flutter_abuba/isoft/operation_page/internalaudit/detailreport_assets.dart';
import 'package:flutter_abuba/isoft/operation_page/internalaudit/detailreport_cash.dart';
import 'package:flutter_abuba/isoft/operation_page/internalaudit/detailreport_equipment.dart';
import 'package:flutter_abuba/isoft/operation_page/internalaudit/detailreport_inventory.dart';
import 'package:flutter_abuba/isoft/operation_page/internalaudit/viewCAR.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailReport extends StatefulWidget {
  @override
  _DetailReportState createState() => _DetailReportState();

  final String outlet;
  final int idUser;
  var iaNo;
  final String departmentUser;
  final String namaUser;
  final String idCollection;
  final double hasilGrafik;
  final double hasilAreaLuar;
  final List<dynamic> AreaLuarScore;
  final List<dynamic> criticalAreaLuar;
  final List<dynamic> systemAreaLuar;
  final double hasilDinningArea;
  final List<dynamic> DinningAreaScore;
  final List<dynamic> criticalDinningArea;
  final List<dynamic> systemDinningArea;
  final double hasilService;
  final List<dynamic> ServiceScore;
  final List<dynamic> criticalService;
  final List<dynamic> systemService;
  final double hasilCashier;
  final List<dynamic> CashierScore;
  final List<dynamic> criticalCashier;
  final List<dynamic> systemCashier;
  final double hasilCashierAccuracy;
  final List<dynamic> CashierAccuracyScore;
  final List<dynamic> criticalCashierAccuracy;
  final List<dynamic> systemCashierAccuracy;
  final double hasilBoh;
  final List<dynamic> BohScore;
  final List<dynamic> criticalBoh;
  final List<dynamic> systemBoh;
  final double hasilWarehouse;
  final List<dynamic> WarehouseScore;
  final List<dynamic> criticalWarehouse;
  final List<dynamic> systemWarehouse;
  final double hasilSocialBlock;
  final List<dynamic> SocialBlockScore;
  final List<dynamic> criticalSocialBlock;
  final List<dynamic> systemSocialBlock;
  final double hasilPersonal;
  final List<dynamic> PersonalScore;
  final List<dynamic> criticalPersonal;
  final List<dynamic> systemPersonal;
  final double hasilFoodCooked;
  final List<dynamic> FoodCookedScore;
  final List<dynamic> criticalFoodCooked;
  final List<dynamic> systemFoodCooked;
  final String tanggal;
  final String waktuStart;
  final String waktuEnd;

  final List<dynamic> pertanyaanAreaLuar;
  final List<dynamic> pertanyaanDinningRoom;
  final List<dynamic> pertanyaanService;
  final List<dynamic> pertanyaanCashier;
  final List<dynamic> pertanyaanCashierAccuracy;
  final List<dynamic> pertanyaanBOH;
  final List<dynamic> pertanyaanWareHouse;
  final List<dynamic> pertanyaanSocialBlock;
  final List<dynamic> pertanyaanPersonalHygiene;
  final List<dynamic> pertanyaanFoodCompletely;
  List<dynamic> auditor; 
  final int auditee;
  final int leadauditor;

  // sini transfer
  final List<dynamic> bobotPertanyaanSocial;
  final double bobotSocial;
  final List<dynamic> bobotPertanyaanAreaLuar;
  final double bobotAreaLuar;
  final List<dynamic> bobotPertanyaanDinningArea;
  final double bobotDinningArea;
  final List<dynamic> bobotPertanyaanService;
  final double bobotService;
  final List<dynamic> bobotPertanyaanCashier;
  final double bobotCashier;
  final List<dynamic> bobotPertanyaanCashierAccuracy;
  final double bobotCashierAccuracy;
  final List<dynamic> bobotPertanyaanBoh;
  final double bobotBoh;
  final List<dynamic> bobotPertanyaanWarehouse;
  final double bobotWarehouse;
  final List<dynamic> bobotPertanyaanPersonal;
  final double bobotPersonal;
  final List<dynamic> bobotPertanyaanFood;
  final double bobotFood;

  final int totalCP;
  DetailReport({
    this.totalCP,
    this.bobotSocial,
    this.bobotPertanyaanSocial,
    this.bobotPertanyaanAreaLuar,
    this.bobotAreaLuar,
    this.bobotPertanyaanDinningArea,
    this.bobotDinningArea,
    this.bobotPertanyaanService,
    this.bobotService,
    this.bobotPertanyaanCashier,
    this.bobotCashier,
    this.bobotPertanyaanCashierAccuracy,
    this.bobotCashierAccuracy,
    this.bobotPertanyaanBoh,
    this.bobotBoh,
    this.bobotPertanyaanWarehouse,
    this.bobotWarehouse,
    this.bobotPertanyaanPersonal,
    this.bobotPersonal,
    this.bobotPertanyaanFood,
    this.bobotFood,
    this.iaNo,
    this.departmentUser,
    this.auditee, 
    this.leadauditor,
    this.auditor,
    this.pertanyaanAreaLuar,
    this.pertanyaanBOH,
    this.pertanyaanCashier,
    this.pertanyaanCashierAccuracy,
    this.pertanyaanDinningRoom,
    this.pertanyaanFoodCompletely,
    this.pertanyaanPersonalHygiene,
    this.pertanyaanService,
    this.pertanyaanSocialBlock,
    this.pertanyaanWareHouse,
    this.tanggal,
    this.waktuStart,
    this.waktuEnd,
    this.outlet,
    this.idUser,
    this.namaUser,
    this.idCollection,
    this.hasilGrafik,
    this.hasilAreaLuar,
    this.AreaLuarScore,
    this.criticalAreaLuar,
    this.systemAreaLuar,
    this.hasilDinningArea,
    this.DinningAreaScore,
    this.criticalDinningArea,
    this.systemDinningArea,
    this.hasilService,
    this.ServiceScore,
    this.criticalService,
    this.systemService,
    this.hasilCashier,
    this.CashierScore,
    this.criticalCashier,
    this.systemCashier,
    this.hasilCashierAccuracy,
    this.CashierAccuracyScore,
    this.criticalCashierAccuracy,
    this.systemCashierAccuracy,
    this.hasilBoh,
    this.BohScore,
    this.criticalBoh,
    this.systemBoh,
    this.hasilWarehouse,
    this.WarehouseScore,
    this.criticalWarehouse,
    this.systemWarehouse,
    this.hasilSocialBlock,
    this.SocialBlockScore,
    this.criticalSocialBlock,
    this.systemSocialBlock,
    this.hasilPersonal,
    this.PersonalScore,
    this.criticalPersonal,
    this.systemPersonal,
    this.hasilFoodCooked,
    this.FoodCookedScore,
    this.criticalFoodCooked,
    this.systemFoodCooked,
  });
}

class _DetailReportState extends State<DetailReport> with TickerProviderStateMixin {
  AnimationController animationController;
  final GlobalKey<AnimatedCircularChartState> _chartKey =
  new GlobalKey<AnimatedCircularChartState>();


  List<dynamic> AreaLuarNote = [];
  List<dynamic> pertanyaanAreaLuar = [];
  List<dynamic> imageAreaLuar = [];
  List<dynamic> imageAreaLuarSplit = [];
  List<bool> noteAreaLuar = [];
  List<bool> _gambarAreaLuar = [];

  List<dynamic> DinningAreaNote = [];
  List<dynamic> pertanyaanDinningArea = [];
  List<dynamic> imageDinningArea = [];
  List<dynamic> imageDinningAreaSplit = [];
  List<bool> _catatanDinningArea = [];
  List<bool> _gambarDinningArea = [];

  List<dynamic> ServiceNote = [];
  List<dynamic> pertanyaanService = [];
  List<dynamic> imageService = [];
  List<dynamic> imageServiceSplit = [];
  List<bool> _catatanService = [];
  List<bool> _gambarService = [];

  List<dynamic> CashierNote = [];
  List<dynamic> pertanyaanCashier = [];
  List<dynamic> imageCashier = [];
  List<dynamic> imageCashierSplit = [];
  List<bool> _catatanCashier = [];
  List<bool> _gambarCashier = [];

  List<dynamic> CashierAccuracyNote = [];
  List<dynamic> pertanyaanCashierAccuracy = [];
  List<dynamic> imageCashierAccuracy = [];
  List<dynamic> imageCashierAccuracySplit = [];
  List<bool> _catatanCashierAccuracy = [];
  List<bool> _gambarCashierAccuracy = [];

  List<dynamic> BohNote = [];
  List<dynamic> pertanyaanBoh = [];
  List<dynamic> imageBoh = [];
  List<dynamic> imageBohSplit = [];
  List<bool> _catatanBoh = [];
  List<bool> _gambarBoh = [];

  List<dynamic> WarehouseNote = [];
  List<dynamic> pertanyaanWarehouse = [];
  List<dynamic> imageWarehouse = [];
  List<dynamic> imageWarehouseSplit = [];
  List<bool> _catatanWarehouse = [];
  List<bool> _gambarWarehouse = [];

  List<dynamic> SocialBlockNote = [];
  List<dynamic> pertanyaanSocialBlock = [];
  List<dynamic> imageSocialBlock = [];
  List<dynamic> imageSocialBlockSplit = [];
  List<bool> _catatanSocialBlock = [];
  List<bool> _gambarSocialBlock = [];

  List<dynamic> PersonalNote = [];
  List<dynamic> pertanyaanPersonal = [];
  List<dynamic> imagePersonal = [];
  List<dynamic> imagePersonalSplit = [];
  List<bool> _catatanPersonal = [];
  List<bool> _gambarPersonal = [];

  List<dynamic> FoodCookedNote = [];
  List<dynamic> pertanyaanFoodCooked = [];
  List<dynamic> imageFoodCooked = [];
  List<dynamic> imageFoodCookedSplit = [];
  List<bool> _catatanFoodCooked = [];
  List<bool> _gambarFoodCooked = [];

  String userCreated;
  Color colorGrafik = Colors.green;

  int parameterAreaLuar = 0;
  int parameterDinningArea = 0;
  int parameterService = 0;
  int parameterCashier = 0;
  int parameterCashierAccuracy = 0;
  int parameterBoh = 0;
  int parameterWarehouse = 0;
  int parameterSocialBlock = 0;
  int parameterPersonal = 0;
  int parameterFoodCooked = 0;

  String auditee = '';
  String leadAuditor = '';
  List<String> auditor = [];

  List<dynamic> statusCAR = [];
  var textEditingControllers = <TextEditingController>[];
  int auditeeID;
  int departmentAuditee;
  
  double hasilSocial = 0;
  double hasilAreaLuar = 0;
  double hasilDinningArea = 0;
  double hasilService = 0;
  double hasilCashier = 0;
  double hasilCashierAccuracy = 0;
  double hasilBoh = 0;
  double hasilWarehouse = 0;
  double hasilPersonal = 0;
  double hasilFood = 0;
  double hasilGrafik = 0;

  String statusTemplateCountCash;
  String statusTemplateCountInventory;
  String statusTemplateCountEquipment;
  String statusTemplateCountAssets;
  String bantuTemplateCount;
  List<dynamic> templateCount = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      // hitung sini
      for (int zz = 0; zz < widget.SocialBlockScore.length; zz++) {
        hasilSocial += double.tryParse(widget.SocialBlockScore[zz].toString()) * double.tryParse(widget.bobotPertanyaanSocial[zz].toString());
      }
      hasilSocial = hasilSocial / 2;
      
      for (int zz2 = 0; zz2 < widget.AreaLuarScore.length; zz2++) {
        hasilAreaLuar += double.tryParse(widget.AreaLuarScore[zz2].toString()) * double.tryParse(widget.bobotPertanyaanAreaLuar[zz2].toString());
      }
      hasilAreaLuar = hasilAreaLuar / 2;

      for (int zz3 = 0; zz3 < widget.DinningAreaScore.length; zz3++) {
        hasilDinningArea += double.tryParse(widget.DinningAreaScore[zz3].toString()) * double.tryParse(widget.bobotPertanyaanDinningArea[zz3].toString());
      }
      hasilDinningArea = hasilDinningArea / 2;

      for (int zz4 = 0; zz4 < widget.ServiceScore.length; zz4++) {
        hasilService += double.tryParse(widget.ServiceScore[zz4].toString()) * double.tryParse(widget.bobotPertanyaanService[zz4].toString());
      }
      hasilService = hasilService / 2;

      for (int zz5 = 0; zz5 < widget.CashierScore.length; zz5++) {
        hasilCashier += double.tryParse(widget.CashierScore[zz5].toString()) * double.tryParse(widget.bobotPertanyaanCashier[zz5].toString());
      }
      hasilCashier = hasilCashier / 2;

      for (int zz6 = 0; zz6 < widget.CashierAccuracyScore.length; zz6++) {
        hasilCashierAccuracy += double.tryParse(widget.CashierAccuracyScore[zz6].toString()) * double.tryParse(widget.bobotPertanyaanCashierAccuracy[zz6].toString());
      }
      hasilCashierAccuracy = hasilCashierAccuracy / 2;

      for (int zz7 = 0; zz7 < widget.BohScore.length; zz7++) {
        hasilBoh += double.tryParse(widget.BohScore[zz7].toString()) * double.tryParse(widget.bobotPertanyaanBoh[zz7].toString());
      }
      hasilBoh = hasilBoh / 2;

      for (int zz8 = 0; zz8 < widget.PersonalScore.length; zz8++) {
        hasilPersonal += double.tryParse(widget.PersonalScore[zz8].toString()) * double.tryParse(widget.bobotPertanyaanPersonal[zz8].toString());
      }
      hasilPersonal = hasilPersonal / 2;

      for (int zz9 = 0; zz9 < widget.FoodCookedScore.length; zz9++) {
        hasilFood += double.tryParse(widget.FoodCookedScore[zz9].toString()) * double.tryParse(widget.bobotPertanyaanFood[zz9].toString());
      }
      hasilFood = hasilFood / 2;

      for (int zz10 = 0; zz10 < widget.WarehouseScore.length; zz10++) {
        hasilWarehouse += double.tryParse(widget.WarehouseScore[zz10].toString()) * double.tryParse(widget.bobotPertanyaanWarehouse[zz10].toString());
      }
      hasilWarehouse = hasilWarehouse / 2;
      hasilGrafik = (hasilAreaLuar * widget.bobotAreaLuar) + (hasilDinningArea * widget.bobotDinningArea) + (hasilService * widget.bobotService) + (hasilCashier * widget.bobotCashier) + (hasilCashierAccuracy * widget.bobotCashierAccuracy) + (hasilBoh * widget.bobotBoh) + (hasilWarehouse * widget.bobotWarehouse) + (hasilSocial * widget.bobotSocial) + (hasilPersonal * widget.bobotPersonal) + (hasilFood * widget.bobotFood);

      if (widget.totalCP >= 1 && widget.totalCP <= 5) {
        hasilGrafik = hasilGrafik - (hasilGrafik * 2 / 100);
      } else if (widget.totalCP >= 6 && widget.totalCP <= 11) {
        hasilGrafik = hasilGrafik - (hasilGrafik * 4 / 100);
      } else if (widget.totalCP >= 12 && widget.totalCP <= 20) {
        hasilGrafik = hasilGrafik - (hasilGrafik * 8 / 100);
      } else if (widget.totalCP == 0) {
        hasilGrafik = hasilGrafik;
      }

      hasilGrafik.round() > 85.0
        ? colorGrafik = Colors.green
        : hasilGrafik.round() < 70.0
            ? colorGrafik = Colors.redAccent
            : colorGrafik = Colors.orangeAccent;

      Firestore.instance.collection('user').where('id', isEqualTo: widget.auditee).snapshots().listen((dataAuditee) {
        auditee = dataAuditee.documents[0].data['nama'];
      });

      Firestore.instance.collection('user').where('id', isEqualTo: widget.leadauditor).snapshots().listen((datalead) {
        leadAuditor = datalead.documents[0].data['nama'];
      });

      for (int a = 0; a < widget.auditor.length; a++) {
        Firestore.instance.collection('user').where('id', isEqualTo: int.tryParse(widget.auditor[a].toString())).snapshots().listen((dataAuditor) {
          auditor.add(dataAuditor.documents[0].data['nama']);
        });
      }
      
      Firestore.instance.collection('audit_internal').document(widget.idCollection).snapshots().listen((data) {
        for (int a = 0; a < data.data['FSCarNo'].length; a++) {
          if (data.data['FSCarNo'][a] == null) {
            statusCAR.add(null);
          } else {
            Firestore.instance.collection('correctiveAction').where('carNo', isEqualTo: data.data['FSCarNo'][a]).snapshots().listen((dataCAR) {
              statusCAR.add(dataCAR.documents[0].data['status']);
            });
          }
        }

        for (int a = 0; a < data.data['FSProblem'].length; a++) {
          var textEditingController = new TextEditingController();
          textEditingControllers.add(textEditingController);
        }

        auditeeID = data.data['auditee'];

        if (data.data.containsKey('templateCount')) {
          bantuTemplateCount = 'yes';
          templateCount = data.data['templateCount'];
        } else {
          bantuTemplateCount = 'no';
          templateCount = [];
        }

        Firestore.instance.collection('user').where('id', isEqualTo: data.data['auditee']).snapshots().listen((data2) {
          departmentAuditee = data2.documents[0].data['departmentID'];
        });

        AreaLuarNote = data.data['AreaLuar_note'];
        imageAreaLuar = data.data['imageAreaLuar'];

        DinningAreaNote = data.data['DinningArea_note'];
        imageDinningArea = data.data['imageDinningArea'];

        ServiceNote = data.data['Service_note'];
        imageService = data.data['imageService'];

        CashierNote = data.data['Cashier_note'];
        imageCashier = data.data['imageCashier'];

        CashierAccuracyNote = data.data['CashierAccuracy_note'];
        imageCashierAccuracy = data.data['imageCashierAccuracy'];

        BohNote = data.data['Boh_note'];
        imageBoh = data.data['imageBoh'];

        WarehouseNote = data.data['Warehouse_note'];
        imageWarehouse = data.data['imageWarehouse'];

        SocialBlockNote = data.data['SocialBlock_note'];
        imageSocialBlock = data.data['imageSocialBlock'];

        PersonalNote = data.data['Personal_note'];
        imagePersonal = data.data['imagePersonal'];

        FoodCookedNote = data.data['FoodCooked_note'];
        imageFoodCooked = data.data['imageFoodCooked'];

        Firestore.instance.collection('user').where('id', isEqualTo: data.data['userCreated']).snapshots().listen((data2) {
          userCreated = data2.documents[0].data['nama'];
        });

        parameterAreaLuar = data.data['bobot_AreaLuar'];
        parameterDinningArea = data.data['bobot_DinningArea'];
        parameterService = data.data['bobot_Service'];
        parameterCashier = data.data['bobot_Cashier'];
        parameterCashierAccuracy = data.data['bobot_CashierAccuracy'];
        parameterBoh = data.data['bobot_Boh'];
        parameterWarehouse = data.data['bobot_Warehouse'];
        parameterSocialBlock = data.data['bobot_SocialBlock'];
        parameterPersonal = data.data['bobot_Personal'];
        parameterFoodCooked = data.data['bobot_FoodCooked'];
      });
    });

    for (int i = 0; i < widget.pertanyaanAreaLuar.length; i++) {
      noteAreaLuar.add(false);
      _gambarAreaLuar.add(false);
    }

    for (int i = 0; i < widget.pertanyaanBOH.length; i++) {
      _catatanBoh.add(false);
      _gambarBoh.add(false);
    }

    for (int i = 0; i < widget.pertanyaanCashier.length; i++) {
      _catatanCashier.add(false);
      _gambarCashier.add(false);
    }

    for (int i = 0; i < widget.pertanyaanCashierAccuracy.length; i++) {
      _catatanCashierAccuracy.add(false);
      _gambarCashierAccuracy.add(false);
    }

    for (int i = 0; i < widget.pertanyaanDinningRoom.length; i++) {
      _catatanDinningArea.add(false);
      _gambarDinningArea.add(false);
    }

    for (int i = 0; i < widget.pertanyaanFoodCompletely.length; i++) {
      _catatanFoodCooked.add(false);
      _gambarFoodCooked.add(false);
    }

    for (int i = 0; i < widget.pertanyaanPersonalHygiene.length; i++) {
      _catatanPersonal.add(false);
      _gambarPersonal.add(false);
    }

    for (int i = 0; i < widget.pertanyaanService.length; i++) {
      _catatanService.add(false);
      _gambarService.add(false);
    }

    for (int i = 0; i < widget.pertanyaanSocialBlock.length; i++) {
      _catatanSocialBlock.add(false);
      _gambarSocialBlock.add(false);
    }

    for (int i = 0; i < widget.pertanyaanWareHouse.length; i++) {
      _catatanWarehouse.add(false);
      _gambarWarehouse.add(false);
    }

    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(
        from:
        animationController.value == 0.0 ? 1.0 : animationController.value);

    Firestore.instance.collection('audit_internalDetail-cash').where('docRef', isEqualTo: widget.idCollection).snapshots().listen((data2) {
      setState(() {
        if (data2.documents.length == 0) {
          statusTemplateCountCash = 'open';
        } else {
          statusTemplateCountCash = 'close';
        }
      });
    });

    Firestore.instance.collection('audit_internalDetail-inventory').where('docRef', isEqualTo: widget.idCollection).snapshots().listen((data2) {
      setState(() {
        if (data2.documents.length == 0) {
          statusTemplateCountInventory = 'open';
        } else {
          statusTemplateCountInventory = 'close';
        }
      });
    });

    Firestore.instance.collection('audit_internalDetail-equipment').where('docRef', isEqualTo: widget.idCollection).snapshots().listen((data2) {
      setState(() {
        if (data2.documents.length == 0) {
          statusTemplateCountEquipment = 'open';
        } else {
          statusTemplateCountEquipment = 'close';
        }
      });
    });

    Firestore.instance.collection('audit_internalDetail-assets').where('docRef', isEqualTo: widget.idCollection).snapshots().listen((data2) {
      setState(() {
        if (data2.documents.length == 0) {
          statusTemplateCountAssets = 'open';
        } else {
          statusTemplateCountAssets = 'close';
        }
      });
    });
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
        body: _formDetail(size, context),
      ),
    );
  }

  Widget _formDetail(double size, BuildContext context) {
    return Scrollbar(
      child: ListView(
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
                    style: TextStyle(
                        color: AbubaPallate.greenabuba, fontSize: 12.0),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    'Internal Audit',
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
                  : Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, right: 15.0, left: 15.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  widget.outlet,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black54),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  widget.tanggal,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black54),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  userCreated,
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 13.0),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  '${widget.waktuStart.toString()} - ${widget.waktuEnd.toString()}',
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 13.0),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, right: 15.0, left: 15.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Auditee',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black54),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  auditee,
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 13.0),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Lead Auditor',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black54),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  leadAuditor,
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 13.0),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Center(
                        child: new AnimatedCircularChart(
                          key: _chartKey,
                          size: Size(size / 4, size / 3),
                          initialChartData: <CircularStackEntry>[
                            new CircularStackEntry(
                              <CircularSegmentEntry>[
                                new CircularSegmentEntry(
                                  hasilGrafik,
                                  colorGrafik,
                                  rankKey: 'completed',
                                ),
                                new CircularSegmentEntry(
                                  100.0 - hasilGrafik.round(),
                                  Colors.blueGrey[600],
                                  rankKey: 'remaining',
                                ),
                              ],
                              rankKey: 'progress',
                            ),
                          ],
                          chartType: CircularChartType.Radial,
                          percentageValues: true,
                          holeLabel: hasilGrafik.round() >= 100.0
                              ? '100%'
                              : '${hasilGrafik.round().toString()}%',
                          labelStyle: new TextStyle(
                            color: Colors.blueGrey[600],
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                          ),
                        ),
                      ),
                    ),
                    // finding status here
                    StreamBuilder(
                      stream: Firestore.instance.collection('audit_internal').where('iaNo', isEqualTo: widget.iaNo).snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData)
                          return Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );

                        if (snapshot.data.documents[0].data.containsKey('FSProblem')) {
                          return ExpansionTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Finding Status',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            children: <Widget>[
                              Column(
                                children: List.generate(snapshot.data.documents[0].data['FSProblem'].length, (index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  snapshot.data.documents[0].data['FSArea'][index],
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14.0
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
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
                                                        snapshot.data.documents[0].data['FSSubBab'][index],
                                                        style: TextStyle(
                                                          color: Colors.green,
                                                          fontWeight: FontWeight.w700,
                                                          fontSize: 14.0
                                                        ),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        snapshot.data.documents[0].data['FSAuditor'][index],
                                                        style: TextStyle(
                                                          color: Colors.black45,
                                                          fontWeight: FontWeight.w700,
                                                          fontSize: 14.0
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5.0,
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        '${index + 1}. ${snapshot.data.documents[0].data['FSProblem'][index]}',
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
                                        ),
                                        snapshot.data.documents[0].data['FSAuditorID'][index] == widget.idUser
                                          ? snapshot.data.documents[0].data['FSCarNo'][index] == null
                                              ? Container(
                                                  padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
                                                  alignment: Alignment.centerRight,
                                                  child: ButtonTheme(
                                                    minWidth: 50.0,
                                                    height: 30.0,
                                                    child: OutlineButton(
                                                      child: Text(
                                                        'Rekomendasi',
                                                        style: TextStyle(fontSize: 13.0, color: AbubaPallate.menuBluebird),
                                                      ),
                                                      borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                                                      highlightedBorderColor: AbubaPallate.menuBluebird,
                                                      onPressed: () {
                                                        showModalBottomSheet(
                                                          context: context,
                                                          builder: (builder) {
                                                            return DialogBottomRekomendasi(
                                                              indexData: index,
                                                              leadAuditorID: snapshot.data.documents[0].data['leadAuditor'],
                                                              indexx: snapshot.data.documents[0].documentID,
                                                              area: snapshot.data.documents[0].data['FSArea'][index],
                                                              auditeeID: int.tryParse(auditeeID.toString()),
                                                              auditorIDFS: snapshot.data.documents[0].data['FSAuditorID'][index],
                                                              categoryFS: snapshot.data.documents[0].data['FSCategory'],
                                                              departmentAuditee: departmentAuditee,
                                                              departmentID: snapshot.data.documents[0].data['FSDepartment'],
                                                              departmentUser: int.tryParse(widget.departmentUser),
                                                              divisi: snapshot.data.documents[0].data['FSDivisi'],
                                                              problemFS: snapshot.data.documents[0].data['FSProblem'][index],
                                                              result: (value) {
                                                                statusCAR.removeAt(index);
                                                                statusCAR.insert(index, value[0]);
                                                              },
                                                            );
                                                          },
                                                        );
                                                      }
                                                    ),
                                                  ),
                                                )
                                              : StreamBuilder(
                                                  stream: Firestore.instance.collection('correctiveAction').where('carNo', isEqualTo: snapshot.data.documents[0].data['FSCarNo'][index]).snapshots(),
                                                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot2) {

                                                    if (snapshot2.data == null) return CircularProgressIndicator();

                                                    return Container(
                                                      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[
                                                          Flexible(
                                                            child: Text(
                                                              'CAR # ${snapshot2.data.documents[0].data['carNo'].toString().padLeft(4, '0')}',
                                                              style: TextStyle(
                                                                color: Colors.black54,
                                                                fontWeight: FontWeight.w700,
                                                                fontSize: 14.0
                                                              ),
                                                            ),
                                                          ),
                                                          Flexible(
                                                            child: Container(
                                                              width: 100.0,
                                                              height: 30.0,
                                                              child: ButtonTheme(
                                                                minWidth: 50.0,
                                                                height: 30.0,
                                                                child: OutlineButton(
                                                                  child: Text(
                                                                    snapshot2.data.documents[0].data['status'].toString().toUpperCase() == 'CLOSED' ? 'VERIFIED' : snapshot2.data.documents[0].data['status'].toString().toUpperCase(),

                                                                    style: TextStyle(fontSize: 12.0, color: snapshot2.data.documents[0].data['status'].toString().toUpperCase() == 'OPEN' ? Colors.redAccent : snapshot2.data.documents[0].data['status'].toString().toUpperCase() == 'ONGOING' ? Colors.orangeAccent : snapshot2.data.documents[0].data['status'].toString().toUpperCase() == 'DONE' ? AbubaPallate.menuBluebird : Colors.green),
                                                                  ),

                                                                  borderSide: BorderSide(color: snapshot2.data.documents[0].data['status'].toString().toUpperCase() == 'OPEN' ? Colors.redAccent : snapshot2.data.documents[0].data['status'].toString().toUpperCase() == 'ONGOING' ? Colors.orangeAccent : snapshot2.data.documents[0].data['status'].toString().toUpperCase() == 'DONE' ? AbubaPallate.menuBluebird : Colors.green, width: 1.0),

                                                                  highlightedBorderColor: snapshot2.data.documents[0].data['status'].toString().toUpperCase() == 'OPEN' ? Colors.redAccent : snapshot2.data.documents[0].data['status'].toString().toUpperCase() == 'ONGOING' ? Colors.orangeAccent : snapshot2.data.documents[0].data['status'].toString().toUpperCase() == 'DONE' ? AbubaPallate.menuBluebird : Colors.green,

                                                                  onPressed: () {
                                                                    if (snapshot2.data.documents[0].data['userCreated'] == widget.idUser) {
                                                                      if (snapshot2.data.documents[0].data['status'].toString().toUpperCase() == 'DONE') {
                                                                        Navigator.pushReplacement(context,
                                                                          MaterialPageRoute(
                                                                            builder: (_) => VerifikasiLanjutan(departmentUser: widget.departmentUser, idUser: widget.idUser, namaUser: widget.namaUser, status: snapshot2.data.documents[0].data['status'], index: snapshot2.data.documents[0].documentID)
                                                                          )
                                                                        );
                                                                      } else {
                                                                        Navigator.push(context,
                                                                          MaterialPageRoute(
                                                                            builder: (_) => ViewCAR(index: snapshot2.data.documents[0].data['carNo'], namaUser: widget.namaUser, idUser: widget.idUser, departmentUser: widget.departmentUser, idCollectionIA: widget.idCollection)
                                                                          )
                                                                        );
                                                                      }
                                                                    } else if (snapshot2.data.documents[0].data['userDituju'] == widget.idUser) {
                                                                      if (snapshot2.data.documents[0].data['status'].toString().toUpperCase() == 'OPEN' || snapshot2.data.documents[0].data['status'].toString().toUpperCase() == 'ONGOING') {
                                                                        Navigator.pushReplacement(context,
                                                                          MyCustomRoute(
                                                                            builder: (context) => FormCreateLanjutanIA(idUser: widget.idUser, departmentUser: widget.departmentUser, namaUser: widget.namaUser, status: 'carLanjutan', index: snapshot2.data.documents[0].documentID)
                                                                          )
                                                                        );
                                                                      } else {
                                                                        Navigator.push(context,
                                                                          MaterialPageRoute(
                                                                            builder: (_) => ViewCAR(index: snapshot2.data.documents[0].data['carNo'], namaUser: widget.namaUser, idUser: widget.idUser, departmentUser: widget.departmentUser, idCollectionIA: widget.idCollection)
                                                                          )
                                                                        );
                                                                      }
                                                                    } else {
                                                                      Navigator.push(context,
                                                                        MaterialPageRoute(
                                                                          builder: (_) => ViewCAR(index: snapshot2.data.documents[0].data['carNo'], namaUser: widget.namaUser, idUser: widget.idUser, departmentUser: widget.departmentUser, idCollectionIA: widget.idCollection)
                                                                        )
                                                                      );
                                                                    }
                                                                  }
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                )
                                          : snapshot.data.documents[0].data['FSCarNo'][index] == null
                                              ? Container()
                                              : StreamBuilder(
                                                  stream: Firestore.instance.collection('correctiveAction').where('carNo', isEqualTo: snapshot.data.documents[0].data['FSCarNo'][index]).snapshots(),
                                                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot2) {

                                                    if (snapshot2.data == null) return CircularProgressIndicator();
                                                    
                                                    return Container(
                                                      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0, bottom: 5.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[
                                                          Flexible(
                                                            child: Text(
                                                              // 'CAR # ${snapshot.data.documents[0].data['FSCarNo'][index].toString().padLeft(4, '0')}',
                                                              'CAR # ${snapshot2.data.documents[0].data['carNo'].toString().padLeft(4, '0')}',
                                                              style: TextStyle(
                                                                color: Colors.black54,
                                                                fontWeight: FontWeight.w700,
                                                                fontSize: 14.0
                                                              ),
                                                            ),
                                                          ),
                                                          Flexible(
                                                            child: Container(
                                                              height: 30.0,
                                                              width: 100.0,
                                                              child: ButtonTheme(
                                                                minWidth: 50,
                                                                height: 30.0,
                                                                child: OutlineButton(
                                                                  child: Text(
                                                                    snapshot2.data.documents[0].data['status'].toString().toUpperCase() == 'CLOSED' ? 'VERIFIED' : snapshot2.data.documents[0].data['status'].toString().toUpperCase(),

                                                                    style: TextStyle(fontSize: 12.0, color: snapshot2.data.documents[0].data['status'].toString().toUpperCase() == 'OPEN' ? Colors.redAccent : snapshot2.data.documents[0].data['status'].toString().toUpperCase() == 'ONGOING' ? Colors.orangeAccent : snapshot2.data.documents[0].data['status'].toString().toUpperCase() == 'DONE' ? AbubaPallate.menuBluebird : Colors.green),
                                                                  ),
                                                                  borderSide: BorderSide(color: snapshot2.data.documents[0].data['status'].toString().toUpperCase() == 'OPEN' ? Colors.redAccent : snapshot2.data.documents[0].data['status'].toString().toUpperCase() == 'ONGOING' ? Colors.orangeAccent : snapshot2.data.documents[0].data['status'].toString().toUpperCase() == 'DONE' ? AbubaPallate.menuBluebird : Colors.green, width: 1.0),

                                                                  highlightedBorderColor: snapshot2.data.documents[0].data['status'].toString().toUpperCase() == 'OPEN' ? Colors.redAccent : snapshot2.data.documents[0].data['status'].toString().toUpperCase() == 'ONGOING' ? Colors.orangeAccent : snapshot2.data.documents[0].data['status'].toString().toUpperCase() == 'DONE' ? AbubaPallate.menuBluebird : Colors.green,

                                                                  onPressed: () {
                                                                    if (snapshot2.data.documents[0].data['userCreated'] == widget.idUser) {
                                                                      if (snapshot2.data.documents[0].data['status'].toString().toUpperCase() == 'DONE') {
                                                                        Navigator.pushReplacement(context,
                                                                          MaterialPageRoute(
                                                                            builder: (_) => VerifikasiLanjutan(departmentUser: widget.departmentUser, idUser: widget.idUser, namaUser: widget.namaUser, status: snapshot2.data.documents[0].data['status'], index: snapshot2.data.documents[0].documentID)
                                                                          )
                                                                        );
                                                                      } else {
                                                                        Navigator.push(context,
                                                                          MaterialPageRoute(
                                                                            builder: (_) => ViewCAR(index: snapshot2.data.documents[0].data['carNo'], namaUser: widget.namaUser, idUser: widget.idUser, departmentUser: widget.departmentUser, idCollectionIA: widget.idCollection)
                                                                          )
                                                                        );
                                                                      }
                                                                    } else if (snapshot2.data.documents[0].data['userDituju'] == widget.idUser) {
                                                                      if (snapshot2.data.documents[0].data['status'].toString().toUpperCase() == 'OPEN' || snapshot2.data.documents[0].data['status'].toString().toUpperCase() == 'ONGOING') {
                                                                        Navigator.pushReplacement(context,
                                                                          MyCustomRoute(
                                                                            builder: (context) => FormCreateLanjutanIA(idUser: widget.idUser, departmentUser: widget.departmentUser, namaUser: widget.namaUser, status: 'carLanjutan', index: snapshot2.data.documents[0].documentID)
                                                                          )
                                                                        );
                                                                      } else {
                                                                        Navigator.push(context,
                                                                          MaterialPageRoute(
                                                                            builder: (_) => ViewCAR(index: snapshot2.data.documents[0].data['carNo'], namaUser: widget.namaUser, idUser: widget.idUser, departmentUser: widget.departmentUser, idCollectionIA: widget.idCollection)
                                                                          )
                                                                        );
                                                                      }
                                                                    } else {
                                                                      Navigator.push(context,
                                                                        MaterialPageRoute(
                                                                          builder: (_) => ViewCAR(index: snapshot2.data.documents[0].data['carNo'], namaUser: widget.namaUser, idUser: widget.idUser, departmentUser: widget.departmentUser, idCollectionIA: widget.idCollection)
                                                                        )
                                                                      );
                                                                    }
                                                                  }
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                )
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    ExpansionTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Area Luar',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700,
                                      color: (hasilAreaLuar * 100).round() > 85.0
                                          ? Colors.green
                                          : (hasilAreaLuar * 100).round() < 70.0
                                          ? Colors.redAccent
                                          : Colors.orangeAccent,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Auditor : ${auditor[0]}',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ),
                        ],
                      ),
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: LinearPercentIndicator(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18.0),
                            width: size,
                            animation: true,
                            lineHeight: 30.0,
                            percent: hasilAreaLuar > 1.0
                                ? 1.0
                                : hasilAreaLuar,
                            center: Text(hasilAreaLuar >= 1.0
                                ? '100%'
                                : '${(hasilAreaLuar * 100).round().toString()}%'),
                            animationDuration: 1000,
                            linearStrokeCap: LinearStrokeCap.butt,
                            progressColor:
                            (hasilAreaLuar * 100).round() > 85.0
                                ? Colors.green
                                : (hasilAreaLuar * 100).round() < 70.0
                                ? Colors.redAccent
                                : Colors.orangeAccent,
                          ),
                        ),
                        Column(
                          children: List.generate(widget.pertanyaanAreaLuar.length, (index) {
                            return Column(
                              children: <Widget>[
                                ListTile(
                                  title: Container(
                                    width: 270.0,
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                widget.systemAreaLuar[
                                                index],
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontWeight:
                                                    FontWeight.w700,
                                                    fontSize: 14.0),
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                widget.criticalAreaLuar[
                                                index] ==
                                                    'false'
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
                                                '${index + 1}. ${widget.pertanyaanAreaLuar[index]}',
                                                style: TextStyle(
                                                    color:
                                                    Colors.black54,
                                                    fontSize: 14.0),
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
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            widget.AreaLuarScore[index]
                                                .toString(),
                                            style: TextStyle(
                                                color: widget.AreaLuarScore[
                                                index] ==
                                                    0
                                                    ? Colors.redAccent
                                                    : widget.AreaLuarScore[
                                                index] ==
                                                    1
                                                    ? Colors
                                                    .orangeAccent
                                                    : Colors.green,
                                                fontWeight:
                                                FontWeight.w700),
                                          ),
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
                                            imageAreaLuar[index] == null
                                              ? Container()
                                              : GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      imageAreaLuarSplit.clear();
                                                      imageAreaLuarSplit = [];
                                                      imageAreaLuarSplit = imageAreaLuar[index].split('###');
                                                      var bantuGambarAreaLuar = _gambarAreaLuar[index];
                                                      _gambarAreaLuar.removeAt(index);
                                                      _gambarAreaLuar.insert(index, !bantuGambarAreaLuar);
                                                      noteAreaLuar.removeAt(index);
                                                      noteAreaLuar.insert(index, false);
                                                    });
                                                  },
                                                  child: Icon(Icons.image, color: AbubaPallate.menuBluebird),
                                                ),
                                              AreaLuarNote[index] == null
                                                ? Container()
                                                : GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        var bantuNoteAreaLuar = noteAreaLuar[index];
                                                        noteAreaLuar.removeAt(index);
                                                        noteAreaLuar.insert(index, !bantuNoteAreaLuar);
                                                        _gambarAreaLuar.removeAt(index);
                                                        _gambarAreaLuar.insert(index, false);
                                                      });   
                                                    },
                                                    child: Icon(Icons.note_add, color: AbubaPallate.menuBluebird),
                                                  )
                                          ]
                                      ),
                                    )
                                ),
                                _gambarAreaLuar[index]
                                    ? imageAreaLuar[index] == null
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
                                                        fontWeight: FontWeight.w700
                                                      ),
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
                                          crossAxisCount: 5,
                                          childAspectRatio: 1.0,
                                          mainAxisSpacing: 4.0,
                                          crossAxisSpacing: 4.0,
                                          shrinkWrap: true,
                                          children: List.generate(imageAreaLuarSplit.length, (index2) {
                                            return GridTile(
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(context,
                                                    MyCustomRoute(builder: (context) => DetailScreenAreaLuar(image: imageAreaLuarSplit[index2].toString(), indexx: index2))
                                                  );
                                                },
                                                child: Hero(
                                                  tag: 'imageHero${index2.toString()}',
                                                  child: Image.network(
                                                    imageAreaLuarSplit[index2].toString(),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  transitionOnUserGestures: true,
                                                )
                                              )
                                            );
                                          }).toList()
                                        ),
                                      )
                                    : Container(),
                                noteAreaLuar[index]
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
                                        AreaLuarNote[index] == null
                                            ? Container()
                                            : Row(
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                '- ${AreaLuarNote[index].toString()}',
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
                                    : Container(),
                              ],
                            );
                          },
                          ),
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Dinning Area',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700,
                                      color: (hasilDinningArea * 100).round() > 85.0
                                          ? Colors.green
                                          : (hasilDinningArea * 100).round() < 70.0
                                          ? Colors.redAccent
                                          : Colors.orangeAccent,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Auditor : ${auditor[1]}',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ),
                        ],
                      ),
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: LinearPercentIndicator(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18.0),
                            width: size,
                            animation: true,
                            lineHeight: 30.0,
                            percent: hasilDinningArea > 1.0
                                ? 1.0
                                : hasilDinningArea,
                            center: Text(hasilDinningArea >= 1.0
                                ? '100%'
                                : '${(hasilDinningArea * 100).round().toString()}%'),
                            animationDuration: 1000,
                            linearStrokeCap: LinearStrokeCap.butt,
                            progressColor:
                            hasilDinningArea * 100 > 85.0
                                ? Colors.green
                                : hasilDinningArea * 100 < 70.0
                                ? Colors.redAccent
                                : Colors.orangeAccent,
                          ),
                        ),
                        Column(
                          children: List.generate(
                            widget.pertanyaanDinningRoom.length,
                                (index) {
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Container(
                                      width: 270.0,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  widget.systemDinningArea[
                                                  index],
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      fontSize: 14.0),
                                                ),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  widget.criticalDinningArea[
                                                  index] ==
                                                      'false'
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
                                                  '${index + 1}. ${widget.pertanyaanDinningRoom[index]}',
                                                  style: TextStyle(
                                                      color:
                                                      Colors.black54,
                                                      fontSize: 14.0),
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
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              widget
                                                  .DinningAreaScore[index]
                                                  .toString(),
                                              style: TextStyle(
                                                  color: widget.DinningAreaScore[
                                                  index] ==
                                                      0
                                                      ? Colors.redAccent
                                                      : widget.DinningAreaScore[
                                                  index] ==
                                                      1
                                                      ? Colors
                                                      .orangeAccent
                                                      : Colors.green,
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
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
                                            imageDinningArea[index] == null
                                              ? Container()
                                              : GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      imageDinningAreaSplit.clear();
                                                      imageDinningAreaSplit = [];
                                                      imageDinningAreaSplit = imageDinningArea[index].split('###');
                                                      var bantuGambarDinning = _gambarDinningArea[index];
                                                      _gambarDinningArea.removeAt(index);
                                                      _gambarDinningArea.insert(index, !bantuGambarDinning);
                                                      _catatanDinningArea.removeAt(index);
                                                      _catatanDinningArea.insert(index, false);
                                                    });
                                                  },
                                                  child: Icon(Icons.image, color: AbubaPallate.menuBluebird),
                                                ),
                                              DinningAreaNote[index] == null
                                                ? Container()
                                                : GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        var bantuCatatanDinning = _catatanDinningArea[index];
                                                        _catatanDinningArea.removeAt(index);
                                                        _catatanDinningArea.insert(index, !bantuCatatanDinning);
                                                        _gambarDinningArea.removeAt(index);
                                                        _gambarDinningArea.insert(index, false);
                                                      });
                                                    },
                                                    child: Icon(Icons.note_add, color: AbubaPallate.menuBluebird),
                                                  ),
                                          ]
                                      ),
                                    ),
                                  ),
                                  _gambarDinningArea[index]
                                      ? imageDinningArea[index] == null
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
                                            crossAxisCount: 5,
                                            childAspectRatio: 1.0,
                                            mainAxisSpacing: 4.0,
                                            crossAxisSpacing: 4.0,
                                            shrinkWrap: true,
                                            children: List.generate(imageDinningAreaSplit.length, (index2) {
                                              return GridTile(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(context,
                                                      MyCustomRoute(builder: (context) => DetailScreenDinningArea(image: imageDinningAreaSplit[index2].toString(), indexx: index2))
                                                    );
                                                  },
                                                  child: Hero(
                                                    tag: 'imageHero${index2.toString()}',
                                                    child: Image.network(
                                                      imageDinningAreaSplit[index2].toString(),
                                                      fit: BoxFit.cover,
                                                    ),
                                                    transitionOnUserGestures: true,
                                                  )
                                                )
                                              );
                                            }).toList()
                                          ),
                                        )
                                      : Container(),
                                  _catatanDinningArea[index]
                                      ? Padding(
                                    padding: EdgeInsets.only(
                                        left: 17.0,
                                        right: 17.0,
                                        bottom: 10.0),
                                    child: Container(
                                      decoration:
                                      const BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                              width: 1.0,
                                              color: Color(
                                                  0xFFFF000000)),
                                          left: BorderSide(
                                              width: 1.0,
                                              color: Color(
                                                  0xFFFF000000)),
                                          right: BorderSide(
                                              width: 1.0,
                                              color: Color(
                                                  0xFFFF000000)),
                                          bottom: BorderSide(
                                              width: 1.0,
                                              color: Color(
                                                  0xFFFF000000)),
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
                                                      color: Colors
                                                          .black54,
                                                      fontWeight:
                                                      FontWeight
                                                          .w700),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          DinningAreaNote[index] ==
                                              null
                                              ? Container()
                                              : Row(
                                            children: <
                                                Widget>[
                                              Flexible(
                                                child: Text(
                                                  '- ${DinningAreaNote[index].toString()}',
                                                  style:
                                                  TextStyle(
                                                    color: Colors
                                                        .black38,
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                      : Container(),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Service',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700,
                                      color: (hasilService * 100).round() > 85.0
                                          ? Colors.green
                                          : (hasilService * 100).round() < 70.0
                                          ? Colors.redAccent
                                          : Colors.orangeAccent,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Auditor : ${auditor[2]}',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ),
                        ],
                      ),
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: LinearPercentIndicator(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18.0),
                            width: size,
                            animation: true,
                            lineHeight: 30.0,
                            percent: hasilService > 1.0
                                ? 1.0
                                : hasilService,
                            center: Text(hasilService >= 1.0
                                ? '100%'
                                : '${(hasilService * 100).round().toString()}%'),
                            animationDuration: 1000,
                            linearStrokeCap: LinearStrokeCap.butt,
                            progressColor:
                            hasilService * 100 > 85.0
                                ? Colors.green
                                : hasilService * 100 < 70.0
                                ? Colors.redAccent
                                : Colors.orangeAccent,
                          ),
                        ),
                        Column(
                          children: List.generate(
                            widget.pertanyaanService.length,
                                (index) {
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Container(
                                      width: 270.0,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  widget.systemService[
                                                  index],
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      fontSize: 14.0),
                                                ),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  widget.criticalService[
                                                  index] ==
                                                      'false'
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
                                                  '${index + 1}. ${widget.pertanyaanService[index]}',
                                                  style: TextStyle(
                                                      color:
                                                      Colors.black54,
                                                      fontSize: 14.0),
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
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              widget.ServiceScore[index]
                                                  .toString(),
                                              style: TextStyle(
                                                  color: widget.ServiceScore[
                                                  index] ==
                                                      0
                                                      ? Colors.redAccent
                                                      : widget.ServiceScore[
                                                  index] ==
                                                      1
                                                      ? Colors
                                                      .orangeAccent
                                                      : Colors.green,
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
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
                                            imageService[index] == null
                                              ? Container()
                                              : GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      imageServiceSplit.clear();
                                                      imageServiceSplit = [];
                                                      imageServiceSplit = imageService[index].split('###');
                                                      var bantuGambarService = _gambarService[index];
                                                      _gambarService.removeAt(index);
                                                      _gambarService.insert(index, !bantuGambarService);
                                                      _catatanService.removeAt(index);
                                                      _catatanService.insert(index, false);
                                                    });
                                                  },
                                                  child: Icon(Icons.image, color: AbubaPallate.menuBluebird),
                                                ),
                                              ServiceNote[index] == null
                                                ? Container()
                                                : GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        var bantuCatatanService = _catatanService[index];
                                                        _catatanService.removeAt(index);
                                                        _catatanService.insert(index, !bantuCatatanService);
                                                        _gambarService.removeAt(index);
                                                        _gambarService.insert(index, false);
                                                      });
                                                    },
                                                    child: Icon(Icons.note_add, color: AbubaPallate.menuBluebird),
                                                  ),
                                          ]
                                      ),
                                    ),
                                  ),
                                  _gambarService[index]
                                      ? imageService[index] == null
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
                                        crossAxisCount: 5,
                                        childAspectRatio: 1.0,
                                        mainAxisSpacing: 4.0,
                                        crossAxisSpacing: 4.0,
                                        shrinkWrap: true,
                                        children: List.generate(imageServiceSplit.length, (index2) {
                                          return GridTile(
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(context,
                                                  MyCustomRoute(builder: (context) => DetailScreenService(image: imageServiceSplit[index2].toString(), indexx: index2))
                                                );
                                              },
                                              child: Hero(
                                                tag: 'imageHero${index2.toString()}',
                                                child: Image.network(
                                                  imageServiceSplit[index2].toString(),
                                                  fit: BoxFit.cover,
                                                ),
                                                transitionOnUserGestures: true,
                                              )
                                            )
                                          );
                                        }).toList()
                                    ),
                                  )
                                      : Container(),
                                  _catatanService[index]
                                      ? Padding(
                                    padding: EdgeInsets.only(
                                        left: 17.0,
                                        right: 17.0,
                                        bottom: 10.0),
                                    child: Container(
                                      decoration:
                                      const BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                              width: 1.0,
                                              color: Color(
                                                  0xFFFF000000)),
                                          left: BorderSide(
                                              width: 1.0,
                                              color: Color(
                                                  0xFFFF000000)),
                                          right: BorderSide(
                                              width: 1.0,
                                              color: Color(
                                                  0xFFFF000000)),
                                          bottom: BorderSide(
                                              width: 1.0,
                                              color: Color(
                                                  0xFFFF000000)),
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
                                                      color: Colors
                                                          .black54,
                                                      fontWeight:
                                                      FontWeight
                                                          .w700),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          ServiceNote[index] == null
                                              ? Container()
                                              : Row(
                                            children: <
                                                Widget>[
                                              Flexible(
                                                child: Text(
                                                  '- ${ServiceNote[index].toString()}',
                                                  style:
                                                  TextStyle(
                                                    color: Colors
                                                        .black38,
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                      : Container(),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Cashier',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700,
                                      color: (hasilCashier * 100).round() > 85.0
                                          ? Colors.green
                                          : (hasilCashier * 100).round() < 70.0
                                          ? Colors.redAccent
                                          : Colors.orangeAccent,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Auditor : ${auditor[3]}',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ),
                        ],
                      ),
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: LinearPercentIndicator(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18.0),
                            width: size,
                            animation: true,
                            lineHeight: 30.0,
                            percent: hasilCashier > 1.0
                                ? 1.0
                                : hasilCashier,
                            center: Text(hasilCashier >= 1.0
                                ? '100%'
                                : '${(hasilCashier * 100).round().toString()}%'),
                            animationDuration: 1000,
                            linearStrokeCap: LinearStrokeCap.butt,
                            progressColor:
                            hasilCashier * 100 > 85.0
                                ? Colors.green
                                : hasilCashier * 100 < 70.0
                                ? Colors.redAccent
                                : Colors.orangeAccent,
                          ),
                        ),
                        Column(
                          children: List.generate(
                            widget.pertanyaanCashier.length,
                                (index) {
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Container(
                                      width: 270.0,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  widget.systemCashier[
                                                  index],
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      fontSize: 14.0),
                                                ),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  widget.criticalCashier[
                                                  index] ==
                                                      'false'
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
                                                  '${index + 1}. ${widget.pertanyaanCashier[index]}',
                                                  style: TextStyle(
                                                      color:
                                                      Colors.black54,
                                                      fontSize: 14.0),
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
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              widget.CashierScore[index]
                                                  .toString(),
                                              style: TextStyle(
                                                  color: widget.CashierScore[
                                                  index] ==
                                                      0
                                                      ? Colors.redAccent
                                                      : widget.CashierScore[
                                                  index] ==
                                                      1
                                                      ? Colors
                                                      .orangeAccent
                                                      : Colors.green,
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
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
                                            imageCashier[index] == null
                                              ? Container()
                                              : GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      imageCashierSplit.clear();
                                                      imageCashierSplit = [];
                                                      imageCashierSplit = imageCashier[index].split('###');
                                                      var bantuGambarCashier = _gambarCashier[index];
                                                      _gambarCashier.removeAt(index);
                                                      _gambarCashier.insert(index, !bantuGambarCashier);
                                                      _catatanCashier.removeAt(index);
                                                      _catatanCashier.insert(index, false);
                                                    });
                                                  },
                                                  child: Icon(Icons.image, color: imageCashier[index] == null ? Colors.grey : AbubaPallate.menuBluebird),
                                                ),
                                              CashierNote[index] == null
                                                ? Container()
                                                : GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        var bantuCatatanCashier = _catatanCashier[index];
                                                        _catatanCashier.removeAt(index);
                                                        _catatanCashier.insert(index, !bantuCatatanCashier);
                                                        _gambarCashier.removeAt(index);
                                                        _gambarCashier.insert(index, false);
                                                      });
                                                    },
                                                    child: Icon(Icons.note_add, color: AbubaPallate.menuBluebird),
                                                  ),
                                          ]
                                      ),
                                    ),
                                  ),
                                  _gambarCashier[index]
                                      ? imageCashier[index] == null
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
                                        crossAxisCount: 5,
                                        childAspectRatio: 1.0,
                                        mainAxisSpacing: 4.0,
                                        crossAxisSpacing: 4.0,
                                        shrinkWrap: true,
                                        children: List.generate(imageCashierSplit.length, (index2) {
                                          return GridTile(
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(context,
                                                  MyCustomRoute(builder: (context) => DetailScreenCashier(image: imageCashierSplit[index2].toString(), indexx: index2))
                                                );
                                              },
                                              child: Hero(
                                                tag: 'imageHero${index2.toString()}',
                                                child: Image.network(
                                                  imageCashierSplit[index2].toString(),
                                                  fit: BoxFit.cover,
                                                ),
                                                transitionOnUserGestures: true,
                                              )
                                            )
                                          );
                                        }).toList()
                                    ),
                                  )
                                      : Container(),
                                  _catatanCashier[index]
                                      ? Padding(
                                    padding: EdgeInsets.only(
                                        left: 17.0,
                                        right: 17.0,
                                        bottom: 10.0),
                                    child: Container(
                                      decoration:
                                      const BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                              width: 1.0,
                                              color: Color(
                                                  0xFFFF000000)),
                                          left: BorderSide(
                                              width: 1.0,
                                              color: Color(
                                                  0xFFFF000000)),
                                          right: BorderSide(
                                              width: 1.0,
                                              color: Color(
                                                  0xFFFF000000)),
                                          bottom: BorderSide(
                                              width: 1.0,
                                              color: Color(
                                                  0xFFFF000000)),
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
                                                      color: Colors
                                                          .black54,
                                                      fontWeight:
                                                      FontWeight
                                                          .w700),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          CashierNote[index] == null
                                              ? Container()
                                              : Row(
                                            children: <
                                                Widget>[
                                              Flexible(
                                                child: Text(
                                                  '- ${CashierNote[index].toString()}',
                                                  style:
                                                  TextStyle(
                                                    color: Colors
                                                        .black38,
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                      : Container(),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Administrasi Keuangan',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700,
                                      color: (hasilCashierAccuracy * 100).round() > 85.0
                                          ? Colors.green
                                          : (hasilCashierAccuracy * 100).round() < 70.0
                                          ? Colors.redAccent
                                          : Colors.orangeAccent,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Auditor : ${auditor[4]}',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ),
                        ],
                      ),
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: LinearPercentIndicator(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18.0),
                            width: size,
                            animation: true,
                            lineHeight: 30.0,
                            percent: hasilCashierAccuracy > 1.0
                                ? 1.0
                                : hasilCashierAccuracy,
                            center: Text(hasilCashierAccuracy >= 1.0
                                ? '100%'
                                : '${(hasilCashierAccuracy * 100).round().toString()}%'),
                            animationDuration: 1000,
                            linearStrokeCap: LinearStrokeCap.butt,
                            progressColor:
                            hasilCashierAccuracy * 100 > 85.0
                                ? Colors.green
                                : hasilCashierAccuracy * 100 < 70.0
                                ? Colors.redAccent
                                : Colors.orangeAccent,
                          ),
                        ),
                        Column(
                          children: List.generate(
                            widget.pertanyaanCashierAccuracy.length,
                                (index) {
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Container(
                                      width: 270.0,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  widget.systemCashierAccuracy[
                                                  index],
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      fontSize: 14.0),
                                                ),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  widget.criticalCashierAccuracy[
                                                  index] ==
                                                      'false'
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
                                                  '${index + 1}. ${widget.pertanyaanCashierAccuracy[index]}',
                                                  style: TextStyle(
                                                      color:
                                                      Colors.black54,
                                                      fontSize: 14.0),
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
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              widget.CashierAccuracyScore[
                                              index]
                                                  .toString(),
                                              style: TextStyle(
                                                  color: widget.CashierAccuracyScore[
                                                  index] ==
                                                      0
                                                      ? Colors.redAccent
                                                      : widget.CashierAccuracyScore[
                                                  index] ==
                                                      1
                                                      ? Colors
                                                      .orangeAccent
                                                      : Colors.green,
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
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
                                            imageCashierAccuracy[index] == null
                                              ? Container()
                                              : GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      imageCashierAccuracySplit.clear();
                                                      imageCashierAccuracySplit = [];
                                                      imageCashierAccuracySplit = imageCashierAccuracy[index].split('###');
                                                      var bantuGambarCashierAccuracy = _gambarCashierAccuracy[index];
                                                      _gambarCashierAccuracy.removeAt(index);
                                                      _gambarCashierAccuracy.insert(index, !bantuGambarCashierAccuracy);
                                                      _catatanCashierAccuracy.removeAt(index);
                                                      _catatanCashierAccuracy.insert(index, false);
                                                    });
                                                  },
                                                  child: Icon(Icons.image, color: AbubaPallate.menuBluebird),
                                                ),
                                              bantuTemplateCount == 'yes'
                                                ? templateCount[index] == null
                                                    ? Container()
                                                    : Container(
                                                        width: MediaQuery.of(context).size.width * 0.13,
                                                        height: MediaQuery.of(context).size.width * 0.13,
                                                        child: FlatButton(
                                                          shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                                                          child: Container(
                                                            padding: EdgeInsets.only(right: 10.0, bottom: 10.0, left: 10.0),
                                                            alignment: Alignment.centerRight,
                                                            decoration: new BoxDecoration(
                                                              color: Colors.transparent,
                                                              shape: BoxShape.rectangle,
                                                              image: DecorationImage(
                                                                image: AssetImage('assets/images/templateCountBlue.png'),
                                                                fit: BoxFit.fitWidth,
                                                              )
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            if (templateCount[index] == 'cash') {
                                                              Navigator.push(context, 
                                                                MaterialPageRoute(
                                                                  builder: (_) => DetailReportCash(departmentUser: widget.departmentUser, idUser: widget.idUser, index: widget.idCollection, namaUser: widget.namaUser)
                                                                )
                                                              );
                                                            } else if (templateCount[index] == 'inventory') {
                                                              Navigator.push(context, 
                                                                MaterialPageRoute(
                                                                  builder: (_) => DetailReportInventory(departmentUser: widget.departmentUser, idUser: widget.idUser, index: widget.idCollection, namaUser: widget.namaUser)
                                                                )
                                                              );
                                                            } else if (templateCount[index] == 'equipment') {
                                                              Navigator.push(context, 
                                                                MaterialPageRoute(
                                                                  builder: (_) => DetailReportEquipment(departmentUser: widget.departmentUser, idUser: widget.idUser, index: widget.idCollection, namaUser: widget.namaUser)
                                                                )
                                                              );
                                                            } else if (templateCount[index] == 'assets') {
                                                              Navigator.push(context, 
                                                                MaterialPageRoute(
                                                                  builder: (_) => DetailReportAssets(departmentUser: widget.departmentUser, idUser: widget.idUser, index: widget.idCollection, namaUser: widget.namaUser)
                                                                )
                                                              );
                                                            } else {}
                                                          },
                                                        ),
                                                      )
                                                : Container(),
                                              CashierAccuracyNote[index] == null
                                                ? Container()
                                                : GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        var bantuCatatanCashierAccuracy = _catatanCashierAccuracy[index];
                                                        _catatanCashierAccuracy.removeAt(index);
                                                        _catatanCashierAccuracy.insert(index, !bantuCatatanCashierAccuracy);
                                                        _gambarCashierAccuracy.removeAt(index);
                                                        _gambarCashierAccuracy.insert(index, false);
                                                      });
                                                    },
                                                    child: Icon(Icons.note_add, color: AbubaPallate.menuBluebird),
                                                  ),
                                          ]
                                      ),
                                    ),
                                  ),
                                  _gambarCashierAccuracy[index]
                                      ? imageCashierAccuracy[index] == null
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
                                        crossAxisCount: 5,
                                        childAspectRatio: 1.0,
                                        mainAxisSpacing: 4.0,
                                        crossAxisSpacing: 4.0,
                                        shrinkWrap: true,
                                        children: List.generate(imageCashierAccuracySplit.length, (index2) {
                                          return GridTile(
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(context,
                                                  MyCustomRoute(builder: (context) => DetailScreenCashierAccuracy(image: imageCashierAccuracySplit[index2].toString(), indexx: index2))
                                                );
                                              },
                                              child: Hero(
                                                tag: 'imageHero${index2.toString()}',
                                                child: Image.network(
                                                  imageCashierAccuracySplit[index2].toString(),
                                                  fit: BoxFit.cover,
                                                ),
                                                transitionOnUserGestures: true,
                                              )
                                            )
                                          );
                                        }).toList()
                                    ),
                                  )
                                      : Container(),
                                  _catatanCashierAccuracy[index]
                                      ? Padding(
                                    padding: EdgeInsets.only(
                                        left: 17.0,
                                        right: 17.0,
                                        bottom: 10.0),
                                    child: Container(
                                      decoration:
                                      const BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                              width: 1.0,
                                              color: Color(
                                                  0xFFFF000000)),
                                          left: BorderSide(
                                              width: 1.0,
                                              color: Color(
                                                  0xFFFF000000)),
                                          right: BorderSide(
                                              width: 1.0,
                                              color: Color(
                                                  0xFFFF000000)),
                                          bottom: BorderSide(
                                              width: 1.0,
                                              color: Color(
                                                  0xFFFF000000)),
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
                                                      color: Colors
                                                          .black54,
                                                      fontWeight:
                                                      FontWeight
                                                          .w700),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          CashierAccuracyNote[
                                          index] ==
                                              null
                                              ? Container()
                                              : Row(
                                            children: <
                                                Widget>[
                                              Flexible(
                                                child: Text(
                                                  '- ${CashierAccuracyNote[index].toString()}',
                                                  style:
                                                  TextStyle(
                                                    color: Colors
                                                        .black38,
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                      : Container(),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Back of The House (BOH)',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700,
                                      color: (hasilBoh * 100).round() > 85.0
                                          ? Colors.green
                                          : (hasilBoh * 100).round() < 70.0
                                          ? Colors.redAccent
                                          : Colors.orangeAccent,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Auditor : ${auditor[5]}',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ),
                        ],
                      ),
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: LinearPercentIndicator(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18.0),
                            width: size,
                            animation: true,
                            lineHeight: 30.0,
                            percent: hasilBoh > 1.0
                                ? 1.0
                                : hasilBoh,
                            center: Text(hasilBoh >= 1.0
                                ? '100%'
                                : '${(hasilBoh * 100).round().toString()}%'),
                            animationDuration: 1000,
                            linearStrokeCap: LinearStrokeCap.butt,
                            progressColor:
                            hasilBoh * 100 > 85.0
                                ? Colors.green
                                : hasilBoh * 100 < 70.0
                                ? Colors.redAccent
                                : Colors.orangeAccent,
                          ),
                        ),
                        Column(
                          children: List.generate(
                            widget.pertanyaanBOH.length,
                                (index) {
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Container(
                                      width: 270.0,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  widget.systemBoh[index],
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      fontSize: 14.0),
                                                ),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  widget.criticalBoh[
                                                  index] ==
                                                      'false'
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
                                                  '${index + 1}. ${widget.pertanyaanBOH[index]}',
                                                  style: TextStyle(
                                                      color:
                                                      Colors.black54,
                                                      fontSize: 14.0),
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
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              widget.BohScore[index]
                                                  .toString(),
                                              style: TextStyle(
                                                  color: widget.BohScore[
                                                  index] ==
                                                      0
                                                      ? Colors.redAccent
                                                      : widget.BohScore[
                                                  index] ==
                                                      1
                                                      ? Colors
                                                      .orangeAccent
                                                      : Colors.green,
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
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
                                            imageBoh[index] == null
                                              ? Container()
                                              : GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      imageBohSplit.clear();
                                                      imageBohSplit = [];
                                                      imageBohSplit = imageBoh[index].split('###');
                                                      var bantuGambarBoh = _gambarBoh[index];
                                                      _gambarBoh.removeAt(index);
                                                      _gambarBoh.insert(index, !bantuGambarBoh);
                                                      _catatanBoh.removeAt(index);
                                                      _catatanBoh.insert(index, false);
                                                    });
                                                  },
                                                  child: Icon(Icons.image, color: AbubaPallate.menuBluebird),
                                                ),
                                              BohNote[index] == null
                                                ? Container()
                                                : GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        var bantuCatatanBoh = _catatanBoh[index];
                                                        _catatanBoh.removeAt(index);
                                                        _catatanBoh.insert(index, !bantuCatatanBoh);
                                                        _gambarBoh.removeAt(index);
                                                        _gambarBoh.insert(index, false);
                                                      });
                                                    },
                                                    child: Icon(Icons.note_add, color: AbubaPallate.menuBluebird),
                                                  ),
                                          ]
                                      ),
                                    ),
                                  ),
                                  _gambarBoh[index]
                                      ? imageBoh[index] == null
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
                                        crossAxisCount: 5,
                                        childAspectRatio: 1.0,
                                        mainAxisSpacing: 4.0,
                                        crossAxisSpacing: 4.0,
                                        shrinkWrap: true,
                                        children: List.generate(imageBohSplit.length, (index2) {
                                          return GridTile(
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(context,
                                                  MyCustomRoute(builder: (context) => DetailScreenBoh(image: imageBohSplit[index2].toString(), indexx: index2))
                                                );
                                              },
                                              child: Hero(
                                                tag: 'imageHero${index2.toString()}',
                                                child: Image.network(
                                                  imageBohSplit[index2].toString(),
                                                  fit: BoxFit.cover,
                                                ),
                                                transitionOnUserGestures: true,
                                              )
                                            )
                                          );
                                        }).toList()
                                    ),
                                  )
                                      : Container(),
                                  _catatanBoh[index]
                                      ? Padding(
                                    padding: EdgeInsets.only(
                                        left: 17.0,
                                        right: 17.0,
                                        bottom: 10.0),
                                    child: Container(
                                      decoration:
                                      const BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                              width: 1.0,
                                              color: Color(
                                                  0xFFFF000000)),
                                          left: BorderSide(
                                              width: 1.0,
                                              color: Color(
                                                  0xFFFF000000)),
                                          right: BorderSide(
                                              width: 1.0,
                                              color: Color(
                                                  0xFFFF000000)),
                                          bottom: BorderSide(
                                              width: 1.0,
                                              color: Color(
                                                  0xFFFF000000)),
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
                                                      color: Colors
                                                          .black54,
                                                      fontWeight:
                                                      FontWeight
                                                          .w700),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          BohNote[index] == null
                                              ? Container()
                                              : Row(
                                            children: <
                                                Widget>[
                                              Flexible(
                                                child: Text(
                                                  '- ${BohNote[index].toString()}',
                                                  style:
                                                  TextStyle(
                                                    color: Colors
                                                        .black38,
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                      : Container(),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Warehouse',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700,
                                      color: (hasilWarehouse * 100).round() > 85.0
                                          ? Colors.green
                                          : (hasilWarehouse * 100).round() < 70.0
                                          ? Colors.redAccent
                                          : Colors.orangeAccent,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Auditor : ${auditor[6]}',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ),
                        ],
                      ),
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: LinearPercentIndicator(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18.0),
                            width: size,
                            animation: true,
                            lineHeight: 30.0,
                            percent: hasilWarehouse > 1.0
                                ? 1.0
                                : hasilWarehouse,
                            center: Text(hasilWarehouse >= 1.0
                                ? '100%'
                                : '${(hasilWarehouse * 100).round().toString()}%'),
                            animationDuration: 1000,
                            linearStrokeCap: LinearStrokeCap.butt,
                            progressColor:
                            hasilWarehouse * 100 > 85.0
                                ? Colors.green
                                : hasilWarehouse * 100 < 70.0
                                ? Colors.redAccent
                                : Colors.orangeAccent,
                          ),
                        ),
                        Column(
                          children: List.generate(
                            widget.pertanyaanWareHouse.length,
                                (index) {
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Container(
                                      width: 270.0,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  widget.systemWarehouse[
                                                  index],
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      fontSize: 14.0),
                                                ),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  widget.criticalWarehouse[
                                                  index] ==
                                                      'false'
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
                                                  '${index + 1}. ${widget.pertanyaanWareHouse[index]}',
                                                  style: TextStyle(
                                                      color:
                                                      Colors.black54,
                                                      fontSize: 14.0),
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
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              widget.WarehouseScore[index]
                                                  .toString(),
                                              style: TextStyle(
                                                  color: widget.WarehouseScore[
                                                  index] ==
                                                      0
                                                      ? Colors.redAccent
                                                      : widget.WarehouseScore[
                                                  index] ==
                                                      1
                                                      ? Colors
                                                      .orangeAccent
                                                      : Colors.green,
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
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
                                            imageWarehouse[index] == null
                                              ? Container()
                                              : GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      imageWarehouseSplit.clear();
                                                      imageWarehouseSplit = [];
                                                      imageWarehouseSplit = imageWarehouse[index].split('###');
                                                      var bantuGambarWarehouse = _gambarWarehouse[index];
                                                      _gambarWarehouse.removeAt(index);
                                                      _gambarWarehouse.insert(index, !bantuGambarWarehouse);
                                                      _catatanWarehouse.removeAt(index);
                                                      _catatanWarehouse.insert(index, false);
                                                    });
                                                  },
                                                  child: Icon(Icons.image, color: AbubaPallate.menuBluebird),
                                                ),
                                              WarehouseNote[index] == null
                                                ? Container()
                                                : GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        var bantuCatatanWareHouse = _catatanWarehouse[index];
                                                        _catatanWarehouse.removeAt(index);
                                                        _catatanWarehouse.insert(index, !bantuCatatanWareHouse);
                                                        _gambarWarehouse.removeAt(index);
                                                        _gambarWarehouse.insert(index, false);
                                                      });
                                                    },
                                                    child: Icon(Icons.note_add, color: AbubaPallate.menuBluebird),
                                                  ),
                                          ]
                                      ),
                                    ),
                                  ),
                                  _gambarWarehouse[index]
                                      ? imageWarehouse[index] == null
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
                                        crossAxisCount: 5,
                                        childAspectRatio: 1.0,
                                        mainAxisSpacing: 4.0,
                                        crossAxisSpacing: 4.0,
                                        shrinkWrap: true,
                                        children: List.generate(imageWarehouseSplit.length, (index2) {
                                          return GridTile(
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(context,
                                                  MyCustomRoute(builder: (context) => DetailScreenWarehouse(image: imageWarehouseSplit[index2].toString(), indexx: index2))
                                                );
                                              },
                                              child: Hero(
                                                tag: 'imageHero${index2.toString()}',
                                                child: Image.network(
                                                  imageWarehouseSplit[index2].toString(),
                                                  fit: BoxFit.cover,
                                                ),
                                                transitionOnUserGestures: true,
                                              )
                                            )
                                          );
                                        }).toList()
                                    ),
                                  )
                                      : Container(),
                                  _catatanWarehouse[index]
                                      ? Padding(
                                    padding: EdgeInsets.only(
                                        left: 17.0,
                                        right: 17.0,
                                        bottom: 10.0),
                                    child: Container(
                                      decoration:
                                      const BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                              width: 1.0,
                                              color: Color(
                                                  0xFFFF000000)),
                                          left: BorderSide(
                                              width: 1.0,
                                              color: Color(
                                                  0xFFFF000000)),
                                          right: BorderSide(
                                              width: 1.0,
                                              color: Color(
                                                  0xFFFF000000)),
                                          bottom: BorderSide(
                                              width: 1.0,
                                              color: Color(
                                                  0xFFFF000000)),
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
                                                      color: Colors
                                                          .black54,
                                                      fontWeight:
                                                      FontWeight
                                                          .w700),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          WarehouseNote[index] ==
                                              null
                                              ? Container()
                                              : Row(
                                            children: <
                                                Widget>[
                                              Flexible(
                                                child: Text(
                                                  '- ${WarehouseNote[index].toString()}',
                                                  style:
                                                  TextStyle(
                                                    color: Colors
                                                        .black38,
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                      : Container(),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Social Block',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700,
                                      color: (hasilSocial * 100).round() > 85.0
                                          ? Colors.green
                                          : (hasilSocial * 100).round() < 70.0
                                          ? Colors.redAccent
                                          : Colors.orangeAccent,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Auditor : ${auditor[7]}',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ),
                        ],
                      ),
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: LinearPercentIndicator(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18.0),
                            width: size,
                            animation: true,
                            lineHeight: 30.0,
                            percent: hasilSocial > 1.0
                                ? 1.0
                                : hasilSocial,
                            center: Text(hasilSocial >= 1.0
                                ? '100%'
                                : '${(hasilSocial * 100).round().toString()}%'),
                            animationDuration: 1000,
                            linearStrokeCap: LinearStrokeCap.butt,
                            progressColor:
                            hasilSocial * 100 > 85.0
                                ? Colors.green
                                : hasilSocial * 100 < 70.0
                                ? Colors.redAccent
                                : Colors.orangeAccent,
                          ),
                        ),
                        Column(
                          children: List.generate(
                            widget.pertanyaanSocialBlock.length,
                                (index) {
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Container(
                                      width: 270.0,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  widget.systemSocialBlock[
                                                  index],
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      fontSize: 14.0),
                                                ),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  widget.criticalSocialBlock[
                                                  index] ==
                                                      'false'
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
                                                  '${index + 1}. ${widget.pertanyaanSocialBlock[index]}',
                                                  style: TextStyle(
                                                      color:
                                                      Colors.black54,
                                                      fontSize: 14.0),
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
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              widget
                                                  .SocialBlockScore[index]
                                                  .toString(),
                                              style: TextStyle(
                                                  color: widget.SocialBlockScore[
                                                  index] ==
                                                      0
                                                      ? Colors.redAccent
                                                      : widget.SocialBlockScore[
                                                  index] ==
                                                      1
                                                      ? Colors
                                                      .orangeAccent
                                                      : Colors.green,
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
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
                                            imageSocialBlock[index] == null
                                              ? Container()
                                              : GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      imageSocialBlockSplit.clear();
                                                      imageSocialBlockSplit = [];
                                                      imageSocialBlockSplit = imageSocialBlock[index].split('###');
                                                      var bantuGambarSocialBlock = _gambarSocialBlock[index];
                                                      _gambarSocialBlock.removeAt(index);
                                                      _gambarSocialBlock.insert(index, !bantuGambarSocialBlock);
                                                      _catatanSocialBlock.removeAt(index);
                                                      _catatanSocialBlock.insert(index, false);
                                                    });
                                                  },
                                                  child: Icon(Icons.image, color: imageSocialBlock[index] == null ? Colors.grey : AbubaPallate.menuBluebird),
                                                ),
                                              SocialBlockNote[index] == null
                                                ? Container()
                                                : GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        var bantuCatatanSocialBlock = _catatanSocialBlock[index];
                                                        _catatanSocialBlock.removeAt(index);
                                                        _catatanSocialBlock.insert(index, !bantuCatatanSocialBlock);
                                                        _gambarSocialBlock.removeAt(index);
                                                        _gambarSocialBlock.insert(index, false);
                                                      });
                                                    },
                                                    child: Icon(Icons.note_add, color: AbubaPallate.menuBluebird),
                                                  ),
                                          ]
                                      ),
                                    ),
                                  ),
                                  _gambarSocialBlock[index]
                                      ? imageSocialBlock[index] == null
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
                                        crossAxisCount: 5,
                                        childAspectRatio: 1.0,
                                        mainAxisSpacing: 4.0,
                                        crossAxisSpacing: 4.0,
                                        shrinkWrap: true,
                                        children: List.generate(imageSocialBlockSplit.length, (index2) {
                                          return GridTile(
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(context,
                                                  MyCustomRoute(builder: (context) => DetailScreenSocialBlock(image: imageSocialBlockSplit[index2].toString(), indexx: index2))
                                                );
                                              },
                                              child: Hero(
                                                tag: 'imageHero${index2.toString()}',
                                                child: Image.network(
                                                  imageSocialBlockSplit[index2].toString(),
                                                  fit: BoxFit.cover,
                                                ),
                                                transitionOnUserGestures: true,
                                              )
                                            )
                                          );
                                        }).toList()
                                    ),
                                  )
                                      : Container(),
                                  _catatanSocialBlock[index]
                                      ? Padding(
                                    padding: EdgeInsets.only(
                                        left: 17.0,
                                        right: 17.0,
                                        bottom: 10.0),
                                    child: Container(
                                      decoration:
                                      const BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                              width: 1.0,
                                              color: Color(
                                                  0xFFFF000000)),
                                          left: BorderSide(
                                              width: 1.0,
                                              color: Color(
                                                  0xFFFF000000)),
                                          right: BorderSide(
                                              width: 1.0,
                                              color: Color(
                                                  0xFFFF000000)),
                                          bottom: BorderSide(
                                              width: 1.0,
                                              color: Color(
                                                  0xFFFF000000)),
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
                                                      color: Colors
                                                          .black54,
                                                      fontWeight:
                                                      FontWeight
                                                          .w700),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          SocialBlockNote[index] ==
                                              null
                                              ? Container()
                                              : Row(
                                            children: <
                                                Widget>[
                                              Flexible(
                                                child: Text(
                                                  '- ${SocialBlockNote[index].toString()}',
                                                  style:
                                                  TextStyle(
                                                    color: Colors
                                                        .black38,
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                      : Container(),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Personal Hygiene',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700,
                                      color: (hasilPersonal * 100).round() > 85.0
                                          ? Colors.green
                                          : (hasilPersonal * 100).round() < 70.0
                                          ? Colors.redAccent
                                          : Colors.orangeAccent,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Auditor : ${auditor[8]}',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ),
                        ],
                      ),
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: LinearPercentIndicator(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18.0),
                            width: size,
                            animation: true,
                            lineHeight: 30.0,
                            percent: hasilPersonal > 1.0
                                ? 1.0
                                : hasilPersonal,
                            center: Text(hasilPersonal >= 1.0
                                ? '100%'
                                : '${(hasilPersonal * 100).round().toString()}%'),
                            animationDuration: 1000,
                            linearStrokeCap: LinearStrokeCap.butt,
                            progressColor:
                            hasilPersonal * 100 > 85.0
                                ? Colors.green
                                : hasilPersonal * 100 < 70.0
                                ? Colors.redAccent
                                : Colors.orangeAccent,
                          ),
                        ),
                        Column(
                          children: List.generate(
                            widget.pertanyaanPersonalHygiene.length,
                                (index) {
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Container(
                                      width: 270.0,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  widget.systemPersonal[
                                                  index],
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      fontSize: 14.0),
                                                ),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  widget.criticalPersonal[
                                                  index] ==
                                                      'false'
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
                                                  '${index + 1}. ${widget.pertanyaanPersonalHygiene[index]}',
                                                  style: TextStyle(
                                                      color:
                                                      Colors.black54,
                                                      fontSize: 14.0),
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
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              widget
                                                  .PersonalScore[index]
                                                  .toString(),
                                              style: TextStyle(
                                                  color: widget.PersonalScore[
                                                  index] ==
                                                      0
                                                      ? Colors.redAccent
                                                      : widget.PersonalScore[
                                                  index] ==
                                                      1
                                                      ? Colors
                                                      .orangeAccent
                                                      : Colors.green,
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
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
                                            imagePersonal[index] == null
                                              ? Container()
                                              : GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      imagePersonalSplit.clear();
                                                      imagePersonalSplit = [];
                                                      imagePersonalSplit = imagePersonal[index].split('###');
                                                      var bantuGambarPersonal = _gambarPersonal[index];
                                                      _gambarPersonal.removeAt(index);
                                                      _gambarPersonal.insert(index, !bantuGambarPersonal);
                                                      _catatanPersonal.removeAt(index);
                                                      _catatanPersonal.insert(index, false);
                                                    });
                                                  },
                                                  child: Icon(Icons.image, color: AbubaPallate.menuBluebird),
                                                ),
                                              PersonalNote[index] == null
                                                ? Container()
                                                : GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        var bantuCatatanPersonal = _catatanPersonal[index];
                                                        _catatanPersonal.removeAt(index);
                                                        _catatanPersonal.insert(index, !bantuCatatanPersonal);
                                                        _gambarPersonal.removeAt(index);
                                                        _gambarPersonal.insert(index, false);
                                                      });
                                                    },
                                                    child: Icon(Icons.note_add, color: AbubaPallate.menuBluebird),
                                                  ),
                                          ]
                                      ),
                                    ),
                                  ),
                                  _gambarPersonal[index]
                                      ? imagePersonal[index] == null
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
                                        crossAxisCount: 5,
                                        childAspectRatio: 1.0,
                                        mainAxisSpacing: 4.0,
                                        crossAxisSpacing: 4.0,
                                        shrinkWrap: true,
                                        children: List.generate(imagePersonalSplit.length, (index2) {
                                          return GridTile(
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(context,
                                                  MyCustomRoute(builder: (context) => DetailScreenPersonal(image: imagePersonalSplit[index2].toString(), indexx: index2))
                                                );
                                              },
                                              child: Hero(
                                                tag: 'imageHero${index2.toString()}',
                                                child: Image.network(
                                                  imagePersonalSplit[index2].toString(),
                                                  fit: BoxFit.cover,
                                                ),
                                                transitionOnUserGestures: true,
                                              )
                                            )
                                          );
                                        }).toList()
                                    ),
                                  )
                                      : Container(),
                                  _catatanPersonal[index]
                                      ? Padding(
                                    padding: EdgeInsets.only(
                                        left: 17.0,
                                        right: 17.0,
                                        bottom: 10.0),
                                    child: Container(
                                      decoration:
                                      const BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                              width: 1.0,
                                              color: Color(
                                                  0xFFFF000000)),
                                          left: BorderSide(
                                              width: 1.0,
                                              color: Color(
                                                  0xFFFF000000)),
                                          right: BorderSide(
                                              width: 1.0,
                                              color: Color(
                                                  0xFFFF000000)),
                                          bottom: BorderSide(
                                              width: 1.0,
                                              color: Color(
                                                  0xFFFF000000)),
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
                                                      color: Colors
                                                          .black54,
                                                      fontWeight:
                                                      FontWeight
                                                          .w700),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          PersonalNote[index] ==
                                              null
                                              ? Container()
                                              : Row(
                                            children: <
                                                Widget>[
                                              Flexible(
                                                child: Text(
                                                  '- ${PersonalNote[index].toString()}',
                                                  style:
                                                  TextStyle(
                                                    color: Colors
                                                        .black38,
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                      : Container(),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Product Handling',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700,
                                      color: (hasilFood * 100).round() > 85.0
                                          ? Colors.green
                                          : (hasilFood * 100).round() < 70.0
                                          ? Colors.redAccent
                                          : Colors.orangeAccent,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Auditor : ${auditor[9]}',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ),
                        ],
                      ),
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: LinearPercentIndicator(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18.0),
                            width: size,
                            animation: true,
                            lineHeight: 30.0,
                            percent: hasilFood > 1.0
                                ? 1.0
                                : hasilFood,
                            center: Text(hasilFood >= 1.0
                                ? '100%'
                                : '${(hasilFood * 100).round().toString()}%'),
                            animationDuration: 1000,
                            linearStrokeCap: LinearStrokeCap.butt,
                            progressColor:
                            hasilFood * 100 > 85.0
                                ? Colors.green
                                : hasilFood * 100 < 70.0
                                ? Colors.redAccent
                                : Colors.orangeAccent,
                          ),
                        ),
                        Column(
                          children: List.generate(
                            widget.pertanyaanFoodCompletely.length,
                                (index) {
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Container(
                                      width: 270.0,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  widget.systemFoodCooked[
                                                  index],
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontWeight:
                                                      FontWeight.w700,
                                                      fontSize: 14.0),
                                                ),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  widget.criticalFoodCooked[
                                                  index] ==
                                                      'false'
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
                                                  '${index + 1}. ${widget.pertanyaanFoodCompletely[index]}',
                                                  style: TextStyle(
                                                      color:
                                                      Colors.black54,
                                                      fontSize: 14.0),
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
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              widget
                                                  .FoodCookedScore[index]
                                                  .toString(),
                                              style: TextStyle(
                                                  color: widget.FoodCookedScore[
                                                  index] ==
                                                      0
                                                      ? Colors.redAccent
                                                      : widget.FoodCookedScore[
                                                  index] ==
                                                      1
                                                      ? Colors
                                                      .orangeAccent
                                                      : Colors.green,
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
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
                                            imageFoodCooked[index] == null
                                              ? Container()
                                              : GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      imageFoodCookedSplit.clear();
                                                      imageFoodCookedSplit = [];
                                                      imageFoodCookedSplit = imageFoodCooked[index].split('###');
                                                      var bantuGambarFood = _gambarFoodCooked[index];
                                                      _gambarFoodCooked.removeAt(index);
                                                      _gambarFoodCooked.insert(index, !bantuGambarFood);
                                                      _catatanFoodCooked.removeAt(index);
                                                      _catatanFoodCooked.insert(index, false);
                                                    });
                                                  },
                                                  child: Icon(Icons.image, color: imageFoodCooked[index] == null ? Colors.grey : AbubaPallate.menuBluebird),
                                                ),
                                              FoodCookedNote[index] == null
                                                ? Container()
                                                : GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        var bantuCatatanFood = _catatanFoodCooked[index];
                                                        _catatanFoodCooked.removeAt(index);
                                                        _catatanFoodCooked.insert(index, !bantuCatatanFood);
                                                        _gambarFoodCooked.removeAt(index);
                                                        _gambarFoodCooked.insert(index, false);
                                                      });
                                                    },
                                                    child: Icon(Icons.note_add, color: AbubaPallate.menuBluebird),
                                                  ),
                                          ]
                                      ),
                                    ),
                                  ),
                                  _gambarFoodCooked[index]
                                      ? imageFoodCooked[index] == null
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
                                        crossAxisCount: 5,
                                        childAspectRatio: 1.0,
                                        mainAxisSpacing: 4.0,
                                        crossAxisSpacing: 4.0,
                                        shrinkWrap: true,
                                        children: List.generate(imageFoodCookedSplit.length, (index2) {
                                          return GridTile(
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(context,
                                                  MyCustomRoute(builder: (context) => DetailScreenFoodCooked(image: imageFoodCookedSplit[index2].toString(), indexx: index2))
                                                );
                                              },
                                              child: Hero(
                                                tag: 'imageHero${index2.toString()}',
                                                child: Image.network(
                                                  imageFoodCookedSplit[index2].toString(),
                                                  fit: BoxFit.cover,
                                                ),
                                                transitionOnUserGestures: true,
                                              )
                                            )
                                          );
                                        }).toList()
                                    ),
                                  )
                                      : Container(),
                                  _catatanFoodCooked[index]
                                      ? Padding(
                                    padding: EdgeInsets.only(
                                        left: 17.0,
                                        right: 17.0,
                                        bottom: 10.0),
                                    child: Container(
                                      decoration:
                                      const BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                              width: 1.0,
                                              color: Color(
                                                  0xFFFF000000)),
                                          left: BorderSide(
                                              width: 1.0,
                                              color: Color(
                                                  0xFFFF000000)),
                                          right: BorderSide(
                                              width: 1.0,
                                              color: Color(
                                                  0xFFFF000000)),
                                          bottom: BorderSide(
                                              width: 1.0,
                                              color: Color(
                                                  0xFFFF000000)),
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
                                                      color: Colors
                                                          .black54,
                                                      fontWeight:
                                                      FontWeight
                                                          .w700),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          FoodCookedNote[index] ==
                                              null
                                              ? Container()
                                              : Row(
                                            children: <
                                                Widget>[
                                              Flexible(
                                                child: Text(
                                                  '- ${FoodCookedNote[index].toString()}',
                                                  style:
                                                  TextStyle(
                                                    color: Colors
                                                        .black38,
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                      : Container(),
                                ],
                              );
                            },
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
      ),
    );
  }
}

class DetailScreenAreaLuar extends StatefulWidget {
  final String image;
  final int indexx;
  DetailScreenAreaLuar({this.image, this.indexx});

  @override
  _DetailScreenAreaLuarState createState() => _DetailScreenAreaLuarState();
}

class _DetailScreenAreaLuarState extends State<DetailScreenAreaLuar>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero${widget.indexx.toString()}',
            child: Image.network(
              widget.image.toString(),
            ),
            transitionOnUserGestures: true,
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class DetailScreenDinningArea extends StatefulWidget {
  @override
  _DetailScreenDinningAreaState createState() => _DetailScreenDinningAreaState();
  final String image;
  final int indexx;

  DetailScreenDinningArea({this.image, this.indexx});
}

class _DetailScreenDinningAreaState extends State<DetailScreenDinningArea>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero${widget.indexx.toString()}',
            child: Image.network(
              widget.image.toString(),
            ),
            transitionOnUserGestures: true,
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class DetailScreenService extends StatefulWidget {
  @override
  _DetailScreenServiceState createState() => _DetailScreenServiceState();
  final String image;
  final int indexx;

  DetailScreenService({this.image, this.indexx});
}

class _DetailScreenServiceState extends State<DetailScreenService>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero${widget.indexx.toString()}',
            child: Image.network(
              widget.image.toString(),
            ),
            transitionOnUserGestures: true,
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class DetailScreenCashier extends StatefulWidget {
  @override
  _DetailScreenCashierState createState() => _DetailScreenCashierState();
  final String image;
  final int indexx;

  DetailScreenCashier({this.image, this.indexx});
}

class _DetailScreenCashierState extends State<DetailScreenCashier>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero${widget.indexx.toString()}',
            child: Image.network(
              widget.image.toString(),
            ),
            transitionOnUserGestures: true,
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class DetailScreenCashierAccuracy extends StatefulWidget {
  @override
  _DetailScreenCashierAccuracyState createState() => _DetailScreenCashierAccuracyState();
  final String image;
  final int indexx;

  DetailScreenCashierAccuracy({this.image, this.indexx});
}

class _DetailScreenCashierAccuracyState extends State<DetailScreenCashierAccuracy>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero${widget.indexx.toString()}',
            child: Image.network(
              widget.image.toString(),
            ),
            transitionOnUserGestures: true,
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}


class DetailScreenBoh extends StatefulWidget {
  @override
  _DetailScreenBohState createState() => _DetailScreenBohState();
  final String image;
  final int indexx;

  DetailScreenBoh({this.image, this.indexx});
}

class _DetailScreenBohState extends State<DetailScreenBoh>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero${widget.indexx.toString()}',
            child: Image.network(
              widget.image.toString(),
            ),
            transitionOnUserGestures: true,
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class DetailScreenWarehouse extends StatefulWidget {
  @override
  _DetailScreenWarehouseState createState() => _DetailScreenWarehouseState();
  final String image;
  final int indexx;

  DetailScreenWarehouse({this.image, this.indexx});
}

class _DetailScreenWarehouseState extends State<DetailScreenWarehouse>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero${widget.indexx.toString()}',
            child: Image.network(
              widget.image.toString(),
            ),
            transitionOnUserGestures: true,
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class DetailScreenSocialBlock extends StatefulWidget {
  @override
  _DetailScreenSocialBlockState createState() => _DetailScreenSocialBlockState();
  final String image;
  final int indexx;

  DetailScreenSocialBlock({this.image, this.indexx});
}

class _DetailScreenSocialBlockState extends State<DetailScreenSocialBlock>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero${widget.indexx.toString()}',
            child: Image.network(
              widget.image.toString(),
            ),
            transitionOnUserGestures: true,
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class DetailScreenPersonal extends StatefulWidget {
  @override
  _DetailScreenPersonalState createState() => _DetailScreenPersonalState();
  final String image;
  final int indexx;

  DetailScreenPersonal({this.image, this.indexx});
}

class _DetailScreenPersonalState extends State<DetailScreenPersonal>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero${widget.indexx.toString()}',
            child: Image.network(
              widget.image.toString(),
            ),
            transitionOnUserGestures: true,
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class DetailScreenFoodCooked extends StatefulWidget {
  @override
  _DetailScreenFoodCookedState createState() => _DetailScreenFoodCookedState();
  final String image;
  final int indexx;

  DetailScreenFoodCooked({this.image, this.indexx});
}

class _DetailScreenFoodCookedState extends State<DetailScreenFoodCooked>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero${widget.indexx.toString()}',
            child: Image.network(
              widget.image.toString(),
            ),
            transitionOnUserGestures: true,
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class DialogBottomRekomendasi extends StatefulWidget {
  final ValueChanged<List<dynamic>> result;
  final int auditorIDFS;
  final int leadAuditorID;
  final int departmentUser;
  final int categoryFS;
  final String problemFS;
  final String departmentID;
  final String divisi;
  final String area;
  final int auditeeID;
  final int departmentAuditee;
  var indexx;
  var indexData;

  DialogBottomRekomendasi({this.result, this.auditeeID, this.departmentAuditee, this.area, this.auditorIDFS, this.categoryFS, this.departmentID, this.departmentUser, this.divisi, this.problemFS, this.indexx, this.indexData, this.leadAuditorID});
  @override
  _DialogBottomRekomendasiState createState() => _DialogBottomRekomendasiState();
}

class _DialogBottomRekomendasiState extends State<DialogBottomRekomendasi> {
  TextEditingController controller = TextEditingController();
  bool isProses = false;
  var maxidCorrectiveAction;
  var indexCorrectiveAction;

  @override
  void initState() {
    Firestore.instance.collection('dumper_correctiveAction').snapshots().listen((data) {
      setState(() {
        maxidCorrectiveAction = data.documents[0].data['maxid_correctiveAction'] + 1;
        indexCorrectiveAction = data.documents[0].documentID;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF737373),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: const Radius.circular(20.0),
            topLeft: const Radius.circular(20.0),
          ),
        ),
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, top: 20.0, left: 12.0, right: 12.0),
        child: isProses
          ? Container(
              height: 30.0,
              alignment: Alignment.center,
              child: SizedBox(
                width: 25.0,
                height: 25.0,
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                ),
              ),
            )
          : ListTile(
              title: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Rekomendasi',
                    hintStyle: TextStyle(fontSize: 14.0),
                  ),
                  // controller: textEditingControllers[index],
                  controller: controller,
                  maxLength: 250,
                  textCapitalization: TextCapitalization.sentences,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0
                  ),
                ),
              ),
              trailing: Container(
                width: MediaQuery.of(context).size.width * 0.15,
                child: OutlineButton(
                  child: Text(
                    'SAVE',
                    style: TextStyle(fontSize: 13.0, color: AbubaPallate.greenabuba),
                  ),
                  borderSide: BorderSide(color: AbubaPallate.greenabuba, width: 1.0),
                  highlightedBorderColor: AbubaPallate.greenabuba,
                  onPressed: () {
                    setState(() {
                      isProses = true;
                    });

                    var carNo = [];
                    var rekomendasi = [];

                    // save corrective action
                    DocumentReference docReference = Firestore.instance.collection('correctiveAction').document();

                    docReference.setData({
                      'userCreated': widget.leadAuditorID,
                      'dateCreated': DateTime.now(),
                      'departmentCreated': widget.departmentUser,
                      'carNo': maxidCorrectiveAction,
                      'category': int.tryParse(widget.categoryFS.toString()),
                      'problem': widget.problemFS,
                      'when': DateTime.now(),
                      'departmentWhere': widget.departmentID,
                      'divisiWhere': widget.divisi,
                      'areaWhere': widget.area,
                      'howSevere': 'High',
                      'remarksProblem': null,
                      'userDituju': int.tryParse(widget.auditeeID.toString()),
                      'departmentDituju': widget.departmentAuditee,
                      'status': 'OPEN',
                      'rekomendasiFS': controller.text
                    }).then((doc) async {
                      widget.result(['OPEN']);
                      Firestore.instance.collection('audit_internal').document(widget.indexx).snapshots().listen((data) {
                        setState(() {
                          carNo = List<dynamic>.from(data.data['FSCarNo']);
                          rekomendasi = List<dynamic>.from(data.data['FSRekomendasi']);
                        });
                      });

                      await new Future.delayed(Duration(
                        seconds: 3
                      ));

                      setState(() {
                        carNo.removeAt(widget.indexData);
                        carNo.insert(widget.indexData, maxidCorrectiveAction);

                        rekomendasi.removeAt(widget.indexData);
                        rekomendasi.insert(widget.indexData, controller.text);
                      });

                      DocumentReference documentReference2 = Firestore.instance.collection('audit_internal').document(widget.indexx);
                      documentReference2.updateData({
                        'FSRekomendasi': rekomendasi,
                        'FSCarNo': carNo,
                      }).then((doc3) {
                        DocumentReference documentReference = Firestore.instance.collection('dumper_correctiveAction').document(indexCorrectiveAction);

                        documentReference.updateData({
                          'maxid_correctiveAction':maxidCorrectiveAction
                        }).then((doc2) {
                          print('success');
                          setState(() {
                            isProses = false;
                            controller.clear();
                          });
                          Navigator.pop(context);
                        }).catchError((error2) {
                          print(error2);
                        });
                      }).catchError((error) {
                        print(error);
                      });
                    }).catchError((error) {
                      print(error);
                    });
                  },
                )
              ),
            )
      ),
    );
  }
}