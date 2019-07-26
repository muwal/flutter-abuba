import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_abuba/isoft/operation_page/internalaudit/detail_assets.dart';
import 'package:flutter_abuba/isoft/operation_page/internalaudit/detail_cash.dart';
import 'package:flutter_abuba/isoft/operation_page/internalaudit/detail_equipment.dart';
import 'package:flutter_abuba/isoft/operation_page/internalaudit/detail_inventory.dart';
import 'package:flutter_abuba/isoft/operation_page/internalaudit/form_jadwal_start.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FormAudit extends StatefulWidget {
  var index;
  final int idUser;
  final String namaUser;
  final String departmentUser;
  List<dynamic> subArea;
  List<dynamic> auditor;
  FormAudit({this.idUser, this.namaUser, this.departmentUser, this.index, this.subArea, this.auditor});

  @override
  _FormAuditState createState() => _FormAuditState();
}

class _FormAuditState extends State<FormAudit> with TickerProviderStateMixin {
  AnimationController animationController;

  double hasilGrafik = 0.0;
  double finalBantu = 0.0;
  double FixAreaLuar = 0.0;
  int nilai_cp = 0;

  DateTime timeStart;
  DateTime done;

  int jumlahCriticalPoint = 0;

  int indexAreaLuar = 0;
  int jumlahAreaLuar = 0;
  List<int> scoreAreaLuar = [];
  List<String> jawabanSplitAreaLuar;
  List<dynamic> jawabanSplitAreaLuarBantu = [];
  List<String> warnaAreaLuar = [];
  List<String> noteAreaLuar = [];
  int parameterAreaLuar = 0;
  List<dynamic> bobotPertanyaanAreaLuar;
  List<dynamic> bobotAreaLuar = [];
  List<dynamic> jmlAreaLuar = [];
  List<dynamic> criticalAreaLuar = [];
  List<dynamic> systemAreaLuar = [];
  double hasilAreaLuar = 0.0;
  double finalAreaLuar = 0.0;
  double bobotBantuAreaLuar = 0.0;
  TextEditingController _controllerAreaLuar = TextEditingController();
  List<dynamic> pertanyaanAreaLuar = [];
  List<String> imageAreaLuar = [];
  List<File> imageAreaLuarBantu = [];
  File imageAreaLuar1;
  String filenameAreaLuar1;
  List<String> imageAreaLuarSave = [];

  int indexDinningArea = 0;
  int jumlahDinningArea = 0;
  List<int> scoreDinningArea = [];
  List<String> jawabanSplitDinningArea;
  List<dynamic> jawabanSplitDinningAreaBantu = [];
  List<String> warnaDinningArea = [];
  List<String> noteDinningArea = [];
  int parameterDinningArea = 0;
  List<dynamic> bobotPertanyaanDinningArea;
  List<dynamic> bobotDinningArea = [];
  List<dynamic> jmlDinningArea = [];
  List<dynamic> criticalDinningArea = [];
  List<dynamic> systemDinningArea = [];
  double hasilDinningArea = 0.0;
  double finalDinningArea = 0.0;
  double bobotBantuDinningArea = 0.0;
  TextEditingController _controllerDinningArea = TextEditingController();
  List<dynamic> pertanyaanDinningArea = [];
  List<String> imageDinningArea = [];
  List<File> imageDinningAreaBantu = [];
  File imageDinningArea1;
  String filenameDinningArea1;
  List<String> imageDinningAreaSave = [];

  int indexService = 0;
  int jumlahService = 0;
  List<int> scoreService = [];
  List<String> jawabanSplitService;
  List<dynamic> jawabanSplitServiceBantu = [];
  List<String> warnaService = [];
  List<String> noteService = [];
  int parameterService = 0;
  List<dynamic> bobotPertanyaanService;
  List<dynamic> bobotService = [];
  List<dynamic> jmlService = [];
  List<dynamic> criticalService = [];
  List<dynamic> systemService = [];
  double hasilService = 0.0;
  double finalService = 0.0;
  double bobotBantuService = 0.0;
  TextEditingController _controllerService = TextEditingController();
  List<dynamic> pertanyaanService = [];
  List<String> imageService = [];
  List<File> imageServiceBantu = [];
  File imageService1;
  String filenameService1;
  List<String> imageServiceSave = [];

  int indexCashier = 0;
  int jumlahCashier = 0;
  List<int> scoreCashier = [];
  List<String> jawabanSplitCashier;
  List<dynamic> jawabanSplitCashierBantu = [];
  List<String> warnaCashier = [];
  List<String> noteCashier = [];
  int parameterCashier = 0;
  List<dynamic> bobotPertanyaanCashier;
  List<dynamic> bobotCashier = [];
  List<dynamic> jmlCashier = [];
  List<dynamic> criticalCashier = [];
  List<dynamic> systemCashier = [];
  double hasilCashier = 0.0;
  double finalCashier = 0.0;
  double bobotBantuCashier = 0.0;
  TextEditingController _controllerCashier = TextEditingController();
  List<dynamic> pertanyaanCashier = [];
  List<String> imageCashier = [];
  List<File> imageCashierBantu = [];
  File imageCashier1;
  String filenameCashier1;
  List<String> imageCashierSave = [];

  int indexCashierAccuracy = 0;
  int jumlahCashierAccuracy = 0;
  List<int> scoreCashierAccuracy = [];
  List<String> jawabanSplitCashierAccuracy;
  List<dynamic> jawabanSplitCashierAccuracyBantu = [];
  List<String> warnaCashierAccuracy = [];
  List<String> noteCashierAccuracy = [];
  int parameterCashierAccuracy = 0;
  List<dynamic> bobotPertanyaanCashierAccuracy;
  List<dynamic> bobotCashierAccuracy = [];
  List<dynamic> jmlCashierAccuracy = [];
  List<dynamic> criticalCashierAccuracy = [];
  List<dynamic> systemCashierAccuracy = [];
  double hasilCashierAccuracy = 0.0;
  double finalCashierAccuracy = 0.0;
  double bobotBantuCashierAccuracy = 0.0;
  TextEditingController _controllerCashierAccuracy = TextEditingController();
  List<dynamic> pertanyaanCashierAccuracy = [];
  List<String> imageCashierAccuracy = [];
  List<File> imageCashierAccuracyBantu = [];
  File imageCashierAccuracy1;
  String filenameCashierAccuracy1;
  List<String> imageCashierAccuracySave = [];

  int indexBoh = 0;
  int jumlahBoh = 0;
  List<int> scoreBoh = [];
  List<String> jawabanSplitBoh;
  List<dynamic> jawabanSplitBohBantu = [];
  List<String> warnaBoh = [];
  List<String> noteBoh = [];
  int parameterBoh = 0;
  List<dynamic> bobotPertanyaanBoh;
  List<dynamic> bobotBoh = [];
  List<dynamic> jmlBoh = [];
  List<dynamic> criticalBoh = [];
  List<dynamic> systemBoh = [];
  double hasilBoh = 0.0;
  double finalBoh = 0.0;
  double bobotBantuBoh = 0.0;
  TextEditingController _controllerBoh = TextEditingController();
  List<dynamic> pertanyaanBoh = [];
  List<String> imageBoh = [];
  List<File> imageBohBantu = [];
  File imageBoh1;
  String filenameBoh1;
  List<String> imageBohSave = [];

  int indexWarehouse = 0;
  int jumlahWarehouse = 0;
  List<int> scoreWarehouse = [];
  List<String> jawabanSplitWarehouse;
  List<dynamic> jawabanSplitWarehouseBantu = [];
  List<String> warnaWarehouse = [];
  List<String> noteWarehouse = [];
  int parameterWarehouse = 0;
  List<dynamic> bobotPertanyaanWarehouse;
  List<dynamic> bobotWarehouse = [];
  List<dynamic> jmlWarehouse = [];
  List<dynamic> criticalWarehouse = [];
  List<dynamic> systemWarehouse = [];
  double hasilWarehouse = 0.0;
  double finalWarehouse = 0.0;
  double bobotBantuWarehouse = 0.0;
  TextEditingController _controllerWarehouse = TextEditingController();
  List<dynamic> pertanyaanWarehouse = [];
  List<String> imageWarehouse = [];
  List<File> imageWarehouseBantu = [];
  File imageWarehouse1;
  String filenameWarehouse1;
  List<String> imageWarehouseSave = [];

  int indexSocialBlock = 0;
  int jumlahSocialBlock = 0;
  List<int> scoreSocialBlock = [];
  List<String> jawabanSplitSocialBlock;
  List<dynamic> jawabanSplitSocialBlockBantu = [];
  List<String> warnaSocialBlock = [];
  List<String> noteSocialBlock = [];
  int parameterSocialBlock = 0;
  List<dynamic> bobotPertanyaanSocialBlock;
  List<dynamic> bobotSocialBlock = [];
  List<dynamic> jmlSocialBlock = [];
  List<dynamic> criticalSocialBlock = [];
  List<dynamic> systemSocialBlock = [];
  double hasilSocialBlock = 0.0;
  double finalSocialBlock = 0.0;
  double bobotBantuSocialBlock = 0.0;
  TextEditingController _controllerSocialBlock = TextEditingController();
  List<dynamic> pertanyaanSocialBlock = [];
  List<String> imageSocialBlock = [];
  List<File> imageSocialBlockBantu = [];
  File imageSocialBlock1;
  String filenameSocialBlock1;
  List<String> imageSocialBlockSave = [];

  int indexPersonal = 0;
  int jumlahPersonal = 0;
  List<int> scorePersonal = [];
  List<String> jawabanSplitPersonal;
  List<dynamic> jawabanSplitPersonalBantu = [];
  List<String> warnaPersonal = [];
  List<String> notePersonal = [];
  int parameterPersonal = 0;
  List<dynamic> bobotPertanyaanPersonal;
  List<dynamic> bobotPersonal = [];
  List<dynamic> jmlPersonal = [];
  List<dynamic> criticalPersonal = [];
  List<dynamic> systemPersonal = [];
  double hasilPersonal = 0.0;
  double finalPersonal = 0.0;
  double bobotBantuPersonal = 0.0;
  TextEditingController _controllerPersonal = TextEditingController();
  List<dynamic> pertanyaanPersonal = [];
  List<String> imagePersonal = [];
  List<File> imagePersonalBantu = [];
  File imagePersonal1;
  String filenamePersonal1;
  List<String> imagePersonalSave = [];

  int indexFoodCooked = 0;
  int jumlahFoodCooked = 0;
  List<int> scoreFoodCooked = [];
  List<String> jawabanSplitFoodCooked;
  List<dynamic> jawabanSplitFoodCookedBantu = [];
  List<String> warnaFoodCooked = [];
  List<String> noteFoodCooked = [];
  int parameterFoodCooked = 0;
  List<dynamic> bobotPertanyaanFoodCooked;
  List<dynamic> bobotFoodCooked = [];
  List<dynamic> jmlFoodCooked = [];
  List<dynamic> criticalFoodCooked = [];
  List<dynamic> systemFoodCooked = [];
  double hasilFoodCooked = 0.0;
  double finalFoodCooked = 0.0;
  double bobotBantuFoodCooked = 0.0;
  TextEditingController _controllerFoodCooked = TextEditingController();
  List<dynamic> pertanyaanFoodCooked = [];
  List<String> imageFoodCooked = [];
  List<File> imageFoodCookedBantu = [];
  File imageFoodCooked1;
  String filenameFoodCooked1;
  List<String> imageFoodCookedSave = [];

  TextEditingController _controllerNote = TextEditingController();
  List<dynamic> testing = [];

  bool _answer0 = false;
  Color _answer0Color = Colors.grey;
  bool _answer1 = false;
  Color _answer1Color = Colors.grey;
  bool _answer2 = false;
  Color _answer2Color = Colors.grey;

  List<Map> _listData = [
    {'nomor': '1'},
    {'nomor': '2'},
    {'nomor': '3'},
    {'nomor': '4'},
    {'nomor': '5'},
    {'nomor': '6'},
    {'nomor': '7'},
    {'nomor': '8'},
    {'nomor': '9'},
    {'nomor': '10'},
  ];

  List<String> auditorName = [];
  bool isProcess = false;

  List<dynamic> problemFS = [];
  List<dynamic> areaFS = [];
  List<dynamic> auditorFS = [];
  List<dynamic> auditorIDFS = [];
  List<dynamic> criticalFS = [];
  List<dynamic> subBabFS = [];
  List<dynamic> rekomendasiFS = [];
  List<dynamic> carNoFS = [];
  int categoryFS;
  DateTime whenFS;
  int departmentIDFS;
  String departmentNameFS;
  String divisiFS;

  List<dynamic> templateCount = [];

