import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailReport extends StatefulWidget {
  @override
  _DetailReportState createState() => _DetailReportState();
  final String counter;
  final int idUser;
  final String namaUser;
  final String idCollection;
  final String tanggal;
  final String waktuStart;
  final String waktuEnd;
  final String outlet;

  final List<dynamic> scoreParkingLobby;
  final List<dynamic> scoreDinningAreaLobby;
  final List<dynamic> scoreRestroomLobby;
  final List<dynamic> scoreGrillAreaDinning;
  final List<dynamic> scoreBarDinning;
  final List<dynamic> scoreProductionDinning;
  final List<dynamic> scoreWarehouseDinning;
  final List<dynamic> scoreMenuBoardPelayanan;
  final List<dynamic> scoreServiceAreaPelayanan;
  final List<dynamic> scoreGroomingPelayanan;
  final List<dynamic> scoreKeamananPelayanan;
  final List<dynamic> scoreKesiapanBisnis;
  final List<dynamic> scoreSteakCook;
  final List<dynamic> scoreBatterMixCook;
  final List<dynamic> scoreMixVegetablesCook;
  final List<dynamic> scorePotatoCook;
  final List<dynamic> scoreGrillerCook;
  final List<dynamic> scoreKeamananMakananCook;
  final List<dynamic> scoreAreaCook;
  final List<dynamic> scoreKitchenCook;
  final List<dynamic> scoreDishwasherWash;
  final List<dynamic> scoreChillerWash;
  final List<dynamic> scoreKeamananWash;
  final List<dynamic> scoreAlatWash;

  final List<dynamic> pertanyaanParkingLobby;
  final List<dynamic> pertanyaanDinningAreaLobby;
  final List<dynamic> pertanyaanRestroomLobby;
  final List<dynamic> pertanyaanGrillAreaDinning;
  final List<dynamic> pertanyaanBarDinning;
  final List<dynamic> pertanyaanProductionDinning;
  final List<dynamic> pertanyaanWarehouseDinning;
  final List<dynamic> pertanyaanMenuBoardPelayanan;
  final List<dynamic> pertanyaanServiceAreaPelayanan;
  final List<dynamic> pertanyaanGroomingPelayanan;
  final List<dynamic> pertanyaanKeamananPelayanan;
  final List<dynamic> pertanyaanKesiapanBisnis;
  final List<dynamic> pertanyaanSteakCook;
  final List<dynamic> pertanyaanBatterMixCook;
  final List<dynamic> pertanyaanMixVegetablesCook;
  final List<dynamic> pertanyaanPotatoCook;
  final List<dynamic> pertanyaanGrillerCook;
  final List<dynamic> pertanyaanKeamananMakananCook;
  final List<dynamic> pertanyaanAreaCook;
  final List<dynamic> pertanyaanKitchenCook;
  final List<dynamic> pertanyaanDishwasherWash;
  final List<dynamic> pertanyaanChillerWash;
  final List<dynamic> pertanyaanKeamananWash;
  final List<dynamic> pertanyaanAlatWash;
  DetailReport({
    this.outlet,
    this.counter,
    this.pertanyaanParkingLobby,
    this.pertanyaanDinningAreaLobby,
    this.pertanyaanRestroomLobby,
    this.pertanyaanGrillAreaDinning,
    this.pertanyaanBarDinning,
    this.pertanyaanProductionDinning,
    this.pertanyaanWarehouseDinning,
    this.pertanyaanMenuBoardPelayanan,
    this.pertanyaanServiceAreaPelayanan,
    this.pertanyaanGroomingPelayanan,
    this.pertanyaanKeamananPelayanan,
    this.pertanyaanKesiapanBisnis,
    this.pertanyaanSteakCook,
    this.pertanyaanBatterMixCook,
    this.pertanyaanMixVegetablesCook,
    this.pertanyaanPotatoCook,
    this.pertanyaanGrillerCook,
    this.pertanyaanKeamananMakananCook,
    this.pertanyaanAreaCook,
    this.pertanyaanKitchenCook,
    this.pertanyaanDishwasherWash,
    this.pertanyaanChillerWash,
    this.pertanyaanKeamananWash,
    this.pertanyaanAlatWash,
    this.scoreParkingLobby,
    this.scoreDinningAreaLobby,
    this.scoreRestroomLobby,
    this.scoreGrillAreaDinning,
    this.scoreBarDinning,
    this.scoreProductionDinning,
    this.scoreWarehouseDinning,
    this.scoreMenuBoardPelayanan,
    this.scoreServiceAreaPelayanan,
    this.scoreGroomingPelayanan,
    this.scoreKeamananPelayanan,
    this.scoreKesiapanBisnis,
    this.scoreSteakCook,
    this.scoreBatterMixCook,
    this.scoreMixVegetablesCook,
    this.scorePotatoCook,
    this.scoreGrillerCook,
    this.scoreKeamananMakananCook,
    this.scoreAreaCook,
    this.scoreKitchenCook,
    this.scoreDishwasherWash,
    this.scoreChillerWash,
    this.scoreKeamananWash,
    this.scoreAlatWash,
    this.tanggal,
    this.waktuStart,
    this.waktuEnd,
    this.idUser,
    this.namaUser,
    this.idCollection,
  });
}

