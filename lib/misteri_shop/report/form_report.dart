import 'dart:async';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'detail_report.dart';

class FormReport extends StatefulWidget {
  final int idUser;
  final String aksesStatus;
  FormReport({this.idUser, this.aksesStatus});

  @override
  _FormReportState createState() => _FormReportState();
}

class _FormReportState extends State<FormReport> {
  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime dateStart;
  DateTime dateEnd;

  String userName = '';
  String tanggal = '';
  String waktuStart = '';
  String waktuEnd = '';
  List<dynamic> complaintNote = [];
  String category = '';
  String product = '';
  String service = '';
  String serviceNote = '';
  String pic = '';
  String complaint;
  
  List<dynamic> parkingScore = [];
  List<dynamic> parkingNote = [];
  List<dynamic> greetingScore = [];
  List<dynamic> greetingNote = [];
  List<dynamic> seatingScore = [];
  List<dynamic> seatingNote = [];
  List<dynamic> takingOrderScore = [];
  List<dynamic> takingOrderNote = [];
  List<dynamic> servingProductScore = [];
  List<dynamic> servingProductNote = [];
  List<dynamic> complaintScore = [];
  List<dynamic> bobotServingTime = [];
  List<dynamic> servingTimeScore = [];
  List<dynamic> billingScore = [];
  List<dynamic> billingNote = [];
  List<dynamic> thankingScore = [];
  List<dynamic> thankingNote = [];
  List<dynamic> preBushingScore = [];
  List<dynamic> preBushingNote = [];
  List<dynamic> cleanlinessScore = [];
  List<dynamic> cleanlinessNote = [];

  List<dynamic> imageServingProduct = [];
  List<dynamic> imageComplaint = [];
  List<dynamic> imagePreBushing = [];
  List<dynamic> imageCleanliness = [];
  List<dynamic> imageParking = [];
  List<dynamic> imageBilling = [];

  List<dynamic> orderTimeDone = [];
  List<dynamic> menuName = [];

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
  double hasilGrafik = 0;
  double bobot1 = 0;
  double bobot2 = 0;
  double bobot3 = 0;
  double bobot4 = 0;
  double bobot5 = 0;
  double bobot6 = 0;
  double bobot7 = 0;
  double bobot8 = 0;
  double bobot9 = 0;
  double bobot10 = 0;
  double bobot11 = 0;

  List<bool> buttonView = [];
  bool showDataFiltered = false;
  bool showHelper = false;
  String helperText = '';

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
                  'Report',
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

                    for (int i = 0; i < snapshot.data.documents.length; i++) {
                      buttonView.add(false);
                    }