  Future<bool> onWillPop(context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => new AlertDialog(
        title: new Text('Kembali ke menu sebelumnya ?'),
        content: new Text('Semua progres pada halaman ini akan hilang'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('Cancel'),
          ),
          new FlatButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigator.pushReplacement(context,
              //   MaterialPageRoute(
              //     builder: (_) => StartAudit(departmentUser: widget.departmentUser, idUser: widget.idUser, namaUser: widget.namaUser)
              //   )
              // );
            },
            child: new Text('Ya'),
          ),
        ],
      ),
    ).whenComplete(() {
      Navigator.pop(context);
    });
  }

  @override
  void initState() {
    _cardController = new TabController(vsync: this, length: 10);

    Firestore.instance.collection('correctiveAction_category').where('category', isEqualTo: 'Internal Audit').snapshots().listen((dataIA) {
      setState(() {
        categoryFS = dataIA.documents[0].data['id'];
      });
    });

    Firestore.instance.collection('audit_internal').document(widget.index).snapshots().listen((dataAI) {
      Firestore.instance.collection('user').where('id', isEqualTo: dataAI.data['auditee']).snapshots().listen((dataAuditeeName) {
        Firestore.instance.collection('department').where('id', isEqualTo: dataAuditeeName.documents[0].data['departmentID']).snapshots().listen((dataDepartmentName) {
          setState(() {
            departmentIDFS = dataAuditeeName.documents[0].data['departmentID'];
            departmentNameFS = dataDepartmentName.documents[0].data['name'];
            // divisiFS = dataAuditeeName.documents[0].data['divisi'];
          });
        });
      });
    });

    for (int abc = 0; abc < widget.auditor.length; abc++) {
      Firestore.instance.collection('user').where('id', isEqualTo: int.tryParse(widget.auditor[abc].toString())).snapshots().listen((dataAuditor) {
        setState(() {
          auditorName.add(dataAuditor.documents[0].data['nama']);
        });
      });
    }
    setState(() {
      Firestore.instance.collection('area_luar').snapshots().listen((data) {
        jmlAreaLuar = data.documents[0].data['pertanyaan'];
        parameterAreaLuar = data.documents[0].data['bobot'];
        bobotPertanyaanAreaLuar = data.documents[0].data['bobot_pertanyaan'];
        criticalAreaLuar = data.documents[0].data['critical_point'];
        systemAreaLuar = data.documents[0].data['integrated_system'];

        jumlahAreaLuar = data.documents[0].data['pertanyaan'].length;
        jawabanSplitAreaLuarBantu = data.documents[0].data['jawaban'];
        pertanyaanAreaLuar = data.documents[0].data['pertanyaan'];
      });

      Firestore.instance.collection('dinning_area').snapshots().listen((data) {
        jmlDinningArea = data.documents[0].data['pertanyaan'];
        parameterDinningArea = data.documents[0].data['bobot'];
        bobotPertanyaanDinningArea = data.documents[0].data['bobot_pertanyaan'];
        criticalDinningArea = data.documents[0].data['critical_point'];
        systemDinningArea = data.documents[0].data['integrated_system'];

        jumlahDinningArea = data.documents[0].data['pertanyaan'].length;
        jawabanSplitDinningAreaBantu = data.documents[0].data['jawaban'];
        pertanyaanDinningArea = data.documents[0].data['pertanyaan'];
      });

      Firestore.instance.collection('service').snapshots().listen((data) {
        jmlService = data.documents[0].data['pertanyaan'];
        parameterService = data.documents[0].data['bobot'];
        bobotPertanyaanService = data.documents[0].data['bobot_pertanyaan'];
        criticalService = data.documents[0].data['critical_point'];
        systemService = data.documents[0].data['integrated_system'];

        jumlahService = data.documents[0].data['pertanyaan'].length;
        jawabanSplitServiceBantu = data.documents[0].data['jawaban'];
        pertanyaanService = data.documents[0].data['pertanyaan'];
      });

      Firestore.instance.collection('cashier').snapshots().listen((data) {
        jmlCashier = data.documents[0].data['pertanyaan'];
        parameterCashier = data.documents[0].data['bobot'];
        bobotPertanyaanCashier = data.documents[0].data['bobot_pertanyaan'];
        criticalCashier = data.documents[0].data['critical_point'];
        systemCashier = data.documents[0].data['integrated_system'];

        jumlahCashier = data.documents[0].data['pertanyaan'].length;
        jawabanSplitCashierBantu = data.documents[0].data['jawaban'];
        pertanyaanCashier = data.documents[0].data['pertanyaan'];
      });

      Firestore.instance.collection('cashier_accuracy').snapshots().listen((data) {
        jmlCashierAccuracy = data.documents[0].data['pertanyaan'];
        parameterCashierAccuracy = data.documents[0].data['bobot'];
        bobotPertanyaanCashierAccuracy =
        data.documents[0].data['bobot_pertanyaan'];
        criticalCashierAccuracy = data.documents[0].data['critical_point'];
        systemCashierAccuracy = data.documents[0].data['integrated_system'];

        jumlahCashierAccuracy = data.documents[0].data['pertanyaan'].length;
        jawabanSplitCashierAccuracyBantu = data.documents[0].data['jawaban'];
        pertanyaanCashierAccuracy = data.documents[0].data['pertanyaan'];

        templateCount = data.documents[0].data['templateCount'];
      });

      Firestore.instance.collection('boh').snapshots().listen((data) {
        jmlBoh = data.documents[0].data['pertanyaan'];
        parameterBoh = data.documents[0].data['bobot'];
        bobotPertanyaanBoh = data.documents[0].data['bobot_pertanyaan'];
        criticalBoh = data.documents[0].data['critical_point'];
        systemBoh = data.documents[0].data['integrated_system'];

        jumlahBoh = data.documents[0].data['pertanyaan'].length;
        jawabanSplitBohBantu = data.documents[0].data['jawaban'];
        pertanyaanBoh = data.documents[0].data['pertanyaan'];
      });

      Firestore.instance.collection('warehouse').snapshots().listen((data) {
        jmlWarehouse = data.documents[0].data['pertanyaan'];
        parameterWarehouse = data.documents[0].data['bobot'];
        bobotPertanyaanWarehouse = data.documents[0].data['bobot_pertanyaan'];
        criticalWarehouse = data.documents[0].data['critical_point'];
        systemWarehouse = data.documents[0].data['integrated_system'];

        jumlahWarehouse = data.documents[0].data['pertanyaan'].length;
        jawabanSplitWarehouseBantu = data.documents[0].data['jawaban'];
        pertanyaanWarehouse = data.documents[0].data['pertanyaan'];
      });

      Firestore.instance.collection('social_block').snapshots().listen((data) {
        jmlSocialBlock = data.documents[0].data['pertanyaan'];
        parameterSocialBlock = data.documents[0].data['bobot'];
        bobotPertanyaanSocialBlock = data.documents[0].data['bobot_pertanyaan'];
        criticalSocialBlock = data.documents[0].data['critical_point'];
        systemSocialBlock = data.documents[0].data['integrated_system'];

        jumlahSocialBlock = data.documents[0].data['pertanyaan'].length;
        jawabanSplitSocialBlockBantu = data.documents[0].data['jawaban'];
        pertanyaanSocialBlock = data.documents[0].data['pertanyaan'];
      });

      Firestore.instance
          .collection('personal_hygiene')
          .snapshots()
          .listen((data) {
        jmlPersonal = data.documents[0].data['pertanyaan'];
        parameterPersonal = data.documents[0].data['bobot'];
        bobotPertanyaanPersonal = data.documents[0].data['bobot_pertanyaan'];
        criticalPersonal = data.documents[0].data['critical_point'];
        systemPersonal = data.documents[0].data['integrated_system'];

        jumlahPersonal = data.documents[0].data['pertanyaan'].length;
        jawabanSplitPersonalBantu = data.documents[0].data['jawaban'];
        pertanyaanPersonal = data.documents[0].data['pertanyaan'];
      });

      Firestore.instance.collection('food_cooked').snapshots().listen((data) {
        jmlFoodCooked = data.documents[0].data['pertanyaan'];
        parameterFoodCooked = data.documents[0].data['bobot'];
        bobotPertanyaanFoodCooked = data.documents[0].data['bobot_pertanyaan'];
        criticalFoodCooked = data.documents[0].data['critical_point'];
        systemFoodCooked = data.documents[0].data['integrated_system'];

        jumlahFoodCooked = data.documents[0].data['pertanyaan'].length;
        jawabanSplitFoodCookedBantu = data.documents[0].data['jawaban'];
        pertanyaanFoodCooked = data.documents[0].data['pertanyaan'];
      });
    });

    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(
        from:
        animationController.value == 0.0 ? 1.0 : animationController.value);
  }

  TabController _cardController;

  @override
  void dispose() {
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          onWillPop(context);
        },
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
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                onWillPop(context);
              }
            ),
          ),
          backgroundColor: Colors.white,
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: _buildFormMenu(context)
          ),
        ),
      ),
    );
  }

  Widget _buildFormMenu(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: TabBarView(
              controller: _cardController,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                // sini area luar 
                  ListView(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      children: <Widget>[
                        PreferredSize(
                          preferredSize: Size.fromHeight(55.0),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 55.0,
                                child: Container(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.75,
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                text: TextSpan(
                                                  text: 'Area Luar',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17.0
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.75,
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                text: TextSpan(
                                                  text: 'Auditor : ${auditorName[0].toString()}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11.0
                                                  ),
                                                ),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '1 of ${_listData.length.toString()}',
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 14.0),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF2F592F),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        AnimatedBuilder(
                          animation: animationController,
                          builder: (_, Widget child) {
                            return animationController.isAnimating
                              ? Center(
                                  child: Container(
                                    child: CircularProgressIndicator(),
                                    alignment: Alignment(0.0, 0.0),
                                    height: MediaQuery.of(context).size.height * 0.736,
                                  ),
                                )
                              : Container(
                              height: MediaQuery.of(context).size.height * 0.736,
                              color: Colors.white,
                              child: Scrollbar(
                                child: ListView(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  children: List.generate(jmlAreaLuar.length, (index) {
                                    indexAreaLuar = index;
                                    jawabanSplitAreaLuar = jawabanSplitAreaLuarBantu[index].split(r"!@#$");
                                    if (scoreAreaLuar.length < jumlahAreaLuar) {
                                      for (int a = 0; a < jumlahAreaLuar; a++) {
                                        scoreAreaLuar.add(null);
                                        noteAreaLuar.add(null);
                                        imageAreaLuar.add(null);
                                        imageAreaLuarBantu.add(null);
                                        imageAreaLuarSave.add(null);

                                        warnaAreaLuar.add('abu');
                                      }
                                    }

                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        criticalAreaLuar[index] == 'false'
                                          ? Padding(
                                              padding: EdgeInsets.only(right: 15.0, left: 15.0, bottom: 8.0, top: 8.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      systemAreaLuar[index],
                                                      style: TextStyle(
                                                        color: Colors.green,
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 16.0
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Padding(
                                              padding: EdgeInsets.only(right: 15.0,left: 15.0,bottom: 8.0,top: 8.0),
                                              child: Row(
                                                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      systemAreaLuar[index],
                                                      style: TextStyle(
                                                        color: Colors.green,
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 16.0
                                                      ),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      'CRITICAL',
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 16.0
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsets.only(right: 15.0,left: 15.0,top: 10.0,bottom: 50.0),
                                                  child: Text(
                                                    jmlAreaLuar[index],
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20.0
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          widget.subArea.contains('Area Luar')
                                            ? Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                                child: Row(
                                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    jawabanSplitAreaLuar[0] == 'null'
                                                      ? Container()
                                                      : Tooltip(
                                                          message:
                                                          jawabanSplitAreaLuar == null
                                                            ? ''
                                                            : jawabanSplitAreaLuar[0],
                                                          preferBelow: false,
                                                          child: Container(
                                                            child: ButtonTheme(
                                                              minWidth: 50.0,
                                                              height: 50.0,
                                                              child:
                                                              RaisedButton(
                                                                shape:
                                                                new RoundedRectangleBorder(
                                                                  borderRadius:new BorderRadius.circular(5.0),
                                                                  side:
                                                                  BorderSide(
                                                                    width: 1.5,
                                                                    color: warnaAreaLuar.length == 0
                                                                      ? Color.fromARGB(170,192,192,192)
                                                                      : warnaAreaLuar[index] == 'merah'
                                                                          ? Colors.white
                                                                          : Color.fromARGB(170,192,192,192
                                                                    ),
                                                                  ),
                                                                ),
                                                                child: Text(
                                                                  '0',
                                                                  style:
                                                                  TextStyle(
                                                                    fontSize:18.0,
                                                                    color: warnaAreaLuar.length == 0
                                                                      ? Color.fromARGB(170,255,40,0)
                                                                      : warnaAreaLuar[index] == 'merah'
                                                                          ? Colors.white
                                                                          : Color.fromARGB(170,255,40,0),
                                                                  ),
                                                                  textAlign:
                                                                  TextAlign.center,
                                                                ),
                                                                color: warnaAreaLuar.length ==0
                                                                  ? Colors.white
                                                                  : warnaAreaLuar[index] == 'merah'
                                                                      ? Color.fromARGB(170,255,40,0)
                                                                      : Colors.white,
                                                                onPressed: () {
                                                                  setState(() {
                                                                    if (criticalAreaLuar[index] =='false') {
                                                                      print('false');
                                                                    } else if (criticalAreaLuar[index] == 'true') {
                                                                      if (scoreAreaLuar[index] == null) {
                                                                        jumlahCriticalPoint = jumlahCriticalPoint + 1;
                                                                      } else {
                                                                        if (scoreAreaLuar[index] == 2) {
                                                                          jumlahCriticalPoint = jumlahCriticalPoint + 1;
                                                                        } else if (scoreAreaLuar[index] == 0 || scoreAreaLuar[index] == 1) {
                                                                          jumlahCriticalPoint = jumlahCriticalPoint + 0;
                                                                        }
                                                                      }
                                                                    }

                                                                    if (problemFS.length == 0) {
                                                                      problemFS.add(jmlAreaLuar[index]);
                                                                      areaFS.add('Area Luar');
                                                                      auditorFS.add(auditorName[0]);
                                                                      auditorIDFS.add(int.tryParse(widget.auditor[0].toString()));
                                                                      subBabFS.add(systemAreaLuar[index]);
                                                                      criticalFS.add(criticalAreaLuar[index] == 'false' ? 'no' : 'yes');
                                                                      rekomendasiFS.add(null);
                                                                      carNoFS.add(null);
                                                                    } else {
                                                                      if (problemFS.contains(jmlAreaLuar[index])) {
                                                                        
                                                                      } else {
                                                                        problemFS.add(jmlAreaLuar[index]);
                                                                        areaFS.add('Area Luar');
                                                                        auditorFS.add(auditorName[0]);
                                                                        auditorIDFS.add(int.tryParse(widget.auditor[0].toString()));
                                                                        subBabFS.add(systemAreaLuar[index]);
                                                                        criticalFS.add(criticalAreaLuar[index] == 'false' ? 'no' : 'yes');
                                                                        rekomendasiFS.add(null);
                                                                        carNoFS.add(null);
                                                                      }
                                                                    }

                                                                    scoreAreaLuar.removeAt(index);
                                                                    scoreAreaLuar.insert(index,0);
                                                                    warnaAreaLuar.removeAt(index);
                                                                    warnaAreaLuar.insert(index,'merah');
                                                                  });

                                                                  print(problemFS);
                                                                  print(areaFS);
                                                                  print(criticalFS);
                                                                  print(auditorFS);
                                                                  print(subBabFS);
                                                                  
                                                                },
                                                              ),
                                                            ),
                                                            alignment:
                                                            Alignment(0.0, 0.0),
                                                          ),
                                                        ),
                                                    jawabanSplitAreaLuar[1] == 'null'
                                                      ? Container()
                                                      : Tooltip(
                                                      message: jawabanSplitAreaLuar == null
                                                        ? ''
                                                        : jawabanSplitAreaLuar[1],
                                                      preferBelow: false,
                                                      child: Container(
                                                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                                                        child: ButtonTheme(
                                                          minWidth: 50.0,
                                                          height: 50.0,
                                                          child: RaisedButton(
                                                            shape: new RoundedRectangleBorder(
                                                              borderRadius:
                                                              new BorderRadius.circular(5.0),
                                                              side: BorderSide(
                                                                width: 1.5,
                                                                color: warnaAreaLuar.length == 0
                                                                  ? Color.fromARGB(170,192,192,192)
                                                                  : warnaAreaLuar[index] == 'kuning'
                                                                    ? Colors.white
                                                                    : Color.fromARGB(170,192,192,192),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              '1',
                                                              style: TextStyle(
                                                                  fontSize: 18.0,
                                                                  color: warnaAreaLuar.length == 0
                                                                    ? Color.fromARGB(170,247,202,24)
                                                                    : warnaAreaLuar[index] == 'kuning'
                                                                      ? Colors.white
                                                                      : Color.fromARGB(170, 247, 202, 24)),
                                                              textAlign: TextAlign.center,
                                                            ),
                                                            color: warnaAreaLuar.length == 0
                                                              ? Colors.white
                                                              : warnaAreaLuar[index] == 'kuning'
                                                                ? Color.fromARGB(170,247,202,24)
                                                                : Colors.white,
                                                            onPressed: () {
                                                              setState(() {
                                                                if (criticalAreaLuar[index] == 'false') {
                                                                  print('false');
                                                                } else if (criticalAreaLuar[index] == 'true') {
                                                                  if (scoreAreaLuar[index] == null) {
                                                                    jumlahCriticalPoint = jumlahCriticalPoint + 1;
                                                                  } else {
                                                                    if (scoreAreaLuar[index] == 2) {
                                                                      jumlahCriticalPoint = jumlahCriticalPoint + 1;
                                                                    } else if (scoreAreaLuar[index] == 0 || scoreAreaLuar[index] == 1) {
                                                                      jumlahCriticalPoint = jumlahCriticalPoint + 0;
                                                                    }
                                                                  }
                                                                }

                                                                if (problemFS.length == 0) {
                                                                  
                                                                } else {
                                                                  if (problemFS.contains(jmlAreaLuar[index])) {
                                                                    areaFS.removeAt(problemFS.indexWhere((test) => test == jmlAreaLuar[index]));
                                                                    rekomendasiFS.removeAt(problemFS.indexWhere((test) => test == jmlAreaLuar[index]));
                                                                    carNoFS.removeAt(problemFS.indexWhere((test) => test == jmlAreaLuar[index]));
                                                                    auditorFS.removeAt(problemFS.indexWhere((test) => test == jmlAreaLuar[index]));
                                                                    auditorIDFS.removeAt(problemFS.indexWhere((test) => test == jmlAreaLuar[index]));
                                                                    criticalFS.removeAt(problemFS.indexWhere((test) => test == jmlAreaLuar[index]));
                                                                    subBabFS.removeAt(problemFS.indexWhere((test) => test == jmlAreaLuar[index]));
                                                                    problemFS.removeAt(problemFS.indexWhere((test) => test == jmlAreaLuar[index]));
                                                                  } else {
                                                                    
                                                                  }
                                                                }

                                                                scoreAreaLuar.removeAt(index);
                                                                scoreAreaLuar.insert(index, 1);
                                                                warnaAreaLuar.removeAt(index);
                                                                warnaAreaLuar.insert(index, 'kuning');
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        alignment: Alignment(0.0, 0.0),
                                                      ),
                                                    ),
                                                    jawabanSplitAreaLuar[2] == 'null'
                                                      ? Container()
                                                      : Tooltip(
                                                          message: jawabanSplitAreaLuar == null
                                                            ? ''
                                                            : jawabanSplitAreaLuar[2],
                                                          preferBelow: false,
                                                          child: Container(
                                                            child: ButtonTheme(
                                                              minWidth: 50.0,
                                                              height: 50.0,
                                                              child: RaisedButton(
                                                              shape: new RoundedRectangleBorder(
                                                                borderRadius: new BorderRadius.circular(5.0),
                                                                side: BorderSide(
                                                                  width: 1.5,
                                                                  color: warnaAreaLuar.length == 0
                                                                    ? Color.fromARGB(170,192,192,192)
                                                                    : warnaAreaLuar[index] == 'hijau'
                                                                      ? Colors.white
                                                                      : Color.fromARGB(170,192,192,192),
                                                                ),
                                                              ),
                                                            child: Text(
                                                              '2',
                                                              style: TextStyle(
                                                                fontSize: 18.0,
                                                                color: warnaAreaLuar.length == 0
                                                                  ? Color.fromARGB(170,50,205,50)
                                                                  : warnaAreaLuar[index] == 'hijau'
                                                                      ? Colors.white
                                                                      : Color.fromARGB(170, 50, 205, 50)),
                                                              textAlign: TextAlign.center,
                                                            ),
                                                            color: warnaAreaLuar.length == 0
                                                              ? Colors.white
                                                              : warnaAreaLuar[index] == 'hijau'
                                                                  ? Color.fromARGB(170,50,205,50)
                                                                  : Colors.white,
                                                            onPressed: () {
                                                              setState(() {
                                                                if (criticalAreaLuar[index] == 'false') {
                                                                  print('false');
                                                                } else if (criticalAreaLuar[index] == 'true') {
                                                                  if (scoreAreaLuar[index] == 2) {
                                                                    jumlahCriticalPoint = jumlahCriticalPoint + 0;
                                                                    print(jumlahCriticalPoint);
                                                                  } else {
                                                                    if (scoreAreaLuar[index] == 2) {
                                                                      jumlahCriticalPoint = jumlahCriticalPoint + 0;
                                                                      print(jumlahCriticalPoint);
                                                                    } else if (scoreAreaLuar[index] == 0 || scoreAreaLuar[index] == 1) {
                                                                      jumlahCriticalPoint = jumlahCriticalPoint - 1;
                                                                      print(jumlahCriticalPoint);
                                                                    }
                                                                  }
                                                                }

                                                                if (problemFS.length == 0) {
                                                                  
                                                                } else {
                                                                  if (problemFS.contains(jmlAreaLuar[index])) {
                                                                    areaFS.removeAt(problemFS.indexWhere((test) => test == jmlAreaLuar[index]));
                                                                    auditorFS.removeAt(problemFS.indexWhere((test) => test == jmlAreaLuar[index]));
                                                                    rekomendasiFS.removeAt(problemFS.indexWhere((test) => test == jmlAreaLuar[index]));
                                                                    carNoFS.removeAt(problemFS.indexWhere((test) => test == jmlAreaLuar[index]));
                                                                    auditorIDFS.removeAt(problemFS.indexWhere((test) => test == jmlAreaLuar[index]));
                                                                    criticalFS.removeAt(problemFS.indexWhere((test) => test == jmlAreaLuar[index]));
                                                                    subBabFS.removeAt(problemFS.indexWhere((test) => test == jmlAreaLuar[index]));
                                                                    problemFS.removeAt(problemFS.indexWhere((test) => test == jmlAreaLuar[index]));
                                                                  } else {
                                                                    
                                                                  }
                                                                }

                                                                scoreAreaLuar.removeAt(index);
                                                                scoreAreaLuar.insert(index, 2);
                                                                warnaAreaLuar.removeAt(index);
                                                                warnaAreaLuar.insert(index, 'hijau');
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        alignment: Alignment(0.0, 0.0),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                          widget.subArea.contains('Area Luar')
                                            ? Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    imageAreaLuar[index] == null
                                                      ? IconButton(
                                                          icon: Icon(Icons.camera_alt, color: AbubaPallate.greenabuba),
                                                          onPressed: () async {
                                                            var selectedImage =
                                                            await ImagePicker.pickImage(source: ImageSource.camera, maxHeight: 400.0, maxWidth: 400.0);
                                                            
                                                            imageAreaLuar1 = selectedImage;
                                                            filenameAreaLuar1 = basename(imageAreaLuar1.path);

                                                            StorageReference strRef = FirebaseStorage.instance.ref().child(filenameAreaLuar1);
                                                            StorageUploadTask uploadTask = strRef.putFile(imageAreaLuar1);

                                                            var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
                                                            var url = downUrl.toString();

                                                            setState(() {
                                                              if (imageAreaLuar[index] != null) {
                                                                List<String> bantuImageAreaLuar = [];
                                                                List<String> bantuImageAreaLuarSave = [];
                                                                bantuImageAreaLuar = imageAreaLuar[index].split('###');
                                                                bantuImageAreaLuar.add(filenameAreaLuar1);
                                                                imageAreaLuar[index] = bantuImageAreaLuar.join('###');

                                                                bantuImageAreaLuarSave = imageAreaLuarSave[index].split('###');
                                                                bantuImageAreaLuarSave.add(url);
                                                                imageAreaLuarSave[index] = bantuImageAreaLuarSave.join('###');
                                                              } else {
                                                                imageAreaLuar[index] = filenameAreaLuar1;
                                                                imageAreaLuarSave[index] = url;
                                                              }
                                                              // imageAreaLuarBantu[index] = imageAreaLuar1;
                                                              print(imageAreaLuar);
                                                              print(imageAreaLuarSave);
                                                              print(imageAreaLuar[index].split('###').length);
                                                              print(imageAreaLuarSave[index].split('###').length);
                                                            });
                                                          },
                                                        )
                                                      : imageAreaLuar[index].split('###').length >= 5
                                                          ? IconButton(
                                                              icon: Icon(Icons.disc_full, color: Colors.grey),
                                                              onPressed: () {},
                                                              tooltip: 'Sudah mencapai batas maksimal 5 foto tiap pertanyaan',
                                                            )
                                                          : IconButton(
                                                              icon: Icon(Icons.camera_alt, color: AbubaPallate.greenabuba),
                                                              onPressed: () async {
                                                                var selectedImage =
                                                                await ImagePicker.pickImage(source: ImageSource.camera, maxHeight: 400.0, maxWidth: 400.0);
                                                                
                                                                imageAreaLuar1 = selectedImage;
                                                                filenameAreaLuar1 = basename(imageAreaLuar1.path);

                                                                StorageReference strRef = FirebaseStorage.instance.ref().child(filenameAreaLuar1);
                                                                StorageUploadTask uploadTask = strRef.putFile(imageAreaLuar1);

                                                                var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
                                                                var url = downUrl.toString();

                                                                setState(() {
                                                                  if (imageAreaLuar[index] != null) {
                                                                    List<String> bantuImageAreaLuar = [];
                                                                    List<String> bantuImageAreaLuarSave = [];
                                                                    bantuImageAreaLuar = imageAreaLuar[index].split('###');
                                                                    bantuImageAreaLuar.add(filenameAreaLuar1);
                                                                    imageAreaLuar[index] = bantuImageAreaLuar.join('###');

                                                                    bantuImageAreaLuarSave = imageAreaLuarSave[index].split('###');
                                                                    bantuImageAreaLuarSave.add(url);
                                                                    imageAreaLuarSave[index] = bantuImageAreaLuarSave.join('###');
                                                                  } else {
                                                                    imageAreaLuar[index] = filenameAreaLuar1;
                                                                    imageAreaLuarSave[index] = url;
                                                                  }
                                                                  // imageAreaLuarBantu[index] = imageAreaLuar1;
                                                                  print(imageAreaLuar);
                                                                  print(imageAreaLuarSave);
                                                                  print(imageAreaLuar[index].split('###').length);
                                                                  print(imageAreaLuarSave[index].split('###').length);
                                                                });
                                                              },
                                                            ),
                                                    IconButton(
                                                      icon: Icon(Icons.event_note,
                                                          color: AbubaPallate
                                                              .greenabuba),
                                                      onPressed: () {
                                                        if (noteAreaLuar[index] ==
                                                            null) {
                                                          _controllerAreaLuar
                                                              .text = '';
                                                        } else {
                                                          _controllerAreaLuar
                                                              .text =
                                                          noteAreaLuar[index];
                                                        }
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              title: Text('NOTE'),
                                                              content: Container(
                                                                width: 300.0,
                                                                child: TextField(
                                                                  controller:
                                                                  _controllerAreaLuar,
                                                                  decoration:
                                                                  InputDecoration(
                                                                    border:
                                                                    OutlineInputBorder(),
                                                                    hintText:
                                                                    'Note',
                                                                    hintStyle: TextStyle(
                                                                        fontSize:
                                                                        12.0),
                                                                  ),
                                                                  maxLines: 3,
                                                                  style:
                                                                  TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                              ),
                                                              actions: <Widget>[
                                                                FlatButton(
                                                                  splashColor: Colors
                                                                      .greenAccent,
                                                                  child: Text(
                                                                    'OK',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .green),
                                                                  ),
                                                                  onPressed: () {
                                                                    noteAreaLuar
                                                                        .removeAt(
                                                                        index);
                                                                    noteAreaLuar.insert(
                                                                        index,
                                                                        _controllerAreaLuar
                                                                            .text);
                                                                    print(
                                                                        noteAreaLuar);
                                                                    Navigator.of(
                                                                        context)
                                                                        .pop();
                                                                  },
                                                                )
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                          Divider(
                                            height: 2.0,
                                          ),
                                        ],
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
                            );
                          },
                        ),
                        PreferredSize(
                          preferredSize: Size.fromHeight(
                              MediaQuery.of(context).size.height -
                                  55.0 -
                                  (MediaQuery.of(context).size.height * 0.7)),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 55.0,
                                child: Container(
                                    child: Padding(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: <Widget>[
                                              IconButton(
                                                icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                                                onPressed: () {
                                                  if (widget.subArea.contains('Area Luar')) {
                                                    if (scoreAreaLuar[indexAreaLuar] == null) {
                                                      showDialog(
                                                        barrierDismissible: false,
                                                        context: context,
                                                        builder: (context) => Dialog(
                                                          child: Container(
                                                            height: 180.0,
                                                            child: Column(
                                                              children: <Widget>[
                                                                Container(
                                                                  color: AbubaPallate.greenabuba,
                                                                  height: 50.0,
                                                                  child: Center(
                                                                    child: Text(
                                                                      'OOPS!',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                          17.0,
                                                                          fontWeight:
                                                                          FontWeight.w700),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 20.0,
                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                      10.0,
                                                                      vertical:
                                                                      10.0),
                                                                  child: Text(
                                                                    'Please select the answer!',
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      16.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                  children: <Widget>[
                                                                    FlatButton(
                                                                      child: Text('OK'),
                                                                      onPressed: () {
                                                                        Navigator.pop(context);
                                                                      },
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      hasilAreaLuar = 0;
                                                      for (int i = 0; i < scoreAreaLuar.length; i++) {
                                                        hasilAreaLuar += double.tryParse(bobotPertanyaanAreaLuar[i].toString()) * double.tryParse(scoreAreaLuar[i].toString());
                                                      }
                                                      hasilAreaLuar = hasilAreaLuar / 2;
                                                      // if (hasilAreaLuar > 1.0) {
                                                      //   hasilAreaLuar = 1.0;
                                                      // } else {
                                                      //   hasilAreaLuar = hasilAreaLuar;
                                                      // }
                                                      // finalAreaLuar = (hasilAreaLuar * parameterAreaLuar) / 100;

                                                      print(bobotPertanyaanAreaLuar);
                                                      print(scoreAreaLuar);
                                                      print((hasilAreaLuar * 100).round().toString());
                                                      // print(finalAreaLuar);
                                                      _cardController.animateTo(_cardController.index + 1);
                                                    }
                                                  } else {
                                                    print(bobotPertanyaanAreaLuar);
                                                    print(scoreAreaLuar);
                                                    print(hasilAreaLuar);
                                                    print(finalAreaLuar);
                                                    _cardController.animateTo(_cardController.index + 1);
                                                  }
                                                },
                                                tooltip: 'Next',
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    decoration:
                                    BoxDecoration(color: Color(0xFF2F592F))),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  // : Container(),
                // sini dinning area
                ListView(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      children: <Widget>[
                        PreferredSize(
                          preferredSize: Size.fromHeight(55.0),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 55.0,
                                child: Container(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.75,
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                text: TextSpan(
                                                  text: 'Dinning Area',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17.0
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.75,
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                text: TextSpan(
                                                  text: 'Auditor : ${auditorName[1].toString()}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11.0
                                                  ),
                                                ),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '2 of ${_listData.length.toString()}',
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 14.0),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF2F592F),
                                  ),
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
                                alignment: Alignment(0.0, 0.0),
                                /*height: MediaQuery.of(context).size.height * 0.648,*/
                                height: MediaQuery.of(context).size.height *
                                    0.736,
                              )
                                  : Container(
                                /*height: MediaQuery.of(context).size.height * 0.648,*/
                                height: MediaQuery.of(context).size.height *
                                    0.736,
                                color: Colors.white,
                                child: Scrollbar(
                                  child: ListView(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    children: List.generate(
                                        jmlDinningArea.length, (index) {
                                      indexDinningArea = index;
                                      jawabanSplitDinningArea =
                                          jawabanSplitDinningAreaBantu[index]
                                              .split(r"!@#$");
                                      if (scoreDinningArea.length <
                                          jumlahDinningArea) {
                                        for (int a = 0;
                                        a < jumlahDinningArea;
                                        a++) {
                                          noteDinningArea.add(null);
                                          scoreDinningArea.add(null);
                                          imageDinningArea.add(null);
                                          imageDinningAreaBantu.add(null);
                                          imageDinningAreaSave.add(null);
                                          warnaDinningArea.add('abu');
                                        }
                                      }

                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          criticalDinningArea[index] ==
                                              'false'
                                              ? Padding(
                                            padding: EdgeInsets.only(
                                                right: 15.0,
                                                left: 15.0,
                                                bottom: 8.0,
                                                top: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    systemDinningArea[
                                                    index],
                                                    style: TextStyle(
                                                        color: Colors
                                                            .green,
                                                        fontWeight:
                                                        FontWeight
                                                            .w700,
                                                        fontSize: 16.0),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                              : Padding(
                                            padding: EdgeInsets.only(
                                                right: 15.0,
                                                left: 15.0,
                                                bottom: 8.0,
                                                top: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    systemDinningArea[
                                                    index],
                                                    style: TextStyle(
                                                        color: Colors
                                                            .green,
                                                        fontWeight:
                                                        FontWeight
                                                            .w700,
                                                        fontSize: 16.0),
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    'CRITICAL',
                                                    style: TextStyle(
                                                        color:
                                                        Colors.red,
                                                        fontWeight:
                                                        FontWeight
                                                            .w700,
                                                        fontSize: 16.0),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 15.0,
                                                      left: 15.0,
                                                      top: 10.0,
                                                      bottom: 50.0),
                                                  child: Text(
                                                    jmlDinningArea[index],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18.0),
                                                    textAlign:
                                                    TextAlign.start,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          widget.subArea.contains('Dinning Area')
                                            ? Padding(
                                                padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 15.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: <Widget>[
                                                    jawabanSplitDinningArea[0] ==
                                                        'null'
                                                        ? Container()
                                                        : Tooltip(
                                                      message:
                                                      jawabanSplitDinningArea ==
                                                          null
                                                          ? ''
                                                          : jawabanSplitDinningArea[
                                                      0],
                                                      preferBelow: false,
                                                      child: Container(
                                                        child: ButtonTheme(
                                                          minWidth: 50.0,
                                                          height: 50.0,
                                                          child:
                                                          RaisedButton(
                                                            shape:
                                                            new RoundedRectangleBorder(
                                                              borderRadius:
                                                              new BorderRadius
                                                                  .circular(
                                                                  5.0),
                                                              side:
                                                              BorderSide(
                                                                width: 1.5,
                                                                color: warnaDinningArea.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    192,
                                                                    192,
                                                                    192)
                                                                    : warnaDinningArea[index] ==
                                                                    'merah'
                                                                    ? Colors
                                                                    .white
                                                                    : Color.fromARGB(
                                                                    170,
                                                                    192,
                                                                    192,
                                                                    192),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              '0',
                                                              style:
                                                              TextStyle(
                                                                fontSize:
                                                                18.0,
                                                                color: warnaDinningArea.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    255,
                                                                    40,
                                                                    0)
                                                                    : warnaDinningArea[index] ==
                                                                    'merah'
                                                                    ? Colors
                                                                    .white
                                                                    : Color.fromARGB(
                                                                    170,
                                                                    255,
                                                                    40,
                                                                    0),
                                                              ),
                                                              textAlign:
                                                              TextAlign
                                                                  .center,
                                                            ),
                                                            color: warnaDinningArea
                                                                .length ==
                                                                0
                                                                ? Colors
                                                                .white
                                                                : warnaDinningArea[index] ==
                                                                'merah'
                                                                ? Color.fromARGB(
                                                                170,
                                                                255,
                                                                40,
                                                                0)
                                                                : Colors
                                                                .white,
                                                            onPressed: () {
                                                              setState(() {
                                                                if (criticalDinningArea[
                                                                index] ==
                                                                    'false') {
                                                                  print(
                                                                      'false');
                                                                } else if (criticalDinningArea[
                                                                index] ==
                                                                    'true') {
                                                                  if (scoreDinningArea[
                                                                  index] ==
                                                                      null) {
                                                                    jumlahCriticalPoint =
                                                                        jumlahCriticalPoint +
                                                                            1;
                                                                    print(
                                                                        jumlahCriticalPoint);
                                                                  } else {
                                                                    if (scoreDinningArea[index] ==
                                                                        2) {
                                                                      jumlahCriticalPoint =
                                                                          jumlahCriticalPoint + 1;
                                                                      print(
                                                                          jumlahCriticalPoint);
                                                                    } else if (scoreDinningArea[index] ==
                                                                        0 ||
                                                                        scoreDinningArea[index] ==
                                                                            1) {
                                                                      jumlahCriticalPoint =
                                                                          jumlahCriticalPoint + 0;
                                                                      print(
                                                                          jumlahCriticalPoint);
                                                                    }
                                                                  }
                                                                }

                                                                if (problemFS.length == 0) {
                                                                  problemFS.add(jmlDinningArea[index]);
                                                                  areaFS.add('Dinning Area');
                                                                  auditorFS.add(auditorName[1]);
                                                                  auditorIDFS.add(int.tryParse(widget.auditor[1].toString()));
                                                                  subBabFS.add(systemDinningArea[index]);
                                                                  rekomendasiFS.add(null);
                                                                      carNoFS.add(null);
                                                                  criticalFS.add(criticalDinningArea[index] == 'false' ? 'no' : 'yes');
                                                                } else {
                                                                  if (problemFS.contains(jmlDinningArea[index])) {
                                                                    
                                                                  } else {
                                                                    problemFS.add(jmlDinningArea[index]);
                                                                    areaFS.add('Dinning Area');
                                                                    auditorFS.add(auditorName[1]);
                                                                    auditorIDFS.add(int.tryParse(widget.auditor[1].toString()));
                                                                    subBabFS.add(systemDinningArea[index]);
                                                                    criticalFS.add(criticalDinningArea[index] == 'false' ? 'no' : 'yes');
                                                                    rekomendasiFS.add(null);
                                                                      carNoFS.add(null);
                                                                  }
                                                                }

                                                                scoreDinningArea
                                                                    .removeAt(
                                                                    index);
                                                                scoreDinningArea
                                                                    .insert(
                                                                    index,
                                                                    0);
                                                                warnaDinningArea
                                                                    .removeAt(
                                                                    index);
                                                                warnaDinningArea
                                                                    .insert(
                                                                    index,
                                                                    'merah');
                                                              });

                                                              print(problemFS);
                                                              print(areaFS);
                                                              print(criticalFS);
                                                              print(auditorFS);
                                                              print(subBabFS);
                                                            },
                                                          ),
                                                        ),
                                                        alignment:
                                                        Alignment(
                                                            0.0, 0.0),
                                                      ),
                                                    ),
                                                    jawabanSplitDinningArea[1] ==
                                                        'null'
                                                        ? Container()
                                                        : Tooltip(
                                                      message:
                                                      jawabanSplitDinningArea ==
                                                          null
                                                          ? ''
                                                          : jawabanSplitDinningArea[
                                                      1],
                                                      preferBelow: false,
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                            horizontal:
                                                            5.0),
                                                        child: ButtonTheme(
                                                          minWidth: 50.0,
                                                          height: 50.0,
                                                          child:
                                                          RaisedButton(
                                                            shape:
                                                            new RoundedRectangleBorder(
                                                              borderRadius:
                                                              new BorderRadius
                                                                  .circular(
                                                                  5.0),
                                                              side:
                                                              BorderSide(
                                                                width: 1.5,
                                                                color: warnaDinningArea.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    192,
                                                                    192,
                                                                    192)
                                                                    : warnaDinningArea[index] ==
                                                                    'kuning'
                                                                    ? Colors
                                                                    .white
                                                                    : Color.fromARGB(
                                                                    170,
                                                                    192,
                                                                    192,
                                                                    192),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              '1',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  18.0,
                                                                  color: warnaDinningArea.length ==
                                                                      0
                                                                      ? Color.fromARGB(
                                                                      170,
                                                                      247,
                                                                      202,
                                                                      24)
                                                                      : warnaDinningArea[index] == 'kuning'
                                                                      ? Colors.white
                                                                      : Color.fromARGB(170, 247, 202, 24)),
                                                              textAlign:
                                                              TextAlign
                                                                  .center,
                                                            ),
                                                            color: warnaDinningArea
                                                                .length ==
                                                                0
                                                                ? Colors
                                                                .white
                                                                : warnaDinningArea[index] ==
                                                                'kuning'
                                                                ? Color.fromARGB(
                                                                170,
                                                                247,
                                                                202,
                                                                24)
                                                                : Colors
                                                                .white,
                                                            onPressed: () {
                                                              setState(() {
                                                                if (criticalDinningArea[
                                                                index] ==
                                                                    'false') {
                                                                  print(
                                                                      'false');
                                                                } else if (criticalDinningArea[
                                                                index] ==
                                                                    'true') {
                                                                  if (scoreDinningArea[
                                                                  index] ==
                                                                      null) {
                                                                    jumlahCriticalPoint =
                                                                        jumlahCriticalPoint +
                                                                            1;
                                                                    print(
                                                                        jumlahCriticalPoint);
                                                                  } else {
                                                                    if (scoreDinningArea[index] ==
                                                                        2) {
                                                                      jumlahCriticalPoint =
                                                                          jumlahCriticalPoint + 1;
                                                                      print(
                                                                          jumlahCriticalPoint);
                                                                    } else if (scoreDinningArea[index] ==
                                                                        0 ||
                                                                        scoreDinningArea[index] ==
                                                                            1) {
                                                                      jumlahCriticalPoint =
                                                                          jumlahCriticalPoint + 0;
                                                                      print(
                                                                          jumlahCriticalPoint);
                                                                    }
                                                                  }
                                                                }

                                                                if (problemFS.length == 0) {
                                                                  
                                                                } else {
                                                                  if (problemFS.contains(jmlDinningArea[index])) {
                                                                    areaFS.removeAt(problemFS.indexWhere((test) => test == jmlDinningArea[index]));
                                                                    rekomendasiFS.removeAt(problemFS.indexWhere((test) => test == jmlDinningArea[index]));
                                                                    carNoFS.removeAt(problemFS.indexWhere((test) => test == jmlDinningArea[index]));
                                                                    auditorFS.removeAt(problemFS.indexWhere((test) => test == jmlDinningArea[index]));
                                                                    auditorIDFS.removeAt(problemFS.indexWhere((test) => test == jmlDinningArea[index]));
                                                                    criticalFS.removeAt(problemFS.indexWhere((test) => test == jmlDinningArea[index]));
                                                                    subBabFS.removeAt(problemFS.indexWhere((test) => test == jmlDinningArea[index]));
                                                                    problemFS.removeAt(problemFS.indexWhere((test) => test == jmlDinningArea[index]));
                                                                  } else {
                                                                    
                                                                  }
                                                                }

                                                                scoreDinningArea
                                                                    .removeAt(
                                                                    index);
                                                                scoreDinningArea
                                                                    .insert(
                                                                    index,
                                                                    1);
                                                                warnaDinningArea
                                                                    .removeAt(
                                                                    index);
                                                                warnaDinningArea
                                                                    .insert(
                                                                    index,
                                                                    'kuning');
                                                              });

                                                              print(problemFS);
                                                              print(areaFS);
                                                              print(criticalFS);
                                                              print(auditorFS);
                                                              print(subBabFS);
                                                            },
                                                          ),
                                                        ),
                                                        alignment:
                                                        Alignment(
                                                            0.0, 0.0),
                                                      ),
                                                    ),
                                                    jawabanSplitDinningArea[2] ==
                                                        'null'
                                                        ? Container()
                                                        : Tooltip(
                                                      message:
                                                      jawabanSplitDinningArea ==
                                                          null
                                                          ? ''
                                                          : jawabanSplitDinningArea[
                                                      2],
                                                      preferBelow: false,
                                                      child: Container(
                                                        child: ButtonTheme(
                                                          minWidth: 50.0,
                                                          height: 50.0,
                                                          child:
                                                          RaisedButton(
                                                            shape:
                                                            new RoundedRectangleBorder(
                                                              borderRadius:
                                                              new BorderRadius
                                                                  .circular(
                                                                  5.0),
                                                              side:
                                                              BorderSide(
                                                                width: 1.5,
                                                                color: warnaDinningArea.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    192,
                                                                    192,
                                                                    192)
                                                                    : warnaDinningArea[index] ==
                                                                    'hijau'
                                                                    ? Colors
                                                                    .white
                                                                    : Color.fromARGB(
                                                                    170,
                                                                    192,
                                                                    192,
                                                                    192),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              '2',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  18.0,
                                                                  color: warnaDinningArea.length ==
                                                                      0
                                                                      ? Color.fromARGB(
                                                                      170,
                                                                      50,
                                                                      205,
                                                                      50)
                                                                      : warnaDinningArea[index] == 'hijau'
                                                                      ? Colors.white
                                                                      : Color.fromARGB(170, 50, 205, 50)),
                                                              textAlign:
                                                              TextAlign
                                                                  .center,
                                                            ),
                                                            color: warnaDinningArea
                                                                .length ==
                                                                0
                                                                ? Colors
                                                                .white
                                                                : warnaDinningArea[index] ==
                                                                'hijau'
                                                                ? Color.fromARGB(
                                                                170,
                                                                50,
                                                                205,
                                                                50)
                                                                : Colors
                                                                .white,
                                                            onPressed: () {
                                                              setState(() {
                                                                if (criticalDinningArea[
                                                                index] ==
                                                                    'false') {
                                                                  print(
                                                                      'false');
                                                                } else if (criticalDinningArea[
                                                                index] ==
                                                                    'true') {
                                                                  if (scoreDinningArea[
                                                                  index] ==
                                                                      2) {
                                                                    jumlahCriticalPoint =
                                                                        jumlahCriticalPoint +
                                                                            0;
                                                                    print(
                                                                        jumlahCriticalPoint);
                                                                  } else {
                                                                    if (scoreDinningArea[index] ==
                                                                        2) {
                                                                      jumlahCriticalPoint =
                                                                          jumlahCriticalPoint + 0;
                                                                      print(
                                                                          jumlahCriticalPoint);
                                                                    } else if (scoreDinningArea[index] ==
                                                                        0 ||
                                                                        scoreDinningArea[index] ==
                                                                            1) {
                                                                      jumlahCriticalPoint =
                                                                          jumlahCriticalPoint - 1;
                                                                      print(
                                                                          jumlahCriticalPoint);
                                                                    }
                                                                  }
                                                                }

                                                                if (problemFS.length == 0) {
                                                                  
                                                                } else {
                                                                  if (problemFS.contains(jmlDinningArea[index])) {
                                                                    areaFS.removeAt(problemFS.indexWhere((test) => test == jmlDinningArea[index]));
                                                                    rekomendasiFS.removeAt(problemFS.indexWhere((test) => test == jmlDinningArea[index]));
                                                                    carNoFS.removeAt(problemFS.indexWhere((test) => test == jmlDinningArea[index]));
                                                                    auditorFS.removeAt(problemFS.indexWhere((test) => test == jmlDinningArea[index]));
                                                                    auditorIDFS.removeAt(problemFS.indexWhere((test) => test == jmlDinningArea[index]));
                                                                    criticalFS.removeAt(problemFS.indexWhere((test) => test == jmlDinningArea[index]));
                                                                    subBabFS.removeAt(problemFS.indexWhere((test) => test == jmlDinningArea[index]));
                                                                    problemFS.removeAt(problemFS.indexWhere((test) => test == jmlDinningArea[index]));
                                                                  } else {
                                                                    
                                                                  }
                                                                }

                                                                scoreDinningArea
                                                                    .removeAt(
                                                                    index);
                                                                scoreDinningArea
                                                                    .insert(
                                                                    index,
                                                                    2);
                                                                warnaDinningArea
                                                                    .removeAt(
                                                                    index);
                                                                warnaDinningArea
                                                                    .insert(
                                                                    index,
                                                                    'hijau');
                                                              });

                                                              print(problemFS);
                                                              print(areaFS);
                                                              print(criticalFS);
                                                              print(auditorFS);
                                                              print(subBabFS);
                                                            },
                                                          ),
                                                        ),
                                                        alignment:
                                                        Alignment(
                                                            0.0, 0.0),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                          widget.subArea.contains('Dinning Area')
                                            ? Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    imageDinningArea[index] == null
                                                      ? IconButton(
                                                          icon: Icon(Icons.camera_alt, color: AbubaPallate.greenabuba),
                                                          onPressed: () async {
                                                            var selectedImage =
                                                            await ImagePicker.pickImage(source: ImageSource.camera, maxHeight: 400.0, maxWidth: 400.0);
                                                            
                                                            imageDinningArea1 = selectedImage;
                                                            filenameDinningArea1 = basename(imageDinningArea1.path);

                                                            StorageReference strRef = FirebaseStorage.instance.ref().child(filenameDinningArea1);
                                                            StorageUploadTask uploadTask = strRef.putFile(imageDinningArea1);

                                                            var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
                                                            var url = downUrl.toString();

                                                            setState(() {
                                                              if (imageDinningArea[index] != null) {
                                                                List<String> bantuImageDinningArea = [];
                                                                List<String> bantuImageDinningAreaSave = [];
                                                                bantuImageDinningArea = imageDinningArea[index].split('###');
                                                                bantuImageDinningArea.add(filenameDinningArea1);
                                                                imageDinningArea[index] = bantuImageDinningArea.join('###');

                                                                bantuImageDinningAreaSave = imageDinningAreaSave[index].split('###');
                                                                bantuImageDinningAreaSave.add(url);
                                                                imageDinningAreaSave[index] = bantuImageDinningAreaSave.join('###');
                                                              } else {
                                                                imageDinningArea[index] = filenameDinningArea1;
                                                                imageDinningAreaSave[index] = url;
                                                              }
                                                              // imageDinningAreaBantu[index] = imageDinningArea1;
                                                              print(imageDinningArea);
                                                              print(imageDinningAreaSave);
                                                              print(imageDinningArea[index].split('###').length);
                                                              print(imageDinningAreaSave[index].split('###').length);
                                                            });
                                                          },
                                                        )
                                                      : imageDinningArea[index].split('###').length >= 5
                                                          ? IconButton(
                                                              icon: Icon(Icons.disc_full, color: Colors.grey),
                                                              onPressed: () {},
                                                              tooltip: 'Sudah mencapai batas maksimal 5 foto tiap pertanyaan',
                                                            )
                                                          : IconButton(
                                                              icon: Icon(Icons.camera_alt, color: AbubaPallate.greenabuba),
                                                              onPressed: () async {
                                                                var selectedImage =
                                                                await ImagePicker.pickImage(source: ImageSource.camera, maxHeight: 400.0, maxWidth: 400.0);
                                                                
                                                                imageDinningArea1 = selectedImage;
                                                                filenameDinningArea1 = basename(imageDinningArea1.path);

                                                                StorageReference strRef = FirebaseStorage.instance.ref().child(filenameDinningArea1);
                                                                StorageUploadTask uploadTask = strRef.putFile(imageDinningArea1);

                                                                var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
                                                                var url = downUrl.toString();

                                                                setState(() {
                                                                  if (imageDinningArea[index] != null) {
                                                                    List<String> bantuImageDinningArea = [];
                                                                    List<String> bantuImageDinningAreaSave = [];
                                                                    bantuImageDinningArea = imageDinningArea[index].split('###');
                                                                    bantuImageDinningArea.add(filenameDinningArea1);
                                                                    imageDinningArea[index] = bantuImageDinningArea.join('###');

                                                                    bantuImageDinningAreaSave = imageDinningAreaSave[index].split('###');
                                                                    bantuImageDinningAreaSave.add(url);
                                                                    imageDinningAreaSave[index] = bantuImageDinningAreaSave.join('###');
                                                                  } else {
                                                                    imageDinningArea[index] = filenameDinningArea1;
                                                                    imageDinningAreaSave[index] = url;
                                                                  }
                                                                  // imageDinningAreaBantu[index] = imageDinningArea1;
                                                                  print(imageDinningArea);
                                                                  print(imageDinningAreaSave);
                                                                  print(imageDinningArea[index].split('###').length);
                                                                  print(imageDinningAreaSave[index].split('###').length);
                                                                });
                                                              },
                                                            ),
                                                    IconButton(
                                                      icon: Icon(Icons.event_note,
                                                          color: AbubaPallate
                                                              .greenabuba),
                                                      onPressed: () {
                                                        if (noteDinningArea[
                                                        index] ==
                                                            null) {
                                                          _controllerDinningArea
                                                              .text = '';
                                                        } else {
                                                          _controllerDinningArea
                                                              .text =
                                                          noteDinningArea[
                                                          index];
                                                        }
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              title: Text('NOTE'),
                                                              content: Container(
                                                                width: 300.0,
                                                                child: TextField(
                                                                  controller:
                                                                  _controllerDinningArea,
                                                                  decoration:
                                                                  InputDecoration(
                                                                    border:
                                                                    OutlineInputBorder(),
                                                                    hintText:
                                                                    'Note',
                                                                    hintStyle: TextStyle(
                                                                        fontSize:
                                                                        12.0),
                                                                  ),
                                                                  maxLines: 3,
                                                                  style:
                                                                  TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                              ),
                                                              actions: <Widget>[
                                                                FlatButton(
                                                                  splashColor: Colors
                                                                      .greenAccent,
                                                                  child: Text(
                                                                    'OK',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .green),
                                                                  ),
                                                                  onPressed: () {
                                                                    noteDinningArea
                                                                        .removeAt(
                                                                        index);
                                                                    noteDinningArea.insert(
                                                                        index,
                                                                        _controllerDinningArea
                                                                            .text);
                                                                    print(
                                                                        noteDinningArea);
                                                                    Navigator.of(
                                                                        context)
                                                                        .pop();
                                                                  },
                                                                )
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                          Divider(
                                            height: 2.0,
                                          )
                                        ],
                                      );
                                    }).toList(),
                                  ),
                                ),
                              );
                            }),
                        PreferredSize(
                          preferredSize: Size.fromHeight(
                              MediaQuery.of(context).size.height -
                                  55.0 -
                                  (MediaQuery.of(context).size.height * 0.7)),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 55.0,
                                child: Container(
                                    child: Padding(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: <Widget>[
                                              IconButton(
                                                icon: Icon(Icons.arrow_back_ios,
                                                    color: Colors.white),
                                                onPressed: () {
                                                  _cardController.animateTo(
                                                      _cardController.index - 1);
                                                },
                                                tooltip: 'Previous',
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.arrow_forward_ios,
                                                    color: Colors.white),
                                                onPressed: () {
                                                  if (widget.subArea.contains('Dinning Area')) {
                                                    if (scoreDinningArea[
                                                    indexDinningArea] ==
                                                        null) {
                                                      showDialog(
                                                        barrierDismissible: false,
                                                        context: context,
                                                        builder: (context) => Dialog(
                                                          child: Container(
                                                            height: 180.0,
                                                            child: Column(
                                                              children: <Widget>[
                                                                Container(
                                                                  color: AbubaPallate
                                                                      .greenabuba,
                                                                  height: 50.0,
                                                                  child: Center(
                                                                    child: Text(
                                                                      'OOPS!',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                          17.0,
                                                                          fontWeight:
                                                                          FontWeight.w700),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 20.0,
                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                      10.0,
                                                                      vertical:
                                                                      10.0),
                                                                  child: Text(
                                                                    'Please select the answer!',
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      16.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                                  children: <
                                                                      Widget>[
                                                                    FlatButton(
                                                                      child: Text(
                                                                          'OK'),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      hasilDinningArea = 0;
                                                      for (int i = 0;
                                                      i < scoreDinningArea.length;
                                                      i++) {
                                                        hasilDinningArea += double
                                                            .tryParse(
                                                            bobotPertanyaanDinningArea[
                                                            i]
                                                                .toString()) *
                                                            double.tryParse(
                                                                scoreDinningArea[i]
                                                                    .toString());
                                                      }
                                                      hasilDinningArea = hasilDinningArea / 2;
                                                      // if (hasilDinningArea > 1.0) {
                                                      //   hasilDinningArea = 1.0;
                                                      // } else {
                                                      //   hasilDinningArea =
                                                      //       hasilDinningArea;
                                                      // }
                                                      // finalDinningArea = (hasilDinningArea * parameterDinningArea) /100;

                                                      print(bobotPertanyaanDinningArea);
                                                      print(scoreDinningArea);
                                                      print(hasilDinningArea);
                                                      // print(finalDinningArea);
                                                      _cardController.animateTo(_cardController.index + 1);
                                                    }
                                                  } else {
                                                    print(bobotPertanyaanDinningArea);
                                                    print(scoreDinningArea);
                                                    print(hasilDinningArea);
                                                    print(finalDinningArea);
                                                    _cardController.animateTo(_cardController.index + 1);
                                                  }
                                                },
                                                tooltip: 'Next',
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    decoration:
                                    BoxDecoration(color: Color(0xFF2F592F))),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                // sini service
                ListView(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      children: <Widget>[
                        PreferredSize(
                          preferredSize: Size.fromHeight(55.0),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 55.0,
                                child: Container(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.75,
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                text: TextSpan(
                                                  text: 'Service',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17.0
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.75,
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                text: TextSpan(
                                                  text: 'Auditor : ${auditorName[2].toString()}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11.0
                                                  ),
                                                ),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '3 of ${_listData.length.toString()}',
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 14.0),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF2F592F),
                                  ),
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
                                /*height: MediaQuery.of(context).size.height * 0.648,*/
                                height: MediaQuery.of(context).size.height *
                                    0.736,
                              )
                                  : Container(
                                /*height: MediaQuery.of(context).size.height * 0.648,*/
                                height: MediaQuery.of(context).size.height *
                                    0.736,
                                color: Colors.white,
                                child: Scrollbar(
                                  child: ListView(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    children: List.generate(jmlService.length,
                                            (index) {
                                          indexService = index;
                                          jawabanSplitService =
                                              jawabanSplitServiceBantu[index]
                                                  .split(r"!@#$");
                                          if (scoreService.length <
                                              jumlahService) {
                                            for (int a = 0;
                                            a < jumlahService;
                                            a++) {
                                              noteService.add(null);
                                              scoreService.add(null);
                                              imageService.add(null);
                                              imageServiceBantu.add(null);
                                              imageServiceSave.add(null);
                                              warnaService.add('abu');
                                            }
                                          }

                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              criticalService[index] == 'false'
                                                  ? Padding(
                                                padding: EdgeInsets.only(
                                                    right: 15.0,
                                                    left: 15.0,
                                                    bottom: 8.0,
                                                    top: 8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        systemService[
                                                        index],
                                                        style: TextStyle(
                                                            color: Colors
                                                                .green,
                                                            fontWeight:
                                                            FontWeight
                                                                .w700,
                                                            fontSize: 16.0),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                                  : Padding(
                                                padding: EdgeInsets.only(
                                                    right: 15.0,
                                                    left: 15.0,
                                                    bottom: 8.0,
                                                    top: 8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        systemService[
                                                        index],
                                                        style: TextStyle(
                                                            color: Colors
                                                                .green,
                                                            fontWeight:
                                                            FontWeight
                                                                .w700,
                                                            fontSize: 16.0),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        'CRITICAL',
                                                        style: TextStyle(
                                                            color:
                                                            Colors.red,
                                                            fontWeight:
                                                            FontWeight
                                                                .w700,
                                                            fontSize: 16.0),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 15.0,
                                                          left: 15.0,
                                                          top: 10.0,
                                                          bottom: 50.0),
                                                      child: Text(
                                                        jmlService[index],
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 18.0),
                                                        textAlign:
                                                        TextAlign.start,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              widget.subArea.contains('Service')
                                                ? Padding(
                                                    padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: <Widget>[
                                                        jawabanSplitService[0] ==
                                                            'null'
                                                            ? Container()
                                                            : Tooltip(
                                                          message:
                                                          jawabanSplitService ==
                                                              null
                                                              ? ''
                                                              : jawabanSplitService[
                                                          0],
                                                          preferBelow: false,
                                                          child: Container(
                                                            child: ButtonTheme(
                                                              minWidth: 50.0,
                                                              height: 50.0,
                                                              child:
                                                              RaisedButton(
                                                                shape:
                                                                new RoundedRectangleBorder(
                                                                  borderRadius:
                                                                  new BorderRadius
                                                                      .circular(
                                                                      5.0),
                                                                  side:
                                                                  BorderSide(
                                                                    width: 1.5,
                                                                    color: warnaService.length ==
                                                                        0
                                                                        ? Color.fromARGB(
                                                                        170,
                                                                        192,
                                                                        192,
                                                                        192)
                                                                        : warnaService[index] ==
                                                                        'merah'
                                                                        ? Colors
                                                                        .white
                                                                        : Color.fromARGB(
                                                                        170,
                                                                        192,
                                                                        192,
                                                                        192),
                                                                  ),
                                                                ),
                                                                child: Text(
                                                                  '0',
                                                                  style:
                                                                  TextStyle(
                                                                    fontSize:
                                                                    18.0,
                                                                    color: warnaService.length ==
                                                                        0
                                                                        ? Color.fromARGB(
                                                                        170,
                                                                        255,
                                                                        40,
                                                                        0)
                                                                        : warnaService[index] ==
                                                                        'merah'
                                                                        ? Colors
                                                                        .white
                                                                        : Color.fromARGB(
                                                                        170,
                                                                        255,
                                                                        40,
                                                                        0),
                                                                  ),
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                ),
                                                                color: warnaService
                                                                    .length ==
                                                                    0
                                                                    ? Colors
                                                                    .white
                                                                    : warnaService[index] ==
                                                                    'merah'
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    255,
                                                                    40,
                                                                    0)
                                                                    : Colors
                                                                    .white,
                                                                onPressed: () {
                                                                  setState(() {
                                                                    if (criticalService[
                                                                    index] ==
                                                                        'false') {
                                                                      print(
                                                                          'false');
                                                                    } else if (criticalService[
                                                                    index] ==
                                                                        'true') {
                                                                      if (scoreService[
                                                                      index] ==
                                                                          null) {
                                                                        jumlahCriticalPoint =
                                                                            jumlahCriticalPoint +
                                                                                1;
                                                                        print(
                                                                            jumlahCriticalPoint);
                                                                      } else {
                                                                        if (scoreService[index] ==
                                                                            2) {
                                                                          jumlahCriticalPoint =
                                                                              jumlahCriticalPoint + 1;
                                                                          print(
                                                                              jumlahCriticalPoint);
                                                                        } else if (scoreService[index] ==
                                                                            0 ||
                                                                            scoreService[index] ==
                                                                                1) {
                                                                          jumlahCriticalPoint =
                                                                              jumlahCriticalPoint + 0;
                                                                          print(
                                                                              jumlahCriticalPoint);
                                                                        }
                                                                      }
                                                                    }

                                                                    if (problemFS.length == 0) {
                                                                      problemFS.add(jmlService[index]);
                                                                      areaFS.add('Service');
                                                                      auditorFS.add(auditorName[2]);
                                                                      auditorIDFS.add(int.tryParse(widget.auditor[2].toString()));
                                                                      subBabFS.add(systemService[index]);
                                                                      criticalFS.add(criticalService[index] == 'false' ? 'no' : 'yes');
                                                                      rekomendasiFS.add(null);
                                                                      carNoFS.add(null);
                                                                    } else {
                                                                      if (problemFS.contains(jmlService[index])) {
                                                                        
                                                                      } else {
                                                                        problemFS.add(jmlService[index]);
                                                                        areaFS.add('Service');
                                                                        auditorFS.add(auditorName[2]);
                                                                        auditorIDFS.add(int.tryParse(widget.auditor[2].toString()));
                                                                        subBabFS.add(systemService[index]);
                                                                        criticalFS.add(criticalService[index] == 'false' ? 'no' : 'yes');
                                                                        rekomendasiFS.add(null);
                                                                      carNoFS.add(null);
                                                                      }
                                                                    }

                                                                    scoreService
                                                                        .removeAt(
                                                                        index);
                                                                    scoreService
                                                                        .insert(
                                                                        index,
                                                                        0);
                                                                    warnaService
                                                                        .removeAt(
                                                                        index);
                                                                    warnaService
                                                                        .insert(
                                                                        index,
                                                                        'merah');

                                                                    print(problemFS);
                                                              print(areaFS);
                                                              print(criticalFS);
                                                              print(auditorFS);
                                                              print(subBabFS);
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                            alignment:
                                                            Alignment(
                                                                0.0, 0.0),
                                                          ),
                                                        ),
                                                        jawabanSplitService[1] ==
                                                            'null'
                                                            ? Container()
                                                            : Tooltip(
                                                          message:
                                                          jawabanSplitService ==
                                                              null
                                                              ? ''
                                                              : jawabanSplitService[
                                                          1],
                                                          preferBelow: false,
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                5.0),
                                                            child: ButtonTheme(
                                                              minWidth: 50.0,
                                                              height: 50.0,
                                                              child:
                                                              RaisedButton(
                                                                shape:
                                                                new RoundedRectangleBorder(
                                                                  borderRadius:
                                                                  new BorderRadius
                                                                      .circular(
                                                                      5.0),
                                                                  side:
                                                                  BorderSide(
                                                                    width: 1.5,
                                                                    color: warnaService.length ==
                                                                        0
                                                                        ? Color.fromARGB(
                                                                        170,
                                                                        192,
                                                                        192,
                                                                        192)
                                                                        : warnaService[index] ==
                                                                        'kuning'
                                                                        ? Colors
                                                                        .white
                                                                        : Color.fromARGB(
                                                                        170,
                                                                        192,
                                                                        192,
                                                                        192),
                                                                  ),
                                                                ),
                                                                child: Text(
                                                                  '1',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                      18.0,
                                                                      color: warnaService.length ==
                                                                          0
                                                                          ? Color.fromARGB(
                                                                          170,
                                                                          247,
                                                                          202,
                                                                          24)
                                                                          : warnaService[index] == 'kuning'
                                                                          ? Colors.white
                                                                          : Color.fromARGB(170, 247, 202, 24)),
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                ),
                                                                color: warnaService
                                                                    .length ==
                                                                    0
                                                                    ? Colors
                                                                    .white
                                                                    : warnaService[index] ==
                                                                    'kuning'
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    247,
                                                                    202,
                                                                    24)
                                                                    : Colors
                                                                    .white,
                                                                onPressed: () {
                                                                  setState(() {
                                                                    if (criticalService[
                                                                    index] ==
                                                                        'false') {
                                                                      print(
                                                                          'false');
                                                                    } else if (criticalService[
                                                                    index] ==
                                                                        'true') {
                                                                      if (scoreService[
                                                                      index] ==
                                                                          null) {
                                                                        jumlahCriticalPoint =
                                                                            jumlahCriticalPoint +
                                                                                1;
                                                                        print(
                                                                            jumlahCriticalPoint);
                                                                      } else {
                                                                        if (scoreService[index] ==
                                                                            2) {
                                                                          jumlahCriticalPoint =
                                                                              jumlahCriticalPoint + 1;
                                                                          print(
                                                                              jumlahCriticalPoint);
                                                                        } else if (scoreService[index] ==
                                                                            0 ||
                                                                            scoreService[index] ==
                                                                                1) {
                                                                          jumlahCriticalPoint =
                                                                              jumlahCriticalPoint + 0;
                                                                          print(
                                                                              jumlahCriticalPoint);
                                                                        }
                                                                      }
                                                                    }

                                                                    if (problemFS.length == 0) {
                                                                  
                                                                    } else {
                                                                      if (problemFS.contains(jmlService[index])) {
                                                                        areaFS.removeAt(problemFS.indexWhere((test) => test == jmlService[index]));
                                                                        rekomendasiFS.removeAt(problemFS.indexWhere((test) => test == jmlService[index]));
                                                                    carNoFS.removeAt(problemFS.indexWhere((test) => test == jmlService[index]));
                                                                        auditorFS.removeAt(problemFS.indexWhere((test) => test == jmlService[index]));
                                                                        auditorIDFS.removeAt(problemFS.indexWhere((test) => test == jmlService[index]));
                                                                        criticalFS.removeAt(problemFS.indexWhere((test) => test == jmlService[index]));
                                                                        subBabFS.removeAt(problemFS.indexWhere((test) => test == jmlService[index]));
                                                                        problemFS.removeAt(problemFS.indexWhere((test) => test == jmlService[index]));
                                                                      } else {
                                                                        
                                                                      }
                                                                    }

                                                                    scoreService
                                                                        .removeAt(
                                                                        index);
                                                                    scoreService
                                                                        .insert(
                                                                        index,
                                                                        1);
                                                                    warnaService
                                                                        .removeAt(
                                                                        index);
                                                                    warnaService
                                                                        .insert(
                                                                        index,
                                                                        'kuning');

                                                                        print(problemFS);
                                                              print(areaFS);
                                                              print(criticalFS);
                                                              print(auditorFS);
                                                              print(subBabFS);
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                            alignment:
                                                            Alignment(
                                                                0.0, 0.0),
                                                          ),
                                                        ),
                                                        jawabanSplitService[2] ==
                                                            'null'
                                                            ? Container()
                                                            : Tooltip(
                                                          message:
                                                          jawabanSplitService ==
                                                              null
                                                              ? ''
                                                              : jawabanSplitService[
                                                          2],
                                                          preferBelow: false,
                                                          child: Container(
                                                            child: ButtonTheme(
                                                              minWidth: 50.0,
                                                              height: 50.0,
                                                              child:
                                                              RaisedButton(
                                                                shape:
                                                                new RoundedRectangleBorder(
                                                                  borderRadius:
                                                                  new BorderRadius
                                                                      .circular(
                                                                      5.0),
                                                                  side:
                                                                  BorderSide(
                                                                    width: 1.5,
                                                                    color: warnaService.length ==
                                                                        0
                                                                        ? Color.fromARGB(
                                                                        170,
                                                                        192,
                                                                        192,
                                                                        192)
                                                                        : warnaService[index] ==
                                                                        'hijau'
                                                                        ? Colors
                                                                        .white
                                                                        : Color.fromARGB(
                                                                        170,
                                                                        192,
                                                                        192,
                                                                        192),
                                                                  ),
                                                                ),
                                                                child: Text(
                                                                  '2',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                      18.0,
                                                                      color: warnaService.length ==
                                                                          0
                                                                          ? Color.fromARGB(
                                                                          170,
                                                                          50,
                                                                          205,
                                                                          50)
                                                                          : warnaService[index] == 'hijau'
                                                                          ? Colors.white
                                                                          : Color.fromARGB(170, 50, 205, 50)),
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                ),
                                                                color: warnaService
                                                                    .length ==
                                                                    0
                                                                    ? Colors
                                                                    .white
                                                                    : warnaService[index] ==
                                                                    'hijau'
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    50,
                                                                    205,
                                                                    50)
                                                                    : Colors
                                                                    .white,
                                                                onPressed: () {
                                                                  setState(() {
                                                                    if (criticalService[
                                                                    index] ==
                                                                        'false') {
                                                                      print(
                                                                          'false');
                                                                    } else if (criticalService[
                                                                    index] ==
                                                                        'true') {
                                                                      if (scoreService[
                                                                      index] ==
                                                                          2) {
                                                                        jumlahCriticalPoint =
                                                                            jumlahCriticalPoint +
                                                                                0;
                                                                        print(
                                                                            jumlahCriticalPoint);
                                                                      } else {
                                                                        if (scoreService[index] ==
                                                                            2) {
                                                                          jumlahCriticalPoint =
                                                                              jumlahCriticalPoint + 0;
                                                                          print(
                                                                              jumlahCriticalPoint);
                                                                        } else if (scoreService[index] ==
                                                                            0 ||
                                                                            scoreService[index] ==
                                                                                1) {
                                                                          jumlahCriticalPoint =
                                                                              jumlahCriticalPoint - 1;
                                                                          print(
                                                                              jumlahCriticalPoint);
                                                                        }
                                                                      }
                                                                    }

                                                                    if (problemFS.length == 0) {
                                                                  
                                                                    } else {
                                                                      if (problemFS.contains(jmlService[index])) {
                                                                        areaFS.removeAt(problemFS.indexWhere((test) => test == jmlService[index]));
                                                                        rekomendasiFS.removeAt(problemFS.indexWhere((test) => test == jmlService[index]));
                                                                    carNoFS.removeAt(problemFS.indexWhere((test) => test == jmlService[index]));
                                                                        auditorFS.removeAt(problemFS.indexWhere((test) => test == jmlService[index]));
                                                                        auditorIDFS.removeAt(problemFS.indexWhere((test) => test == jmlService[index]));
                                                                        criticalFS.removeAt(problemFS.indexWhere((test) => test == jmlService[index]));
                                                                        subBabFS.removeAt(problemFS.indexWhere((test) => test == jmlService[index]));
                                                                        problemFS.removeAt(problemFS.indexWhere((test) => test == jmlService[index]));
                                                                      } else {
                                                                        
                                                                      }
                                                                    }

                                                                    scoreService
                                                                        .removeAt(
                                                                        index);
                                                                    scoreService
                                                                        .insert(
                                                                        index,
                                                                        2);
                                                                    warnaService
                                                                        .removeAt(
                                                                        index);
                                                                    warnaService
                                                                        .insert(
                                                                        index,
                                                                        'hijau');

                                                                        print(problemFS);
                                                              print(areaFS);
                                                              print(criticalFS);
                                                              print(auditorFS);
                                                              print(subBabFS);
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                            alignment:
                                                            Alignment(
                                                                0.0, 0.0),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : Container(),
                                              widget.subArea.contains('Service')
                                                ? Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
                                                        imageService[index] == null
                                                          ? IconButton(
                                                              icon: Icon(Icons.camera_alt, color: AbubaPallate.greenabuba),
                                                              onPressed: () async {
                                                                var selectedImage =
                                                                await ImagePicker.pickImage(source: ImageSource.camera, maxHeight: 400.0, maxWidth: 400.0);
                                                                
                                                                imageService1 = selectedImage;
                                                                filenameService1 = basename(imageService1.path);

                                                                StorageReference strRef = FirebaseStorage.instance.ref().child(filenameService1);
                                                                StorageUploadTask uploadTask = strRef.putFile(imageService1);

                                                                var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
                                                                var url = downUrl.toString();

                                                                setState(() {
                                                                  if (imageService[index] != null) {
                                                                    List<String> bantuImageService = [];
                                                                    List<String> bantuImageServiceSave = [];
                                                                    bantuImageService = imageService[index].split('###');
                                                                    bantuImageService.add(filenameService1);
                                                                    imageService[index] = bantuImageService.join('###');

                                                                    bantuImageServiceSave = imageServiceSave[index].split('###');
                                                                    bantuImageServiceSave.add(url);
                                                                    imageServiceSave[index] = bantuImageServiceSave.join('###');
                                                                  } else {
                                                                    imageService[index] = filenameService1;
                                                                    imageServiceSave[index] = url;
                                                                  }
                                                                  // imageServiceBantu[index] = imageService1;
                                                                  print(imageService);
                                                                  print(imageServiceSave);
                                                                  print(imageService[index].split('###').length);
                                                                  print(imageServiceSave[index].split('###').length);
                                                                });
                                                              },
                                                            )
                                                          : imageService[index].split('###').length >= 5
                                                              ? IconButton(
                                                                  icon: Icon(Icons.disc_full, color: Colors.grey),
                                                                  onPressed: () {},
                                                                  tooltip: 'Sudah mencapai batas maksimal 5 foto tiap pertanyaan',
                                                                )
                                                              : IconButton(
                                                                  icon: Icon(Icons.camera_alt, color: AbubaPallate.greenabuba),
                                                                  onPressed: () async {
                                                                    var selectedImage =
                                                                    await ImagePicker.pickImage(source: ImageSource.camera, maxHeight: 400.0, maxWidth: 400.0);
                                                                    
                                                                    imageService1 = selectedImage;
                                                                    filenameService1 = basename(imageService1.path);

                                                                    StorageReference strRef = FirebaseStorage.instance.ref().child(filenameService1);
                                                                    StorageUploadTask uploadTask = strRef.putFile(imageService1);

                                                                    var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
                                                                    var url = downUrl.toString();

                                                                    setState(() {
                                                                      if (imageService[index] != null) {
                                                                        List<String> bantuImageService = [];
                                                                        List<String> bantuImageServiceSave = [];
                                                                        bantuImageService = imageService[index].split('###');
                                                                        bantuImageService.add(filenameService1);
                                                                        imageService[index] = bantuImageService.join('###');

                                                                        bantuImageServiceSave = imageServiceSave[index].split('###');
                                                                        bantuImageServiceSave.add(url);
                                                                        imageServiceSave[index] = bantuImageServiceSave.join('###');
                                                                      } else {
                                                                        imageService[index] = filenameService1;
                                                                        imageServiceSave[index] = url;
                                                                      }
                                                                      // imageServiceBantu[index] = imageService1;
                                                                      print(imageService);
                                                                      print(imageServiceSave);
                                                                      print(imageService[index].split('###').length);
                                                                      print(imageServiceSave[index].split('###').length);
                                                                    });
                                                                  },
                                                                ),
                                                        IconButton(
                                                          icon: Icon(Icons.event_note,
                                                              color: AbubaPallate
                                                                  .greenabuba),
                                                          onPressed: () {
                                                            if (noteService[index] ==
                                                                null) {
                                                              _controllerService
                                                                  .text = '';
                                                            } else {
                                                              _controllerService
                                                                  .text =
                                                              noteService[index];
                                                            }
                                                            showDialog(
                                                              context: context,
                                                              builder: (context) {
                                                                return AlertDialog(
                                                                  title: Text('NOTE'),
                                                                  content: Container(
                                                                    width: 300.0,
                                                                    child: TextField(
                                                                      controller:
                                                                      _controllerService,
                                                                      decoration:
                                                                      InputDecoration(
                                                                        border:
                                                                        OutlineInputBorder(),
                                                                        hintText:
                                                                        'Note',
                                                                        hintStyle: TextStyle(
                                                                            fontSize:
                                                                            12.0),
                                                                      ),
                                                                      maxLines: 3,
                                                                      style:
                                                                      TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  actions: <Widget>[
                                                                    FlatButton(
                                                                      splashColor: Colors
                                                                          .greenAccent,
                                                                      child: Text(
                                                                        'OK',
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .green),
                                                                      ),
                                                                      onPressed: () {
                                                                        noteService
                                                                            .removeAt(
                                                                            index);
                                                                        noteService.insert(
                                                                            index,
                                                                            _controllerService
                                                                                .text);
                                                                        print(
                                                                            noteService);
                                                                        Navigator.of(
                                                                            context)
                                                                            .pop();
                                                                      },
                                                                    )
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : Container(),
                                              Divider(
                                                height: 2.0,
                                              )
                                            ],
                                          );
                                        }).toList(),
                                  ),
                                ),
                              );
                            }),
                        PreferredSize(
                          preferredSize: Size.fromHeight(
                              MediaQuery.of(context).size.height -
                                  55.0 -
                                  (MediaQuery.of(context).size.height * 0.7)),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 55.0,
                                child: Container(
                                    child: Padding(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: <Widget>[
                                              IconButton(
                                                icon: Icon(Icons.arrow_back_ios,
                                                    color: Colors.white),
                                                onPressed: () {
                                                  _cardController.animateTo(
                                                      _cardController.index - 1);
                                                },
                                                tooltip: 'Previous',
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.arrow_forward_ios,
                                                    color: Colors.white),
                                                onPressed: () {
                                                  if (widget.subArea.contains('Service')) {
                                                    if (scoreService[indexService] ==
                                                        null) {
                                                      showDialog(
                                                        barrierDismissible: false,
                                                        context: context,
                                                        builder: (context) => Dialog(
                                                          child: Container(
                                                            height: 180.0,
                                                            child: Column(
                                                              children: <Widget>[
                                                                Container(
                                                                  color: AbubaPallate
                                                                      .greenabuba,
                                                                  height: 50.0,
                                                                  child: Center(
                                                                    child: Text(
                                                                      'OOPS!',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                          17.0,
                                                                          fontWeight:
                                                                          FontWeight.w700),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 20.0,
                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                      10.0,
                                                                      vertical:
                                                                      10.0),
                                                                  child: Text(
                                                                    'Please select the answer!',
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      16.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                                  children: <
                                                                      Widget>[
                                                                    FlatButton(
                                                                      child: Text(
                                                                          'OK'),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      hasilService = 0;
                                                      for (int i = 0;
                                                      i < scoreService.length;
                                                      i++) {
                                                        hasilService += double.tryParse(
                                                            bobotPertanyaanService[
                                                            i]
                                                                .toString()) *
                                                            double.tryParse(
                                                                scoreService[i]
                                                                    .toString());
                                                      }
                                                      hasilService = hasilService / 2;
                                                      // if (hasilService > 1.0) {
                                                      //   hasilService = 1.0;
                                                      // } else {
                                                      //   hasilService = hasilService;
                                                      // }
                                                      // finalService = (hasilService *
                                                      //     parameterService) /
                                                      //     100;

                                                      print(bobotPertanyaanService);
                                                      print(scoreService);
                                                      print(hasilService);
                                                      // print(finalService);
                                                      _cardController.animateTo(_cardController.index + 1);
                                                    }
                                                  } else {
                                                    print(bobotPertanyaanService);
                                                    print(scoreService);
                                                    print(hasilService);
                                                    print(finalService);
                                                    _cardController.animateTo(_cardController.index + 1);
                                                  }
                                                },
                                                tooltip: 'Next',
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    decoration:
                                    BoxDecoration(color: Color(0xFF2F592F))),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                // sini cashier
                ListView(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      children: <Widget>[
                        PreferredSize(
                          preferredSize: Size.fromHeight(55.0),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 55.0,
                                child: Container(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.75,
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                text: TextSpan(
                                                  text: 'Cashier',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17.0
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.75,
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                text: TextSpan(
                                                  text: 'Auditor : ${auditorName[3].toString()}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11.0
                                                  ),
                                                ),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '4 of ${_listData.length.toString()}',
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 14.0),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF2F592F),
                                  ),
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
                                alignment: Alignment(0.0, 0.0),
                                height: MediaQuery.of(context).size.height *
                                    0.736,
                              )
                                  : Container(
                                height: MediaQuery.of(context).size.height *
                                    0.736,
                                color: Colors.white,
                                child: Scrollbar(
                                  child: ListView(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    children: List.generate(jmlCashier.length,
                                            (index) {
                                          indexCashier = index;
                                          jawabanSplitCashier =
                                              jawabanSplitCashierBantu[index]
                                                  .split(r"!@#$");
                                          if (scoreCashier.length <
                                              jumlahCashier) {
                                            for (int a = 0;
                                            a < jumlahCashier;
                                            a++) {
                                              noteCashier.add(null);
                                              scoreCashier.add(null);
                                              imageCashier.add(null);
                                              imageCashierBantu.add(null);
                                              imageCashierSave.add(null);
                                              warnaCashier.add('abu');
                                            }
                                          }

                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              criticalCashier[index] == 'false'
                                                  ? Padding(
                                                padding: EdgeInsets.only(
                                                    right: 15.0,
                                                    left: 15.0,
                                                    bottom: 8.0,
                                                    top: 8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        systemCashier[
                                                        index],
                                                        style: TextStyle(
                                                            color: Colors
                                                                .green,
                                                            fontWeight:
                                                            FontWeight
                                                                .w700,
                                                            fontSize: 16.0),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                                  : Padding(
                                                padding: EdgeInsets.only(
                                                    right: 15.0,
                                                    left: 15.0,
                                                    bottom: 8.0,
                                                    top: 8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        systemCashier[
                                                        index],
                                                        style: TextStyle(
                                                            color: Colors
                                                                .green,
                                                            fontWeight:
                                                            FontWeight
                                                                .w700,
                                                            fontSize: 16.0),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        'CRITICAL',
                                                        style: TextStyle(
                                                            color:
                                                            Colors.red,
                                                            fontWeight:
                                                            FontWeight
                                                                .w700,
                                                            fontSize: 16.0),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 15.0,
                                                          left: 15.0,
                                                          top: 10.0,
                                                          bottom: 50.0),
                                                      child: Text(
                                                        jmlCashier[index],
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 18.0),
                                                        textAlign:
                                                        TextAlign.start,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              widget.subArea.contains('Cashier')
                                                ? Padding(
                                                    padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: <Widget>[
                                                        jawabanSplitCashier[0] ==
                                                            'null'
                                                            ? Container()
                                                            : Tooltip(
                                                          message:
                                                          jawabanSplitCashier ==
                                                              null
                                                              ? ''
                                                              : jawabanSplitCashier[
                                                          0],
                                                          preferBelow: false,
                                                          child: Container(
                                                            child: ButtonTheme(
                                                              minWidth: 50.0,
                                                              height: 50.0,
                                                              child:
                                                              RaisedButton(
                                                                shape:
                                                                new RoundedRectangleBorder(
                                                                  borderRadius:
                                                                  new BorderRadius
                                                                      .circular(
                                                                      5.0),
                                                                  side:
                                                                  BorderSide(
                                                                    width: 1.5,
                                                                    color: warnaCashier.length ==
                                                                        0
                                                                        ? Color.fromARGB(
                                                                        170,
                                                                        192,
                                                                        192,
                                                                        192)
                                                                        : warnaCashier[index] ==
                                                                        'merah'
                                                                        ? Colors
                                                                        .white
                                                                        : Color.fromARGB(
                                                                        170,
                                                                        192,
                                                                        192,
                                                                        192),
                                                                  ),
                                                                ),
                                                                child: Text(
                                                                  '0',
                                                                  style:
                                                                  TextStyle(
                                                                    fontSize:
                                                                    18.0,
                                                                    color: warnaCashier.length ==
                                                                        0
                                                                        ? Color.fromARGB(
                                                                        170,
                                                                        255,
                                                                        40,
                                                                        0)
                                                                        : warnaCashier[index] ==
                                                                        'merah'
                                                                        ? Colors
                                                                        .white
                                                                        : Color.fromARGB(
                                                                        170,
                                                                        255,
                                                                        40,
                                                                        0),
                                                                  ),
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                ),
                                                                color: warnaCashier
                                                                    .length ==
                                                                    0
                                                                    ? Colors
                                                                    .white
                                                                    : warnaCashier[index] ==
                                                                    'merah'
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    255,
                                                                    40,
                                                                    0)
                                                                    : Colors
                                                                    .white,
                                                                onPressed: () {
                                                                  setState(() {
                                                                    if (criticalCashier[
                                                                    index] ==
                                                                        'false') {
                                                                      print(
                                                                          'false');
                                                                    } else if (criticalCashier[
                                                                    index] ==
                                                                        'true') {
                                                                      if (scoreCashier[
                                                                      index] ==
                                                                          null) {
                                                                        jumlahCriticalPoint =
                                                                            jumlahCriticalPoint +
                                                                                1;
                                                                        print(
                                                                            jumlahCriticalPoint);
                                                                      } else {
                                                                        if (scoreCashier[index] ==
                                                                            2) {
                                                                          jumlahCriticalPoint =
                                                                              jumlahCriticalPoint + 1;
                                                                          print(
                                                                              jumlahCriticalPoint);
                                                                        } else if (scoreCashier[index] ==
                                                                            0 ||
                                                                            scoreCashier[index] ==
                                                                                1) {
                                                                          jumlahCriticalPoint =
                                                                              jumlahCriticalPoint + 0;
                                                                          print(
                                                                              jumlahCriticalPoint);
                                                                        }
                                                                      }
                                                                    }

                                                                    if (problemFS.length == 0) {
                                                                      problemFS.add(jmlCashier[index]);
                                                                      areaFS.add('Cashier');
                                                                      auditorFS.add(auditorName[3]);
                                                                      auditorIDFS.add(int.tryParse(widget.auditor[3].toString()));
                                                                      subBabFS.add(systemCashier[index]);
                                                                      criticalFS.add(criticalCashier[index] == 'false' ? 'no' : 'yes');
                                                                      rekomendasiFS.add(null);
                                                                      carNoFS.add(null);
                                                                    } else {
                                                                      if (problemFS.contains(jmlCashier[index])) {
                                                                        
                                                                      } else {
                                                                        rekomendasiFS.add(null);
                                                                      carNoFS.add(null);
                                                                        problemFS.add(jmlCashier[index]);
                                                                        areaFS.add('Cashier');
                                                                        auditorFS.add(auditorName[3]);
                                                                        auditorIDFS.add(int.tryParse(widget.auditor[3].toString()));
                                                                        subBabFS.add(systemCashier[index]);
                                                                        criticalFS.add(criticalCashier[index] == 'false' ? 'no' : 'yes');
                                                                      }
                                                                    }

                                                                    scoreCashier
                                                                        .removeAt(
                                                                        index);
                                                                    scoreCashier
                                                                        .insert(
                                                                        index,
                                                                        0);
                                                                    warnaCashier
                                                                        .removeAt(
                                                                        index);
                                                                    warnaCashier
                                                                        .insert(
                                                                        index,
                                                                        'merah');

                                                                        print(problemFS);
                                                              print(areaFS);
                                                              print(criticalFS);
                                                              print(auditorFS);
                                                              print(subBabFS);
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                            alignment:
                                                            Alignment(
                                                                0.0, 0.0),
                                                          ),
                                                        ),
                                                        jawabanSplitCashier[1] ==
                                                            'null'
                                                            ? Container()
                                                            : Tooltip(
                                                          message:
                                                          jawabanSplitCashier ==
                                                              null
                                                              ? ''
                                                              : jawabanSplitCashier[
                                                          1],
                                                          preferBelow: false,
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                5.0),
                                                            child: ButtonTheme(
                                                              minWidth: 50.0,
                                                              height: 50.0,
                                                              child:
                                                              RaisedButton(
                                                                shape:
                                                                new RoundedRectangleBorder(
                                                                  borderRadius:
                                                                  new BorderRadius
                                                                      .circular(
                                                                      5.0),
                                                                  side:
                                                                  BorderSide(
                                                                    width: 1.5,
                                                                    color: warnaCashier.length ==
                                                                        0
                                                                        ? Color.fromARGB(
                                                                        170,
                                                                        192,
                                                                        192,
                                                                        192)
                                                                        : warnaCashier[index] ==
                                                                        'kuning'
                                                                        ? Colors
                                                                        .white
                                                                        : Color.fromARGB(
                                                                        170,
                                                                        192,
                                                                        192,
                                                                        192),
                                                                  ),
                                                                ),
                                                                child: Text(
                                                                  '1',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                      18.0,
                                                                      color: warnaCashier.length ==
                                                                          0
                                                                          ? Color.fromARGB(
                                                                          170,
                                                                          247,
                                                                          202,
                                                                          24)
                                                                          : warnaCashier[index] == 'kuning'
                                                                          ? Colors.white
                                                                          : Color.fromARGB(170, 247, 202, 24)),
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                ),
                                                                color: warnaCashier
                                                                    .length ==
                                                                    0
                                                                    ? Colors
                                                                    .white
                                                                    : warnaCashier[index] ==
                                                                    'kuning'
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    247,
                                                                    202,
                                                                    24)
                                                                    : Colors
                                                                    .white,
                                                                onPressed: () {
                                                                  setState(() {
                                                                    if (criticalCashier[
                                                                    index] ==
                                                                        'false') {
                                                                      print(
                                                                          'false');
                                                                    } else if (criticalCashier[
                                                                    index] ==
                                                                        'true') {
                                                                      if (scoreCashier[
                                                                      index] ==
                                                                          null) {
                                                                        jumlahCriticalPoint =
                                                                            jumlahCriticalPoint +
                                                                                1;
                                                                        print(
                                                                            jumlahCriticalPoint);
                                                                      } else {
                                                                        if (scoreCashier[index] ==
                                                                            2) {
                                                                          jumlahCriticalPoint =
                                                                              jumlahCriticalPoint + 1;
                                                                          print(
                                                                              jumlahCriticalPoint);
                                                                        } else if (scoreCashier[index] ==
                                                                            0 ||
                                                                            scoreCashier[index] ==
                                                                                1) {
                                                                          jumlahCriticalPoint =
                                                                              jumlahCriticalPoint + 0;
                                                                          print(
                                                                              jumlahCriticalPoint);
                                                                        }
                                                                      }
                                                                    }

                                                                    if (problemFS.length == 0) {
                                                                  
                                                                    } else {
                                                                      if (problemFS.contains(jmlCashier[index])) {
                                                                        areaFS.removeAt(problemFS.indexWhere((test) => test == jmlCashier[index]));
                                                                        rekomendasiFS.removeAt(problemFS.indexWhere((test) => test == jmlCashier[index]));
                                                                    carNoFS.removeAt(problemFS.indexWhere((test) => test == jmlCashier[index]));
                                                                        auditorFS.removeAt(problemFS.indexWhere((test) => test == jmlCashier[index]));
                                                                        auditorIDFS.removeAt(problemFS.indexWhere((test) => test == jmlCashier[index]));
                                                                        criticalFS.removeAt(problemFS.indexWhere((test) => test == jmlCashier[index]));
                                                                        subBabFS.removeAt(problemFS.indexWhere((test) => test == jmlCashier[index]));
                                                                        problemFS.removeAt(problemFS.indexWhere((test) => test == jmlCashier[index]));
                                                                      } else {
                                                                        
                                                                      }
                                                                    }

                                                                    scoreCashier
                                                                        .removeAt(
                                                                        index);
                                                                    scoreCashier
                                                                        .insert(
                                                                        index,
                                                                        1);
                                                                    warnaCashier
                                                                        .removeAt(
                                                                        index);
                                                                    warnaCashier
                                                                        .insert(
                                                                        index,
                                                                        'kuning');

                                                                        print(problemFS);
                                                              print(areaFS);
                                                              print(criticalFS);
                                                              print(auditorFS);
                                                              print(subBabFS);
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                            alignment:
                                                            Alignment(
                                                                0.0, 0.0),
                                                          ),
                                                        ),
                                                        jawabanSplitCashier[2] ==
                                                            'null'
                                                            ? Container()
                                                            : Tooltip(
                                                          message:
                                                          jawabanSplitCashier ==
                                                              null
                                                              ? ''
                                                              : jawabanSplitCashier[
                                                          2],
                                                          preferBelow: false,
                                                          child: Container(
                                                            child: ButtonTheme(
                                                              minWidth: 50.0,
                                                              height: 50.0,
                                                              child:
                                                              RaisedButton(
                                                                shape:
                                                                new RoundedRectangleBorder(
                                                                  borderRadius:
                                                                  new BorderRadius
                                                                      .circular(
                                                                      5.0),
                                                                  side:
                                                                  BorderSide(
                                                                    width: 1.5,
                                                                    color: warnaCashier.length ==
                                                                        0
                                                                        ? Color.fromARGB(
                                                                        170,
                                                                        192,
                                                                        192,
                                                                        192)
                                                                        : warnaCashier[index] ==
                                                                        'hijau'
                                                                        ? Colors
                                                                        .white
                                                                        : Color.fromARGB(
                                                                        170,
                                                                        192,
                                                                        192,
                                                                        192),
                                                                  ),
                                                                ),
                                                                child: Text(
                                                                  '2',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                      18.0,
                                                                      color: warnaCashier.length ==
                                                                          0
                                                                          ? Color.fromARGB(
                                                                          170,
                                                                          50,
                                                                          205,
                                                                          50)
                                                                          : warnaCashier[index] == 'hijau'
                                                                          ? Colors.white
                                                                          : Color.fromARGB(170, 50, 205, 50)),
                                                                  textAlign:
                                                                  TextAlign
                                                                      .center,
                                                                ),
                                                                color: warnaCashier
                                                                    .length ==
                                                                    0
                                                                    ? Colors
                                                                    .white
                                                                    : warnaCashier[index] ==
                                                                    'hijau'
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    50,
                                                                    205,
                                                                    50)
                                                                    : Colors
                                                                    .white,
                                                                onPressed: () {
                                                                  setState(() {
                                                                    if (criticalCashier[
                                                                    index] ==
                                                                        'false') {
                                                                      print(
                                                                          'false');
                                                                    } else if (criticalCashier[
                                                                    index] ==
                                                                        'true') {
                                                                      if (scoreCashier[
                                                                      index] ==
                                                                          2) {
                                                                        jumlahCriticalPoint =
                                                                            jumlahCriticalPoint +
                                                                                0;
                                                                        print(
                                                                            jumlahCriticalPoint);
                                                                      } else {
                                                                        if (scoreCashier[index] ==
                                                                            2) {
                                                                          jumlahCriticalPoint =
                                                                              jumlahCriticalPoint + 0;
                                                                          print(
                                                                              jumlahCriticalPoint);
                                                                        } else if (scoreCashier[index] ==
                                                                            0 ||
                                                                            scoreCashier[index] ==
                                                                                1) {
                                                                          jumlahCriticalPoint =
                                                                              jumlahCriticalPoint - 1;
                                                                          print(
                                                                              jumlahCriticalPoint);
                                                                        }
                                                                      }
                                                                    }

                                                                    if (problemFS.length == 0) {
                                                                  
                                                                    } else {
                                                                      if (problemFS.contains(jmlCashier[index])) {
                                                                        areaFS.removeAt(problemFS.indexWhere((test) => test == jmlCashier[index]));
                                                                        rekomendasiFS.removeAt(problemFS.indexWhere((test) => test == jmlCashier[index]));
                                                                    carNoFS.removeAt(problemFS.indexWhere((test) => test == jmlCashier[index]));
                                                                        auditorFS.removeAt(problemFS.indexWhere((test) => test == jmlCashier[index]));
                                                                        auditorIDFS.removeAt(problemFS.indexWhere((test) => test == jmlCashier[index]));
                                                                        criticalFS.removeAt(problemFS.indexWhere((test) => test == jmlCashier[index]));
                                                                        subBabFS.removeAt(problemFS.indexWhere((test) => test == jmlCashier[index]));
                                                                        problemFS.removeAt(problemFS.indexWhere((test) => test == jmlCashier[index]));
                                                                      } else {
                                                                        
                                                                      }
                                                                    }

                                                                    scoreCashier
                                                                        .removeAt(
                                                                        index);
                                                                    scoreCashier
                                                                        .insert(
                                                                        index,
                                                                        2);
                                                                    warnaCashier
                                                                        .removeAt(
                                                                        index);
                                                                    warnaCashier
                                                                        .insert(
                                                                        index,
                                                                        'hijau');

                                                                        print(problemFS);
                                                              print(areaFS);
                                                              print(criticalFS);
                                                              print(auditorFS);
                                                              print(subBabFS);
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                            alignment:
                                                            Alignment(
                                                                0.0, 0.0),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : Container(),
                                              widget.subArea.contains('Cashier')
                                                ? Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
                                                        imageCashier[index] == null
                                                          ? IconButton(
                                                              icon: Icon(Icons.camera_alt, color: AbubaPallate.greenabuba),
                                                              onPressed: () async {
                                                                var selectedImage =
                                                                await ImagePicker.pickImage(source: ImageSource.camera, maxHeight: 400.0, maxWidth: 400.0);
                                                                
                                                                imageCashier1 = selectedImage;
                                                                filenameCashier1 = basename(imageCashier1.path);

                                                                StorageReference strRef = FirebaseStorage.instance.ref().child(filenameCashier1);
                                                                StorageUploadTask uploadTask = strRef.putFile(imageCashier1);

                                                                var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
                                                                var url = downUrl.toString();

                                                                setState(() {
                                                                  if (imageCashier[index] != null) {
                                                                    List<String> bantuImageCashier = [];
                                                                    List<String> bantuImageCashierSave = [];
                                                                    bantuImageCashier = imageCashier[index].split('###');
                                                                    bantuImageCashier.add(filenameCashier1);
                                                                    imageCashier[index] = bantuImageCashier.join('###');

                                                                    bantuImageCashierSave = imageCashierSave[index].split('###');
                                                                    bantuImageCashierSave.add(url);
                                                                    imageCashierSave[index] = bantuImageCashierSave.join('###');
                                                                  } else {
                                                                    imageCashier[index] = filenameCashier1;
                                                                    imageCashierSave[index] = url;
                                                                  }
                                                                  // imageCashierBantu[index] = imageCashier1;
                                                                  print(imageCashier);
                                                                  print(imageCashierSave);
                                                                  print(imageCashier[index].split('###').length);
                                                                  print(imageCashierSave[index].split('###').length);
                                                                });
                                                              },
                                                            )
                                                          : imageCashier[index].split('###').length >= 5
                                                              ? IconButton(
                                                                  icon: Icon(Icons.disc_full, color: Colors.grey),
                                                                  onPressed: () {},
                                                                  tooltip: 'Sudah mencapai batas maksimal 5 foto tiap pertanyaan',
                                                                )
                                                              : IconButton(
                                                                  icon: Icon(Icons.camera_alt, color: AbubaPallate.greenabuba),
                                                                  onPressed: () async {
                                                                    var selectedImage =
                                                                    await ImagePicker.pickImage(source: ImageSource.camera, maxHeight: 400.0, maxWidth: 400.0);
                                                                    
                                                                    imageCashier1 = selectedImage;
                                                                    filenameCashier1 = basename(imageCashier1.path);

                                                                    StorageReference strRef = FirebaseStorage.instance.ref().child(filenameCashier1);
                                                                    StorageUploadTask uploadTask = strRef.putFile(imageCashier1);

                                                                    var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
                                                                    var url = downUrl.toString();

                                                                    setState(() {
                                                                      if (imageCashier[index] != null) {
                                                                        List<String> bantuImageCashier = [];
                                                                        List<String> bantuImageCashierSave = [];
                                                                        bantuImageCashier = imageCashier[index].split('###');
                                                                        bantuImageCashier.add(filenameCashier1);
                                                                        imageCashier[index] = bantuImageCashier.join('###');

                                                                        bantuImageCashierSave = imageCashierSave[index].split('###');
                                                                        bantuImageCashierSave.add(url);
                                                                        imageCashierSave[index] = bantuImageCashierSave.join('###');
                                                                      } else {
                                                                        imageCashier[index] = filenameCashier1;
                                                                        imageCashierSave[index] = url;
                                                                      }
                                                                      // imageCashierBantu[index] = imageCashier1;
                                                                      print(imageCashier);
                                                                      print(imageCashierSave);
                                                                      print(imageCashier[index].split('###').length);
                                                                      print(imageCashierSave[index].split('###').length);
                                                                    });
                                                                  },
                                                                ),
                                                        IconButton(
                                                          icon: Icon(Icons.event_note,
                                                              color: AbubaPallate
                                                                  .greenabuba),
                                                          onPressed: () {
                                                            if (noteCashier[index] ==
                                                                null) {
                                                              _controllerCashier
                                                                  .text = '';
                                                            } else {
                                                              _controllerCashier
                                                                  .text =
                                                              noteCashier[index];
                                                            }
                                                            showDialog(
                                                              context: context,
                                                              builder: (context) {
                                                                return AlertDialog(
                                                                  title: Text('NOTE'),
                                                                  content: Container(
                                                                    width: 300.0,
                                                                    child: TextField(
                                                                      controller:
                                                                      _controllerCashier,
                                                                      decoration:
                                                                      InputDecoration(
                                                                        border:
                                                                        OutlineInputBorder(),
                                                                        hintText:
                                                                        'Note',
                                                                        hintStyle: TextStyle(
                                                                            fontSize:
                                                                            12.0),
                                                                      ),
                                                                      maxLines: 3,
                                                                      style:
                                                                      TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  actions: <Widget>[
                                                                    FlatButton(
                                                                      splashColor: Colors
                                                                          .greenAccent,
                                                                      child: Text(
                                                                        'OK',
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .green),
                                                                      ),
                                                                      onPressed: () {
                                                                        noteCashier
                                                                            .removeAt(
                                                                            index);
                                                                        noteCashier.insert(
                                                                            index,
                                                                            _controllerCashier
                                                                                .text);
                                                                        print(
                                                                            noteCashier);
                                                                        Navigator.of(
                                                                            context)
                                                                            .pop();
                                                                      },
                                                                    )
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : Container(),
                                              Divider(
                                                height: 2.0,
                                              )
                                            ],
                                          );
                                        }).toList(),
                                  ),
                                ),
                              );
                            }),
                        PreferredSize(
                          preferredSize: Size.fromHeight(
                              MediaQuery.of(context).size.height -
                                  55.0 -
                                  (MediaQuery.of(context).size.height * 0.7)),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 55.0,
                                child: Container(
                                    child: Padding(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: <Widget>[
                                              IconButton(
                                                icon: Icon(Icons.arrow_back_ios,
                                                    color: Colors.white),
                                                onPressed: () {
                                                  _cardController.animateTo(
                                                      _cardController.index - 1);
                                                },
                                                tooltip: 'Previous',
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.arrow_forward_ios,
                                                    color: Colors.white),
                                                onPressed: () {
                                                  if (widget.subArea.contains('Cashier')) {
                                                    if (scoreCashier[indexCashier] ==
                                                        null) {
                                                      showDialog(
                                                        barrierDismissible: false,
                                                        context: context,
                                                        builder: (context) => Dialog(
                                                          child: Container(
                                                            height: 180.0,
                                                            child: Column(
                                                              children: <Widget>[
                                                                Container(
                                                                  color: AbubaPallate
                                                                      .greenabuba,
                                                                  height: 50.0,
                                                                  child: Center(
                                                                    child: Text(
                                                                      'OOPS!',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                          17.0,
                                                                          fontWeight:
                                                                          FontWeight.w700),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 20.0,
                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                      10.0,
                                                                      vertical:
                                                                      10.0),
                                                                  child: Text(
                                                                    'Please select the answer!',
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      16.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                                  children: <
                                                                      Widget>[
                                                                    FlatButton(
                                                                      child: Text(
                                                                          'OK'),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      hasilCashier = 0;
                                                      for (int i = 0; i < scoreCashier.length; i++) {
                                                        hasilCashier += double.tryParse(bobotPertanyaanCashier[i].toString()) * double.tryParse(scoreCashier[i].toString());
                                                      }
                                                      hasilCashier = hasilCashier / 2;
                                                      // if (hasilCashier > 1.0) {
                                                      //   hasilCashier = 1.0;
                                                      // } else {
                                                      //   hasilCashier = hasilCashier;
                                                      // }
                                                      // // sini coy
                                                      // finalCashier = (hasilCashier * parameterCashier) / 100;

                                                      print(bobotPertanyaanCashier);
                                                      print(scoreCashier);
                                                      print(hasilCashier);
                                                      // print(finalCashier);
                                                      _cardController.animateTo(_cardController.index + 1);
                                                    }
                                                  } else {
                                                    print(bobotPertanyaanCashier);
                                                    print(scoreCashier);
                                                    print(hasilCashier);
                                                    print(finalCashier);
                                                    _cardController.animateTo(_cardController.index + 1);
                                                  }
                                                },
                                                tooltip: 'Next',
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    decoration:
                                    BoxDecoration(color: Color(0xFF2F592F))),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                // Administrasi Keuangan
                ListView(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      children: <Widget>[
                        PreferredSize(
                          preferredSize: Size.fromHeight(55.0),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 55.0,
                                child: Container(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.75,
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                softWrap: true,
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.ellipsis,
                                                text: TextSpan(
                                                  text: 'Administrasi Keuangan',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17.0
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.75,
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                softWrap: true,
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.ellipsis,
                                                text: TextSpan(
                                                  text: 'Auditor : ${auditorName[4].toString()}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11.0
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '5 of ${_listData.length.toString()}',
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 14.0),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF2F592F),
                                  ),
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
                                alignment: Alignment(0.0, 0.0),
                                height: MediaQuery.of(context).size.height *
                                    0.736,
                              )
                                  : Container(
                                height: MediaQuery.of(context).size.height *
                                    0.736,
                                color: Colors.white,
                                child: Scrollbar(
                                  child: ListView(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    children: List.generate(
                                        jmlCashierAccuracy.length, (index) {
                                      indexCashierAccuracy = index;
                                      jawabanSplitCashierAccuracy =
                                          jawabanSplitCashierAccuracyBantu[
                                          index]
                                              .split(r"!@#$");
                                      if (scoreCashierAccuracy.length <
                                          jumlahCashierAccuracy) {
                                        for (int a = 0;
                                        a < jumlahCashierAccuracy;
                                        a++) {
                                          noteCashierAccuracy.add(null);
                                          scoreCashierAccuracy.add(null);
                                          imageCashierAccuracy.add(null);
                                          imageCashierAccuracyBantu.add(null);
                                          imageCashierAccuracySave.add(null);
                                          warnaCashierAccuracy.add('abu');
                                        }
                                      }

                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          criticalCashierAccuracy[index] ==
                                              'false'
                                              ? Padding(
                                            padding: EdgeInsets.only(
                                                right: 15.0,
                                                left: 15.0,
                                                bottom: 8.0,
                                                top: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    systemCashierAccuracy[
                                                    index],
                                                    style: TextStyle(
                                                        color: Colors
                                                            .green,
                                                        fontWeight:
                                                        FontWeight
                                                            .w700,
                                                        fontSize: 16.0),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                              : Padding(
                                            padding: EdgeInsets.only(
                                                right: 15.0,
                                                left: 15.0,
                                                bottom: 8.0,
                                                top: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    systemCashierAccuracy[
                                                    index],
                                                    style: TextStyle(
                                                        color: Colors
                                                            .green,
                                                        fontWeight:
                                                        FontWeight
                                                            .w700,
                                                        fontSize: 16.0),
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    'CRITICAL',
                                                    style: TextStyle(
                                                        color:
                                                        Colors.red,
                                                        fontWeight:
                                                        FontWeight
                                                            .w700,
                                                        fontSize: 16.0),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 15.0,
                                                      left: 15.0,
                                                      top: 10.0,
                                                      bottom: 50.0),
                                                  child: Text(
                                                    jmlCashierAccuracy[index],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18.0),
                                                    textAlign:
                                                    TextAlign.start,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          widget.subArea.contains('Administrasi Keuangan')
                                            ? Padding(
                                                padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 15.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: <Widget>[
                                                    jawabanSplitCashierAccuracy[
                                                    0] ==
                                                        'null'
                                                        ? Container()
                                                        : Tooltip(
                                                      message:
                                                      jawabanSplitCashierAccuracy ==
                                                          null
                                                          ? ''
                                                          : jawabanSplitCashierAccuracy[
                                                      0],
                                                      preferBelow: false,
                                                      child: Container(
                                                        child: ButtonTheme(
                                                          minWidth: 50.0,
                                                          height: 50.0,
                                                          child:
                                                          RaisedButton(
                                                            shape:
                                                            new RoundedRectangleBorder(
                                                              borderRadius:
                                                              new BorderRadius
                                                                  .circular(
                                                                  5.0),
                                                              side:
                                                              BorderSide(
                                                                width: 1.5,
                                                                color: warnaCashierAccuracy.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    192,
                                                                    192,
                                                                    192)
                                                                    : warnaCashierAccuracy[index] ==
                                                                    'merah'
                                                                    ? Colors
                                                                    .white
                                                                    : Color.fromARGB(
                                                                    170,
                                                                    192,
                                                                    192,
                                                                    192),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              '0',
                                                              style:
                                                              TextStyle(
                                                                fontSize:
                                                                18.0,
                                                                color: warnaCashierAccuracy.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    255,
                                                                    40,
                                                                    0)
                                                                    : warnaCashierAccuracy[index] ==
                                                                    'merah'
                                                                    ? Colors
                                                                    .white
                                                                    : Color.fromARGB(
                                                                    170,
                                                                    255,
                                                                    40,
                                                                    0),
                                                              ),
                                                              textAlign:
                                                              TextAlign
                                                                  .center,
                                                            ),
                                                            color: warnaCashierAccuracy
                                                                .length ==
                                                                0
                                                                ? Colors
                                                                .white
                                                                : warnaCashierAccuracy[index] ==
                                                                'merah'
                                                                ? Color.fromARGB(
                                                                170,
                                                                255,
                                                                40,
                                                                0)
                                                                : Colors
                                                                .white,
                                                            onPressed: () {
                                                              setState(() {
                                                                if (criticalCashierAccuracy[
                                                                index] ==
                                                                    'false') {
                                                                  print(
                                                                      'false');
                                                                } else if (criticalCashierAccuracy[
                                                                index] ==
                                                                    'true') {
                                                                  if (scoreCashierAccuracy[
                                                                  index] ==
                                                                      null) {
                                                                    jumlahCriticalPoint =
                                                                        jumlahCriticalPoint +
                                                                            1;
                                                                    print(
                                                                        jumlahCriticalPoint);
                                                                  } else {
                                                                    if (scoreCashierAccuracy[index] ==
                                                                        2) {
                                                                      jumlahCriticalPoint =
                                                                          jumlahCriticalPoint + 1;
                                                                      print(
                                                                          jumlahCriticalPoint);
                                                                    } else if (scoreCashierAccuracy[index] ==
                                                                        0 ||
                                                                        scoreCashierAccuracy[index] ==
                                                                            1) {
                                                                      jumlahCriticalPoint =
                                                                          jumlahCriticalPoint + 0;
                                                                      print(
                                                                          jumlahCriticalPoint);
                                                                    }
                                                                  }
                                                                }

                                                                if (problemFS.length == 0) {
                                                                  problemFS.add(jmlCashierAccuracy[index]);
                                                                  areaFS.add('Administrasi Keuangan');
                                                                  auditorFS.add(auditorName[4]);
                                                                  auditorIDFS.add(int.tryParse(widget.auditor[4].toString()));
                                                                  subBabFS.add(systemCashierAccuracy[index]);
                                                                  criticalFS.add(criticalCashierAccuracy[index] == 'false' ? 'no' : 'yes');
                                                                  rekomendasiFS.add(null);
                                                                      carNoFS.add(null);
                                                                } else {
                                                                  if (problemFS.contains(jmlCashierAccuracy[index])) {
                                                                    
                                                                  } else {
                                                                    rekomendasiFS.add(null);
                                                                      carNoFS.add(null);
                                                                    problemFS.add(jmlCashierAccuracy[index]);
                                                                    areaFS.add('Administrasi Keuangan');
                                                                    auditorFS.add(auditorName[4]);
                                                                    auditorIDFS.add(int.tryParse(widget.auditor[4].toString()));
                                                                    subBabFS.add(systemCashierAccuracy[index]);
                                                                    criticalFS.add(criticalCashierAccuracy[index] == 'false' ? 'no' : 'yes');
                                                                  }
                                                                }
                                                                
                                                                scoreCashierAccuracy
                                                                    .removeAt(
                                                                    index);
                                                                scoreCashierAccuracy
                                                                    .insert(
                                                                    index,
                                                                    0);
                                                                warnaCashierAccuracy
                                                                    .removeAt(
                                                                    index);
                                                                warnaCashierAccuracy
                                                                    .insert(
                                                                    index,
                                                                    'merah');

                                                                    print(problemFS);
                                                              print(areaFS);
                                                              print(criticalFS);
                                                              print(auditorFS);
                                                              print(subBabFS);
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        alignment:
                                                        Alignment(
                                                            0.0, 0.0),
                                                      ),
                                                    ),
                                                    jawabanSplitCashierAccuracy[
                                                    1] ==
                                                        'null'
                                                        ? Container()
                                                        : Tooltip(
                                                      message:
                                                      jawabanSplitCashierAccuracy ==
                                                          null
                                                          ? ''
                                                          : jawabanSplitCashierAccuracy[
                                                      1],
                                                      preferBelow: false,
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                            horizontal:
                                                            5.0),
                                                        child: ButtonTheme(
                                                          minWidth: 50.0,
                                                          height: 50.0,
                                                          child:
                                                          RaisedButton(
                                                            shape:
                                                            new RoundedRectangleBorder(
                                                              borderRadius:
                                                              new BorderRadius
                                                                  .circular(
                                                                  5.0),
                                                              side:
                                                              BorderSide(
                                                                width: 1.5,
                                                                color: warnaCashierAccuracy.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    192,
                                                                    192,
                                                                    192)
                                                                    : warnaCashierAccuracy[index] ==
                                                                    'kuning'
                                                                    ? Colors
                                                                    .white
                                                                    : Color.fromARGB(
                                                                    170,
                                                                    192,
                                                                    192,
                                                                    192),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              '1',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  18.0,
                                                                  color: warnaCashierAccuracy.length ==
                                                                      0
                                                                      ? Color.fromARGB(
                                                                      170,
                                                                      247,
                                                                      202,
                                                                      24)
                                                                      : warnaCashierAccuracy[index] == 'kuning'
                                                                      ? Colors.white
                                                                      : Color.fromARGB(170, 247, 202, 24)),
                                                              textAlign:
                                                              TextAlign
                                                                  .center,
                                                            ),
                                                            color: warnaCashierAccuracy
                                                                .length ==
                                                                0
                                                                ? Colors
                                                                .white
                                                                : warnaCashierAccuracy[index] ==
                                                                'kuning'
                                                                ? Color.fromARGB(
                                                                170,
                                                                247,
                                                                202,
                                                                24)
                                                                : Colors
                                                                .white,
                                                            onPressed: () {
                                                              setState(() {
                                                                if (criticalCashierAccuracy[
                                                                index] ==
                                                                    'false') {
                                                                  print(
                                                                      'false');
                                                                } else if (criticalCashierAccuracy[
                                                                index] ==
                                                                    'true') {
                                                                  if (scoreCashierAccuracy[
                                                                  index] ==
                                                                      null) {
                                                                    jumlahCriticalPoint =
                                                                        jumlahCriticalPoint +
                                                                            1;
                                                                    print(
                                                                        jumlahCriticalPoint);
                                                                  } else {
                                                                    if (scoreCashierAccuracy[index] ==
                                                                        2) {
                                                                      jumlahCriticalPoint =
                                                                          jumlahCriticalPoint + 1;
                                                                      print(
                                                                          jumlahCriticalPoint);
                                                                    } else if (scoreCashierAccuracy[index] ==
                                                                        0 ||
                                                                        scoreCashierAccuracy[index] ==
                                                                            1) {
                                                                      jumlahCriticalPoint =
                                                                          jumlahCriticalPoint + 0;
                                                                      print(
                                                                          jumlahCriticalPoint);
                                                                    }
                                                                  }
                                                                }

                                                                if (problemFS.length == 0) {
                                                                  
                                                                } else {
                                                                  if (problemFS.contains(jmlCashierAccuracy[index])) {
                                                                    areaFS.removeAt(problemFS.indexWhere((test) => test == jmlCashierAccuracy[index]));
                                                                    rekomendasiFS.removeAt(problemFS.indexWhere((test) => test == jmlCashierAccuracy[index]));
                                                                    carNoFS.removeAt(problemFS.indexWhere((test) => test == jmlCashierAccuracy[index]));
                                                                    auditorFS.removeAt(problemFS.indexWhere((test) => test == jmlCashierAccuracy[index]));
                                                                    auditorIDFS.removeAt(problemFS.indexWhere((test) => test == jmlCashierAccuracy[index]));
                                                                    criticalFS.removeAt(problemFS.indexWhere((test) => test == jmlCashierAccuracy[index]));
                                                                    subBabFS.removeAt(problemFS.indexWhere((test) => test == jmlCashierAccuracy[index]));
                                                                    problemFS.removeAt(problemFS.indexWhere((test) => test == jmlCashierAccuracy[index]));
                                                                  } else {
                                                                    
                                                                  }
                                                                }

                                                                scoreCashierAccuracy
                                                                    .removeAt(
                                                                    index);
                                                                scoreCashierAccuracy
                                                                    .insert(
                                                                    index,
                                                                    1);
                                                                warnaCashierAccuracy
                                                                    .removeAt(
                                                                    index);
                                                                warnaCashierAccuracy
                                                                    .insert(
                                                                    index,
                                                                    'kuning');

                                                                    print(problemFS);
                                                              print(areaFS);
                                                              print(criticalFS);
                                                              print(auditorFS);
                                                              print(subBabFS);
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        alignment:
                                                        Alignment(
                                                            0.0, 0.0),
                                                      ),
                                                    ),
                                                    jawabanSplitCashierAccuracy[
                                                    2] ==
                                                        'null'
                                                        ? Container()
                                                        : Tooltip(
                                                      message:
                                                      jawabanSplitCashierAccuracy ==
                                                          null
                                                          ? ''
                                                          : jawabanSplitCashierAccuracy[
                                                      2],
                                                      preferBelow: false,
                                                      child: Container(
                                                        child: ButtonTheme(
                                                          minWidth: 50.0,
                                                          height: 50.0,
                                                          child:
                                                          RaisedButton(
                                                            shape:
                                                            new RoundedRectangleBorder(
                                                              borderRadius:
                                                              new BorderRadius
                                                                  .circular(
                                                                  5.0),
                                                              side:
                                                              BorderSide(
                                                                width: 1.5,
                                                                color: warnaCashierAccuracy.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    192,
                                                                    192,
                                                                    192)
                                                                    : warnaCashierAccuracy[index] ==
                                                                    'hijau'
                                                                    ? Colors
                                                                    .white
                                                                    : Color.fromARGB(
                                                                    170,
                                                                    192,
                                                                    192,
                                                                    192),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              '2',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  18.0,
                                                                  color: warnaCashierAccuracy.length ==
                                                                      0
                                                                      ? Color.fromARGB(
                                                                      170,
                                                                      50,
                                                                      205,
                                                                      50)
                                                                      : warnaCashierAccuracy[index] == 'hijau'
                                                                      ? Colors.white
                                                                      : Color.fromARGB(170, 50, 205, 50)),
                                                              textAlign:
                                                              TextAlign
                                                                  .center,
                                                            ),
                                                            color: warnaCashierAccuracy
                                                                .length ==
                                                                0
                                                                ? Colors
                                                                .white
                                                                : warnaCashierAccuracy[index] ==
                                                                'hijau'
                                                                ? Color.fromARGB(
                                                                170,
                                                                50,
                                                                205,
                                                                50)
                                                                : Colors
                                                                .white,
                                                            onPressed: () {
                                                              setState(() {
                                                                if (criticalCashierAccuracy[
                                                                index] ==
                                                                    'false') {
                                                                  print(
                                                                      'false');
                                                                } else if (criticalCashierAccuracy[
                                                                index] ==
                                                                    'true') {
                                                                  if (scoreCashierAccuracy[
                                                                  index] ==
                                                                      2) {
                                                                    jumlahCriticalPoint =
                                                                        jumlahCriticalPoint +
                                                                            0;
                                                                    print(
                                                                        jumlahCriticalPoint);
                                                                  } else {
                                                                    if (scoreCashierAccuracy[index] ==
                                                                        2) {
                                                                      jumlahCriticalPoint =
                                                                          jumlahCriticalPoint + 0;
                                                                      print(
                                                                          jumlahCriticalPoint);
                                                                    } else if (scoreCashierAccuracy[index] ==
                                                                        0 ||
                                                                        scoreCashierAccuracy[index] ==
                                                                            1) {
                                                                      jumlahCriticalPoint =
                                                                          jumlahCriticalPoint - 1;
                                                                      print(
                                                                          jumlahCriticalPoint);
                                                                    }
                                                                  }
                                                                }

                                                                if (problemFS.length == 0) {
                                                                  
                                                                } else {
                                                                  if (problemFS.contains(jmlCashierAccuracy[index])) {
                                                                    areaFS.removeAt(problemFS.indexWhere((test) => test == jmlCashierAccuracy[index]));
                                                                    rekomendasiFS.removeAt(problemFS.indexWhere((test) => test == jmlCashierAccuracy[index]));
                                                                    carNoFS.removeAt(problemFS.indexWhere((test) => test == jmlCashierAccuracy[index]));
                                                                    auditorFS.removeAt(problemFS.indexWhere((test) => test == jmlCashierAccuracy[index]));
                                                                    auditorIDFS.removeAt(problemFS.indexWhere((test) => test == jmlCashierAccuracy[index]));
                                                                    criticalFS.removeAt(problemFS.indexWhere((test) => test == jmlCashierAccuracy[index]));
                                                                    subBabFS.removeAt(problemFS.indexWhere((test) => test == jmlCashierAccuracy[index]));
                                                                    problemFS.removeAt(problemFS.indexWhere((test) => test == jmlCashierAccuracy[index]));
                                                                  } else {
                                                                    
                                                                  }
                                                                }

                                                                scoreCashierAccuracy
                                                                    .removeAt(
                                                                    index);
                                                                scoreCashierAccuracy.insert(index, 2);
                                                                warnaCashierAccuracy
                                                                    .removeAt(
                                                                    index);
                                                                warnaCashierAccuracy
                                                                    .insert(
                                                                    index,
                                                                    'hijau');

                                                                    print(problemFS);
                                                              print(areaFS);
                                                              print(criticalFS);
                                                              print(auditorFS);
                                                              print(subBabFS);
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        alignment:
                                                        Alignment(
                                                            0.0, 0.0),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                          widget.subArea.contains('Administrasi Keuangan')
                                            ? Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    imageCashierAccuracy[index] == null
                                                      ? IconButton(
                                                          icon: Icon(Icons.camera_alt, color: AbubaPallate.greenabuba),
                                                          onPressed: () async {
                                                            var selectedImage =
                                                            await ImagePicker.pickImage(source: ImageSource.camera, maxHeight: 400.0, maxWidth: 400.0);
                                                            
                                                            imageCashierAccuracy1 = selectedImage;
                                                            filenameCashierAccuracy1 = basename(imageCashierAccuracy1.path);

                                                            StorageReference strRef = FirebaseStorage.instance.ref().child(filenameCashierAccuracy1);
                                                            StorageUploadTask uploadTask = strRef.putFile(imageCashierAccuracy1);

                                                            var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
                                                            var url = downUrl.toString();

                                                            setState(() {
                                                              if (imageCashierAccuracy[index] != null) {
                                                                List<String> bantuImageCashierAccuracy = [];
                                                                List<String> bantuImageCashierAccuracySave = [];
                                                                bantuImageCashierAccuracy = imageCashierAccuracy[index].split('###');
                                                                bantuImageCashierAccuracy.add(filenameCashierAccuracy1);
                                                                imageCashierAccuracy[index] = bantuImageCashierAccuracy.join('###');

                                                                bantuImageCashierAccuracySave = imageCashierAccuracySave[index].split('###');
                                                                bantuImageCashierAccuracySave.add(url);
                                                                imageCashierAccuracySave[index] = bantuImageCashierAccuracySave.join('###');
                                                              } else {
                                                                imageCashierAccuracy[index] = filenameCashierAccuracy1;
                                                                imageCashierAccuracySave[index] = url;
                                                              }
                                                              // imageCashierAccuracyBantu[index] = imageCashierAccuracy1;
                                                              print(imageCashierAccuracy);
                                                              print(imageCashierAccuracySave);
                                                              print(imageCashierAccuracy[index].split('###').length);
                                                              print(imageCashierAccuracySave[index].split('###').length);
                                                            });
                                                          },
                                                        )
                                                      : imageCashierAccuracy[index].split('###').length >= 5
                                                          ? IconButton(
                                                              icon: Icon(Icons.disc_full, color: Colors.grey),
                                                              onPressed: () {},
                                                              tooltip: 'Sudah mencapai batas maksimal 5 foto tiap pertanyaan',
                                                            )
                                                          : IconButton(
                                                              icon: Icon(Icons.camera_alt, color: AbubaPallate.greenabuba),
                                                              onPressed: () async {
                                                                var selectedImage =
                                                                await ImagePicker.pickImage(source: ImageSource.camera, maxHeight: 400.0, maxWidth: 400.0);
                                                                
                                                                imageCashierAccuracy1 = selectedImage;
                                                                filenameCashierAccuracy1 = basename(imageCashierAccuracy1.path);

                                                                StorageReference strRef = FirebaseStorage.instance.ref().child(filenameCashierAccuracy1);
                                                                StorageUploadTask uploadTask = strRef.putFile(imageCashierAccuracy1);

                                                                var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
                                                                var url = downUrl.toString();

                                                                setState(() {
                                                                  if (imageCashierAccuracy[index] != null) {
                                                                    List<String> bantuImageCashierAccuracy = [];
                                                                    List<String> bantuImageCashierAccuracySave = [];
                                                                    bantuImageCashierAccuracy = imageCashierAccuracy[index].split('###');
                                                                    bantuImageCashierAccuracy.add(filenameCashierAccuracy1);
                                                                    imageCashierAccuracy[index] = bantuImageCashierAccuracy.join('###');

                                                                    bantuImageCashierAccuracySave = imageCashierAccuracySave[index].split('###');
                                                                    bantuImageCashierAccuracySave.add(url);
                                                                    imageCashierAccuracySave[index] = bantuImageCashierAccuracySave.join('###');
                                                                  } else {
                                                                    imageCashierAccuracy[index] = filenameCashierAccuracy1;
                                                                    imageCashierAccuracySave[index] = url;
                                                                  }
                                                                  // imageCashierAccuracyBantu[index] = imageCashierAccuracy1;
                                                                  print(imageCashierAccuracy);
                                                                  print(imageCashierAccuracySave);
                                                                  print(imageCashierAccuracy[index].split('###').length);
                                                                  print(imageCashierAccuracySave[index].split('###').length);
                                                                });
                                                              },
                                                            ),
                                                    templateCount[index] != null
                                                      ? Container(
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
                                                                  image: AssetImage('assets/images/templateCount.png'),
                                                                  fit: BoxFit.fitWidth,
                                                                )
                                                              ),
                                                            ),
                                                            onPressed: () {
                                                              if (templateCount[index] == 'cash') {
                                                                Navigator.push(context, 
                                                                  MaterialPageRoute(
                                                                    builder: (_) => DetailCash(departmentUser: widget.departmentUser, idUser: widget.idUser, index: widget.index, namaUser: widget.namaUser)
                                                                  )
                                                                );
                                                              } else if (templateCount[index] == 'inventory') {
                                                                Navigator.push(context, 
                                                                  MaterialPageRoute(
                                                                    builder: (_) => DetailInventory(departmentUser: widget.departmentUser, idUser: widget.idUser, index: widget.index, namaUser: widget.namaUser)
                                                                  )
                                                                );
                                                              } else if (templateCount[index] == 'equipment') {
                                                                Navigator.push(context, 
                                                                  MaterialPageRoute(
                                                                    builder: (_) => DetailEquipment(departmentUser: widget.departmentUser, idUser: widget.idUser, index: widget.index, namaUser: widget.namaUser)
                                                                  )
                                                                );
                                                              } else if (templateCount[index] == 'assets') {
                                                                Navigator.push(context, 
                                                                  MaterialPageRoute(
                                                                    builder: (_) => DetailAssets(departmentUser: widget.departmentUser, idUser: widget.idUser, index: widget.index, namaUser: widget.namaUser)
                                                                  )
                                                                );
                                                              } else {}
                                                            },
                                                          ),
                                                        )
                                                      : Container(),
                                                    IconButton(
                                                      icon: Icon(Icons.event_note, color: AbubaPallate.greenabuba),
                                                      onPressed: () {
                                                        if (noteCashierAccuracy[index] == null) {
                                                          _controllerCashierAccuracy.text = '';
                                                        } else {
                                                          _controllerCashierAccuracy.text =
                                                          noteCashierAccuracy[index];
                                                        }
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              title: Text('NOTE'),
                                                              content: Container(
                                                                width: 300.0,
                                                                child: TextField(
                                                                  controller:
                                                                  _controllerCashierAccuracy,
                                                                  decoration:
                                                                  InputDecoration(
                                                                    border:
                                                                    OutlineInputBorder(),
                                                                    hintText:
                                                                    'Note',
                                                                    hintStyle: TextStyle(
                                                                      fontSize: 12.0
                                                                    ),
                                                                  ),
                                                                  maxLines: 3,
                                                                  style: TextStyle(
                                                                    color: Colors.black,
                                                                  ),
                                                                ),
                                                              ),
                                                              actions: <Widget>[
                                                                FlatButton(
                                                                  splashColor: Colors.greenAccent,
                                                                  child: Text(
                                                                    'OK',
                                                                    style: TextStyle(
                                                                      color: Colors.green
                                                                    ),
                                                                  ),
                                                                  onPressed: () {
                                                                    noteCashierAccuracy.removeAt(index);
                                                                    noteCashierAccuracy.insert(index, _controllerCashierAccuracy.text);
                                                                    print(noteCashierAccuracy);
                                                                    Navigator.of(context).pop();
                                                                  },
                                                                )
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                          Divider(
                                            height: 2.0,
                                          )
                                        ],
                                      );
                                    }).toList(),
                                  ),
                                ),
                              );
                            }),
                        PreferredSize(
                          preferredSize: Size.fromHeight(
                              MediaQuery.of(context).size.height -
                                  55.0 -
                                  (MediaQuery.of(context).size.height * 0.7)),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 55.0,
                                child: Container(
                                    child: Padding(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: <Widget>[
                                              IconButton(
                                                icon: Icon(Icons.arrow_back_ios,
                                                    color: Colors.white),
                                                onPressed: () {
                                                  _cardController.animateTo(
                                                      _cardController.index - 1);
                                                },
                                                tooltip: 'Previous',
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.arrow_forward_ios,
                                                    color: Colors.white),
                                                onPressed: () {
                                                  if (widget.subArea.contains('Administrasi Keuangan')) {
                                                    if (scoreCashierAccuracy[
                                                    indexCashierAccuracy] ==
                                                        null) {
                                                      showDialog(
                                                        barrierDismissible: false,
                                                        context: context,
                                                        builder: (context) => Dialog(
                                                          child: Container(
                                                            height: 180.0,
                                                            child: Column(
                                                              children: <Widget>[
                                                                Container(
                                                                  color: AbubaPallate
                                                                      .greenabuba,
                                                                  height: 50.0,
                                                                  child: Center(
                                                                    child: Text(
                                                                      'OOPS!',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                          17.0,
                                                                          fontWeight:
                                                                          FontWeight.w700),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 20.0,
                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                      10.0,
                                                                      vertical:
                                                                      10.0),
                                                                  child: Text(
                                                                    'Please select the answer!',
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      16.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                                  children: <
                                                                      Widget>[
                                                                    FlatButton(
                                                                      child: Text(
                                                                          'OK'),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      hasilCashierAccuracy = 0;
                                                      for (int i = 0;
                                                      i <
                                                          scoreCashierAccuracy
                                                              .length;
                                                      i++) {
                                                        hasilCashierAccuracy += double
                                                            .tryParse(
                                                            bobotPertanyaanCashierAccuracy[
                                                            i]
                                                                .toString()) *
                                                            double.tryParse(
                                                                scoreCashierAccuracy[
                                                                i]
                                                                    .toString());
                                                      }
                                                      hasilCashierAccuracy = hasilCashierAccuracy / 2;
                                                      // if (hasilCashierAccuracy >
                                                      //     1.0) {
                                                      //   hasilCashierAccuracy = 1.0;
                                                      // } else {
                                                      //   hasilCashierAccuracy =
                                                      //       hasilCashierAccuracy;
                                                      // }
                                                      // finalCashierAccuracy =
                                                      //     (hasilCashierAccuracy *
                                                      //         parameterCashierAccuracy) /
                                                      //         100;

                                                      print(bobotPertanyaanCashierAccuracy);
                                                      print(scoreCashierAccuracy);
                                                      print(hasilCashierAccuracy);
                                                      // print(finalCashierAccuracy);
                                                      _cardController.animateTo(_cardController.index + 1);
                                                    }
                                                  } else {
                                                    print(bobotPertanyaanCashierAccuracy);
                                                    print(scoreCashierAccuracy);
                                                    print(hasilCashierAccuracy);
                                                    print(finalCashierAccuracy);
                                                    _cardController.animateTo(_cardController.index + 1);
                                                  }
                                                },
                                                tooltip: 'Next',
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    decoration:
                                    BoxDecoration(color: Color(0xFF2F592F))),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                // sini back of the house
                ListView(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      children: <Widget>[
                        PreferredSize(
                          preferredSize: Size.fromHeight(55.0),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 55.0,
                                child: Container(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.75,
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                text: TextSpan(
                                                  text: 'Back of The House (BOH)',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17.0
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.75,
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                text: TextSpan(
                                                  text: 'Auditor : ${auditorName[5].toString()}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11.0
                                                  ),
                                                ),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '6 of ${_listData.length.toString()}',
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 14.0),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF2F592F),
                                  ),
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
                                alignment: Alignment(0.0, 0.0),
                                height: MediaQuery.of(context).size.height *
                                    0.736,
                              )
                                  : Container(
                                height: MediaQuery.of(context).size.height *
                                    0.736,
                                color: Colors.white,
                                child: Scrollbar(
                                  child: ListView(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    children:
                                    List.generate(jmlBoh.length, (index) {
                                      indexBoh = index;
                                      jawabanSplitBoh =
                                          jawabanSplitBohBantu[index]
                                              .split(r"!@#$");
                                      if (scoreBoh.length < jumlahBoh) {
                                        for (int a = 0; a < jumlahBoh; a++) {
                                          noteBoh.add(null);
                                          scoreBoh.add(null);
                                          imageBoh.add(null);
                                          imageBohBantu.add(null);
                                          imageBohSave.add(null);
                                          warnaBoh.add('abu');
                                        }
                                      }

                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          criticalBoh[index] == 'false'
                                              ? Padding(
                                            padding: EdgeInsets.only(
                                                right: 15.0,
                                                left: 15.0,
                                                bottom: 8.0,
                                                top: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    systemBoh[index],
                                                    style: TextStyle(
                                                        color: Colors
                                                            .green,
                                                        fontWeight:
                                                        FontWeight
                                                            .w700,
                                                        fontSize: 16.0),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                              : Padding(
                                            padding: EdgeInsets.only(
                                                right: 15.0,
                                                left: 15.0,
                                                bottom: 8.0,
                                                top: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    systemBoh[index],
                                                    style: TextStyle(
                                                        color: Colors
                                                            .green,
                                                        fontWeight:
                                                        FontWeight
                                                            .w700,
                                                        fontSize: 16.0),
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    'CRITICAL',
                                                    style: TextStyle(
                                                        color:
                                                        Colors.red,
                                                        fontWeight:
                                                        FontWeight
                                                            .w700,
                                                        fontSize: 16.0),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 15.0,
                                                      left: 15.0,
                                                      top: 10.0,
                                                      bottom: 50.0),
                                                  child: Text(
                                                    jmlBoh[index],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18.0),
                                                    textAlign:
                                                    TextAlign.start,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          widget.subArea.contains('Back of The House (BOH)')
                                            ? Padding(
                                                padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 15.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: <Widget>[
                                                    jawabanSplitBoh[0] == 'null'
                                                        ? Container()
                                                        : Tooltip(
                                                      message:
                                                      jawabanSplitBoh ==
                                                          null
                                                          ? ''
                                                          : jawabanSplitBoh[
                                                      0],
                                                      preferBelow: false,
                                                      child: Container(
                                                        child: ButtonTheme(
                                                          minWidth: 50.0,
                                                          height: 50.0,
                                                          child:
                                                          RaisedButton(
                                                            shape:
                                                            new RoundedRectangleBorder(
                                                              borderRadius:
                                                              new BorderRadius
                                                                  .circular(
                                                                  5.0),
                                                              side:
                                                              BorderSide(
                                                                width: 1.5,
                                                                color: warnaBoh.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    192,
                                                                    192,
                                                                    192)
                                                                    : warnaBoh[index] ==
                                                                    'merah'
                                                                    ? Colors
                                                                    .white
                                                                    : Color.fromARGB(
                                                                    170,
                                                                    192,
                                                                    192,
                                                                    192),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              '0',
                                                              style:
                                                              TextStyle(
                                                                fontSize:
                                                                18.0,
                                                                color: warnaBoh.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    255,
                                                                    40,
                                                                    0)
                                                                    : warnaBoh[index] ==
                                                                    'merah'
                                                                    ? Colors
                                                                    .white
                                                                    : Color.fromARGB(
                                                                    170,
                                                                    255,
                                                                    40,
                                                                    0),
                                                              ),
                                                              textAlign:
                                                              TextAlign
                                                                  .center,
                                                            ),
                                                            color: warnaBoh
                                                                .length ==
                                                                0
                                                                ? Colors
                                                                .white
                                                                : warnaBoh[index] ==
                                                                'merah'
                                                                ? Color.fromARGB(
                                                                170,
                                                                255,
                                                                40,
                                                                0)
                                                                : Colors
                                                                .white,
                                                            onPressed: () {
                                                              setState(() {
                                                                if (criticalBoh[
                                                                index] ==
                                                                    'false') {
                                                                  print(
                                                                      'false');
                                                                } else if (criticalBoh[
                                                                index] ==
                                                                    'true') {
                                                                  if (scoreBoh[
                                                                  index] ==
                                                                      null) {
                                                                    jumlahCriticalPoint =
                                                                        jumlahCriticalPoint +
                                                                            1;
                                                                    print(
                                                                        jumlahCriticalPoint);
                                                                  } else {
                                                                    if (scoreBoh[index] ==
                                                                        2) {
                                                                      jumlahCriticalPoint =
                                                                          jumlahCriticalPoint + 1;
                                                                      print(
                                                                          jumlahCriticalPoint);
                                                                    } else if (scoreBoh[index] ==
                                                                        0 ||
                                                                        scoreBoh[index] ==
                                                                            1) {
                                                                      jumlahCriticalPoint =
                                                                          jumlahCriticalPoint + 0;
                                                                      print(
                                                                          jumlahCriticalPoint);
                                                                    }
                                                                  }
                                                                }

                                                                if (problemFS.length == 0) {
                                                                  problemFS.add(jmlBoh[index]);
                                                                  areaFS.add('Back of The House (BOH)');
                                                                  auditorFS.add(auditorName[5]);
                                                                  auditorIDFS.add(int.tryParse(widget.auditor[5].toString()));
                                                                  subBabFS.add(systemBoh[index]);
                                                                  rekomendasiFS.add(null);
                                                                      carNoFS.add(null);
                                                                  criticalFS.add(criticalBoh[index] == 'false' ? 'no' : 'yes');
                                                                } else {
                                                                  if (problemFS.contains(jmlBoh[index])) {
                                                                    
                                                                  } else {
                                                                    rekomendasiFS.add(null);
                                                                      carNoFS.add(null);
                                                                    problemFS.add(jmlBoh[index]);
                                                                    areaFS.add('Back of The House (BOH)');
                                                                    auditorFS.add(auditorName[5]);
                                                                    auditorIDFS.add(int.tryParse(widget.auditor[5].toString()));
                                                                    subBabFS.add(systemBoh[index]);
                                                                    criticalFS.add(criticalBoh[index] == 'false' ? 'no' : 'yes');
                                                                  }
                                                                }

                                                                scoreBoh
                                                                    .removeAt(
                                                                    index);
                                                                scoreBoh
                                                                    .insert(
                                                                    index,
                                                                    0);
                                                                warnaBoh
                                                                    .removeAt(
                                                                    index);
                                                                warnaBoh.insert(
                                                                    index,
                                                                    'merah');


                                                                    print(problemFS);
                                                              print(areaFS);
                                                              print(criticalFS);
                                                              print(auditorFS);
                                                              print(subBabFS);
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        alignment:
                                                        Alignment(
                                                            0.0, 0.0),
                                                      ),
                                                    ),
                                                    jawabanSplitBoh[1] == 'null'
                                                        ? Container()
                                                        : Tooltip(
                                                      message:
                                                      jawabanSplitBoh ==
                                                          null
                                                          ? ''
                                                          : jawabanSplitBoh[
                                                      1],
                                                      preferBelow: false,
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                            horizontal:
                                                            5.0),
                                                        child: ButtonTheme(
                                                          minWidth: 50.0,
                                                          height: 50.0,
                                                          child:
                                                          RaisedButton(
                                                            shape:
                                                            new RoundedRectangleBorder(
                                                              borderRadius:
                                                              new BorderRadius
                                                                  .circular(
                                                                  5.0),
                                                              side:
                                                              BorderSide(
                                                                width: 1.5,
                                                                color: warnaBoh.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    192,
                                                                    192,
                                                                    192)
                                                                    : warnaBoh[index] ==
                                                                    'kuning'
                                                                    ? Colors
                                                                    .white
                                                                    : Color.fromARGB(
                                                                    170,
                                                                    192,
                                                                    192,
                                                                    192),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              '1',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  18.0,
                                                                  color: warnaBoh.length ==
                                                                      0
                                                                      ? Color.fromARGB(
                                                                      170,
                                                                      247,
                                                                      202,
                                                                      24)
                                                                      : warnaBoh[index] == 'kuning'
                                                                      ? Colors.white
                                                                      : Color.fromARGB(170, 247, 202, 24)),
                                                              textAlign:
                                                              TextAlign
                                                                  .center,
                                                            ),
                                                            color: warnaBoh
                                                                .length ==
                                                                0
                                                                ? Colors
                                                                .white
                                                                : warnaBoh[index] ==
                                                                'kuning'
                                                                ? Color.fromARGB(
                                                                170,
                                                                247,
                                                                202,
                                                                24)
                                                                : Colors
                                                                .white,
                                                            onPressed: () {
                                                              setState(() {
                                                                if (criticalBoh[
                                                                index] ==
                                                                    'false') {
                                                                  print(
                                                                      'false');
                                                                } else if (criticalBoh[
                                                                index] ==
                                                                    'true') {
                                                                  if (scoreBoh[
                                                                  index] ==
                                                                      null) {
                                                                    jumlahCriticalPoint =
                                                                        jumlahCriticalPoint +
                                                                            1;
                                                                    print(
                                                                        jumlahCriticalPoint);
                                                                  } else {
                                                                    if (scoreBoh[index] ==
                                                                        2) {
                                                                      jumlahCriticalPoint =
                                                                          jumlahCriticalPoint + 1;
                                                                      print(
                                                                          jumlahCriticalPoint);
                                                                    } else if (scoreBoh[index] ==
                                                                        0 ||
                                                                        scoreBoh[index] ==
                                                                            1) {
                                                                      jumlahCriticalPoint =
                                                                          jumlahCriticalPoint + 0;
                                                                      print(
                                                                          jumlahCriticalPoint);
                                                                    }
                                                                  }
                                                                }

                                                                if (problemFS.length == 0) {
                                                                  
                                                                } else {
                                                                  if (problemFS.contains(jmlBoh[index])) {
                                                                    rekomendasiFS.removeAt(problemFS.indexWhere((test) => test == jmlBoh[index]));
                                                                    carNoFS.removeAt(problemFS.indexWhere((test) => test == jmlBoh[index]));
                                                                    areaFS.removeAt(problemFS.indexWhere((test) => test == jmlBoh[index]));
                                                                    auditorFS.removeAt(problemFS.indexWhere((test) => test == jmlBoh[index]));
                                                                    auditorIDFS.removeAt(problemFS.indexWhere((test) => test == jmlBoh[index]));
                                                                    criticalFS.removeAt(problemFS.indexWhere((test) => test == jmlBoh[index]));
                                                                    subBabFS.removeAt(problemFS.indexWhere((test) => test == jmlBoh[index]));
                                                                    problemFS.removeAt(problemFS.indexWhere((test) => test == jmlBoh[index]));
                                                                  } else {
                                                                    
                                                                  }
                                                                }

                                                                scoreBoh
                                                                    .removeAt(
                                                                    index);
                                                                scoreBoh
                                                                    .insert(
                                                                    index,
                                                                    1);
                                                                warnaBoh
                                                                    .removeAt(
                                                                    index);
                                                                warnaBoh.insert(
                                                                    index,
                                                                    'kuning');

                                                                    print(problemFS);
                                                              print(areaFS);
                                                              print(criticalFS);
                                                              print(auditorFS);
                                                              print(subBabFS);
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        alignment:
                                                        Alignment(
                                                            0.0, 0.0),
                                                      ),
                                                    ),
                                                    jawabanSplitBoh[2] == 'null'
                                                        ? Container()
                                                        : Tooltip(
                                                      message:
                                                      jawabanSplitBoh ==
                                                          null
                                                          ? ''
                                                          : jawabanSplitBoh[
                                                      2],
                                                      preferBelow: false,
                                                      child: Container(
                                                        child: ButtonTheme(
                                                          minWidth: 50.0,
                                                          height: 50.0,
                                                          child:
                                                          RaisedButton(
                                                            shape:
                                                            new RoundedRectangleBorder(
                                                              borderRadius:
                                                              new BorderRadius
                                                                  .circular(
                                                                  5.0),
                                                              side:
                                                              BorderSide(
                                                                width: 1.5,
                                                                color: warnaBoh.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    192,
                                                                    192,
                                                                    192)
                                                                    : warnaBoh[index] ==
                                                                    'hijau'
                                                                    ? Colors
                                                                    .white
                                                                    : Color.fromARGB(
                                                                    170,
                                                                    192,
                                                                    192,
                                                                    192),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              '2',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  18.0,
                                                                  color: warnaBoh.length ==
                                                                      0
                                                                      ? Color.fromARGB(
                                                                      170,
                                                                      50,
                                                                      205,
                                                                      50)
                                                                      : warnaBoh[index] == 'hijau'
                                                                      ? Colors.white
                                                                      : Color.fromARGB(170, 50, 205, 50)),
                                                              textAlign:
                                                              TextAlign
                                                                  .center,
                                                            ),
                                                            color: warnaBoh
                                                                .length ==
                                                                0
                                                                ? Colors
                                                                .white
                                                                : warnaBoh[index] ==
                                                                'hijau'
                                                                ? Color.fromARGB(
                                                                170,
                                                                50,
                                                                205,
                                                                50)
                                                                : Colors
                                                                .white,
                                                            onPressed: () {
                                                              setState(() {
                                                                if (criticalBoh[
                                                                index] ==
                                                                    'false') {
                                                                  print(
                                                                      'false');
                                                                } else if (criticalBoh[
                                                                index] ==
                                                                    'true') {
                                                                  if (scoreBoh[
                                                                  index] ==
                                                                      2) {
                                                                    jumlahCriticalPoint =
                                                                        jumlahCriticalPoint +
                                                                            0;
                                                                    print(
                                                                        jumlahCriticalPoint);
                                                                  } else {
                                                                    if (scoreBoh[index] ==
                                                                        2) {
                                                                      jumlahCriticalPoint =
                                                                          jumlahCriticalPoint + 0;
                                                                      print(
                                                                          jumlahCriticalPoint);
                                                                    } else if (scoreBoh[index] ==
                                                                        0 ||
                                                                        scoreBoh[index] ==
                                                                            1) {
                                                                      jumlahCriticalPoint =
                                                                          jumlahCriticalPoint - 1;
                                                                      print(
                                                                          jumlahCriticalPoint);
                                                                    }
                                                                  }
                                                                }

                                                                if (problemFS.length == 0) {
                                                                  
                                                                } else {
                                                                  if (problemFS.contains(jmlBoh[index])) {
                                                                    rekomendasiFS.removeAt(problemFS.indexWhere((test) => test == jmlBoh[index]));
                                                                    carNoFS.removeAt(problemFS.indexWhere((test) => test == jmlBoh[index]));
                                                                    areaFS.removeAt(problemFS.indexWhere((test) => test == jmlBoh[index]));
                                                                    auditorFS.removeAt(problemFS.indexWhere((test) => test == jmlBoh[index]));
                                                                    auditorIDFS.removeAt(problemFS.indexWhere((test) => test == jmlBoh[index]));
                                                                    criticalFS.removeAt(problemFS.indexWhere((test) => test == jmlBoh[index]));
                                                                    subBabFS.removeAt(problemFS.indexWhere((test) => test == jmlBoh[index]));
                                                                    problemFS.removeAt(problemFS.indexWhere((test) => test == jmlBoh[index]));
                                                                  } else {
                                                                    
                                                                  }
                                                                }

                                                                scoreBoh
                                                                    .removeAt(
                                                                    index);
                                                                scoreBoh
                                                                    .insert(
                                                                    index,
                                                                    2);
                                                                warnaBoh
                                                                    .removeAt(
                                                                    index);
                                                                warnaBoh.insert(
                                                                    index,
                                                                    'hijau');

                                                                    print(problemFS);
                                                              print(areaFS);
                                                              print(criticalFS);
                                                              print(auditorFS);
                                                              print(subBabFS);
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        alignment:
                                                        Alignment(
                                                            0.0, 0.0),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                          widget.subArea.contains('Back of The House (BOH)')
                                            ? Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    imageBoh[index] == null
                                                      ? IconButton(
                                                          icon: Icon(Icons.camera_alt, color: AbubaPallate.greenabuba),
                                                          onPressed: () async {
                                                            var selectedImage =
                                                            await ImagePicker.pickImage(source: ImageSource.camera, maxHeight: 400.0, maxWidth: 400.0);
                                                            
                                                            imageBoh1 = selectedImage;
                                                            filenameBoh1 = basename(imageBoh1.path);

                                                            StorageReference strRef = FirebaseStorage.instance.ref().child(filenameBoh1);
                                                            StorageUploadTask uploadTask = strRef.putFile(imageBoh1);

                                                            var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
                                                            var url = downUrl.toString();

                                                            setState(() {
                                                              if (imageBoh[index] != null) {
                                                                List<String> bantuImageBoh = [];
                                                                List<String> bantuImageBohSave = [];
                                                                bantuImageBoh = imageBoh[index].split('###');
                                                                bantuImageBoh.add(filenameBoh1);
                                                                imageBoh[index] = bantuImageBoh.join('###');

                                                                bantuImageBohSave = imageBohSave[index].split('###');
                                                                bantuImageBohSave.add(url);
                                                                imageBohSave[index] = bantuImageBohSave.join('###');
                                                              } else {
                                                                imageBoh[index] = filenameBoh1;
                                                                imageBohSave[index] = url;
                                                              }
                                                              // imageBohBantu[index] = imageBoh1;
                                                              print(imageBoh);
                                                              print(imageBohSave);
                                                              print(imageBoh[index].split('###').length);
                                                              print(imageBohSave[index].split('###').length);
                                                            });
                                                          },
                                                        )
                                                      : imageBoh[index].split('###').length >= 5
                                                          ? IconButton(
                                                              icon: Icon(Icons.disc_full, color: Colors.grey),
                                                              onPressed: () {},
                                                              tooltip: 'Sudah mencapai batas maksimal 5 foto tiap pertanyaan',
                                                            )
                                                          : IconButton(
                                                              icon: Icon(Icons.camera_alt, color: AbubaPallate.greenabuba),
                                                              onPressed: () async {
                                                                var selectedImage =
                                                                await ImagePicker.pickImage(source: ImageSource.camera, maxHeight: 400.0, maxWidth: 400.0);
                                                                
                                                                imageBoh1 = selectedImage;
                                                                filenameBoh1 = basename(imageBoh1.path);

                                                                StorageReference strRef = FirebaseStorage.instance.ref().child(filenameBoh1);
                                                                StorageUploadTask uploadTask = strRef.putFile(imageBoh1);

                                                                var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
                                                                var url = downUrl.toString();

                                                                setState(() {
                                                                  if (imageBoh[index] != null) {
                                                                    List<String> bantuImageBoh = [];
                                                                    List<String> bantuImageBohSave = [];
                                                                    bantuImageBoh = imageBoh[index].split('###');
                                                                    bantuImageBoh.add(filenameBoh1);
                                                                    imageBoh[index] = bantuImageBoh.join('###');

                                                                    bantuImageBohSave = imageBohSave[index].split('###');
                                                                    bantuImageBohSave.add(url);
                                                                    imageBohSave[index] = bantuImageBohSave.join('###');
                                                                  } else {
                                                                    imageBoh[index] = filenameBoh1;
                                                                    imageBohSave[index] = url;
                                                                  }
                                                                  // imageBohBantu[index] = imageBoh1;
                                                                  print(imageBoh);
                                                                  print(imageBohSave);
                                                                  print(imageBoh[index].split('###').length);
                                                                  print(imageBohSave[index].split('###').length);
                                                                });
                                                              },
                                                            ),
                                                    IconButton(
                                                      icon: Icon(Icons.event_note,
                                                          color: AbubaPallate
                                                              .greenabuba),
                                                      onPressed: () {
                                                        if (noteBoh[index] ==
                                                            null) {
                                                          _controllerBoh.text =
                                                          '';
                                                        } else {
                                                          _controllerBoh.text =
                                                          noteBoh[index];
                                                        }
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              title: Text('NOTE'),
                                                              content: Container(
                                                                width: 300.0,
                                                                child: TextField(
                                                                  controller:
                                                                  _controllerBoh,
                                                                  decoration:
                                                                  InputDecoration(
                                                                    border:
                                                                    OutlineInputBorder(),
                                                                    hintText:
                                                                    'Note',
                                                                    hintStyle: TextStyle(
                                                                        fontSize:
                                                                        12.0),
                                                                  ),
                                                                  maxLines: 3,
                                                                  style:
                                                                  TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                              ),
                                                              actions: <Widget>[
                                                                FlatButton(
                                                                  splashColor: Colors
                                                                      .greenAccent,
                                                                  child: Text(
                                                                    'OK',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .green),
                                                                  ),
                                                                  onPressed: () {
                                                                    noteBoh
                                                                        .removeAt(
                                                                        index);
                                                                    noteBoh.insert(
                                                                        index,
                                                                        _controllerBoh
                                                                            .text);
                                                                    print(
                                                                        noteBoh);
                                                                    Navigator.of(
                                                                        context)
                                                                        .pop();
                                                                  },
                                                                )
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                          Divider(
                                            height: 2.0,
                                          )
                                        ],
                                      );
                                    }).toList(),
                                  ),
                                ),
                              );
                            }),
                        PreferredSize(
                          preferredSize: Size.fromHeight(
                              MediaQuery.of(context).size.height -
                                  55.0 -
                                  (MediaQuery.of(context).size.height * 0.7)),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 55.0,
                                child: Container(
                                    child: Padding(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: <Widget>[
                                              IconButton(
                                                icon: Icon(Icons.arrow_back_ios,
                                                    color: Colors.white),
                                                onPressed: () {
                                                  _cardController.animateTo(
                                                      _cardController.index - 1);
                                                },
                                                tooltip: 'Previous',
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.arrow_forward_ios,
                                                    color: Colors.white),
                                                onPressed: () {
                                                  if (widget.subArea.contains('Back of The House (BOH)')) {
                                                    if (scoreBoh[indexBoh] == null) {
                                                      showDialog(
                                                        barrierDismissible: false,
                                                        context: context,
                                                        builder: (context) => Dialog(
                                                          child: Container(
                                                            height: 180.0,
                                                            child: Column(
                                                              children: <Widget>[
                                                                Container(
                                                                  color: AbubaPallate
                                                                      .greenabuba,
                                                                  height: 50.0,
                                                                  child: Center(
                                                                    child: Text(
                                                                      'OOPS!',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                          17.0,
                                                                          fontWeight:
                                                                          FontWeight.w700),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 20.0,
                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                      10.0,
                                                                      vertical:
                                                                      10.0),
                                                                  child: Text(
                                                                    'Please select the answer!',
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      16.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                                  children: <
                                                                      Widget>[
                                                                    FlatButton(
                                                                      child: Text(
                                                                          'OK'),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      hasilBoh = 0;
                                                      for (int i = 0; i < scoreBoh.length; i++) {
                                                        hasilBoh += double.tryParse(bobotPertanyaanBoh[i].toString()) * double.tryParse(scoreBoh[i].toString());
                                                      }
                                                      hasilBoh = hasilBoh / 2;
                                                      // if (hasilBoh > 1.0) {
                                                      //   hasilBoh = 1.0;
                                                      // } else {
                                                      //   hasilBoh = hasilBoh;
                                                      // }
                                                      // finalBoh = (hasilBoh * parameterBoh) / 100;

                                                      print(bobotPertanyaanBoh);
                                                      print(scoreBoh);
                                                      print(hasilBoh);
                                                      // print(finalBoh);
                                                      _cardController.animateTo(_cardController.index + 1);
                                                    }
                                                  } else {
                                                    print(bobotPertanyaanBoh);
                                                    print(scoreBoh);
                                                    print(hasilBoh);
                                                    print(finalBoh);
                                                    _cardController.animateTo(_cardController.index + 1);
                                                  }
                                                },
                                                tooltip: 'Next',
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    decoration:
                                    BoxDecoration(color: Color(0xFF2F592F))),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                // sini warehouse
                ListView(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      children: <Widget>[
                        PreferredSize(
                          preferredSize: Size.fromHeight(55.0),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 55.0,
                                child: Container(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.75,
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                text: TextSpan(
                                                  text: 'Warehouse',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17.0
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.75,
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                text: TextSpan(
                                                  text: 'Auditor : ${auditorName[6].toString()}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11.0
                                                  ),
                                                ),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '7 of ${_listData.length.toString()}',
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 14.0),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF2F592F),
                                  ),
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
                                alignment: Alignment(0.0, 0.0),
                                height: MediaQuery.of(context).size.height *
                                    0.736,
                              )
                                  : Container(
                                height: MediaQuery.of(context).size.height *
                                    0.736,
                                color: Colors.white,
                                child: Scrollbar(
                                  child: ListView(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    children: List.generate(
                                        jmlWarehouse.length, (index) {
                                      indexWarehouse = index;
                                      jawabanSplitWarehouse =
                                          jawabanSplitWarehouseBantu[index]
                                              .split(r"!@#$");
                                      if (scoreWarehouse.length <
                                          jumlahWarehouse) {
                                        for (int a = 0;
                                        a < jumlahWarehouse;
                                        a++) {
                                          noteWarehouse.add(null);
                                          scoreWarehouse.add(null);
                                          imageWarehouse.add(null);
                                          imageWarehouseBantu.add(null);
                                          imageWarehouseSave.add(null);
                                          warnaWarehouse.add('abu');
                                        }
                                      }

                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          criticalWarehouse[index] == 'false'
                                              ? Padding(
                                            padding: EdgeInsets.only(
                                                right: 15.0,
                                                left: 15.0,
                                                bottom: 8.0,
                                                top: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    systemWarehouse[
                                                    index],
                                                    style: TextStyle(
                                                        color: Colors
                                                            .green,
                                                        fontWeight:
                                                        FontWeight
                                                            .w700,
                                                        fontSize: 16.0),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                              : Padding(
                                            padding: EdgeInsets.only(
                                                right: 15.0,
                                                left: 15.0,
                                                bottom: 8.0,
                                                top: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    systemWarehouse[
                                                    index],
                                                    style: TextStyle(
                                                        color: Colors
                                                            .green,
                                                        fontWeight:
                                                        FontWeight
                                                            .w700,
                                                        fontSize: 16.0),
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    'CRITICAL',
                                                    style: TextStyle(
                                                        color:
                                                        Colors.red,
                                                        fontWeight:
                                                        FontWeight
                                                            .w700,
                                                        fontSize: 16.0),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 15.0,
                                                      left: 15.0,
                                                      top: 10.0,
                                                      bottom: 50.0),
                                                  child: Text(
                                                    jmlWarehouse[index],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18.0),
                                                    textAlign:
                                                    TextAlign.start,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          widget.subArea.contains('Warehouse')
                                            ? Padding(
                                                padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 15.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: <Widget>[
                                                    jawabanSplitWarehouse[0] ==
                                                        'null'
                                                        ? Container()
                                                        : Tooltip(
                                                      message:
                                                      jawabanSplitWarehouse ==
                                                          null
                                                          ? ''
                                                          : jawabanSplitWarehouse[
                                                      0],
                                                      preferBelow: false,
                                                      child: Container(
                                                        child: ButtonTheme(
                                                          minWidth: 50.0,
                                                          height: 50.0,
                                                          child:
                                                          RaisedButton(
                                                            shape:
                                                            new RoundedRectangleBorder(
                                                              borderRadius:
                                                              new BorderRadius
                                                                  .circular(
                                                                  5.0),
                                                              side:
                                                              BorderSide(
                                                                width: 1.5,
                                                                color: warnaWarehouse.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    192,
                                                                    192,
                                                                    192)
                                                                    : warnaWarehouse[index] ==
                                                                    'merah'
                                                                    ? Colors
                                                                    .white
                                                                    : Color.fromARGB(
                                                                    170,
                                                                    192,
                                                                    192,
                                                                    192),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              '0',
                                                              style:
                                                              TextStyle(
                                                                fontSize:
                                                                18.0,
                                                                color: warnaWarehouse.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    255,
                                                                    40,
                                                                    0)
                                                                    : warnaWarehouse[index] ==
                                                                    'merah'
                                                                    ? Colors
                                                                    .white
                                                                    : Color.fromARGB(
                                                                    170,
                                                                    255,
                                                                    40,
                                                                    0),
                                                              ),
                                                              textAlign:
                                                              TextAlign
                                                                  .center,
                                                            ),
                                                            color: warnaWarehouse
                                                                .length ==
                                                                0
                                                                ? Colors
                                                                .white
                                                                : warnaWarehouse[index] ==
                                                                'merah'
                                                                ? Color.fromARGB(
                                                                170,
                                                                255,
                                                                40,
                                                                0)
                                                                : Colors
                                                                .white,
                                                            onPressed: () {
                                                              setState(() {
                                                                if (criticalWarehouse[
                                                                index] ==
                                                                    'false') {
                                                                  print(
                                                                      'false');
                                                                } else if (criticalWarehouse[
                                                                index] ==
                                                                    'true') {
                                                                  if (scoreWarehouse[
                                                                  index] ==
                                                                      null) {
                                                                    jumlahCriticalPoint =
                                                                        jumlahCriticalPoint +
                                                                            1;
                                                                    print(
                                                                        jumlahCriticalPoint);
                                                                  } else {
                                                                    if (scoreWarehouse[index] ==
                                                                        2) {
                                                                      jumlahCriticalPoint =
                                                                          jumlahCriticalPoint + 1;
                                                                      print(
                                                                          jumlahCriticalPoint);
                                                                    } else if (scoreWarehouse[index] ==
                                                                        0 ||
                                                                        scoreWarehouse[index] ==
                                                                            1) {
                                                                      jumlahCriticalPoint =
                                                                          jumlahCriticalPoint + 0;
                                                                      print(
                                                                          jumlahCriticalPoint);
                                                                    }
                                                                  }
                                                                }

                                                                if (problemFS.length == 0) {
                                                                  problemFS.add(jmlWarehouse[index]);
                                                                  areaFS.add('Warehouse');
                                                                  auditorFS.add(auditorName[6]);
                                                                  auditorIDFS.add(int.tryParse(widget.auditor[6].toString()));
                                                                  subBabFS.add(systemWarehouse[index]);
                                                                  rekomendasiFS.add(null);
                                                                      carNoFS.add(null);
                                                                  criticalFS.add(criticalWarehouse[index] == 'false' ? 'no' : 'yes');
                                                                } else {
                                                                  if (problemFS.contains(jmlWarehouse[index])) {
                                                                    
                                                                  } else {
                                                                    rekomendasiFS.add(null);
                                                                      carNoFS.add(null);
                                                                    problemFS.add(jmlWarehouse[index]);
                                                                    areaFS.add('Warehouse');
                                                                    auditorFS.add(auditorName[6]);
                                                                    auditorIDFS.add(int.tryParse(widget.auditor[6].toString()));
                                                                    subBabFS.add(systemWarehouse[index]);
                                                                    criticalFS.add(criticalWarehouse[index] == 'false' ? 'no' : 'yes');
                                                                  }
                                                                }

                                                                scoreWarehouse
                                                                    .removeAt(
                                                                    index);
                                                                scoreWarehouse
                                                                    .insert(
                                                                    index,
                                                                    0);
                                                                warnaWarehouse
                                                                    .removeAt(
                                                                    index);
                                                                warnaWarehouse
                                                                    .insert(
                                                                    index,
                                                                    'merah');


                                                                    print(problemFS);
                                                              print(areaFS);
                                                              print(criticalFS);
                                                              print(auditorFS);
                                                              print(subBabFS);
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        alignment:
                                                        Alignment(
                                                            0.0, 0.0),
                                                      ),
                                                    ),
                                                    jawabanSplitWarehouse[1] ==
                                                        'null'
                                                        ? Container()
                                                        : Tooltip(
                                                      message:
                                                      jawabanSplitWarehouse ==
                                                          null
                                                          ? ''
                                                          : jawabanSplitWarehouse[
                                                      1],
                                                      preferBelow: false,
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                            horizontal:
                                                            5.0),
                                                        child: ButtonTheme(
                                                          minWidth: 50.0,
                                                          height: 50.0,
                                                          child:
                                                          RaisedButton(
                                                            shape:
                                                            new RoundedRectangleBorder(
                                                              borderRadius:
                                                              new BorderRadius
                                                                  .circular(
                                                                  5.0),
                                                              side:
                                                              BorderSide(
                                                                width: 1.5,
                                                                color: warnaWarehouse.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    192,
                                                                    192,
                                                                    192)
                                                                    : warnaWarehouse[index] ==
                                                                    'kuning'
                                                                    ? Colors
                                                                    .white
                                                                    : Color.fromARGB(
                                                                    170,
                                                                    192,
                                                                    192,
                                                                    192),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              '1',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  18.0,
                                                                  color: warnaWarehouse.length ==
                                                                      0
                                                                      ? Color.fromARGB(
                                                                      170,
                                                                      247,
                                                                      202,
                                                                      24)
                                                                      : warnaWarehouse[index] == 'kuning'
                                                                      ? Colors.white
                                                                      : Color.fromARGB(170, 247, 202, 24)),
                                                              textAlign:
                                                              TextAlign
                                                                  .center,
                                                            ),
                                                            color: warnaWarehouse
                                                                .length ==
                                                                0
                                                                ? Colors
                                                                .white
                                                                : warnaWarehouse[index] ==
                                                                'kuning'
                                                                ? Color.fromARGB(
                                                                170,
                                                                247,
                                                                202,
                                                                24)
                                                                : Colors
                                                                .white,
                                                            onPressed: () {
                                                              setState(() {
                                                                if (criticalWarehouse[
                                                                index] ==
                                                                    'false') {
                                                                  print(
                                                                      'false');
                                                                } else if (criticalWarehouse[
                                                                index] ==
                                                                    'true') {
                                                                  if (scoreWarehouse[
                                                                  index] ==
                                                                      null) {
                                                                    jumlahCriticalPoint =
                                                                        jumlahCriticalPoint +
                                                                            1;
                                                                    print(
                                                                        jumlahCriticalPoint);
                                                                  } else {
                                                                    if (scoreWarehouse[index] ==
                                                                        2) {
                                                                      jumlahCriticalPoint =
                                                                          jumlahCriticalPoint + 1;
                                                                      print(
                                                                          jumlahCriticalPoint);
                                                                    } else if (scoreWarehouse[index] ==
                                                                        0 ||
                                                                        scoreWarehouse[index] ==
                                                                            1) {
                                                                      jumlahCriticalPoint =
                                                                          jumlahCriticalPoint + 0;
                                                                      print(
                                                                          jumlahCriticalPoint);
                                                                    }
                                                                  }
                                                                }

                                                                if (problemFS.length == 0) {
                                                                  
                                                                } else {
                                                                  if (problemFS.contains(jmlWarehouse[index])) {
                                                                    areaFS.removeAt(problemFS.indexWhere((test) => test == jmlWarehouse[index]));
                                                                    auditorFS.removeAt(problemFS.indexWhere((test) => test == jmlWarehouse[index]));
                                                                    rekomendasiFS.removeAt(problemFS.indexWhere((test) => test == jmlWarehouse[index]));
                                                                    carNoFS.removeAt(problemFS.indexWhere((test) => test == jmlWarehouse[index]));
                                                                    auditorIDFS.removeAt(problemFS.indexWhere((test) => test == jmlWarehouse[index]));
                                                                    criticalFS.removeAt(problemFS.indexWhere((test) => test == jmlWarehouse[index]));
                                                                    subBabFS.removeAt(problemFS.indexWhere((test) => test == jmlWarehouse[index]));
                                                                    problemFS.removeAt(problemFS.indexWhere((test) => test == jmlWarehouse[index]));
                                                                  } else {
                                                                    
                                                                  }
                                                                }

                                                                scoreWarehouse
                                                                    .removeAt(
                                                                    index);
                                                                scoreWarehouse
                                                                    .insert(
                                                                    index,
                                                                    1);
                                                                warnaWarehouse
                                                                    .removeAt(
                                                                    index);
                                                                warnaWarehouse
                                                                    .insert(
                                                                    index,
                                                                    'kuning');

                                                                    print(problemFS);
                                                              print(areaFS);
                                                              print(criticalFS);
                                                              print(auditorFS);
                                                              print(subBabFS);
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        alignment:
                                                        Alignment(
                                                            0.0, 0.0),
                                                      ),
                                                    ),
                                                    jawabanSplitWarehouse[2] ==
                                                        'null'
                                                        ? Container()
                                                        : Tooltip(
                                                      message:
                                                      jawabanSplitWarehouse ==
                                                          null
                                                          ? ''
                                                          : jawabanSplitWarehouse[
                                                      2],
                                                      preferBelow: false,
                                                      child: Container(
                                                        child: ButtonTheme(
                                                          minWidth: 50.0,
                                                          height: 50.0,
                                                          child:
                                                          RaisedButton(
                                                            shape:
                                                            new RoundedRectangleBorder(
                                                              borderRadius:
                                                              new BorderRadius
                                                                  .circular(
                                                                  5.0),
                                                              side:
                                                              BorderSide(
                                                                width: 1.5,
                                                                color: warnaWarehouse.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    192,
                                                                    192,
                                                                    192)
                                                                    : warnaWarehouse[index] ==
                                                                    'hijau'
                                                                    ? Colors
                                                                    .white
                                                                    : Color.fromARGB(
                                                                    170,
                                                                    192,
                                                                    192,
                                                                    192),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              '2',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  18.0,
                                                                  color: warnaWarehouse.length ==
                                                                      0
                                                                      ? Color.fromARGB(
                                                                      170,
                                                                      50,
                                                                      205,
                                                                      50)
                                                                      : warnaWarehouse[index] == 'hijau'
                                                                      ? Colors.white
                                                                      : Color.fromARGB(170, 50, 205, 50)),
                                                              textAlign:
                                                              TextAlign
                                                                  .center,
                                                            ),
                                                            color: warnaWarehouse
                                                                .length ==
                                                                0
                                                                ? Colors
                                                                .white
                                                                : warnaWarehouse[index] ==
                                                                'hijau'
                                                                ? Color.fromARGB(
                                                                170,
                                                                50,
                                                                205,
                                                                50)
                                                                : Colors
                                                                .white,
                                                            onPressed: () {
                                                              setState(() {
                                                                if (criticalWarehouse[
                                                                index] ==
                                                                    'false') {
                                                                  print(
                                                                      'false');
                                                                } else if (criticalWarehouse[
                                                                index] ==
                                                                    'true') {
                                                                  if (scoreWarehouse[
                                                                  index] ==
                                                                      2) {
                                                                    jumlahCriticalPoint =
                                                                        jumlahCriticalPoint +
                                                                            0;
                                                                    print(
                                                                        jumlahCriticalPoint);
                                                                  } else {
                                                                    if (scoreWarehouse[index] ==
                                                                        2) {
                                                                      jumlahCriticalPoint =
                                                                          jumlahCriticalPoint + 0;
                                                                      print(
                                                                          jumlahCriticalPoint);
                                                                    } else if (scoreWarehouse[index] ==
                                                                        0 ||
                                                                        scoreWarehouse[index] ==
                                                                            1) {
                                                                      jumlahCriticalPoint =
                                                                          jumlahCriticalPoint - 1;
                                                                      print(
                                                                          jumlahCriticalPoint);
                                                                    }
                                                                  }
                                                                }

                                                                if (problemFS.length == 0) {
                                                                  
                                                                } else {
                                                                  if (problemFS.contains(jmlWarehouse[index])) {
                                                                    rekomendasiFS.removeAt(problemFS.indexWhere((test) => test == jmlWarehouse[index]));
                                                                    carNoFS.removeAt(problemFS.indexWhere((test) => test == jmlWarehouse[index]));
                                                                    areaFS.removeAt(problemFS.indexWhere((test) => test == jmlWarehouse[index]));
                                                                    auditorFS.removeAt(problemFS.indexWhere((test) => test == jmlWarehouse[index]));
                                                                    auditorIDFS.removeAt(problemFS.indexWhere((test) => test == jmlWarehouse[index]));
                                                                    criticalFS.removeAt(problemFS.indexWhere((test) => test == jmlWarehouse[index]));
                                                                    subBabFS.removeAt(problemFS.indexWhere((test) => test == jmlWarehouse[index]));
                                                                    problemFS.removeAt(problemFS.indexWhere((test) => test == jmlWarehouse[index]));
                                                                  } else {
                                                                    
                                                                  }
                                                                }

                                                                scoreWarehouse
                                                                    .removeAt(
                                                                    index);
                                                                scoreWarehouse
                                                                    .insert(
                                                                    index,
                                                                    2);
                                                                warnaWarehouse
                                                                    .removeAt(
                                                                    index);
                                                                warnaWarehouse
                                                                    .insert(
                                                                    index,
                                                                    'hijau');

                                                                    print(problemFS);
                                                              print(areaFS);
                                                              print(criticalFS);
                                                              print(auditorFS);
                                                              print(subBabFS);
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        alignment:
                                                        Alignment(
                                                            0.0, 0.0),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                          widget.subArea.contains('Warehouse')
                                            ? Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    imageWarehouse[index] == null
                                                      ? IconButton(
                                                          icon: Icon(Icons.camera_alt, color: AbubaPallate.greenabuba),
                                                          onPressed: () async {
                                                            var selectedImage =
                                                            await ImagePicker.pickImage(source: ImageSource.camera, maxHeight: 400.0, maxWidth: 400.0);
                                                            
                                                            imageWarehouse1 = selectedImage;
                                                            filenameWarehouse1 = basename(imageWarehouse1.path);

                                                            StorageReference strRef = FirebaseStorage.instance.ref().child(filenameWarehouse1);
                                                            StorageUploadTask uploadTask = strRef.putFile(imageWarehouse1);

                                                            var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
                                                            var url = downUrl.toString();

                                                            setState(() {
                                                              if (imageWarehouse[index] != null) {
                                                                List<String> bantuImageWarehouse = [];
                                                                List<String> bantuImageWarehouseSave = [];
                                                                bantuImageWarehouse = imageWarehouse[index].split('###');
                                                                bantuImageWarehouse.add(filenameWarehouse1);
                                                                imageWarehouse[index] = bantuImageWarehouse.join('###');

                                                                bantuImageWarehouseSave = imageWarehouseSave[index].split('###');
                                                                bantuImageWarehouseSave.add(url);
                                                                imageWarehouseSave[index] = bantuImageWarehouseSave.join('###');
                                                              } else {
                                                                imageWarehouse[index] = filenameWarehouse1;
                                                                imageWarehouseSave[index] = url;
                                                              }
                                                              // imageWarehouseBantu[index] = imageWarehouse1;
                                                              print(imageWarehouse);
                                                              print(imageWarehouseSave);
                                                              print(imageWarehouse[index].split('###').length);
                                                              print(imageWarehouseSave[index].split('###').length);
                                                            });
                                                          },
                                                        )
                                                      : imageWarehouse[index].split('###').length >= 5
                                                          ? IconButton(
                                                              icon: Icon(Icons.disc_full, color: Colors.grey),
                                                              onPressed: () {},
                                                              tooltip: 'Sudah mencapai batas maksimal 5 foto tiap pertanyaan',
                                                            )
                                                          : IconButton(
                                                              icon: Icon(Icons.camera_alt, color: AbubaPallate.greenabuba),
                                                              onPressed: () async {
                                                                var selectedImage =
                                                                await ImagePicker.pickImage(source: ImageSource.camera, maxHeight: 400.0, maxWidth: 400.0);
                                                                
                                                                imageWarehouse1 = selectedImage;
                                                                filenameWarehouse1 = basename(imageWarehouse1.path);

                                                                StorageReference strRef = FirebaseStorage.instance.ref().child(filenameWarehouse1);
                                                                StorageUploadTask uploadTask = strRef.putFile(imageWarehouse1);

                                                                var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
                                                                var url = downUrl.toString();

                                                                setState(() {
                                                                  if (imageWarehouse[index] != null) {
                                                                    List<String> bantuImageWarehouse = [];
                                                                    List<String> bantuImageWarehouseSave = [];
                                                                    bantuImageWarehouse = imageWarehouse[index].split('###');
                                                                    bantuImageWarehouse.add(filenameWarehouse1);
                                                                    imageWarehouse[index] = bantuImageWarehouse.join('###');

                                                                    bantuImageWarehouseSave = imageWarehouseSave[index].split('###');
                                                                    bantuImageWarehouseSave.add(url);
                                                                    imageWarehouseSave[index] = bantuImageWarehouseSave.join('###');
                                                                  } else {
                                                                    imageWarehouse[index] = filenameWarehouse1;
                                                                    imageWarehouseSave[index] = url;
                                                                  }
                                                                  // imageWarehouseBantu[index] = imageWarehouse1;
                                                                  print(imageWarehouse);
                                                                  print(imageWarehouseSave);
                                                                  print(imageWarehouse[index].split('###').length);
                                                                  print(imageWarehouseSave[index].split('###').length);
                                                                });
                                                              },
                                                            ),
                                                    IconButton(
                                                      icon: Icon(Icons.event_note,
                                                          color: AbubaPallate
                                                              .greenabuba),
                                                      onPressed: () {
                                                        if (noteWarehouse[
                                                        index] ==
                                                            null) {
                                                          _controllerWarehouse
                                                              .text = '';
                                                        } else {
                                                          _controllerWarehouse
                                                              .text =
                                                          noteWarehouse[
                                                          index];
                                                        }
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              title: Text('NOTE'),
                                                              content: Container(
                                                                width: 300.0,
                                                                child: TextField(
                                                                  controller:
                                                                  _controllerWarehouse,
                                                                  decoration:
                                                                  InputDecoration(
                                                                    border:
                                                                    OutlineInputBorder(),
                                                                    hintText:
                                                                    'Note',
                                                                    hintStyle: TextStyle(
                                                                        fontSize:
                                                                        12.0),
                                                                  ),
                                                                  maxLines: 3,
                                                                  style:
                                                                  TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                              ),
                                                              actions: <Widget>[
                                                                FlatButton(
                                                                  splashColor: Colors
                                                                      .greenAccent,
                                                                  child: Text(
                                                                    'OK',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .green),
                                                                  ),
                                                                  onPressed: () {
                                                                    noteWarehouse
                                                                        .removeAt(
                                                                        index);
                                                                    noteWarehouse.insert(
                                                                        index,
                                                                        _controllerWarehouse
                                                                            .text);
                                                                    print(
                                                                        noteWarehouse);
                                                                    Navigator.of(
                                                                        context)
                                                                        .pop();
                                                                  },
                                                                )
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                          Divider(
                                            height: 2.0,
                                          )
                                        ],
                                      );
                                    }).toList(),
                                  ),
                                ),
                              );
                            }),
                        PreferredSize(
                          preferredSize: Size.fromHeight(
                              MediaQuery.of(context).size.height -
                                  55.0 -
                                  (MediaQuery.of(context).size.height * 0.7)),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 55.0,
                                child: Container(
                                    child: Padding(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: <Widget>[
                                              IconButton(
                                                icon: Icon(Icons.arrow_back_ios,
                                                    color: Colors.white),
                                                onPressed: () {
                                                  _cardController.animateTo(
                                                      _cardController.index - 1);
                                                },
                                                tooltip: 'Previous',
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.arrow_forward_ios,
                                                    color: Colors.white),
                                                onPressed: () {
                                                  if (widget.subArea.contains('Warehouse')) {
                                                    if (scoreWarehouse[
                                                    indexWarehouse] ==
                                                        null) {
                                                      showDialog(
                                                        barrierDismissible: false,
                                                        context: context,
                                                        builder: (context) => Dialog(
                                                          child: Container(
                                                            height: 180.0,
                                                            child: Column(
                                                              children: <Widget>[
                                                                Container(
                                                                  color: AbubaPallate
                                                                      .greenabuba,
                                                                  height: 50.0,
                                                                  child: Center(
                                                                    child: Text(
                                                                      'OOPS!',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                          17.0,
                                                                          fontWeight:
                                                                          FontWeight.w700),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 20.0,
                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                      10.0,
                                                                      vertical:
                                                                      10.0),
                                                                  child: Text(
                                                                    'Please select the answer!',
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      16.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                                  children: <
                                                                      Widget>[
                                                                    FlatButton(
                                                                      child: Text(
                                                                          'OK'),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      hasilWarehouse = 0;
                                                      for (int i = 0; i < scoreWarehouse.length; i++) {
                                                        hasilWarehouse += double.tryParse(bobotPertanyaanWarehouse[i].toString()) * double.tryParse(scoreWarehouse[i].toString());
                                                      }
                                                      hasilWarehouse = hasilWarehouse / 2;
                                                      // if (hasilWarehouse > 1.0) {
                                                      //   hasilWarehouse = 1.0;
                                                      // } else {
                                                      //   hasilWarehouse = hasilWarehouse;
                                                      // }
                                                      // finalWarehouse = (hasilWarehouse * parameterWarehouse) / 100;

                                                      print(bobotPertanyaanWarehouse);
                                                      print(scoreWarehouse);
                                                      print(hasilWarehouse);
                                                      // print(finalWarehouse);
                                                      _cardController.animateTo(_cardController.index + 1);
                                                    }
                                                  } else {
                                                    print(bobotPertanyaanWarehouse);
                                                    print(scoreWarehouse);
                                                    print(hasilWarehouse);
                                                    print(finalWarehouse);
                                                    _cardController.animateTo(_cardController.index + 1);
                                                  }
                                                },
                                                tooltip: 'Next',
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    decoration:
                                    BoxDecoration(color: Color(0xFF2F592F))),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                // sini social block
                ListView(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      children: <Widget>[
                        PreferredSize(
                          preferredSize: Size.fromHeight(55.0),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 55.0,
                                child: Container(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.75,
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                text: TextSpan(
                                                  text: 'Social Block',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17.0
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.75,
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                text: TextSpan(
                                                  text: 'Auditor : ${auditorName[7].toString()}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11.0
                                                  ),
                                                ),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '8 of ${_listData.length.toString()}',
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 14.0),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF2F592F),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        AnimatedBuilder(
                          animation: animationController,
                          builder: (_, Widget child) {
                            return animationController.isAnimating
                                ? Center(
                              child: Container(
                                child: CircularProgressIndicator(),
                                alignment: Alignment(0.0, 0.0),
                                height: MediaQuery.of(context).size.height *
                                    0.736,
                              ),
                            )
                                : Container(
                              height:
                              MediaQuery.of(context).size.height * 0.736,
                              color: Colors.white,
                              child: Scrollbar(
                                child: ListView(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  children: List.generate(
                                    jmlSocialBlock.length,
                                        (index) {
                                      indexSocialBlock = index;
                                      jawabanSplitSocialBlock =
                                          jawabanSplitSocialBlockBantu[index]
                                              .split(r"!@#$");
                                      if (scoreSocialBlock.length <
                                          jumlahSocialBlock) {
                                        for (int a = 0;
                                        a < jumlahSocialBlock;
                                        a++) {
                                          noteSocialBlock.add(null);
                                          scoreSocialBlock.add(null);
                                          imageSocialBlock.add(null);
                                          imageSocialBlockBantu.add(null);
                                          imageSocialBlockSave.add(null);
                                          warnaSocialBlock.add('abu');
                                        }
                                      }

                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          criticalSocialBlock[index] ==
                                              'false'
                                              ? Padding(
                                            padding: EdgeInsets.only(
                                                right: 15.0,
                                                left: 15.0,
                                                bottom: 8.0,
                                                top: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    systemSocialBlock[
                                                    index],
                                                    style: TextStyle(
                                                        color: Colors
                                                            .green,
                                                        fontWeight:
                                                        FontWeight
                                                            .w700,
                                                        fontSize: 16.0),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                              : Padding(
                                            padding: EdgeInsets.only(
                                                right: 15.0,
                                                left: 15.0,
                                                bottom: 8.0,
                                                top: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    systemSocialBlock[
                                                    index],
                                                    style: TextStyle(
                                                        color: Colors
                                                            .green,
                                                        fontWeight:
                                                        FontWeight
                                                            .w700,
                                                        fontSize: 16.0),
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    'CRITICAL',
                                                    style: TextStyle(
                                                        color:
                                                        Colors.red,
                                                        fontWeight:
                                                        FontWeight
                                                            .w700,
                                                        fontSize: 16.0),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 15.0,
                                                      left: 15.0,
                                                      top: 10.0,
                                                      bottom: 50.0),
                                                  child: Text(
                                                    jmlSocialBlock[index],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20.0),
                                                    textAlign:
                                                    TextAlign.start,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          widget.subArea.contains('Social Block')
                                            ? Padding(
                                                padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 15.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: <Widget>[
                                                    jawabanSplitSocialBlock[0] ==
                                                        'null'
                                                        ? Container()
                                                        : Tooltip(
                                                      message:
                                                      jawabanSplitSocialBlock ==
                                                          null
                                                          ? ''
                                                          : jawabanSplitSocialBlock[
                                                      0],
                                                      preferBelow: false,
                                                      child: Container(
                                                        child: ButtonTheme(
                                                          minWidth: 50.0,
                                                          height: 50.0,
                                                          child:
                                                          RaisedButton(
                                                            shape:
                                                            new RoundedRectangleBorder(
                                                              borderRadius:
                                                              new BorderRadius
                                                                  .circular(
                                                                  5.0),
                                                              side:
                                                              BorderSide(
                                                                width: 1.5,
                                                                color: warnaSocialBlock.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    192,
                                                                    192,
                                                                    192)
                                                                    : warnaSocialBlock[index] ==
                                                                    'merah'
                                                                    ? Colors
                                                                    .white
                                                                    : Color.fromARGB(
                                                                    170,
                                                                    192,
                                                                    192,
                                                                    192),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              '0',
                                                              style:
                                                              TextStyle(
                                                                fontSize:
                                                                18.0,
                                                                color: warnaSocialBlock.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    255,
                                                                    40,
                                                                    0)
                                                                    : warnaSocialBlock[index] ==
                                                                    'merah'
                                                                    ? Colors
                                                                    .white
                                                                    : Color.fromARGB(
                                                                    170,
                                                                    255,
                                                                    40,
                                                                    0),
                                                              ),
                                                              textAlign:
                                                              TextAlign
                                                                  .center,
                                                            ),
                                                            color: warnaSocialBlock
                                                                .length ==
                                                                0
                                                                ? Colors
                                                                .white
                                                                : warnaSocialBlock[index] ==
                                                                'merah'
                                                                ? Color.fromARGB(
                                                                170,
                                                                255,
                                                                40,
                                                                0)
                                                                : Colors
                                                                .white,
                                                            onPressed: () {
                                                              setState(() {
                                                                if (criticalSocialBlock[
                                                                index] ==
                                                                    'false') {
                                                                  print(
                                                                      'false');
                                                                } else if (criticalSocialBlock[
                                                                index] ==
                                                                    'true') {
                                                                  if (scoreSocialBlock[
                                                                  index] ==
                                                                      null) {
                                                                    jumlahCriticalPoint =
                                                                        jumlahCriticalPoint +
                                                                            1;
                                                                    print(
                                                                        jumlahCriticalPoint);
                                                                  } else {
                                                                    if (scoreSocialBlock[index] ==
                                                                        2) {
                                                                      jumlahCriticalPoint =
                                                                          jumlahCriticalPoint + 1;
                                                                      print(
                                                                          jumlahCriticalPoint);
                                                                    } else if (scoreSocialBlock[index] ==
                                                                        0 ||
                                                                        scoreSocialBlock[index] ==
                                                                            1) {
                                                                      jumlahCriticalPoint =
                                                                          jumlahCriticalPoint + 0;
                                                                      print(
                                                                          jumlahCriticalPoint);
                                                                    }
                                                                  }
                                                                }

                                                                if (problemFS.length == 0) {
                                                                  problemFS.add(jmlSocialBlock[index]);
                                                                  areaFS.add('Social Block');
                                                                  auditorFS.add(auditorName[7]);
                                                                  auditorIDFS.add(int.tryParse(widget.auditor[7].toString()));
                                                                  subBabFS.add(systemSocialBlock[index]);
                                                                  rekomendasiFS.add(null);
                                                                      carNoFS.add(null);
                                                                  criticalFS.add(criticalSocialBlock[index] == 'false' ? 'no' : 'yes');
                                                                } else {
                                                                  if (problemFS.contains(jmlSocialBlock[index])) {
                                                                    
                                                                  } else {
                                                                    rekomendasiFS.add(null);
                                                                      carNoFS.add(null);
                                                                    problemFS.add(jmlSocialBlock[index]);
                                                                    areaFS.add('Social Block');
                                                                    auditorFS.add(auditorName[7]);
                                                                    auditorIDFS.add(int.tryParse(widget.auditor[7].toString()));
                                                                    subBabFS.add(systemSocialBlock[index]);
                                                                    criticalFS.add(criticalSocialBlock[index] == 'false' ? 'no' : 'yes');
                                                                  }
                                                                }
                                                                
                                                                scoreSocialBlock
                                                                    .removeAt(
                                                                    index);
                                                                scoreSocialBlock
                                                                    .insert(
                                                                    index,
                                                                    0);
                                                                warnaSocialBlock
                                                                    .removeAt(
                                                                    index);
                                                                warnaSocialBlock
                                                                    .insert(
                                                                    index,
                                                                    'merah');

                                                                    print(problemFS);
                                                              print(areaFS);
                                                              print(criticalFS);
                                                              print(auditorFS);
                                                              print(subBabFS);
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        alignment:
                                                        Alignment(
                                                            0.0, 0.0),
                                                      ),
                                                    ),
                                                    jawabanSplitSocialBlock[1] ==
                                                        'null'
                                                        ? Container()
                                                        : Tooltip(
                                                      message:
                                                      jawabanSplitSocialBlock ==
                                                          null
                                                          ? ''
                                                          : jawabanSplitSocialBlock[
                                                      1],
                                                      preferBelow: false,
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                            horizontal:
                                                            5.0),
                                                        child: ButtonTheme(
                                                          minWidth: 50.0,
                                                          height: 50.0,
                                                          child:
                                                          RaisedButton(
                                                            shape:
                                                            new RoundedRectangleBorder(
                                                              borderRadius:
                                                              new BorderRadius
                                                                  .circular(
                                                                  5.0),
                                                              side:
                                                              BorderSide(
                                                                width: 1.5,
                                                                color: warnaSocialBlock.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    192,
                                                                    192,
                                                                    192)
                                                                    : warnaSocialBlock[index] ==
                                                                    'kuning'
                                                                    ? Colors
                                                                    .white
                                                                    : Color.fromARGB(
                                                                    170,
                                                                    192,
                                                                    192,
                                                                    192),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              '1',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  18.0,
                                                                  color: warnaSocialBlock.length ==
                                                                      0
                                                                      ? Color.fromARGB(
                                                                      170,
                                                                      247,
                                                                      202,
                                                                      24)
                                                                      : warnaSocialBlock[index] == 'kuning'
                                                                      ? Colors.white
                                                                      : Color.fromARGB(170, 247, 202, 24)),
                                                              textAlign:
                                                              TextAlign
                                                                  .center,
                                                            ),
                                                            color: warnaSocialBlock
                                                                .length ==
                                                                0
                                                                ? Colors
                                                                .white
                                                                : warnaSocialBlock[index] ==
                                                                'kuning'
                                                                ? Color.fromARGB(
                                                                170,
                                                                247,
                                                                202,
                                                                24)
                                                                : Colors
                                                                .white,
                                                            onPressed: () {
                                                              setState(() {
                                                                if (criticalSocialBlock[
                                                                index] ==
                                                                    'false') {
                                                                  print(
                                                                      'false');
                                                                } else if (criticalSocialBlock[
                                                                index] ==
                                                                    'true') {
                                                                  if (scoreSocialBlock[
                                                                  index] ==
                                                                      null) {
                                                                    jumlahCriticalPoint =
                                                                        jumlahCriticalPoint +
                                                                            1;
                                                                    print(
                                                                        jumlahCriticalPoint);
                                                                  } else {
                                                                    if (scoreSocialBlock[index] ==
                                                                        2) {
                                                                      jumlahCriticalPoint =
                                                                          jumlahCriticalPoint + 1;
                                                                      print(
                                                                          jumlahCriticalPoint);
                                                                    } else if (scoreSocialBlock[index] ==
                                                                        0 ||
                                                                        scoreSocialBlock[index] ==
                                                                            1) {
                                                                      jumlahCriticalPoint =
                                                                          jumlahCriticalPoint + 0;
                                                                      print(
                                                                          jumlahCriticalPoint);
                                                                    }
                                                                  }
                                                                }

                                                                if (problemFS.length == 0) {
                                                                  
                                                                } else {
                                                                  if (problemFS.contains(jmlSocialBlock[index])) {
                                                                    areaFS.removeAt(problemFS.indexWhere((test) => test == jmlSocialBlock[index]));
                                                                    rekomendasiFS.removeAt(problemFS.indexWhere((test) => test == jmlSocialBlock[index]));
                                                                    carNoFS.removeAt(problemFS.indexWhere((test) => test == jmlSocialBlock[index]));
                                                                    auditorFS.removeAt(problemFS.indexWhere((test) => test == jmlSocialBlock[index]));
                                                                    auditorIDFS.removeAt(problemFS.indexWhere((test) => test == jmlSocialBlock[index]));
                                                                    criticalFS.removeAt(problemFS.indexWhere((test) => test == jmlSocialBlock[index]));
                                                                    subBabFS.removeAt(problemFS.indexWhere((test) => test == jmlSocialBlock[index]));
                                                                    problemFS.removeAt(problemFS.indexWhere((test) => test == jmlSocialBlock[index]));
                                                                  } else {
                                                                    
                                                                  }
                                                                }

                                                                scoreSocialBlock
                                                                    .removeAt(
                                                                    index);
                                                                scoreSocialBlock
                                                                    .insert(
                                                                    index,
                                                                    1);
                                                                warnaSocialBlock
                                                                    .removeAt(
                                                                    index);
                                                                warnaSocialBlock
                                                                    .insert(
                                                                    index,
                                                                    'kuning');

                                                                    print(problemFS);
                                                              print(areaFS);
                                                              print(criticalFS);
                                                              print(auditorFS);
                                                              print(subBabFS);
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        alignment:
                                                        Alignment(
                                                            0.0, 0.0),
                                                      ),
                                                    ),
                                                    jawabanSplitSocialBlock[2] ==
                                                        'null'
                                                        ? Container()
                                                        : Tooltip(
                                                      message:
                                                      jawabanSplitSocialBlock ==
                                                          null
                                                          ? ''
                                                          : jawabanSplitSocialBlock[
                                                      2],
                                                      preferBelow: false,
                                                      child: Container(
                                                        child: ButtonTheme(
                                                          minWidth: 50.0,
                                                          height: 50.0,
                                                          child:
                                                          RaisedButton(
                                                            shape:
                                                            new RoundedRectangleBorder(
                                                              borderRadius:
                                                              new BorderRadius
                                                                  .circular(
                                                                  5.0),
                                                              side:
                                                              BorderSide(
                                                                width: 1.5,
                                                                color: warnaSocialBlock.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    192,
                                                                    192,
                                                                    192)
                                                                    : warnaSocialBlock[index] ==
                                                                    'hijau'
                                                                    ? Colors
                                                                    .white
                                                                    : Color.fromARGB(
                                                                    170,
                                                                    192,
                                                                    192,
                                                                    192),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              '2',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  18.0,
                                                                  color: warnaSocialBlock.length ==
                                                                      0
                                                                      ? Color.fromARGB(
                                                                      170,
                                                                      50,
                                                                      205,
                                                                      50)
                                                                      : warnaSocialBlock[index] == 'hijau'
                                                                      ? Colors.white
                                                                      : Color.fromARGB(170, 50, 205, 50)),
                                                              textAlign:
                                                              TextAlign
                                                                  .center,
                                                            ),
                                                            color: warnaSocialBlock
                                                                .length ==
                                                                0
                                                                ? Colors
                                                                .white
                                                                : warnaSocialBlock[index] ==
                                                                'hijau'
                                                                ? Color.fromARGB(
                                                                170,
                                                                50,
                                                                205,
                                                                50)
                                                                : Colors
                                                                .white,
                                                            onPressed: () {
                                                              setState(() {
                                                                if (criticalSocialBlock[
                                                                index] ==
                                                                    'false') {
                                                                  print(
                                                                      'false');
                                                                } else if (criticalSocialBlock[
                                                                index] ==
                                                                    'true') {
                                                                  if (scoreSocialBlock[
                                                                  index] ==
                                                                      2) {
                                                                    jumlahCriticalPoint =
                                                                        jumlahCriticalPoint +
                                                                            0;
                                                                    print(
                                                                        jumlahCriticalPoint);
                                                                  } else {
                                                                    if (scoreSocialBlock[index] ==
                                                                        2) {
                                                                      jumlahCriticalPoint =
                                                                          jumlahCriticalPoint + 0;
                                                                      print(
                                                                          jumlahCriticalPoint);
                                                                    } else if (scoreSocialBlock[index] ==
                                                                        0 ||
                                                                        scoreSocialBlock[index] ==
                                                                            1) {
                                                                      jumlahCriticalPoint =
                                                                          jumlahCriticalPoint - 1;
                                                                      print(
                                                                          jumlahCriticalPoint);
                                                                    }
                                                                  }
                                                                }

                                                                if (problemFS.length == 0) {
                                                                  
                                                                } else {
                                                                  if (problemFS.contains(jmlSocialBlock[index])) {
                                                                    areaFS.removeAt(problemFS.indexWhere((test) => test == jmlSocialBlock[index]));
                                                                    rekomendasiFS.removeAt(problemFS.indexWhere((test) => test == jmlSocialBlock[index]));
                                                                    carNoFS.removeAt(problemFS.indexWhere((test) => test == jmlSocialBlock[index]));
                                                                    auditorFS.removeAt(problemFS.indexWhere((test) => test == jmlSocialBlock[index]));
                                                                    auditorIDFS.removeAt(problemFS.indexWhere((test) => test == jmlSocialBlock[index]));
                                                                    criticalFS.removeAt(problemFS.indexWhere((test) => test == jmlSocialBlock[index]));
                                                                    subBabFS.removeAt(problemFS.indexWhere((test) => test == jmlSocialBlock[index]));
                                                                    problemFS.removeAt(problemFS.indexWhere((test) => test == jmlSocialBlock[index]));
                                                                  } else {
                                                                    
                                                                  }
                                                                }

                                                                scoreSocialBlock
                                                                    .removeAt(
                                                                    index);
                                                                scoreSocialBlock
                                                                    .insert(
                                                                    index,
                                                                    2);
                                                                warnaSocialBlock
                                                                    .removeAt(
                                                                    index);
                                                                warnaSocialBlock
                                                                    .insert(
                                                                    index,
                                                                    'hijau');

                                                                    print(problemFS);
                                                              print(areaFS);
                                                              print(criticalFS);
                                                              print(auditorFS);
                                                              print(subBabFS);
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        alignment:
                                                        Alignment(
                                                            0.0, 0.0),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                          widget.subArea.contains('Social Block')
                                            ? Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    imageSocialBlock[index] == null
                                                      ? IconButton(
                                                          icon: Icon(Icons.camera_alt, color: AbubaPallate.greenabuba),
                                                          onPressed: () async {
                                                            var selectedImage =
                                                            await ImagePicker.pickImage(source: ImageSource.camera, maxHeight: 400.0, maxWidth: 400.0);
                                                            
                                                            imageSocialBlock1 = selectedImage;
                                                            filenameSocialBlock1 = basename(imageSocialBlock1.path);

                                                            StorageReference strRef = FirebaseStorage.instance.ref().child(filenameSocialBlock1);
                                                            StorageUploadTask uploadTask = strRef.putFile(imageSocialBlock1);

                                                            var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
                                                            var url = downUrl.toString();

                                                            setState(() {
                                                              if (imageSocialBlock[index] != null) {
                                                                List<String> bantuImageSocialBlock = [];
                                                                List<String> bantuImageSocialBlockSave = [];
                                                                bantuImageSocialBlock = imageSocialBlock[index].split('###');
                                                                bantuImageSocialBlock.add(filenameSocialBlock1);
                                                                imageSocialBlock[index] = bantuImageSocialBlock.join('###');

                                                                bantuImageSocialBlockSave = imageSocialBlockSave[index].split('###');
                                                                bantuImageSocialBlockSave.add(url);
                                                                imageSocialBlockSave[index] = bantuImageSocialBlockSave.join('###');
                                                              } else {
                                                                imageSocialBlock[index] = filenameSocialBlock1;
                                                                imageSocialBlockSave[index] = url;
                                                              }
                                                              // imageSocialBlockBantu[index] = imageSocialBlock1;
                                                              print(imageSocialBlock);
                                                              print(imageSocialBlockSave);
                                                              print(imageSocialBlock[index].split('###').length);
                                                              print(imageSocialBlockSave[index].split('###').length);
                                                            });
                                                          },
                                                        )
                                                      : imageSocialBlock[index].split('###').length >= 5
                                                          ? IconButton(
                                                              icon: Icon(Icons.disc_full, color: Colors.grey),
                                                              onPressed: () {},
                                                              tooltip: 'Sudah mencapai batas maksimal 5 foto tiap pertanyaan',
                                                            )
                                                          : IconButton(
                                                              icon: Icon(Icons.camera_alt, color: AbubaPallate.greenabuba),
                                                              onPressed: () async {
                                                                var selectedImage =
                                                                await ImagePicker.pickImage(source: ImageSource.camera, maxHeight: 400.0, maxWidth: 400.0);
                                                                
                                                                imageSocialBlock1 = selectedImage;
                                                                filenameSocialBlock1 = basename(imageSocialBlock1.path);

                                                                StorageReference strRef = FirebaseStorage.instance.ref().child(filenameSocialBlock1);
                                                                StorageUploadTask uploadTask = strRef.putFile(imageSocialBlock1);

                                                                var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
                                                                var url = downUrl.toString();

                                                                setState(() {
                                                                  if (imageSocialBlock[index] != null) {
                                                                    List<String> bantuImageSocialBlock = [];
                                                                    List<String> bantuImageSocialBlockSave = [];
                                                                    bantuImageSocialBlock = imageSocialBlock[index].split('###');
                                                                    bantuImageSocialBlock.add(filenameSocialBlock1);
                                                                    imageSocialBlock[index] = bantuImageSocialBlock.join('###');

                                                                    bantuImageSocialBlockSave = imageSocialBlockSave[index].split('###');
                                                                    bantuImageSocialBlockSave.add(url);
                                                                    imageSocialBlockSave[index] = bantuImageSocialBlockSave.join('###');
                                                                  } else {
                                                                    imageSocialBlock[index] = filenameSocialBlock1;
                                                                    imageSocialBlockSave[index] = url;
                                                                  }
                                                                  // imageSocialBlockBantu[index] = imageSocialBlock1;
                                                                  print(imageSocialBlock);
                                                                  print(imageSocialBlockSave);
                                                                  print(imageSocialBlock[index].split('###').length);
                                                                  print(imageSocialBlockSave[index].split('###').length);
                                                                });
                                                              },
                                                            ),
                                                    IconButton(
                                                      icon: Icon(Icons.event_note,
                                                          color: AbubaPallate
                                                              .greenabuba),
                                                      onPressed: () {
                                                        if (noteSocialBlock[
                                                        index] ==
                                                            null) {
                                                          _controllerSocialBlock
                                                              .text = '';
                                                        } else {
                                                          _controllerSocialBlock
                                                              .text =
                                                          noteSocialBlock[
                                                          index];
                                                        }
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              title: Text('NOTE'),
                                                              content: Container(
                                                                width: 300.0,
                                                                child: TextField(
                                                                  controller:
                                                                  _controllerSocialBlock,
                                                                  decoration:
                                                                  InputDecoration(
                                                                    border:
                                                                    OutlineInputBorder(),
                                                                    hintText:
                                                                    'Note',
                                                                    hintStyle: TextStyle(
                                                                        fontSize:
                                                                        12.0),
                                                                  ),
                                                                  maxLines: 3,
                                                                  style:
                                                                  TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                              ),
                                                              actions: <Widget>[
                                                                FlatButton(
                                                                  splashColor: Colors
                                                                      .greenAccent,
                                                                  child: Text(
                                                                    'OK',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .green),
                                                                  ),
                                                                  onPressed: () {
                                                                    noteSocialBlock
                                                                        .removeAt(
                                                                        index);
                                                                    noteSocialBlock.insert(
                                                                        index,
                                                                        _controllerSocialBlock
                                                                            .text);
                                                                    print(
                                                                        noteSocialBlock);
                                                                    Navigator.of(
                                                                        context)
                                                                        .pop();
                                                                  },
                                                                )
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                          Divider(
                                            height: 2.0,
                                          ),
                                        ],
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
                            );
                          },
                        ),
                        PreferredSize(
                          preferredSize: Size.fromHeight(
                              MediaQuery.of(context).size.height -
                                  55.0 -
                                  (MediaQuery.of(context).size.height * 0.7)),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 55.0,
                                child: Container(
                                    child: Padding(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: <Widget>[
                                              IconButton(
                                                icon: Icon(Icons.arrow_back_ios,
                                                    color: Colors.white),
                                                onPressed: () {
                                                  _cardController.animateTo(
                                                      _cardController.index - 1);
                                                },
                                                tooltip: 'Previous',
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.arrow_forward_ios,
                                                    color: Colors.white),
                                                onPressed: () {
                                                  if (widget.subArea.contains('Social Block')) {
                                                    if (scoreSocialBlock[
                                                    indexSocialBlock] ==
                                                        null) {
                                                      showDialog(
                                                        barrierDismissible: false,
                                                        context: context,
                                                        builder: (context) => Dialog(
                                                          child: Container(
                                                            height: 180.0,
                                                            child: Column(
                                                              children: <Widget>[
                                                                Container(
                                                                  color: AbubaPallate
                                                                      .greenabuba,
                                                                  height: 50.0,
                                                                  child: Center(
                                                                    child: Text(
                                                                      'OOPS!',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                          17.0,
                                                                          fontWeight:
                                                                          FontWeight.w700),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 20.0,
                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                      10.0,
                                                                      vertical:
                                                                      10.0),
                                                                  child: Text(
                                                                    'Please select the answer!',
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      16.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                                  children: <
                                                                      Widget>[
                                                                    FlatButton(
                                                                      child: Text(
                                                                          'OK'),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      hasilSocialBlock = 0;
                                                      for (int i = 0;
                                                      i < scoreSocialBlock.length;
                                                      i++) {
                                                        hasilSocialBlock += double
                                                            .tryParse(
                                                            bobotPertanyaanSocialBlock[
                                                            i]
                                                                .toString()) *
                                                            double.tryParse(
                                                                scoreSocialBlock[i]
                                                                    .toString());
                                                      }
                                                      hasilSocialBlock = hasilSocialBlock / 2;
                                                      // if (hasilSocialBlock > 1.0) {
                                                      //   hasilSocialBlock = 1.0;
                                                      // } else {
                                                      //   hasilSocialBlock =
                                                      //       hasilSocialBlock;
                                                      // }
                                                      // finalSocialBlock =
                                                      //     (hasilSocialBlock *
                                                      //         parameterSocialBlock) /
                                                      //         100;

                                                      print(bobotPertanyaanSocialBlock);
                                                      print(scoreSocialBlock);
                                                      print(hasilSocialBlock);
                                                      // print(finalSocialBlock);
                                                      _cardController.animateTo(_cardController.index + 1);
                                                    }
                                                  } else {
                                                    print(bobotPertanyaanSocialBlock);
                                                    print(scoreSocialBlock);
                                                    print(hasilSocialBlock);
                                                    print(finalSocialBlock);
                                                    _cardController.animateTo(_cardController.index + 1);
                                                  }
                                                },
                                                tooltip: 'Next',
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    decoration:
                                    BoxDecoration(color: Color(0xFF2F592F))),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                // sini personal hygiene
                ListView(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      children: <Widget>[
                        PreferredSize(
                          preferredSize: Size.fromHeight(55.0),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 55.0,
                                child: Container(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.75,
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                text: TextSpan(
                                                  text: 'Personal Hygiene',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17.0
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.75,
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                text: TextSpan(
                                                  text: 'Auditor : ${auditorName[8].toString()}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11.0
                                                  ),
                                                ),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '9 of ${_listData.length.toString()}',
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 14.0),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF2F592F),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        AnimatedBuilder(
                          animation: animationController,
                          builder: (_, Widget child) {
                            return animationController.isAnimating
                                ? Center(
                              child: Container(
                                child: CircularProgressIndicator(),
                                alignment: Alignment(0.0, 0.0),
                                height: MediaQuery.of(context).size.height *
                                    0.736,
                              ),
                            )
                                : Container(
                              height:
                              MediaQuery.of(context).size.height * 0.736,
                              color: Colors.white,
                              child: Scrollbar(
                                child: ListView(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  children: List.generate(
                                    jmlPersonal.length,
                                        (index) {
                                      indexPersonal = index;
                                      jawabanSplitPersonal =
                                          jawabanSplitPersonalBantu[index]
                                              .split(r"!@#$");
                                      if (scorePersonal.length <
                                          jumlahPersonal) {
                                        for (int a = 0;
                                        a < jumlahPersonal;
                                        a++) {
                                          notePersonal.add(null);
                                          scorePersonal.add(null);
                                          imagePersonal.add(null);
                                          imagePersonalBantu.add(null);
                                          imagePersonalSave.add(null);
                                          warnaPersonal.add('abu');
                                        }
                                      }

                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          criticalPersonal[index] == 'false'
                                              ? Padding(
                                            padding: EdgeInsets.only(
                                                right: 15.0,
                                                left: 15.0,
                                                bottom: 8.0,
                                                top: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    systemPersonal[
                                                    index],
                                                    style: TextStyle(
                                                        color: Colors
                                                            .green,
                                                        fontWeight:
                                                        FontWeight
                                                            .w700,
                                                        fontSize: 16.0),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                              : Padding(
                                            padding: EdgeInsets.only(
                                                right: 15.0,
                                                left: 15.0,
                                                bottom: 8.0,
                                                top: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    systemPersonal[
                                                    index],
                                                    style: TextStyle(
                                                        color: Colors
                                                            .green,
                                                        fontWeight:
                                                        FontWeight
                                                            .w700,
                                                        fontSize: 16.0),
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    'CRITICAL',
                                                    style: TextStyle(
                                                        color:
                                                        Colors.red,
                                                        fontWeight:
                                                        FontWeight
                                                            .w700,
                                                        fontSize: 16.0),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 15.0,
                                                      left: 15.0,
                                                      top: 10.0,
                                                      bottom: 50.0),
                                                  child: Text(
                                                    jmlPersonal[index],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20.0),
                                                    textAlign:
                                                    TextAlign.start,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          widget.subArea.contains('Personal Hygiene')
                                            ? Padding(
                                                padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 15.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: <Widget>[
                                                    jawabanSplitPersonal[0] ==
                                                        'null'
                                                        ? Container()
                                                        : Tooltip(
                                                      message:
                                                      jawabanSplitPersonal ==
                                                          null
                                                          ? ''
                                                          : jawabanSplitPersonal[
                                                      0],
                                                      preferBelow: false,
                                                      child: Container(
                                                        child: ButtonTheme(
                                                          minWidth: 50.0,
                                                          height: 50.0,
                                                          child:
                                                          RaisedButton(
                                                            shape:
                                                            new RoundedRectangleBorder(
                                                              borderRadius:
                                                              new BorderRadius
                                                                  .circular(
                                                                  5.0),
                                                              side:
                                                              BorderSide(
                                                                width: 1.5,
                                                                color: warnaPersonal.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    192,
                                                                    192,
                                                                    192)
                                                                    : warnaPersonal[index] ==
                                                                    'merah'
                                                                    ? Colors
                                                                    .white
                                                                    : Color.fromARGB(
                                                                    170,
                                                                    192,
                                                                    192,
                                                                    192),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              '0',
                                                              style:
                                                              TextStyle(
                                                                fontSize:
                                                                18.0,
                                                                color: warnaPersonal.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    255,
                                                                    40,
                                                                    0)
                                                                    : warnaPersonal[index] ==
                                                                    'merah'
                                                                    ? Colors
                                                                    .white
                                                                    : Color.fromARGB(
                                                                    170,
                                                                    255,
                                                                    40,
                                                                    0),
                                                              ),
                                                              textAlign:
                                                              TextAlign
                                                                  .center,
                                                            ),
                                                            color: warnaPersonal
                                                                .length ==
                                                                0
                                                                ? Colors
                                                                .white
                                                                : warnaPersonal[index] ==
                                                                'merah'
                                                                ? Color.fromARGB(
                                                                170,
                                                                255,
                                                                40,
                                                                0)
                                                                : Colors
                                                                .white,
                                                            onPressed: () {
                                                              setState(() {
                                                                if (criticalPersonal[
                                                                index] ==
                                                                    'false') {
                                                                  print(
                                                                      'false');
                                                                } else if (criticalPersonal[
                                                                index] ==
                                                                    'true') {
                                                                  if (scorePersonal[
                                                                  index] ==
                                                                      null) {
                                                                    jumlahCriticalPoint =
                                                                        jumlahCriticalPoint +
                                                                            1;
                                                                    print(
                                                                        jumlahCriticalPoint);
                                                                  } else {
                                                                    if (scorePersonal[index] ==
                                                                        2) {
                                                                      jumlahCriticalPoint =
                                                                          jumlahCriticalPoint + 1;
                                                                      print(
                                                                          jumlahCriticalPoint);
                                                                    } else if (scorePersonal[index] ==
                                                                        0 ||
                                                                        scorePersonal[index] ==
                                                                            1) {
                                                                      jumlahCriticalPoint =
                                                                          jumlahCriticalPoint + 0;
                                                                      print(
                                                                          jumlahCriticalPoint);
                                                                    }
                                                                  }
                                                                }

                                                                if (problemFS.length == 0) {
                                                                  problemFS.add(jmlPersonal[index]);
                                                                  areaFS.add('Personal Hygiene');
                                                                  auditorFS.add(auditorName[8]);
                                                                  auditorIDFS.add(int.tryParse(widget.auditor[8].toString()));
                                                                  subBabFS.add(systemPersonal[index]);
                                                                  rekomendasiFS.add(null);
                                                                      carNoFS.add(null);
                                                                  criticalFS.add(criticalPersonal[index] == 'false' ? 'no' : 'yes');
                                                                } else {
                                                                  if (problemFS.contains(jmlPersonal[index])) {
                                                                    
                                                                  } else {
                                                                    rekomendasiFS.add(null);
                                                                      carNoFS.add(null);
                                                                    problemFS.add(jmlPersonal[index]);
                                                                    areaFS.add('Personal Hygiene');
                                                                    auditorFS.add(auditorName[8]);
                                                                    auditorIDFS.add(int.tryParse(widget.auditor[8].toString()));
                                                                    subBabFS.add(systemPersonal[index]);
                                                                    criticalFS.add(criticalPersonal[index] == 'false' ? 'no' : 'yes');
                                                                  }
                                                                }
                                                                
                                                                scorePersonal
                                                                    .removeAt(
                                                                    index);
                                                                scorePersonal
                                                                    .insert(
                                                                    index,
                                                                    0);
                                                                warnaPersonal
                                                                    .removeAt(
                                                                    index);
                                                                warnaPersonal
                                                                    .insert(
                                                                    index,
                                                                    'merah');

                                                                    print(problemFS);
                                                              print(areaFS);
                                                              print(criticalFS);
                                                              print(auditorFS);
                                                              print(subBabFS);
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        alignment:
                                                        Alignment(
                                                            0.0, 0.0),
                                                      ),
                                                    ),
                                                    jawabanSplitPersonal[1] ==
                                                        'null'
                                                        ? Container()
                                                        : Tooltip(
                                                      message:
                                                      jawabanSplitPersonal ==
                                                          null
                                                          ? ''
                                                          : jawabanSplitPersonal[
                                                      1],
                                                      preferBelow: false,
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                            horizontal:
                                                            5.0),
                                                        child: ButtonTheme(
                                                          minWidth: 50.0,
                                                          height: 50.0,
                                                          child:
                                                          RaisedButton(
                                                            shape:
                                                            new RoundedRectangleBorder(
                                                              borderRadius:
                                                              new BorderRadius
                                                                  .circular(
                                                                  5.0),
                                                              side:
                                                              BorderSide(
                                                                width: 1.5,
                                                                color: warnaPersonal.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    192,
                                                                    192,
                                                                    192)
                                                                    : warnaPersonal[index] ==
                                                                    'kuning'
                                                                    ? Colors
                                                                    .white
                                                                    : Color.fromARGB(
                                                                    170,
                                                                    192,
                                                                    192,
                                                                    192),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              '1',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  18.0,
                                                                  color: warnaPersonal.length ==
                                                                      0
                                                                      ? Color.fromARGB(
                                                                      170,
                                                                      247,
                                                                      202,
                                                                      24)
                                                                      : warnaPersonal[index] == 'kuning'
                                                                      ? Colors.white
                                                                      : Color.fromARGB(170, 247, 202, 24)),
                                                              textAlign:
                                                              TextAlign
                                                                  .center,
                                                            ),
                                                            color: warnaPersonal
                                                                .length ==
                                                                0
                                                                ? Colors
                                                                .white
                                                                : warnaPersonal[index] ==
                                                                'kuning'
                                                                ? Color.fromARGB(
                                                                170,
                                                                247,
                                                                202,
                                                                24)
                                                                : Colors
                                                                .white,
                                                            onPressed: () {
                                                              setState(() {
                                                                if (criticalPersonal[
                                                                index] ==
                                                                    'false') {
                                                                  print(
                                                                      'false');
                                                                } else if (criticalPersonal[
                                                                index] ==
                                                                    'true') {
                                                                  if (scorePersonal[
                                                                  index] ==
                                                                      null) {
                                                                    jumlahCriticalPoint =
                                                                        jumlahCriticalPoint +
                                                                            1;
                                                                    print(
                                                                        jumlahCriticalPoint);
                                                                  } else {
                                                                    if (scorePersonal[index] ==
                                                                        2) {
                                                                      jumlahCriticalPoint =
                                                                          jumlahCriticalPoint + 1;
                                                                      print(
                                                                          jumlahCriticalPoint);
                                                                    } else if (scorePersonal[index] ==
                                                                        0 ||
                                                                        scorePersonal[index] ==
                                                                            1) {
                                                                      jumlahCriticalPoint =
                                                                          jumlahCriticalPoint + 0;
                                                                      print(
                                                                          jumlahCriticalPoint);
                                                                    }
                                                                  }
                                                                }

                                                                if (problemFS.length == 0) {
                                                                  
                                                                } else {
                                                                  if (problemFS.contains(jmlPersonal[index])) {
                                                                    areaFS.removeAt(problemFS.indexWhere((test) => test == jmlPersonal[index]));
                                                                    auditorFS.removeAt(problemFS.indexWhere((test) => test == jmlPersonal[index]));
                                                                    rekomendasiFS.removeAt(problemFS.indexWhere((test) => test == jmlPersonal[index]));
                                                                    carNoFS.removeAt(problemFS.indexWhere((test) => test == jmlPersonal[index]));
                                                                    auditorIDFS.removeAt(problemFS.indexWhere((test) => test == jmlPersonal[index]));
                                                                    criticalFS.removeAt(problemFS.indexWhere((test) => test == jmlPersonal[index]));
                                                                    subBabFS.removeAt(problemFS.indexWhere((test) => test == jmlPersonal[index]));
                                                                    problemFS.removeAt(problemFS.indexWhere((test) => test == jmlPersonal[index]));
                                                                  } else {
                                                                    
                                                                  }
                                                                }

                                                                scorePersonal
                                                                    .removeAt(
                                                                    index);
                                                                scorePersonal
                                                                    .insert(
                                                                    index,
                                                                    1);
                                                                warnaPersonal
                                                                    .removeAt(
                                                                    index);
                                                                warnaPersonal
                                                                    .insert(
                                                                    index,
                                                                    'kuning');

                                                                    print(problemFS);
                                                              print(areaFS);
                                                              print(criticalFS);
                                                              print(auditorFS);
                                                              print(subBabFS);
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        alignment:
                                                        Alignment(
                                                            0.0, 0.0),
                                                      ),
                                                    ),
                                                    jawabanSplitPersonal[2] ==
                                                        'null'
                                                        ? Container()
                                                        : Tooltip(
                                                      message:
                                                      jawabanSplitPersonal ==
                                                          null
                                                          ? ''
                                                          : jawabanSplitPersonal[
                                                      2],
                                                      preferBelow: false,
                                                      child: Container(
                                                        child: ButtonTheme(
                                                          minWidth: 50.0,
                                                          height: 50.0,
                                                          child:
                                                          RaisedButton(
                                                            shape:
                                                            new RoundedRectangleBorder(
                                                              borderRadius:
                                                              new BorderRadius
                                                                  .circular(
                                                                  5.0),
                                                              side:
                                                              BorderSide(
                                                                width: 1.5,
                                                                color: warnaPersonal.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    192,
                                                                    192,
                                                                    192)
                                                                    : warnaPersonal[index] ==
                                                                    'hijau'
                                                                    ? Colors
                                                                    .white
                                                                    : Color.fromARGB(
                                                                    170,
                                                                    192,
                                                                    192,
                                                                    192),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              '2',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  18.0,
                                                                  color: warnaPersonal.length ==
                                                                      0
                                                                      ? Color.fromARGB(
                                                                      170,
                                                                      50,
                                                                      205,
                                                                      50)
                                                                      : warnaPersonal[index] == 'hijau'
                                                                      ? Colors.white
                                                                      : Color.fromARGB(170, 50, 205, 50)),
                                                              textAlign:
                                                              TextAlign
                                                                  .center,
                                                            ),
                                                            color: warnaPersonal
                                                                .length ==
                                                                0
                                                                ? Colors
                                                                .white
                                                                : warnaPersonal[index] ==
                                                                'hijau'
                                                                ? Color.fromARGB(
                                                                170,
                                                                50,
                                                                205,
                                                                50)
                                                                : Colors
                                                                .white,
                                                            onPressed: () {
                                                              setState(() {
                                                                if (criticalPersonal[
                                                                index] ==
                                                                    'false') {
                                                                  print(
                                                                      'false');
                                                                } else if (criticalPersonal[
                                                                index] ==
                                                                    'true') {
                                                                  if (scorePersonal[
                                                                  index] ==
                                                                      2) {
                                                                    jumlahCriticalPoint =
                                                                        jumlahCriticalPoint +
                                                                            0;
                                                                    print(
                                                                        jumlahCriticalPoint);
                                                                  } else {
                                                                    if (scorePersonal[index] ==
                                                                        2) {
                                                                      jumlahCriticalPoint =
                                                                          jumlahCriticalPoint + 0;
                                                                      print(
                                                                          jumlahCriticalPoint);
                                                                    } else if (scorePersonal[index] ==
                                                                        0 ||
                                                                        scorePersonal[index] ==
                                                                            1) {
                                                                      jumlahCriticalPoint =
                                                                          jumlahCriticalPoint - 1;
                                                                      print(
                                                                          jumlahCriticalPoint);
                                                                    }
                                                                  }
                                                                }

                                                                if (problemFS.length == 0) {
                                                                  
                                                                } else {
                                                                  if (problemFS.contains(jmlPersonal[index])) {
                                                                    rekomendasiFS.removeAt(problemFS.indexWhere((test) => test == jmlPersonal[index]));
                                                                    carNoFS.removeAt(problemFS.indexWhere((test) => test == jmlPersonal[index]));
                                                                    areaFS.removeAt(problemFS.indexWhere((test) => test == jmlPersonal[index]));
                                                                    auditorFS.removeAt(problemFS.indexWhere((test) => test == jmlPersonal[index]));
                                                                    auditorIDFS.removeAt(problemFS.indexWhere((test) => test == jmlPersonal[index]));
                                                                    criticalFS.removeAt(problemFS.indexWhere((test) => test == jmlPersonal[index]));
                                                                    subBabFS.removeAt(problemFS.indexWhere((test) => test == jmlPersonal[index]));
                                                                    problemFS.removeAt(problemFS.indexWhere((test) => test == jmlPersonal[index]));
                                                                  } else {
                                                                    
                                                                  }
                                                                }

                                                                scorePersonal
                                                                    .removeAt(
                                                                    index);
                                                                scorePersonal
                                                                    .insert(
                                                                    index,
                                                                    2);
                                                                warnaPersonal
                                                                    .removeAt(
                                                                    index);
                                                                warnaPersonal
                                                                    .insert(
                                                                    index,
                                                                    'hijau');

                                                                    print(problemFS);
                                                              print(areaFS);
                                                              print(criticalFS);
                                                              print(auditorFS);
                                                              print(subBabFS);
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        alignment:
                                                        Alignment(
                                                            0.0, 0.0),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                          widget.subArea.contains('Personal Hygiene')
                                            ? Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    imagePersonal[index] == null
                                                      ? IconButton(
                                                          icon: Icon(Icons.camera_alt, color: AbubaPallate.greenabuba),
                                                          onPressed: () async {
                                                            var selectedImage =
                                                            await ImagePicker.pickImage(source: ImageSource.camera, maxHeight: 400.0, maxWidth: 400.0);
                                                            
                                                            imagePersonal1 = selectedImage;
                                                            filenamePersonal1 = basename(imagePersonal1.path);

                                                            StorageReference strRef = FirebaseStorage.instance.ref().child(filenamePersonal1);
                                                            StorageUploadTask uploadTask = strRef.putFile(imagePersonal1);

                                                            var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
                                                            var url = downUrl.toString();

                                                            setState(() {
                                                              if (imagePersonal[index] != null) {
                                                                List<String> bantuImagePersonal = [];
                                                                List<String> bantuImagePersonalSave = [];
                                                                bantuImagePersonal = imagePersonal[index].split('###');
                                                                bantuImagePersonal.add(filenamePersonal1);
                                                                imagePersonal[index] = bantuImagePersonal.join('###');

                                                                bantuImagePersonalSave = imagePersonalSave[index].split('###');
                                                                bantuImagePersonalSave.add(url);
                                                                imagePersonalSave[index] = bantuImagePersonalSave.join('###');
                                                              } else {
                                                                imagePersonal[index] = filenamePersonal1;
                                                                imagePersonalSave[index] = url;
                                                              }
                                                              // imagePersonalBantu[index] = imagePersonal1;
                                                              print(imagePersonal);
                                                              print(imagePersonalSave);
                                                              print(imagePersonal[index].split('###').length);
                                                              print(imagePersonalSave[index].split('###').length);
                                                            });
                                                          },
                                                        )
                                                      : imagePersonal[index].split('###').length >= 5
                                                          ? IconButton(
                                                              icon: Icon(Icons.disc_full, color: Colors.grey),
                                                              onPressed: () {},
                                                              tooltip: 'Sudah mencapai batas maksimal 5 foto tiap pertanyaan',
                                                            )
                                                          : IconButton(
                                                              icon: Icon(Icons.camera_alt, color: AbubaPallate.greenabuba),
                                                              onPressed: () async {
                                                                var selectedImage =
                                                                await ImagePicker.pickImage(source: ImageSource.camera, maxHeight: 400.0, maxWidth: 400.0);
                                                                
                                                                imagePersonal1 = selectedImage;
                                                                filenamePersonal1 = basename(imagePersonal1.path);

                                                                StorageReference strRef = FirebaseStorage.instance.ref().child(filenamePersonal1);
                                                                StorageUploadTask uploadTask = strRef.putFile(imagePersonal1);

                                                                var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
                                                                var url = downUrl.toString();

                                                                setState(() {
                                                                  if (imagePersonal[index] != null) {
                                                                    List<String> bantuImagePersonal = [];
                                                                    List<String> bantuImagePersonalSave = [];
                                                                    bantuImagePersonal = imagePersonal[index].split('###');
                                                                    bantuImagePersonal.add(filenamePersonal1);
                                                                    imagePersonal[index] = bantuImagePersonal.join('###');

                                                                    bantuImagePersonalSave = imagePersonalSave[index].split('###');
                                                                    bantuImagePersonalSave.add(url);
                                                                    imagePersonalSave[index] = bantuImagePersonalSave.join('###');
                                                                  } else {
                                                                    imagePersonal[index] = filenamePersonal1;
                                                                    imagePersonalSave[index] = url;
                                                                  }
                                                                  // imagePersonalBantu[index] = imagePersonal1;
                                                                  print(imagePersonal);
                                                                  print(imagePersonalSave);
                                                                  print(imagePersonal[index].split('###').length);
                                                                  print(imagePersonalSave[index].split('###').length);
                                                                });
                                                              },
                                                            ),
                                                    IconButton(
                                                      icon: Icon(Icons.event_note,
                                                          color: AbubaPallate
                                                              .greenabuba),
                                                      onPressed: () {
                                                        if (notePersonal[index] ==
                                                            null) {
                                                          _controllerPersonal
                                                              .text = '';
                                                        } else {
                                                          _controllerPersonal
                                                              .text =
                                                          notePersonal[index];
                                                        }
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              title: Text('NOTE'),
                                                              content: Container(
                                                                width: 300.0,
                                                                child: TextField(
                                                                  controller:
                                                                  _controllerPersonal,
                                                                  decoration:
                                                                  InputDecoration(
                                                                    border:
                                                                    OutlineInputBorder(),
                                                                    hintText:
                                                                    'Note',
                                                                    hintStyle: TextStyle(
                                                                        fontSize:
                                                                        12.0),
                                                                  ),
                                                                  maxLines: 3,
                                                                  style:
                                                                  TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                              ),
                                                              actions: <Widget>[
                                                                FlatButton(
                                                                  splashColor: Colors
                                                                      .greenAccent,
                                                                  child: Text(
                                                                    'OK',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .green),
                                                                  ),
                                                                  onPressed: () {
                                                                    notePersonal
                                                                        .removeAt(
                                                                        index);
                                                                    notePersonal.insert(
                                                                        index,
                                                                        _controllerPersonal
                                                                            .text);
                                                                    print(
                                                                        notePersonal);
                                                                    Navigator.of(
                                                                        context)
                                                                        .pop();
                                                                  },
                                                                )
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                          Divider(
                                            height: 2.0,
                                          ),
                                        ],
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
                            );
                          },
                        ),
                        PreferredSize(
                          preferredSize: Size.fromHeight(
                              MediaQuery.of(context).size.height -
                                  55.0 -
                                  (MediaQuery.of(context).size.height * 0.7)),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 55.0,
                                child: Container(
                                    child: Padding(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: <Widget>[
                                              IconButton(
                                                icon: Icon(Icons.arrow_back_ios,
                                                    color: Colors.white),
                                                onPressed: () {
                                                  _cardController.animateTo(
                                                      _cardController.index - 1);
                                                },
                                                tooltip: 'Previous',
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.arrow_forward_ios,
                                                    color: Colors.white),
                                                onPressed: () {
                                                  if (widget.subArea.contains('Personal Hygiene')) {
                                                    if (scorePersonal[
                                                    indexPersonal] ==
                                                        null) {
                                                      showDialog(
                                                        barrierDismissible: false,
                                                        context: context,
                                                        builder: (context) => Dialog(
                                                          child: Container(
                                                            height: 180.0,
                                                            child: Column(
                                                              children: <Widget>[
                                                                Container(
                                                                  color: AbubaPallate
                                                                      .greenabuba,
                                                                  height: 50.0,
                                                                  child: Center(
                                                                    child: Text(
                                                                      'OOPS!',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                          17.0,
                                                                          fontWeight:
                                                                          FontWeight.w700),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 20.0,
                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                      10.0,
                                                                      vertical:
                                                                      10.0),
                                                                  child: Text(
                                                                    'Please select the answer!',
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:
                                                                      16.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                                  children: <
                                                                      Widget>[
                                                                    FlatButton(
                                                                      child: Text(
                                                                          'OK'),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      hasilPersonal = 0;
                                                      for (int i = 0;
                                                      i < scorePersonal.length;
                                                      i++) {
                                                        hasilPersonal += double.tryParse(
                                                            bobotPertanyaanPersonal[
                                                            i]
                                                                .toString()) *
                                                            double.tryParse(
                                                                scorePersonal[i]
                                                                    .toString());
                                                      }
                                                      hasilPersonal = hasilPersonal / 2;
                                                      // if (hasilPersonal > 1.0) {
                                                      //   hasilPersonal = 1.0;
                                                      // } else {
                                                      //   hasilPersonal = hasilPersonal;
                                                      // }
                                                      // finalPersonal = (hasilPersonal *
                                                      //     parameterPersonal) /
                                                      //     100;

                                                      print(bobotPertanyaanPersonal);
                                                      print(scorePersonal);
                                                      print(hasilPersonal);
                                                      // print(finalPersonal);
                                                      _cardController.animateTo(_cardController.index + 1);
                                                    }
                                                  } else {
                                                    print(bobotPertanyaanPersonal);
                                                    print(scorePersonal);
                                                    print(hasilPersonal);
                                                    print(finalPersonal);
                                                    _cardController.animateTo(_cardController.index + 1);
                                                  }
                                                },
                                                tooltip: 'Next',
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    decoration:
                                    BoxDecoration(color: Color(0xFF2F592F))),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                // sini food completely cooked
                ListView(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      children: <Widget>[
                        PreferredSize(
                          preferredSize: Size.fromHeight(55.0),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 55.0,
                                child: Container(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.7,
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                                text: TextSpan(
                                                  text: 'Food Completely Cooked',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17.0
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.7,
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                text: TextSpan(
                                                  text: 'Auditor : ${auditorName[9].toString()}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11.0
                                                  ),
                                                ),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '10 of ${_listData.length.toString()}',
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 14.0),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF2F592F),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        AnimatedBuilder(
                          animation: animationController,
                          builder: (_, Widget child) {
                            return animationController.isAnimating
                                ? Center(
                              child: Container(
                                child: CircularProgressIndicator(),
                                alignment: Alignment(0.0, 0.0),
                                height: MediaQuery.of(context).size.height *
                                    0.736,
                              ),
                            )
                                : Container(
                              height:
                              MediaQuery.of(context).size.height * 0.736,
                              color: Colors.white,
                              child: Scrollbar(
                                child: ListView(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  children: List.generate(
                                    jmlFoodCooked.length,
                                        (index) {
                                      indexFoodCooked = index;
                                      jawabanSplitFoodCooked =
                                          jawabanSplitFoodCookedBantu[index]
                                              .split(r"!@#$");
                                      if (scoreFoodCooked.length <
                                          jumlahFoodCooked) {
                                        for (int a = 0;
                                        a < jumlahFoodCooked;
                                        a++) {
                                          noteFoodCooked.add(null);
                                          scoreFoodCooked.add(null);
                                          imageFoodCooked.add(null);
                                          imageFoodCookedBantu.add(null);
                                          imageFoodCookedSave.add(null);
                                          warnaFoodCooked.add('abu');
                                        }
                                      }

                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          criticalFoodCooked[index] == 'false'
                                              ? Padding(
                                            padding: EdgeInsets.only(
                                                right: 15.0,
                                                left: 15.0,
                                                bottom: 8.0,
                                                top: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    systemFoodCooked[
                                                    index],
                                                    style: TextStyle(
                                                        color: Colors
                                                            .green,
                                                        fontWeight:
                                                        FontWeight
                                                            .w700,
                                                        fontSize: 16.0),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                              : Padding(
                                            padding: EdgeInsets.only(
                                                right: 15.0,
                                                left: 15.0,
                                                bottom: 8.0,
                                                top: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    systemFoodCooked[
                                                    index],
                                                    style: TextStyle(
                                                        color: Colors
                                                            .green,
                                                        fontWeight:
                                                        FontWeight
                                                            .w700,
                                                        fontSize: 16.0),
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    'CRITICAL',
                                                    style: TextStyle(
                                                        color:
                                                        Colors.red,
                                                        fontWeight:
                                                        FontWeight
                                                            .w700,
                                                        fontSize: 16.0),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 15.0,
                                                      left: 15.0,
                                                      top: 10.0,
                                                      bottom: 50.0),
                                                  child: Text(
                                                    jmlFoodCooked[index],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20.0),
                                                    textAlign:
                                                    TextAlign.start,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          widget.subArea.contains('Food Completely Cooked')
                                            ? Padding(
                                                padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 15.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: <Widget>[
                                                    jawabanSplitFoodCooked[0] ==
                                                        'null'
                                                        ? Container()
                                                        : Tooltip(
                                                      message:
                                                      jawabanSplitFoodCooked ==
                                                          null
                                                          ? ''
                                                          : jawabanSplitFoodCooked[
                                                      0],
                                                      preferBelow: false,
                                                      child: Container(
                                                        child: ButtonTheme(
                                                          minWidth: 50.0,
                                                          height: 50.0,
                                                          child:
                                                          RaisedButton(
                                                            shape:
                                                            new RoundedRectangleBorder(
                                                              borderRadius:
                                                              new BorderRadius
                                                                  .circular(
                                                                  5.0),
                                                              side:
                                                              BorderSide(
                                                                width: 1.5,
                                                                color: warnaFoodCooked.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    192,
                                                                    192,
                                                                    192)
                                                                    : warnaFoodCooked[index] ==
                                                                    'merah'
                                                                    ? Colors
                                                                    .white
                                                                    : Color.fromARGB(
                                                                    170,
                                                                    192,
                                                                    192,
                                                                    192),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              '0',
                                                              style:
                                                              TextStyle(
                                                                fontSize:
                                                                18.0,
                                                                color: warnaFoodCooked.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    255,
                                                                    40,
                                                                    0)
                                                                    : warnaFoodCooked[index] ==
                                                                    'merah'
                                                                    ? Colors
                                                                    .white
                                                                    : Color.fromARGB(
                                                                    170,
                                                                    255,
                                                                    40,
                                                                    0),
                                                              ),
                                                              textAlign:
                                                              TextAlign
                                                                  .center,
                                                            ),
                                                            color: warnaFoodCooked
                                                                .length ==
                                                                0
                                                                ? Colors
                                                                .white
                                                                : warnaFoodCooked[index] ==
                                                                'merah'
                                                                ? Color.fromARGB(
                                                                170,
                                                                255,
                                                                40,
                                                                0)
                                                                : Colors
                                                                .white,
                                                            onPressed: () {
                                                              setState(() {
                                                                if (criticalFoodCooked[
                                                                index] ==
                                                                    'false') {
                                                                  print(
                                                                      'false');
                                                                } else if (criticalFoodCooked[
                                                                index] ==
                                                                    'true') {
                                                                  if (scoreFoodCooked[
                                                                  index] ==
                                                                      null) {
                                                                    jumlahCriticalPoint =
                                                                        jumlahCriticalPoint +
                                                                            1;
                                                                    print(
                                                                        jumlahCriticalPoint);
                                                                  } else {
                                                                    if (scoreFoodCooked[index] ==
                                                                        2) {
                                                                      jumlahCriticalPoint =
                                                                          jumlahCriticalPoint + 1;
                                                                      print(
                                                                          jumlahCriticalPoint);
                                                                    } else if (scoreFoodCooked[index] ==
                                                                        0 ||
                                                                        scoreFoodCooked[index] ==
                                                                            1) {
                                                                      jumlahCriticalPoint =
                                                                          jumlahCriticalPoint + 0;
                                                                      print(
                                                                          jumlahCriticalPoint);
                                                                    }
                                                                  }
                                                                }

                                                                if (problemFS.length == 0) {
                                                                  problemFS.add(jmlFoodCooked[index]);
                                                                  areaFS.add('Food Completely Cooked');
                                                                  auditorFS.add(auditorName[9]);
                                                                  auditorIDFS.add(int.tryParse(widget.auditor[9].toString()));
                                                                  subBabFS.add(systemFoodCooked[index]);
                                                                  rekomendasiFS.add(null);
                                                                      carNoFS.add(null);
                                                                  criticalFS.add(criticalFoodCooked[index] == 'false' ? 'no' : 'yes');
                                                                } else {
                                                                  if (problemFS.contains(jmlFoodCooked[index])) {
                                                                    
                                                                  } else {
                                                                    rekomendasiFS.add(null);
                                                                      carNoFS.add(null);
                                                                    problemFS.add(jmlFoodCooked[index]);
                                                                    areaFS.add('Food Completely Cooked');
                                                                    auditorFS.add(auditorName[9]);
                                                                    auditorIDFS.add(int.tryParse(widget.auditor[9].toString()));
                                                                    subBabFS.add(systemFoodCooked[index]);
                                                                    criticalFS.add(criticalFoodCooked[index] == 'false' ? 'no' : 'yes');
                                                                  }
                                                                }
                                                                
                                                                scoreFoodCooked
                                                                    .removeAt(
                                                                    index);
                                                                scoreFoodCooked
                                                                    .insert(
                                                                    index,
                                                                    0);
                                                                warnaFoodCooked
                                                                    .removeAt(
                                                                    index);
                                                                warnaFoodCooked
                                                                    .insert(
                                                                    index,
                                                                    'merah');

                                                                    print(problemFS);
                                                              print(areaFS);
                                                              print(criticalFS);
                                                              print(auditorFS);
                                                              print(subBabFS);
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        alignment:
                                                        Alignment(
                                                            0.0, 0.0),
                                                      ),
                                                    ),
                                                    jawabanSplitFoodCooked[1] ==
                                                        'null'
                                                        ? Container()
                                                        : Tooltip(
                                                      message:
                                                      jawabanSplitFoodCooked ==
                                                          null
                                                          ? ''
                                                          : jawabanSplitFoodCooked[
                                                      1],
                                                      preferBelow: false,
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                            horizontal:
                                                            5.0),
                                                        child: ButtonTheme(
                                                          minWidth: 50.0,
                                                          height: 50.0,
                                                          child:
                                                          RaisedButton(
                                                            shape:
                                                            new RoundedRectangleBorder(
                                                              borderRadius:
                                                              new BorderRadius
                                                                  .circular(
                                                                  5.0),
                                                              side:
                                                              BorderSide(
                                                                width: 1.5,
                                                                color: warnaFoodCooked.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    192,
                                                                    192,
                                                                    192)
                                                                    : warnaFoodCooked[index] ==
                                                                    'kuning'
                                                                    ? Colors
                                                                    .white
                                                                    : Color.fromARGB(
                                                                    170,
                                                                    192,
                                                                    192,
                                                                    192),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              '1',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  18.0,
                                                                  color: warnaFoodCooked.length ==
                                                                      0
                                                                      ? Color.fromARGB(
                                                                      170,
                                                                      247,
                                                                      202,
                                                                      24)
                                                                      : warnaFoodCooked[index] == 'kuning'
                                                                      ? Colors.white
                                                                      : Color.fromARGB(170, 247, 202, 24)),
                                                              textAlign:
                                                              TextAlign
                                                                  .center,
                                                            ),
                                                            color: warnaFoodCooked
                                                                .length ==
                                                                0
                                                                ? Colors
                                                                .white
                                                                : warnaFoodCooked[index] ==
                                                                'kuning'
                                                                ? Color.fromARGB(
                                                                170,
                                                                247,
                                                                202,
                                                                24)
                                                                : Colors
                                                                .white,
                                                            onPressed: () {
                                                              setState(() {
                                                                if (criticalFoodCooked[
                                                                index] ==
                                                                    'false') {
                                                                  print(
                                                                      'false');
                                                                } else if (criticalFoodCooked[
                                                                index] ==
                                                                    'true') {
                                                                  if (scoreFoodCooked[
                                                                  index] ==
                                                                      null) {
                                                                    jumlahCriticalPoint =
                                                                        jumlahCriticalPoint +
                                                                            1;
                                                                    print(
                                                                        jumlahCriticalPoint);
                                                                  } else {
                                                                    if (scoreFoodCooked[index] ==
                                                                        2) {
                                                                      jumlahCriticalPoint =
                                                                          jumlahCriticalPoint + 1;
                                                                      print(
                                                                          jumlahCriticalPoint);
                                                                    } else if (scoreFoodCooked[index] ==
                                                                        0 ||
                                                                        scoreFoodCooked[index] ==
                                                                            1) {
                                                                      jumlahCriticalPoint =
                                                                          jumlahCriticalPoint + 0;
                                                                      print(
                                                                          jumlahCriticalPoint);
                                                                    }
                                                                  }
                                                                }

                                                                if (problemFS.length == 0) {
                                                                  
                                                                } else {
                                                                  if (problemFS.contains(jmlFoodCooked[index])) {
                                                                    areaFS.removeAt(problemFS.indexWhere((test) => test == jmlFoodCooked[index]));
                                                                    auditorFS.removeAt(problemFS.indexWhere((test) => test == jmlFoodCooked[index]));
                                                                    rekomendasiFS.removeAt(problemFS.indexWhere((test) => test == jmlFoodCooked[index]));
                                                                    carNoFS.removeAt(problemFS.indexWhere((test) => test == jmlFoodCooked[index]));
                                                                    auditorIDFS.removeAt(problemFS.indexWhere((test) => test == jmlFoodCooked[index]));
                                                                    criticalFS.removeAt(problemFS.indexWhere((test) => test == jmlFoodCooked[index]));
                                                                    subBabFS.removeAt(problemFS.indexWhere((test) => test == jmlFoodCooked[index]));
                                                                    problemFS.removeAt(problemFS.indexWhere((test) => test == jmlFoodCooked[index]));
                                                                  } else {
                                                                    
                                                                  }
                                                                }

                                                                scoreFoodCooked
                                                                    .removeAt(
                                                                    index);
                                                                scoreFoodCooked
                                                                    .insert(
                                                                    index,
                                                                    1);
                                                                warnaFoodCooked
                                                                    .removeAt(
                                                                    index);
                                                                warnaFoodCooked
                                                                    .insert(
                                                                    index,
                                                                    'kuning');

                                                                    print(problemFS);
                                                              print(areaFS);
                                                              print(criticalFS);
                                                              print(auditorFS);
                                                              print(subBabFS);
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        alignment:
                                                        Alignment(
                                                            0.0, 0.0),
                                                      ),
                                                    ),
                                                    jawabanSplitFoodCooked[2] ==
                                                        'null'
                                                        ? Container()
                                                        : Tooltip(
                                                      message:
                                                      jawabanSplitFoodCooked ==
                                                          null
                                                          ? ''
                                                          : jawabanSplitFoodCooked[
                                                      2],
                                                      preferBelow: false,
                                                      child: Container(
                                                        child: ButtonTheme(
                                                          minWidth: 50.0,
                                                          height: 50.0,
                                                          child:
                                                          RaisedButton(
                                                            shape:
                                                            new RoundedRectangleBorder(
                                                              borderRadius:
                                                              new BorderRadius
                                                                  .circular(
                                                                  5.0),
                                                              side:
                                                              BorderSide(
                                                                width: 1.5,
                                                                color: warnaFoodCooked.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    192,
                                                                    192,
                                                                    192)
                                                                    : warnaFoodCooked[index] ==
                                                                    'hijau'
                                                                    ? Colors
                                                                    .white
                                                                    : Color.fromARGB(
                                                                    170,
                                                                    192,
                                                                    192,
                                                                    192),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              '2',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  18.0,
                                                                  color: warnaFoodCooked.length ==
                                                                      0
                                                                      ? Color.fromARGB(
                                                                      170,
                                                                      50,
                                                                      205,
                                                                      50)
                                                                      : warnaFoodCooked[index] == 'hijau'
                                                                      ? Colors.white
                                                                      : Color.fromARGB(170, 50, 205, 50)),
                                                              textAlign:
                                                              TextAlign
                                                                  .center,
                                                            ),
                                                            color: warnaFoodCooked
                                                                .length ==
                                                                0
                                                                ? Colors
                                                                .white
                                                                : warnaFoodCooked[index] ==
                                                                'hijau'
                                                                ? Color.fromARGB(
                                                                170,
                                                                50,
                                                                205,
                                                                50)
                                                                : Colors
                                                                .white,
                                                            onPressed: () {
                                                              setState(() {
                                                                if (criticalFoodCooked[
                                                                index] ==
                                                                    'false') {
                                                                  print(
                                                                      'false');
                                                                } else if (criticalFoodCooked[
                                                                index] ==
                                                                    'true') {
                                                                  if (scoreFoodCooked[
                                                                  index] ==
                                                                      2) {
                                                                    jumlahCriticalPoint =
                                                                        jumlahCriticalPoint +
                                                                            0;
                                                                    print(
                                                                        jumlahCriticalPoint);
                                                                  } else {
                                                                    if (scoreFoodCooked[index] ==
                                                                        2) {
                                                                      jumlahCriticalPoint =
                                                                          jumlahCriticalPoint + 0;
                                                                      print(
                                                                          jumlahCriticalPoint);
                                                                    } else if (scoreFoodCooked[index] ==
                                                                        0 ||
                                                                        scoreFoodCooked[index] ==
                                                                            1) {
                                                                      jumlahCriticalPoint =
                                                                          jumlahCriticalPoint - 1;
                                                                      print(
                                                                          jumlahCriticalPoint);
                                                                    }
                                                                  }
                                                                }

                                                                if (problemFS.length == 0) {
                                                                  
                                                                } else {
                                                                  if (problemFS.contains(jmlFoodCooked[index])) {
                                                                    rekomendasiFS.removeAt(problemFS.indexWhere((test) => test == jmlFoodCooked[index]));
                                                                    carNoFS.removeAt(problemFS.indexWhere((test) => test == jmlFoodCooked[index]));
                                                                    areaFS.removeAt(problemFS.indexWhere((test) => test == jmlFoodCooked[index]));
                                                                    auditorFS.removeAt(problemFS.indexWhere((test) => test == jmlFoodCooked[index]));
                                                                    auditorIDFS.removeAt(problemFS.indexWhere((test) => test == jmlFoodCooked[index]));
                                                                    criticalFS.removeAt(problemFS.indexWhere((test) => test == jmlFoodCooked[index]));
                                                                    subBabFS.removeAt(problemFS.indexWhere((test) => test == jmlFoodCooked[index]));
                                                                    problemFS.removeAt(problemFS.indexWhere((test) => test == jmlFoodCooked[index]));
                                                                  } else {
                                                                    
                                                                  }
                                                                }

                                                                scoreFoodCooked
                                                                    .removeAt(
                                                                    index);
                                                                scoreFoodCooked
                                                                    .insert(
                                                                    index,
                                                                    2);
                                                                warnaFoodCooked
                                                                    .removeAt(
                                                                    index);
                                                                warnaFoodCooked
                                                                    .insert(
                                                                    index,
                                                                    'hijau');

                                                                    print(problemFS);
                                                              print(areaFS);
                                                              print(criticalFS);
                                                              print(auditorFS);
                                                              print(subBabFS);
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        alignment:
                                                        Alignment(
                                                            0.0, 0.0),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                          widget.subArea.contains('Food Completely Cooked')
                                            ? Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    imageFoodCooked[index] == null
                                                      ? IconButton(
                                                          icon: Icon(Icons.camera_alt, color: AbubaPallate.greenabuba),
                                                          onPressed: () async {
                                                            var selectedImage =
                                                            await ImagePicker.pickImage(source: ImageSource.camera, maxHeight: 400.0, maxWidth: 400.0);
                                                            
                                                            imageFoodCooked1 = selectedImage;
                                                            filenameFoodCooked1 = basename(imageFoodCooked1.path);

                                                            StorageReference strRef = FirebaseStorage.instance.ref().child(filenameFoodCooked1);
                                                            StorageUploadTask uploadTask = strRef.putFile(imageFoodCooked1);

                                                            var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
                                                            var url = downUrl.toString();

                                                            setState(() {
                                                              if (imageFoodCooked[index] != null) {
                                                                List<String> bantuImageFoodCooked = [];
                                                                List<String> bantuImageFoodCookedSave = [];
                                                                bantuImageFoodCooked = imageFoodCooked[index].split('###');
                                                                bantuImageFoodCooked.add(filenameFoodCooked1);
                                                                imageFoodCooked[index] = bantuImageFoodCooked.join('###');

                                                                bantuImageFoodCookedSave = imageFoodCookedSave[index].split('###');
                                                                bantuImageFoodCookedSave.add(url);
                                                                imageFoodCookedSave[index] = bantuImageFoodCookedSave.join('###');
                                                              } else {
                                                                imageFoodCooked[index] = filenameFoodCooked1;
                                                                imageFoodCookedSave[index] = url;
                                                              }
                                                              // imageFoodCookedBantu[index] = imageFoodCooked1;
                                                              print(imageFoodCooked);
                                                              print(imageFoodCookedSave);
                                                              print(imageFoodCooked[index].split('###').length);
                                                              print(imageFoodCookedSave[index].split('###').length);
                                                            });
                                                          },
                                                        )
                                                      : imageFoodCooked[index].split('###').length >= 5
                                                          ? IconButton(
                                                              icon: Icon(Icons.disc_full, color: Colors.grey),
                                                              onPressed: () {},
                                                              tooltip: 'Sudah mencapai batas maksimal 5 foto tiap pertanyaan',
                                                            )
                                                          : IconButton(
                                                              icon: Icon(Icons.camera_alt, color: AbubaPallate.greenabuba),
                                                              onPressed: () async {
                                                                var selectedImage =
                                                                await ImagePicker.pickImage(source: ImageSource.camera, maxHeight: 400.0, maxWidth: 400.0);
                                                                
                                                                imageFoodCooked1 = selectedImage;
                                                                filenameFoodCooked1 = basename(imageFoodCooked1.path);

                                                                StorageReference strRef = FirebaseStorage.instance.ref().child(filenameFoodCooked1);
                                                                StorageUploadTask uploadTask = strRef.putFile(imageFoodCooked1);

                                                                var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
                                                                var url = downUrl.toString();

                                                                setState(() {
                                                                  if (imageFoodCooked[index] != null) {
                                                                    List<String> bantuImageFoodCooked = [];
                                                                    List<String> bantuImageFoodCookedSave = [];
                                                                    bantuImageFoodCooked = imageFoodCooked[index].split('###');
                                                                    bantuImageFoodCooked.add(filenameFoodCooked1);
                                                                    imageFoodCooked[index] = bantuImageFoodCooked.join('###');

                                                                    bantuImageFoodCookedSave = imageFoodCookedSave[index].split('###');
                                                                    bantuImageFoodCookedSave.add(url);
                                                                    imageFoodCookedSave[index] = bantuImageFoodCookedSave.join('###');
                                                                  } else {
                                                                    imageFoodCooked[index] = filenameFoodCooked1;
                                                                    imageFoodCookedSave[index] = url;
                                                                  }
                                                                  // imageFoodCookedBantu[index] = imageFoodCooked1;
                                                                  print(imageFoodCooked);
                                                                  print(imageFoodCookedSave);
                                                                  print(imageFoodCooked[index].split('###').length);
                                                                  print(imageFoodCookedSave[index].split('###').length);
                                                                });
                                                              },
                                                            ),
                                                    IconButton(
                                                      icon: Icon(Icons.event_note,
                                                          color: AbubaPallate
                                                              .greenabuba),
                                                      onPressed: () {
                                                        if (noteFoodCooked[
                                                        index] ==
                                                            null) {
                                                          _controllerFoodCooked
                                                              .text = '';
                                                        } else {
                                                          _controllerFoodCooked
                                                              .text =
                                                          noteFoodCooked[
                                                          index];
                                                        }
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              title: Text('NOTE'),
                                                              content: Container(
                                                                width: 300.0,
                                                                child: TextField(
                                                                  controller:
                                                                  _controllerFoodCooked,
                                                                  decoration:
                                                                  InputDecoration(
                                                                    border:
                                                                    OutlineInputBorder(),
                                                                    hintText:
                                                                    'Note',
                                                                    hintStyle: TextStyle(
                                                                        fontSize:
                                                                        12.0),
                                                                  ),
                                                                  maxLines: 3,
                                                                  style:
                                                                  TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                              ),
                                                              actions: <Widget>[
                                                                FlatButton(
                                                                  splashColor: Colors
                                                                      .greenAccent,
                                                                  child: Text(
                                                                    'OK',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .green),
                                                                  ),
                                                                  onPressed: () {
                                                                    noteFoodCooked
                                                                        .removeAt(
                                                                        index);
                                                                    noteFoodCooked.insert(
                                                                        index,
                                                                        _controllerFoodCooked
                                                                            .text);
                                                                    print(
                                                                        noteFoodCooked);
                                                                    Navigator.of(
                                                                        context)
                                                                        .pop();
                                                                  },
                                                                )
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                          Divider(
                                            height: 2.0,
                                          ),
                                        ],
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
                            );
                          },
                        ),
                        PreferredSize(
                          preferredSize: Size.fromHeight(
                              MediaQuery.of(context).size.height -
                                  55.0 -
                                  (MediaQuery.of(context).size.height * 0.7)),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 55.0,
                                child: Container(
                                    child: Padding(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: <Widget>[
                                              IconButton(
                                                icon: Icon(Icons.arrow_back_ios,
                                                    color: Colors.white),
                                                onPressed: () {
                                                  _cardController.animateTo(
                                                      _cardController.index - 1);
                                                },
                                                tooltip: 'Previous',
                                              ),
                                              GestureDetector(
                                                child: isProcess
                                                  ? SizedBox(
                                                      height: 20.0,
                                                      width: 20.0,
                                                      child: CircularProgressIndicator(
                                                        valueColor: AlwaysStoppedAnimation(Colors.white),
                                                        strokeWidth: 2.0
                                                      ),
                                                    )
                                                  : Icon(
                                                      Icons.save,
                                                      color: Colors.white
                                                    ),
                                                onTap: () async {
                                                  if (scoreFoodCooked[indexFoodCooked] == null) {
                                                    if (widget.subArea.contains('Food Completely Cooked')) {
                                                      showDialog(
                                                        barrierDismissible: false,
                                                        context: context,
                                                        builder: (context) => Dialog(
                                                          child: Container(
                                                            height: 180.0,
                                                            child: Column(
                                                              children: <Widget>[
                                                                Container(
                                                                  color: AbubaPallate.greenabuba,
                                                                  height: 50.0,
                                                                  child: Center(
                                                                    child: Text(
                                                                      'OOPS!',
                                                                      style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontSize:
                                                                        17.0,
                                                                        fontWeight:
                                                                        FontWeight.w700
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 20.0,
                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets.symmetric(horizontal:10.0,vertical:10.0),
                                                                  child: Text(
                                                                    'Please select the answer!',
                                                                    style:
                                                                    TextStyle(
                                                                      fontSize:16.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:MainAxisAlignment.end,
                                                                  children: <Widget>[
                                                                    FlatButton(
                                                                      child: Text('OK'),
                                                                      onPressed:() {
                                                                        Navigator.pop(context);
                                                                      },
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      setState(() {
                                                        isProcess = true; 
                                                      });
                                                      print(bobotPertanyaanFoodCooked);
                                                      print(scoreFoodCooked);
                                                      print(hasilFoodCooked);
                                                      print(finalFoodCooked);

                                                      DateTime done = DateTime.now();

                                                      int totalCPfirebase = 0;

                                                      Firestore.instance.collection('audit_internal').document(widget.index).snapshots().listen((cp) {
                                                        if (!cp.data.containsKey('total_cp')) {
                                                          setState(() {
                                                            totalCPfirebase = jumlahCriticalPoint;
                                                          });
                                                        } else {
                                                          setState(() {
                                                            totalCPfirebase = cp.data['total_cp'] + jumlahCriticalPoint;
                                                          });
                                                        }
                                                        if (widget.subArea.contains('Area Luar')) {
                                                          if (cp.data.containsKey('hasilAreaLuar')) {
                                                            finalAreaLuar = (cp.data['hasilAreaLuar'] * parameterAreaLuar) / 100;
                                                          } else {
                                                            finalAreaLuar = 0;
                                                          }
                                                        } else if (widget.subArea.contains('Dinning Area')) {
                                                          if (cp.data.containsKey('hasilDinningArea')) {
                                                            finalDinningArea = (cp.data['hasilDinningArea'] * parameterDinningArea) / 100;
                                                          } else {
                                                            finalDinningArea = 0;
                                                          }
                                                        } else if (widget.subArea.contains('Service')) {
                                                          if (cp.data.containsKey('hasilService')) {
                                                            finalService = (cp.data['hasilService'] * parameterService) / 100;
                                                          } else {
                                                            finalService = 0;
                                                          }
                                                        } else if (widget.subArea.contains('Cashier')) {
                                                          if (cp.data.containsKey('hasilCashier')) {
                                                            finalCashier = (cp.data['hasilCashier'] * parameterCashier) / 100;
                                                          } else {
                                                            finalCashier = 0;
                                                          }
                                                        } else if (widget.subArea.contains('Administrasi Keuangan')) {
                                                          if (cp.data.containsKey('hasilCashierAccuracy')) {
                                                            finalCashierAccuracy = (cp.data['hasilCashierAccuracy'] * parameterCashierAccuracy) / 100;
                                                          } else {
                                                            finalCashierAccuracy = 0;
                                                          }
                                                        } else if (widget.subArea.contains('Back of The House (BOH)')) {
                                                          if (cp.data.containsKey('hasilBoh')) {
                                                            finalBoh = (cp.data['hasilBoh'] * parameterBoh) / 100;
                                                          } else {
                                                            finalBoh = 0;
                                                          }
                                                        } else if (widget.subArea.contains('Warehouse')) {
                                                          if (cp.data.containsKey('hasilWarehouse')) {
                                                            finalWarehouse = (cp.data['hasilWarehouse'] * parameterWarehouse) / 100;
                                                          } else {
                                                            finalWarehouse = 0;
                                                          }
                                                        } else if (widget.subArea.contains('Social Block')) {
                                                          if (cp.data.containsKey('hasilSocialBlock')) {
                                                            finalSocialBlock = (cp.data['hasilSocialBlock'] * parameterSocialBlock) / 100;
                                                          } else {
                                                            finalSocialBlock = 0;
                                                          }
                                                        } else if (widget.subArea.contains('Personal Hygiene')) {
                                                          if (cp.data.containsKey('hasilPersonal')) {
                                                            finalPersonal = (cp.data['hasilPersonal'] * parameterPersonal) / 100;
                                                          } else {
                                                            finalPersonal = 0;
                                                          }
                                                        } else if (widget.subArea.contains('Food Completely Cooked')) {
                                                          if (cp.data.containsKey('hasilFoodCooked')) {
                                                            finalFoodCooked = (cp.data['hasilFoodCooked'] * parameterFoodCooked) / 100;
                                                          } else {
                                                            finalFoodCooked = 0;
                                                          }
                                                        } else {
                                                          finalAreaLuar = 0;
                                                          finalDinningArea = 0;
                                                          finalService = 0;
                                                          finalCashier = 0;
                                                          finalCashierAccuracy = 0;
                                                          finalBoh = 0;
                                                          finalWarehouse = 0;
                                                          finalSocialBlock = 0;
                                                          finalPersonal = 0;
                                                          finalFoodCooked = 0;
                                                        }
                                                      });

                                                      if (totalCPfirebase >= 1 && totalCPfirebase <= 5) {
                                                        nilai_cp = 2;
                                                      } else if (totalCPfirebase >= 6 && totalCPfirebase <= 11) {
                                                        nilai_cp = 4;
                                                      } else if (totalCPfirebase >= 12 && totalCPfirebase <= 20) {
                                                        nilai_cp = 8;
                                                      }

                                                      finalBantu = finalAreaLuar + finalDinningArea + finalService + finalCashier + finalCashierAccuracy + finalBoh + finalWarehouse + finalSocialBlock + finalPersonal + finalFoodCooked;
                                                      hasilGrafik = finalBantu - (finalBantu * nilai_cp / 100);

                                                      print(finalBantu);
                                                      print('hasilGrafik 1 : ${hasilGrafik.toString()}');
                                                      print(nilai_cp);
                                                      print(totalCPfirebase);

                                                      await new Future.delayed(Duration(
                                                        seconds: 3
                                                      ));

                                                      print(totalCPfirebase);

                                                      DocumentReference docReference = Firestore.instance.collection('audit_internal').document(widget.index);
                                                      
                                                      if (widget.subArea.contains('Area Luar')) {
                                                        docReference.updateData({
                                                          'AreaLuar_score': scoreAreaLuar,
                                                          'AreaLuar_note': noteAreaLuar,
                                                          'hasilAreaLuar': hasilAreaLuar,
                                                          'timeDone': done,
                                                          'total_cp': totalCPfirebase,
                                                          'pertanyaanAreaLuar': pertanyaanAreaLuar,
                                                          'criticalAreaLuar': criticalAreaLuar,
                                                          'sistemAreaLuar': systemAreaLuar,
                                                          'imageAreaLuar': imageAreaLuarSave,
                                                        }).then((doc) {
                                                          print('sucess');
                                                        }).catchError((error) {
                                                          print(error);
                                                        });
                                                      }

                                                      if (widget.subArea.contains('Dinning Area')) {
                                                        docReference.updateData({
                                                          'DinningArea_score': scoreDinningArea,
                                                          'DinningArea_note': noteDinningArea,
                                                          'hasilDinningArea': hasilDinningArea,
                                                          'timeDone': done,
                                                          'total_cp': totalCPfirebase,
                                                          'pertanyaanDinningArea': pertanyaanDinningArea,
                                                          'criticalDinningArea': criticalDinningArea,
                                                          'sistemDinningArea': systemDinningArea,
                                                          'imageDinningArea': imageDinningAreaSave,
                                                        }).then((doc) {
                                                          print('sucess');
                                                        }).catchError((error) {
                                                          print(error);
                                                        });
                                                      }

                                                      if (widget.subArea.contains('Service')) {
                                                        docReference.updateData({
                                                          'Service_score': scoreService,
                                                          'Service_note': noteService,
                                                          'hasilService': hasilService,
                                                          'timeDone': done,
                                                          'total_cp': totalCPfirebase,
                                                          'pertanyaanService': pertanyaanService,
                                                          'criticalService': criticalService,
                                                          'sistemService': systemService,
                                                          'imageService': imageServiceSave,
                                                        }).then((doc) {
                                                          print('sucess');
                                                        }).catchError((error) {
                                                          print(error);
                                                        });
                                                      }

                                                      if (widget.subArea.contains('Cashier')) {
                                                        docReference.updateData({
                                                          'Cashier_score': scoreCashier,
                                                          'Cashier_note': noteCashier,
                                                          'hasilCashier': hasilCashier,
                                                          'timeDone': done,
                                                          'total_cp': totalCPfirebase,
                                                          'pertanyaanCashier': pertanyaanCashier,
                                                          'criticalCashier': criticalCashier,
                                                          'sistemCashier': systemCashier,
                                                          'imageCashier': imageCashierSave,
                                                        }).then((doc) {
                                                          print('sucess');
                                                        }).catchError((error) {
                                                          print(error);
                                                        });
                                                      }

                                                      if (widget.subArea.contains('Administrasi Keuangan')) {
                                                        docReference.updateData({
                                                          'CashierAccuracy_score': scoreCashierAccuracy,
                                                          'CashierAccuracy_note': noteCashierAccuracy,
                                                          'hasilCashierAccuracy': hasilCashierAccuracy,
                                                          'timeDone': done,
                                                          'total_cp': totalCPfirebase,
                                                          'pertanyaanCashierAccuracy': pertanyaanCashierAccuracy,
                                                          'criticalCashierAccuracy': criticalCashierAccuracy,
                                                          'sistemCashierAccuracy': systemCashierAccuracy,
                                                          'imageCashierAccuracy': imageCashierAccuracySave,
                                                        }).then((doc) {
                                                          print('sucess');
                                                        }).catchError((error) {
                                                          print(error);
                                                        });
                                                      }

                                                      if (widget.subArea.contains('Back of The House (BOH)')) {
                                                        docReference.updateData({
                                                          'Boh_score': scoreBoh,
                                                          'Boh_note': noteBoh,
                                                          'hasilBoh': hasilBoh,
                                                          'timeDone': done,
                                                          'total_cp': totalCPfirebase,
                                                          'pertanyaanBoh': pertanyaanBoh,
                                                          'criticalBoh': criticalBoh,
                                                          'sistemBoh': systemBoh,
                                                          'imageBoh': imageBohSave,
                                                        }).then((doc) {
                                                          print('sucess');
                                                        }).catchError((error) {
                                                          print(error);
                                                        });
                                                      }

                                                      if (widget.subArea.contains('Warehouse')) {
                                                        docReference.updateData({
                                                          'Warehouse_score': scoreWarehouse,
                                                          'Warehouse_note': noteWarehouse,
                                                          'hasilWarehouse': hasilWarehouse,
                                                          'timeDone': done,
                                                          'total_cp': totalCPfirebase,
                                                          'pertanyaanWarehouse': pertanyaanWarehouse,
                                                          'criticalWarehouse': criticalWarehouse,
                                                          'sistemWarehouse': systemWarehouse,
                                                          'imageWarehouse': imageWarehouseSave,
                                                        }).then((doc) {
                                                          print('sucess');
                                                        }).catchError((error) {
                                                          print(error);
                                                        });
                                                      }

                                                      if (widget.subArea.contains('Social Block')) {
                                                        docReference.updateData({
                                                          'SocialBlock_score': scoreSocialBlock,
                                                          'SocialBlock_note': noteSocialBlock,
                                                          'hasilSocialBlock': hasilSocialBlock,
                                                          'timeDone': done,
                                                          'total_cp': totalCPfirebase,
                                                          'pertanyaanSocialBlock': pertanyaanSocialBlock,
                                                          'criticalSocialBlock': criticalSocialBlock,
                                                          'sistemSocialBlock': systemSocialBlock,
                                                          'imageSocialBlock': imageSocialBlockSave,
                                                        }).then((doc) {
                                                          print('sucess');
                                                        }).catchError((error) {
                                                          print(error);
                                                        });
                                                      }

                                                      if (widget.subArea.contains('Personal Hygiene')) {
                                                        docReference.updateData({
                                                          'Personal_score': scorePersonal,
                                                          'Personal_note': notePersonal,
                                                          'hasilPersonal': hasilPersonal,
                                                          'timeDone': done,
                                                          'total_cp': totalCPfirebase,
                                                          'pertanyaanPersonal': pertanyaanPersonal,
                                                          'criticalPersonal': criticalPersonal,
                                                          'sistemPersonal': systemPersonal,
                                                          'imagePersonal': imagePersonalSave,
                                                        }).then((doc) {
                                                          print('sucess');
                                                        }).catchError((error) {
                                                          print(error);
                                                        });
                                                      }

                                                      if (widget.subArea.contains('Food Completely Cooked')) {
                                                        docReference.updateData({
                                                          'FoodCooked_score': scoreFoodCooked,
                                                          'FoodCooked_note': noteFoodCooked,
                                                          'hasilFoodCooked': hasilFoodCooked,
                                                          'timeDone': done,
                                                          'total_cp': totalCPfirebase,
                                                          'pertanyaanFoodCooked': pertanyaanFoodCooked,
                                                          'criticalFoodCooked': criticalFoodCooked,
                                                          'sistemFoodCooked': systemFoodCooked,
                                                          'imageFoodCooked': imageFoodCookedSave,
                                                        }).then((doc) async {
                                                          print('success');
                                                        }).catchError((error) {
                                                          print(error);
                                                        });
                                                      }

                                                      var checkOutPesertaSave = [];
                                                      var pesertaStatus = [];
                                                      var pesertaHadir = [];

                                                      Firestore.instance.collection('audit_internal').document(widget.index).snapshots().listen((dataCheckout) {
                                                        if (mounted) {
                                                          setState(() {
                                                            pesertaStatus = List<dynamic>.from(dataCheckout.data['pesertaStatus']);
                                                            pesertaHadir = List<dynamic>.from(dataCheckout.data['pesertaHadir']);

                                                            for (int au = 0; au < dataCheckout.data['checkOutPeserta'].length; au++) {
                                                              if (int.tryParse(widget.auditor[au].toString()) == widget.idUser) {
                                                                print('out');
                                                                checkOutPesertaSave.add(DateTime.now());
                                                              } else {
                                                                print('non');
                                                                Timestamp bantu = dataCheckout.data['checkOutPeserta'][au];
                                                                if (bantu == null) {
                                                                  checkOutPesertaSave.add(null);
                                                                } else {
                                                                  checkOutPesertaSave.add(bantu.toDate());
                                                                }
                                                              }
                                                            }

                                                            pesertaStatus[pesertaHadir.indexWhere((dynamic test) => int.tryParse(test.toString()) == widget.idUser)] = 'DONE';
                                                          });
                                                        }
                                                      });

                                                      await new Future.delayed(Duration(
                                                        seconds: 3
                                                      ));

                                                      DocumentReference docReference44 = Firestore.instance.collection('audit_internal').document(widget.index);

                                                      List<dynamic> problemFSPertama = [];
                                                      List<dynamic> areaFSPertama = [];
                                                      List<dynamic> criticalFSPertama = [];
                                                      List<dynamic> auditorFSPertama = [];
                                                      List<dynamic> auditorIDFSPertama = [];
                                                      List<dynamic> subBabFSPertama = [];
                                                      List<dynamic> carNoFSPertama = [];
                                                      List<dynamic> rekomendasiFSPertama = [];

                                                      var problemFSSave;
                                                      var areaFSSave;
                                                      var criticalFSSave;
                                                      var auditorFSSave;
                                                      var auditorIDFSSave;
                                                      var subBabFSSave;
                                                      var carNoFSSave;
                                                      var rekomendasiFSSave;
                                                      
                                                      Firestore.instance.collection('audit_internal').document(widget.index).snapshots().listen((data) {
                                                        setState(() {
                                                          problemFSPertama = data.data['FSProblem'];
                                                          areaFSPertama = data.data['FSArea'];
                                                          criticalFSPertama = data.data['FSCritical'];
                                                          auditorFSPertama = data.data['FSAuditor'];
                                                          auditorIDFSPertama = data.data['FSAuditorID'];
                                                          subBabFSPertama = data.data['FSSubBab'];
                                                          carNoFSPertama = data.data['FSCarNo'];
                                                          rekomendasiFSPertama = data.data['FSRekomendasi'];
                                                        });
                                                      });
                                                      await new Future.delayed(Duration(
                                                        seconds: 3
                                                      ));

                                                      setState(() {
                                                        problemFSSave = List.from(problemFSPertama)..addAll(problemFS);
                                                        areaFSSave = List.from(areaFSPertama)..addAll(areaFS);
                                                        criticalFSSave = List.from(criticalFSPertama)..addAll(criticalFS);
                                                        auditorFSSave = List.from(auditorFSPertama)..addAll(auditorFS);
                                                        auditorIDFSSave = List.from(auditorIDFSPertama)..addAll(auditorIDFS);
                                                        subBabFSSave = List.from(subBabFSPertama)..addAll(subBabFS);
                                                        carNoFSSave = List.from(carNoFSPertama)..addAll(carNoFS);
                                                        rekomendasiFSSave = List.from(rekomendasiFSPertama)..addAll(rekomendasiFS);
                                                      });

                                                      docReference44.updateData({
                                                        'pesertaStatus': pesertaStatus,
                                                        'checkOutPeserta': checkOutPesertaSave,
                                                        'leadAuditorCheckOut': DateTime.now(),
                                                        'leadAuditorStatus': 'DONE',
                                                        'hasilGrafik': hasilGrafik,
                                                        // 'FSDivisi': divisiFS,
                                                        'FSDepartment': departmentNameFS,
                                                        'FSDepartmentID': departmentIDFS,
                                                        'FSCategory': categoryFS,
                                                        'FSSubBab': subBabFSSave,
                                                        'FSAuditor': auditorFSSave,
                                                        'FSAuditorID': auditorIDFSSave,
                                                        'FSCritical': criticalFSSave,
                                                        'FSArea': areaFSSave,
                                                        'FSProblem': problemFSSave,
                                                        'FSRekomendasi': rekomendasiFSSave,
                                                        'FSCarNo': carNoFSSave,
                                                      }).then((doc) {
                                                        print('success');
                                                        setState(() {
                                                          isProcess = false; 
                                                        });
                                                        showDialog(
                                                          barrierDismissible: false,
                                                          context: context,
                                                          builder: (context) => Dialog(
                                                            child: Container(
                                                              height: 180.0,
                                                              child: Column(
                                                                children: <Widget>[
                                                                  Container(
                                                                    color: AbubaPallate.greenabuba,
                                                                    height:50.0,
                                                                    child:
                                                                    Center(
                                                                      child: Text(
                                                                        'SUCCESSFUL!',
                                                                        style: TextStyle(
                                                                          color: Colors.white,
                                                                          fontSize: 17.0,
                                                                          fontWeight: FontWeight.w700
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 20.0,
                                                                  ),
                                                                  Container(
                                                                    padding: EdgeInsets.symmetric(horizontal:10.0,vertical:10.0),
                                                                    child: Text(
                                                                      'Internal Audit Success',
                                                                      style: TextStyle(
                                                                        fontSize: 16.0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:MainAxisAlignment.end,
                                                                    children: <Widget>[
                                                                      FlatButton(
                                                                        child: Text('OK'),
                                                                        onPressed:() {
                                                                          Navigator.pop(context);
                                                                        },
                                                                      )
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          )).whenComplete(() {
                                                            Navigator.pop(context);
                                                          }
                                                        );
                                                      }).catchError((error) {
                                                        print(error);
                                                      });
                                                      print(problemFSSave);
                                                      print(areaFSSave);
                                                      print(criticalFSSave);
                                                      print(auditorFSSave);
                                                      print(auditorIDFSSave);
                                                      print(subBabFSSave);
                                                      print(carNoFSSave);
                                                      print(rekomendasiFSSave);
                                                      print(jumlahCriticalPoint);
                                                    }

                                                    print('save 1');
                                                  } else {
                                                    setState(() {
                                                      isProcess = true; 
                                                    });
                                                    for (int i = 0; i < scoreFoodCooked.length; i++) {
                                                      hasilFoodCooked += double.tryParse(bobotPertanyaanFoodCooked[i].toString()) * double.tryParse(scoreFoodCooked[i].toString());
                                                    }
                                                    hasilFoodCooked = hasilFoodCooked / 2;
                                                    // if (hasilFoodCooked > 1.0) {
                                                    //   hasilFoodCooked = 1.0;
                                                    // } else {
                                                    //   hasilFoodCooked = hasilFoodCooked;
                                                    // }
                                                    // finalFoodCooked = (hasilFoodCooked * parameterFoodCooked) / 100;

                                                    print(bobotPertanyaanFoodCooked);
                                                    print(scoreFoodCooked);
                                                    print(hasilFoodCooked);
                                                    print(finalFoodCooked);

                                                    DateTime done = DateTime.now();

                                                    int totalCPfirebase = 0;

                                                    Firestore.instance.collection('audit_internal').document(widget.index).snapshots().listen((cp) {
                                                      if (!cp.data.containsKey('total_cp')) {
                                                        setState(() {
                                                          totalCPfirebase = jumlahCriticalPoint;
                                                        });
                                                      } else {
                                                        setState(() {
                                                          totalCPfirebase = cp.data['total_cp'] + jumlahCriticalPoint;
                                                        });
                                                      }
                                                      if (widget.subArea.contains('Area Luar')) {
                                                        if (cp.data.containsKey('hasilAreaLuar')) {
                                                          finalAreaLuar = (cp.data['hasilAreaLuar'] * parameterAreaLuar) / 100;
                                                        } else {
                                                          finalAreaLuar = 0;
                                                        }
                                                      } else if (widget.subArea.contains('Dinning Area')) {
                                                        if (cp.data.containsKey('hasilDinningArea')) {
                                                          finalDinningArea = (cp.data['hasilDinningArea'] * parameterDinningArea) / 100;
                                                        } else {
                                                          finalDinningArea = 0;
                                                        }
                                                      } else if (widget.subArea.contains('Service')) {
                                                        if (cp.data.containsKey('hasilService')) {
                                                          finalService = (cp.data['hasilService'] * parameterService) / 100;
                                                        } else {
                                                          finalService = 0;
                                                        }
                                                      } else if (widget.subArea.contains('Cashier')) {
                                                        if (cp.data.containsKey('hasilCashier')) {
                                                          finalCashier = (cp.data['hasilCashier'] * parameterCashier) / 100;
                                                        } else {
                                                          finalCashier = 0;
                                                        }
                                                      } else if (widget.subArea.contains('Administrasi Keuangan')) {
                                                        if (cp.data.containsKey('hasilCashierAccuracy')) {
                                                          finalCashierAccuracy = (cp.data['hasilCashierAccuracy'] * parameterCashierAccuracy) / 100;
                                                        } else {
                                                          finalCashierAccuracy = 0;
                                                        }
                                                      } else if (widget.subArea.contains('Back of The House (BOH)')) {
                                                        if (cp.data.containsKey('hasilBoh')) {
                                                          finalBoh = (cp.data['hasilBoh'] * parameterBoh) / 100;
                                                        } else {
                                                          finalBoh = 0;
                                                        }
                                                      } else if (widget.subArea.contains('Warehouse')) {
                                                        if (cp.data.containsKey('hasilWarehouse')) {
                                                          finalWarehouse = (cp.data['hasilWarehouse'] * parameterWarehouse) / 100;
                                                        } else {
                                                          finalWarehouse = 0;
                                                        }
                                                      } else if (widget.subArea.contains('Social Block')) {
                                                        if (cp.data.containsKey('hasilSocialBlock')) {
                                                          finalSocialBlock = (cp.data['hasilSocialBlock'] * parameterSocialBlock) / 100;
                                                        } else {
                                                          finalSocialBlock = 0;
                                                        }
                                                      } else if (widget.subArea.contains('Personal Hygiene')) {
                                                        if (cp.data.containsKey('hasilPersonal')) {
                                                          finalPersonal = (cp.data['hasilPersonal'] * parameterPersonal) / 100;
                                                        } else {
                                                          finalPersonal = 0;
                                                        }
                                                      } else if (widget.subArea.contains('Food Completely Cooked')) {
                                                        if (cp.data.containsKey('hasilFoodCooked')) {
                                                          finalFoodCooked = (cp.data['hasilFoodCooked'] * parameterFoodCooked) / 100;
                                                        } else {
                                                          finalFoodCooked = 0;
                                                        }
                                                      } else {
                                                        finalAreaLuar = 0;
                                                        finalDinningArea = 0;
                                                        finalService = 0;
                                                        finalCashier = 0;
                                                        finalCashierAccuracy = 0;
                                                        finalBoh = 0;
                                                        finalWarehouse = 0;
                                                        finalSocialBlock = 0;
                                                        finalPersonal = 0;
                                                        finalFoodCooked = 0;
                                                      }
                                                    });

                                                    await new Future.delayed(Duration(
                                                      seconds: 3
                                                    ));

                                                    if (totalCPfirebase >= 1 && totalCPfirebase <= 5) {
                                                      nilai_cp = 2;
                                                    } else if (totalCPfirebase >= 6 && totalCPfirebase <= 11) {
                                                      nilai_cp = 4;
                                                    } else if (totalCPfirebase >= 12 && totalCPfirebase <= 20) {
                                                      nilai_cp = 8;
                                                    }

                                                    finalBantu = finalAreaLuar + finalDinningArea + finalService + finalCashier + finalCashierAccuracy + finalBoh + finalWarehouse + finalSocialBlock + finalPersonal + finalFoodCooked;
                                                    hasilGrafik = finalBantu - (finalBantu * nilai_cp / 100);

                                                    print(finalBantu);
                                                    print('hasil Grafik : ${hasilGrafik.toString()}');
                                                    print(nilai_cp);

                                                    DocumentReference docReference = Firestore.instance.collection('audit_internal').document(widget.index);
                                                    
                                                    if (widget.subArea.contains('Area Luar')) {
                                                      docReference.updateData({
                                                        'AreaLuar_score': scoreAreaLuar,
                                                        'AreaLuar_note': noteAreaLuar,
                                                        'hasilAreaLuar': hasilAreaLuar,
                                                        'timeDone': done,
                                                        'total_cp': totalCPfirebase,
                                                        'pertanyaanAreaLuar': pertanyaanAreaLuar,
                                                        'criticalAreaLuar': criticalAreaLuar,
                                                        'sistemAreaLuar': systemAreaLuar,
                                                        'imageAreaLuar': imageAreaLuarSave,
                                                      }).then((doc) {
                                                        print('sucess');
                                                      }).catchError((error) {
                                                        print(error);
                                                      });
                                                    }

                                                    if (widget.subArea.contains('Dinning Area')) {
                                                      docReference.updateData({
                                                        'DinningArea_score': scoreDinningArea,
                                                        'DinningArea_note': noteDinningArea,
                                                        'hasilDinningArea': hasilDinningArea,
                                                        'timeDone': done,
                                                        'total_cp': totalCPfirebase,
                                                        'pertanyaanDinningArea': pertanyaanDinningArea,
                                                        'criticalDinningArea': criticalDinningArea,
                                                        'sistemDinningArea': systemDinningArea,
                                                        'imageDinningArea': imageDinningAreaSave,
                                                      }).then((doc) {
                                                        print('sucess');
                                                      }).catchError((error) {
                                                        print(error);
                                                      });
                                                    }

                                                    if (widget.subArea.contains('Service')) {
                                                      docReference.updateData({
                                                        'Service_score': scoreService,
                                                        'Service_note': noteService,
                                                        'hasilService': hasilService,
                                                        'timeDone': done,
                                                        'total_cp': totalCPfirebase,
                                                        'pertanyaanService': pertanyaanService,
                                                        'criticalService': criticalService,
                                                        'sistemService': systemService,
                                                        'imageService': imageServiceSave,
                                                      }).then((doc) {
                                                        print('sucess');
                                                      }).catchError((error) {
                                                        print(error);
                                                      });
                                                    }

                                                    if (widget.subArea.contains('Cashier')) {
                                                      docReference.updateData({
                                                        'Cashier_score': scoreCashier,
                                                        'Cashier_note': noteCashier,
                                                        'hasilCashier': hasilCashier,
                                                        'timeDone': done,
                                                        'total_cp': totalCPfirebase,
                                                        'pertanyaanCashier': pertanyaanCashier,
                                                        'criticalCashier': criticalCashier,
                                                        'sistemCashier': systemCashier,
                                                        'imageCashier': imageCashierSave,
                                                      }).then((doc) {
                                                        print('sucess');
                                                      }).catchError((error) {
                                                        print(error);
                                                      });
                                                    }

                                                    if (widget.subArea.contains('Administrasi Keuangan')) {
                                                      docReference.updateData({
                                                        'CashierAccuracy_score': scoreCashierAccuracy,
                                                        'CashierAccuracy_note': noteCashierAccuracy,
                                                        'hasilCashierAccuracy': hasilCashierAccuracy,
                                                        'timeDone': done,
                                                        'total_cp': totalCPfirebase,
                                                        'pertanyaanCashierAccuracy': pertanyaanCashierAccuracy,
                                                        'criticalCashierAccuracy': criticalCashierAccuracy,
                                                        'sistemCashierAccuracy': systemCashierAccuracy,
                                                        'imageCashierAccuracy': imageCashierAccuracySave,
                                                      }).then((doc) {
                                                        print('sucess');
                                                      }).catchError((error) {
                                                        print(error);
                                                      });
                                                    }

                                                    if (widget.subArea.contains('Back of The House (BOH)')) {
                                                      docReference.updateData({
                                                        'Boh_score': scoreBoh,
                                                        'Boh_note': noteBoh,
                                                        'hasilBoh': hasilBoh,
                                                        'timeDone': done,
                                                        'total_cp': totalCPfirebase,
                                                        'pertanyaanBoh': pertanyaanBoh,
                                                        'criticalBoh': criticalBoh,
                                                        'sistemBoh': systemBoh,
                                                        'imageBoh': imageBohSave,
                                                      }).then((doc) {
                                                        print('sucess');
                                                      }).catchError((error) {
                                                        print(error);
                                                      });
                                                    }

                                                    if (widget.subArea.contains('Warehouse')) {
                                                      docReference.updateData({
                                                        'Warehouse_score': scoreWarehouse,
                                                        'Warehouse_note': noteWarehouse,
                                                        'hasilWarehouse': hasilWarehouse,
                                                        'timeDone': done,
                                                        'total_cp': totalCPfirebase,
                                                        'pertanyaanWarehouse': pertanyaanWarehouse,
                                                        'criticalWarehouse': criticalWarehouse,
                                                        'sistemWarehouse': systemWarehouse,
                                                        'imageWarehouse': imageWarehouseSave,
                                                      }).then((doc) {
                                                        print('sucess');
                                                      }).catchError((error) {
                                                        print(error);
                                                      });
                                                    }

                                                    if (widget.subArea.contains('Social Block')) {
                                                      docReference.updateData({
                                                        'SocialBlock_score': scoreSocialBlock,
                                                        'SocialBlock_note': noteSocialBlock,
                                                        'hasilSocialBlock': hasilSocialBlock,
                                                        'timeDone': done,
                                                        'total_cp': totalCPfirebase,
                                                        'pertanyaanSocialBlock': pertanyaanSocialBlock,
                                                        'criticalSocialBlock': criticalSocialBlock,
                                                        'sistemSocialBlock': systemSocialBlock,
                                                        'imageSocialBlock': imageSocialBlockSave,
                                                      }).then((doc) {
                                                        print('sucess');
                                                      }).catchError((error) {
                                                        print(error);
                                                      });
                                                    }

                                                    if (widget.subArea.contains('Personal Hygiene')) {
                                                      docReference.updateData({
                                                        'Personal_score': scorePersonal,
                                                        'Personal_note': notePersonal,
                                                        'hasilPersonal': hasilPersonal,
                                                        'timeDone': done,
                                                        'total_cp': totalCPfirebase,
                                                        'pertanyaanPersonal': pertanyaanPersonal,
                                                        'criticalPersonal': criticalPersonal,
                                                        'sistemPersonal': systemPersonal,
                                                        'imagePersonal': imagePersonalSave,
                                                      }).then((doc) {
                                                        print('sucess');
                                                      }).catchError((error) {
                                                        print(error);
                                                      });
                                                    }

                                                    if (widget.subArea.contains('Food Completely Cooked')) {
                                                      docReference.updateData({
                                                        'FoodCooked_score': scoreFoodCooked,
                                                        'FoodCooked_note': noteFoodCooked,
                                                        'hasilFoodCooked': hasilFoodCooked,
                                                        'timeDone': done,
                                                        'total_cp': totalCPfirebase,
                                                        'pertanyaanFoodCooked': pertanyaanFoodCooked,
                                                        'criticalFoodCooked': criticalFoodCooked,
                                                        'sistemFoodCooked': systemFoodCooked,
                                                        'imageFoodCooked': imageFoodCookedSave,
                                                      }).then((doc) async {
                                                        var checkOutPesertaSave = [];
                                                        var pesertaStatus = [];
                                                        var pesertaHadir = [];

                                                        Firestore.instance.collection('audit_internal').document(widget.index).snapshots().listen((dataCheckout) {
                                                          if (mounted) {
                                                            setState(() {
                                                              pesertaStatus = List<dynamic>.from(dataCheckout.data['pesertaStatus']);
                                                              pesertaHadir = List<dynamic>.from(dataCheckout.data['pesertaHadir']);

                                                              for (int au = 0; au < dataCheckout.data['checkOutPeserta'].length; au++) {
                                                                if (int.tryParse(widget.auditor[au].toString()) == widget.idUser) {
                                                                  checkOutPesertaSave.add(DateTime.now());
                                                                } else {
                                                                  Timestamp bantu = dataCheckout.data['checkOutPeserta'][au];
                                                                  if (bantu == null) {
                                                                    checkOutPesertaSave.add(null);
                                                                  } else {
                                                                    checkOutPesertaSave.add(bantu.toDate());
                                                                  }
                                                                }
                                                              }

                                                              pesertaStatus[pesertaHadir.indexWhere((dynamic test) => int.tryParse(test.toString()) == widget.idUser)] = 'DONE';
                                                            });
                                                          }
                                                        });

                                                        await new Future.delayed(Duration(
                                                          seconds: 3
                                                        ));

                                                        DocumentReference docReference44 = Firestore.instance.collection('audit_internal').document(widget.index);

                                                        List<dynamic> problemFSPertama = [];
                                                      List<dynamic> areaFSPertama = [];
                                                      List<dynamic> criticalFSPertama = [];
                                                      List<dynamic> auditorFSPertama = [];
                                                      List<dynamic> auditorIDFSPertama = [];
                                                      List<dynamic> subBabFSPertama = [];
                                                      List<dynamic> carNoFSPertama = [];
                                                      List<dynamic> rekomendasiFSPertama = [];

                                                      var problemFSSave;
                                                      var areaFSSave;
                                                      var criticalFSSave;
                                                      var auditorFSSave;
                                                      var auditorIDFSSave;
                                                      var subBabFSSave;
                                                      var carNoFSSave;
                                                      var rekomendasiFSSave;
                                                      
                                                      Firestore.instance.collection('audit_internal').document(widget.index).snapshots().listen((data) {
                                                        setState(() {
                                                          problemFSPertama = data.data['FSProblem'];
                                                          areaFSPertama = data.data['FSArea'];
                                                          criticalFSPertama = data.data['FSCritical'];
                                                          auditorFSPertama = data.data['FSAuditor'];
                                                          auditorIDFSPertama = data.data['FSAuditorID'];
                                                          subBabFSPertama = data.data['FSSubBab'];
                                                          carNoFSPertama = data.data['FSCarNo'];
                                                          rekomendasiFSPertama = data.data['FSRekomendasi'];
                                                        });
                                                      });
                                                      await new Future.delayed(Duration(
                                                        seconds: 3
                                                      ));

                                                      setState(() {
                                                        problemFSSave = List.from(problemFSPertama)..addAll(problemFS);
                                                        areaFSSave = List.from(areaFSPertama)..addAll(areaFS);
                                                        criticalFSSave = List.from(criticalFSPertama)..addAll(criticalFS);
                                                        auditorFSSave = List.from(auditorFSPertama)..addAll(auditorFS);
                                                        auditorIDFSSave = List.from(auditorIDFSPertama)..addAll(auditorIDFS);
                                                        subBabFSSave = List.from(subBabFSPertama)..addAll(subBabFS);
                                                        carNoFSSave = List.from(carNoFSPertama)..addAll(carNoFS);
                                                        rekomendasiFSSave = List.from(rekomendasiFSPertama)..addAll(rekomendasiFS);
                                                      });

                                                        docReference44.updateData({
                                                          'pesertaStatus': pesertaStatus,
                                                          'hasilGrafik': hasilGrafik,
                                                          'checkOutPeserta': checkOutPesertaSave,
                                                          // 'FSDivisi': divisiFS,
                                                          'FSDepartment': departmentNameFS,
                                                          'FSDepartmentID': departmentIDFS,
                                                          'FSCategory': categoryFS,
                                                          'FSSubBab': subBabFSSave,
                                                          'FSAuditor': auditorFSSave,
                                                          'FSAuditorID': auditorIDFSSave,
                                                          'FSCritical': criticalFSSave,
                                                          'FSArea': areaFSSave,
                                                          'FSProblem': problemFSSave,
                                                          'FSRekomendasi': rekomendasiFSSave,
                                                          'FSCarNo': carNoFSSave,
                                                        }).then((doc) {
                                                          setState(() {
                                                            isProcess = false; 
                                                          });
                                                          showDialog(
                                                            barrierDismissible: false,
                                                            context: context,
                                                            builder: (context) => Dialog(
                                                              child: Container(
                                                                height: 180.0,
                                                                child: Column(
                                                                  children: <Widget>[
                                                                    Container(
                                                                      color: AbubaPallate.greenabuba,
                                                                      height:50.0,
                                                                      child:
                                                                      Center(
                                                                        child: Text(
                                                                          'SUCCESSFUL!',
                                                                          style: TextStyle(
                                                                            color: Colors.white,
                                                                            fontSize: 17.0,
                                                                            fontWeight: FontWeight.w700
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 20.0,
                                                                    ),
                                                                    Container(
                                                                      padding: EdgeInsets.symmetric(horizontal:10.0,vertical:10.0),
                                                                      child: Text(
                                                                        'Internal Audit Success',
                                                                        style: TextStyle(
                                                                          fontSize: 16.0,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:MainAxisAlignment.end,
                                                                      children: <Widget>[
                                                                        FlatButton(
                                                                          child: Text('OK'),
                                                                          onPressed:() {
                                                                            Navigator.pop(context);
                                                                          },
                                                                        )
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            )).whenComplete(() {
                                                                Navigator.pop(context);
                                                            }
                                                          );
                                                          print(problemFSSave);
                                                          print(areaFSSave);
                                                          print(criticalFSSave);
                                                          print(auditorFSSave);
                                                          print(auditorIDFSSave);
                                                          print(subBabFSSave);
                                                          print(carNoFSSave);
                                                          print(rekomendasiFSSave);
                                                        }).catchError((error) {
                                                          print(error);
                                                        });
                                                      }).catchError((error) {
                                                        print(error);
                                                      });

                                                    }
                                                    print(jumlahCriticalPoint);
                                                    print(totalCPfirebase);
                                                    print('save 2');
                                                  }
                                                },
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    decoration:
                                    BoxDecoration(color: Color(0xFF2F592F))),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
              ],
            ),
          )
        ],
      ),
    );
  }
}