class _DetailReportState extends State<DetailReport>
    with TickerProviderStateMixin {
  AnimationController animationController;
  final GlobalKey<AnimatedCircularChartState> _chartKey =
  new GlobalKey<AnimatedCircularChartState>();

  String userCreated;

  bool _gambarParkingLobby = false;
  bool _gambarDinningAreaLobby = false;
  bool _gambarRestroomLobby = false;
  bool _gambarGrillAreaDinning = false;
  bool _gambarBarDinning = false;
  bool _gambarProductionDinning = false;
  bool _gambarWarehouseDinning = false;
  bool _gambarMenuBoardPelayanan = false;
  bool _gambarServiceAreaPelayanan = false;
  bool _gambarGroomingPelayanan = false;
  bool _gambarKeamananPelayanan = false;
  bool _gambarKesiapanBisnis = false;
  bool _gambarSteakCook = false;
  bool _gambarBatterMixCook = false;
  bool _gambarMixVegetablesCook = false;
  bool _gambarPotatoCook = false;
  bool _gambarGrillerCook = false;
  bool _gambarKeamananMakananCook = false;
  bool _gambarAreaCook = false;
  bool _gambarKitchenCook = false;
  bool _gambarDishwasherWash = false;
  bool _gambarChillerWash = false;
  bool _gambarKeamananWash = false;
  bool _gambarAlatWash = false;

  String imageParkingLobby;
  String imageDinningAreaLobby;
  String imageRestroomLobby;
  String imageGrillAreaDinning;
  String imageBarDinning;
  String imageProductionDinning;
  String imageWarehouseDinning;
  String imageMenuBoardPelayanan;
  String imageServiceAreaPelayanan;
  String imageGroomingPelayanan;
  String imageKeamananPelayanan;
  String imageKesiapanBisnis;
  String imageSteakCook;
  String imageBatterMixCook;
  String imageMixVegetablesCook;
  String imagePotatoCook;
  String imageGrillerCook;
  String imageKeamananMakananCook;
  String imageAreaCook;
  String imageKitchenCook;
  String imageDishwasherWash;
  String imageChillerWash;
  String imageKeamananWash;
  String imageAlatWash;

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

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.scoreParkingLobby.length; i++) {
      if (widget.scoreParkingLobby[i] == 0) {
        jmlNoParkingLobby++;
      } else if (widget.scoreParkingLobby[i] == 2) {
        jmlYesParkingLobby++;
      }
    }

    for (var i = 0; i < widget.scoreDinningAreaLobby.length; i++) {
      if (widget.scoreDinningAreaLobby[i] == 0) {
        jmlNoDinningAreaLobby++;
      } else if (widget.scoreDinningAreaLobby[i] == 2) {
        jmlYesDinningAreaLobby++;
      }
    }

    for (var i = 0; i < widget.scoreRestroomLobby.length; i++) {
      if (widget.scoreRestroomLobby[i] == 0) {
        jmlNoRestroomLobby++;
      } else if (widget.scoreRestroomLobby[i] == 2) {
        jmlYesRestroomLobby++;
      }
    }

    for (var i = 0; i < widget.scoreGrillAreaDinning.length; i++) {
      if (widget.scoreGrillAreaDinning[i] == 0) {
        jmlNoGrillAreaDinning++;
      } else if (widget.scoreGrillAreaDinning[i] == 2) {
        jmlYesGrillAreaDinning++;
      }
    }

    for (var i = 0; i < widget.scoreBarDinning.length; i++) {
      if (widget.scoreBarDinning[i] == 0) {
        jmlNoBarDinning++;
      } else if (widget.scoreBarDinning[i] == 2) {
        jmlYesBarDinning++;
      }
    }

    for (var i = 0; i < widget.scoreProductionDinning.length; i++) {
      if (widget.scoreProductionDinning[i] == 0) {
        jmlNoProductionDinning++;
      } else if (widget.scoreProductionDinning[i] == 2) {
        jmlYesProductionDinning++;
      }
    }

    for (var i = 0; i < widget.scoreWarehouseDinning.length; i++) {
      if (widget.scoreWarehouseDinning[i] == 0) {
        jmlNoWarehouseDinning++;
      } else if (widget.scoreWarehouseDinning[i] == 2) {
        jmlYesWarehouseDinning++;
      }
    }

    for (var i = 0; i < widget.scoreMenuBoardPelayanan.length; i++) {
      if (widget.scoreMenuBoardPelayanan[i] == 0) {
        jmlNoMenuBoardPelayanan++;
      } else if (widget.scoreMenuBoardPelayanan[i] == 2) {
        jmlYesMenuBoardPelayanan++;
      }
    }

    for (var i = 0; i < widget.scoreServiceAreaPelayanan.length; i++) {
      if (widget.scoreServiceAreaPelayanan[i] == 0) {
        jmlNoServiceAreaPelayanan++;
      } else if (widget.scoreServiceAreaPelayanan[i] == 2) {
        jmlYesServiceAreaPelayanan++;
      }
    }

    for (var i = 0; i < widget.scoreGroomingPelayanan.length; i++) {
      if (widget.scoreGroomingPelayanan[i] == 0) {
        jmlNoGroomingPelayanan++;
      } else if (widget.scoreGroomingPelayanan[i] == 2) {
        jmlYesGroomingPelayanan++;
      }
    }

    for (var i = 0; i < widget.scoreKeamananPelayanan.length; i++) {
      if (widget.scoreKeamananPelayanan[i] == 0) {
        jmlNoKeamananPelayanan++;
      } else if (widget.scoreKeamananPelayanan[i] == 2) {
        jmlYesKeamananPelayanan++;
      }
    }

    for (var i = 0; i < widget.scoreKesiapanBisnis.length; i++) {
      if (widget.scoreKesiapanBisnis[i] == 0) {
        jmlNoKesiapanBisnis++;
      } else if (widget.scoreKesiapanBisnis[i] == 2) {
        jmlYesKesiapanBisnis++;
      }
    }

    for (var i = 0; i < widget.scoreSteakCook.length; i++) {
      if (widget.scoreSteakCook[i] == 0) {
        jmlNoSteakCook++;
      } else if (widget.scoreSteakCook[i] == 2) {
        jmlYesSteakCook++;
      }
    }

    for (var i = 0; i < widget.scoreBatterMixCook.length; i++) {
      if (widget.scoreBatterMixCook[i] == 0) {
        jmlNoBatterMixCook++;
      } else if (widget.scoreBatterMixCook[i] == 2) {
        jmlYesBatterMixCook++;
      }
    }

    for (var i = 0; i < widget.scoreMixVegetablesCook.length; i++) {
      if (widget.scoreMixVegetablesCook[i] == 0) {
        jmlNoMixVegetablesCook++;
      } else if (widget.scoreMixVegetablesCook[i] == 2) {
        jmlYesMixVegetablesCook++;
      }
    }

    for (var i = 0; i < widget.scorePotatoCook.length; i++) {
      if (widget.scorePotatoCook[i] == 0) {
        jmlNoPotatoCook++;
      } else if (widget.scorePotatoCook[i] == 2) {
        jmlYesPotatoCook++;
      }
    }

    for (var i = 0; i < widget.scoreGrillerCook.length; i++) {
      if (widget.scoreGrillerCook[i] == 0) {
        jmlNoGrillerCook++;
      } else if (widget.scoreGrillerCook[i] == 2) {
        jmlYesGrillerCook++;
      }
    }

    for (var i = 0; i < widget.scoreKeamananMakananCook.length; i++) {
      if (widget.scoreKeamananMakananCook[i] == 0) {
        jmlNoKeamananMakananCook++;
      } else if (widget.scoreKeamananMakananCook[i] == 2) {
        jmlYesKeamananMakananCook++;
      }
    }

    for (var i = 0; i < widget.scoreAreaCook.length; i++) {
      if (widget.scoreAreaCook[i] == 0) {
        jmlNoAreaCook++;
      } else if (widget.scoreAreaCook[i] == 2) {
        jmlYesAreaCook++;
      }
    }

    for (var i = 0; i < widget.scoreKitchenCook.length; i++) {
      if (widget.scoreKitchenCook[i] == 0) {
        jmlNoKitchenCook++;
      }else if (widget.scoreKitchenCook[i] == 2) {
        jmlYesKitchenCook++;
      }
    }

    for (var i = 0; i < widget.scoreDishwasherWash.length; i++) {
      if (widget.scoreDishwasherWash[i] == 0) {
        jmlNoDishwasherWash++;
      } else if (widget.scoreDishwasherWash[i] == 2) {
        jmlYesDishwasherWash++;
      }
    }

    for (var i = 0; i < widget.scoreChillerWash.length; i++) {
      if (widget.scoreChillerWash[i] == 0) {
        jmlNoChillerWash++;
      } else if (widget.scoreChillerWash[i] == 2) {
        jmlYesChillerWash++;
      }
    }

    for (var i = 0; i < widget.scoreKeamananWash.length; i++) {
      if (widget.scoreKeamananWash[i] == 0) {
        jmlNoKeamananWash++;
      } else if (widget.scoreKeamananWash[i] == 2) {
        jmlYesKeamananWash++;
      }
    }

    for (var i = 0; i < widget.scoreAlatWash.length; i++) {
      if (widget.scoreAlatWash[i] == 0) {
        jmlNoAlatWash++;
      } else if (widget.scoreAlatWash[i] == 2) {
        jmlYesAlatWash++;
      }
    }

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

    jmlPertanyaan = widget.pertanyaanParkingLobby.length + widget.pertanyaanDinningAreaLobby.length + widget.pertanyaanRestroomLobby.length + widget.pertanyaanGrillAreaDinning.length + widget.pertanyaanBarDinning.length + widget.pertanyaanProductionDinning.length + widget.pertanyaanWarehouseDinning.length + widget.pertanyaanMenuBoardPelayanan.length + widget.pertanyaanServiceAreaPelayanan.length + widget.pertanyaanGroomingPelayanan.length + widget.pertanyaanKeamananPelayanan.length + widget.pertanyaanKesiapanBisnis.length + widget.pertanyaanSteakCook.length + widget.pertanyaanBatterMixCook.length + widget.pertanyaanMixVegetablesCook.length + widget.pertanyaanPotatoCook.length + widget.pertanyaanGrillerCook.length + widget.pertanyaanKeamananMakananCook.length + widget.pertanyaanAreaCook.length + widget.pertanyaanKitchenCook.length + widget.pertanyaanDishwasherWash.length + widget.pertanyaanChillerWash.length + widget.pertanyaanKeamananWash.length + widget.pertanyaanAlatWash.length;

    hasilKedua = hasilPertama / jmlPertanyaan * 100;

    Color colorGrafik = Colors.green;

    setState(() {
      Firestore.instance
          .collection('dailychecklist')
          .document(widget.idCollection)
          .snapshots()
          .listen((data) {

        imageParkingLobby = data.data['parkingLot_image'];
        imageDinningAreaLobby = data.data['dinningArea_image'];
        imageRestroomLobby = data.data['restroom_image'];
        imageGrillAreaDinning = data.data['grillArea_image'];
        imageBarDinning = data.data['bar_image'];
        imageProductionDinning = data.data['production_image'];
        imageWarehouseDinning = data.data['warehouse_image'];
        imageMenuBoardPelayanan = data.data['menuBoard_image'];
        imageServiceAreaPelayanan = data.data['serviceArea_image'];
        imageGroomingPelayanan = data.data['grooming_image'];
        imageKeamananPelayanan = data.data['keamananPelayanan_image'];
        imageKesiapanBisnis = data.data['kesiapanBisnis_image'];
        imageSteakCook = data.data['steak_image'];
        imageBatterMixCook = data.data['batterMix_image'];
        imageMixVegetablesCook = data.data['mixVegetables_image'];
        imagePotatoCook = data.data['potatoWedges_image'];
        imageGrillerCook = data.data['griller_image'];
        imageKeamananMakananCook = data.data['keamananCook_image'];
        imageAreaCook = data.data['cookArea_image'];
        imageKitchenCook = data.data['kitchenEquipment_image'];
        imageDishwasherWash = data.data['dishwasherArea_image'];
        imageChillerWash = data.data['chiller_image'];
        imageKeamananWash = data.data['keamananWash_image'];
        imageAlatWash = data.data['alatKeamanan_image'];

        Firestore.instance
            .collection('user')
            .where('id', isEqualTo: data.data['userCreated'])
            .snapshots()
            .listen((data2) {
          userCreated = data2.documents[0].data['nama'];
        });
      });
    });

    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(
        from:
        animationController.value == 0.0 ? 1.0 : animationController.value);
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

    hasilKedua > 85.0
        ? colorGrafik = Colors.green
        : hasilKedua < 70.0
        ? colorGrafik = Colors.redAccent
        : colorGrafik = Colors.orangeAccent;

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
                    'Detail Report',
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
                          top: 10.0,
                          right: 15.0,
                          left: 15.0,
                          bottom: 10.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  '${widget.outlet.toString()}',
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
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Center(
                        child: new AnimatedCircularChart(
                          key: _chartKey,
                          size: Size(size / 4, size / 3),
                          initialChartData: <CircularStackEntry>[
                            new CircularStackEntry(
                              <CircularSegmentEntry>[
                                new CircularSegmentEntry(
                                  hasilKedua,
                                  colorGrafik,
                                  rankKey: 'completed',
                                ),
                                new CircularSegmentEntry(
                                  100.0 - hasilKedua,
                                  Colors.blueGrey[600],
                                  rankKey: 'remaining',
                                ),
                              ],
                              rankKey: 'progress',
                            ),
                          ],
                          chartType: CircularChartType.Radial,
                          percentageValues: true,
                          holeLabel: hasilKedua >= 100.0
                              ? '100%'
                              : '${hasilKedua.toString().substring(0, 2)}%',
                          labelStyle: new TextStyle(
                            color: Colors.blueGrey[600],
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                          ),
                        ),
                      ),
                    ),
                    ExpansionTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Lobby / Restroom Area',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                color:
                                hasilLobby == 0
                                    ? Colors.green
                                    : hasilLobby >= 5
                                    ? Colors.redAccent
                                    : Colors.orangeAccent,
                              ),
                            ),
                          ),
                        ],
                      ),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Parking Lot',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color:
                                    /*widget.hasilAreaLuar * 100 > 85.0
                                      ? Colors.green
                                      : widget.hasilAreaLuar * 100 < 70.0
                                      ? Colors.redAccent
                                      : Colors.orangeAccent,*/
                                    Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: List.generate(
                            widget.pertanyaanParkingLobby.length,
                                (index) {
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Container(
                                      width: 270.0,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  '${index + 1}. ${widget.pertanyaanParkingLobby[index]}',
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
                                              widget.scoreParkingLobby[
                                              index] ==
                                                  0
                                                  ? 'NO'
                                                  : 'YES',
                                              style: TextStyle(
                                                  color:
                                                  widget.scoreParkingLobby[
                                                  index] ==
                                                      0
                                                      ? Colors
                                                      .redAccent
                                                      : Colors.black54,
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _gambarParkingLobby = !_gambarParkingLobby;
                                      });
                                    },
                                    child: Icon(Icons.image, color: imageParkingLobby == null ? Colors.grey : AbubaPallate.menuBluebird),
                                  ),
                                ]
                            )
                        ),
                        _gambarParkingLobby
                            ? imageParkingLobby == null
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
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MyCustomRoute(builder: (context) => DetailScreenParkingLobby(image: imageParkingLobby)));
                                      },
                                      child: Image.network(
                                        imageParkingLobby.toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                ),
                              ]
                          ),
                        )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 15.0, left: 15.0, bottom: 10.0),
                          child: Divider(
                            height: 1.0,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Dinning Area',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color:
                                    /*widget.hasilAreaLuar * 100 > 85.0
                                      ? Colors.green
                                      : widget.hasilAreaLuar * 100 < 70.0
                                      ? Colors.redAccent
                                      : Colors.orangeAccent,*/
                                    Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: List.generate(
                            widget.pertanyaanDinningAreaLobby.length,
                                (indexdua) {
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Container(
                                      width: 270.0,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  '${indexdua + 1}. ${widget.pertanyaanDinningAreaLobby[indexdua]}',
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
                                              widget.scoreDinningAreaLobby[
                                              indexdua] ==
                                                  0
                                                  ? 'NO'
                                                  : 'YES',
                                              style: TextStyle(
                                                  color: widget.scoreDinningAreaLobby[
                                                  indexdua] ==
                                                      0
                                                      ? Colors.redAccent
                                                      : Colors.black54,
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _gambarDinningAreaLobby = !_gambarDinningAreaLobby;
                                      });
                                    },
                                    child: Icon(Icons.image, color: imageDinningAreaLobby == null ? Colors.grey : AbubaPallate.menuBluebird),
                                  ),
                                ]
                            )
                        ),
                        _gambarDinningAreaLobby
                            ? imageDinningAreaLobby == null
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
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MyCustomRoute(builder: (context) => DetailScreenDinningAreaLobby(image: imageDinningAreaLobby)));
                                      },
                                      child: Image.network(
                                        imageDinningAreaLobby.toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                ),
                              ]
                          ),
                        )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 15.0, left: 15.0, bottom: 10.0),
                          child: Divider(
                            height: 1.0,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Restroom / Wastafel Area',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color:
                                    /*widget.hasilAreaLuar * 100 > 85.0
                                      ? Colors.green
                                      : widget.hasilAreaLuar * 100 < 70.0
                                      ? Colors.redAccent
                                      : Colors.orangeAccent,*/
                                    Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: List.generate(
                            widget.pertanyaanRestroomLobby.length,
                                (indextiga) {
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Container(
                                      width: 270.0,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  '${indextiga + 1}. ${widget.pertanyaanRestroomLobby[indextiga]}',
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
                                              widget.scoreRestroomLobby[indextiga] == 0
                                                  ? 'NO'
                                                  : 'YES',
                                              style: TextStyle(
                                                  color:
                                                  widget.scoreRestroomLobby[indextiga] == 0
                                                      ? Colors
                                                      .redAccent
                                                      : Colors.black54,
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _gambarRestroomLobby = !_gambarRestroomLobby;
                                      });
                                    },
                                    child: Icon(Icons.image, color: imageRestroomLobby == null ? Colors.grey : AbubaPallate.menuBluebird),
                                  ),
                                ]
                            )
                        ),
                        _gambarRestroomLobby
                            ? imageRestroomLobby == null
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
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MyCustomRoute(builder: (context) => DetailScreenRestroomLobby(image: imageRestroomLobby)));
                                      },
                                      child: Image.network(
                                        imageRestroomLobby.toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                ),
                              ]
                          ),
                        )
                            : Container(),
                      ],
                    ),

                    ExpansionTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Dinning Room / Grill / Bar',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                color:
                                hasilDinning == 0
                                    ? Colors.green
                                    : hasilDinning >= 5
                                    ? Colors.redAccent
                                    : Colors.orangeAccent,
                              ),
                            ),
                          ),
                        ],
                      ),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Grill Area',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color:
                                    /*widget.hasilAreaLuar * 100 > 85.0
                                      ? Colors.green
                                      : widget.hasilAreaLuar * 100 < 70.0
                                      ? Colors.redAccent
                                      : Colors.orangeAccent,*/
                                    Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: List.generate(
                            widget.pertanyaanGrillAreaDinning.length,
                                (index) {
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Container(
                                      width: 270.0,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  '${index + 1}. ${widget.pertanyaanGrillAreaDinning[index]}',
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
                                              widget.scoreGrillAreaDinning[
                                              index] ==
                                                  0
                                                  ? 'NO'
                                                  : 'YES',
                                              style: TextStyle(
                                                  color:
                                                  widget.scoreGrillAreaDinning[
                                                  index] ==
                                                      0
                                                      ? Colors
                                                      .redAccent
                                                      : Colors.black54,
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _gambarGrillAreaDinning = !_gambarGrillAreaDinning;
                                      });
                                    },
                                    child: Icon(Icons.image, color: imageGrillAreaDinning == null ? Colors.grey : AbubaPallate.menuBluebird),
                                  ),
                                ]
                            )
                        ),
                        _gambarGrillAreaDinning
                            ? imageGrillAreaDinning == null
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
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MyCustomRoute(builder: (context) => DetailScreenGrillAreaDinning(image: imageGrillAreaDinning)));
                                      },
                                      child: Image.network(
                                        imageGrillAreaDinning.toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                ),
                              ]
                          ),
                        )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 15.0, left: 15.0, bottom: 10.0),
                          child: Divider(
                            height: 1.0,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Bar',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color:
                                    /*widget.hasilAreaLuar * 100 > 85.0
                                      ? Colors.green
                                      : widget.hasilAreaLuar * 100 < 70.0
                                      ? Colors.redAccent
                                      : Colors.orangeAccent,*/
                                    Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: List.generate(
                            widget.pertanyaanBarDinning.length,
                                (indexdua) {
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Container(
                                      width: 270.0,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  '${indexdua + 1}. ${widget.pertanyaanBarDinning[indexdua]}',
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
                                              widget.scoreBarDinning[
                                              indexdua] ==
                                                  0
                                                  ? 'NO'
                                                  : 'YES',
                                              style: TextStyle(
                                                  color: widget.scoreBarDinning[
                                                  indexdua] ==
                                                      0
                                                      ? Colors.redAccent
                                                      : Colors.black54,
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _gambarBarDinning = !_gambarBarDinning;
                                      });
                                    },
                                    child: Icon(Icons.image, color: imageBarDinning == null ? Colors.grey : AbubaPallate.menuBluebird),
                                  ),
                                ]
                            )
                        ),
                        _gambarBarDinning
                            ? imageBarDinning == null
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
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MyCustomRoute(builder: (context) => DetailScreenBarDinning(image: imageBarDinning)));
                                      },
                                      child: Image.network(
                                        imageBarDinning.toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                ),
                              ]
                          ),
                        )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 15.0, left: 15.0, bottom: 10.0),
                          child: Divider(
                            height: 1.0,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Production & Pantry Area',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color:
                                    /*widget.hasilAreaLuar * 100 > 85.0
                                      ? Colors.green
                                      : widget.hasilAreaLuar * 100 < 70.0
                                      ? Colors.redAccent
                                      : Colors.orangeAccent,*/
                                    Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: List.generate(
                            widget.pertanyaanProductionDinning.length,
                                (indextiga) {
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Container(
                                      width: 270.0,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  '${indextiga + 1}. ${widget.pertanyaanProductionDinning[indextiga]}',
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
                                              widget.scoreProductionDinning[indextiga] == 0
                                                  ? 'NO'
                                                  : 'YES',
                                              style: TextStyle(
                                                  color:
                                                  widget.scoreProductionDinning[indextiga] == 0
                                                      ? Colors
                                                      .redAccent
                                                      : Colors.black54,
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _gambarProductionDinning = !_gambarProductionDinning;
                                      });
                                    },
                                    child: Icon(Icons.image, color: imageProductionDinning == null ? Colors.grey : AbubaPallate.menuBluebird),
                                  ),
                                ]
                            )
                        ),
                        _gambarProductionDinning
                            ? imageProductionDinning == null
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
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MyCustomRoute(builder: (context) => DetailScreenProductionDinning(image: imageProductionDinning)));
                                      },
                                      child: Image.network(
                                        imageProductionDinning.toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                ),
                              ]
                          ),
                        )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 15.0, left: 15.0, bottom: 10.0),
                          child: Divider(
                            height: 1.0,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Warehouse',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color:
                                    /*widget.hasilAreaLuar * 100 > 85.0
                                      ? Colors.green
                                      : widget.hasilAreaLuar * 100 < 70.0
                                      ? Colors.redAccent
                                      : Colors.orangeAccent,*/
                                    Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: List.generate(
                            widget.pertanyaanWarehouseDinning.length,
                                (indexempat) {
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Container(
                                      width: 270.0,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  '${indexempat + 1}. ${widget.pertanyaanWarehouseDinning[indexempat]}',
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
                                              widget.scoreWarehouseDinning[indexempat] == 0
                                                  ? 'NO'
                                                  : 'YES',
                                              style: TextStyle(
                                                  color:
                                                  widget.scoreWarehouseDinning[indexempat] == 0
                                                      ? Colors
                                                      .redAccent
                                                      : Colors.black54,
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _gambarWarehouseDinning = !_gambarWarehouseDinning;
                                      });
                                    },
                                    child: Icon(Icons.image, color: imageWarehouseDinning == null ? Colors.grey : AbubaPallate.menuBluebird),
                                  ),
                                ]
                            )
                        ),
                        _gambarWarehouseDinning
                            ? imageWarehouseDinning == null
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
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MyCustomRoute(builder: (context) => DetailScreenWarehouseDinning(image: imageWarehouseDinning)));
                                      },
                                      child: Image.network(
                                        imageWarehouseDinning.toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                ),
                              ]
                          ),
                        )
                            : Container(),
                      ],
                    ),

                    ExpansionTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Area Service / Pelayanan / Cashier',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                color:
                                hasilPelayanan == 0
                                    ? Colors.green
                                    : hasilPelayanan >= 5
                                    ? Colors.redAccent
                                    : Colors.orangeAccent,
                              ),
                            ),
                          ),
                        ],
                      ),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Menu Board',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color:
                                    /*widget.hasilAreaLuar * 100 > 85.0
                                      ? Colors.green
                                      : widget.hasilAreaLuar * 100 < 70.0
                                      ? Colors.redAccent
                                      : Colors.orangeAccent,*/
                                    Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: List.generate(
                            widget.pertanyaanMenuBoardPelayanan.length,
                                (index) {
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Container(
                                      width: 270.0,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  '${index + 1}. ${widget.pertanyaanMenuBoardPelayanan[index]}',
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
                                              widget.scoreMenuBoardPelayanan[
                                              index] ==
                                                  0
                                                  ? 'NO'
                                                  : 'YES',
                                              style: TextStyle(
                                                  color:
                                                  widget.scoreMenuBoardPelayanan[
                                                  index] ==
                                                      0
                                                      ? Colors
                                                      .redAccent
                                                      : Colors.black54,
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _gambarMenuBoardPelayanan = !_gambarMenuBoardPelayanan;
                                      });
                                    },
                                    child: Icon(Icons.image, color: imageMenuBoardPelayanan == null ? Colors.grey : AbubaPallate.menuBluebird),
                                  ),
                                ]
                            )
                        ),
                        _gambarMenuBoardPelayanan
                            ? imageMenuBoardPelayanan == null
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
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MyCustomRoute(builder: (context) => DetailScreenMenuBoardPelayanan(image: imageMenuBoardPelayanan)));
                                      },
                                      child: Image.network(
                                        imageMenuBoardPelayanan.toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                ),
                              ]
                          ),
                        )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 15.0, left: 15.0, bottom: 10.0),
                          child: Divider(
                            height: 1.0,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Service Area',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color:
                                    /*widget.hasilAreaLuar * 100 > 85.0
                                      ? Colors.green
                                      : widget.hasilAreaLuar * 100 < 70.0
                                      ? Colors.redAccent
                                      : Colors.orangeAccent,*/
                                    Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: List.generate(
                            widget.pertanyaanServiceAreaPelayanan.length,
                                (indexdua) {
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Container(
                                      width: 270.0,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  '${indexdua + 1}. ${widget.pertanyaanServiceAreaPelayanan[indexdua]}',
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
                                              widget.scoreServiceAreaPelayanan[
                                              indexdua] ==
                                                  0
                                                  ? 'NO'
                                                  : 'YES',
                                              style: TextStyle(
                                                  color: widget.scoreServiceAreaPelayanan[
                                                  indexdua] ==
                                                      0
                                                      ? Colors.redAccent
                                                      : Colors.black54,
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _gambarServiceAreaPelayanan = !_gambarServiceAreaPelayanan;
                                      });
                                    },
                                    child: Icon(Icons.image, color: imageServiceAreaPelayanan == null ? Colors.grey : AbubaPallate.menuBluebird),
                                  ),
                                ]
                            )
                        ),
                        _gambarServiceAreaPelayanan
                            ? imageServiceAreaPelayanan == null
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
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MyCustomRoute(builder: (context) => DetailScreenServiceAreaPelayanan(image: imageServiceAreaPelayanan)));
                                      },
                                      child: Image.network(
                                        imageServiceAreaPelayanan.toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                ),
                              ]
                          ),
                        )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 15.0, left: 15.0, bottom: 10.0),
                          child: Divider(
                            height: 1.0,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  '"Grooming" Team Member',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color:
                                    /*widget.hasilAreaLuar * 100 > 85.0
                                      ? Colors.green
                                      : widget.hasilAreaLuar * 100 < 70.0
                                      ? Colors.redAccent
                                      : Colors.orangeAccent,*/
                                    Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: List.generate(
                            widget.pertanyaanGroomingPelayanan.length,
                                (indextiga) {
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Container(
                                      width: 270.0,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  '${indextiga + 1}. ${widget.pertanyaanGroomingPelayanan[indextiga]}',
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
                                              widget.scoreGroomingPelayanan[indextiga] == 0
                                                  ? 'NO'
                                                  : 'YES',
                                              style: TextStyle(
                                                  color:
                                                  widget.scoreGroomingPelayanan[indextiga] == 0
                                                      ? Colors
                                                      .redAccent
                                                      : Colors.black54,
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _gambarGroomingPelayanan = !_gambarGroomingPelayanan;
                                      });
                                    },
                                    child: Icon(Icons.image, color: imageGroomingPelayanan == null ? Colors.grey : AbubaPallate.menuBluebird),
                                  ),
                                ]
                            )
                        ),
                        _gambarGroomingPelayanan
                            ? imageGroomingPelayanan == null
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
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MyCustomRoute(builder: (context) => DetailScreenGroomingPelayanan(image: imageGroomingPelayanan)));
                                      },
                                      child: Image.network(
                                        imageGroomingPelayanan.toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                ),
                              ]
                          ),
                        )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 15.0, left: 15.0, bottom: 10.0),
                          child: Divider(
                            height: 1.0,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Keamanan / Pencegahan Kehilangan',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color:
                                    /*widget.hasilAreaLuar * 100 > 85.0
                                      ? Colors.green
                                      : widget.hasilAreaLuar * 100 < 70.0
                                      ? Colors.redAccent
                                      : Colors.orangeAccent,*/
                                    Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: List.generate(
                            widget.pertanyaanKeamananPelayanan.length,
                                (indexempat) {
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Container(
                                      width: 270.0,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  '${indexempat + 1}. ${widget.pertanyaanKeamananPelayanan[indexempat]}',
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
                                              widget.scoreKeamananPelayanan[indexempat] == 0
                                                  ? 'NO'
                                                  : 'YES',
                                              style: TextStyle(
                                                  color:
                                                  widget.scoreKeamananPelayanan[indexempat] == 0
                                                      ? Colors
                                                      .redAccent
                                                      : Colors.black54,
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _gambarKeamananPelayanan = !_gambarKeamananPelayanan;
                                      });
                                    },
                                    child: Icon(Icons.image, color: imageKeamananPelayanan == null ? Colors.grey : AbubaPallate.menuBluebird),
                                  ),
                                ]
                            )
                        ),
                        _gambarKeamananPelayanan
                            ? imageKeamananPelayanan == null
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
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MyCustomRoute(builder: (context) => DetailScreenKeamananPelayanan(image: imageKeamananPelayanan)));
                                      },
                                      child: Image.network(
                                        imageKeamananPelayanan.toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                ),
                              ]
                          ),
                        )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 15.0, left: 15.0, bottom: 10.0),
                          child: Divider(
                            height: 1.0,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Kesiapan Bisnis',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color:
                                    /*widget.hasilAreaLuar * 100 > 85.0
                                      ? Colors.green
                                      : widget.hasilAreaLuar * 100 < 70.0
                                      ? Colors.redAccent
                                      : Colors.orangeAccent,*/
                                    Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: List.generate(
                            widget.pertanyaanKesiapanBisnis.length,
                                (indexlima) {
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Container(
                                      width: 270.0,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  '${indexlima + 1}. ${widget.pertanyaanKesiapanBisnis[indexlima]}',
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
                                              widget.scoreKesiapanBisnis[indexlima] == 0
                                                  ? 'NO'
                                                  : 'YES',
                                              style: TextStyle(
                                                  color:
                                                  widget.scoreKesiapanBisnis[indexlima] == 0
                                                      ? Colors
                                                      .redAccent
                                                      : Colors.black54,
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _gambarKesiapanBisnis = !_gambarKesiapanBisnis;
                                      });
                                    },
                                    child: Icon(Icons.image, color: imageKesiapanBisnis == null ? Colors.grey : AbubaPallate.menuBluebird),
                                  ),
                                ]
                            )
                        ),
                        _gambarKesiapanBisnis
                            ? imageKesiapanBisnis == null
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
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MyCustomRoute(builder: (context) => DetailScreenKesiapanBisnis(image: imageKesiapanBisnis)));
                                      },
                                      child: Image.network(
                                        imageKesiapanBisnis.toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                ),
                              ]
                          ),
                        )
                            : Container(),
                      ],
                    ),

                    ExpansionTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Area Cook',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                color:
                                hasilAreaCook == 0
                                    ? Colors.green
                                    : hasilAreaCook >= 5
                                    ? Colors.redAccent
                                    : Colors.orangeAccent,
                              ),
                            ),
                          ),
                        ],
                      ),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Steak',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color:
                                    /*widget.hasilAreaLuar * 100 > 85.0
                                      ? Colors.green
                                      : widget.hasilAreaLuar * 100 < 70.0
                                      ? Colors.redAccent
                                      : Colors.orangeAccent,*/
                                    Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: List.generate(
                            widget.pertanyaanSteakCook.length,
                                (index) {
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Container(
                                      width: 270.0,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  '${index + 1}. ${widget.pertanyaanSteakCook[index]}',
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
                                              widget.scoreSteakCook[
                                              index] ==
                                                  0
                                                  ? 'NO'
                                                  : 'YES',
                                              style: TextStyle(
                                                  color:
                                                  widget.scoreSteakCook[
                                                  index] ==
                                                      0
                                                      ? Colors
                                                      .redAccent
                                                      : Colors.black54,
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _gambarSteakCook = !_gambarSteakCook;
                                      });
                                    },
                                    child: Icon(Icons.image, color: imageSteakCook == null ? Colors.grey : AbubaPallate.menuBluebird),
                                  ),
                                ]
                            )
                        ),
                        _gambarSteakCook
                            ? imageSteakCook == null
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
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MyCustomRoute(builder: (context) => DetailScreenSteakCook(image: imageSteakCook)));
                                      },
                                      child: Image.network(
                                        imageSteakCook.toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                ),
                              ]
                          ),
                        )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 15.0, left: 15.0, bottom: 10.0),
                          child: Divider(
                            height: 1.0,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Batter Mix (Spicy/Original)',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color:
                                    /*widget.hasilAreaLuar * 100 > 85.0
                                      ? Colors.green
                                      : widget.hasilAreaLuar * 100 < 70.0
                                      ? Colors.redAccent
                                      : Colors.orangeAccent,*/
                                    Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: List.generate(
                            widget.pertanyaanBatterMixCook.length,
                                (indexdua) {
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Container(
                                      width: 270.0,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  '${indexdua + 1}. ${widget.pertanyaanBatterMixCook[indexdua]}',
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
                                              widget.scoreBatterMixCook[
                                              indexdua] ==
                                                  0
                                                  ? 'NO'
                                                  : 'YES',
                                              style: TextStyle(
                                                  color: widget.scoreBatterMixCook[
                                                  indexdua] ==
                                                      0
                                                      ? Colors.redAccent
                                                      : Colors.black54,
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _gambarBatterMixCook = !_gambarBatterMixCook;
                                      });
                                    },
                                    child: Icon(Icons.image, color: imageBatterMixCook == null ? Colors.grey : AbubaPallate.menuBluebird),
                                  ),
                                ]
                            )
                        ),
                        _gambarBatterMixCook
                            ? imageBatterMixCook == null
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
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MyCustomRoute(builder: (context) => DetailScreenBatterMixCook(image: imageBatterMixCook)));
                                      },
                                      child: Image.network(
                                        imageBatterMixCook.toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                ),
                              ]
                          ),
                        )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 15.0, left: 15.0, bottom: 10.0),
                          child: Divider(
                            height: 1.0,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Mix Vegetables',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color:
                                    /*widget.hasilAreaLuar * 100 > 85.0
                                      ? Colors.green
                                      : widget.hasilAreaLuar * 100 < 70.0
                                      ? Colors.redAccent
                                      : Colors.orangeAccent,*/
                                    Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: List.generate(
                            widget.pertanyaanMixVegetablesCook.length,
                                (indextiga) {
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Container(
                                      width: 270.0,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  '${indextiga + 1}. ${widget.pertanyaanMixVegetablesCook[indextiga]}',
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
                                              widget.scoreMixVegetablesCook[indextiga] == 0
                                                  ? 'NO'
                                                  : 'YES',
                                              style: TextStyle(
                                                  color:
                                                  widget.scoreMixVegetablesCook[indextiga] == 0
                                                      ? Colors
                                                      .redAccent
                                                      : Colors.black54,
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _gambarMixVegetablesCook = !_gambarMixVegetablesCook;
                                      });
                                    },
                                    child: Icon(Icons.image, color: imageMixVegetablesCook == null ? Colors.grey : AbubaPallate.menuBluebird),
                                  ),
                                ]
                            )
                        ),
                        _gambarMixVegetablesCook
                            ? imageMixVegetablesCook == null
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
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MyCustomRoute(builder: (context) => DetailScreenMixVegetablesCook(image: imageMixVegetablesCook)));
                                      },
                                      child: Image.network(
                                        imageMixVegetablesCook.toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                ),
                              ]
                          ),
                        )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 15.0, left: 15.0, bottom: 10.0),
                          child: Divider(
                            height: 1.0,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Potato Wedges',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color:
                                    /*widget.hasilAreaLuar * 100 > 85.0
                                      ? Colors.green
                                      : widget.hasilAreaLuar * 100 < 70.0
                                      ? Colors.redAccent
                                      : Colors.orangeAccent,*/
                                    Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: List.generate(
                            widget.pertanyaanPotatoCook.length,
                                (indexempat) {
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Container(
                                      width: 270.0,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  '${indexempat + 1}. ${widget.pertanyaanPotatoCook[indexempat]}',
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
                                              widget.scorePotatoCook[indexempat] == 0
                                                  ? 'NO'
                                                  : 'YES',
                                              style: TextStyle(
                                                  color:
                                                  widget.scorePotatoCook[indexempat] == 0
                                                      ? Colors
                                                      .redAccent
                                                      : Colors.black54,
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _gambarPotatoCook = !_gambarPotatoCook;
                                      });
                                    },
                                    child: Icon(Icons.image, color: imagePotatoCook == null ? Colors.grey : AbubaPallate.menuBluebird),
                                  ),
                                ]
                            )
                        ),
                        _gambarPotatoCook
                            ? imagePotatoCook == null
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
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MyCustomRoute(builder: (context) => DetailScreenPotatoCook(image: imagePotatoCook)));
                                      },
                                      child: Image.network(
                                        imagePotatoCook.toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                ),
                              ]
                          ),
                        )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 15.0, left: 15.0, bottom: 10.0),
                          child: Divider(
                            height: 1.0,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Griller',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color:
                                    /*widget.hasilAreaLuar * 100 > 85.0
                                      ? Colors.green
                                      : widget.hasilAreaLuar * 100 < 70.0
                                      ? Colors.redAccent
                                      : Colors.orangeAccent,*/
                                    Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: List.generate(
                            widget.pertanyaanGrillerCook.length,
                                (indexlima) {
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Container(
                                      width: 270.0,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  '${indexlima + 1}. ${widget.pertanyaanGrillerCook[indexlima]}',
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
                                              widget.scoreGrillerCook[indexlima] == 0
                                                  ? 'NO'
                                                  : 'YES',
                                              style: TextStyle(
                                                  color:
                                                  widget.scoreGrillerCook[indexlima] == 0
                                                      ? Colors
                                                      .redAccent
                                                      : Colors.black54,
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _gambarGrillerCook = !_gambarGrillerCook;
                                      });
                                    },
                                    child: Icon(Icons.image, color: imageGrillerCook == null ? Colors.grey : AbubaPallate.menuBluebird),
                                  ),
                                ]
                            )
                        ),
                        _gambarGrillerCook
                            ? imageGrillerCook == null
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
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MyCustomRoute(builder: (context) => DetailScreenGrillerCook(image: imageGrillerCook)));
                                      },
                                      child: Image.network(
                                        imageGrillerCook.toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                ),
                              ]
                          ),
                        )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 15.0, left: 15.0, bottom: 10.0),
                          child: Divider(
                            height: 1.0,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Penanganan Keamanan Makanan',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color:
                                    /*widget.hasilAreaLuar * 100 > 85.0
                                      ? Colors.green
                                      : widget.hasilAreaLuar * 100 < 70.0
                                      ? Colors.redAccent
                                      : Colors.orangeAccent,*/
                                    Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: List.generate(
                            widget.pertanyaanKeamananMakananCook.length,
                                (indexenam) {
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Container(
                                      width: 270.0,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  '${indexenam + 1}. ${widget.pertanyaanKeamananMakananCook[indexenam]}',
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
                                              widget.scoreKeamananMakananCook[indexenam] == 0
                                                  ? 'NO'
                                                  : 'YES',
                                              style: TextStyle(
                                                  color:
                                                  widget.scoreKeamananMakananCook[indexenam] == 0
                                                      ? Colors
                                                      .redAccent
                                                      : Colors.black54,
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _gambarKeamananMakananCook = !_gambarKeamananMakananCook;
                                      });
                                    },
                                    child: Icon(Icons.image, color: imageKeamananMakananCook == null ? Colors.grey : AbubaPallate.menuBluebird),
                                  ),
                                ]
                            )
                        ),
                        _gambarKeamananMakananCook
                            ? imageKeamananMakananCook == null
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
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MyCustomRoute(builder: (context) => DetailScreenKeamananMakananCook(image: imageKeamananMakananCook)));
                                      },
                                      child: Image.network(
                                        imageKeamananMakananCook.toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                ),
                              ]
                          ),
                        )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 15.0, left: 15.0, bottom: 10.0),
                          child: Divider(
                            height: 1.0,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Cook Area',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color:
                                    /*widget.hasilAreaLuar * 100 > 85.0
                                      ? Colors.green
                                      : widget.hasilAreaLuar * 100 < 70.0
                                      ? Colors.redAccent
                                      : Colors.orangeAccent,*/
                                    Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: List.generate(
                            widget.pertanyaanAreaCook.length,
                                (indextujuh) {
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Container(
                                      width: 270.0,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  '${indextujuh + 1}. ${widget.pertanyaanAreaCook[indextujuh]}',
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
                                              widget.scoreAreaCook[indextujuh] == 0
                                                  ? 'NO'
                                                  : 'YES',
                                              style: TextStyle(
                                                  color:
                                                  widget.scoreAreaCook[indextujuh] == 0
                                                      ? Colors
                                                      .redAccent
                                                      : Colors.black54,
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _gambarAreaCook = !_gambarAreaCook;
                                      });
                                    },
                                    child: Icon(Icons.image, color: imageAreaCook == null ? Colors.grey : AbubaPallate.menuBluebird),
                                  ),
                                ]
                            )
                        ),
                        _gambarAreaCook
                            ? imageAreaCook == null
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
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MyCustomRoute(builder: (context) => DetailScreenAreaCook(image: imageAreaCook)));
                                      },
                                      child: Image.network(
                                        imageAreaCook.toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                ),
                              ]
                          ),
                        )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 15.0, left: 15.0, bottom: 10.0),
                          child: Divider(
                            height: 1.0,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Kitchen Equipment',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color:
                                    /*widget.hasilAreaLuar * 100 > 85.0
                                      ? Colors.green
                                      : widget.hasilAreaLuar * 100 < 70.0
                                      ? Colors.redAccent
                                      : Colors.orangeAccent,*/
                                    Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: List.generate(
                            widget.pertanyaanKitchenCook.length,
                                (indexdelapan) {
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Container(
                                      width: 270.0,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  '${indexdelapan + 1}. ${widget.pertanyaanKitchenCook[indexdelapan]}',
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
                                              widget.scoreKitchenCook[indexdelapan] == 0
                                                  ? 'NO'
                                                  : 'YES',
                                              style: TextStyle(
                                                  color:
                                                  widget.scoreKitchenCook[indexdelapan] == 0
                                                      ? Colors
                                                      .redAccent
                                                      : Colors.black54,
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _gambarKitchenCook = !_gambarKitchenCook;
                                      });
                                    },
                                    child: Icon(Icons.image, color: imageKitchenCook == null ? Colors.grey : AbubaPallate.menuBluebird),
                                  ),
                                ]
                            )
                        ),
                        _gambarKitchenCook
                            ? imageKitchenCook == null
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
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MyCustomRoute(builder: (context) => DetailScreenKitchenCook(image: imageKitchenCook)));
                                      },
                                      child: Image.network(
                                        imageKitchenCook.toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                ),
                              ]
                          ),
                        )
                            : Container(),
                      ],
                    ),

                    ExpansionTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Area Back Wash / Storage',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                color:
                                hasilWash == 0
                                    ? Colors.green
                                    : hasilWash >= 5
                                    ? Colors.redAccent
                                    : Colors.orangeAccent,
                              ),
                            ),
                          ),
                        ],
                      ),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Dishwasher Area',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color:
                                    /*widget.hasilAreaLuar * 100 > 85.0
                                      ? Colors.green
                                      : widget.hasilAreaLuar * 100 < 70.0
                                      ? Colors.redAccent
                                      : Colors.orangeAccent,*/
                                    Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: List.generate(
                            widget.pertanyaanDishwasherWash.length,
                                (index) {
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Container(
                                      width: 270.0,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  '${index + 1}. ${widget.pertanyaanDishwasherWash[index]}',
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
                                              widget.scoreDishwasherWash[
                                              index] ==
                                                  0
                                                  ? 'NO'
                                                  : 'YES',
                                              style: TextStyle(
                                                  color:
                                                  widget.scoreDishwasherWash[
                                                  index] ==
                                                      0
                                                      ? Colors
                                                      .redAccent
                                                      : Colors.black54,
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _gambarDishwasherWash = !_gambarDishwasherWash;
                                      });
                                    },
                                    child: Icon(Icons.image, color: imageDishwasherWash == null ? Colors.grey : AbubaPallate.menuBluebird),
                                  ),
                                ]
                            )
                        ),
                        _gambarDishwasherWash
                            ? imageDishwasherWash == null
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
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MyCustomRoute(builder: (context) => DetailScreenDishwasherWash(image: imageDishwasherWash)));
                                      },
                                      child: Image.network(
                                        imageDishwasherWash.toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                ),
                              ]
                          ),
                        )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 15.0, left: 15.0, bottom: 10.0),
                          child: Divider(
                            height: 1.0,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Chiller & Freezer',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color:
                                    /*widget.hasilAreaLuar * 100 > 85.0
                                      ? Colors.green
                                      : widget.hasilAreaLuar * 100 < 70.0
                                      ? Colors.redAccent
                                      : Colors.orangeAccent,*/
                                    Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: List.generate(
                            widget.pertanyaanChillerWash.length,
                                (indexdua) {
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Container(
                                      width: 270.0,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  '${indexdua + 1}. ${widget.pertanyaanChillerWash[indexdua]}',
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
                                              widget.scoreChillerWash[
                                              indexdua] ==
                                                  0
                                                  ? 'NO'
                                                  : 'YES',
                                              style: TextStyle(
                                                  color: widget.scoreChillerWash[
                                                  indexdua] ==
                                                      0
                                                      ? Colors.redAccent
                                                      : Colors.black54,
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _gambarChillerWash = !_gambarChillerWash;
                                      });
                                    },
                                    child: Icon(Icons.image, color: imageChillerWash == null ? Colors.grey : AbubaPallate.menuBluebird),
                                  ),
                                ]
                            )
                        ),
                        _gambarChillerWash
                            ? imageChillerWash == null
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
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MyCustomRoute(builder: (context) => DetailScreenChillerWash(image: imageChillerWash)));
                                      },
                                      child: Image.network(
                                        imageChillerWash.toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                ),
                              ]
                          ),
                        )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 15.0, left: 15.0, bottom: 10.0),
                          child: Divider(
                            height: 1.0,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Penanganan Keamanan Makanan',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color:
                                    /*widget.hasilAreaLuar * 100 > 85.0
                                      ? Colors.green
                                      : widget.hasilAreaLuar * 100 < 70.0
                                      ? Colors.redAccent
                                      : Colors.orangeAccent,*/
                                    Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: List.generate(
                            widget.pertanyaanKeamananWash.length,
                                (indextiga) {
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Container(
                                      width: 270.0,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  '${indextiga + 1}. ${widget.pertanyaanKeamananWash[indextiga]}',
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
                                              widget.scoreKeamananWash[indextiga] == 0
                                                  ? 'NO'
                                                  : 'YES',
                                              style: TextStyle(
                                                  color:
                                                  widget.scoreKeamananWash[indextiga] == 0
                                                      ? Colors
                                                      .redAccent
                                                      : Colors.black54,
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _gambarKeamananWash = !_gambarKeamananWash;
                                      });
                                    },
                                    child: Icon(Icons.image, color: imageKeamananWash == null ? Colors.grey : AbubaPallate.menuBluebird),
                                  ),
                                ]
                            )
                        ),
                        _gambarKeamananWash
                            ? imageKeamananWash == null
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
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MyCustomRoute(builder: (context) => DetailScreenKeamananWash(image: imageKeamananWash)));
                                      },
                                      child: Image.network(
                                        imageKeamananWash.toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                ),
                              ]
                          ),
                        )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 15.0, left: 15.0, bottom: 10.0),
                          child: Divider(
                            height: 1.0,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Alat Keamanan',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color:
                                    /*widget.hasilAreaLuar * 100 > 85.0
                                      ? Colors.green
                                      : widget.hasilAreaLuar * 100 < 70.0
                                      ? Colors.redAccent
                                      : Colors.orangeAccent,*/
                                    Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: List.generate(
                            widget.pertanyaanAlatWash.length,
                                (indexempat) {
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Container(
                                      width: 270.0,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  '${indexempat + 1}. ${widget.pertanyaanAlatWash[indexempat]}',
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
                                              widget.scoreAlatWash[indexempat] == 0
                                                  ? 'NO'
                                                  : 'YES',
                                              style: TextStyle(
                                                  color:
                                                  widget.scoreAlatWash[indexempat] == 0
                                                      ? Colors
                                                      .redAccent
                                                      : Colors.black54,
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _gambarAlatWash = !_gambarAlatWash;
                                      });
                                    },
                                    child: Icon(Icons.image, color: imageAlatWash == null ? Colors.grey : AbubaPallate.menuBluebird),
                                  ),
                                ]
                            )
                        ),
                        _gambarAlatWash
                            ? imageAlatWash == null
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
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MyCustomRoute(builder: (context) => DetailScreenAlatWash(image: imageAlatWash)));
                                      },
                                      child: Image.network(
                                        imageAlatWash.toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                ),
                              ]
                          ),
                        )
                            : Container(),
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

