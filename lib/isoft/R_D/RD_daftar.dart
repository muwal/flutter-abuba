import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_abuba/isoft/R_D/RD_daftar_detail.dart';
import 'package:flutter_abuba/constant.dart';

class RDdaftar extends StatefulWidget {
  final int idUser;
  RDdaftar({Key key, this.idUser}) : super(key: key);

  _RDdaftarState createState() => _RDdaftarState();
}

class _RDdaftarState extends State<RDdaftar> with TickerProviderStateMixin {
  AnimationController animationController;
  var documentID = [];
  List<dynamic> tanggalEksperimen = [];
  List<dynamic> namaProduk = [];
  List<dynamic> category = [];
  List<dynamic> eksperimenID = [];

  @override
  void initState() {
    super.initState();

    CollectionReference reference = Firestore.instance.collection('rnd_eksperimen');
    reference.snapshots().listen((data) {
      data.documentChanges.forEach((change) {
        setState(() {
          Firestore.instance.collection('product_complaint-mg').where('id', isEqualTo: change.document.data['id_product']).snapshots().listen((data2) {
            namaProduk.add(data2.documents[0].data['product']);
          });

          Firestore.instance.collection('rnd_eksperimen_category').where('id', isEqualTo: change.document.data['id_eksperimen_category']).snapshots().listen((data3) {
            category.add(data3.documents[0].data['category']);
          });
        });
      });
    });

    animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(
      from: animationController.value == 0.0
        ? 1.0
        : animationController.value
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: Scrollbar(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'R&D',
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
                        'Daftar',
                        style: TextStyle(
                            color: AbubaPallate.greenabuba, fontSize: 12.0),
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
                      )
                    : Container(
                        color: Colors.white,
                        width: width,
                        height: MediaQuery.of(context).size.height / 1.2,
                        child: Container(
                          child: StreamBuilder(
                            stream: Firestore.instance.collection('rnd_eksperimen').snapshots(),
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData)
                                return Container(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              
                              return Column(
                                children: List.generate(snapshot.data.documents.length, (index) {
                                  Timestamp tanggal = snapshot.data.documents[index].data['date_eksperimen'];

                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      index == 0
                                        ? Padding(
                                            padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                  width: width / 5,
                                                  child: Row(
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'Tanggal',
                                                          style: TextStyle(color: Colors.green),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: width / 5,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'Nama Produk',
                                                          style: TextStyle(color: Colors.green),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: width / 5,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'Category',
                                                          style: TextStyle(color: Colors.green),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Container(),
                                        snapshot.data.documents[index].data['kirim_kepada'].indexWhere((dynamic result) => int.tryParse(result.toString()) == widget.idUser) >= 0
                                          ? snapshot.data.documents[index].data['status'][snapshot.data.documents[index].data['kirim_kepada'].indexWhere((dynamic result) => int.tryParse(result.toString()) == widget.idUser)] == 'OPEN'
                                            ? snapshot.data.documents[index].data['kirim_kepada'].contains(widget.idUser)
                                                ? Padding(
                                                    padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 0.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
                                                        Container(
                                                          width: width / 5,
                                                          child: Row(
                                                            children: <Widget>[
                                                              Flexible(
                                                                child: Text(
                                                                  tanggal.toDate().toString().substring(8, 10) + '/' + tanggal.toDate().toString().substring(5, 7) + '/' +tanggal.toDate().toString().substring(0, 4),
                                                                  style: TextStyle(
                                                                      fontSize: 12.0, color: Colors.black38),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          width: width / 5,
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: <Widget>[
                                                              Flexible(
                                                                child: Text(
                                                                  namaProduk[index],
                                                                  style: TextStyle(
                                                                      fontSize: 12.0, color: Colors.black38),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          width: width / 5,
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: <Widget>[
                                                              Flexible(
                                                                child: ButtonTheme(
                                                                  minWidth: 50.0,
                                                                  height: 30.0,
                                                                  splashColor: AbubaPallate.menuBluebird,
                                                                  child: OutlineButton(
                                                                    borderSide: BorderSide(
                                                                        color: AbubaPallate.menuBluebird),
                                                                    child: Text(
                                                                      category[index],
                                                                      style: TextStyle(
                                                                          fontSize: 12.0,
                                                                          color: AbubaPallate.menuBluebird),
                                                                      textAlign: TextAlign.center,
                                                                    ),
                                                                    onPressed: () {
                                                                      Navigator.pushReplacement(context,
                                                                        MyCustomRoute(
                                                                          builder: (context) => RDdaftarDetail(idUser: widget.idUser, eksperimenID: snapshot.data.documents[index].documentID, parameter: snapshot.data.documents[index].data['id_parameter'], status: snapshot.data.documents[index].data['status'], dateApprove: snapshot.data.documents[index].data['approveDate'], indexUpdate: snapshot.data.documents[index].data['kirim_kepada'].indexWhere((dynamic result) => int.tryParse(result.toString()) == widget.idUser), score: snapshot.data.documents[index].data['scoreParameter'], note: snapshot.data.documents[index].data['catatan'],),
                                                                        )
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                : Container()
                                            : Container()
                                          : Container()
                                    ],
                                  );
                                }).toList(),
                              );
                            },
                          ),
                        )
                      );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _appBar() {
    return AppBar(
      elevation: 0.25,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      actions: <Widget>[
        IconButton(
          tooltip: 'Search',
          icon: Icon(Icons.search),
          onPressed: () {}
        )
      ],
      title: Image.asset(
        'assets/images/logo2.png',
        height: 150.0,
        width: 120.0,
      ),
    );
  }
}