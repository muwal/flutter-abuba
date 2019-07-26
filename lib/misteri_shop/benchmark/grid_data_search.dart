import 'dart:async';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'detail_benchmark.dart';

class FormBenchmark extends StatefulWidget {
  final int idUser;
  FormBenchmark({this.idUser});
  @override
  _FormBenchmarkState createState() => _FormBenchmarkState();
}

class _FormBenchmarkState extends State<FormBenchmark> {
  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime dateStart;
  DateTime dateEnd;

  double hasilParking = 0;
  double hasilGreeting = 0;
  double hasilSeating = 0;
  double hasilTakingOrder = 0;
  double hasilServingProduct = 0;
  double hasilCleanliness = 0;
  double hasilPreBushing = 0;
  double hasilBilling = 0;
  double hasilThanking = 0;
  double hasilComplaint = 0;
  double hasilServingTime = 0;

  double hasilParking2 = 0;
  double hasilGreeting2 = 0;
  double hasilSeating2 = 0;
  double hasilTakingOrder2 = 0;
  double hasilServingProduct2 = 0;
  double hasilCleanliness2 = 0;
  double hasilPreBushing2 = 0;
  double hasilBilling2 = 0;
  double hasilThanking2 = 0;
  double hasilComplaint2 = 0;
  double hasilServingTime2 = 0;

  List<String> selectedOutlet = [];
  List<String> selectedOutletID = [];
  List<String> selectedOutletTanggal = [];

  List<String> outletSend = [];
  List<String> outletTanggalSend = [];

