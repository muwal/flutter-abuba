import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailReport extends StatefulWidget {
  @override
  _DetailReportState createState() => _DetailReportState();

  final String outlet;
  final int idUser;
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
  DetailReport({
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
  List<bool> noteAreaLuar = [];
  List<bool> _gambarAreaLuar = [];

  List<dynamic> DinningAreaNote = [];
  List<dynamic> pertanyaanDinningArea = [];
  List<dynamic> imageDinningArea = [];
  List<bool> _catatanDinningArea = [];
  List<bool> _gambarDinningArea = [];

  List<dynamic> ServiceNote = [];
  List<dynamic> pertanyaanService = [];
  List<dynamic> imageService = [];
  List<bool> _catatanService = [];
  List<bool> _gambarService = [];

  List<dynamic> CashierNote = [];
  List<dynamic> pertanyaanCashier = [];
  List<dynamic> imageCashier = [];
  List<bool> _catatanCashier = [];
  List<bool> _gambarCashier = [];

  List<dynamic> CashierAccuracyNote = [];
  List<dynamic> pertanyaanCashierAccuracy = [];
  List<dynamic> imageCashierAccuracy = [];
  List<bool> _catatanCashierAccuracy = [];
  List<bool> _gambarCashierAccuracy = [];

  List<dynamic> BohNote = [];
  List<dynamic> pertanyaanBoh = [];
  List<dynamic> imageBoh = [];
  List<bool> _catatanBoh = [];
  List<bool> _gambarBoh = [];

  List<dynamic> WarehouseNote = [];
  List<dynamic> pertanyaanWarehouse = [];
  List<dynamic> imageWarehouse = [];
  List<bool> _catatanWarehouse = [];
  List<bool> _gambarWarehouse = [];

  List<dynamic> SocialBlockNote = [];
  List<dynamic> pertanyaanSocialBlock = [];
  List<dynamic> imageSocialBlock = [];
  List<bool> _catatanSocialBlock = [];
  List<bool> _gambarSocialBlock = [];

  List<dynamic> PersonalNote = [];
  List<dynamic> pertanyaanPersonal = [];
  List<dynamic> imagePersonal = [];
  List<bool> _catatanPersonal = [];
  List<bool> _gambarPersonal = [];

  List<dynamic> FoodCookedNote = [];
  List<dynamic> pertanyaanFoodCooked = [];
  List<dynamic> imageFoodCooked = [];
  List<bool> _catatanFoodCooked = [];
  List<bool> _gambarFoodCooked = [];

  /*double hasilAreaLuar = 0.0;
  double hasilDinningArea = 0.0;
  double hasilService = 0.0;
  double hasilCashier = 0.0;
  double hasilCashierAccuracy = 0.0;
  double hasilBoh = 0.0;
  double hasilWarehouse = 0.0;
  double hasilSocialBlock = 0.0;
  double hasilPersonal = 0.0;
  double hasilFoodCooked = 0.0;
  double hasilGrafik = 0.0;*/

  String userCreated;

  double hasilKedua = 0.0;
  Color colorGrafik = Colors.green;

  @override
  void initState() {
    super.initState();
    setState(() {
      Firestore.instance
          .collection('linecheck')
          .document(widget.idCollection)
          .snapshots()
          .listen((data) {
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

        Firestore.instance
            .collection('user')
            .where('id', isEqualTo: data.data['idUser'])
            .snapshots()
            .listen((data2) {
          userCreated = data2.documents[0].data['nama'];
        });
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
  }

  @override
  Widget build(BuildContext context) {
    final double size = MediaQuery.of(context).size.width;

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
                child: Text('Material', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black),),
              ),
              /*Stack(
                children: <Widget>[
                  Icon(Icons.notifications, color: Colors.grey[400],)
                ],
              )*/
            ],
          ),
        ),
        body: _formDetail(size, context),
      ),
    );
  }

  Widget _formDetail(double size, BuildContext context) {
    if (widget.hasilAreaLuar == 1 &&
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
    }

    hasilKedua > 85.0
        ? colorGrafik = Colors.green
        : hasilKedua < 70.0
        ? colorGrafik = Colors.redAccent
        : colorGrafik = Colors.orangeAccent;

    return Scrollbar(
      child: ListView(
        children: <Widget>[
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
                              'Area Luar',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                color: widget.hasilAreaLuar * 100 > 85.0
                                    ? Colors.green
                                    : widget.hasilAreaLuar * 100 < 70.0
                                    ? Colors.redAccent
                                    : Colors.orangeAccent,
                              ),
                            ),
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
                            percent: widget.hasilAreaLuar * 100 > 100.0
                                ? 1.0
                                : widget.hasilAreaLuar,
                            center: Text(widget.hasilAreaLuar * 100 >=
                                100.0
                                ? '100%'
                                : '${(widget.hasilAreaLuar * 100).toString().substring(0, 2)}%'),
                            animationDuration: 1000,
                            linearStrokeCap: LinearStrokeCap.butt,
                            progressColor:
                            widget.hasilAreaLuar * 100 > 85.0
                                ? Colors.green
                                : widget.hasilAreaLuar * 100 < 70.0
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
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  var bantuGambarAreaLuar = _gambarAreaLuar[index];
                                                  _gambarAreaLuar.removeAt(index);
                                                  _gambarAreaLuar.insert(index, !bantuGambarAreaLuar);
                                                  noteAreaLuar.removeAt(index);
                                                  noteAreaLuar.insert(index, false);
                                                });
                                              },
                                              child: Icon(Icons.image, color: imageAreaLuar[index] == null ? Colors.grey : AbubaPallate.menuBluebird),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  var bantuNoteAreaLuar = noteAreaLuar[index];
                                                  noteAreaLuar.removeAt(index);
                                                  noteAreaLuar.insert(index, !bantuNoteAreaLuar);
                                                  _gambarAreaLuar.removeAt(index);
                                                  _gambarAreaLuar.insert(index, false);
                                                });
                                              },
                                              child: Icon(Icons.note_add, color: AreaLuarNote[index] == null
                                                  ? Colors.grey
                                                  : AbubaPallate
                                                  .menuBluebird),
                                            ),
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
                                                Navigator.push(context, MyCustomRoute(builder: (context) => DetailScreenAreaLuar(image: imageAreaLuar[index])));
                                              },
                                              child: Image.network(
                                                imageAreaLuar[index].toString(),
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                        ),
                                      ]
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
                            child: Text(
                              'Dinning Area',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                color: widget.hasilDinningArea * 100 >
                                    85.0
                                    ? Colors.green
                                    : widget.hasilDinningArea * 100 < 70.0
                                    ? Colors.redAccent
                                    : Colors.orangeAccent,
                              ),
                            ),
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
                            percent: widget.hasilDinningArea * 100 > 100.0
                                ? 1.0
                                : widget.hasilDinningArea,
                            center: Text(widget.hasilDinningArea * 100 >=
                                100.0
                                ? '100%'
                                : '${(widget.hasilDinningArea * 100).toString().substring(0, 2)}%'),
                            animationDuration: 1000,
                            linearStrokeCap: LinearStrokeCap.butt,
                            progressColor:
                            widget.hasilDinningArea * 100 > 85.0
                                ? Colors.green
                                : widget.hasilDinningArea * 100 < 70.0
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
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  var bantuGambarDinning = _gambarDinningArea[index];
                                                  _gambarDinningArea.removeAt(index);
                                                  _gambarDinningArea.insert(index, !bantuGambarDinning);
                                                  _catatanDinningArea.removeAt(index);
                                                  _catatanDinningArea.insert(index, false);
                                                });
                                              },
                                              child: Icon(Icons.image, color: imageDinningArea[index] == null ? Colors.grey : AbubaPallate.menuBluebird),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  var bantuCatatanDinning = _catatanDinningArea[index];
                                                  _catatanDinningArea.removeAt(index);
                                                  _catatanDinningArea.insert(index, !bantuCatatanDinning);
                                                  _gambarDinningArea.removeAt(index);
                                                  _gambarDinningArea.insert(index, false);
                                                });
                                              },
                                              child: Icon(Icons.note_add,
                                                  color: DinningAreaNote[
                                                  index] ==
                                                      null
                                                      ? Colors.grey
                                                      : AbubaPallate
                                                      .menuBluebird),
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
                                        crossAxisCount: 2,
                                        childAspectRatio: 1.0,
                                        mainAxisSpacing: 4.0,
                                        crossAxisSpacing: 4.0,
                                        shrinkWrap: true,
                                        children: <Widget>[
                                          GridTile(
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(context, MyCustomRoute(builder: (context) => DetailScreenDinningArea(image: imageDinningArea[index])));
                                                },
                                                child: Image.network(
                                                  imageDinningArea[index].toString(),
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                          ),
                                        ]
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
                            child: Text(
                              'Service',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                color: widget.hasilService * 100 > 85.0
                                    ? Colors.green
                                    : widget.hasilService * 100 < 70.0
                                    ? Colors.redAccent
                                    : Colors.orangeAccent,
                              ),
                            ),
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
                            percent: widget.hasilService * 100 > 100.0
                                ? 1.0
                                : widget.hasilService,
                            center: Text(widget.hasilService * 100 >=
                                100.0
                                ? '100%'
                                : '${(widget.hasilService * 100).toString().substring(0, 2)}%'),
                            animationDuration: 1000,
                            linearStrokeCap: LinearStrokeCap.butt,
                            progressColor:
                            widget.hasilService * 100 > 85.0
                                ? Colors.green
                                : widget.hasilService * 100 < 70.0
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
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  var bantuGambarService = _gambarService[index];
                                                  _gambarService.removeAt(index);
                                                  _gambarService.insert(index, !bantuGambarService);
                                                  _catatanService.removeAt(index);
                                                  _catatanService.insert(index, false);
                                                });
                                              },
                                              child: Icon(Icons.image, color: imageService[index] == null ? Colors.grey : AbubaPallate.menuBluebird),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  var bantuCatatanService = _catatanService[index];
                                                  _catatanService.removeAt(index);
                                                  _catatanService.insert(index, !bantuCatatanService);
                                                  _gambarService.removeAt(index);
                                                  _gambarService.insert(index, false);
                                                });
                                              },
                                              child: Icon(Icons.note_add,
                                                  color: ServiceNote[
                                                  index] ==
                                                      null
                                                      ? Colors.grey
                                                      : AbubaPallate
                                                      .menuBluebird),
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
                                        crossAxisCount: 2,
                                        childAspectRatio: 1.0,
                                        mainAxisSpacing: 4.0,
                                        crossAxisSpacing: 4.0,
                                        shrinkWrap: true,
                                        children: <Widget>[
                                          GridTile(
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(context, MyCustomRoute(builder: (context) => DetailScreenService(image: imageService[index])));
                                                },
                                                child: Image.network(
                                                  imageService[index].toString(),
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                          ),
                                        ]
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
                            child: Text(
                              'Cashier',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                color: widget.hasilCashier * 100 > 85.0
                                    ? Colors.green
                                    : widget.hasilCashier * 100 < 70.0
                                    ? Colors.redAccent
                                    : Colors.orangeAccent,
                              ),
                            ),
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
                            percent: widget.hasilCashier * 100 > 100.0
                                ? 1.0
                                : widget.hasilCashier,
                            center: Text(widget.hasilCashier * 100 >=
                                100.0
                                ? '100%'
                                : '${(widget.hasilCashier * 100).toString().substring(0, 2)}%'),
                            animationDuration: 1000,
                            linearStrokeCap: LinearStrokeCap.butt,
                            progressColor:
                            widget.hasilCashier * 100 > 85.0
                                ? Colors.green
                                : widget.hasilCashier * 100 < 70.0
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
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  var bantuGambarCashier = _gambarCashier[index];
                                                  _gambarCashier.removeAt(index);
                                                  _gambarCashier.insert(index, !bantuGambarCashier);
                                                  _catatanCashier.removeAt(index);
                                                  _catatanCashier.insert(index, false);
                                                });
                                              },
                                              child: Icon(Icons.image, color: imageCashier[index] == null ? Colors.grey : AbubaPallate.menuBluebird),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  var bantuCatatanCashier = _catatanCashier[index];
                                                  _catatanCashier.removeAt(index);
                                                  _catatanCashier.insert(index, !bantuCatatanCashier);
                                                  _gambarCashier.removeAt(index);
                                                  _gambarCashier.insert(index, false);
                                                });
                                              },
                                              child: Icon(Icons.note_add,
                                                  color: CashierNote[
                                                  index] ==
                                                      null
                                                      ? Colors.grey
                                                      : AbubaPallate
                                                      .menuBluebird),
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
                                        crossAxisCount: 2,
                                        childAspectRatio: 1.0,
                                        mainAxisSpacing: 4.0,
                                        crossAxisSpacing: 4.0,
                                        shrinkWrap: true,
                                        children: <Widget>[
                                          GridTile(
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(context, MyCustomRoute(builder: (context) => DetailScreenCashier(image: imageCashier[index])));
                                                },
                                                child: Image.network(
                                                  imageCashier[index].toString(),
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                          ),
                                        ]
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
                            child: Text(
                              'Administrasi Keuangan',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                color: widget.hasilCashierAccuracy * 100 >
                                    85.0
                                    ? Colors.green
                                    : widget.hasilCashierAccuracy * 100 <
                                    70.0
                                    ? Colors.redAccent
                                    : Colors.orangeAccent,
                              ),
                            ),
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
                            percent:
                            widget.hasilCashierAccuracy * 100 > 100.0
                                ? 1.0
                                : widget.hasilCashierAccuracy,
                            center: Text(widget.hasilCashierAccuracy *
                                100 >=
                                100.0
                                ? '100%'
                                : '${(widget.hasilCashierAccuracy * 100).toString().substring(0, 2)}%'),
                            animationDuration: 1000,
                            linearStrokeCap: LinearStrokeCap.butt,
                            progressColor:
                            widget.hasilCashierAccuracy * 100 > 85.0
                                ? Colors.green
                                : widget.hasilCashierAccuracy * 100 <
                                70.0
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
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  var bantuGambarCashierAccuracy = _gambarCashierAccuracy[index];
                                                  _gambarCashierAccuracy.removeAt(index);
                                                  _gambarCashierAccuracy.insert(index, !bantuGambarCashierAccuracy);
                                                  _catatanCashierAccuracy.removeAt(index);
                                                  _catatanCashierAccuracy.insert(index, false);
                                                });
                                              },
                                              child: Icon(Icons.image, color: imageCashierAccuracy[index] == null ? Colors.grey : AbubaPallate.menuBluebird),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  var bantuCatatanCashierAccuracy = _catatanCashierAccuracy[index];
                                                  _catatanCashierAccuracy.removeAt(index);
                                                  _catatanCashierAccuracy.insert(index, !bantuCatatanCashierAccuracy);
                                                  _gambarCashierAccuracy.removeAt(index);
                                                  _gambarCashierAccuracy.insert(index, false);
                                                });
                                              },
                                              child: Icon(Icons.note_add,
                                                  color: CashierAccuracyNote[
                                                  index] ==
                                                      null
                                                      ? Colors.grey
                                                      : AbubaPallate
                                                      .menuBluebird),
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
                                        crossAxisCount: 2,
                                        childAspectRatio: 1.0,
                                        mainAxisSpacing: 4.0,
                                        crossAxisSpacing: 4.0,
                                        shrinkWrap: true,
                                        children: <Widget>[
                                          GridTile(
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(context, MyCustomRoute(builder: (context) => DetailScreenCashierAccuracy(image: imageCashierAccuracy[index])));
                                                },
                                                child: Image.network(
                                                  imageCashierAccuracy[index].toString(),
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                          ),
                                        ]
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
                            child: Text(
                              'Back of the House (BOH)',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                color: widget.hasilBoh * 100 > 85.0
                                    ? Colors.green
                                    : widget.hasilBoh * 100 < 70.0
                                    ? Colors.redAccent
                                    : Colors.orangeAccent,
                              ),
                            ),
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
                            percent: widget.hasilBoh * 100 > 100.0
                                ? 1.0
                                : widget.hasilBoh,
                            center: Text(widget.hasilBoh * 100 >= 100.0
                                ? '100%'
                                : '${(widget.hasilBoh * 100).toString().substring(0, 2)}%'),
                            animationDuration: 1000,
                            linearStrokeCap: LinearStrokeCap.butt,
                            progressColor: widget.hasilBoh * 100 > 85.0
                                ? Colors.green
                                : widget.hasilBoh * 100 < 70.0
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
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  var bantuGambarBoh = _gambarBoh[index];
                                                  _gambarBoh.removeAt(index);
                                                  _gambarBoh.insert(index, !bantuGambarBoh);
                                                  _catatanBoh.removeAt(index);
                                                  _catatanBoh.insert(index, false);
                                                });
                                              },
                                              child: Icon(Icons.image, color: imageBoh[index] == null ? Colors.grey : AbubaPallate.menuBluebird),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  var bantuCatatanBoh = _catatanBoh[index];
                                                  _catatanBoh.removeAt(index);
                                                  _catatanBoh.insert(index, !bantuCatatanBoh);
                                                  _gambarBoh.removeAt(index);
                                                  _gambarBoh.insert(index, false);
                                                });
                                              },
                                              child: Icon(Icons.note_add,
                                                  color: BohNote[
                                                  index] ==
                                                      null
                                                      ? Colors.grey
                                                      : AbubaPallate
                                                      .menuBluebird),
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
                                        crossAxisCount: 2,
                                        childAspectRatio: 1.0,
                                        mainAxisSpacing: 4.0,
                                        crossAxisSpacing: 4.0,
                                        shrinkWrap: true,
                                        children: <Widget>[
                                          GridTile(
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(context, MyCustomRoute(builder: (context) => DetailScreenBoh(image: imageBoh[index])));
                                                },
                                                child: Image.network(
                                                  imageBoh[index].toString(),
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                          ),
                                        ]
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
                            child: Text(
                              'Warehouse',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                color: widget.hasilWarehouse * 100 > 85.0
                                    ? Colors.green
                                    : widget.hasilWarehouse * 100 < 70.0
                                    ? Colors.redAccent
                                    : Colors.orangeAccent,
                              ),
                            ),
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
                            percent: widget.hasilWarehouse * 100 > 100.0
                                ? 1.0
                                : widget.hasilWarehouse,
                            center: Text(widget.hasilWarehouse * 100 >=
                                100.0
                                ? '100%'
                                : '${(widget.hasilWarehouse * 100).toString().substring(0, 2)}%'),
                            animationDuration: 1000,
                            linearStrokeCap: LinearStrokeCap.butt,
                            progressColor:
                            widget.hasilWarehouse * 100 > 85.0
                                ? Colors.green
                                : widget.hasilWarehouse * 100 < 70.0
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
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  var bantuGambarWarehouse = _gambarWarehouse[index];
                                                  _gambarWarehouse.removeAt(index);
                                                  _gambarWarehouse.insert(index, !bantuGambarWarehouse);
                                                  _catatanWarehouse.removeAt(index);
                                                  _catatanWarehouse.insert(index, false);
                                                });
                                              },
                                              child: Icon(Icons.image, color: imageWarehouse[index] == null ? Colors.grey : AbubaPallate.menuBluebird),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  var bantuCatatanWareHouse = _catatanWarehouse[index];
                                                  _catatanWarehouse.removeAt(index);
                                                  _catatanWarehouse.insert(index, !bantuCatatanWareHouse);
                                                  _gambarWarehouse.removeAt(index);
                                                  _gambarWarehouse.insert(index, false);
                                                });
                                              },
                                              child: Icon(Icons.note_add,
                                                  color: WarehouseNote[
                                                  index] ==
                                                      null
                                                      ? Colors.grey
                                                      : AbubaPallate
                                                      .menuBluebird),
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
                                        crossAxisCount: 2,
                                        childAspectRatio: 1.0,
                                        mainAxisSpacing: 4.0,
                                        crossAxisSpacing: 4.0,
                                        shrinkWrap: true,
                                        children: <Widget>[
                                          GridTile(
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(context, MyCustomRoute(builder: (context) => DetailScreenWarehouse(image: imageWarehouse[index])));
                                                },
                                                child: Image.network(
                                                  imageWarehouse[index].toString(),
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                          ),
                                        ]
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
                            child: Text(
                              'Social Block',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                color: widget.hasilSocialBlock * 100 >
                                    85.0
                                    ? Colors.green
                                    : widget.hasilSocialBlock * 100 < 70.0
                                    ? Colors.redAccent
                                    : Colors.orangeAccent,
                              ),
                            ),
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
                            percent: widget.hasilSocialBlock * 100 > 100.0
                                ? 1.0
                                : widget.hasilSocialBlock,
                            center: Text(widget.hasilSocialBlock * 100 >=
                                100.0
                                ? '100%'
                                : '${(widget.hasilSocialBlock * 100).toString().substring(0, 2)}%'),
                            animationDuration: 1000,
                            linearStrokeCap: LinearStrokeCap.butt,
                            progressColor:
                            widget.hasilSocialBlock * 100 > 85.0
                                ? Colors.green
                                : widget.hasilSocialBlock * 100 < 70.0
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
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  var bantuGambarSocialBlock = _gambarSocialBlock[index];
                                                  _gambarSocialBlock.removeAt(index);
                                                  _gambarSocialBlock.insert(index, !bantuGambarSocialBlock);
                                                  _catatanSocialBlock.removeAt(index);
                                                  _catatanSocialBlock.insert(index, false);
                                                });
                                              },
                                              child: Icon(Icons.image, color: imageSocialBlock[index] == null ? Colors.grey : AbubaPallate.menuBluebird),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  var bantuCatatanSocialBlock = _catatanSocialBlock[index];
                                                  _catatanSocialBlock.removeAt(index);
                                                  _catatanSocialBlock.insert(index, !bantuCatatanSocialBlock);
                                                  _gambarSocialBlock.removeAt(index);
                                                  _gambarSocialBlock.insert(index, false);
                                                });
                                              },
                                              child: Icon(Icons.note_add,
                                                  color: SocialBlockNote[
                                                  index] ==
                                                      null
                                                      ? Colors.grey
                                                      : AbubaPallate
                                                      .menuBluebird),
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
                                        crossAxisCount: 2,
                                        childAspectRatio: 1.0,
                                        mainAxisSpacing: 4.0,
                                        crossAxisSpacing: 4.0,
                                        shrinkWrap: true,
                                        children: <Widget>[
                                          GridTile(
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(context, MyCustomRoute(builder: (context) => DetailScreenSocialBlock(image: imageSocialBlock[index])));
                                                },
                                                child: Image.network(
                                                  imageSocialBlock[index].toString(),
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                          ),
                                        ]
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
                            child: Text(
                              'Personal Hygiene',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                color: widget.hasilPersonal * 100 > 85.0
                                    ? Colors.green
                                    : widget.hasilPersonal * 100 < 70.0
                                    ? Colors.redAccent
                                    : Colors.orangeAccent,
                              ),
                            ),
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
                            percent: widget.hasilPersonal * 100 > 100.0
                                ? 1.0
                                : widget.hasilPersonal,
                            center: Text(widget.hasilPersonal * 100 >=
                                100.0
                                ? '100%'
                                : '${(widget.hasilPersonal * 100).toString().substring(0, 2)}%'),
                            animationDuration: 1000,
                            linearStrokeCap: LinearStrokeCap.butt,
                            progressColor:
                            widget.hasilPersonal * 100 > 85.0
                                ? Colors.green
                                : widget.hasilPersonal * 100 < 70.0
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
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  var bantuGambarPersonal = _gambarPersonal[index];
                                                  _gambarPersonal.removeAt(index);
                                                  _gambarPersonal.insert(index, !bantuGambarPersonal);
                                                  _catatanPersonal.removeAt(index);
                                                  _catatanPersonal.insert(index, false);
                                                });
                                              },
                                              child: Icon(Icons.image, color: imagePersonal[index] == null ? Colors.grey : AbubaPallate.menuBluebird),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  var bantuCatatanPersonal = _catatanPersonal[index];
                                                  _catatanPersonal.removeAt(index);
                                                  _catatanPersonal.insert(index, !bantuCatatanPersonal);
                                                  _gambarPersonal.removeAt(index);
                                                  _gambarPersonal.insert(index, false);
                                                });
                                              },
                                              child: Icon(Icons.note_add,
                                                  color: PersonalNote[
                                                  index] ==
                                                      null
                                                      ? Colors.grey
                                                      : AbubaPallate
                                                      .menuBluebird),
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
                                        crossAxisCount: 2,
                                        childAspectRatio: 1.0,
                                        mainAxisSpacing: 4.0,
                                        crossAxisSpacing: 4.0,
                                        shrinkWrap: true,
                                        children: <Widget>[
                                          GridTile(
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(context, MyCustomRoute(builder: (context) => DetailScreenPersonal(image: imagePersonal[index])));
                                                },
                                                child: Image.network(
                                                  imagePersonal[index].toString(),
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                          ),
                                        ]
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
                            child: Text(
                              'Food Completely Cooked',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                color: widget.hasilFoodCooked * 100 > 85.0
                                    ? Colors.green
                                    : widget.hasilFoodCooked * 100 < 70.0
                                    ? Colors.redAccent
                                    : Colors.orangeAccent,
                              ),
                            ),
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
                            percent: widget.hasilFoodCooked * 100 > 100.0
                                ? 1.0
                                : widget.hasilFoodCooked,
                            center: Text(widget.hasilFoodCooked * 100 >=
                                100.0
                                ? '100%'
                                : '${(widget.hasilFoodCooked * 100).toString().substring(0, 2)}%'),
                            animationDuration: 1000,
                            linearStrokeCap: LinearStrokeCap.butt,
                            progressColor:
                            widget.hasilFoodCooked * 100 > 85.0
                                ? Colors.green
                                : widget.hasilFoodCooked * 100 < 70.0
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
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  var bantuGambarFood = _gambarFoodCooked[index];
                                                  _gambarFoodCooked.removeAt(index);
                                                  _gambarFoodCooked.insert(index, !bantuGambarFood);
                                                  _catatanFoodCooked.removeAt(index);
                                                  _catatanFoodCooked.insert(index, false);
                                                });
                                              },
                                              child: Icon(Icons.image, color: imageFoodCooked[index] == null ? Colors.grey : AbubaPallate.menuBluebird),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  var bantuCatatanFood = _catatanFoodCooked[index];
                                                  _catatanFoodCooked.removeAt(index);
                                                  _catatanFoodCooked.insert(index, !bantuCatatanFood);
                                                  _gambarFoodCooked.removeAt(index);
                                                  _gambarFoodCooked.insert(index, false);
                                                });
                                              },
                                              child: Icon(Icons.note_add,
                                                  color: FoodCookedNote[
                                                  index] ==
                                                      null
                                                      ? Colors.grey
                                                      : AbubaPallate
                                                      .menuBluebird),
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
                                        crossAxisCount: 2,
                                        childAspectRatio: 1.0,
                                        mainAxisSpacing: 4.0,
                                        crossAxisSpacing: 4.0,
                                        shrinkWrap: true,
                                        children: <Widget>[
                                          GridTile(
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(context, MyCustomRoute(builder: (context) => DetailScreenFoodCooked(image: imageFoodCooked[index])));
                                                },
                                                child: Image.network(
                                                  imageFoodCooked[index].toString(),
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                          ),
                                        ]
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