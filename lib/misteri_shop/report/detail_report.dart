import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailReport extends StatefulWidget {
  final int idUser;
  final int user;
  final String outlet;
  var index;
  final String aksesStatus;

  List<dynamic> orderTimeDone;

  final double servingTimeGrafik;
  final double bobotServingTime;
  final List<dynamic> servingTimeNilai;
  final double parkingGrafik;
  final double bobotParking;
  final List<dynamic> parkingNilai;
  final double greetingGrafik;
  final double bobotGreeting;
  final List<dynamic> greetingNilai;
  final double seatingGrafik;
  final double bobotSeating;
  final List<dynamic> seatingNilai;
  final double takingOrderGrafik;
  final double bobotTakingOrder;
  final List<dynamic> takingOrderNilai;
  final double servingProductGrafik;
  final double bobotServingProduct;
  final List<dynamic> servingProductNilai;
  final double cleanlinessGrafik;
  final double bobotCleanliness;
  final List<dynamic> cleanlinessNilai;
  final double preBushingGrafik;
  final double bobotPreBushing;
  final List<dynamic> preBushingNilai;
  final double billingGrafik;
  final double bobotBilling;
  final List<dynamic> billingNilai;
  final double thankingGrafik;
  final double bobotThanking;
  final List<dynamic> thankingNilai;
  final double complaintGrafik;
  final double bobotComplaint;
  final List<dynamic> complaintNilai;

  final double hasilGrafik;
  final List<dynamic> menuName;

  final List<dynamic> imageServingProduct;
  final List<dynamic> imageComplaint;
  final List<dynamic> imagePreBushing;
  final List<dynamic> imageCleanliness;
  final List<dynamic> imageParking;
  final List<dynamic> imageBilling;

  final List<dynamic> parkingNote;
  final List<dynamic> greetingNote;
  final List<dynamic> seatingNote;
  final List<dynamic> takingOrderNote;
  final List<dynamic> servingProductNote;
  final List<dynamic> billingNote;
  final List<dynamic> thankingNote;
  final List<dynamic> preBushingNote;
  final List<dynamic> cleanlinessNote;

  final String userName;
  final String tanggal;
  final String waktuStart;
  final String waktuEnd;
  final List<dynamic> complaintNote;
  final String category;
  final String product;
  final String service;
  final String serviceNote;
  final String pic;
  final String complaint;

  DetailReport({this.user, this.outlet, this.servingTimeGrafik, this.bobotServingTime, this.servingTimeNilai, this.parkingGrafik, this.parkingNilai, this.bobotParking, this.greetingGrafik, this.greetingNilai, this.bobotGreeting, this.seatingGrafik, this.seatingNilai, this.bobotSeating, this.takingOrderGrafik, this.takingOrderNilai, this.bobotTakingOrder, this.servingProductGrafik, this.servingProductNilai, this.bobotServingProduct, this.cleanlinessGrafik, this.cleanlinessNilai, this.bobotCleanliness, this.preBushingGrafik, this.preBushingNilai, this.bobotPreBushing, this.billingGrafik, this.billingNilai, this.bobotBilling, this.thankingGrafik, this.thankingNilai, this.bobotThanking, this.complaintGrafik, this.complaintNilai, this.bobotComplaint, this.userName, this.tanggal, this.waktuStart, this.waktuEnd, this.complaintNote, this.category, this.product, this.service, this.serviceNote, this.pic, this.complaint, this.parkingNote, this.billingNote, this.cleanlinessNote, this.greetingNote, this.preBushingNote, this.seatingNote, this.servingProductNote, this.takingOrderNote, this.thankingNote, this.index, this.idUser, this.imageServingProduct, this.imageCleanliness, this.imageComplaint, this.imageParking, this.imagePreBushing, this.imageBilling, this.orderTimeDone, this.hasilGrafik, this.aksesStatus, this.menuName});

  @override
  _DetailReportState createState() => _DetailReportState();
}

class _DetailReportState extends State<DetailReport> {
  final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();

  bool _gambarParking = false;
  bool _gambarServingProduct = false;
  bool _gambarPreBushing = false;
  bool _gambarCleanliness = false;
  bool _gambarBilling = false;
  bool _gambarComplaint = false;
  bool _catatanParking = false;
  bool _catatanGreeting = false;
  bool _catatanTakingOrder = false;
  bool _catatanSeating = false;
  bool _catatanServingProduct = false;
  bool _catatanComplaint = false;
  bool _catatanBilling = false;
  bool _catatanThanking = false;
  bool _catatanPreBushing = false;
  bool _catatanCleanliness = false;

  double hasilKedua = 0;
  Color colorGrafik = Colors.green;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<FirebaseUser> getUser() async {
    return await _auth.currentUser();
  }

