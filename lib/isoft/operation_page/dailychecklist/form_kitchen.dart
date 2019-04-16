import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FormKitchen extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  FormKitchen({
    this.idUser,
    this.namaUser,
    this.departmentUser,
  });
  @override
  _FormKitchenState createState() => _FormKitchenState();
}

class _FormKitchenState extends State<FormKitchen> with TickerProviderStateMixin {
  AnimationController animationController;

  int indexParkingLobby = 0;
  int jumlahParkingLobby = 0;
  List<int> scoreParkingLobby = [];
  List<String> warnaParkingLobby = [];
  List<dynamic> pertanyaanParkingLobby = [];
  String imageParkingLobby = null;
  File imageParkingLobbyBantu;
  File imageParkingLobby1;
  String filenameParkingLobby1;
  String imageParkingLobbySave = null;

  int indexDinningAreaLobby = 0;
  int jumlahDinningAreaLobby = 0;
  List<int> scoreDinningAreaLobby = [];
  List<String> warnaDinningAreaLobby = [];
  List<dynamic> pertanyaanDinningAreaLobby = [];
  String imageDinningAreaLobby = null;
  File imageDinningAreaLobbyBantu;
  File imageDinningAreaLobby1;
  String filenameDinningAreaLobby1;
  String imageDinningAreaLobbySave = null;

  int indexRestroomLobby = 0;
  int jumlahRestroomLobby = 0;
  List<int> scoreRestroomLobby = [];
  List<String> warnaRestroomLobby = [];
  List<dynamic> pertanyaanRestroomLobby = [];
  String imageRestroomLobby = null;
  File imageRestroomLobbyBantu;
  File imageRestroomLobby1;
  String filenameRestroomLobby1;
  String imageRestroomLobbySave = null;

  int indexGrillAreaDinning = 0;
  int jumlahGrillAreaDinning = 0;
  List<int> scoreGrillAreaDinning = [];
  List<String> warnaGrillAreaDinning = [];
  List<dynamic> pertanyaanGrillAreaDinning = [];
  String imageGrillAreaDinning = null;
  File imageGrillAreaDinningBantu;
  File imageGrillAreaDinning1;
  String filenameGrillAreaDinning1;
  String imageGrillAreaDinningSave = null;

  int indexBarDinning = 0;
  int jumlahBarDinning = 0;
  List<int> scoreBarDinning = [];
  List<String> warnaBarDinning = [];
  List<dynamic> pertanyaanBarDinning = [];
  String imageBarDinning = null;
  File imageBarDinningBantu;
  File imageBarDinning1;
  String filenameBarDinning1;
  String imageBarDinningSave = null;

  int indexProductionDinning = 0;
  int jumlahProductionDinning = 0;
  List<int> scoreProductionDinning = [];
  List<String> warnaProductionDinning = [];
  List<dynamic> pertanyaanProductionDinning = [];
  String imageProductionDinning = null;
  File imageProductionDinningBantu;
  File imageProductionDinning1;
  String filenameProductionDinning1;
  String imageProductionDinningSave = null;

  int indexWarehouseDinning = 0;
  int jumlahWarehouseDinning = 0;
  List<int> scoreWarehouseDinning = [];
  List<String> warnaWarehouseDinning = [];
  List<dynamic> pertanyaanWarehouseDinning = [];
  String imageWarehouseDinning = null;
  File imageWarehouseDinningBantu;
  File imageWarehouseDinning1;
  String filenameWarehouseDinning1;
  String imageWarehouseDinningSave = null;

  int indexMenuBoardPelayanan = 0;
  int jumlahMenuBoardPelayanan = 0;
  List<int> scoreMenuBoardPelayanan = [];
  List<String> warnaMenuBoardPelayanan = [];
  List<dynamic> pertanyaanMenuBoardPelayanan = [];
  String imageMenuBoardPelayanan = null;
  File imageMenuBoardPelayananBantu;
  File imageMenuBoardPelayanan1;
  String filenameMenuBoardPelayanan1;
  String imageMenuBoardPelayananSave = null;

  int indexServiceAreaPelayanan = 0;
  int jumlahServiceAreaPelayanan = 0;
  List<int> scoreServiceAreaPelayanan = [];
  List<String> warnaServiceAreaPelayanan = [];
  List<dynamic> pertanyaanServiceAreaPelayanan = [];
  String imageServiceAreaPelayanan = null;
  File imageServiceAreaPelayananBantu;
  File imageServiceAreaPelayanan1;
  String filenameServiceAreaPelayanan1;
  String imageServiceAreaPelayananSave = null;

  int indexGroomingPelayanan = 0;
  int jumlahGroomingPelayanan = 0;
  List<int> scoreGroomingPelayanan = [];
  List<String> warnaGroomingPelayanan = [];
  List<dynamic> pertanyaanGroomingPelayanan = [];
  String imageGroomingPelayanan = null;
  File imageGroomingPelayananBantu;
  File imageGroomingPelayanan1;
  String filenameGroomingPelayanan1;
  String imageGroomingPelayananSave = null;

  int indexKeamananPelayanan = 0;
  int jumlahKeamananPelayanan = 0;
  List<int> scoreKeamananPelayanan = [];
  List<String> warnaKeamananPelayanan = [];
  List<dynamic> pertanyaanKeamananPelayanan = [];
  String imageKeamananPelayanan = null;
  File imageKeamananPelayananBantu;
  File imageKeamananPelayanan1;
  String filenameKeamananPelayanan1;
  String imageKeamananPelayananSave = null;

  int indexKesiapanBisnis = 0;
  int jumlahKesiapanBisnis = 0;
  List<int> scoreKesiapanBisnis = [];
  List<String> warnaKesiapanBisnis = [];
  List<dynamic> pertanyaanKesiapanBisnis = [];
  String imageKesiapanBisnis = null;
  File imageKesiapanBisnisBantu;
  File imageKesiapanBisnis1;
  String filenameKesiapanBisnis1;
  String imageKesiapanBisnisSave = null;

  int indexSteakCook = 0;
  int jumlahSteakCook = 0;
  List<int> scoreSteakCook = [];
  List<String> warnaSteakCook = [];
  List<dynamic> pertanyaanSteakCook = [];
  String imageSteakCook = null;
  File imageSteakCookBantu;
  File imageSteakCook1;
  String filenameSteakCook1;
  String imageSteakCookSave = null;

  int indexBatterMixCook = 0;
  int jumlahBatterMixCook = 0;
  List<int> scoreBatterMixCook = [];
  List<String> warnaBatterMixCook = [];
  List<dynamic> pertanyaanBatterMixCook = [];
  String imageBatterMixCook = null;
  File imageBatterMixCookBantu;
  File imageBatterMixCook1;
  String filenameBatterMixCook1;
  String imageBatterMixCookSave = null;

  int indexMixVegetablesCook = 0;
  int jumlahMixVegetablesCook = 0;
  List<int> scoreMixVegetablesCook = [];
  List<String> warnaMixVegetablesCook = [];
  List<dynamic> pertanyaanMixVegetablesCook = [];
  String imageMixVegetablesCook = null;
  File imageMixVegetablesCookBantu;
  File imageMixVegetablesCook1;
  String filenameMixVegetablesCook1;
  String imageMixVegetablesCookSave = null;

  int indexPotatoCook = 0;
  int jumlahPotatoCook = 0;
  List<int> scorePotatoCook = [];
  List<String> warnaPotatoCook = [];
  List<dynamic> pertanyaanPotatoCook = [];
  String imagePotatoCook = null;
  File imagePotatoCookBantu;
  File imagePotatoCook1;
  String filenamePotatoCook1;
  String imagePotatoCookSave = null;

  int indexGrillerCook = 0;
  int jumlahGrillerCook = 0;
  List<int> scoreGrillerCook = [];
  List<String> warnaGrillerCook = [];
  List<dynamic> pertanyaanGrillerCook = [];
  String imageGrillerCook = null;
  File imageGrillerCookBantu;
  File imageGrillerCook1;
  String filenameGrillerCook1;
  String imageGrillerCookSave = null;

  int indexKeamananMakananCook = 0;
  int jumlahKeamananMakananCook = 0;
  List<int> scoreKeamananMakananCook = [];
  List<String> warnaKeamananMakananCook = [];
  List<dynamic> pertanyaanKeamananMakananCook = [];
  String imageKeamananMakananCook = null;
  File imageKeamananMakananCookBantu;
  File imageKeamananMakananCook1;
  String filenameKeamananMakananCook1;
  String imageKeamananMakananCookSave = null;

  int indexAreaCook = 0;
  int jumlahAreaCook = 0;
  List<int> scoreAreaCook = [];
  List<String> warnaAreaCook = [];
  List<dynamic> pertanyaanAreaCook = [];
  String imageAreaCook = null;
  File imageAreaCookBantu;
  File imageAreaCook1;
  String filenameAreaCook1;
  String imageAreaCookSave = null;

  int indexKitchenCook = 0;
  int jumlahKitchenCook = 0;
  List<int> scoreKitchenCook = [];
  List<String> warnaKitchenCook = [];
  List<dynamic> pertanyaanKitchenCook = [];
  String imageKitchenCook = null;
  File imageKitchenCookBantu;
  File imageKitchenCook1;
  String filenameKitchenCook1;
  String imageKitchenCookSave = null;

  int indexDishwasherWash = 0;
  int jumlahDishwasherWash = 0;
  List<int> scoreDishwasherWash = [];
  List<String> warnaDishwasherWash = [];
  List<dynamic> pertanyaanDishwasherWash = [];
  String imageDishwasherWash = null;
  File imageDishwasherWashBantu;
  File imageDishwasherWash1;
  String filenameDishwasherWash1;
  String imageDishwasherWashSave = null;

  int indexChillerWash = 0;
  int jumlahChillerWash = 0;
  List<int> scoreChillerWash = [];
  List<String> warnaChillerWash = [];
  List<dynamic> pertanyaanChillerWash = [];
  String imageChillerWash = null;
  File imageChillerWashBantu;
  File imageChillerWash1;
  String filenameChillerWash1;
  String imageChillerWashSave = null;

  int indexKeamananWash = 0;
  int jumlahKeamananWash = 0;
  List<int> scoreKeamananWash = [];
  List<String> warnaKeamananWash = [];
  List<dynamic> pertanyaanKeamananWash = [];
  String imageKeamananWash = null;
  File imageKeamananWashBantu;
  File imageKeamananWash1;
  String filenameKeamananWash1;
  String imageKeamananWashSave = null;

  int indexAlatWash = 0;
  int jumlahAlatWash = 0;
  List<int> scoreAlatWash = [];
  List<String> warnaAlatWash = [];
  List<dynamic> pertanyaanAlatWash = [];
  String imageAlatWash = null;
  File imageAlatWashBantu;
  File imageAlatWash1;
  String filenameAlatWash1;
  String imageAlatWashSave = null;

  List<Map> _listData = [
    {'nomor': '1'},
    {'nomor': '2'},
    {'nomor': '3'},
    {'nomor': '4'},
    {'nomor': '5'}
  ];