class DetailScreenParkingLobby extends StatefulWidget {
  @override
  _DetailScreenParkingLobbyState createState() => _DetailScreenParkingLobbyState();
  final String image;

  DetailScreenParkingLobby({this.image});
}

class _DetailScreenParkingLobbyState extends State<DetailScreenParkingLobby> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              widget.image.toString(),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class DetailScreenDinningAreaLobby extends StatefulWidget {
  @override
  _DetailScreenDinningAreaLobbyState createState() => _DetailScreenDinningAreaLobbyState();
  final String image;

  DetailScreenDinningAreaLobby({this.image});
}

class _DetailScreenDinningAreaLobbyState extends State<DetailScreenDinningAreaLobby> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              widget.image.toString(),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class DetailScreenRestroomLobby extends StatefulWidget {
  @override
  _DetailScreenRestroomLobbyState createState() => _DetailScreenRestroomLobbyState();
  final String image;

  DetailScreenRestroomLobby({this.image});
}

class _DetailScreenRestroomLobbyState extends State<DetailScreenRestroomLobby> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              widget.image.toString(),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

/* bab 2 */
class DetailScreenGrillAreaDinning extends StatefulWidget {
  @override
  _DetailScreenGrillAreaDinningState createState() => _DetailScreenGrillAreaDinningState();
  final String image;