  bool buttonView = false;
  bool showDataFiltered = false;
  bool showHelper = false;
  String helperText = '';
  bool _error = false;

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
                'Mystery Shopper',
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
                  'Benchmark',
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
                padding: const EdgeInsets.only(top: 0.0, left: 20.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: width / 2.5,
                      child: DateTimePickerFormField(
                        format: dateFormat,
                        onChanged: (dt) => setState(() => dateStart = dt),
                        dateOnly: true,
                        editable: false,
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelStyle: TextStyle(fontSize: 14.0),
                          labelText: 'From',
                          helperText: helperText,
                          helperStyle: TextStyle(
                            color: showHelper ? Colors.redAccent : Colors.black38,
                            fontStyle: showHelper ? FontStyle.italic : FontStyle.normal,
                            fontSize: 14.0
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: width / 2.5,
                      child: DateTimePickerFormField(
                    format: dateFormat,
                    onChanged: (dt) => setState(() => dateEnd = dt),
                    dateOnly: true,
                    editable: false,
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
                padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 15.0),
                child: ButtonTheme(
                  minWidth: width / 2.5,
                  height: 40.0,
                  child: RaisedButton(
                    color: Colors.green,
                    child: Text(
                      'SEARCH',
                      style: TextStyle(
                          fontSize: 13.0, color: Colors.white),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    style: BorderStyle.solid,
                    width: 1.0,
                    color: Colors.black
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(selectedOutlet.length == 0
                            ? 'Select 2 outlets'
                            : selectedOutlet.join(', ')),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 10.0),
              width: MediaQuery.of(context).size.width * 0.3,
              child: ButtonTheme(
                minWidth: 30.0,
                child: RaisedButton(
                  color: selectedOutlet.length != 2 ? Colors.grey : Colors.green,
                  elevation: 0.0,
                  child: buttonView ? Text('Preparing ...', style: TextStyle(color: Colors.white, fontSize: 12.0)) : Text('GO', style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold)),
                  onPressed: () async {
                    if (selectedOutlet.length == 2) {
                      buttonView = true;
                      _error = false;
                      Firestore.instance.collection('mystery_shopper').document(selectedOutletID[0]).snapshots()
                        .listen((data) {
                          setState(() {
                            hasilParking = data['hasilParking'];
                            hasilGreeting = data['hasilGreeting'];
                            hasilSeating = data['hasilSeating'];
                            hasilTakingOrder = data['hasilTakingOrder'];
                            hasilServingProduct = data['hasilServingProduct'];
                            hasilPreBushing = data['hasilPreBushing'];
                            hasilCleanliness = data['hasilCleanliness'];
                            hasilServingTime = data['hasilServingTime'];
                            hasilComplaint = data['hasilComplaint'];
                            hasilBilling = data['hasilBilling'];
                            hasilThanking = data['hasilThanking'];
                          });
                        });

                      Firestore.instance.collection('mystery_shopper').document(selectedOutletID[1]).snapshots()
                        .listen((data) {
                          setState(() {
                            hasilParking2 = data['hasilParking'];
                            hasilGreeting2 = data['hasilGreeting'];
                            hasilSeating2 = data['hasilSeating'];
                            hasilTakingOrder2 = data['hasilTakingOrder'];
                            hasilServingProduct2 = data['hasilServingProduct'];
                            hasilPreBushing2 = data['hasilPreBushing'];
                            hasilCleanliness2 = data['hasilCleanliness'];
                            hasilServingTime2 = data['hasilServingTime'];
                            hasilComplaint2 = data['hasilComplaint'];
                            hasilBilling2 = data['hasilBilling'];
                            hasilThanking2 = data['hasilThanking'];
                          });
                        });
                      await new Future.delayed(Duration(
                        seconds: 3
                      ));
                      setState(() {
                        buttonView = false;
                        outletSend = selectedOutlet;
                        outletTanggalSend = selectedOutletTanggal;

                        selectedOutlet = [];
                        selectedOutletID.clear();
                        selectedOutletTanggal = [];
                      });
                      Navigator.push(context, 
                        MaterialPageRoute(
                          builder: (context) => DetailBenchmark(selectedOutlet: outletSend, selectedOutletTanggal: outletTanggalSend, hasilParking: hasilParking, hasilGreeting: hasilGreeting, hasilSeating: hasilSeating, hasilTakingOrder: hasilTakingOrder, hasilServingProduct: hasilServingProduct, hasilServingTime: hasilServingTime, hasilComplaint: hasilComplaint, hasilBilling: hasilBilling,  hasilCleanliness: hasilCleanliness, hasilThanking: hasilThanking, hasilPreBushing: hasilPreBushing, hasilParking2: hasilParking2, hasilBilling2: hasilBilling2, hasilCleanliness2: hasilCleanliness2, hasilComplaint2: hasilComplaint2, hasilGreeting2: hasilGreeting2, hasilPreBushing2: hasilPreBushing2, hasilSeating2: hasilSeating2, hasilServingProduct2: hasilServingProduct2, hasilServingTime2: hasilServingTime2, hasilTakingOrder2: hasilTakingOrder2, hasilThanking2: hasilThanking2,)
                        )
                      );
                    } else {
                      setState(() {
                        _error = true;
                      });
                    }
                  },
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20.0,
        ),
        _error
          ? Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              width: width,
              child: RichText(
                overflow: TextOverflow.visible,
                text: TextSpan(
                  text: '*select 2 outlets',
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 12.0,
                    fontStyle: FontStyle.italic
                  )
                ),
              ),
            )
          : Container(),
        SizedBox(
          height: 20.0,
        ),
        Container(
          width: width,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              StreamBuilder(
                stream: showDataFiltered
                  ? Firestore.instance.collection('mystery_shopper').where('checkIn', isGreaterThanOrEqualTo: dateStart).orderBy('checkIn', descending: false).snapshots()
                  : Firestore.instance.collection('mystery_shopper').orderBy('checkIn', descending: false).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData && snapshot.data == null) 
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                            ),
                    );

                  return Column(
                    children: List.generate(snapshot.data.documents.length, (index) {
                      Timestamp tanggalTS = snapshot.data.documents[index].data['checkIn'];
                      DateTime tanggalBantu = DateTime.tryParse(tanggalTS.toDate().toString());
                      if (showDataFiltered && dateEnd != null && dateStart != null) {
                        if (tanggalBantu.isAfter(dateEnd.subtract(Duration(days: -1))) == true || snapshot.data.documents[index].data['checkOut'] == null) {
                          return Container();
                        } else {
                          return ListTile(
                            onTap: () {
                              setState(() {
                                if (selectedOutlet.length < 2) {
                                  if (selectedOutletID.contains(snapshot.data.documents[index].documentID)) {
                                    selectedOutlet.removeWhere((item) => item == snapshot.data.documents[index].data['outlet']);
                                    selectedOutletTanggal.removeAt(selectedOutletID.indexOf(snapshot.data.documents[index].documentID));
                                    selectedOutletID.removeWhere((item) => item == snapshot.data.documents[index].documentID);
                                  } else {
                                    selectedOutlet.add(snapshot.data.documents[index].data['outlet']);
                                    selectedOutletID.add(snapshot.data.documents[index].documentID);
                                    selectedOutletTanggal.add(tanggalTS.toDate().toString().substring(8, 10) + '/' + tanggalTS.toDate().toString().substring(5, 7) + '/' + tanggalTS.toDate().toString().substring(0, 4));
                                  }
                                } else {
                                  if (selectedOutletID.contains(snapshot.data.documents[index].documentID)) {
                                    selectedOutlet.removeWhere((item) => item == snapshot.data.documents[index].data['outlet']);
                                    selectedOutletTanggal.removeAt(selectedOutletID.indexOf(snapshot.data.documents[index].documentID));
                                    selectedOutletID.removeWhere((item) => item == snapshot.data.documents[index].documentID);
                                  }
                                }
                              });
                            },
                            title: Container(
                              width: 150.0,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      snapshot.data.documents[index].data['outlet'],
                                      style: TextStyle(fontSize: 14.0, color: Colors.black54, fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  selectedOutletID.contains(snapshot.data.documents[index].documentID)
                                    ? IconButton(
                                        icon: Icon(Icons.check, color: Colors.green,),
                                        onPressed: null,
                                      )
                                    : Container()
                                ],
                              ),
                            ),
                            trailing: Container(
                              width: 150.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      tanggalTS.toDate().toString().substring(8, 10) + '/' + tanggalTS.toDate().toString().substring(5, 7) + '/' + tanggalTS.toDate().toString().substring(0, 4),
                                      style: TextStyle(
                                          fontSize: 13.0, color: Colors.blue),
                                      textAlign: TextAlign.right,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                      } else {
                        if (snapshot.data.documents[index].data['checkOut'] == null) {
                          return Container();
                        } else {
                          return ListTile(
                            onTap: () {
                              setState(() {
                                if (selectedOutlet.length < 2) {
                                  if (selectedOutletID.contains(snapshot.data.documents[index].documentID)) {
                                    selectedOutlet.removeWhere((item) => item == snapshot.data.documents[index].data['outlet']);
                                    selectedOutletTanggal.removeAt(selectedOutletID.indexOf(snapshot.data.documents[index].documentID));
                                    selectedOutletID.removeWhere((item) => item == snapshot.data.documents[index].documentID);
                                  } else {
                                    selectedOutlet.add(snapshot.data.documents[index].data['outlet']);
                                    selectedOutletID.add(snapshot.data.documents[index].documentID);
                                    selectedOutletTanggal.add(tanggalTS.toDate().toString().substring(8, 10) + '/' + tanggalTS.toDate().toString().substring(5, 7) + '/' + tanggalTS.toDate().toString().substring(0, 4));
                                  }
                                } else {
                                  if (selectedOutletID.contains(snapshot.data.documents[index].documentID)) {
                                    selectedOutlet.removeWhere((item) => item == snapshot.data.documents[index].data['outlet']);
                                    selectedOutletTanggal.removeAt(selectedOutletID.indexOf(snapshot.data.documents[index].documentID));
                                    selectedOutletID.removeWhere((item) => item == snapshot.data.documents[index].documentID);
                                  }
                                }
                              });
                            },
                            title: Container(
                              width: 150.0,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      snapshot.data.documents[index].data['outlet'],
                                      style: TextStyle(fontSize: 14.0, color: Colors.black54, fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  selectedOutletID.contains(snapshot.data.documents[index].documentID)
                                    ? IconButton(
                                        icon: Icon(Icons.check, color: Colors.green,),
                                        onPressed: null,
                                      )
                                    : Container()
                                ],
                              ),
                            ),
                            trailing: Container(
                              width: 150.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      tanggalTS.toDate().toString().substring(8, 10) + '/' + tanggalTS.toDate().toString().substring(5, 7) + '/' + tanggalTS.toDate().toString().substring(0, 4),
                                      style: TextStyle(
                                          fontSize: 13.0, color: Colors.blue),
                                      textAlign: TextAlign.right,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                      }
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
