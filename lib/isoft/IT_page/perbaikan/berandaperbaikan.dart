import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/isoft/IT_page/perbaikan/detail_workingOrder.dart';
import 'package:flutter_abuba/isoft/IT_page/perbaikan/form_perbaikan.dart';
import 'package:flutter_abuba/isoft/IT_page/perbaikan/openStatus.dart';
import 'package:flutter_abuba/isoft/IT_page/perbaikan/report_perbaikan.dart';
import 'package:flutter_abuba/isoft/IT_page/perbaikan/verifikasi.dart';
import 'package:flutter_abuba/isoft/IT_page/perbaikan/working_order.dart';
import 'package:flutter/services.dart';

class BerandaPerbaikan extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  BerandaPerbaikan({this.idUser, this.namaUser, this.departmentUser});

  @override
  _BerandaPerbaikanState createState() => _BerandaPerbaikanState();
}

class _BerandaPerbaikanState extends State<BerandaPerbaikan> with TickerProviderStateMixin {
  AnimationController animationController;
  final _scaffoldState = GlobalKey<ScaffoldState>();
  List<dynamic> itemMaintenance = [];
  bool preCreate = false;

  Future<bool> _onWillPop() {
    Navigator.pop(context);
    /*SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Color(0xfff9f9f9), //
    ));*/
    return null;
  }

  String jabatan;
  bool showNotifPerbaikanWO = false;
  List<String> areaWO = [];
  List<String> lokasiWO = [];
  List<String> itemWO = [];
  List<String> itemNoWO = [];
  List<String> tanggalWO = [];
  List<String> categoryWO = [];
  var indexx = [];

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(
      from: animationController.value == 0.0
        ? 1.0
        : animationController.value
    );

    Firestore.instance.collection('user').where('id', isEqualTo: widget.idUser).snapshots().listen((data) {
      setState(() {
        jabatan = data.documents[0].data['grade'];
      });
    });