  @override
  Widget build(BuildContext context) {
    final double size = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: widget.aksesStatus == 'mg'
          ? AppBar(
              elevation: 0.25,
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black),
              automaticallyImplyLeading: false,
              actions: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: ButtonTheme(
                    minWidth: 50.0,
                    height: 40.0,
                    child: RaisedButton(
                      elevation: 0.0,
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
                      child: Text(
                        'Finish & Sign Out',
                        style:
                        TextStyle(fontSize: 13.0, color: Colors.black87),
                      ),
                      color: Colors.grey[300],
                      onPressed: () {
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
                                        'THANK YOU!',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                    child: Text(
                                      'Your review data has been stored by our system',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      FlatButton(
                                        child: Text('OK'),
                                        onPressed: () async {
                                          await _auth.signOut().then((_) {
                                            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                                          });
                                        },
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        );
                      },
                    )
                  ),
                )
              ],
              title: Image.asset(
                'assets/images/logo2.png',
                height: 100.0,
                width: 120.0,
              ),
            )
          : AppBar(
              elevation: 0.25,
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black),
              title: Image.asset(
                'assets/images/logo2.png',
                height: 100.0,
                width: 120.0,
              ),
            ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: _bodyForm(size, context),
        ),
      ),
    );
  }

  Widget _bodyForm(double size, BuildContext context) {
    if (widget.parkingGrafik == 1 && widget.greetingGrafik == 1 && widget.seatingGrafik == 1 && widget.takingOrderGrafik == 1 && widget.servingProductGrafik == 1 && widget.servingTimeGrafik == 1 && widget.cleanlinessGrafik == 1 && widget.preBushingGrafik == 1 && widget.billingGrafik == 1 && widget.thankingGrafik == 1 && widget.complaintGrafik == 1) {
      hasilKedua = 100.0;
    } else {
      hasilKedua = widget.hasilGrafik;
    }

    hasilKedua > 85.0 ? colorGrafik = Colors.green : hasilKedua < 70.0 ? colorGrafik = Colors.redAccent : colorGrafik = Colors.orangeAccent;

    return Scrollbar(
      child: ListView(
        shrinkWrap: true,
        physics: ScrollPhysics(),
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
          Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10.0, right: 15.0, left: 15.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              widget.outlet.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black54),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              widget.tanggal.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              widget.userName.toString(),
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 13.0),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              '${widget.waktuStart.toString()} - ${widget.waktuEnd.toString()}',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 13.0),
                            ),
                          ),
                        ],
                      )
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
                      holeLabel: hasilKedua >= 100.0 ? '100%' : '${hasilKedua.toString().substring(0,2)}%',
                      labelStyle: new TextStyle(
                        color: Colors.blueGrey[600],
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                ),
                ExpansionTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Parking',
                              style: TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.w700,
                                color: widget.parkingGrafik * 100 > 85.0 ? Colors.green : widget.parkingGrafik * 100 < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        StreamBuilder(
                          stream: Firestore.instance.collection('parking').snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData)
                              return Container(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            
                            return Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: LinearPercentIndicator(
                                    padding: const EdgeInsets.symmetric(horizontal: 17.0),
                                    width: MediaQuery.of(context).size.width,
                                    animation: true,
                                    lineHeight: 30.0,
                                    percent: widget.parkingGrafik * 100 > 100.0 ? 1.0 : widget.parkingGrafik,
                                    center: Text(
                                      widget.parkingGrafik * 100 >= 100.0 ? '100%' : '${(widget.parkingGrafik * 100).toString().substring(0, 2)}%'
                                    ),
                                    animationDuration: 1000,
                                    linearStrokeCap: LinearStrokeCap.butt,
                                    progressColor: widget.parkingGrafik * 100 > 85.0 ? Colors.green : widget.parkingGrafik * 100 < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                                  ),
                                ),
                                Column(
                                  children: List.generate(snapshot.data.documents[0].data['pertanyaan'].length, (index) {
                                    return ListTile(
                                      onTap: () {},
                                      title: Container(
                                        width: 250.0,
                                        child: Row(
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                '${index + 1}. ${snapshot.data.documents[0].data['pertanyaan'][index]}',
                                                style: TextStyle(color: Colors.black54, fontSize: 14.0),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      trailing: Container(
                                        width: 50.0,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                widget.parkingNilai[0][index].toString(),
                                                style: TextStyle(
                                                  color: widget.parkingNilai[0][index] == 0 ? Colors.redAccent : Colors.black54,
                                                  fontWeight: FontWeight.w700),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            );
                          },
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(17.0, 0.0, 17.0, 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _gambarParking = !_gambarParking;
                                    _catatanParking = false;
                                  });
                                },
                                child: Icon(Icons.image, color: widget.imageParking[0].length == 0 ? Colors.grey : AbubaPallate.menuBluebird),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _catatanParking = !_catatanParking;
                                    _gambarParking = false;
                                  });
                                },
                                child: Icon(Icons.note_add, color: widget.parkingNote[0].length == 0 ? Colors.grey : AbubaPallate.menuBluebird),
                              ),
                            ],
                          ),
                        ),
                        _gambarParking
                            ? widget.imageParking[0].length == 0
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
                                      children: List.generate(widget.imageParking[0].length, (index) {
                                        return GridTile(
                                          child: new Image.network(
                                            widget.imageParking[0][index].toString(),
                                            fit: BoxFit.cover
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  )
                            : Container(),
                        _catatanParking
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
                                              'Catatan',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Column(
                                        children: List.generate(widget.parkingNote[0].length, (index) {
                                          return widget.parkingNote[0][index] == ''
                                            ? Container()
                                            : Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      '- ${widget.parkingNote[0][index].toString()}',
                                                      style: TextStyle(
                                                        color: Colors.black38,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              );
                                        }).toList(),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Greeting',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w700,
                                  color: widget.greetingGrafik * 100 > 85.0 ? Colors.green : widget.greetingGrafik * 100 < 70.0 ? Colors.redAccent : Colors.orangeAccent,),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: LinearPercentIndicator(
                            padding: const EdgeInsets.symmetric(horizontal: 17.0),
                            width: MediaQuery.of(context).size.width,
                            animation: true,
                            lineHeight: 30.0,
                            percent: widget.greetingGrafik * 100 > 100.0 ? 1.0 : widget.greetingGrafik,
                            center: Text(
                              widget.greetingGrafik * 100 >= 100.0 ? '100%' : '${(widget.greetingGrafik * 100).toString().substring(0, 2)}%'
                            ),
                            animationDuration: 1000,
                            linearStrokeCap: LinearStrokeCap.butt,
                            progressColor: widget.greetingGrafik * 100 > 85.0 ? Colors.green : widget.greetingGrafik * 100 < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                          ),
                        ),
                        StreamBuilder(
                          stream: Firestore.instance.collection('greeting').snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData)
                              return Container(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            
                            return Column(
                              children: List.generate(snapshot.data.documents[0].data['pertanyaan'].length, (index) {
                                return ListTile(
                                  onTap: () {},
                                  title: Container(
                                    width: 250.0,
                                    child: Row(
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            '${index + 1}. ${snapshot.data.documents[0].data['pertanyaan'][index]}',
                                            style: TextStyle(color: Colors.black54, fontSize: 14.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  trailing: Container(
                                    width: 50.0,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            widget.greetingNilai[0][index].toString(),
                                            style: TextStyle(
                                              color: widget.greetingNilai[0][index] == 0 ? Colors.redAccent : Colors.black54,
                                              fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(17.0, 0.0, 17.0, 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _catatanGreeting = !_catatanGreeting;
                                  });
                                },
                                child: Icon(Icons.note_add, color: widget.greetingNote[0].length == 0 ? Colors.grey : AbubaPallate.menuBluebird),
                              ),
                            ],
                          ),
                        ),
                        _catatanGreeting
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
                                              'Catatan',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Column(
                                        children: List.generate(widget.greetingNote[0].length, (index) {
                                          return widget.greetingNote[0][index] == ''
                                            ? Container()
                                            : Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      '- ${widget.greetingNote[0][index].toString()}',
                                                      style: TextStyle(
                                                        color: Colors.black38,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              );
                                        }).toList(),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Seating',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w700,
                                  color: widget.seatingGrafik * 100 > 85.0 ? Colors.green : widget.seatingGrafik * 100 < 70.0 ? Colors.redAccent : Colors.orangeAccent,),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: LinearPercentIndicator(
                            padding: const EdgeInsets.symmetric(horizontal: 17.0),
                            width: MediaQuery.of(context).size.width,
                            animation: true,
                            lineHeight: 30.0,
                            percent: widget.seatingGrafik * 100 > 100.0 ? 1.0 : widget.seatingGrafik,
                            center: Text(
                              widget.seatingGrafik * 100 >= 100.0 ? '100%' : '${(widget.seatingGrafik* 100).toString().substring(0, 2)}%'
                            ),
                            animationDuration: 1000,
                            linearStrokeCap: LinearStrokeCap.butt,
                            progressColor: widget.seatingGrafik* 100 > 85.0 ? Colors.green : widget.seatingGrafik* 100 < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                          ),
                        ),
                        StreamBuilder(
                          stream: Firestore.instance.collection('seating').snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData)
                              return Container(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            
                            return Column(
                              children: List.generate(snapshot.data.documents[0].data['pertanyaan'].length, (index) {
                                return ListTile(
                                  onTap: () {},
                                  title: Container(
                                    width: 250.0,
                                    child: Row(
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            '${index + 1}. ${snapshot.data.documents[0].data['pertanyaan'][index]}',
                                            style: TextStyle(color: Colors.black54, fontSize: 14.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  trailing: Container(
                                    width: 50.0,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            widget.seatingNilai[0][index].toString(),
                                            style: TextStyle(
                                              color: widget.seatingNilai[0][index] == 0 ? Colors.redAccent : Colors.black54,
                                              fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(17.0, 0.0, 17.0, 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _catatanSeating = !_catatanSeating;
                                  });
                                },
                                child: Icon(Icons.note_add, color: widget.seatingNote[0].length == 0 ? Colors.grey : AbubaPallate.menuBluebird),
                              ),
                            ],
                          ),
                        ),
                        _catatanSeating
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
                                              'Catatan',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Column(
                                        children: List.generate(widget.seatingNote[0].length, (index) {
                                          return widget.seatingNote[0][index] == ''
                                            ? Container()
                                            : Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      '- ${widget.seatingNote[0][index].toString()}',
                                                      style: TextStyle(
                                                        color: Colors.black38,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              );
                                        }).toList(),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Taking Order',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w700,
                                  color: widget.takingOrderGrafik * 100 > 85.0 ? Colors.green : widget.takingOrderGrafik * 100 < 70.0 ? Colors.redAccent : Colors.orangeAccent,),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: LinearPercentIndicator(
                            padding: const EdgeInsets.symmetric(horizontal: 17.0),
                            width: MediaQuery.of(context).size.width,
                            animation: true,
                            lineHeight: 30.0,
                            percent: widget.takingOrderGrafik * 100 > 100.0 ? 1.0 : widget.takingOrderGrafik,
                            center: Text(
                              widget.takingOrderGrafik * 100 >= 100.0 ? '100%' : '${(widget.takingOrderGrafik * 100).toString().substring(0, 2)}%'
                            ),
                            animationDuration: 1000,
                            linearStrokeCap: LinearStrokeCap.butt,
                            progressColor: widget.takingOrderGrafik * 100 > 85.0 ? Colors.green : widget.takingOrderGrafik * 100 < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                          ),
                        ),
                        StreamBuilder(
                          stream: Firestore.instance.collection('takingOrder').snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData)
                              return Container(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            
                            return Column(
                              children: List.generate(snapshot.data.documents[0].data['pertanyaan'].length, (index) {
                                return ListTile(
                                  onTap: () {},
                                  title: Container(
                                    width: 250.0,
                                    child: Row(
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            '${index + 1}. ${snapshot.data.documents[0].data['pertanyaan'][index]}',
                                            style: TextStyle(color: Colors.black54, fontSize: 14.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  trailing: Container(
                                    width: 50.0,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            widget.takingOrderNilai[0][index].toString(),
                                            style: TextStyle(
                                              color: widget.takingOrderNilai[0][index] == 0 ? Colors.redAccent : Colors.black54,
                                              fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(17.0, 0.0, 17.0, 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _catatanTakingOrder = !_catatanTakingOrder;
                                  });
                                },
                                child: Icon(Icons.note_add, color: widget.takingOrderNote[0].length == 0 ? Colors.grey : AbubaPallate.menuBluebird),
                              ),
                            ],
                          ),
                        ),
                        _catatanTakingOrder
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
                                              'Catatan',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Column(
                                        children: List.generate(widget.takingOrderNote[0].length, (index) {
                                          return widget.takingOrderNote[0][index] == ''
                                            ? Container()
                                            : Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      '- ${widget.takingOrderNote[0][index].toString()}',
                                                      style: TextStyle(
                                                        color: Colors.black38,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              );
                                        }).toList(),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Serving Product',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w700,
                                  color: widget.servingProductGrafik * 100 > 85.0 ? Colors.green : widget.servingProductGrafik * 100 < 70.0 ? Colors.redAccent : Colors.orangeAccent,),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: LinearPercentIndicator(
                            padding: const EdgeInsets.symmetric(horizontal: 17.0),
                            width: MediaQuery.of(context).size.width,
                            animation: true,
                            lineHeight: 30.0,
                            percent: widget.servingProductGrafik * 100 > 100.0 ? 1.0 : widget.servingProductGrafik,
                            center: Text(
                              widget.servingProductGrafik * 100 >= 100.0 ? '100%' : '${(widget.servingProductGrafik * 100).toString().substring(0, 2)}%'
                            ),
                            animationDuration: 1000,
                            linearStrokeCap: LinearStrokeCap.butt,
                            progressColor: widget.servingProductGrafik * 100 > 85.0 ? Colors.green : widget.servingProductGrafik * 100 < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                          ),
                        ),
                        StreamBuilder(
                          stream: Firestore.instance.collection('servingProduct').snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData)
                              return Container(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            
                            return Column(
                              children: List.generate(snapshot.data.documents[0].data['pertanyaan'].length, (index) {
                                return ListTile(
                                  onTap: () {},
                                  title: Container(
                                    width: 250.0,
                                    child: Row(
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            '${index + 1}. ${snapshot.data.documents[0].data['pertanyaan'][index]}',
                                            style: TextStyle(color: Colors.black54, fontSize: 14.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  trailing: Container(
                                    width: 50.0,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            widget.servingProductNilai[0][index].toString(),
                                            style: TextStyle(
                                              color: widget.servingProductNilai[0][index] == 0 ? Colors.redAccent : Colors.black54,
                                              fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(17.0, 0.0, 17.0, 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _gambarServingProduct = !_gambarServingProduct;
                                    _catatanServingProduct = false;
                                  });
                                },
                                child: Icon(Icons.image, color: widget.imageServingProduct[0].length == 0 ? Colors.grey : AbubaPallate.menuBluebird),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _catatanServingProduct = !_catatanServingProduct;
                                    _gambarServingProduct = false;
                                  });
                                },
                                child: Icon(Icons.note_add, color: widget.servingProductNote[0].length == 0 ? Colors.grey : AbubaPallate.menuBluebird),
                              ),
                            ],
                          ),
                        ),
                        _gambarServingProduct
                            ? widget.imageServingProduct[0].length == 0
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
                                      children: List.generate(widget.imageServingProduct[0].length, (index) {
                                        return GridTile(
                                          child: new Image.network(
                                            widget.imageServingProduct[0][index].toString(),
                                            fit: BoxFit.cover
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  )
                            : Container(),
                        _catatanServingProduct
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
                                              'Catatan',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Column(
                                        children: List.generate(widget.servingProductNote[0].length, (index) {
                                          return widget.servingProductNote[0][index] == ''
                                            ? Container()
                                            : Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      '- ${widget.servingProductNote[0][index].toString()}',
                                                      style: TextStyle(
                                                        color: Colors.black38,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              );
                                        }).toList(),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
                
                ExpansionTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Serving Time',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w700,
                                  color: widget.servingTimeGrafik * 100 > 85.0 ? Colors.green : widget.servingTimeGrafik * 100 < 70.0 ? Colors.redAccent : Colors.orangeAccent,),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            StreamBuilder(
                              stream: Firestore.instance.collection('mystery_shopper').document(widget.index).snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData)
                                  return Container(
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );

                                var doc = snapshot.data;

                                return Column(
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: LinearPercentIndicator(
                                        padding: const EdgeInsets.symmetric(horizontal: 17.0),
                                        width: MediaQuery.of(context).size.width,
                                        animation: true,
                                        lineHeight: 30.0,
                                        percent: widget.servingTimeGrafik * 100 > 100.0 ? 1.0 : widget.servingTimeGrafik,
                                        center: Text(
                                          widget.servingTimeGrafik * 100 >= 100.0 ? '100%' : '${(widget.servingTimeGrafik * 100).toString().substring(0, 2)}%'
                                        ),
                                        animationDuration: 1000,
                                        linearStrokeCap: LinearStrokeCap.butt,
                                        progressColor: widget.servingTimeGrafik * 100 > 85.0 ? Colors.green : widget.servingTimeGrafik * 100 < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 17.0),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                width: 100.0,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        'Items',
                                                        style: TextStyle(
                                                            color: Colors.black54,
                                                            fontWeight: FontWeight.w700
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 100.0,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        'Standard Actual',
                                                        style: TextStyle(
                                                            color: Colors.black54,
                                                            fontWeight: FontWeight.w700,

                                                        ), textAlign: TextAlign.center,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: 100.0,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        'Scores',
                                                        style: TextStyle(
                                                            color: Colors.black54,
                                                            fontWeight: FontWeight.w700
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Column(
                                            children: List.generate(doc['order'].length, (index) {
                                              return Column(
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Container(
                                                        alignment: Alignment.centerLeft,
                                                        width: 100.0,
                                                        child: Column(
                                                          children: <Widget>[
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: <Widget>[
                                                                Flexible(
                                                                  child: Text(
                                                                    doc['order'][index],
                                                                    style: TextStyle(
                                                                      color: Colors.black54,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: <Widget>[
                                                                RichText(
                                                                  overflow: TextOverflow.ellipsis,
                                                                  text: TextSpan(
                                                                    text: doc['menuName'][index],
                                                                    style: TextStyle(
                                                                      color: Colors.black54,
                                                                      fontSize: 12.0
                                                                    )
                                                                  ),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        )
                                                      ),
                                                      Container(
                                                        width: 100.0,
                                                        child: Column(
                                                          children: <Widget>[
                                                            Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment.center,
                                                              children: <Widget>[
                                                                Flexible(
                                                                  child: Text(
                                                                    doc['stdTime'][index],
                                                                    style: TextStyle(
                                                                      color: Colors.black54,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment.center,
                                                              children: <Widget>[
                                                                Flexible(
                                                                  child: Text(
                                                                    doc['orderTimeDone'][index],
                                                                    style: TextStyle(
                                                                      color: Colors.black54,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 100.0,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                          children: <Widget>[
                                                            Flexible(
                                                              child: Text(
                                                                doc['score'][index].toString(),
                                                                style: TextStyle(
                                                                  color: doc['score'][index] == 0 ? Colors.redAccent : Colors.black54,
                                                                  fontWeight: FontWeight.w700
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Divider(
                                                    height: 15.0,
                                                  )
                                                ],
                                              );
                                            }).toList(),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Cleanliness',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w700,
                                  color: widget.cleanlinessGrafik * 100 > 85.0 ? Colors.green : widget.cleanlinessGrafik * 100 < 70.0 ? Colors.redAccent : Colors.orangeAccent,),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: LinearPercentIndicator(
                            padding: const EdgeInsets.symmetric(horizontal: 17.0),
                            width: MediaQuery.of(context).size.width,
                            animation: true,
                            lineHeight: 30.0,
                            percent: widget.cleanlinessGrafik * 100 > 100.0 ? 1.0 : widget.cleanlinessGrafik,
                            center: Text(
                              widget.cleanlinessGrafik * 100 >= 100.0 ? '100%' : '${(widget.cleanlinessGrafik * 100).toString().substring(0, 2)}%'
                            ),
                            animationDuration: 1000,
                            linearStrokeCap: LinearStrokeCap.butt,
                            progressColor: widget.cleanlinessGrafik * 100 > 85.0 ? Colors.green : widget.cleanlinessGrafik * 100 < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                          ),
                        ),
                        StreamBuilder(
                          stream: Firestore.instance.collection('cleaniness').snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData)
                              return Container(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            
                            return Column(
                              children: List.generate(snapshot.data.documents[0].data['pertanyaan'].length, (index) {
                                return ListTile(
                                  onTap: () {},
                                  title: Container(
                                    width: 250.0,
                                    child: Row(
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            '${index + 1}. ${snapshot.data.documents[0].data['pertanyaan'][index]}',
                                            style: TextStyle(color: Colors.black54, fontSize: 14.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  trailing: Container(
                                    width: 50.0,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            widget.cleanlinessNilai[0][index].toString(),
                                            style: TextStyle(
                                              color: widget.cleanlinessNilai[0][index] == 0 ? Colors.redAccent : Colors.black54,
                                              fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(17.0, 0.0, 17.0, 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _gambarCleanliness = !_gambarCleanliness;
                                    _catatanCleanliness = false;
                                  });
                                },
                                child: Icon(Icons.image, color: widget.imageCleanliness[0].length == 0 ? Colors.grey : AbubaPallate.menuBluebird),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _catatanCleanliness = !_catatanCleanliness;
                                    _gambarCleanliness = false;
                                  });
                                },
                                child: Icon(Icons.note_add, color: widget.cleanlinessNote[0].length == 0 ? Colors.grey : AbubaPallate.menuBluebird),
                              ),
                            ],
                          ),
                        ),
                        _gambarCleanliness
                            ? widget.imageCleanliness[0].length == 0
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
                                      children: List.generate(widget.imageCleanliness[0].length, (index) {
                                        return GridTile(
                                          child: new Image.network(
                                            widget.imageCleanliness[0][index].toString(),
                                            fit: BoxFit.cover
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  )
                            : Container(),
                        _catatanCleanliness
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
                                              'Catatan',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Column(
                                        children: List.generate(widget.cleanlinessNote[0].length, (index) {
                                          return widget.cleanlinessNote[0][index] == ''
                                            ? Container()
                                            : Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      '- ${widget.cleanlinessNote[0][index].toString()}',
                                                      style: TextStyle(
                                                        color: Colors.black38,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              );
                                        }).toList(),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Pre-Bushing',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w700,
                                  color: widget.preBushingGrafik * 100 > 85.0 ? Colors.green : widget.preBushingGrafik * 100 < 70.0 ? Colors.redAccent : Colors.orangeAccent,),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: LinearPercentIndicator(
                            padding: const EdgeInsets.symmetric(horizontal: 17.0),
                            width: MediaQuery.of(context).size.width,
                            animation: true,
                            lineHeight: 30.0,
                            percent: widget.preBushingGrafik* 100 > 100.0 ? 1.0 : widget.preBushingGrafik,
                            center: Text(
                              widget.preBushingGrafik* 100 >= 100.0 ? '100%' : '${(widget.preBushingGrafik* 100).toString().substring(0, 2)}%'
                            ),
                            animationDuration: 1000,
                            linearStrokeCap: LinearStrokeCap.butt,
                            progressColor: widget.preBushingGrafik* 100 > 85.0 ? Colors.green : widget.preBushingGrafik* 100 < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                          ),
                        ),
                        StreamBuilder(
                          stream: Firestore.instance.collection('pre-bushing').snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData)
                              return Container(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            
                            return Column(
                              children: List.generate(snapshot.data.documents[0].data['pertanyaan'].length, (index) {
                                return ListTile(
                                  onTap: () {},
                                  title: Container(
                                    width: 250.0,
                                    child: Row(
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            '${index + 1}. ${snapshot.data.documents[0].data['pertanyaan'][index]}',
                                            style: TextStyle(color: Colors.black54, fontSize: 14.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  trailing: Container(
                                    width: 50.0,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            widget.preBushingNilai[0][index].toString(),
                                            style: TextStyle(
                                              color: widget.preBushingNilai[0][index] == 0 ? Colors.redAccent : Colors.black54,
                                              fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(17.0, 0.0, 17.0, 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _gambarPreBushing = !_gambarPreBushing;
                                    _catatanPreBushing = false;
                                  });
                                },
                                child: Icon(Icons.image, color: widget.imagePreBushing[0].length == 0 ? Colors.grey : AbubaPallate.menuBluebird),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _catatanPreBushing = !_catatanPreBushing;
                                    _gambarPreBushing = false;
                                  });
                                },
                                child: Icon(Icons.note_add, color: widget.preBushingNote[0].length == 0 ? Colors.grey : AbubaPallate.menuBluebird),
                              ),
                            ],
                          ),
                        ),
                        _gambarPreBushing
                            ? widget.imagePreBushing[0].length == 0
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
                                      children: List.generate(widget.imagePreBushing[0].length, (index) {
                                        return GridTile(
                                          child: new Image.network(
                                            widget.imagePreBushing[0][index].toString(),
                                            fit: BoxFit.cover
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  )
                            : Container(),
                        _catatanPreBushing
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
                                              'Catatan',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Column(
                                        children: List.generate(widget.preBushingNote[0].length, (index) {
                                          return widget.preBushingNote[0][index] == ''
                                            ? Container()
                                            : Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      '- ${widget.preBushingNote[0][index].toString()}',
                                                      style: TextStyle(
                                                        color: Colors.black38,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              );
                                        }).toList(),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Billing',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w700,
                                  color: widget.billingGrafik * 100 > 85.0 ? Colors.green : widget.billingGrafik * 100 < 70.0 ? Colors.redAccent : Colors.orangeAccent,),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: LinearPercentIndicator(
                            padding: const EdgeInsets.symmetric(horizontal: 17.0),
                            width: MediaQuery.of(context).size.width,
                            animation: true,
                            lineHeight: 30.0,
                            percent: widget.billingGrafik * 100 > 100.0 ? 1.0 : widget.billingGrafik,
                            center: Text(
                              widget.billingGrafik * 100 >= 100.0 ? '100%' : '${(widget.billingGrafik * 100).toString().substring(0, 2)}%'
                            ),
                            animationDuration: 1000,
                            linearStrokeCap: LinearStrokeCap.butt,
                            progressColor: widget.billingGrafik * 100 > 85.0 ? Colors.green : widget.billingGrafik * 100 < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                          ),
                        ),
                        StreamBuilder(
                          stream: Firestore.instance.collection('billing').snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData)
                              return Container(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            
                            return Column(
                              children: List.generate(snapshot.data.documents[0].data['pertanyaan'].length, (index) {
                                return ListTile(
                                  onTap: () {},
                                  title: Container(
                                    width: 250.0,
                                    child: Row(
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            '${index + 1}. ${snapshot.data.documents[0].data['pertanyaan'][index]}',
                                            style: TextStyle(color: Colors.black54, fontSize: 14.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  trailing: Container(
                                    width: 50.0,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            widget.billingNilai[0][index].toString(),
                                            style: TextStyle(
                                              color: widget.billingNilai[0][index] == 0 ? Colors.redAccent : Colors.black54,
                                              fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(17.0, 0.0, 17.0, 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _gambarBilling = !_gambarBilling;
                                    _catatanBilling = false;
                                  });
                                },
                                child: Icon(Icons.image, color: widget.imageBilling[0].length == 0 ? Colors.grey : AbubaPallate.menuBluebird),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _catatanBilling = !_catatanBilling;
                                    _gambarBilling = false;
                                  });
                                },
                                child: Icon(Icons.note_add, color: widget.billingNote[0].length == 0 ? Colors.grey : AbubaPallate.menuBluebird),
                              ),
                            ],
                          ),
                        ),
                        _gambarBilling
                            ? widget.imageBilling[0].length == 0
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
                                      children: List.generate(widget.imageBilling[0].length, (index) {
                                        return GridTile(
                                          child: new Image.network(
                                            widget.imageBilling[0][index].toString(),
                                            fit: BoxFit.cover
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  )
                            : Container(),
                        _catatanBilling
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
                                              'Catatan',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Column(
                                        children: List.generate(widget.billingNote[0].length, (index) {
                                          return widget.billingNote[0][index] == ''
                                            ? Container()
                                            : Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      '- ${widget.billingNote[0][index].toString()}',
                                                      style: TextStyle(
                                                        color: Colors.black38,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              );
                                        }).toList(),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Thanking',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w700,
                                  color: widget.thankingGrafik * 100 > 85.0 ? Colors.green : widget.thankingGrafik * 100 < 70.0 ? Colors.redAccent : Colors.orangeAccent,),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: LinearPercentIndicator(
                            padding: const EdgeInsets.symmetric(horizontal: 17.0),
                            width: MediaQuery.of(context).size.width,
                            animation: true,
                            lineHeight: 30.0,
                            percent: widget.thankingGrafik * 100 > 100.0 ? 1.0 : widget.thankingGrafik,
                            center: Text(
                              widget.thankingGrafik * 100 >= 100.0 ? '100%' : '${(widget.thankingGrafik * 100).toString().substring(0, 2)}%'
                            ),
                            animationDuration: 1000,
                            linearStrokeCap: LinearStrokeCap.butt,
                            progressColor: widget.thankingGrafik * 100 > 85.0 ? Colors.green : widget.thankingGrafik * 100 < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                          ),
                        ),
                        StreamBuilder(
                          stream: Firestore.instance.collection('thanking').snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData)
                              return Container(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            
                            return Column(
                              children: List.generate(snapshot.data.documents[0].data['pertanyaan'].length, (index) {
                                return ListTile(
                                  onTap: () {},
                                  title: Container(
                                    width: 250.0,
                                    child: Row(
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            '${index + 1}. ${snapshot.data.documents[0].data['pertanyaan'][index]}',
                                            style: TextStyle(color: Colors.black54, fontSize: 14.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  trailing: Container(
                                    width: 50.0,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            widget.thankingNilai[0][index].toString(),
                                            style: TextStyle(
                                              color: widget.thankingNilai[0][index] == 0 ? Colors.redAccent : Colors.black54,
                                              fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(17.0, 0.0, 17.0, 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _catatanThanking = !_catatanThanking;
                                  });
                                },
                                child: Icon(Icons.note_add, color: widget.thankingNote[0].length == 0 ? Colors.grey : AbubaPallate.menuBluebird),
                              ),
                            ],
                          ),
                        ),
                        _catatanThanking
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
                                              'Catatan',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Column(
                                        children: List.generate(widget.thankingNote[0].length, (index) {
                                          return widget.thankingNote[0][index] == ''
                                            ? Container()
                                            : Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      '- ${widget.thankingNote[0][index].toString()}',
                                                      style: TextStyle(
                                                        color: Colors.black38,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              );
                                        }).toList(),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Complaint',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w700,
                                  color: widget.complaintGrafik * 100 > 85.0 ? Colors.green : widget.complaintGrafik * 100 < 70.0 ? Colors.redAccent : Colors.orangeAccent,),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(17.0, 0.0, 17.0, 0.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Detail Complaint',
                                      style: TextStyle(
                                          color: AbubaPallate.greenabuba,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 5.0),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.2,
                                          child: RichText(
                                            text: TextSpan(
                                              text: 'Category',
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 11.5,
                                                fontWeight:FontWeight.w700,
                                              ),
                                            )
                                          )
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.7,
                                          child: RichText(
                                            text: TextSpan(
                                              text: ': ${widget.category.toString()}',
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 11.5
                                              ),
                                            )
                                          )
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.2,
                                          child: RichText(
                                            text: TextSpan(
                                              text: 'Product',
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 11.5,
                                                fontWeight:FontWeight.w700,
                                              ),
                                            )
                                          )
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.7,
                                          child: RichText(
                                            text: TextSpan(
                                              text: ': ${widget.product.isEmpty ? '-' : widget.product.toString()}',
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 11.5
                                              ),
                                            )
                                          )
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.2,
                                          child: RichText(
                                            text: TextSpan(
                                              text: 'Service',
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 11.5,
                                                fontWeight:FontWeight.w700,
                                              ),
                                            )
                                          )
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.7,
                                          child: RichText(
                                            text: TextSpan(
                                              text: ': ${widget.service.isEmpty ? '-' : widget.service.toString()}',
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 11.5
                                              ),
                                            )
                                          )
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.2,
                                          child: RichText(
                                            text: TextSpan(
                                              text: 'PIC yang dituju',
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 11.5,
                                                fontWeight:FontWeight.w700,
                                              ),
                                            )
                                          )
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.7,
                                          child: RichText(
                                            text: TextSpan(
                                              text: ': ${widget.pic.isEmpty ? '-' : widget.pic.toString()}',
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 11.5
                                              ),
                                            )
                                          )
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.2,
                                          child: RichText(
                                            text: TextSpan(
                                              text: 'Verbatim Complaint',
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 11.5,
                                                fontWeight:FontWeight.w700,
                                              ),
                                            )
                                          )
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.7,
                                          child: RichText(
                                            text: TextSpan(
                                              text: ': ${widget.complaint.toString()}',
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 11.5
                                              ),
                                            )
                                          )
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 17.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Complaint Handling',
                                      style: TextStyle(
                                          color: AbubaPallate.greenabuba,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: LinearPercentIndicator(
                                padding: const EdgeInsets.symmetric(horizontal: 17.0),
                                width: MediaQuery.of(context).size.width,
                                animation: true,
                                lineHeight: 30.0,
                                percent: widget.complaintGrafik * 100 > 100.0 ? 1.0 : widget.complaintGrafik,
                                center: Text(
                                  widget.complaintGrafik * 100 >= 100.0 ? '100%' : '${(widget.complaintGrafik * 100).toString().substring(0, 2)}%'
                                ),
                                animationDuration: 1000,
                                linearStrokeCap: LinearStrokeCap.butt,
                                progressColor: widget.complaintGrafik * 100 > 85.0 ? Colors.green : widget.complaintGrafik * 100 < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                              ),
                            ),
                            StreamBuilder(
                              stream: Firestore.instance.collection('complaint_handling').where('category', isEqualTo: widget.category.toString()).snapshots(),
                              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData)
                                  return Container(
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                
                                return Column(
                                  children: List.generate(snapshot.data.documents[0].data['pertanyaan'].length, (index) {
                                    return ListTile(
                                      onTap: () {},
                                      title: Container(
                                        width: 250.0,
                                        child: Row(
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                '${index + 1}. ${snapshot.data.documents[0].data['pertanyaan'][index]}',
                                                style: TextStyle(color: Colors.black54, fontSize: 14.0),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      trailing: Container(
                                        width: 50.0,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                widget.complaintNilai[0][index].toString(),
                                                style: TextStyle(
                                                  color: widget.complaintNilai[0][index] == 0 ? Colors.redAccent : Colors.black54,
                                                  fontWeight: FontWeight.w700),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                );
                              },
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(17.0, 0.0, 17.0, 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _gambarComplaint = !_gambarComplaint;
                                        _catatanComplaint = false;
                                      });
                                    },
                                    child: Icon(Icons.image, color: widget.imageComplaint[0].length == 0 ? Colors.grey : AbubaPallate.menuBluebird),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _catatanComplaint = !_catatanComplaint;
                                        _gambarComplaint = false;
                                      });
                                    },
                                    child: Icon(Icons.note_add, color: widget.complaintNote[0].length == 0 ? Colors.grey : AbubaPallate.menuBluebird),
                                  ),
                                ],
                              ),
                            ),
                            _gambarComplaint
                                ? widget.imageComplaint[0].length == 0
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
                                          children: List.generate(widget.imageComplaint[0].length, (index) {
                                            return GridTile(
                                              child: new Image.network(
                                                widget.imageComplaint[0][index].toString(),
                                                fit: BoxFit.cover
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      )
                                : Container(),
                            _catatanComplaint
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
                                                  'Catatan',
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Column(
                                            children: List.generate(widget.complaintNote[0].length, (index) {
                                              return widget.complaintNote[0][index] == ''
                                                ? Container()
                                                : Row(
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          '- ${widget.complaintNote[0][index].toString()}',
                                                          style: TextStyle(
                                                            color: Colors.black38,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  );
                                            }).toList(),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

              ],
            ),
          ),
        
        ],
      ),
    );
  }
}
