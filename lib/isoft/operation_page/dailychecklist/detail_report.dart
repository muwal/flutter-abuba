import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailReport extends StatefulWidget {
  @override
  _DetailReportState createState() => _DetailReportState();

  final int idUser;
  final String namaUser;
  final String idCollection;
  final String tanggal;
  final String waktuStart;
  final String waktuEnd;

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
  final List<dynamic> pertanyaanKeamananWash;
  final List<dynamic> pertanyaanAlatWash;
  DetailReport({
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

class _DetailReportState extends State<DetailReport> with TickerProviderStateMixin {
  AnimationController animationController;
  final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();

  String userCreated;

  double hasilKedua = 0.0;
  Color colorGrafik = Colors.green;

  @override
  void initState() {
    super.initState();
    setState(() {
      Firestore.instance
          .collection('dailychecklist')
          .document(widget.idCollection)
          .snapshots()
          .listen((data) {

        Firestore.instance
            .collection('user')
            .where('id', isEqualTo: data.data['idUser'])
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
    /*if (widget.hasilAreaLuar == 1 &&
        widget.hasilDinningArea == 1 &&
        widget.hasilService == 1 &&
        widget.hasilCashier == 1 &&
        widget.hasilCashierAccuracy == 1 &&
        widget.hasilBoh == 1 &&
        widget.hasilWarehouse == 1 &&
        widget.hasilSocialBlock == 1 &&
        widget.hasilPersonal == 1 &&
        widget.hasilFoodCooked == 1) {
      hasilKedua = 100.0;
    } else {
      hasilKedua = widget.hasilGrafik * 100.0;
    }*/

    /*hasilKedua > 85.0
        ? colorGrafik = Colors.green
        : hasilKedua < 70.0
        ? colorGrafik = Colors.redAccent
        : colorGrafik = Colors.orangeAccent;*/

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
                    'Daily Checklist Report',
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
                                  '1',
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
  @override
  _DetailScreenAreaLuarState createState() => _DetailScreenAreaLuarState();
  final String image;

  DetailScreenAreaLuar({this.image});




}

class _DetailScreenAreaLuarState extends State<DetailScreenAreaLuar>{
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

class DetailScreenDinningArea extends StatefulWidget {
  @override
  _DetailScreenDinningAreaState createState() => _DetailScreenDinningAreaState();
  final String image;

  DetailScreenDinningArea({this.image});
}

class _DetailScreenDinningAreaState extends State<DetailScreenDinningArea>{
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

class DetailScreenService extends StatefulWidget {
  @override
  _DetailScreenServiceState createState() => _DetailScreenServiceState();
  final String image;

  DetailScreenService({this.image});




}

class _DetailScreenServiceState extends State<DetailScreenService>{
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

class DetailScreenCashier extends StatefulWidget {
  @override
  _DetailScreenCashierState createState() => _DetailScreenCashierState();
  final String image;

  DetailScreenCashier({this.image});

}

class _DetailScreenCashierState extends State<DetailScreenCashier>{
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

class DetailScreenCashierAccuracy extends StatefulWidget {
  @override
  _DetailScreenCashierAccuracyState createState() => _DetailScreenCashierAccuracyState();
  final String image;

  DetailScreenCashierAccuracy({this.image});




}

class _DetailScreenCashierAccuracyState extends State<DetailScreenCashierAccuracy>{
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


class DetailScreenBoh extends StatefulWidget {
  @override
  _DetailScreenBohState createState() => _DetailScreenBohState();
  final String image;

  DetailScreenBoh({this.image});




}

class _DetailScreenBohState extends State<DetailScreenBoh>{
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

class DetailScreenWarehouse extends StatefulWidget {
  @override
  _DetailScreenWarehouseState createState() => _DetailScreenWarehouseState();
  final String image;

  DetailScreenWarehouse({this.image});




}

class _DetailScreenWarehouseState extends State<DetailScreenWarehouse>{
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

class DetailScreenSocialBlock extends StatefulWidget {
  @override
  _DetailScreenSocialBlockState createState() => _DetailScreenSocialBlockState();
  final String image;

  DetailScreenSocialBlock({this.image});




}

class _DetailScreenSocialBlockState extends State<DetailScreenSocialBlock>{
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

class DetailScreenPersonal extends StatefulWidget {
  @override
  _DetailScreenPersonalState createState() => _DetailScreenPersonalState();
  final String image;

  DetailScreenPersonal({this.image});
}

class _DetailScreenPersonalState extends State<DetailScreenPersonal>{
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

class DetailScreenFoodCooked extends StatefulWidget {
  @override
  _DetailScreenFoodCookedState createState() => _DetailScreenFoodCookedState();
  final String image;

  DetailScreenFoodCooked({this.image});
}

class _DetailScreenFoodCookedState extends State<DetailScreenFoodCooked>{
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