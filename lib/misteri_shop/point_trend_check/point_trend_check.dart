import 'dart:async';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PointTrendCheck extends StatefulWidget {
  @override
  _PointTrendCheckState createState() => _PointTrendCheckState();
}

class _PointTrendCheckState extends State<PointTrendCheck> with TickerProviderStateMixin {
  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime dateStart;
  DateTime dateEnd;

  bool showDataFiltered = false;
  bool showHelper = false;
  String helperText = '';

  var document = [];
  
  List<double> parkingDataGrafik = [];
  List<double> greetingDataGrafik = [];
  List<double> seatingDataGrafik = [];
  List<double> takingOrderDataGrafik = [];
  List<double> servingProductDataGrafik = [];
  List<double> servingTimeDataGrafik = [];
  List<double> cleanlinessDataGrafik = [];
  List<double> preBushingDataGrafik = [];
  List<double> billingDataGrafik = [];
  List<double> thankingDataGrafik = [];
  List<double> complaintDataGrafik = [];

  double parking = 0.0;
  double greeting = 0.0;
  double seating = 0.0;
  double takingOrder = 0.0;
  double servingProduct = 0.0;
  double servingTime = 0.0;
  double cleanliness = 0.0;
  double preBushing = 0.0;
  double billing = 0.0;
  double thanking = 0.0;
  double complaint = 0.0;

  int count = 0;

