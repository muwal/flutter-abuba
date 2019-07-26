import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FormCreateKitchen extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  FormCreateKitchen({this.idUser, this.namaUser, this.departmentUser});

  @override
  _FormCreateKitchenState createState() => _FormCreateKitchenState();
}

class _FormCreateKitchenState extends State<FormCreateKitchen> with TickerProviderStateMixin {
  AnimationController animationController;

  String _sumber;
  String _selectionSumber;
  List<Map> _sumberJSON = [
    {"id": 1, "sumber": "F 4444 AE"},
    {"id": 2, "sumber": "F 5555 AB"},
  ];

  String _selectionSupir;
  List<Map> _supirJSON = [
    {"id": 1, "sumber": "Farid"},
    {"id": 2, "sumber": "Rifai"},
  ];

  String _selectionCust;
  List<Map> _custJSON = [
    {"id": 1, "sumber": "Farid"},
    {"id": 2, "sumber": "Rifai"},
  ];



  Color _colorLowLi = Colors.grey;
  Color _colorHighLi = Colors.grey;

  int indexKitchen = 0;
  int jumlahKitchen = 0;
  List<int> scoreKitchen = [];
  List<String> warnaKitchen = [];
  List<dynamic> pertanyaanKitchen = [];

  String _risk = '';
  Color _colorRisk = Colors.grey;

  var dumperID;
  int maxid_kitchen;
  var index_kitchen;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(
        from:
            animationController.value == 0.0 ? 1.0 : animationController.value);

    setState(() {
      Firestore.instance
          .collection('kitchenQuestion')
          .snapshots()
          .listen((data) {
        jumlahKitchen = data.documents[0].data['pertanyaan'].length;
        pertanyaanKitchen = data.documents[0].data['pertanyaan'];
      });
    });