  DetailScreenGrillAreaDinning({this.image});
}

class _DetailScreenGrillAreaDinningState extends State<DetailScreenGrillAreaDinning> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              widget.image.toString(),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class DetailScreenBarDinning extends StatefulWidget {
  @override
  _DetailScreenBarDinningState createState() => _DetailScreenBarDinningState();
  final String image;

  DetailScreenBarDinning({this.image});
}

class _DetailScreenBarDinningState extends State<DetailScreenBarDinning> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              widget.image.toString(),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class DetailScreenProductionDinning extends StatefulWidget {
  @override
  _DetailScreenProductionDinningState createState() => _DetailScreenProductionDinningState();
  final String image;

  DetailScreenProductionDinning({this.image});
}

class _DetailScreenProductionDinningState extends State<DetailScreenProductionDinning> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              widget.image.toString(),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class DetailScreenWarehouseDinning extends StatefulWidget {
  @override
  _DetailScreenWarehouseDinningState createState() => _DetailScreenWarehouseDinningState();
  final String image;

  DetailScreenWarehouseDinning({this.image});
}

class _DetailScreenWarehouseDinningState extends State<DetailScreenWarehouseDinning> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              widget.image.toString(),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

/* bab 3 */
class DetailScreenMenuBoardPelayanan extends StatefulWidget {
  @override
  _DetailScreenMenuBoardPelayananState createState() => _DetailScreenMenuBoardPelayananState();
  final String image;

