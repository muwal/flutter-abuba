import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_abuba/misteri_shop/outlet/form_after_checkin.dart';

class FormCheckIn extends StatefulWidget {
  final String outlet;
  final int idOutlet;
  final String imageOutlet;
  final String alamatOutlet;
  final int idUser;
  FormCheckIn({this.outlet,this.imageOutlet,this.alamatOutlet,this.idOutlet,this.idUser});

  @override
  _FormCheckInState createState() => _FormCheckInState();
}

class _FormCheckInState extends State<FormCheckIn> {
  DateTime checkinNow = DateTime.now();
  var maxid;
  var index;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AbubaAppBar(),
        body: Scrollbar(
          child: ListView(
            children: <Widget>[
              Container(
                height: 400.0,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Column(
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
                              style: TextStyle(
                                  color: AbubaPallate.greenabuba, fontSize: 12.0),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15.0),
                            child: Text(
                              'Location',
                              style: TextStyle(
                                  color: AbubaPallate.greenabuba, fontSize: 12.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 20.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Welcome to ${widget.outlet}',
                                  style: TextStyle(
                                      color: AbubaPallate.greenabuba,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20.0),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  widget.alamatOutlet,
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.black54),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          ButtonTheme(
                            minWidth: 50.0,
                            height: 40.0,
                            child: RaisedButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(5.0)),
                              child: Text(
                                'CHECK IN',
                                style:
                                TextStyle(fontSize: 13.0, color: Colors.white),
                              ),
                              color: Colors.green,
                              onPressed: () {
                                Firestore.instance
                                    .collection('dumper_mystery_shopper')
                                    .snapshots()
                                    .listen((data) => data.documents.forEach((doc) {
                                  setState(() {
                                    maxid = doc['max_id'];
                                    index = data.documents[0].reference;
                                  });
                                }));
                                Firestore.instance.runTransaction((Transaction transaction) async {
                                  CollectionReference reference = Firestore.instance.collection('mystery_shopper');
                                  await reference.add({
                                    'id': maxid + 1,
                                    'user': widget.idUser,
                                    'checkIn': checkinNow,
                                    'checkOut': null,
                                    'outlet': widget.idOutlet
                                  });

                                  DocumentSnapshot snapshot = await transaction.get(index);
                                  await transaction.update(snapshot.reference, {
                                    'max_id': maxid + 1,
                                  });
                                });
                                // print(maxid_bantu);
                                Navigator.push(context,
                                  MyCustomRoute(
                                    builder: (context) => FormSuasanaResto(idOutlet: widget.idOutlet,alamatOutlet: widget.alamatOutlet,outlet: widget.outlet,imageOutlet: widget.imageOutlet,idUser: widget.idUser, idMysteryGuest: maxid),
                                  )
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Image.asset(
                  'assets/images/slide2.png',
                  fit: BoxFit.fitWidth,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}