                  return Column(
                    children: List.generate(snapshot.data.documents.length, (index) {
                      Timestamp tanggalTS = snapshot.data.documents[index].data['checkIn'];
                      DateTime tanggalBantu = DateTime.tryParse(tanggalTS.toDate().toString());
                      if (showDataFiltered && dateEnd != null && dateStart != null) {
                        if (tanggalBantu.isAfter(dateEnd.subtract(Duration(days: -1))) == true || snapshot.data.documents[index].data['checkOut'] == null) {
                          return Container();
                        } else {
                          return ListTile(
                            onTap: null,
                            title: Container(
                              width: 150.0,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      snapshot.data.documents[index].data['outlet'],
                                      style: TextStyle(fontSize: 14.0, color: Colors.black54, fontWeight: FontWeight.w700),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            trailing: GestureDetector(
                              onTap: () async {
                                setState(() {
                                  imageServingProduct.clear();
                                  imageComplaint.clear();
                                  imagePreBushing.clear();
                                  imageCleanliness.clear();
                                  imageParking.clear();
                                  imageBilling.clear();

                                  complaintNote.clear();
                                  parkingNote.clear();
                                  greetingNote.clear();
                                  seatingNote.clear();
                                  takingOrderNote.clear();
                                  servingProductNote.clear();
                                  billingNote.clear();
                                  thankingNote.clear();
                                  preBushingNote.clear();
                                  cleanlinessNote.clear();

                                  parkingScore.clear();
                                  greetingScore.clear();
                                  seatingScore.clear();
                                  takingOrderScore.clear();
                                  servingProductScore.clear();
                                  complaintScore.clear();
                                  servingTimeScore.clear();
                                  billingScore.clear();
                                  thankingScore.clear();
                                  preBushingScore.clear();
                                  cleanlinessScore.clear();

                                  menuName.clear();
                                });
                                Firestore.instance.collection('mystery_shopper')
                                  .document(snapshot.data.documents[index].documentID)
                                  .snapshots()
                                  .listen((data) {
                                    setState(() {
                                      parkingScore.add(data['parking_score']);
                                      parkingNote.add(data['parking_note']);
                                      greetingScore.add(data['greeting_score']);
                                      greetingNote.add(data['greeting_note']);
                                      seatingScore.add(data['seating_score']);
                                      seatingNote.add(data['seating_note']);
                                      takingOrderScore.add(data['takingOrder_score']);
                                      takingOrderNote.add(data['takingOrder_note']);
                                      servingProductScore.add(data['servingProduct_score']);
                                      servingProductNote.add(data['servingProduct_note']);
                                      complaintScore.add(data['complaint_score']);
                                      complaintNote.add(data['complaint_note']);
                                      billingScore.add(data['billing_score']);
                                      billingNote.add(data['billing_note']);
                                      thankingScore.add(data['thanking_score']);
                                      thankingNote.add(data['thanking_note']);
                                      preBushingScore.add(data['preBushing_score']);
                                      preBushingNote.add(data['preBushing_note']);
                                      cleanlinessScore.add(data['cleanliness_score']);
                                      cleanlinessNote.add(data['cleanliness_note']);
                                      complaint = data['complaint_detail'];
                                      category = data['category'];
                                      serviceNote = data['note_service'];
                                      servingTimeScore.add(data['score']);
                                      bobotServingTime.add(data['bobot_pertanyaan']);
                                      bobot11 = double.tryParse(data['bobot'].toString());
                                      orderTimeDone.add(data['orderTimeDone']);
                                      menuName.add(data['menuName']);

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
                                      hasilGrafik = data['hasilGrafik'];

                                      imageServingProduct.add(data['servingProduct_image']);
                                      imageComplaint.add(data['complaint_image']);
                                      imagePreBushing.add(data['preBushing_image']);
                                      imageCleanliness.add(data['cleanliness_image']);
                                      imageParking.add(data['parking_image']);
                                      imageBilling.add(data['billing_image']);

                                      if (data['product'] == null) {
                                        product = '';
                                      } else {
                                        Firestore.instance.collection('product_complaint-mg').where('id', isEqualTo: data['product']).snapshots()
                                          .listen((data2) => data2.documents.forEach((doc2) {
                                            product = doc2['product'];
                                          }));
                                      }

                                      if (data['service'] == null) {
                                        service = '';
                                      } else {
                                        Firestore.instance.collection('service_complaint-mg').where('id', isEqualTo: data['service']).snapshots()
                                          .listen((data2) => data2.documents.forEach((doc2) {
                                            service = doc2['service'];
                                          }));
                                      }

                                      Firestore.instance.collection('pic_complaint-mg').where('id', isEqualTo: data['pic']).snapshots()
                                        .listen((data2) => data2.documents.forEach((doc2) {
                                          pic = doc2['pic'];
                                        }));

                                      Timestamp checkInBantu = data['checkIn'];
                                      Timestamp checkOutBantu = data['checkOut'];
                                      tanggal = checkInBantu.toDate().toString().substring(8, 10) + '/' + checkInBantu.toDate().toString().substring(5, 7) + '/' + checkInBantu.toDate().toString().substring(0, 4);
                                      waktuStart = checkInBantu.toDate().toString().substring(11, 16);
                                      if (data['checkOut'] == null) {
                                        waktuEnd = '00.00';
                                      } else {
                                        waktuEnd = checkOutBantu.toDate().toString().substring(11, 16);
                                      }
                                    });
                                  });

                                Firestore.instance.collection('parking').snapshots()
                                  .listen((data5) => data5.documents.forEach((doc5) {
                                    bobot1 = double.tryParse(doc5['bobot'].toString());
                                  }));

                                Firestore.instance.collection('greeting').snapshots()
                                  .listen((data5) => data5.documents.forEach((doc5) {
                                    bobot2 = double.tryParse(doc5['bobot'].toString());
                                  }));

                                Firestore.instance.collection('seating').snapshots()
                                  .listen((data5) => data5.documents.forEach((doc5) {
                                    bobot3 = double.tryParse(doc5['bobot'].toString());
                                  }));

                                Firestore.instance.collection('takingOrder').snapshots()
                                  .listen((data5) => data5.documents.forEach((doc5) {
                                    bobot4 = double.tryParse(doc5['bobot'].toString());
                                  }));

                                Firestore.instance.collection('servingProduct').snapshots()
                                  .listen((data5) => data5.documents.forEach((doc5) {
                                    bobot5 = double.tryParse(doc5['bobot'].toString());
                                  }));

                                Firestore.instance.collection('cleaniness').snapshots()
                                  .listen((data5) => data5.documents.forEach((doc5) {
                                    bobot6 = double.tryParse(doc5['bobot'].toString());
                                  }));

                                Firestore.instance.collection('pre-bushing').snapshots()
                                  .listen((data5) => data5.documents.forEach((doc5) {
                                    bobot7 = double.tryParse(doc5['bobot'].toString());
                                  }));

                                Firestore.instance.collection('billing').snapshots()
                                  .listen((data5) => data5.documents.forEach((doc5) {
                                    bobot8 = double.tryParse(doc5['bobot'].toString());
                                  }));

                                Firestore.instance.collection('thanking').snapshots()
                                  .listen((data5) => data5.documents.forEach((doc5) {
                                    bobot9 = double.tryParse(doc5['bobot'].toString());
                                  }));

                                Firestore.instance.collection('complaint_handling').snapshots()
                                  .listen((data5) => data5.documents.forEach((doc5) {
                                    bobot10 = double.tryParse(doc5['bobot'].toString());
                                  }));

                                Firestore.instance.collection('user').where('id', isEqualTo: snapshot.data.documents[index].data['user']).snapshots()
                                  .listen((data) => data.documents.forEach((doc) {
                                    setState(() {
                                      userName = doc['nama'];
                                    });
                                  }));
                                setState(() {
                                  buttonView.removeAt(index);
                                  buttonView.insert(index, true);
                                });
                                await new Future.delayed(Duration(
                                  seconds: 3
                                ));
                                setState(() {
                                  buttonView.removeAt(index);
                                  buttonView.insert(index, false);
                                });
                                Navigator.push(context,
                                  MyCustomRoute(
                                    builder: (context) => DetailReport(user: snapshot.data.documents[index].data['user'], outlet: snapshot.data.documents[index].data['outlet'], bobotServingTime: bobot11, servingTimeGrafik: hasilServingTime, servingTimeNilai: servingTimeScore, parkingGrafik: hasilParking, parkingNilai: parkingScore, parkingNote: parkingNote, bobotParking: bobot1, greetingGrafik: hasilGreeting, greetingNilai: greetingScore, greetingNote: greetingNote, bobotGreeting: bobot2, seatingGrafik: hasilSeating, seatingNilai: seatingScore, seatingNote: seatingNote, bobotSeating: bobot3, takingOrderGrafik: hasilTakingOrder, takingOrderNilai: takingOrderScore, takingOrderNote: takingOrderNote, bobotTakingOrder: bobot4, servingProductGrafik: hasilServingProduct, servingProductNilai: servingProductScore, servingProductNote: servingProductNote, bobotServingProduct: bobot5, cleanlinessGrafik: hasilCleanliness, cleanlinessNilai: cleanlinessScore, cleanlinessNote: cleanlinessNote, bobotCleanliness: bobot6, preBushingGrafik: hasilPreBushing, preBushingNilai: preBushingScore, preBushingNote: preBushingNote, bobotPreBushing: bobot7, billingGrafik: hasilBilling, billingNilai: billingScore, billingNote: billingNote, bobotBilling: bobot8, thankingGrafik: hasilThanking, thankingNilai: thankingScore, thankingNote: thankingNote, bobotThanking: bobot9, complaintGrafik: hasilComplaint, complaintNilai: complaintScore, complaintNote: complaintNote, bobotComplaint: bobot10, userName: userName, tanggal: tanggal, waktuStart: waktuStart, waktuEnd: waktuEnd, category: category, product: product, service: service, serviceNote: serviceNote, pic: pic, complaint: complaint, index: snapshot.data.documents[index].documentID, idUser: widget.idUser, imageServingProduct: imageServingProduct, imageComplaint: imageComplaint, imageCleanliness: imageCleanliness, imageParking: imageParking, imagePreBushing: imagePreBushing, imageBilling: imageBilling, orderTimeDone: orderTimeDone, hasilGrafik: hasilGrafik, aksesStatus: widget.aksesStatus, menuName: menuName)
                                  )
                                );
                              },
                              child: Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        buttonView[index] ? 'Preparing ...' : tanggalTS.toDate().toString().substring(8, 10) + '/' + tanggalTS.toDate().toString().substring(5, 7) + '/' + tanggalTS.toDate().toString().substring(0, 4),
                                        style: TextStyle(
                                            fontSize: 13.0, color: buttonView[index] ? Colors.black54 : Colors.blue),
                                        textAlign: TextAlign.right,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      } else {
                        if (snapshot.data.documents[index].data['checkOut'] == null) {
                          return Container();
                        } else {
                          return ListTile(
                            onTap: null,
                            title: Container(
                              width: 150.0,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      snapshot.data.documents[index].data['outlet'],
                                      style: TextStyle(fontSize: 14.0, color: Colors.black54, fontWeight: FontWeight.w700),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            trailing: GestureDetector(
                              onTap: () async {
                                setState(() {
                                  imageServingProduct.clear();
                                  imageComplaint.clear();
                                  imagePreBushing.clear();
                                  imageCleanliness.clear();
                                  imageParking.clear();
                                  imageBilling.clear();

                                  complaintNote.clear();
                                  parkingNote.clear();
                                  greetingNote.clear();
                                  seatingNote.clear();
                                  takingOrderNote.clear();
                                  servingProductNote.clear();
                                  billingNote.clear();
                                  thankingNote.clear();
                                  preBushingNote.clear();
                                  cleanlinessNote.clear();

                                  parkingScore.clear();
                                  greetingScore.clear();
                                  seatingScore.clear();
                                  takingOrderScore.clear();
                                  servingProductScore.clear();
                                  complaintScore.clear();
                                  servingTimeScore.clear();
                                  billingScore.clear();
                                  thankingScore.clear();
                                  preBushingScore.clear();
                                  cleanlinessScore.clear();

                                  menuName.clear();
                                });
                                Firestore.instance.collection('mystery_shopper')
                                  .document(snapshot.data.documents[index].documentID)
                                  .snapshots()
                                  .listen((data) {
                                    setState(() {
                                      parkingScore.add(data['parking_score']);
                                      parkingNote.add(data['parking_note']);
                                      greetingScore.add(data['greeting_score']);
                                      greetingNote.add(data['greeting_note']);
                                      seatingScore.add(data['seating_score']);
                                      seatingNote.add(data['seating_note']);
                                      takingOrderScore.add(data['takingOrder_score']);
                                      takingOrderNote.add(data['takingOrder_note']);
                                      servingProductScore.add(data['servingProduct_score']);
                                      servingProductNote.add(data['servingProduct_note']);
                                      complaintScore.add(data['complaint_score']);
                                      complaintNote.add(data['complaint_note']);
                                      billingScore.add(data['billing_score']);
                                      billingNote.add(data['billing_note']);
                                      thankingScore.add(data['thanking_score']);
                                      thankingNote.add(data['thanking_note']);
                                      preBushingScore.add(data['preBushing_score']);
                                      preBushingNote.add(data['preBushing_note']);
                                      cleanlinessScore.add(data['cleanliness_score']);
                                      cleanlinessNote.add(data['cleanliness_note']);
                                      complaint = data['complaint_detail'];
                                      category = data['category'];
                                      serviceNote = data['note_service'];
                                      servingTimeScore.add(data['score']);
                                      bobotServingTime.add(data['bobot_pertanyaan']);
                                      bobot11 = double.tryParse(data['bobot'].toString());
                                      orderTimeDone.add(data['orderTimeDone']);
                                      menuName.add(data['menuName']);

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
                                      hasilGrafik = data['hasilGrafik'];

                                      imageServingProduct.add(data['servingProduct_image']);
                                      imageComplaint.add(data['complaint_image']);
                                      imagePreBushing.add(data['preBushing_image']);
                                      imageCleanliness.add(data['cleanliness_image']);
                                      imageParking.add(data['parking_image']);
                                      imageBilling.add(data['billing_image']);

                                      if (data['product'] == null) {
                                        product = '';
                                      } else {
                                        Firestore.instance.collection('product_complaint-mg').where('id', isEqualTo: data['product']).snapshots()
                                          .listen((data2) => data2.documents.forEach((doc2) {
                                            product = doc2['product'];
                                          }));
                                      }

                                      if (data['service'] == null) {
                                        service = '';
                                      } else {
                                        Firestore.instance.collection('service_complaint-mg').where('id', isEqualTo: data['service']).snapshots()
                                          .listen((data2) => data2.documents.forEach((doc2) {
                                            service = doc2['service'];
                                          }));
                                      }

                                      Firestore.instance.collection('pic_complaint-mg').where('id', isEqualTo: data['pic']).snapshots()
                                        .listen((data2) => data2.documents.forEach((doc2) {
                                          pic = doc2['pic'];
                                        }));
                                      
                                      Timestamp checkInBantu = data['checkIn'];
                                      Timestamp checkOutBantu = data['checkOut'];
                                      tanggal = checkInBantu.toDate().toString().substring(8, 10) + '/' + checkInBantu.toDate().toString().substring(5, 7) + '/' + checkInBantu.toDate().toString().substring(0, 4);
                                      waktuStart = checkInBantu.toDate().toString().substring(11, 16);
                                      if (data['checkOut'] == null) {
                                        waktuEnd = '00.00';
                                      } else {
                                        waktuEnd = checkOutBantu.toDate().toString().substring(11, 16);
                                      }
                                    });
                                  });

                                Firestore.instance.collection('parking').snapshots()
                                  .listen((data5) => data5.documents.forEach((doc5) {
                                    bobot1 = double.tryParse(doc5['bobot'].toString());
                                  }));

                                Firestore.instance.collection('greeting').snapshots()
                                  .listen((data5) => data5.documents.forEach((doc5) {
                                    bobot2 = double.tryParse(doc5['bobot'].toString());
                                  }));

                                Firestore.instance.collection('seating').snapshots()
                                  .listen((data5) => data5.documents.forEach((doc5) {
                                    bobot3 = double.tryParse(doc5['bobot'].toString());
                                  }));

                                Firestore.instance.collection('takingOrder').snapshots()
                                  .listen((data5) => data5.documents.forEach((doc5) {
                                    bobot4 = double.tryParse(doc5['bobot'].toString());
                                  }));

                                Firestore.instance.collection('servingProduct').snapshots()
                                  .listen((data5) => data5.documents.forEach((doc5) {
                                    bobot5 = double.tryParse(doc5['bobot'].toString());
                                  }));

                                Firestore.instance.collection('cleaniness').snapshots()
                                  .listen((data5) => data5.documents.forEach((doc5) {
                                    bobot6 = double.tryParse(doc5['bobot'].toString());
                                  }));

                                Firestore.instance.collection('pre-bushing').snapshots()
                                  .listen((data5) => data5.documents.forEach((doc5) {
                                    bobot7 = double.tryParse(doc5['bobot'].toString());
                                  }));

                                Firestore.instance.collection('billing').snapshots()
                                  .listen((data5) => data5.documents.forEach((doc5) {
                                    bobot8 = double.tryParse(doc5['bobot'].toString());
                                  }));

                                Firestore.instance.collection('thanking').snapshots()
                                  .listen((data5) => data5.documents.forEach((doc5) {
                                    bobot9 = double.tryParse(doc5['bobot'].toString());
                                  }));

                                Firestore.instance.collection('complaint_handling').snapshots()
                                  .listen((data5) => data5.documents.forEach((doc5) {
                                    bobot10 = double.tryParse(doc5['bobot'].toString());
                                  }));

                                Firestore.instance.collection('user').where('id', isEqualTo: snapshot.data.documents[index].data['user']).snapshots()
                                  .listen((data) => data.documents.forEach((doc) {
                                    setState(() {
                                      userName = doc['nama'];
                                    });
                                  }));
                                setState(() {
                                  buttonView.removeAt(index);
                                  buttonView.insert(index, true);
                                });
                                await new Future.delayed(Duration(
                                  seconds: 3
                                ));
                                setState(() {
                                  buttonView.removeAt(index);
                                  buttonView.insert(index, false);
                                });
                                Navigator.push(context,
                                  MyCustomRoute(
                                    builder: (context) => DetailReport(user: snapshot.data.documents[index].data['user'], outlet: snapshot.data.documents[index].data['outlet'], bobotServingTime: bobot11, servingTimeGrafik: hasilServingTime, servingTimeNilai: servingTimeScore, parkingGrafik: hasilParking, parkingNilai: parkingScore, parkingNote: parkingNote, bobotParking: bobot1, greetingGrafik: hasilGreeting, greetingNilai: greetingScore, greetingNote: greetingNote, bobotGreeting: bobot2, seatingGrafik: hasilSeating, seatingNilai: seatingScore, seatingNote: seatingNote, bobotSeating: bobot3, takingOrderGrafik: hasilTakingOrder, takingOrderNilai: takingOrderScore, takingOrderNote: takingOrderNote, bobotTakingOrder: bobot4, servingProductGrafik: hasilServingProduct, servingProductNilai: servingProductScore, servingProductNote: servingProductNote, bobotServingProduct: bobot5, cleanlinessGrafik: hasilCleanliness, cleanlinessNilai: cleanlinessScore, cleanlinessNote: cleanlinessNote, bobotCleanliness: bobot6, preBushingGrafik: hasilPreBushing, preBushingNilai: preBushingScore, preBushingNote: preBushingNote, bobotPreBushing: bobot7, billingGrafik: hasilBilling, billingNilai: billingScore, billingNote: billingNote, bobotBilling: bobot8, thankingGrafik: hasilThanking, thankingNilai: thankingScore, thankingNote: thankingNote, bobotThanking: bobot9, complaintGrafik: hasilComplaint, complaintNilai: complaintScore, complaintNote: complaintNote, bobotComplaint: bobot10, userName: userName, tanggal: tanggal, waktuStart: waktuStart, waktuEnd: waktuEnd, category: category, product: product, service: service, serviceNote: serviceNote, pic: pic, complaint: complaint, index: snapshot.data.documents[index].documentID, idUser: widget.idUser, imageServingProduct: imageServingProduct, imageComplaint: imageComplaint, imageCleanliness: imageCleanliness, imageParking: imageParking, imagePreBushing: imagePreBushing, imageBilling: imageBilling, orderTimeDone: orderTimeDone, hasilGrafik: hasilGrafik, aksesStatus: widget.aksesStatus, menuName: menuName)
                                  )
                                );
                              },
                              child: Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        buttonView[index] ? 'Preparing ...' : tanggalTS.toDate().toString().substring(8, 10) + '/' + tanggalTS.toDate().toString().substring(5, 7) + '/' + tanggalTS.toDate().toString().substring(0, 4),
                                        style: TextStyle(
                                            fontSize: 13.0, color: buttonView[index] ? Colors.black54 : Colors.blue),
                                        textAlign: TextAlign.right,
                                      ),
                                    )
                                  ],
                                ),
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