  DetailScreenMenuBoardPelayanan({this.image});
}

class _DetailScreenMenuBoardPelayananState extends State<DetailScreenMenuBoardPelayanan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              widget.image.toString(),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class DetailScreenServiceAreaPelayanan extends StatefulWidget {
  @override
  _DetailScreenServiceAreaPelayananState createState() => _DetailScreenServiceAreaPelayananState();
  final String image;

  DetailScreenServiceAreaPelayanan({this.image});
}

class _DetailScreenServiceAreaPelayananState extends State<DetailScreenServiceAreaPelayanan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              widget.image.toString(),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class DetailScreenGroomingPelayanan extends StatefulWidget {
  @override
  _DetailScreenGroomingPelayananState createState() => _DetailScreenGroomingPelayananState();
  final String image;

  DetailScreenGroomingPelayanan({this.image});
}

class _DetailScreenGroomingPelayananState extends State<DetailScreenGroomingPelayanan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              widget.image.toString(),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class DetailScreenKeamananPelayanan extends StatefulWidget {
  @override
  _DetailScreenKeamananPelayananState createState() => _DetailScreenKeamananPelayananState();
  final String image;

  DetailScreenKeamananPelayanan({this.image});
}

class _DetailScreenKeamananPelayananState extends State<DetailScreenKeamananPelayanan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              widget.image.toString(),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class DetailScreenKesiapanBisnis extends StatefulWidget {
  @override
  _DetailScreenKesiapanBisnisState createState() => _DetailScreenKesiapanBisnisState();
  final String image;