  @override
  void initState() {
    _cardController = new TabController(vsync: this, length: _listData.length);
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(
        from:
        animationController.value == 0.0 ? 1.0 : animationController.value);

    setState(() {

      /*BAB 1*/
      Firestore.instance.collection('parkingLobby').snapshots().listen((data) {
        jumlahParkingLobby = data.documents[0].data['pertanyaan'].length;
        pertanyaanParkingLobby = data.documents[0].data['pertanyaan'];
      });

      Firestore.instance.collection('dinningAreaLobby').snapshots().listen((data) {
        jumlahDinningAreaLobby = data.documents[0].data['pertanyaan'].length;
        pertanyaanDinningAreaLobby = data.documents[0].data['pertanyaan'];
      });

      Firestore.instance.collection('restroomLobby').snapshots().listen((data) {
        jumlahRestroomLobby = data.documents[0].data['pertanyaan'].length;
        pertanyaanRestroomLobby = data.documents[0].data['pertanyaan'];
      });
      /*END BAB 1*/

      /*BAB 2*/
      Firestore.instance.collection('grillAreaDinning').snapshots().listen((data) {
        jumlahGrillAreaDinning= data.documents[0].data['pertanyaan'].length;
        pertanyaanGrillAreaDinning = data.documents[0].data['pertanyaan'];
      });

      Firestore.instance.collection('barDinning').snapshots().listen((data) {
        jumlahBarDinning = data.documents[0].data['pertanyaan'].length;
        pertanyaanBarDinning = data.documents[0].data['pertanyaan'];
      });

      Firestore.instance.collection('productionDinning').snapshots().listen((data) {
        jumlahProductionDinning = data.documents[0].data['pertanyaan'].length;
        pertanyaanProductionDinning = data.documents[0].data['pertanyaan'];
      });

      Firestore.instance.collection('warehouseDinning').snapshots().listen((data) {
        jumlahWarehouseDinning = data.documents[0].data['pertanyaan'].length;
        pertanyaanWarehouseDinning = data.documents[0].data['pertanyaan'];
      });
      /*END BAB 2*/

      /*BAB 3*/
      Firestore.instance.collection('menuBoardPelayanan').snapshots().listen((data) {
        jumlahMenuBoardPelayanan = data.documents[0].data['pertanyaan'].length;
        pertanyaanMenuBoardPelayanan = data.documents[0].data['pertanyaan'];
      });

      Firestore.instance.collection('serviceAreaPelayanan').snapshots().listen((data) {
        jumlahServiceAreaPelayanan = data.documents[0].data['pertanyaan'].length;
        pertanyaanServiceAreaPelayanan = data.documents[0].data['pertanyaan'];
      });

      Firestore.instance.collection('keamananPelayanan').snapshots().listen((data) {
        jumlahKeamananPelayanan = data.documents[0].data['pertanyaan'].length;
        pertanyaanKeamananPelayanan = data.documents[0].data['pertanyaan'];
      });

      Firestore.instance.collection('kesiapanBisnis').snapshots().listen((data) {
        jumlahKesiapanBisnis = data.documents[0].data['pertanyaan'].length;
        pertanyaanKesiapanBisnis = data.documents[0].data['pertanyaan'];
      });
      /*END BAB 3*/

      /*BAB 4*/
      Firestore.instance.collection('steakCook').snapshots().listen((data) {
        jumlahSteakCook = data.documents[0].data['pertanyaan'].length;
        pertanyaanSteakCook = data.documents[0].data['pertanyaan'];
      });

      Firestore.instance.collection('batterMixCook').snapshots().listen((data) {
        jumlahBatterMixCook = data.documents[0].data['pertanyaan'].length;
        pertanyaanBatterMixCook = data.documents[0].data['pertanyaan'];
      });

      Firestore.instance.collection('mixVegetables').snapshots().listen((data) {
        jumlahMixVegetablesCook = data.documents[0].data['pertanyaan'].length;
        pertanyaanMixVegetablesCook = data.documents[0].data['pertanyaan'];
      });

      Firestore.instance.collection('potatoWedgesCook').snapshots().listen((data) {
        jumlahPotatoCook = data.documents[0].data['pertanyaan'].length;
        pertanyaanPotatoCook = data.documents[0].data['pertanyaan'];
      });

      Firestore.instance.collection('grillerCook').snapshots().listen((data) {
        jumlahGrillerCook = data.documents[0].data['pertanyaan'].length;
        pertanyaanGrillerCook = data.documents[0].data['pertanyaan'];
      });

      Firestore.instance.collection('keamananMakananCook').snapshots().listen((data) {
        jumlahKeamananMakananCook = data.documents[0].data['pertanyaan'].length;
        pertanyaanKeamananMakananCook = data.documents[0].data['pertanyaan'];
      });

      Firestore.instance.collection('areaCook').snapshots().listen((data) {
        jumlahAreaCook = data.documents[0].data['pertanyaan'].length;
        pertanyaanAreaCook = data.documents[0].data['pertanyaan'];
      });

      Firestore.instance.collection('kitchenEquipmentCook').snapshots().listen((data) {
        jumlahKitchenCook = data.documents[0].data['pertanyaan'].length;
        pertanyaanKitchenCook = data.documents[0].data['pertanyaan'];
      });
      /*END BAB 4*/

      /*BAB 5*/
      Firestore.instance.collection('dishwasherWash').snapshots().listen((data) {
        jumlahDishwasherWash = data.documents[0].data['pertanyaan'].length;
        pertanyaanDishwasherWash = data.documents[0].data['pertanyaan'];
      });

      Firestore.instance.collection('chillerWash').snapshots().listen((data) {
        jumlahChillerWash = data.documents[0].data['pertanyaan'].length;
        pertanyaanChillerWash = data.documents[0].data['pertanyaan'];
      });

      Firestore.instance.collection('keamananWash').snapshots().listen((data) {
        jumlahKeamananWash = data.documents[0].data['pertanyaan'].length;
        pertanyaanKeamananWash = data.documents[0].data['pertanyaan'];
      });

      Firestore.instance.collection('alatKeamananWash').snapshots().listen((data) {
        jumlahAlatWash = data.documents[0].data['pertanyaan'].length;
        pertanyaanAlatWash = data.documents[0].data['pertanyaan'];
      });
      /*END BAB 5*/
    });
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
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: _buildFormMenu(context)),
      ),
    );
  }

  Widget _buildFormMenu(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Expanded(
            child: TabBarView(
              controller: _cardController,
              physics: ScrollPhysics(),
              children: <Widget>[
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
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Lobby & Restroom',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0),
                                        textAlign: TextAlign.start,
                                      ),
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
                        return Scrollbar(
                          child: animationController.isAnimating ? Center (
                            child: Container(
                              child: CircularProgressIndicator(),
                              alignment: Alignment(0.0, 0.0),
                              height: MediaQuery.of(context).size.height * 0.736,
                            ),
                          ) : Container(
                            /*height: MediaQuery.of(context).size.height * 0.648,*/
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            height: MediaQuery.of(context).size.height * 0.736,
                            color: Colors.white,
                            child: ListView(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 180.0,
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Parking Lot / Sisi Tembok',
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16.0),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 120.0,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'FOLLOW UP',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14.0),
                                            ),
                                          ),
                                          imageParkingLobby != null
                                              ? IconButton(
                                            icon: Icon(
                                                Icons.disc_full,
                                                color:
                                                Colors.grey),
                                            onPressed: () {},
                                            tooltip:
                                            'You have uploaded',
                                          ) :
                                          IconButton(
                                            icon: Icon(
                                                Icons.camera_alt,
                                                color: AbubaPallate
                                                    .greenabuba),
                                            onPressed: () async {
                                              var selectedImage =
                                              await ImagePicker
                                                  .pickImage(
                                                  source:
                                                  ImageSource.camera);
                                              imageParkingLobby1 =
                                                  selectedImage;
                                              filenameParkingLobby1 =
                                                  basename(
                                                      imageParkingLobby1
                                                          .path);

                                              StorageReference
                                              strRef =
                                              FirebaseStorage
                                                  .instance
                                                  .ref()
                                                  .child(
                                                  filenameParkingLobby1);
                                              StorageUploadTask
                                              uploadTask =
                                              strRef.putFile(
                                                  imageParkingLobby1);

                                              var downUrl =
                                              await (await uploadTask
                                                  .onComplete)
                                                  .ref
                                                  .getDownloadURL();
                                              var url = downUrl
                                                  .toString();

                                              setState(() {
                                                imageParkingLobby =
                                                    filenameParkingLobby1;
                                                imageParkingLobbyBantu =
                                                    imageParkingLobby1;
                                                imageParkingLobbySave = url;

                                                print(imageParkingLobby);
                                                print(imageParkingLobbyBantu);
                                                print(imageParkingLobbySave);
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                ListView(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    children: List.generate(pertanyaanParkingLobby.length, (index) {
                                      indexParkingLobby = index;
                                      String counter = (index + 1).toString();
                                      if (scoreParkingLobby.length <
                                          jumlahParkingLobby) {
                                        for (int a = 0;
                                        a < jumlahParkingLobby;
                                        a++) {
                                          scoreParkingLobby.add(2);

                                          warnaParkingLobby.add('hijau');
                                        }
                                      }

                                      return Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                width: 180.0,
                                                child: Row(
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        '${counter + '. ' + pertanyaanParkingLobby[index]}',
                                                        style: TextStyle(
                                                            color: Colors.black54,
                                                            fontSize: 14.0),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 120.0,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaParkingLobby.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaParkingLobby[index] ==
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
                                                            'NO',
                                                            style:
                                                            TextStyle(
                                                              fontSize:
                                                              18.0,
                                                              color: warnaParkingLobby.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  255,
                                                                  40,
                                                                  0)
                                                                  : warnaParkingLobby[index] ==
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
                                                          color: warnaParkingLobby
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaParkingLobby[index] ==
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
                                                              scoreParkingLobby
                                                                  .removeAt(
                                                                  index);
                                                              scoreParkingLobby
                                                                  .insert(
                                                                  index,
                                                                  0);
                                                              warnaParkingLobby
                                                                  .removeAt(
                                                                  index);
                                                              warnaParkingLobby
                                                                  .insert(
                                                                  index,
                                                                  'merah');

                                                              print(scoreParkingLobby);
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                    ),
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaParkingLobby.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaParkingLobby[index] ==
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
                                                            'OK',
                                                            style: TextStyle(
                                                                fontSize:
                                                                18.0,
                                                                color: warnaParkingLobby.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    50,
                                                                    205,
                                                                    50)
                                                                    : warnaParkingLobby[index] == 'hijau'
                                                                    ? Colors.white
                                                                    : Color.fromARGB(170, 50, 205, 50)),
                                                            textAlign:
                                                            TextAlign
                                                                .center,
                                                          ),
                                                          color: warnaParkingLobby
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaParkingLobby[index] ==
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
                                                              scoreParkingLobby
                                                                  .removeAt(
                                                                  index);
                                                              scoreParkingLobby
                                                                  .insert(
                                                                  index,
                                                                  2);
                                                              warnaParkingLobby
                                                                  .removeAt(
                                                                  index);
                                                              warnaParkingLobby
                                                                  .insert(
                                                                  index,
                                                                  'hijau');

                                                              print(scoreParkingLobby);
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      );
                                    })
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Divider(
                                    height: 1.0,
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 180.0,
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Dinning Area',
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16.0),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 120.0,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'FOLLOW UP',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14.0),
                                            ),
                                          ),
                                          imageDinningAreaLobby != null
                                              ? IconButton(
                                            icon: Icon(
                                                Icons.disc_full,
                                                color:
                                                Colors.grey),
                                            onPressed: () {},
                                            tooltip:
                                            'You have uploaded',
                                          ) :
                                          IconButton(
                                            icon: Icon(
                                                Icons.camera_alt,
                                                color: AbubaPallate
                                                    .greenabuba),
                                            onPressed: () async {
                                              var selectedImage =
                                              await ImagePicker
                                                  .pickImage(
                                                  source:
                                                  ImageSource.camera);
                                              imageDinningAreaLobby1 =
                                                  selectedImage;
                                              filenameDinningAreaLobby1 =
                                                  basename(
                                                      imageDinningAreaLobby1
                                                          .path);

                                              StorageReference
                                              strRef =
                                              FirebaseStorage
                                                  .instance
                                                  .ref()
                                                  .child(
                                                  filenameDinningAreaLobby1);
                                              StorageUploadTask
                                              uploadTask =
                                              strRef.putFile(
                                                  imageDinningAreaLobby1);

                                              var downUrl =
                                              await (await uploadTask
                                                  .onComplete)
                                                  .ref
                                                  .getDownloadURL();
                                              var url = downUrl
                                                  .toString();

                                              setState(() {
                                                imageDinningAreaLobby =
                                                    filenameDinningAreaLobby1;
                                                imageDinningAreaLobbyBantu =
                                                    imageDinningAreaLobby1;
                                                imageDinningAreaLobbySave = url;

                                                print(imageDinningAreaLobby);
                                                print(imageDinningAreaLobbyBantu);
                                                print(imageDinningAreaLobbySave);
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                ListView(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    children: List.generate(pertanyaanDinningAreaLobby.length, (index) {
                                      indexDinningAreaLobby = index;
                                      String counter = (index + 1).toString();
                                      if (scoreDinningAreaLobby.length <
                                          jumlahDinningAreaLobby) {
                                        for (int a = 0;
                                        a < jumlahDinningAreaLobby;
                                        a++) {
                                          scoreDinningAreaLobby.add(2);

                                          warnaDinningAreaLobby.add('hijau');
                                        }
                                      }

                                      return Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                width: 180.0,
                                                child: Row(
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        '${counter + '. ' + pertanyaanDinningAreaLobby[index]}',
                                                        style: TextStyle(
                                                            color: Colors.black54,
                                                            fontSize: 14.0),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 120.0,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaDinningAreaLobby.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaDinningAreaLobby[index] ==
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
                                                            'NO',
                                                            style:
                                                            TextStyle(
                                                              fontSize:
                                                              18.0,
                                                              color: warnaDinningAreaLobby.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  255,
                                                                  40,
                                                                  0)
                                                                  : warnaDinningAreaLobby[index] ==
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
                                                          color: warnaDinningAreaLobby
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaDinningAreaLobby[index] ==
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
                                                              scoreDinningAreaLobby
                                                                  .removeAt(
                                                                  index);
                                                              scoreDinningAreaLobby
                                                                  .insert(
                                                                  index,
                                                                  0);
                                                              warnaDinningAreaLobby
                                                                  .removeAt(
                                                                  index);
                                                              warnaDinningAreaLobby
                                                                  .insert(
                                                                  index,
                                                                  'merah');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                    ),
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaDinningAreaLobby.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaDinningAreaLobby[index] ==
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
                                                            'OK',
                                                            style: TextStyle(
                                                                fontSize:
                                                                18.0,
                                                                color: warnaDinningAreaLobby.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    50,
                                                                    205,
                                                                    50)
                                                                    : warnaDinningAreaLobby[index] == 'hijau'
                                                                    ? Colors.white
                                                                    : Color.fromARGB(170, 50, 205, 50)),
                                                            textAlign:
                                                            TextAlign
                                                                .center,
                                                          ),
                                                          color: warnaDinningAreaLobby
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaDinningAreaLobby[index] ==
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
                                                              scoreDinningAreaLobby
                                                                  .removeAt(
                                                                  index);
                                                              scoreDinningAreaLobby
                                                                  .insert(
                                                                  index,
                                                                  2);
                                                              warnaDinningAreaLobby
                                                                  .removeAt(
                                                                  index);
                                                              warnaDinningAreaLobby
                                                                  .insert(
                                                                  index,
                                                                  'hijau');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      );
                                    })
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Divider(
                                    height: 1.0,
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 180.0,
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Restrooms / Wastafel Area',
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16.0),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 120.0,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'FOLLOW UP',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14.0),
                                            ),
                                          ),
                                          imageRestroomLobby != null
                                              ? IconButton(
                                            icon: Icon(
                                                Icons.disc_full,
                                                color:
                                                Colors.grey),
                                            onPressed: () {},
                                            tooltip:
                                            'You have uploaded',
                                          ) :
                                          IconButton(
                                            icon: Icon(
                                                Icons.camera_alt,
                                                color: AbubaPallate
                                                    .greenabuba),
                                            onPressed: () async {
                                              var selectedImage =
                                              await ImagePicker
                                                  .pickImage(
                                                  source:
                                                  ImageSource.camera);
                                              imageRestroomLobby1 =
                                                  selectedImage;
                                              filenameRestroomLobby1 =
                                                  basename(
                                                      imageRestroomLobby1
                                                          .path);

                                              StorageReference
                                              strRef =
                                              FirebaseStorage
                                                  .instance
                                                  .ref()
                                                  .child(
                                                  filenameRestroomLobby1);
                                              StorageUploadTask
                                              uploadTask =
                                              strRef.putFile(
                                                  imageRestroomLobby1);

                                              var downUrl =
                                              await (await uploadTask
                                                  .onComplete)
                                                  .ref
                                                  .getDownloadURL();
                                              var url = downUrl
                                                  .toString();

                                              setState(() {
                                                imageRestroomLobby =
                                                    filenameRestroomLobby1;
                                                imageRestroomLobbyBantu =
                                                    imageRestroomLobby1;
                                                imageRestroomLobbySave = url;

                                                print(imageRestroomLobby);
                                                print(imageRestroomLobbyBantu);
                                                print(imageRestroomLobbySave);
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                ListView(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    children: List.generate(pertanyaanRestroomLobby.length, (index) {
                                      indexRestroomLobby = index;
                                      String counter = (index + 1).toString();
                                      if (scoreRestroomLobby.length <
                                          jumlahRestroomLobby) {
                                        for (int a = 0;
                                        a < jumlahRestroomLobby;
                                        a++) {
                                          scoreRestroomLobby.add(2);

                                          warnaRestroomLobby.add('hijau');
                                        }
                                      }

                                      return Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                width: 180.0,
                                                child: Row(
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        '${counter + '. ' + pertanyaanRestroomLobby[index]}',
                                                        style: TextStyle(
                                                            color: Colors.black54,
                                                            fontSize: 14.0),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 120.0,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaRestroomLobby.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaRestroomLobby[index] ==
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
                                                            'NO',
                                                            style:
                                                            TextStyle(
                                                              fontSize:
                                                              18.0,
                                                              color: warnaRestroomLobby.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  255,
                                                                  40,
                                                                  0)
                                                                  : warnaRestroomLobby[index] ==
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
                                                          color: warnaRestroomLobby
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaRestroomLobby[index] ==
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
                                                              scoreRestroomLobby
                                                                  .removeAt(
                                                                  index);
                                                              scoreRestroomLobby
                                                                  .insert(
                                                                  index,
                                                                  0);
                                                              warnaRestroomLobby
                                                                  .removeAt(
                                                                  index);
                                                              warnaRestroomLobby
                                                                  .insert(
                                                                  index,
                                                                  'merah');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                    ),
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaRestroomLobby.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaRestroomLobby[index] ==
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
                                                            'OK',
                                                            style: TextStyle(
                                                                fontSize:
                                                                18.0,
                                                                color: warnaRestroomLobby.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    50,
                                                                    205,
                                                                    50)
                                                                    : warnaRestroomLobby[index] == 'hijau'
                                                                    ? Colors.white
                                                                    : Color.fromARGB(170, 50, 205, 50)),
                                                            textAlign:
                                                            TextAlign
                                                                .center,
                                                          ),
                                                          color: warnaRestroomLobby
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaRestroomLobby[index] ==
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
                                                              scoreRestroomLobby
                                                                  .removeAt(
                                                                  index);
                                                              scoreRestroomLobby
                                                                  .insert(
                                                                  index,
                                                                  2);
                                                              warnaRestroomLobby
                                                                  .removeAt(
                                                                  index);
                                                              warnaRestroomLobby
                                                                  .insert(
                                                                  index,
                                                                  'hijau');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      );
                                    })
                                ),
                              ],
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
                                          /*IconButton(
                                            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                                            onPressed: () {
                                              _cardController.animateTo(_cardController.index - 1);
                                            },
                                            tooltip: 'Previous',
                                          ),*/
                                          IconButton(
                                            icon: Icon(Icons.arrow_forward_ios,
                                                color: Colors.white),
                                            onPressed: () {
                                              _cardController.animateTo(
                                                  _cardController.index + 1);
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
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Dinning Room / Grill / Bar',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0),
                                        textAlign: TextAlign.start,
                                      ),
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
                        return Scrollbar(
                          child: animationController.isAnimating ? Center (
                            child: Container(
                              child: CircularProgressIndicator(),
                              alignment: Alignment(0.0, 0.0),
                              height: MediaQuery.of(context).size.height * 0.736,
                            ),
                          ) : Container(
                            /*height: MediaQuery.of(context).size.height * 0.648,*/
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            height: MediaQuery.of(context).size.height * 0.736,
                            color: Colors.white,
                            child: ListView(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 180.0,
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Grill Area',
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16.0),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 120.0,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'FOLLOW UP',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14.0),
                                            ),
                                          ),
                                          imageGrillAreaDinning != null
                                              ? IconButton(
                                            icon: Icon(
                                                Icons.disc_full,
                                                color:
                                                Colors.grey),
                                            onPressed: () {},
                                            tooltip:
                                            'You have uploaded',
                                          ) :
                                          IconButton(
                                            icon: Icon(
                                                Icons.camera_alt,
                                                color: AbubaPallate
                                                    .greenabuba),
                                            onPressed: () async {
                                              var selectedImage =
                                              await ImagePicker
                                                  .pickImage(
                                                  source:
                                                  ImageSource.camera);
                                              imageGrillAreaDinning1 =
                                                  selectedImage;
                                              filenameGrillAreaDinning1 =
                                                  basename(
                                                      imageGrillAreaDinning1
                                                          .path);

                                              StorageReference
                                              strRef =
                                              FirebaseStorage
                                                  .instance
                                                  .ref()
                                                  .child(
                                                  filenameGrillAreaDinning1);
                                              StorageUploadTask
                                              uploadTask =
                                              strRef.putFile(
                                                  imageGrillAreaDinning1);

                                              var downUrl =
                                              await (await uploadTask
                                                  .onComplete)
                                                  .ref
                                                  .getDownloadURL();
                                              var url = downUrl
                                                  .toString();

                                              setState(() {
                                                imageGrillAreaDinning =
                                                    filenameGrillAreaDinning1;
                                                imageGrillAreaDinningBantu =
                                                    imageGrillAreaDinning1;
                                                imageGrillAreaDinningSave = url;

                                                print(imageGrillAreaDinning);
                                                print(imageGrillAreaDinningBantu);
                                                print(imageGrillAreaDinningSave);
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                ListView(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    children: List.generate(pertanyaanGrillAreaDinning.length, (index) {
                                      indexGrillAreaDinning = index;
                                      String counter = (index + 1).toString();
                                      if (scoreGrillAreaDinning.length <
                                          jumlahGrillAreaDinning) {
                                        for (int a = 0;
                                        a < jumlahGrillAreaDinning;
                                        a++) {
                                          scoreGrillAreaDinning.add(2);

                                          warnaGrillAreaDinning.add('hijau');
                                        }
                                      }

                                      return Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                width: 180.0,
                                                child: Row(
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        '${counter + '. ' + pertanyaanGrillAreaDinning[index]}',
                                                        style: TextStyle(
                                                            color: Colors.black54,
                                                            fontSize: 14.0),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 120.0,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaGrillAreaDinning.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaGrillAreaDinning[index] ==
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
                                                            'NO',
                                                            style:
                                                            TextStyle(
                                                              fontSize:
                                                              18.0,
                                                              color: warnaGrillAreaDinning.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  255,
                                                                  40,
                                                                  0)
                                                                  : warnaGrillAreaDinning[index] ==
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
                                                          color: warnaGrillAreaDinning
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaGrillAreaDinning[index] ==
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
                                                              scoreGrillAreaDinning
                                                                  .removeAt(
                                                                  index);
                                                              scoreGrillAreaDinning
                                                                  .insert(
                                                                  index,
                                                                  0);
                                                              warnaGrillAreaDinning
                                                                  .removeAt(
                                                                  index);
                                                              warnaGrillAreaDinning
                                                                  .insert(
                                                                  index,
                                                                  'merah');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                    ),
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaGrillAreaDinning.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaGrillAreaDinning[index] ==
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
                                                            'OK',
                                                            style: TextStyle(
                                                                fontSize:
                                                                18.0,
                                                                color: warnaGrillAreaDinning.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    50,
                                                                    205,
                                                                    50)
                                                                    : warnaGrillAreaDinning[index] == 'hijau'
                                                                    ? Colors.white
                                                                    : Color.fromARGB(170, 50, 205, 50)),
                                                            textAlign:
                                                            TextAlign
                                                                .center,
                                                          ),
                                                          color: warnaGrillAreaDinning
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaGrillAreaDinning[index] ==
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
                                                              scoreGrillAreaDinning
                                                                  .removeAt(
                                                                  index);
                                                              scoreGrillAreaDinning
                                                                  .insert(
                                                                  index,
                                                                  2);
                                                              warnaGrillAreaDinning
                                                                  .removeAt(
                                                                  index);
                                                              warnaGrillAreaDinning
                                                                  .insert(
                                                                  index,
                                                                  'hijau');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      );
                                    })
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Divider(
                                    height: 1.0,
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 180.0,
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Bar',
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16.0),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 120.0,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'FOLLOW UP',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14.0),
                                            ),
                                          ),
                                          imageBarDinning != null
                                              ? IconButton(
                                            icon: Icon(
                                                Icons.disc_full,
                                                color:
                                                Colors.grey),
                                            onPressed: () {},
                                            tooltip:
                                            'You have uploaded',
                                          ) :
                                          IconButton(
                                            icon: Icon(
                                                Icons.camera_alt,
                                                color: AbubaPallate
                                                    .greenabuba),
                                            onPressed: () async {
                                              var selectedImage =
                                              await ImagePicker
                                                  .pickImage(
                                                  source:
                                                  ImageSource.camera);
                                              imageBarDinning1 =
                                                  selectedImage;
                                              filenameBarDinning1 =
                                                  basename(
                                                      imageBarDinning1
                                                          .path);

                                              StorageReference
                                              strRef =
                                              FirebaseStorage
                                                  .instance
                                                  .ref()
                                                  .child(
                                                  filenameBarDinning1);
                                              StorageUploadTask
                                              uploadTask =
                                              strRef.putFile(
                                                  imageBarDinning1);

                                              var downUrl =
                                              await (await uploadTask
                                                  .onComplete)
                                                  .ref
                                                  .getDownloadURL();
                                              var url = downUrl
                                                  .toString();

                                              setState(() {
                                                imageBarDinning =
                                                    filenameBarDinning1;
                                                imageBarDinningBantu =
                                                    imageBarDinning1;
                                                imageBarDinningSave = url;

                                                print(imageBarDinning);
                                                print(imageBarDinningBantu);
                                                print(imageBarDinningSave);
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                ListView(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    children: List.generate(pertanyaanBarDinning.length, (index) {
                                      indexBarDinning = index;
                                      String counter = (index + 1).toString();
                                      if (scoreBarDinning.length <
                                          jumlahBarDinning) {
                                        for (int a = 0;
                                        a < jumlahBarDinning;
                                        a++) {
                                          scoreBarDinning.add(2);

                                          warnaBarDinning.add('hijau');
                                        }
                                      }

                                      return Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                width: 180.0,
                                                child: Row(
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        '${counter + '. ' + pertanyaanBarDinning[index]}',
                                                        style: TextStyle(
                                                            color: Colors.black54,
                                                            fontSize: 14.0),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 120.0,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaBarDinning.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaBarDinning[index] ==
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
                                                            'NO',
                                                            style:
                                                            TextStyle(
                                                              fontSize:
                                                              18.0,
                                                              color: warnaBarDinning.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  255,
                                                                  40,
                                                                  0)
                                                                  : warnaBarDinning[index] ==
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
                                                          color: warnaBarDinning
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaBarDinning[index] ==
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
                                                              scoreBarDinning
                                                                  .removeAt(
                                                                  index);
                                                              scoreBarDinning
                                                                  .insert(
                                                                  index,
                                                                  0);
                                                              warnaBarDinning
                                                                  .removeAt(
                                                                  index);
                                                              warnaBarDinning
                                                                  .insert(
                                                                  index,
                                                                  'merah');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                    ),
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaBarDinning.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaBarDinning[index] ==
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
                                                            'OK',
                                                            style: TextStyle(
                                                                fontSize:
                                                                18.0,
                                                                color: warnaBarDinning.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    50,
                                                                    205,
                                                                    50)
                                                                    : warnaBarDinning[index] == 'hijau'
                                                                    ? Colors.white
                                                                    : Color.fromARGB(170, 50, 205, 50)),
                                                            textAlign:
                                                            TextAlign
                                                                .center,
                                                          ),
                                                          color: warnaBarDinning
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaBarDinning[index] ==
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
                                                              scoreBarDinning
                                                                  .removeAt(
                                                                  index);
                                                              scoreBarDinning
                                                                  .insert(
                                                                  index,
                                                                  2);
                                                              warnaBarDinning
                                                                  .removeAt(
                                                                  index);
                                                              warnaBarDinning
                                                                  .insert(
                                                                  index,
                                                                  'hijau');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      );
                                    })
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Divider(
                                    height: 1.0,
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 180.0,
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Production & Pantry Area',
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16.0),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 120.0,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'FOLLOW UP',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14.0),
                                            ),
                                          ),
                                          imageProductionDinning != null
                                              ? IconButton(
                                            icon: Icon(
                                                Icons.disc_full,
                                                color:
                                                Colors.grey),
                                            onPressed: () {},
                                            tooltip:
                                            'You have uploaded',
                                          ) :
                                          IconButton(
                                            icon: Icon(
                                                Icons.camera_alt,
                                                color: AbubaPallate
                                                    .greenabuba),
                                            onPressed: () async {
                                              var selectedImage =
                                              await ImagePicker
                                                  .pickImage(
                                                  source:
                                                  ImageSource.camera);
                                              imageProductionDinning1 =
                                                  selectedImage;
                                              filenameProductionDinning1 =
                                                  basename(
                                                      imageProductionDinning1
                                                          .path);

                                              StorageReference
                                              strRef =
                                              FirebaseStorage
                                                  .instance
                                                  .ref()
                                                  .child(
                                                  filenameProductionDinning1);
                                              StorageUploadTask
                                              uploadTask =
                                              strRef.putFile(
                                                  imageProductionDinning1);

                                              var downUrl =
                                              await (await uploadTask
                                                  .onComplete)
                                                  .ref
                                                  .getDownloadURL();
                                              var url = downUrl
                                                  .toString();

                                              setState(() {
                                                imageProductionDinning =
                                                    filenameProductionDinning1;
                                                imageProductionDinningBantu =
                                                    imageProductionDinning1;
                                                imageProductionDinningSave = url;

                                                print(imageProductionDinning);
                                                print(imageProductionDinningBantu);
                                                print(imageProductionDinningSave);
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                ListView(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    children: List.generate(pertanyaanProductionDinning.length, (index) {
                                      indexProductionDinning = index;
                                      String counter = (index + 1).toString();
                                      if (scoreProductionDinning.length <
                                          jumlahProductionDinning) {
                                        for (int a = 0;
                                        a < jumlahProductionDinning;
                                        a++) {
                                          scoreProductionDinning.add(2);

                                          warnaProductionDinning.add('hijau');
                                        }
                                      }

                                      return Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                width: 180.0,
                                                child: Row(
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        '${counter + '. ' + pertanyaanProductionDinning[index]}',
                                                        style: TextStyle(
                                                            color: Colors.black54,
                                                            fontSize: 14.0),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 120.0,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaProductionDinning.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaProductionDinning[index] ==
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
                                                            'NO',
                                                            style:
                                                            TextStyle(
                                                              fontSize:
                                                              18.0,
                                                              color: warnaProductionDinning.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  255,
                                                                  40,
                                                                  0)
                                                                  : warnaProductionDinning[index] ==
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
                                                          color: warnaProductionDinning
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaProductionDinning[index] ==
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
                                                              scoreProductionDinning
                                                                  .removeAt(
                                                                  index);
                                                              scoreProductionDinning
                                                                  .insert(
                                                                  index,
                                                                  0);
                                                              warnaProductionDinning
                                                                  .removeAt(
                                                                  index);
                                                              warnaProductionDinning
                                                                  .insert(
                                                                  index,
                                                                  'merah');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                    ),
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaProductionDinning.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaProductionDinning[index] ==
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
                                                            'OK',
                                                            style: TextStyle(
                                                                fontSize:
                                                                18.0,
                                                                color: warnaProductionDinning.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    50,
                                                                    205,
                                                                    50)
                                                                    : warnaProductionDinning[index] == 'hijau'
                                                                    ? Colors.white
                                                                    : Color.fromARGB(170, 50, 205, 50)),
                                                            textAlign:
                                                            TextAlign
                                                                .center,
                                                          ),
                                                          color: warnaProductionDinning
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaProductionDinning[index] ==
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
                                                              scoreProductionDinning
                                                                  .removeAt(
                                                                  index);
                                                              scoreProductionDinning
                                                                  .insert(
                                                                  index,
                                                                  2);
                                                              warnaProductionDinning
                                                                  .removeAt(
                                                                  index);
                                                              warnaProductionDinning
                                                                  .insert(
                                                                  index,
                                                                  'hijau');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      );
                                    })
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Divider(
                                    height: 1.0,
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 180.0,
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Warehouse',
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16.0),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 120.0,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'FOLLOW UP',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14.0),
                                            ),
                                          ),
                                          imageWarehouseDinning != null
                                              ? IconButton(
                                            icon: Icon(
                                                Icons.disc_full,
                                                color:
                                                Colors.grey),
                                            onPressed: () {},
                                            tooltip:
                                            'You have uploaded',
                                          ) :
                                          IconButton(
                                            icon: Icon(
                                                Icons.camera_alt,
                                                color: AbubaPallate
                                                    .greenabuba),
                                            onPressed: () async {
                                              var selectedImage =
                                              await ImagePicker
                                                  .pickImage(
                                                  source:
                                                  ImageSource.camera);
                                              imageWarehouseDinning1 =
                                                  selectedImage;
                                              filenameWarehouseDinning1 =
                                                  basename(
                                                      imageWarehouseDinning1
                                                          .path);

                                              StorageReference
                                              strRef =
                                              FirebaseStorage
                                                  .instance
                                                  .ref()
                                                  .child(
                                                  filenameWarehouseDinning1);
                                              StorageUploadTask
                                              uploadTask =
                                              strRef.putFile(
                                                  imageWarehouseDinning1);

                                              var downUrl =
                                              await (await uploadTask
                                                  .onComplete)
                                                  .ref
                                                  .getDownloadURL();
                                              var url = downUrl
                                                  .toString();

                                              setState(() {
                                                imageWarehouseDinning =
                                                    filenameWarehouseDinning1;
                                                imageWarehouseDinningBantu =
                                                    imageWarehouseDinning1;
                                                imageWarehouseDinningSave = url;

                                                print(imageWarehouseDinning);
                                                print(imageWarehouseDinningBantu);
                                                print(imageWarehouseDinningSave);
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                ListView(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    children: List.generate(pertanyaanWarehouseDinning.length, (index) {
                                      indexWarehouseDinning = index;
                                      String counter = (index + 1).toString();
                                      if (scoreWarehouseDinning.length <
                                          jumlahWarehouseDinning) {
                                        for (int a = 0;
                                        a < jumlahWarehouseDinning;
                                        a++) {
                                          scoreWarehouseDinning.add(2);

                                          warnaWarehouseDinning.add('hijau');
                                        }
                                      }

                                      return Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                width: 180.0,
                                                child: Row(
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        '${counter + '. ' + pertanyaanWarehouseDinning[index]}',
                                                        style: TextStyle(
                                                            color: Colors.black54,
                                                            fontSize: 14.0),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 120.0,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaWarehouseDinning.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaWarehouseDinning[index] ==
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
                                                            'NO',
                                                            style:
                                                            TextStyle(
                                                              fontSize:
                                                              18.0,
                                                              color: warnaWarehouseDinning.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  255,
                                                                  40,
                                                                  0)
                                                                  : warnaWarehouseDinning[index] ==
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
                                                          color: warnaWarehouseDinning
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaWarehouseDinning[index] ==
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
                                                              scoreWarehouseDinning
                                                                  .removeAt(
                                                                  index);
                                                              scoreWarehouseDinning
                                                                  .insert(
                                                                  index,
                                                                  0);
                                                              warnaWarehouseDinning
                                                                  .removeAt(
                                                                  index);
                                                              warnaWarehouseDinning
                                                                  .insert(
                                                                  index,
                                                                  'merah');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                    ),
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaWarehouseDinning.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaWarehouseDinning[index] ==
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
                                                            'OK',
                                                            style: TextStyle(
                                                                fontSize:
                                                                18.0,
                                                                color: warnaWarehouseDinning.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    50,
                                                                    205,
                                                                    50)
                                                                    : warnaWarehouseDinning[index] == 'hijau'
                                                                    ? Colors.white
                                                                    : Color.fromARGB(170, 50, 205, 50)),
                                                            textAlign:
                                                            TextAlign
                                                                .center,
                                                          ),
                                                          color: warnaWarehouseDinning
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaWarehouseDinning[index] ==
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
                                                              scoreWarehouseDinning
                                                                  .removeAt(
                                                                  index);
                                                              scoreWarehouseDinning
                                                                  .insert(
                                                                  index,
                                                                  2);
                                                              warnaWarehouseDinning
                                                                  .removeAt(
                                                                  index);
                                                              warnaWarehouseDinning
                                                                  .insert(
                                                                  index,
                                                                  'hijau');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      );
                                    })
                                ),
                              ],
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
                                            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                                            onPressed: () {
                                              _cardController.animateTo(_cardController.index - 1);
                                            },
                                            tooltip: 'Previous',
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.arrow_forward_ios,
                                                color: Colors.white),
                                            onPressed: () {
                                              _cardController.animateTo(
                                                  _cardController.index + 1);
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
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Area Service / Pelayanan / Cashier',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0),
                                        textAlign: TextAlign.start,
                                      ),
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
                        return Scrollbar(
                          child: animationController.isAnimating ? Center (
                            child: Container(
                              child: CircularProgressIndicator(),
                              alignment: Alignment(0.0, 0.0),
                              height: MediaQuery.of(context).size.height * 0.736,
                            ),
                          ) : Container(
                            /*height: MediaQuery.of(context).size.height * 0.648,*/
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            height: MediaQuery.of(context).size.height * 0.736,
                            color: Colors.white,
                            child: ListView(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 180.0,
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Menu Board',
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16.0),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 120.0,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'FOLLOW UP',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14.0),
                                            ),
                                          ),
                                          imageMenuBoardPelayanan != null
                                              ? IconButton(
                                            icon: Icon(
                                                Icons.disc_full,
                                                color:
                                                Colors.grey),
                                            onPressed: () {},
                                            tooltip:
                                            'You have uploaded',
                                          ) :
                                          IconButton(
                                            icon: Icon(
                                                Icons.camera_alt,
                                                color: AbubaPallate
                                                    .greenabuba),
                                            onPressed: () async {
                                              var selectedImage =
                                              await ImagePicker
                                                  .pickImage(
                                                  source:
                                                  ImageSource.camera);
                                              imageMenuBoardPelayanan1 =
                                                  selectedImage;
                                              filenameMenuBoardPelayanan1 =
                                                  basename(
                                                      imageMenuBoardPelayanan1
                                                          .path);

                                              StorageReference
                                              strRef =
                                              FirebaseStorage
                                                  .instance
                                                  .ref()
                                                  .child(
                                                  filenameMenuBoardPelayanan1);
                                              StorageUploadTask
                                              uploadTask =
                                              strRef.putFile(
                                                  imageMenuBoardPelayanan1);

                                              var downUrl =
                                              await (await uploadTask
                                                  .onComplete)
                                                  .ref
                                                  .getDownloadURL();
                                              var url = downUrl
                                                  .toString();

                                              setState(() {
                                                imageMenuBoardPelayanan =
                                                    filenameMenuBoardPelayanan1;
                                                imageMenuBoardPelayananBantu =
                                                    imageMenuBoardPelayanan1;
                                                imageMenuBoardPelayananSave = url;

                                                print(imageMenuBoardPelayanan);
                                                print(imageMenuBoardPelayananBantu);
                                                print(imageMenuBoardPelayananSave);
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                ListView(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    children: List.generate(pertanyaanMenuBoardPelayanan.length, (index) {
                                      indexMenuBoardPelayanan = index;
                                      String counter = (index + 1).toString();
                                      if (scoreMenuBoardPelayanan.length <
                                          jumlahMenuBoardPelayanan) {
                                        for (int a = 0;
                                        a < jumlahMenuBoardPelayanan;
                                        a++) {
                                          scoreMenuBoardPelayanan.add(2);

                                          warnaMenuBoardPelayanan.add('hijau');
                                        }
                                      }

                                      return Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                width: 180.0,
                                                child: Row(
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        '${counter + '. ' + pertanyaanMenuBoardPelayanan[index]}',
                                                        style: TextStyle(
                                                            color: Colors.black54,
                                                            fontSize: 14.0),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 120.0,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaMenuBoardPelayanan.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaMenuBoardPelayanan[index] ==
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
                                                            'NO',
                                                            style:
                                                            TextStyle(
                                                              fontSize:
                                                              18.0,
                                                              color: warnaMenuBoardPelayanan.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  255,
                                                                  40,
                                                                  0)
                                                                  : warnaMenuBoardPelayanan[index] ==
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
                                                          color: warnaMenuBoardPelayanan
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaMenuBoardPelayanan[index] ==
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
                                                              scoreMenuBoardPelayanan
                                                                  .removeAt(
                                                                  index);
                                                              scoreMenuBoardPelayanan
                                                                  .insert(
                                                                  index,
                                                                  0);
                                                              warnaMenuBoardPelayanan
                                                                  .removeAt(
                                                                  index);
                                                              warnaMenuBoardPelayanan
                                                                  .insert(
                                                                  index,
                                                                  'merah');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                    ),
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaMenuBoardPelayanan.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaMenuBoardPelayanan[index] ==
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
                                                            'OK',
                                                            style: TextStyle(
                                                                fontSize:
                                                                18.0,
                                                                color: warnaMenuBoardPelayanan.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    50,
                                                                    205,
                                                                    50)
                                                                    : warnaMenuBoardPelayanan[index] == 'hijau'
                                                                    ? Colors.white
                                                                    : Color.fromARGB(170, 50, 205, 50)),
                                                            textAlign:
                                                            TextAlign
                                                                .center,
                                                          ),
                                                          color: warnaMenuBoardPelayanan
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaMenuBoardPelayanan[index] ==
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
                                                              scoreMenuBoardPelayanan
                                                                  .removeAt(
                                                                  index);
                                                              scoreMenuBoardPelayanan
                                                                  .insert(
                                                                  index,
                                                                  2);
                                                              warnaMenuBoardPelayanan
                                                                  .removeAt(
                                                                  index);
                                                              warnaMenuBoardPelayanan
                                                                  .insert(
                                                                  index,
                                                                  'hijau');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      );
                                    })
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Divider(
                                    height: 1.0,
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 180.0,
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Service Area',
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16.0),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 120.0,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'FOLLOW UP',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14.0),
                                            ),
                                          ),
                                          imageServiceAreaPelayanan != null
                                              ? IconButton(
                                            icon: Icon(
                                                Icons.disc_full,
                                                color:
                                                Colors.grey),
                                            onPressed: () {},
                                            tooltip:
                                            'You have uploaded',
                                          ) :
                                          IconButton(
                                            icon: Icon(
                                                Icons.camera_alt,
                                                color: AbubaPallate
                                                    .greenabuba),
                                            onPressed: () async {
                                              var selectedImage =
                                              await ImagePicker
                                                  .pickImage(
                                                  source:
                                                  ImageSource.camera);
                                              imageServiceAreaPelayanan1 =
                                                  selectedImage;
                                              filenameServiceAreaPelayanan1 =
                                                  basename(
                                                      imageServiceAreaPelayanan1
                                                          .path);

                                              StorageReference
                                              strRef =
                                              FirebaseStorage
                                                  .instance
                                                  .ref()
                                                  .child(
                                                  filenameServiceAreaPelayanan1);
                                              StorageUploadTask
                                              uploadTask =
                                              strRef.putFile(
                                                  imageServiceAreaPelayanan1);

                                              var downUrl =
                                              await (await uploadTask
                                                  .onComplete)
                                                  .ref
                                                  .getDownloadURL();
                                              var url = downUrl
                                                  .toString();

                                              setState(() {
                                                imageServiceAreaPelayanan =
                                                    filenameServiceAreaPelayanan1;
                                                imageServiceAreaPelayananBantu =
                                                    imageServiceAreaPelayanan1;
                                                imageServiceAreaPelayananSave = url;

                                                print(imageServiceAreaPelayanan);
                                                print(imageServiceAreaPelayananBantu);
                                                print(imageServiceAreaPelayananSave);
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                ListView(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    children: List.generate(pertanyaanServiceAreaPelayanan.length, (index) {
                                      indexServiceAreaPelayanan = index;
                                      String counter = (index + 1).toString();
                                      if (scoreServiceAreaPelayanan.length <
                                          jumlahServiceAreaPelayanan) {
                                        for (int a = 0;
                                        a < jumlahServiceAreaPelayanan;
                                        a++) {
                                          scoreServiceAreaPelayanan.add(2);

                                          warnaServiceAreaPelayanan.add('hijau');
                                        }
                                      }

                                      return Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                width: 180.0,
                                                child: Row(
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        '${counter + '. ' + pertanyaanServiceAreaPelayanan[index]}',
                                                        style: TextStyle(
                                                            color: Colors.black54,
                                                            fontSize: 14.0),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 120.0,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaServiceAreaPelayanan.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaServiceAreaPelayanan[index] ==
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
                                                            'NO',
                                                            style:
                                                            TextStyle(
                                                              fontSize:
                                                              18.0,
                                                              color: warnaServiceAreaPelayanan.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  255,
                                                                  40,
                                                                  0)
                                                                  : warnaServiceAreaPelayanan[index] ==
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
                                                          color: warnaServiceAreaPelayanan
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaServiceAreaPelayanan[index] ==
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
                                                              scoreServiceAreaPelayanan
                                                                  .removeAt(
                                                                  index);
                                                              scoreServiceAreaPelayanan
                                                                  .insert(
                                                                  index,
                                                                  0);
                                                              warnaServiceAreaPelayanan
                                                                  .removeAt(
                                                                  index);
                                                              warnaServiceAreaPelayanan
                                                                  .insert(
                                                                  index,
                                                                  'merah');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                    ),
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaServiceAreaPelayanan.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaServiceAreaPelayanan[index] ==
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
                                                            'OK',
                                                            style: TextStyle(
                                                                fontSize:
                                                                18.0,
                                                                color: warnaServiceAreaPelayanan.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    50,
                                                                    205,
                                                                    50)
                                                                    : warnaServiceAreaPelayanan[index] == 'hijau'
                                                                    ? Colors.white
                                                                    : Color.fromARGB(170, 50, 205, 50)),
                                                            textAlign:
                                                            TextAlign
                                                                .center,
                                                          ),
                                                          color: warnaServiceAreaPelayanan
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaServiceAreaPelayanan[index] ==
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
                                                              scoreServiceAreaPelayanan
                                                                  .removeAt(
                                                                  index);
                                                              scoreServiceAreaPelayanan
                                                                  .insert(
                                                                  index,
                                                                  2);
                                                              warnaServiceAreaPelayanan
                                                                  .removeAt(
                                                                  index);
                                                              warnaServiceAreaPelayanan
                                                                  .insert(
                                                                  index,
                                                                  'hijau');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      );
                                    })
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Divider(
                                    height: 1.0,
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 180.0,
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Keamanan / Pencegahan Kehilangan',
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14.0),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 120.0,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'FOLLOW UP',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14.0),
                                            ),
                                          ),
                                          imageKeamananPelayanan != null
                                              ? IconButton(
                                            icon: Icon(
                                                Icons.disc_full,
                                                color:
                                                Colors.grey),
                                            onPressed: () {},
                                            tooltip:
                                            'You have uploaded',
                                          ) :
                                          IconButton(
                                            icon: Icon(
                                                Icons.camera_alt,
                                                color: AbubaPallate
                                                    .greenabuba),
                                            onPressed: () async {
                                              var selectedImage =
                                              await ImagePicker
                                                  .pickImage(
                                                  source:
                                                  ImageSource.camera);
                                              imageKeamananPelayanan1 =
                                                  selectedImage;
                                              filenameKeamananPelayanan1 =
                                                  basename(
                                                      imageKeamananPelayanan1
                                                          .path);

                                              StorageReference
                                              strRef =
                                              FirebaseStorage
                                                  .instance
                                                  .ref()
                                                  .child(
                                                  filenameKeamananPelayanan1);
                                              StorageUploadTask
                                              uploadTask =
                                              strRef.putFile(
                                                  imageKeamananPelayanan1);

                                              var downUrl =
                                              await (await uploadTask
                                                  .onComplete)
                                                  .ref
                                                  .getDownloadURL();
                                              var url = downUrl
                                                  .toString();

                                              setState(() {
                                                imageKeamananPelayanan =
                                                    filenameKeamananPelayanan1;
                                                imageKeamananPelayananBantu =
                                                    imageKeamananPelayanan1;
                                                imageKeamananPelayananSave = url;

                                                print(imageKeamananPelayanan);
                                                print(imageKeamananPelayananBantu);
                                                print(imageKeamananPelayananSave);
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                ListView(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    children: List.generate(pertanyaanKeamananPelayanan.length, (index) {
                                      indexKeamananPelayanan = index;
                                      String counter = (index + 1).toString();
                                      if (scoreKeamananPelayanan.length <
                                          jumlahKeamananPelayanan) {
                                        for (int a = 0;
                                        a < jumlahKeamananPelayanan;
                                        a++) {
                                          scoreKeamananPelayanan.add(2);

                                          warnaKeamananPelayanan.add('hijau');
                                        }
                                      }

                                      return Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                width: 180.0,
                                                child: Row(
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        '${counter + '. ' + pertanyaanKeamananPelayanan[index]}',
                                                        style: TextStyle(
                                                            color: Colors.black54,
                                                            fontSize: 14.0),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 120.0,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaKeamananPelayanan.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaKeamananPelayanan[index] ==
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
                                                            'NO',
                                                            style:
                                                            TextStyle(
                                                              fontSize:
                                                              18.0,
                                                              color: warnaKeamananPelayanan.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  255,
                                                                  40,
                                                                  0)
                                                                  : warnaKeamananPelayanan[index] ==
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
                                                          color: warnaKeamananPelayanan
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaKeamananPelayanan[index] ==
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
                                                              scoreKeamananPelayanan
                                                                  .removeAt(
                                                                  index);
                                                              scoreKeamananPelayanan
                                                                  .insert(
                                                                  index,
                                                                  0);
                                                              warnaKeamananPelayanan
                                                                  .removeAt(
                                                                  index);
                                                              warnaKeamananPelayanan
                                                                  .insert(
                                                                  index,
                                                                  'merah');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                    ),
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaKeamananPelayanan.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaKeamananPelayanan[index] ==
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
                                                            'OK',
                                                            style: TextStyle(
                                                                fontSize:
                                                                18.0,
                                                                color: warnaKeamananPelayanan.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    50,
                                                                    205,
                                                                    50)
                                                                    : warnaKeamananPelayanan[index] == 'hijau'
                                                                    ? Colors.white
                                                                    : Color.fromARGB(170, 50, 205, 50)),
                                                            textAlign:
                                                            TextAlign
                                                                .center,
                                                          ),
                                                          color: warnaKeamananPelayanan
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaKeamananPelayanan[index] ==
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
                                                              scoreKeamananPelayanan
                                                                  .removeAt(
                                                                  index);
                                                              scoreKeamananPelayanan
                                                                  .insert(
                                                                  index,
                                                                  2);
                                                              warnaKeamananPelayanan
                                                                  .removeAt(
                                                                  index);
                                                              warnaKeamananPelayanan
                                                                  .insert(
                                                                  index,
                                                                  'hijau');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment: Alignment(0.0, 0.0),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      );
                                    })
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Divider(
                                    height: 1.0,
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 180.0,
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Kesiapanan Bisnis',
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16.0),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 120.0,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'FOLLOW UP',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14.0),
                                            ),
                                          ),
                                          imageKesiapanBisnis != null
                                              ? IconButton(
                                            icon: Icon(
                                                Icons.disc_full,
                                                color:
                                                Colors.grey),
                                            onPressed: () {},
                                            tooltip:
                                            'You have uploaded',
                                          ) :
                                          IconButton(
                                            icon: Icon(
                                                Icons.camera_alt,
                                                color: AbubaPallate
                                                    .greenabuba),
                                            onPressed: () async {
                                              var selectedImage =
                                              await ImagePicker
                                                  .pickImage(
                                                  source:
                                                  ImageSource.camera);
                                              imageKesiapanBisnis1 =
                                                  selectedImage;
                                              filenameKesiapanBisnis1 =
                                                  basename(
                                                      imageKesiapanBisnis1
                                                          .path);

                                              StorageReference
                                              strRef =
                                              FirebaseStorage
                                                  .instance
                                                  .ref()
                                                  .child(
                                                  filenameKesiapanBisnis1);
                                              StorageUploadTask
                                              uploadTask =
                                              strRef.putFile(
                                                  imageKesiapanBisnis1);

                                              var downUrl =
                                              await (await uploadTask
                                                  .onComplete)
                                                  .ref
                                                  .getDownloadURL();
                                              var url = downUrl
                                                  .toString();

                                              setState(() {
                                                imageKesiapanBisnis =
                                                    filenameKesiapanBisnis1;
                                                imageKesiapanBisnisBantu =
                                                    imageKesiapanBisnis1;
                                                imageKesiapanBisnisSave = url;

                                                print(imageKesiapanBisnis);
                                                print(imageKesiapanBisnisBantu);
                                                print(imageKesiapanBisnisSave);
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                ListView(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    children: List.generate(pertanyaanKesiapanBisnis.length, (index) {
                                      indexKesiapanBisnis = index;
                                      String counter = (index + 1).toString();
                                      if (scoreKesiapanBisnis.length <
                                          jumlahKesiapanBisnis) {
                                        for (int a = 0;
                                        a < jumlahKesiapanBisnis;
                                        a++) {
                                          scoreKesiapanBisnis.add(2);

                                          warnaKesiapanBisnis.add('hijau');
                                        }
                                      }

                                      return Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                width: 180.0,
                                                child: Row(
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        '${counter + '. ' + pertanyaanKesiapanBisnis[index]}',
                                                        style: TextStyle(
                                                            color: Colors.black54,
                                                            fontSize: 14.0),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 120.0,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaKesiapanBisnis.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaKesiapanBisnis[index] ==
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
                                                            'NO',
                                                            style:
                                                            TextStyle(
                                                              fontSize:
                                                              18.0,
                                                              color: warnaKesiapanBisnis.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  255,
                                                                  40,
                                                                  0)
                                                                  : warnaKesiapanBisnis[index] ==
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
                                                          color: warnaKesiapanBisnis
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaKesiapanBisnis[index] ==
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
                                                              scoreKesiapanBisnis
                                                                  .removeAt(
                                                                  index);
                                                              scoreKesiapanBisnis
                                                                  .insert(
                                                                  index,
                                                                  0);
                                                              warnaKesiapanBisnis
                                                                  .removeAt(
                                                                  index);
                                                              warnaKesiapanBisnis
                                                                  .insert(
                                                                  index,
                                                                  'merah');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                    ),
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaKesiapanBisnis.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaKesiapanBisnis[index] ==
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
                                                            'OK',
                                                            style: TextStyle(
                                                                fontSize:
                                                                18.0,
                                                                color: warnaKesiapanBisnis.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    50,
                                                                    205,
                                                                    50)
                                                                    : warnaKesiapanBisnis[index] == 'hijau'
                                                                    ? Colors.white
                                                                    : Color.fromARGB(170, 50, 205, 50)),
                                                            textAlign:
                                                            TextAlign
                                                                .center,
                                                          ),
                                                          color: warnaKesiapanBisnis
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaKesiapanBisnis[index] ==
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
                                                              scoreKesiapanBisnis
                                                                  .removeAt(
                                                                  index);
                                                              scoreKesiapanBisnis
                                                                  .insert(
                                                                  index,
                                                                  2);
                                                              warnaKesiapanBisnis
                                                                  .removeAt(
                                                                  index);
                                                              warnaKesiapanBisnis
                                                                  .insert(
                                                                  index,
                                                                  'hijau');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      );
                                    })
                                ),
                              ],
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
                                            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                                            onPressed: () {
                                              _cardController.animateTo(_cardController.index - 1);
                                            },
                                            tooltip: 'Previous',
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.arrow_forward_ios,
                                                color: Colors.white),
                                            onPressed: () {
                                              _cardController.animateTo(
                                                  _cardController.index + 1);
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
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Area Cook',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0),
                                        textAlign: TextAlign.start,
                                      ),
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
                        return Scrollbar(
                          child: animationController.isAnimating ? Center (
                            child: Container(
                              child: CircularProgressIndicator(),
                              alignment: Alignment(0.0, 0.0),
                              height: MediaQuery.of(context).size.height * 0.736,
                            ),
                          ) : Container(
                            /*height: MediaQuery.of(context).size.height * 0.648,*/
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            height: MediaQuery.of(context).size.height * 0.736,
                            color: Colors.white,
                            child: ListView(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 180.0,
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Steak',
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16.0),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 120.0,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'FOLLOW UP',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14.0),
                                            ),
                                          ),
                                          imageSteakCook != null
                                              ? IconButton(
                                            icon: Icon(
                                                Icons.disc_full,
                                                color:
                                                Colors.grey),
                                            onPressed: () {},
                                            tooltip:
                                            'You have uploaded',
                                          ) :
                                          IconButton(
                                            icon: Icon(
                                                Icons.camera_alt,
                                                color: AbubaPallate
                                                    .greenabuba),
                                            onPressed: () async {
                                              var selectedImage =
                                              await ImagePicker
                                                  .pickImage(
                                                  source:
                                                  ImageSource.camera);
                                              imageSteakCook1 =
                                                  selectedImage;
                                              filenameSteakCook1 =
                                                  basename(
                                                      imageSteakCook1
                                                          .path);

                                              StorageReference
                                              strRef =
                                              FirebaseStorage
                                                  .instance
                                                  .ref()
                                                  .child(
                                                  filenameSteakCook1);
                                              StorageUploadTask
                                              uploadTask =
                                              strRef.putFile(
                                                  imageSteakCook1);

                                              var downUrl =
                                              await (await uploadTask
                                                  .onComplete)
                                                  .ref
                                                  .getDownloadURL();
                                              var url = downUrl
                                                  .toString();

                                              setState(() {
                                                imageSteakCook =
                                                    filenameSteakCook1;
                                                imageSteakCookBantu =
                                                    imageSteakCook1;
                                                imageSteakCookSave = url;

                                                print(imageSteakCook);
                                                print(imageSteakCookBantu);
                                                print(imageSteakCookSave);
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                ListView(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    children: List.generate(pertanyaanSteakCook.length, (index) {
                                      indexSteakCook = index;
                                      String counter = (index + 1).toString();
                                      if (scoreSteakCook.length <
                                          jumlahSteakCook) {
                                        for (int a = 0;
                                        a < jumlahSteakCook;
                                        a++) {
                                          scoreSteakCook.add(2);

                                          warnaSteakCook.add('hijau');
                                        }
                                      }

                                      return Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                width: 180.0,
                                                child: Row(
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        '${counter + '. ' + pertanyaanSteakCook[index]}',
                                                        style: TextStyle(
                                                            color: Colors.black54,
                                                            fontSize: 14.0),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 120.0,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaSteakCook.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaSteakCook[index] ==
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
                                                            'NO',
                                                            style:
                                                            TextStyle(
                                                              fontSize:
                                                              18.0,
                                                              color: warnaSteakCook.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  255,
                                                                  40,
                                                                  0)
                                                                  : warnaSteakCook[index] ==
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
                                                          color: warnaSteakCook
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaSteakCook[index] ==
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
                                                              scoreSteakCook
                                                                  .removeAt(
                                                                  index);
                                                              scoreSteakCook
                                                                  .insert(
                                                                  index,
                                                                  0);
                                                              warnaSteakCook
                                                                  .removeAt(
                                                                  index);
                                                              warnaSteakCook
                                                                  .insert(
                                                                  index,
                                                                  'merah');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                    ),
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaSteakCook.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaSteakCook[index] ==
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
                                                            'OK',
                                                            style: TextStyle(
                                                                fontSize:
                                                                18.0,
                                                                color: warnaSteakCook.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    50,
                                                                    205,
                                                                    50)
                                                                    : warnaSteakCook[index] == 'hijau'
                                                                    ? Colors.white
                                                                    : Color.fromARGB(170, 50, 205, 50)),
                                                            textAlign:
                                                            TextAlign
                                                                .center,
                                                          ),
                                                          color: warnaSteakCook
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaSteakCook[index] ==
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
                                                              scoreSteakCook
                                                                  .removeAt(
                                                                  index);
                                                              scoreSteakCook
                                                                  .insert(
                                                                  index,
                                                                  2);
                                                              warnaSteakCook
                                                                  .removeAt(
                                                                  index);
                                                              warnaSteakCook
                                                                  .insert(
                                                                  index,
                                                                  'hijau');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      );
                                    })
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Divider(
                                    height: 1.0,
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 180.0,
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Batter Mix (Spicy / Original)',
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16.0),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 120.0,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'FOLLOW UP',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14.0),
                                            ),
                                          ),
                                          imageBatterMixCook != null
                                              ? IconButton(
                                            icon: Icon(
                                                Icons.disc_full,
                                                color:
                                                Colors.grey),
                                            onPressed: () {},
                                            tooltip:
                                            'You have uploaded',
                                          ) :
                                          IconButton(
                                            icon: Icon(
                                                Icons.camera_alt,
                                                color: AbubaPallate
                                                    .greenabuba),
                                            onPressed: () async {
                                              var selectedImage =
                                              await ImagePicker
                                                  .pickImage(
                                                  source:
                                                  ImageSource.camera);
                                              imageBatterMixCook1 =
                                                  selectedImage;
                                              filenameBatterMixCook1 =
                                                  basename(
                                                      imageBatterMixCook1
                                                          .path);

                                              StorageReference
                                              strRef =
                                              FirebaseStorage
                                                  .instance
                                                  .ref()
                                                  .child(
                                                  filenameBatterMixCook1);
                                              StorageUploadTask
                                              uploadTask =
                                              strRef.putFile(
                                                  imageBatterMixCook1);

                                              var downUrl =
                                              await (await uploadTask
                                                  .onComplete)
                                                  .ref
                                                  .getDownloadURL();
                                              var url = downUrl
                                                  .toString();

                                              setState(() {
                                                imageBatterMixCook =
                                                    filenameBatterMixCook1;
                                                imageBatterMixCookBantu =
                                                    imageBatterMixCook1;
                                                imageBatterMixCookSave = url;

                                                print(imageBatterMixCook);
                                                print(imageBatterMixCookBantu);
                                                print(imageBatterMixCookSave);
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                ListView(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    children: List.generate(pertanyaanBatterMixCook.length, (index) {
                                      indexBatterMixCook = index;
                                      String counter = (index + 1).toString();
                                      if (scoreBatterMixCook.length <
                                          jumlahBatterMixCook) {
                                        for (int a = 0;
                                        a < jumlahBatterMixCook;
                                        a++) {
                                          scoreBatterMixCook.add(2);

                                          warnaBatterMixCook.add('hijau');
                                        }
                                      }

                                      return Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                width: 180.0,
                                                child: Row(
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        '${counter + '. ' + pertanyaanBatterMixCook[index]}',
                                                        style: TextStyle(
                                                            color: Colors.black54,
                                                            fontSize: 14.0),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 120.0,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaBatterMixCook.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaBatterMixCook[index] ==
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
                                                            'NO',
                                                            style:
                                                            TextStyle(
                                                              fontSize:
                                                              18.0,
                                                              color: warnaBatterMixCook.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  255,
                                                                  40,
                                                                  0)
                                                                  : warnaBatterMixCook[index] ==
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
                                                          color: warnaBatterMixCook
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaBatterMixCook[index] ==
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
                                                              scoreBatterMixCook
                                                                  .removeAt(
                                                                  index);
                                                              scoreBatterMixCook
                                                                  .insert(
                                                                  index,
                                                                  0);
                                                              warnaBatterMixCook
                                                                  .removeAt(
                                                                  index);
                                                              warnaBatterMixCook
                                                                  .insert(
                                                                  index,
                                                                  'merah');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                    ),
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaBatterMixCook.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaBatterMixCook[index] ==
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
                                                            'OK',
                                                            style: TextStyle(
                                                                fontSize:
                                                                18.0,
                                                                color: warnaBatterMixCook.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    50,
                                                                    205,
                                                                    50)
                                                                    : warnaBatterMixCook[index] == 'hijau'
                                                                    ? Colors.white
                                                                    : Color.fromARGB(170, 50, 205, 50)),
                                                            textAlign:
                                                            TextAlign
                                                                .center,
                                                          ),
                                                          color: warnaBatterMixCook
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaBatterMixCook[index] ==
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
                                                              scoreBatterMixCook
                                                                  .removeAt(
                                                                  index);
                                                              scoreBatterMixCook
                                                                  .insert(
                                                                  index,
                                                                  2);
                                                              warnaBatterMixCook
                                                                  .removeAt(
                                                                  index);
                                                              warnaBatterMixCook
                                                                  .insert(
                                                                  index,
                                                                  'hijau');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      );
                                    })
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Divider(
                                    height: 1.0,
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 180.0,
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Mix Vegetables',
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14.0),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 120.0,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'FOLLOW UP',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14.0),
                                            ),
                                          ),
                                          imageMixVegetablesCook != null
                                              ? IconButton(
                                            icon: Icon(
                                                Icons.disc_full,
                                                color:
                                                Colors.grey),
                                            onPressed: () {},
                                            tooltip:
                                            'You have uploaded',
                                          ) :
                                          IconButton(
                                            icon: Icon(
                                                Icons.camera_alt,
                                                color: AbubaPallate
                                                    .greenabuba),
                                            onPressed: () async {
                                              var selectedImage =
                                              await ImagePicker
                                                  .pickImage(
                                                  source:
                                                  ImageSource.camera);
                                              imageMixVegetablesCook1 =
                                                  selectedImage;
                                              filenameMixVegetablesCook1 =
                                                  basename(
                                                      imageMixVegetablesCook1
                                                          .path);

                                              StorageReference
                                              strRef =
                                              FirebaseStorage
                                                  .instance
                                                  .ref()
                                                  .child(
                                                  filenameMixVegetablesCook1);
                                              StorageUploadTask
                                              uploadTask =
                                              strRef.putFile(
                                                  imageMixVegetablesCook1);

                                              var downUrl =
                                              await (await uploadTask
                                                  .onComplete)
                                                  .ref
                                                  .getDownloadURL();
                                              var url = downUrl
                                                  .toString();

                                              setState(() {
                                                imageMixVegetablesCook =
                                                    filenameMixVegetablesCook1;
                                                imageMixVegetablesCookBantu =
                                                    imageMixVegetablesCook1;
                                                imageMixVegetablesCookSave = url;

                                                print(imageMixVegetablesCook);
                                                print(imageMixVegetablesCookBantu);
                                                print(imageMixVegetablesCookSave);
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                ListView(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    children: List.generate(pertanyaanMixVegetablesCook.length, (index) {
                                      indexMixVegetablesCook = index;
                                      String counter = (index + 1).toString();
                                      if (scoreMixVegetablesCook.length <
                                          jumlahMixVegetablesCook) {
                                        for (int a = 0;
                                        a < jumlahMixVegetablesCook;
                                        a++) {
                                          scoreMixVegetablesCook.add(2);

                                          warnaMixVegetablesCook.add('hijau');
                                        }
                                      }

                                      return Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                width: 180.0,
                                                child: Row(
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        '${counter + '. ' + pertanyaanMixVegetablesCook[index]}',
                                                        style: TextStyle(
                                                            color: Colors.black54,
                                                            fontSize: 14.0),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 120.0,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaMixVegetablesCook.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaMixVegetablesCook[index] ==
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
                                                            'NO',
                                                            style:
                                                            TextStyle(
                                                              fontSize:
                                                              18.0,
                                                              color: warnaMixVegetablesCook.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  255,
                                                                  40,
                                                                  0)
                                                                  : warnaMixVegetablesCook[index] ==
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
                                                          color: warnaMixVegetablesCook
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaMixVegetablesCook[index] ==
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
                                                              scoreMixVegetablesCook
                                                                  .removeAt(
                                                                  index);
                                                              scoreMixVegetablesCook
                                                                  .insert(
                                                                  index,
                                                                  0);
                                                              warnaMixVegetablesCook
                                                                  .removeAt(
                                                                  index);
                                                              warnaMixVegetablesCook
                                                                  .insert(
                                                                  index,
                                                                  'merah');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                    ),
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaMixVegetablesCook.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaMixVegetablesCook[index] ==
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
                                                            'OK',
                                                            style: TextStyle(
                                                                fontSize:
                                                                18.0,
                                                                color: warnaMixVegetablesCook.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    50,
                                                                    205,
                                                                    50)
                                                                    : warnaMixVegetablesCook[index] == 'hijau'
                                                                    ? Colors.white
                                                                    : Color.fromARGB(170, 50, 205, 50)),
                                                            textAlign:
                                                            TextAlign
                                                                .center,
                                                          ),
                                                          color: warnaMixVegetablesCook
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaMixVegetablesCook[index] ==
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
                                                              scoreMixVegetablesCook
                                                                  .removeAt(
                                                                  index);
                                                              scoreMixVegetablesCook
                                                                  .insert(
                                                                  index,
                                                                  2);
                                                              warnaMixVegetablesCook
                                                                  .removeAt(
                                                                  index);
                                                              warnaMixVegetablesCook
                                                                  .insert(
                                                                  index,
                                                                  'hijau');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment: Alignment(0.0, 0.0),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      );
                                    })
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Divider(
                                    height: 1.0,
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 180.0,
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Potato Wedges',
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16.0),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 120.0,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'FOLLOW UP',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14.0),
                                            ),
                                          ),
                                          imagePotatoCook != null
                                              ? IconButton(
                                            icon: Icon(
                                                Icons.disc_full,
                                                color:
                                                Colors.grey),
                                            onPressed: () {},
                                            tooltip:
                                            'You have uploaded',
                                          ) :
                                          IconButton(
                                            icon: Icon(
                                                Icons.camera_alt,
                                                color: AbubaPallate
                                                    .greenabuba),
                                            onPressed: () async {
                                              var selectedImage =
                                              await ImagePicker
                                                  .pickImage(
                                                  source:
                                                  ImageSource.camera);
                                              imagePotatoCook1 =
                                                  selectedImage;
                                              filenamePotatoCook1 =
                                                  basename(
                                                      imagePotatoCook1
                                                          .path);

                                              StorageReference
                                              strRef =
                                              FirebaseStorage
                                                  .instance
                                                  .ref()
                                                  .child(
                                                  filenamePotatoCook1);
                                              StorageUploadTask
                                              uploadTask =
                                              strRef.putFile(
                                                  imagePotatoCook1);

                                              var downUrl =
                                              await (await uploadTask
                                                  .onComplete)
                                                  .ref
                                                  .getDownloadURL();
                                              var url = downUrl
                                                  .toString();

                                              setState(() {
                                                imagePotatoCook =
                                                    filenamePotatoCook1;
                                                imagePotatoCookBantu =
                                                    imagePotatoCook1;
                                                imagePotatoCookSave = url;

                                                print(imagePotatoCook);
                                                print(imagePotatoCookBantu);
                                                print(imagePotatoCookSave);
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                ListView(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    children: List.generate(pertanyaanPotatoCook.length, (index) {
                                      indexPotatoCook = index;
                                      String counter = (index + 1).toString();
                                      if (scorePotatoCook.length <
                                          jumlahPotatoCook) {
                                        for (int a = 0;
                                        a < jumlahPotatoCook;
                                        a++) {
                                          scorePotatoCook.add(2);

                                          warnaPotatoCook.add('hijau');
                                        }
                                      }

                                      return Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                width: 180.0,
                                                child: Row(
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        '${counter + '. ' + pertanyaanPotatoCook[index]}',
                                                        style: TextStyle(
                                                            color: Colors.black54,
                                                            fontSize: 14.0),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 120.0,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaPotatoCook.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaPotatoCook[index] ==
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
                                                            'NO',
                                                            style:
                                                            TextStyle(
                                                              fontSize:
                                                              18.0,
                                                              color: warnaPotatoCook.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  255,
                                                                  40,
                                                                  0)
                                                                  : warnaPotatoCook[index] ==
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
                                                          color: warnaPotatoCook
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaPotatoCook[index] ==
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
                                                              scorePotatoCook
                                                                  .removeAt(
                                                                  index);
                                                              scorePotatoCook
                                                                  .insert(
                                                                  index,
                                                                  0);
                                                              warnaPotatoCook
                                                                  .removeAt(
                                                                  index);
                                                              warnaPotatoCook
                                                                  .insert(
                                                                  index,
                                                                  'merah');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                    ),
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaPotatoCook.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaPotatoCook[index] ==
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
                                                            'OK',
                                                            style: TextStyle(
                                                                fontSize:
                                                                18.0,
                                                                color: warnaPotatoCook.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    50,
                                                                    205,
                                                                    50)
                                                                    : warnaPotatoCook[index] == 'hijau'
                                                                    ? Colors.white
                                                                    : Color.fromARGB(170, 50, 205, 50)),
                                                            textAlign:
                                                            TextAlign
                                                                .center,
                                                          ),
                                                          color: warnaPotatoCook
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaPotatoCook[index] ==
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
                                                              scorePotatoCook
                                                                  .removeAt(
                                                                  index);
                                                              scorePotatoCook
                                                                  .insert(
                                                                  index,
                                                                  2);
                                                              warnaPotatoCook
                                                                  .removeAt(
                                                                  index);
                                                              warnaPotatoCook
                                                                  .insert(
                                                                  index,
                                                                  'hijau');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      );
                                    })
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Divider(
                                    height: 1.0,
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 180.0,
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Griller',
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16.0),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 120.0,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'FOLLOW UP',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14.0),
                                            ),
                                          ),
                                          imageGrillerCook != null
                                              ? IconButton(
                                            icon: Icon(
                                                Icons.disc_full,
                                                color:
                                                Colors.grey),
                                            onPressed: () {},
                                            tooltip:
                                            'You have uploaded',
                                          ) :
                                          IconButton(
                                            icon: Icon(
                                                Icons.camera_alt,
                                                color: AbubaPallate
                                                    .greenabuba),
                                            onPressed: () async {
                                              var selectedImage =
                                              await ImagePicker
                                                  .pickImage(
                                                  source:
                                                  ImageSource.camera);
                                              imageGrillerCook1 =
                                                  selectedImage;
                                              filenameGrillerCook1 =
                                                  basename(
                                                      imageGrillerCook1
                                                          .path);

                                              StorageReference
                                              strRef =
                                              FirebaseStorage
                                                  .instance
                                                  .ref()
                                                  .child(
                                                  filenameGrillerCook1);
                                              StorageUploadTask
                                              uploadTask =
                                              strRef.putFile(
                                                  imageGrillerCook1);

                                              var downUrl =
                                              await (await uploadTask
                                                  .onComplete)
                                                  .ref
                                                  .getDownloadURL();
                                              var url = downUrl
                                                  .toString();

                                              setState(() {
                                                imageGrillerCook =
                                                    filenameGrillerCook1;
                                                imageGrillerCookBantu =
                                                    imageGrillerCook1;
                                                imageGrillerCookSave = url;

                                                print(imageGrillerCook);
                                                print(imageGrillerCookBantu);
                                                print(imageGrillerCookSave);
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                ListView(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    children: List.generate(pertanyaanGrillerCook.length, (index) {
                                      indexGrillerCook = index;
                                      String counter = (index + 1).toString();
                                      if (scoreGrillerCook.length <
                                          jumlahGrillerCook) {
                                        for (int a = 0;
                                        a < jumlahGrillerCook;
                                        a++) {
                                          scoreGrillerCook.add(2);

                                          warnaGrillerCook.add('hijau');
                                        }
                                      }

                                      return Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                width: 180.0,
                                                child: Row(
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        '${counter + '. ' + pertanyaanGrillerCook[index]}',
                                                        style: TextStyle(
                                                            color: Colors.black54,
                                                            fontSize: 14.0),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 120.0,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaGrillerCook.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaGrillerCook[index] ==
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
                                                            'NO',
                                                            style:
                                                            TextStyle(
                                                              fontSize:
                                                              18.0,
                                                              color: warnaGrillerCook.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  255,
                                                                  40,
                                                                  0)
                                                                  : warnaGrillerCook[index] ==
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
                                                          color: warnaGrillerCook
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaGrillerCook[index] ==
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
                                                              scoreGrillerCook
                                                                  .removeAt(
                                                                  index);
                                                              scoreGrillerCook
                                                                  .insert(
                                                                  index,
                                                                  0);
                                                              warnaGrillerCook
                                                                  .removeAt(
                                                                  index);
                                                              warnaGrillerCook
                                                                  .insert(
                                                                  index,
                                                                  'merah');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                    ),
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaGrillerCook.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaGrillerCook[index] ==
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
                                                            'OK',
                                                            style: TextStyle(
                                                                fontSize:
                                                                18.0,
                                                                color: warnaGrillerCook.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    50,
                                                                    205,
                                                                    50)
                                                                    : warnaGrillerCook[index] == 'hijau'
                                                                    ? Colors.white
                                                                    : Color.fromARGB(170, 50, 205, 50)),
                                                            textAlign:
                                                            TextAlign
                                                                .center,
                                                          ),
                                                          color: warnaGrillerCook
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaGrillerCook[index] ==
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
                                                              scoreGrillerCook
                                                                  .removeAt(
                                                                  index);
                                                              scoreGrillerCook
                                                                  .insert(
                                                                  index,
                                                                  2);
                                                              warnaGrillerCook
                                                                  .removeAt(
                                                                  index);
                                                              warnaGrillerCook
                                                                  .insert(
                                                                  index,
                                                                  'hijau');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      );
                                    })
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Divider(
                                    height: 1.0,
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 180.0,
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Penanganan Keamanan Makanan',
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16.0),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 120.0,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'FOLLOW UP',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14.0),
                                            ),
                                          ),
                                          imageKeamananMakananCook != null
                                              ? IconButton(
                                            icon: Icon(
                                                Icons.disc_full,
                                                color:
                                                Colors.grey),
                                            onPressed: () {},
                                            tooltip:
                                            'You have uploaded',
                                          ) :
                                          IconButton(
                                            icon: Icon(
                                                Icons.camera_alt,
                                                color: AbubaPallate
                                                    .greenabuba),
                                            onPressed: () async {
                                              var selectedImage =
                                              await ImagePicker
                                                  .pickImage(
                                                  source:
                                                  ImageSource.camera);
                                              imageKeamananMakananCook1 =
                                                  selectedImage;
                                              filenameKeamananMakananCook1 =
                                                  basename(
                                                      imageKeamananMakananCook1
                                                          .path);

                                              StorageReference
                                              strRef =
                                              FirebaseStorage
                                                  .instance
                                                  .ref()
                                                  .child(
                                                  filenameKeamananMakananCook1);
                                              StorageUploadTask
                                              uploadTask =
                                              strRef.putFile(
                                                  imageKeamananMakananCook1);

                                              var downUrl =
                                              await (await uploadTask
                                                  .onComplete)
                                                  .ref
                                                  .getDownloadURL();
                                              var url = downUrl
                                                  .toString();

                                              setState(() {
                                                imageKeamananMakananCook =
                                                    filenameKeamananMakananCook1;
                                                imageKeamananMakananCookBantu =
                                                    imageKeamananMakananCook1;
                                                imageKeamananMakananCookSave = url;

                                                print(imageKeamananMakananCook);
                                                print(imageKeamananMakananCookBantu);
                                                print(imageKeamananMakananCookSave);
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                ListView(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    children: List.generate(pertanyaanKeamananMakananCook.length, (index) {
                                      indexKeamananMakananCook = index;
                                      String counter = (index + 1).toString();
                                      if (scoreKeamananMakananCook.length <
                                          jumlahKeamananMakananCook) {
                                        for (int a = 0;
                                        a < jumlahKeamananMakananCook;
                                        a++) {
                                          scoreKeamananMakananCook.add(2);

                                          warnaKeamananMakananCook.add('hijau');
                                        }
                                      }

                                      return Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                width: 180.0,
                                                child: Row(
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        '${counter + '. ' + pertanyaanKeamananMakananCook[index]}',
                                                        style: TextStyle(
                                                            color: Colors.black54,
                                                            fontSize: 14.0),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 120.0,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaKeamananMakananCook.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaKeamananMakananCook[index] ==
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
                                                            'NO',
                                                            style:
                                                            TextStyle(
                                                              fontSize:
                                                              18.0,
                                                              color: warnaKeamananMakananCook.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  255,
                                                                  40,
                                                                  0)
                                                                  : warnaKeamananMakananCook[index] ==
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
                                                          color: warnaKeamananMakananCook
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaKeamananMakananCook[index] ==
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
                                                              scoreKeamananMakananCook
                                                                  .removeAt(
                                                                  index);
                                                              scoreKeamananMakananCook
                                                                  .insert(
                                                                  index,
                                                                  0);
                                                              warnaKeamananMakananCook
                                                                  .removeAt(
                                                                  index);
                                                              warnaKeamananMakananCook
                                                                  .insert(
                                                                  index,
                                                                  'merah');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                    ),
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaKeamananMakananCook.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaKeamananMakananCook[index] ==
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
                                                            'OK',
                                                            style: TextStyle(
                                                                fontSize:
                                                                18.0,
                                                                color: warnaKeamananMakananCook.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    50,
                                                                    205,
                                                                    50)
                                                                    : warnaKeamananMakananCook[index] == 'hijau'
                                                                    ? Colors.white
                                                                    : Color.fromARGB(170, 50, 205, 50)),
                                                            textAlign:
                                                            TextAlign
                                                                .center,
                                                          ),
                                                          color: warnaKeamananMakananCook
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaKeamananMakananCook[index] ==
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
                                                              scoreKeamananMakananCook
                                                                  .removeAt(
                                                                  index);
                                                              scoreKeamananMakananCook
                                                                  .insert(
                                                                  index,
                                                                  2);
                                                              warnaKeamananMakananCook
                                                                  .removeAt(
                                                                  index);
                                                              warnaKeamananMakananCook
                                                                  .insert(
                                                                  index,
                                                                  'hijau');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      );
                                    })
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Divider(
                                    height: 1.0,
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 180.0,
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Cook Area',
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16.0),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 120.0,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'FOLLOW UP',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14.0),
                                            ),
                                          ),
                                          imageAreaCook != null
                                              ? IconButton(
                                            icon: Icon(
                                                Icons.disc_full,
                                                color:
                                                Colors.grey),
                                            onPressed: () {},
                                            tooltip:
                                            'You have uploaded',
                                          ) :
                                          IconButton(
                                            icon: Icon(
                                                Icons.camera_alt,
                                                color: AbubaPallate
                                                    .greenabuba),
                                            onPressed: () async {
                                              var selectedImage =
                                              await ImagePicker
                                                  .pickImage(
                                                  source:
                                                  ImageSource.camera);
                                              imageAreaCook1 =
                                                  selectedImage;
                                              filenameAreaCook1 =
                                                  basename(
                                                      imageAreaCook1
                                                          .path);

                                              StorageReference
                                              strRef =
                                              FirebaseStorage
                                                  .instance
                                                  .ref()
                                                  .child(
                                                  filenameAreaCook1);
                                              StorageUploadTask
                                              uploadTask =
                                              strRef.putFile(
                                                  imageAreaCook1);

                                              var downUrl =
                                              await (await uploadTask
                                                  .onComplete)
                                                  .ref
                                                  .getDownloadURL();
                                              var url = downUrl
                                                  .toString();

                                              setState(() {
                                                imageAreaCook =
                                                    filenameAreaCook1;
                                                imageAreaCookBantu =
                                                    imageAreaCook1;
                                                imageAreaCookSave = url;

                                                print(imageAreaCook);
                                                print(imageAreaCookBantu);
                                                print(imageAreaCookSave);
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                ListView(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    children: List.generate(pertanyaanAreaCook.length, (index) {
                                      indexAreaCook = index;
                                      String counter = (index + 1).toString();
                                      if (scoreAreaCook.length <
                                          jumlahAreaCook) {
                                        for (int a = 0;
                                        a < jumlahAreaCook;
                                        a++) {
                                          scoreAreaCook.add(2);

                                          warnaAreaCook.add('hijau');
                                        }
                                      }

                                      return Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                width: 180.0,
                                                child: Row(
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        '${counter + '. ' + pertanyaanAreaCook[index]}',
                                                        style: TextStyle(
                                                            color: Colors.black54,
                                                            fontSize: 14.0),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 120.0,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaAreaCook.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaAreaCook[index] ==
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
                                                            'NO',
                                                            style:
                                                            TextStyle(
                                                              fontSize:
                                                              18.0,
                                                              color: warnaAreaCook.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  255,
                                                                  40,
                                                                  0)
                                                                  : warnaAreaCook[index] ==
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
                                                          color: warnaAreaCook
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaAreaCook[index] ==
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
                                                              scoreAreaCook
                                                                  .removeAt(
                                                                  index);
                                                              scoreAreaCook
                                                                  .insert(
                                                                  index,
                                                                  0);
                                                              warnaAreaCook
                                                                  .removeAt(
                                                                  index);
                                                              warnaAreaCook
                                                                  .insert(
                                                                  index,
                                                                  'merah');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                    ),
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaAreaCook.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaAreaCook[index] ==
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
                                                            'OK',
                                                            style: TextStyle(
                                                                fontSize:
                                                                18.0,
                                                                color: warnaAreaCook.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    50,
                                                                    205,
                                                                    50)
                                                                    : warnaAreaCook[index] == 'hijau'
                                                                    ? Colors.white
                                                                    : Color.fromARGB(170, 50, 205, 50)),
                                                            textAlign:
                                                            TextAlign
                                                                .center,
                                                          ),
                                                          color: warnaAreaCook
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaAreaCook[index] ==
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
                                                              scoreAreaCook
                                                                  .removeAt(
                                                                  index);
                                                              scoreAreaCook
                                                                  .insert(
                                                                  index,
                                                                  2);
                                                              warnaAreaCook
                                                                  .removeAt(
                                                                  index);
                                                              warnaAreaCook
                                                                  .insert(
                                                                  index,
                                                                  'hijau');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      );
                                    })
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Divider(
                                    height: 1.0,
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 180.0,
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Kitchen Equipment',
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16.0),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 120.0,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'FOLLOW UP',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14.0),
                                            ),
                                          ),
                                          imageKitchenCook != null
                                              ? IconButton(
                                            icon: Icon(
                                                Icons.disc_full,
                                                color:
                                                Colors.grey),
                                            onPressed: () {},
                                            tooltip:
                                            'You have uploaded',
                                          ) :
                                          IconButton(
                                            icon: Icon(
                                                Icons.camera_alt,
                                                color: AbubaPallate
                                                    .greenabuba),
                                            onPressed: () async {
                                              var selectedImage =
                                              await ImagePicker
                                                  .pickImage(
                                                  source:
                                                  ImageSource.camera);
                                              imageKitchenCook1 =
                                                  selectedImage;
                                              filenameKitchenCook1 =
                                                  basename(
                                                      imageKitchenCook1
                                                          .path);

                                              StorageReference
                                              strRef =
                                              FirebaseStorage
                                                  .instance
                                                  .ref()
                                                  .child(
                                                  filenameKitchenCook1);
                                              StorageUploadTask
                                              uploadTask =
                                              strRef.putFile(
                                                  imageKitchenCook1);

                                              var downUrl =
                                              await (await uploadTask
                                                  .onComplete)
                                                  .ref
                                                  .getDownloadURL();
                                              var url = downUrl
                                                  .toString();

                                              setState(() {
                                                imageKitchenCook =
                                                    filenameKitchenCook1;
                                                imageKitchenCookBantu =
                                                    imageKitchenCook1;
                                                imageKitchenCookSave = url;

                                                print(imageKitchenCook);
                                                print(imageKitchenCookBantu);
                                                print(imageKitchenCookSave);
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                ListView(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    children: List.generate(pertanyaanKitchenCook.length, (index) {
                                      indexKitchenCook = index;
                                      String counter = (index + 1).toString();
                                      if (scoreKitchenCook.length <
                                          jumlahKitchenCook) {
                                        for (int a = 0;
                                        a < jumlahKitchenCook;
                                        a++) {
                                          scoreKitchenCook.add(2);

                                          warnaKitchenCook.add('hijau');
                                        }
                                      }

                                      return Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                width: 180.0,
                                                child: Row(
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        '${counter + '. ' + pertanyaanKitchenCook[index]}',
                                                        style: TextStyle(
                                                            color: Colors.black54,
                                                            fontSize: 14.0),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 120.0,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaKitchenCook.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaKitchenCook[index] ==
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
                                                            'NO',
                                                            style:
                                                            TextStyle(
                                                              fontSize:
                                                              18.0,
                                                              color: warnaKitchenCook.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  255,
                                                                  40,
                                                                  0)
                                                                  : warnaKitchenCook[index] ==
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
                                                          color: warnaKitchenCook
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaKitchenCook[index] ==
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
                                                              scoreKitchenCook
                                                                  .removeAt(
                                                                  index);
                                                              scoreKitchenCook
                                                                  .insert(
                                                                  index,
                                                                  0);
                                                              warnaKitchenCook
                                                                  .removeAt(
                                                                  index);
                                                              warnaKitchenCook
                                                                  .insert(
                                                                  index,
                                                                  'merah');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                    ),
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaKitchenCook.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaKitchenCook[index] ==
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
                                                            'OK',
                                                            style: TextStyle(
                                                                fontSize:
                                                                18.0,
                                                                color: warnaKitchenCook.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    50,
                                                                    205,
                                                                    50)
                                                                    : warnaKitchenCook[index] == 'hijau'
                                                                    ? Colors.white
                                                                    : Color.fromARGB(170, 50, 205, 50)),
                                                            textAlign:
                                                            TextAlign
                                                                .center,
                                                          ),
                                                          color: warnaKitchenCook
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaKitchenCook[index] ==
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
                                                              scoreKitchenCook
                                                                  .removeAt(
                                                                  index);
                                                              scoreKitchenCook
                                                                  .insert(
                                                                  index,
                                                                  2);
                                                              warnaKitchenCook
                                                                  .removeAt(
                                                                  index);
                                                              warnaKitchenCook
                                                                  .insert(
                                                                  index,
                                                                  'hijau');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      );
                                    })
                                ),
                              ],
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
                                            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                                            onPressed: () {
                                              _cardController.animateTo(_cardController.index - 1);
                                            },
                                            tooltip: 'Previous',
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.arrow_forward_ios,
                                                color: Colors.white),
                                            onPressed: () {
                                              _cardController.animateTo(
                                                  _cardController.index + 1);
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
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Area Back Wash / Storage',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0),
                                        textAlign: TextAlign.start,
                                      ),
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
                        return Scrollbar(
                          child: animationController.isAnimating ? Center (
                            child: Container(
                              child: CircularProgressIndicator(),
                              alignment: Alignment(0.0, 0.0),
                              height: MediaQuery.of(context).size.height * 0.736,
                            ),
                          ) : Container(
                            /*height: MediaQuery.of(context).size.height * 0.648,*/
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            height: MediaQuery.of(context).size.height * 0.736,
                            color: Colors.white,
                            child: ListView(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 180.0,
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Dishwasher Area',
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16.0),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 120.0,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'FOLLOW UP',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14.0),
                                            ),
                                          ),
                                          imageDishwasherWash != null
                                              ? IconButton(
                                            icon: Icon(
                                                Icons.disc_full,
                                                color:
                                                Colors.grey),
                                            onPressed: () {},
                                            tooltip:
                                            'You have uploaded',
                                          ) :
                                          IconButton(
                                            icon: Icon(
                                                Icons.camera_alt,
                                                color: AbubaPallate
                                                    .greenabuba),
                                            onPressed: () async {
                                              var selectedImage =
                                              await ImagePicker
                                                  .pickImage(
                                                  source:
                                                  ImageSource.camera);
                                              imageDishwasherWash1 =
                                                  selectedImage;
                                              filenameDishwasherWash1 =
                                                  basename(
                                                      imageDishwasherWash1
                                                          .path);

                                              StorageReference
                                              strRef =
                                              FirebaseStorage
                                                  .instance
                                                  .ref()
                                                  .child(
                                                  filenameDishwasherWash1);
                                              StorageUploadTask
                                              uploadTask =
                                              strRef.putFile(
                                                  imageDishwasherWash1);

                                              var downUrl =
                                              await (await uploadTask
                                                  .onComplete)
                                                  .ref
                                                  .getDownloadURL();
                                              var url = downUrl
                                                  .toString();

                                              setState(() {
                                                imageDishwasherWash =
                                                    filenameDishwasherWash1;
                                                imageDishwasherWashBantu =
                                                    imageDishwasherWash1;
                                                imageDishwasherWashSave = url;

                                                print(imageDishwasherWash);
                                                print(imageDishwasherWashBantu);
                                                print(imageDishwasherWashSave);
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                ListView(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    children: List.generate(pertanyaanDishwasherWash.length, (index) {
                                      indexDishwasherWash = index;
                                      String counter = (index + 1).toString();
                                      if (scoreDishwasherWash.length <
                                          jumlahDishwasherWash) {
                                        for (int a = 0;
                                        a < jumlahDishwasherWash;
                                        a++) {
                                          scoreDishwasherWash.add(2);

                                          warnaDishwasherWash.add('hijau');
                                        }
                                      }

                                      return Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                width: 180.0,
                                                child: Row(
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        '${counter + '. ' + pertanyaanDishwasherWash[index]}',
                                                        style: TextStyle(
                                                            color: Colors.black54,
                                                            fontSize: 14.0),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 120.0,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaDishwasherWash.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaDishwasherWash[index] ==
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
                                                            'NO',
                                                            style:
                                                            TextStyle(
                                                              fontSize:
                                                              18.0,
                                                              color: warnaDishwasherWash.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  255,
                                                                  40,
                                                                  0)
                                                                  : warnaDishwasherWash[index] ==
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
                                                          color: warnaDishwasherWash
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaDishwasherWash[index] ==
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
                                                              scoreDishwasherWash
                                                                  .removeAt(
                                                                  index);
                                                              scoreDishwasherWash
                                                                  .insert(
                                                                  index,
                                                                  0);
                                                              warnaDishwasherWash
                                                                  .removeAt(
                                                                  index);
                                                              warnaDishwasherWash
                                                                  .insert(
                                                                  index,
                                                                  'merah');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                    ),
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaDishwasherWash.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaDishwasherWash[index] ==
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
                                                            'OK',
                                                            style: TextStyle(
                                                                fontSize:
                                                                18.0,
                                                                color: warnaDishwasherWash.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    50,
                                                                    205,
                                                                    50)
                                                                    : warnaDishwasherWash[index] == 'hijau'
                                                                    ? Colors.white
                                                                    : Color.fromARGB(170, 50, 205, 50)),
                                                            textAlign:
                                                            TextAlign
                                                                .center,
                                                          ),
                                                          color: warnaDishwasherWash
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaDishwasherWash[index] ==
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
                                                              scoreDishwasherWash
                                                                  .removeAt(
                                                                  index);
                                                              scoreDishwasherWash
                                                                  .insert(
                                                                  index,
                                                                  2);
                                                              warnaDishwasherWash
                                                                  .removeAt(
                                                                  index);
                                                              warnaDishwasherWash
                                                                  .insert(
                                                                  index,
                                                                  'hijau');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      );
                                    })
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Divider(
                                    height: 1.0,
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 180.0,
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Chiller & Freezer',
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16.0),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 120.0,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'FOLLOW UP',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14.0),
                                            ),
                                          ),
                                          imageChillerWash != null
                                              ? IconButton(
                                            icon: Icon(
                                                Icons.disc_full,
                                                color:
                                                Colors.grey),
                                            onPressed: () {},
                                            tooltip:
                                            'You have uploaded',
                                          ) :
                                          IconButton(
                                            icon: Icon(
                                                Icons.camera_alt,
                                                color: AbubaPallate
                                                    .greenabuba),
                                            onPressed: () async {
                                              var selectedImage =
                                              await ImagePicker
                                                  .pickImage(
                                                  source:
                                                  ImageSource.camera);
                                              imageChillerWash1 =
                                                  selectedImage;
                                              filenameChillerWash1 =
                                                  basename(
                                                      imageChillerWash1
                                                          .path);

                                              StorageReference
                                              strRef =
                                              FirebaseStorage
                                                  .instance
                                                  .ref()
                                                  .child(
                                                  filenameChillerWash1);
                                              StorageUploadTask
                                              uploadTask =
                                              strRef.putFile(
                                                  imageChillerWash1);

                                              var downUrl =
                                              await (await uploadTask
                                                  .onComplete)
                                                  .ref
                                                  .getDownloadURL();
                                              var url = downUrl
                                                  .toString();

                                              setState(() {
                                                imageChillerWash =
                                                    filenameChillerWash1;
                                                imageChillerWashBantu =
                                                    imageChillerWash1;
                                                imageChillerWashSave = url;

                                                print(imageChillerWash);
                                                print(imageChillerWashBantu);
                                                print(imageChillerWashSave);
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                ListView(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    children: List.generate(pertanyaanChillerWash.length, (index) {
                                      indexChillerWash = index;
                                      String counter = (index + 1).toString();
                                      if (scoreChillerWash.length <
                                          jumlahChillerWash) {
                                        for (int a = 0;
                                        a < jumlahChillerWash;
                                        a++) {
                                          scoreChillerWash.add(2);

                                          warnaChillerWash.add('hijau');
                                        }
                                      }

                                      return Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                width: 180.0,
                                                child: Row(
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        '${counter + '. ' + pertanyaanChillerWash[index]}',
                                                        style: TextStyle(
                                                            color: Colors.black54,
                                                            fontSize: 14.0),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 120.0,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaChillerWash.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaChillerWash[index] ==
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
                                                            'NO',
                                                            style:
                                                            TextStyle(
                                                              fontSize:
                                                              18.0,
                                                              color: warnaChillerWash.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  255,
                                                                  40,
                                                                  0)
                                                                  : warnaChillerWash[index] ==
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
                                                          color: warnaChillerWash
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaChillerWash[index] ==
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
                                                              scoreChillerWash
                                                                  .removeAt(
                                                                  index);
                                                              scoreChillerWash
                                                                  .insert(
                                                                  index,
                                                                  0);
                                                              warnaChillerWash
                                                                  .removeAt(
                                                                  index);
                                                              warnaChillerWash
                                                                  .insert(
                                                                  index,
                                                                  'merah');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                    ),
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaChillerWash.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaChillerWash[index] ==
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
                                                            'OK',
                                                            style: TextStyle(
                                                                fontSize:
                                                                18.0,
                                                                color: warnaChillerWash.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    50,
                                                                    205,
                                                                    50)
                                                                    : warnaChillerWash[index] == 'hijau'
                                                                    ? Colors.white
                                                                    : Color.fromARGB(170, 50, 205, 50)),
                                                            textAlign:
                                                            TextAlign
                                                                .center,
                                                          ),
                                                          color: warnaChillerWash
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaChillerWash[index] ==
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
                                                              scoreChillerWash
                                                                  .removeAt(
                                                                  index);
                                                              scoreChillerWash
                                                                  .insert(
                                                                  index,
                                                                  2);
                                                              warnaChillerWash
                                                                  .removeAt(
                                                                  index);
                                                              warnaChillerWash
                                                                  .insert(
                                                                  index,
                                                                  'hijau');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      );
                                    })
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Divider(
                                    height: 1.0,
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 180.0,
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Penanganan Keamanan Makanan',
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14.0),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 120.0,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'FOLLOW UP',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14.0),
                                            ),
                                          ),
                                          imageKeamananWash != null
                                              ? IconButton(
                                            icon: Icon(
                                                Icons.disc_full,
                                                color:
                                                Colors.grey),
                                            onPressed: () {},
                                            tooltip:
                                            'You have uploaded',
                                          ) :
                                          IconButton(
                                            icon: Icon(
                                                Icons.camera_alt,
                                                color: AbubaPallate
                                                    .greenabuba),
                                            onPressed: () async {
                                              var selectedImage =
                                              await ImagePicker
                                                  .pickImage(
                                                  source:
                                                  ImageSource.camera);
                                              imageKeamananWash1 =
                                                  selectedImage;
                                              filenameKeamananWash1 =
                                                  basename(
                                                      imageKeamananWash1
                                                          .path);

                                              StorageReference
                                              strRef =
                                              FirebaseStorage
                                                  .instance
                                                  .ref()
                                                  .child(
                                                  filenameKeamananWash1);
                                              StorageUploadTask
                                              uploadTask =
                                              strRef.putFile(
                                                  imageKeamananWash1);

                                              var downUrl =
                                              await (await uploadTask
                                                  .onComplete)
                                                  .ref
                                                  .getDownloadURL();
                                              var url = downUrl
                                                  .toString();

                                              setState(() {
                                                imageKeamananWash =
                                                    filenameKeamananWash1;
                                                imageKeamananWashBantu =
                                                    imageKeamananWash1;
                                                imageKeamananWashSave = url;

                                                print(imageKeamananWash);
                                                print(imageKeamananWashBantu);
                                                print(imageKeamananWashSave);
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                ListView(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    children: List.generate(pertanyaanKeamananWash.length, (index) {
                                      indexKeamananWash = index;
                                      String counter = (index + 1).toString();
                                      if (scoreKeamananWash.length <
                                          jumlahKeamananWash) {
                                        for (int a = 0;
                                        a < jumlahKeamananWash;
                                        a++) {
                                          scoreKeamananWash.add(2);

                                          warnaKeamananWash.add('hijau');
                                        }
                                      }

                                      return Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                width: 180.0,
                                                child: Row(
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        '${counter + '. ' + pertanyaanKeamananWash[index]}',
                                                        style: TextStyle(
                                                            color: Colors.black54,
                                                            fontSize: 14.0),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 120.0,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaKeamananWash.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaKeamananWash[index] ==
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
                                                            'NO',
                                                            style:
                                                            TextStyle(
                                                              fontSize:
                                                              18.0,
                                                              color: warnaKeamananWash.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  255,
                                                                  40,
                                                                  0)
                                                                  : warnaKeamananWash[index] ==
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
                                                          color: warnaKeamananWash
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaKeamananWash[index] ==
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
                                                              scoreKeamananWash
                                                                  .removeAt(
                                                                  index);
                                                              scoreKeamananWash
                                                                  .insert(
                                                                  index,
                                                                  0);
                                                              warnaKeamananWash
                                                                  .removeAt(
                                                                  index);
                                                              warnaKeamananWash
                                                                  .insert(
                                                                  index,
                                                                  'merah');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                    ),
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaKeamananWash.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaKeamananWash[index] ==
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
                                                            'OK',
                                                            style: TextStyle(
                                                                fontSize:
                                                                18.0,
                                                                color: warnaKeamananWash.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    50,
                                                                    205,
                                                                    50)
                                                                    : warnaKeamananWash[index] == 'hijau'
                                                                    ? Colors.white
                                                                    : Color.fromARGB(170, 50, 205, 50)),
                                                            textAlign:
                                                            TextAlign
                                                                .center,
                                                          ),
                                                          color: warnaKeamananWash
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaKeamananWash[index] ==
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
                                                              scoreKeamananWash
                                                                  .removeAt(
                                                                  index);
                                                              scoreKeamananWash
                                                                  .insert(
                                                                  index,
                                                                  2);
                                                              warnaKeamananWash
                                                                  .removeAt(
                                                                  index);
                                                              warnaKeamananWash
                                                                  .insert(
                                                                  index,
                                                                  'hijau');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      );
                                    })
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Divider(
                                    height: 1.0,
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 180.0,
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Alat Keamanan',
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16.0),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 120.0,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'FOLLOW UP',
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14.0),
                                            ),
                                          ),
                                          imageAlatWash != null
                                              ? IconButton(
                                            icon: Icon(
                                                Icons.disc_full,
                                                color:
                                                Colors.grey),
                                            onPressed: () {},
                                            tooltip:
                                            'You have uploaded',
                                          ) :
                                          IconButton(
                                            icon: Icon(
                                                Icons.camera_alt,
                                                color: AbubaPallate
                                                    .greenabuba),
                                            onPressed: () async {
                                              var selectedImage =
                                              await ImagePicker
                                                  .pickImage(
                                                  source:
                                                  ImageSource.camera);
                                              imageAlatWash1 =
                                                  selectedImage;
                                              filenameAlatWash1 =
                                                  basename(
                                                      imageAlatWash1
                                                          .path);

                                              StorageReference
                                              strRef =
                                              FirebaseStorage
                                                  .instance
                                                  .ref()
                                                  .child(
                                                  filenameAlatWash1);
                                              StorageUploadTask
                                              uploadTask =
                                              strRef.putFile(
                                                  imageAlatWash1);

                                              var downUrl =
                                              await (await uploadTask
                                                  .onComplete)
                                                  .ref
                                                  .getDownloadURL();
                                              var url = downUrl
                                                  .toString();

                                              setState(() {
                                                imageAlatWash =
                                                    filenameAlatWash1;
                                                imageAlatWashBantu =
                                                    imageAlatWash1;
                                                imageAlatWashSave = url;

                                                print(imageAlatWash);
                                                print(imageAlatWashBantu);
                                                print(imageAlatWashSave);
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                ListView(
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    children: List.generate(pertanyaanAlatWash.length, (index) {
                                      indexAlatWash = index;
                                      String counter = (index + 1).toString();
                                      if (scoreAlatWash.length <
                                          jumlahAlatWash) {
                                        for (int a = 0;
                                        a < jumlahAlatWash;
                                        a++) {
                                          scoreAlatWash.add(2);

                                          warnaAlatWash.add('hijau');
                                        }
                                      }

                                      return Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                width: 180.0,
                                                child: Row(
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        '${counter + '. ' + pertanyaanAlatWash[index]}',
                                                        style: TextStyle(
                                                            color: Colors.black54,
                                                            fontSize: 14.0),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 120.0,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaAlatWash.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaAlatWash[index] ==
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
                                                            'NO',
                                                            style:
                                                            TextStyle(
                                                              fontSize:
                                                              18.0,
                                                              color: warnaAlatWash.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  255,
                                                                  40,
                                                                  0)
                                                                  : warnaAlatWash[index] ==
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
                                                          color: warnaAlatWash
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaAlatWash[index] ==
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
                                                              scoreAlatWash
                                                                  .removeAt(
                                                                  index);
                                                              scoreAlatWash
                                                                  .insert(
                                                                  index,
                                                                  0);
                                                              warnaAlatWash
                                                                  .removeAt(
                                                                  index);
                                                              warnaAlatWash
                                                                  .insert(
                                                                  index,
                                                                  'merah');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                    ),
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
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
                                                              color: warnaAlatWash.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaAlatWash[index] ==
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
                                                            'OK',
                                                            style: TextStyle(
                                                                fontSize:
                                                                18.0,
                                                                color: warnaAlatWash.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    50,
                                                                    205,
                                                                    50)
                                                                    : warnaAlatWash[index] == 'hijau'
                                                                    ? Colors.white
                                                                    : Color.fromARGB(170, 50, 205, 50)),
                                                            textAlign:
                                                            TextAlign
                                                                .center,
                                                          ),
                                                          color: warnaAlatWash
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaAlatWash[index] ==
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
                                                              scoreAlatWash
                                                                  .removeAt(
                                                                  index);
                                                              scoreAlatWash
                                                                  .insert(
                                                                  index,
                                                                  2);
                                                              warnaAlatWash
                                                                  .removeAt(
                                                                  index);
                                                              warnaAlatWash
                                                                  .insert(
                                                                  index,
                                                                  'hijau');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment:
                                                      Alignment(
                                                          0.0, 0.0),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      );
                                    })
                                ),
                              ],
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
                                            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                                            onPressed: () {
                                              _cardController.animateTo(_cardController.index - 1);
                                            },
                                            tooltip: 'Previous',
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.save,
                                                color: Colors.white),
                                            onPressed: () {
                                              DateTime done = DateTime.now();

                                              DocumentReference docReference = Firestore.instance.collection('dailychecklist').document();

                                              docReference.setData({
                                                'parkingLot_score': scoreParkingLobby,
                                                'dinningArea_score': scoreDinningAreaLobby,
                                                'restroom_score': scoreRestroomLobby,
                                                'grillArea_score': scoreGrillAreaDinning,
                                                'bar_score': scoreBarDinning,
                                                'production_score': scoreProductionDinning,
                                                'warehouse_score': scoreWarehouseDinning,
                                                'menuBoard_score': scoreMenuBoardPelayanan,
                                                'serviceArea_score': scoreServiceAreaPelayanan,
                                                'keamananPelayanan_score': scoreKeamananPelayanan,
                                                'kesiapanBisnis_score': scoreKesiapanBisnis,
                                                'steak_score': scoreSteakCook,
                                                'batterMix_score': scoreBatterMixCook,
                                                'mixVegetables_score': scoreMixVegetablesCook,
                                                'potatoWedges_score': scorePotatoCook,
                                                'griller_score': scoreGrillerCook,
                                                'keamananCook_score': scoreKeamananMakananCook,
                                                'cookArea_score': scoreAreaCook,
                                                'kitchenEquipment_score': scoreKitchenCook,
                                                'dishwasherArea_score': scoreDishwasherWash,
                                                'chiller_score': scoreChillerWash,
                                                'keamananWash_score': scoreKeamananWash,
                                                'alatKeamanan_score': scoreAlatWash,

                                                'parkingLot_pertanyaan': pertanyaanParkingLobby,
                                                'dinningArea_pertanyaan': pertanyaanDinningAreaLobby,
                                                'restroom_pertanyaan': pertanyaanRestroomLobby,
                                                'grillArea_pertanyaan': pertanyaanGrillAreaDinning,
                                                'bar_pertanyaan': pertanyaanBarDinning,
                                                'production_pertanyaan': pertanyaanProductionDinning,
                                                'warehouse_pertanyaan': pertanyaanWarehouseDinning,
                                                'menuBoard_pertanyaan': pertanyaanMenuBoardPelayanan,
                                                'serviceArea_pertanyaan': pertanyaanServiceAreaPelayanan,
                                                'keamananPelayanan_pertanyaan': pertanyaanKeamananPelayanan,
                                                'kesiapanBisnis_pertanyaan': pertanyaanKesiapanBisnis,
                                                'steak_pertanyaan': pertanyaanSteakCook,
                                                'batterMix_pertanyaan': pertanyaanBatterMixCook,
                                                'mixVegetables_pertanyaan': pertanyaanMixVegetablesCook,
                                                'potatoWedges_pertanyaan': pertanyaanPotatoCook,
                                                'griller_pertanyaan': pertanyaanGrillerCook,
                                                'keamananCook_pertanyaan': pertanyaanKeamananMakananCook,
                                                'cookArea_pertanyaan': pertanyaanAreaCook,
                                                'kitchenEquipment_pertanyaan': pertanyaanKitchenCook,
                                                'dishwasherArea_pertanyaan': pertanyaanDishwasherWash,
                                                'chiller_pertanyaan': pertanyaanChillerWash,
                                                'keamananWash_pertanyaan': pertanyaanKeamananWash,
                                                'alatKeamanan_pertanyaan': pertanyaanAlatWash,

                                                'parkingLot_image': imageParkingLobbySave,
                                                'dinningArea_image': imageDinningAreaLobbySave,
                                                'restroom_image': imageRestroomLobbySave,
                                                'grillArea_image': imageGrillAreaDinningSave,
                                                'bar_image': imageBarDinningSave,
                                                'production_image': imageProductionDinningSave,
                                                'warehouse_image': imageWarehouseDinningSave,
                                                'menuBoard_image': imageMenuBoardPelayananSave,
                                                'serviceArea_image': imageServiceAreaPelayananSave,
                                                'keamananPelayanan_image': imageKeamananPelayananSave,
                                                'kesiapanBisnis_image': imageKesiapanBisnisSave,
                                                'steak_image': imageSteakCookSave,
                                                'batterMix_image': imageBatterMixCookSave,
                                                'mixVegetables_image': imageMixVegetablesCookSave,
                                                'potatoWedges_image': imagePotatoCookSave,
                                                'griller_image': imageGrillerCookSave,
                                                'keamananCook_image': imageKeamananMakananCookSave,
                                                'cookArea_image': imageAreaCookSave,
                                                'kitchenEquipment_image': imageKitchenCookSave,
                                                'dishwasherArea_image': imageDishwasherWashSave,
                                                'chiller_image': imageChillerWashSave,
                                                'keamananWash_image': imageKeamananWashSave,
                                                'alatKeamanan_image': imageAlatWashSave,
                                                'timeDone': done,
                                              }).then((doc) {
                                                /*finalAreaLuar = hasilAreaLuar *
                                                      bobotBantuAreaLuar;*/
                                                print(docReference.documentID);
                                              }).catchError((error) {
                                                print(error);
                                              });

                                              showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder:
                                                      (context) => Dialog(
                                                    child: Container(
                                                      height: 180.0,
                                                      child: Column(
                                                        children: <
                                                            Widget>[
                                                          Container(
                                                            color: AbubaPallate
                                                                .greenabuba,
                                                            height:
                                                            50.0,
                                                            child:
                                                            Center(
                                                              child:
                                                              Text(
                                                                'SUCCESSFUL!',
                                                                style: TextStyle(
                                                                    color: Colors.white,
                                                                    fontSize: 17.0,
                                                                    fontWeight: FontWeight.w700),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height:
                                                            20.0,
                                                          ),
                                                          Container(
                                                            padding: EdgeInsets.symmetric(
                                                                horizontal:
                                                                10.0,
                                                                vertical:
                                                                10.0),
                                                            child:
                                                            Text(
                                                              'Create Success',
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
                                                                child:
                                                                Text('OK'),
                                                                onPressed:
                                                                    () {
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
                                                //print('success');
                                              });
                                            },
                                            tooltip: 'Save',
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