    Firestore.instance.collection('dumper_maxid').snapshots().listen((data) {
      setState(() {
        maxid_kitchen= data.documents[0].data['maxid_kitchen'];
        dumperID = data.documents[0].data['maxid_kitchen'] + 1;
        index_kitchen = data.documents[0].documentID;
      });
    });
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
            child: _buildCreate(context)),
      ),
    );
  }

  Widget _buildCreate(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: Text(
                  'Kitchen',
                  style: TextStyle(color: Colors.black12, fontSize: 12.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  '|',
                  style:
                      TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                ),
              ),
              Flexible(
                child: Text(
                  'Create New',
                  style:
                      TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                ),
              ),
            ],
          ),
        ),
        AnimatedBuilder(
            animation: animationController,
            builder: (_, Widget child) {
              return Scrollbar(
                  child: animationController.isAnimating
                      ? Center(
                          child: Container(
                            child: CircularProgressIndicator(),
                            alignment: Alignment(0.0, 0.0),
                            height: MediaQuery.of(context).size.height - 150.0,
                          ),
                        )
                      : Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            children: <Widget>[
                              DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  labelText: 'No. Polisi',
                                  labelStyle: TextStyle(fontSize: 14.0),
                                ),
                                value: _selectionSumber,
                                onChanged: (String value) {
                                  setState(() {
                                    switch (int.tryParse(value)) {
                                      case 1:
                                        _sumber = 'A';
                                        break;
                                      case 2:
                                        _sumber = 'B';
                                        break;
                                      default:
                                        _sumber = '-';
                                        break;
                                    }
                                    _selectionSumber = value;
                                  });
                                },
                                items: _sumberJSON.map((Map map) {
                                  return DropdownMenuItem(
                                    value: map['sumber'].toString(),
                                    child: Text(map['sumber']),
                                  );
                                }).toList(),
                              ),
                              DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  labelText: 'Nama Sopir',
                                  labelStyle: TextStyle(fontSize: 14.0),
                                ),
                                value: _selectionSupir,
                                onChanged: (String value) {
                                  setState(() {
                                    switch (int.tryParse(value)) {
                                      case 1:
                                        _sumber = 'A';
                                        break;
                                      case 2:
                                        _sumber = 'B';
                                        break;
                                      default:
                                        _sumber = '-';
                                        break;
                                    }
                                    _selectionSupir= value;
                                  });
                                },
                                items: _supirJSON.map((Map map) {
                                  return DropdownMenuItem(
                                    value: map['sumber'].toString(),
                                    child: Text(map['sumber']),
                                  );
                                }).toList(),
                              ),
                              DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  labelText: 'Nama Customer',
                                  labelStyle: TextStyle(fontSize: 14.0),
                                ),
                                value: _selectionCust,
                                onChanged: (String value) {
                                  setState(() {
                                    switch (int.tryParse(value)) {
                                      case 1:
                                        _sumber = 'A';
                                        break;
                                      case 2:
                                        _sumber = 'B';
                                        break;
                                      default:
                                        _sumber = '-';
                                        break;
                                    }
                                    _selectionCust = value;
                                  });
                                },
                                items: _custJSON.map((Map map) {
                                  return DropdownMenuItem(
                                    value: map['sumber'].toString(),
                                    child: Text(map['sumber']),
                                  );
                                }).toList(),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: Divider(
                                  height: 5.0,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Parameter',
                                      style: TextStyle(
                                          color: AbubaPallate.greenabuba,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10.0),
                                child: ListView(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  children: List.generate(jumlahKitchen, (index) {
                                    indexKitchen = index;
                                    String counter = (index + 1).toString();
                                    if (scoreKitchen.length <
                                        jumlahKitchen) {
                                      for (int a = 0;
                                      a < jumlahKitchen;
                                      a++) {
                                        scoreKitchen.add(2);

                                        warnaKitchen.add('hijau');
                                      }
                                    }

                                    return Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                width: 180.0,
                                                child: Row(
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        '${counter + '. ' + pertanyaanKitchen[index]}',
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
                                                  MainAxisAlignment.spaceAround,
                                                  children: <Widget>[
                                                    Container(
                                                      padding: EdgeInsets.only(right: 5.0),
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
                                                              color: warnaKitchen.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaKitchen[index] ==
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
                                                              color: warnaKitchen.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  255,
                                                                  40,
                                                                  0)
                                                                  : warnaKitchen[index] ==
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
                                                          color: warnaKitchen
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaKitchen[index] ==
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
                                                              scoreKitchen
                                                                  .removeAt(
                                                                  index);
                                                              scoreKitchen
                                                                  .insert(
                                                                  index,
                                                                  0);
                                                              warnaKitchen
                                                                  .removeAt(
                                                                  index);
                                                              warnaKitchen
                                                                  .insert(
                                                                  index,
                                                                  'merah');

                                                              print(scoreKitchen);
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
                                                              color: warnaKitchen.length ==
                                                                  0
                                                                  ? Color.fromARGB(
                                                                  170,
                                                                  192,
                                                                  192,
                                                                  192)
                                                                  : warnaKitchen[index] ==
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
                                                            'YES',
                                                            style: TextStyle(
                                                                fontSize:
                                                                18.0,
                                                                color: warnaKitchen.length ==
                                                                    0
                                                                    ? Color.fromARGB(
                                                                    170,
                                                                    50,
                                                                    205,
                                                                    50)
                                                                    : warnaKitchen[index] == 'hijau'
                                                                    ? Colors.white
                                                                    : Color.fromARGB(170, 50, 205, 50)),
                                                            textAlign:
                                                            TextAlign
                                                                .center,
                                                          ),
                                                          color: warnaKitchen
                                                              .length ==
                                                              0
                                                              ? Colors
                                                              .white
                                                              : warnaKitchen[index] ==
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
                                                              scoreKitchen
                                                                  .removeAt(
                                                                  index);
                                                              scoreKitchen
                                                                  .insert(
                                                                  index,
                                                                  2);
                                                              warnaKitchen
                                                                  .removeAt(
                                                                  index);
                                                              warnaKitchen
                                                                  .insert(
                                                                  index,
                                                                  'hijau');

                                                              print(scoreKitchen);
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
                                          ),
                                        )
                                      ],
                                    );
                                  }),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Divider(
                                  height: 5.0,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(right: 5.0),
                                      child: ButtonTheme(
                                        minWidth: 100.0,
                                        height: 30.0,
                                        child: RaisedButton(
                                          color: AbubaPallate.menuFood,
                                          child: Text(
                                            'REJECT',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            DateTime dateCreated = DateTime.now();

                                            DocumentReference documentReference2 = Firestore.instance.collection('dumper_maxid').document(index_kitchen);

                                            documentReference2.updateData({
                                              'maxid_kitchen': dumperID
                                            }).then((doc2) {
                                              print('success');
                                            }).catchError((error2) {
                                              print(error2);
                                            });

                                            DocumentReference docReference = Firestore.instance.collection('kitchen').document();

                                            docReference.setData({
                                              'noPolisi': _selectionSumber,
                                              'namaSupir': _selectionSupir,
                                              'namaCust': _selectionCust,
                                              'pertanyaan': pertanyaanKitchen,
                                              'userCreated': widget.namaUser,
                                              'dateCreated': dateCreated,
                                              'scorePertanyaan': scoreKitchen,
                                              'maxid': dumperID,
                                              'status': 'Rejected'
                                            }).then((doc) {
                                              /*finalAreaLuar = hasilAreaLuar *
                                                        bobotBantuAreaLuar;*/
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
                                                                .menuFood,
                                                            height:
                                                            50.0,
                                                            child:
                                                            Center(
                                                              child:
                                                              Text(
                                                                'REJECTED!',
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
                                                              'Kitchen No. K-${maxid_kitchen.toString().padLeft(4, '0')}',
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
                                              print(docReference.documentID);
                                            }).catchError((error) {
                                              print(error);
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    ButtonTheme(
                                      minWidth: 100.0,
                                      height: 30.0,
                                      child: RaisedButton(
                                        color: AbubaPallate.greenabuba,
                                        child: Text(
                                          'APPROVE',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          DateTime dateCreated = DateTime.now();

                                          DocumentReference documentReference2 = Firestore.instance.collection('dumper_maxid').document(index_kitchen);

                                          documentReference2.updateData({
                                            'maxid_kitchen': dumperID
                                          }).then((doc2) {
                                            print('success');
                                          }).catchError((error2) {
                                            print(error2);
                                          });

                                          DocumentReference docReference = Firestore.instance.collection('kitchen').document();

                                          docReference.setData({
                                            'noPolisi': _selectionSumber,
                                            'namaSupir': _selectionSupir,
                                            'namaCust': _selectionCust,
                                            'pertanyaan': pertanyaanKitchen,
                                            'userCreated': widget.namaUser,
                                            'dateCreated': dateCreated,
                                            'scorePertanyaan': scoreKitchen,
                                            'maxid': dumperID,
                                            'status': 'Approved'
                                          }).then((doc) {
                                            /*finalAreaLuar = hasilAreaLuar *
                                                      bobotBantuAreaLuar;*/
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
                                                              'APPROVED!',
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
                                                            'Kitchen No. K-${maxid_kitchen.toString().padLeft(4, '0')}',
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
                                            print(docReference.documentID);
                                          }).catchError((error) {
                                            print(error);
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ));
            })
      ],
    );
  }
}