  DetailScreenKesiapanBisnis({this.image});
}

class _DetailScreenKesiapanBisnisState extends State<DetailScreenKesiapanBisnis> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              widget.image.toString(),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

/*bab 4*/
class DetailScreenSteakCook extends StatefulWidget {
  @override
  _DetailScreenSteakCookState createState() => _DetailScreenSteakCookState();
  final String image;

  DetailScreenSteakCook({this.image});
}

class _DetailScreenSteakCookState extends State<DetailScreenSteakCook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              widget.image.toString(),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class DetailScreenBatterMixCook extends StatefulWidget {
  @override
  _DetailScreenBatterMixCookState createState() => _DetailScreenBatterMixCookState();
  final String image;

  DetailScreenBatterMixCook({this.image});
}

class _DetailScreenBatterMixCookState extends State<DetailScreenBatterMixCook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              widget.image.toString(),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class DetailScreenMixVegetablesCook extends StatefulWidget {
  @override
  _DetailScreenMixVegetablesCookState createState() => _DetailScreenMixVegetablesCookState();
  final String image;

  DetailScreenMixVegetablesCook({this.image});
}

class _DetailScreenMixVegetablesCookState extends State<DetailScreenMixVegetablesCook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              widget.image.toString(),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class DetailScreenPotatoCook extends StatefulWidget {
  @override
  _DetailScreenPotatoCookState createState() => _DetailScreenPotatoCookState();
  final String image;