    CollectionReference reference14 = Firestore.instance.collection('perbaikanIT');
    reference14.where('status', isEqualTo: 'NOT READY').snapshots().listen((querySnapshot14) {
      querySnapshot14.documentChanges.forEach((change14) {
        setState(() {
          showNotifPerbaikanWO = true;

          itemWO.add(change14.document.data['item']);
          itemNoWO.add(change14.document.data['itemNo']);
          Timestamp bantu = change14.document.data['dateCreated'];
          tanggalWO.add(bantu.toDate().toString().substring(8, 10) + '/' + bantu.toDate().toString().substring(5, 7) + '/' +bantu.toDate().toString().substring(0, 4));
          indexx.add(change14.document.documentID);

          Firestore.instance.collection('perbaikanCategory').where('id', isEqualTo: change14.document.data['category']).snapshots().listen((data) {
            categoryWO.add(data.documents[0].data['category']);
          });

          Firestore.instance.collection('outlet').where('id', isEqualTo: change14.document.data['area']).snapshots().listen((data2) {
            areaWO.add(data2.documents[0].data['nama_outlet']);
          });

          Firestore.instance.collection('lokasi').where('id', isEqualTo: change14.document.data['lokasi']).snapshots().listen((data3) {
            lokasiWO.add(data3.documents[0].data['lokasi']);
          });
        });
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Color(0xff239d6d),
      ),
      child: SafeArea(
        child: WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
            backgroundColor: Color(0xff239d6d),
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            key: _scaffoldState,
            body: _buildLogMenu(),
          ),
        ),
      ),
    );
  }

  Widget _buildLogMenu() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bgabuba.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: AnimatedBuilder(
        animation: animationController,
        builder: (_, Widget child) {
          return animationController.isAnimating
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : ListView(
                children: <Widget>[
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: <Widget>[
                  //     IconButton(
                  //       onPressed: _onWillPop,
                  //       icon: Icon(Icons.arrow_back, color: Colors.white),
                  //     ),
                  //     /*SizedBox(
                  //                   width: 10.0,
                  //                 ),
                  //                 Flexible(
                  //                   child: Text('Maintenance', style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w600),)
                  //                 )*/
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 35.0,
                  // ),
                  Container(
                    margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            jabatan ?? 'Jabatan',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: new BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          child: Text(
                            jabatan != null
                              ? jabatan == 'Assistant Manager' || jabatan == 'Manager'
                                  ? 'Working Order'
                                  : 'Open Status'
                              : '-',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.26,
                      margin: EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: itemWO.length == 0
                              ? Container(
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    elevation: 2.0,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.80,
                                      height: MediaQuery.of(context).size.height * 0.60,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(right: 5.0),
                                            child: Text(
                                              'Tidak Ada Perbaikan Hari Ini',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: itemWO.length > 10 ? 11 : itemWO.length + 1,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    if (index < itemWO.length) {
                                      return Container(
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15.0),
                                          ),
                                          elevation: 2.0,
                                          child: Container(
                                            width: MediaQuery.of(context).size.width * 0.80,
                                            height: MediaQuery.of(context).size.height * 0.60,
                                            child: Column(
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Column(
                                                          children: <Widget>[
                                                            Padding(
                                                              padding: const EdgeInsets.only(left: 10.0, right: 5.0, bottom: 5.0),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                children: <Widget>[
                                                                  Icon(Icons.location_on, color: Colors.grey, size: 16.0),
                                                                  Flexible(
                                                                    child: Text(
                                                                      areaWO[index] + ' - ' + lokasiWO[index],
                                                                      style: TextStyle(
                                                                        fontSize: 14.0,
                                                                        fontWeight: FontWeight.w400,
                                                                        color: Colors.black87
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.only(left: 10.0, right: 5.0, bottom: 5.0),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                children: <Widget>[
                                                                  Flexible(
                                                                    child: Text(
                                                                      itemWO[index] + ' - #' + itemNoWO[index],
                                                                      style: TextStyle(
                                                                        fontSize: 16.0,
                                                                        fontWeight: FontWeight.w700,
                                                                        color: AbubaPallate.greenabuba
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                    padding: const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Column(
                                                            children: <Widget>[
                                                              Padding(
                                                                padding: const EdgeInsets.only(left: 10.0, right: 5.0, bottom: 5.0),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  children: <Widget>[
                                                                    Flexible(
                                                                      child: Text(
                                                                        'CATEGORY',
                                                                        style: TextStyle(
                                                                          fontSize: 15.0,
                                                                          fontWeight: FontWeight.w800,
                                                                          color: Colors.black54,
                                                                          letterSpacing: 1.0
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.only(left: 10.0, right: 5.0, bottom: 5.0),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  children: <Widget>[
                                                                    Flexible(
                                                                      child: Text(
                                                                        categoryWO[index],
                                                                        style: TextStyle(
                                                                          fontSize: 14.0,
                                                                          fontWeight: FontWeight.w500,
                                                                          color: Colors.black54,
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Flexible(
                                                          child: Column(
                                                            children: <Widget>[
                                                              Padding(
                                                                padding: const EdgeInsets.only(left: 10.0, right: 5.0, bottom: 5.0),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                  children: <Widget>[
                                                                    Flexible(
                                                                      child: Text(
                                                                        'DATE REQUEST',
                                                                        style: TextStyle(
                                                                          fontSize: 15.0,
                                                                          fontWeight: FontWeight.w800,
                                                                          color: Colors.black54,
                                                                          letterSpacing: 1.0
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.only(left: 10.0, right: 5.0, bottom: 5.0),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                  children: <Widget>[
                                                                    Flexible(
                                                                      child: Text(
                                                                        tanggalWO[index],
                                                                        style: TextStyle(
                                                                          fontSize: 14.0,
                                                                          fontWeight: FontWeight.w500,
                                                                          color: Colors.black54,
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 3.0, top: 5.0),
                                                  child: Divider(
                                                    height: 3.0,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Container(
                                                        width: MediaQuery.of(context).size.width * 0.5,
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: <Widget>[
                                                            ButtonTheme(
                                                              minWidth: MediaQuery.of(context).size.width * 0.15,
                                                              height: 30.0,
                                                              child: OutlineButton(
                                                                child: Row(
                                                                  children: <Widget>[
                                                                    Container(
                                                                      width: MediaQuery.of(context).size.width * 0.15,
                                                                      alignment: Alignment.center,
                                                                      child: Text(
                                                                        'Detail',
                                                                        style: TextStyle(
                                                                          fontSize: 13.0,
                                                                          color: AbubaPallate.menuBluebird,
                                                                          fontWeight: FontWeight.bold
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                borderSide: BorderSide(
                                                                  color: Colors.transparent,
                                                                  width: 2.0
                                                                ),
                                                                highlightedBorderColor: Colors.transparent,
                                                                splashColor: Colors.white,
                                                                onPressed: () {
                                                                  Navigator.push(context,
                                                                    MaterialPageRoute(
                                                                      builder: (_) => DetailWorkingOrder(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser, index: indexx[index])
                                                                    )
                                                                  );
                                                                },
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(context,
                                            MaterialPageRoute(
                                              builder: (_) => WorkingOrder(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)
                                            )
                                          );
                                        },
                                        child: Container(
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15.0),
                                            ),
                                            elevation: 2.0,
                                            child: Container(
                                              width: MediaQuery.of(context).size.width * 0.80,
                                              height: MediaQuery.of(context).size.height * 0.60,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding: EdgeInsets.only(right: 5.0),
                                                        child: Text(
                                                          'MORE',
                                                          style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight: FontWeight.bold
                                                          ),
                                                        ),
                                                      ),
                                                      Icon(Icons.arrow_forward_ios, size: 18.0)
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 0.0),
                          child: Text(
                            "Perbaikan",
                            style: TextStyle(
                                color: Colors.black38, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(
                          child: new Container(
                              margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                              child: Divider(
                                color: Colors.black38,
                                height: 2,
                              )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15.0),
                    height: 330.0,
                    child: GridView.count(
                      crossAxisCount: 3,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            if (preCreate == false) {
                              preCreate = true;
                              itemMaintenance = [];

                              CollectionReference ref2 =
                                  Firestore.instance.collection('maintenance_IT');
                              ref2
                                  .orderBy('itemNo', descending: false)
                                  .snapshots()
                                  .listen((data2) {
                                data2.documentChanges.forEach((getData2) {
                                  setState(() {
                                    if (itemMaintenance.length == 0) {
                                      itemMaintenance.add(
                                          getData2.document.data['itemNo'] +
                                              ' - ' +
                                              getData2.document.data['item']);
                                    } else {
                                      if (itemMaintenance.contains(
                                          getData2.document.data['itemNo'] +
                                              ' - ' +
                                              getData2.document.data['item'])) {
                                      } else {
                                        itemMaintenance.add(
                                            getData2.document.data['itemNo'] +
                                                ' - ' +
                                                getData2.document.data['item']);
                                      }
                                    }
                                  });
                                });
                              });
                              await new Future.delayed(Duration(seconds: 2));
                              preCreate = false;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => FormPerbaikan(
                                          idUser: widget.idUser,
                                          namaUser: widget.namaUser,
                                          departmentUser: widget.departmentUser,
                                          itemMaintenance: itemMaintenance)));
                            } else {}
                          },
                          child: Column(
                            children: <Widget>[
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15.0),
                                    bottomRight: Radius.circular(15.0),
                                    topRight: Radius.circular(15.0),
                                    topLeft: Radius.circular(15.0),
                                  ),
                                ),
                                elevation: 1.0,
                                child: Container(
                                        width: MediaQuery.of(context).size.width * 0.17,
                                        margin: EdgeInsets.symmetric(vertical: 10.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            preCreate ? SizedBox(
                                              width: 30.0,
                                              height: 30.0,
                                              child:
                                              CircularProgressIndicator(strokeWidth: 1.5),
                                            ) : Image.asset(
                                              'assets/images/hrd/create new2.png',
                                              width: 30.0,
                                              height: 30.0,
                                            ),
                                          ],
                                        ),
                                      ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Create',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (_) => WorkingOrder(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)
                                )
                            );
                          },
                          child: Column(
                            children: <Widget>[
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15.0),
                                    bottomRight: Radius.circular(15.0),
                                    topRight: Radius.circular(15.0),
                                    topLeft: Radius.circular(15.0),
                                  ),
                                ),
                                elevation: 1.0,
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.17,
        //                              height: MediaQuery.of(context).size.width * 0.15,
                                  margin: EdgeInsets.symmetric(vertical: 10.0),
                                  child: Stack(
                                    overflow: Overflow.visible,
                                    children: <Widget>[
                                      Center(
                                        child: Image.asset(
                                          'assets/images/hrd/today task2.png',
                                          width: 30.0,
                                          height: 30.0,
                                        ),
                                      ),
                                      showNotifPerbaikanWO
                                        ? Positioned(
                                            top: -7.0,
                                            right: 0.0,
                                            child: Icon(
                                              Icons.brightness_1,
                                              size: 13.0,
                                              color: Colors.redAccent,
                                            ),
                                          )
                                        : Container(),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Working Order',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                MaterialPageRoute(
                                  builder: (_) => FormVerifikasi(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)
                                )
                              );
                            },
                          child: Column(
                            children: <Widget>[
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15.0),
                                    bottomRight: Radius.circular(15.0),
                                    topRight: Radius.circular(15.0),
                                    topLeft: Radius.circular(15.0),
                                  ),
                                ),
                                elevation: 1.0,
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.17,
        //                              height: MediaQuery.of(context).size.width * 0.15,
                                  margin: EdgeInsets.symmetric(vertical: 10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        'assets/images/hrd/verifikasi2.png',
                                        width: 30.0,
                                        height: 30.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Verifikasi',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),

                        GestureDetector(
                          onTap: () async {
                            Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (_) => OpenStatus(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)
                                )
                            );
                          },
                          child: Column(
                            children: <Widget>[
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15.0),
                                    bottomRight: Radius.circular(15.0),
                                    topRight: Radius.circular(15.0),
                                    topLeft: Radius.circular(15.0),
                                  ),
                                ),
                                elevation: 1.0,
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.17,
                                  margin: EdgeInsets.symmetric(vertical: 10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        'assets/images/hrd/open status2.png',
                                        width: 30.0,
                                        height: 30.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Open Status',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (_) => FormReport(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)
                                )
                            );
                          },
                          child: Column(
                            children: <Widget>[
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15.0),
                                    bottomRight: Radius.circular(15.0),
                                    topRight: Radius.circular(15.0),
                                    topLeft: Radius.circular(15.0),
                                  ),
                                ),
                                elevation: 1.0,
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.17,
        //                              height: MediaQuery.of(context).size.width * 0.15,
                                  margin: EdgeInsets.symmetric(vertical: 10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        'assets/images/hrd/report2.png',
                                        width: 30.0,
                                        height: 30.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Report',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
        },
      )
    );
  }
}