  String isProcess = 'blank';

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
        body: ListView(
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
                      'Point Trend Check',
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
                        const EdgeInsets.only(top: 0.0, left: 20.0, right: 20.0),
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
                            resetIcon: null,
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
                            resetIcon: null,
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
                        top: 10.0, left: 20.0, right: 20.0, bottom: 15.0),
                    child: ButtonTheme(
                      minWidth: width / 2.5,
                      height: 40.0,
                      child: RaisedButton(
                        color: Colors.green,
                        child: Text(
                          'SEARCH',
                          style: TextStyle(fontSize: 13.0, color: Colors.white),
                        ),
                        onPressed: () async {
                          if (dateStart != null && dateEnd != null) {
                            if (dateStart.isAfter(dateEnd) == false) {
                              setState(() {
                                showDataFiltered = true;
                                showHelper = false;
                                helperText = '';

                                isProcess = 'loading';

                                document.clear();
                                
                                parkingDataGrafik.clear();
                                greetingDataGrafik.clear();
                                seatingDataGrafik.clear();
                                takingOrderDataGrafik.clear();
                                servingProductDataGrafik.clear();
                                servingTimeDataGrafik.clear();
                                cleanlinessDataGrafik.clear();
                                preBushingDataGrafik.clear();
                                billingDataGrafik.clear();
                                thankingDataGrafik.clear();
                                complaintDataGrafik.clear();

                                parking = 0.0;
                                greeting = 0.0;
                                seating = 0.0;
                                takingOrder = 0.0;
                                servingProduct = 0.0;
                                servingTime = 0.0;
                                cleanliness = 0.0;
                                preBushing = 0.0;
                                billing = 0.0;
                                thanking = 0.0;
                                complaint = 0.0;

                                count = 0;

                                Firestore.instance.collection('mystery_shopper').where('checkIn', isGreaterThanOrEqualTo: dateStart).getDocuments().then((data) {
                                  document = data.documents;

                                  for (int i = 0; i < document.length; i++) {
                                    Timestamp tanggalTS = document[i].data['checkIn'];
                                    DateTime tanggalBantu = DateTime.tryParse(tanggalTS.toDate().toString());

                                    if (tanggalBantu.isAfter(dateEnd.subtract(Duration(days: -1))) == true || document[i].data['checkOut'] == null) {
                                      
                                    } else {
                                      count += 1;
                                      parkingDataGrafik.add(document[i].data['hasilParking']);
                                      greetingDataGrafik.add(document[i].data['hasilGreeting']);
                                      seatingDataGrafik.add(document[i].data['hasilSeating']);
                                      takingOrderDataGrafik.add(document[i].data['hasilTakingOrder']);
                                      servingProductDataGrafik.add(document[i].data['hasilServingProduct']);
                                      servingTimeDataGrafik.add(document[i].data['hasilServingTime']);
                                      cleanlinessDataGrafik.add(document[i].data['hasilCleanliness']);
                                      preBushingDataGrafik.add(document[i].data['hasilPreBushing']);
                                      billingDataGrafik.add(document[i].data['hasilBilling']);
                                      thankingDataGrafik.add(document[i].data['hasilThanking']);
                                      complaintDataGrafik.add(document[i].data['hasilComplaint']);
                                    }
                                  }

                                  parking = ((parkingDataGrafik.reduce((a, b) => a + b)) / count) * 100;
                                  greeting = ((greetingDataGrafik.reduce((a, b) => a + b)) / count) * 100;
                                  seating = ((seatingDataGrafik.reduce((a, b) => a + b)) / count) * 100;
                                  takingOrder = ((takingOrderDataGrafik.reduce((a, b) => a + b)) / count) * 100;
                                  servingProduct = ((servingProductDataGrafik.reduce((a, b) => a + b)) / count) * 100;
                                  servingTime = ((servingTimeDataGrafik.reduce((a, b) => a + b)) / count) * 100;
                                  cleanliness = ((cleanlinessDataGrafik.reduce((a, b) => a + b)) / count) * 100;
                                  preBushing = ((preBushingDataGrafik.reduce((a, b) => a + b)) / count) * 100;
                                  billing = ((billingDataGrafik.reduce((a, b) => a + b)) / count) * 100;
                                  thanking = ((thankingDataGrafik.reduce((a, b) => a + b)) / count) * 100;
                                  complaint = ((complaintDataGrafik.reduce((a, b) => a + b)) / count) * 100;
                                });
                              });
                              await new Future.delayed(Duration(
                                seconds: 5
                              ));
                              setState(() {
                                isProcess = 'view';
                              });
                            } else {
                              setState(() {
                                showDataFiltered = false;
                                showHelper = true;
                                helperText = "can\'t back date";

                                isProcess = 'blank'; 
                              });
                            }
                          } else {
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
                                          'Date from and date to can\'t be empty',
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
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            );
                          }
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
            isProcess == 'loading'
              ? Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : isProcess == 'view'
                  ? Column(
                      children: <Widget>[
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(vertical:10.0, horizontal: 10.0),
                          child: Column(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12.0, left: 10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text('Parking'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: LinearPercentIndicator(
                                      width: MediaQuery.of(context).size.width / 1.1,
                                      animation: true,
                                      lineHeight: 30.0,
                                      percent: parking >= 100.0 ? 1.0 : parking / 100,
                                      center: Text(
                                        parking >= 100.0 ? '100%' : '${(parking).toString().substring(0, 2)}%'
                                      ),
                                      animationDuration: 1000,
                                      linearStrokeCap: LinearStrokeCap.butt,
                                      progressColor: parking > 85.0 ? Colors.green : parking < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                                    ),
                                  )
                                ],
                              )

                            ],
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(vertical:10.0, horizontal: 10.0),
                          child: Column(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12.0, left: 10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text('Greeting'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: LinearPercentIndicator(
                                      width: MediaQuery.of(context).size.width / 1.1,
                                      animation: true,
                                      lineHeight: 30.0,
                                      percent: greeting >= 100.0 ? 1.0 : greeting / 100,
                                      center: Text(
                                        greeting >= 100.0 ? '100%' : '${(greeting).toString().substring(0, 2)}%'
                                      ),
                                      animationDuration: 1000,
                                      linearStrokeCap: LinearStrokeCap.butt,
                                      progressColor: greeting > 85.0 ? Colors.green : greeting < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                                    ),
                                  )
                                ],
                              )

                            ],
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(vertical:10.0, horizontal: 10.0),
                          child: Column(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12.0, left: 10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text('Seating'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: LinearPercentIndicator(
                                      width: MediaQuery.of(context).size.width / 1.1,
                                      animation: true,
                                      lineHeight: 30.0,
                                      percent: seating >= 100.0 ? 1.0 : seating / 100,
                                      center: Text(
                                        seating >= 100.0 ? '100%' : '${(seating).toString().substring(0, 2)}%'
                                      ),
                                      animationDuration: 1000,
                                      linearStrokeCap: LinearStrokeCap.butt,
                                      progressColor: seating > 85.0 ? Colors.green : seating < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                                    ),
                                  )
                                ],
                              )

                            ],
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(vertical:10.0, horizontal: 10.0),
                          child: Column(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12.0, left: 10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text('Taking Order'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: LinearPercentIndicator(
                                      width: MediaQuery.of(context).size.width / 1.1,
                                      animation: true,
                                      lineHeight: 30.0,
                                      percent: takingOrder >= 100.0 ? 1.0 : takingOrder / 100,
                                      center: Text(
                                        takingOrder >= 100.0 ? '100%' : '${(takingOrder).toString().substring(0, 2)}%'
                                      ),
                                      animationDuration: 1000,
                                      linearStrokeCap: LinearStrokeCap.butt,
                                      progressColor: takingOrder > 85.0 ? Colors.green : takingOrder < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                                    ),
                                  )
                                ],
                              )

                            ],
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(vertical:10.0, horizontal: 10.0),
                          child: Column(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12.0, left: 10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text('Serving Product'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: LinearPercentIndicator(
                                      width: MediaQuery.of(context).size.width / 1.1,
                                      animation: true,
                                      lineHeight: 30.0,
                                      percent: servingProduct >= 100.0 ? 1.0 : servingProduct / 100,
                                      center: Text(
                                        servingProduct >= 100.0 ? '100%' : '${(servingProduct).toString().substring(0, 2)}%'
                                      ),
                                      animationDuration: 1000,
                                      linearStrokeCap: LinearStrokeCap.butt,
                                      progressColor: servingProduct > 85.0 ? Colors.green : servingProduct < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                                    ),
                                  )
                                ],
                              )

                            ],
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(vertical:10.0, horizontal: 10.0),
                          child: Column(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12.0, left: 10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text('Serving Time'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: LinearPercentIndicator(
                                      width: MediaQuery.of(context).size.width / 1.1,
                                      animation: true,
                                      lineHeight: 30.0,
                                      percent: servingTime >= 100.0 ? 1.0 : servingTime / 100,
                                      center: Text(
                                        servingTime >= 100.0 ? '100%' : '${(servingTime).toString().substring(0, 2)}%'
                                      ),
                                      animationDuration: 1000,
                                      linearStrokeCap: LinearStrokeCap.butt,
                                      progressColor: servingTime > 85.0 ? Colors.green : servingTime < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                                    ),
                                  )
                                ],
                              )

                            ],
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(vertical:10.0, horizontal: 10.0),
                          child: Column(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12.0, left: 10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text('Cleanliness'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: LinearPercentIndicator(
                                      width: MediaQuery.of(context).size.width / 1.1,
                                      animation: true,
                                      lineHeight: 30.0,
                                      percent: cleanliness >= 100.0 ? 1.0 : cleanliness / 100,
                                      center: Text(
                                        cleanliness >= 100.0 ? '100%' : '${(cleanliness).toString().substring(0, 2)}%'
                                      ),
                                      animationDuration: 1000,
                                      linearStrokeCap: LinearStrokeCap.butt,
                                      progressColor: cleanliness > 85.0 ? Colors.green : cleanliness < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                                    ),
                                  )
                                ],
                              )

                            ],
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(vertical:10.0, horizontal: 10.0),
                          child: Column(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12.0, left: 10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text('Pre-Bushing'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: LinearPercentIndicator(
                                      width: MediaQuery.of(context).size.width / 1.1,
                                      animation: true,
                                      lineHeight: 30.0,
                                      percent: preBushing >= 100.0 ? 1.0 : preBushing / 100,
                                      center: Text(
                                        preBushing >= 100.0 ? '100%' : '${(preBushing).toString().substring(0, 2)}%'
                                      ),
                                      animationDuration: 1000,
                                      linearStrokeCap: LinearStrokeCap.butt,
                                      progressColor: preBushing > 85.0 ? Colors.green : preBushing < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                                    ),
                                  )
                                ],
                              )

                            ],
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(vertical:10.0, horizontal: 10.0),
                          child: Column(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12.0, left: 10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text('Billing'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: LinearPercentIndicator(
                                      width: MediaQuery.of(context).size.width / 1.1,
                                      animation: true,
                                      lineHeight: 30.0,
                                      percent: billing >= 100.0 ? 1.0 : billing / 100,
                                      center: Text(
                                        billing >= 100.0 ? '100%' : '${(billing).toString().substring(0, 2)}%'
                                      ),
                                      animationDuration: 1000,
                                      linearStrokeCap: LinearStrokeCap.butt,
                                      progressColor: billing > 85.0 ? Colors.green : billing < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                                    ),
                                  )
                                ],
                              )

                            ],
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(vertical:10.0, horizontal: 10.0),
                          child: Column(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12.0, left: 10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text('Thanking'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: LinearPercentIndicator(
                                      width: MediaQuery.of(context).size.width / 1.1,
                                      animation: true,
                                      lineHeight: 30.0,
                                      percent: thanking >= 100.0 ? 1.0 : thanking / 100,
                                      center: Text(
                                        thanking >= 100.0 ? '100%' : '${(thanking).toString().substring(0, 2)}%'
                                      ),
                                      animationDuration: 1000,
                                      linearStrokeCap: LinearStrokeCap.butt,
                                      progressColor: thanking > 85.0 ? Colors.green : thanking < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                                    ),
                                  )
                                ],
                              )

                            ],
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(vertical:10.0, horizontal: 10.0),
                          child: Column(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12.0, left: 10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text('Complaint'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: LinearPercentIndicator(
                                      width: MediaQuery.of(context).size.width / 1.1,
                                      animation: true,
                                      lineHeight: 30.0,
                                      percent: complaint >= 100.0 ? 1.0 : complaint / 100,
                                      center: Text(
                                        complaint >= 100.0 ? '100%' : '${(complaint).toString().substring(0, 2)}%'
                                      ),
                                      animationDuration: 1000,
                                      linearStrokeCap: LinearStrokeCap.butt,
                                      progressColor: complaint > 85.0 ? Colors.green : complaint < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                                    ),
                                  )
                                ],
                              )

                            ],
                          ),
                        ),
                      ],
                    )
                  : Container()
          ],
        ),
      ),
    );
  }
}