  DetailScreenPotatoCook({this.image});
}

class _DetailScreenPotatoCookState extends State<DetailScreenPotatoCook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              widget.image.toString(),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class DetailScreenGrillerCook extends StatefulWidget {
  @override
  _DetailScreenGrillerCookState createState() => _DetailScreenGrillerCookState();
  final String image;

  DetailScreenGrillerCook({this.image});
}

class _DetailScreenGrillerCookState extends State<DetailScreenGrillerCook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              widget.image.toString(),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class DetailScreenKeamananMakananCook extends StatefulWidget {
  @override
  _DetailScreenKeamananMakananCookState createState() => _DetailScreenKeamananMakananCookState();
  final String image;

  DetailScreenKeamananMakananCook({this.image});
}

class _DetailScreenKeamananMakananCookState extends State<DetailScreenKeamananMakananCook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              widget.image.toString(),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class DetailScreenAreaCook extends StatefulWidget {
  @override
  _DetailScreenAreaCookState createState() => _DetailScreenAreaCookState();
  final String image;

  DetailScreenAreaCook({this.image});
}

class _DetailScreenAreaCookState extends State<DetailScreenAreaCook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              widget.image.toString(),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class DetailScreenKitchenCook extends StatefulWidget {
  @override
  _DetailScreenKitchenCookState createState() => _DetailScreenKitchenCookState();
  final String image;

  DetailScreenKitchenCook({this.image});
}

class _DetailScreenKitchenCookState extends State<DetailScreenKitchenCook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              widget.image.toString(),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
/*bab 5*/
class DetailScreenDishwasherWash extends StatefulWidget {
  @override
  _DetailScreenDishwasherWashState createState() => _DetailScreenDishwasherWashState();
  final String image;

  DetailScreenDishwasherWash({this.image});
}

class _DetailScreenDishwasherWashState extends State<DetailScreenDishwasherWash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              widget.image.toString(),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class DetailScreenChillerWash extends StatefulWidget {
  @override
  _DetailScreenChillerWashState createState() => _DetailScreenChillerWashState();
  final String image;

  DetailScreenChillerWash({this.image});
}

class _DetailScreenChillerWashState extends State<DetailScreenChillerWash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              widget.image.toString(),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class DetailScreenKeamananWash extends StatefulWidget {
  @override
  _DetailScreenKeamananWashState createState() => _DetailScreenKeamananWashState();
  final String image;

  DetailScreenKeamananWash({this.image});
}

class _DetailScreenKeamananWashState extends State<DetailScreenKeamananWash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              widget.image.toString(),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class DetailScreenAlatWash extends StatefulWidget {
  @override
  _DetailScreenAlatWashState createState() => _DetailScreenAlatWashState();
  final String image;

  DetailScreenAlatWash({this.image});
}

class _DetailScreenAlatWashState extends State<DetailScreenAlatWash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              widget.image.toString(),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}