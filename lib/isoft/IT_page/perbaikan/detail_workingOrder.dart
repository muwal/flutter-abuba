import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/isoft/IT_page/perbaikan/working_order.dart';
import 'package:intl/intl.dart';
import 'package:search_widget/search_widget.dart';

class LeaderBoard {
  final String name;
  final int id;

  LeaderBoard(this.name, this.id);
}

class DetailWorkingOrder extends StatefulWidget {
  DetailWorkingOrder({this.idUser, this.namaUser, this.departmentUser, this.index});

  final int idUser;
  final String namaUser;
  final String departmentUser;
  var index;

  @override
  _DetailWorkingOrderState createState() => _DetailWorkingOrderState();
}

class _DetailWorkingOrderState extends State<DetailWorkingOrder> with TickerProviderStateMixin {
  AnimationController animationController;

  Timestamp tanggal;
  int no;
  String nama;
  String category;
  String area;
  String lokasi;
  String item;
  String masalah;
  String detailMasalah;
  String pic;
  String identitasNo;
  bool showNote = false;
  String statusPerbaikan;
  String status;
  DateTime dueDate;
  final dateFormat = DateFormat("MMMM d, yyyy");
  String departmentCreated;

  bool isProcess = false;

  List<dynamic> data2 = [];
  List<dynamic> data3 = [];

  Color _colorLowSe = Colors.grey;
  Color _colorMedSe = Colors.grey;
  Color _colorHighSe = Colors.grey;

  List<LeaderBoard> listPIC = <LeaderBoard>[];
  int selectedPIC;

  int managerIT;
  int asManagerIT;

  @override
  void initState() {
    super.initState();
    
    Firestore.instance.collection('perbaikanIT').document(widget.index).snapshots().listen((data) {
      setState(() {
        no = data.data['perbaikanNo'];
        tanggal = data.data['dateCreated'];
        detailMasalah = data.data['detailMasalah'];
        statusPerbaikan = data.data['statusPerbaikan'];
        status = data.data['status'];

        item = data.data['item'];
        identitasNo = data.data['itemNo'];

        Firestore.instance.collection('user').where('id', isEqualTo: data.data['userCreated']).snapshots().listen((data2) {
          Firestore.instance.collection('department').where('id', isEqualTo: data2.documents[0].data['departmentID']).snapshots().listen((dataDepartment) {
//            if (dataDepartment.documents[0].data['department'] == 'IT') {
//              if (data2.documents[0].data['id'] != widget.idUser) {
                nama = data2.documents[0].data['nama'];
                departmentCreated = dataDepartment.documents[0].data['department'];
//              } else {
//                nama = '-';
//                departmentCreated = '-';
//              }
//            }
          });
        });

        Firestore.instance.collection('perbaikanMasalah').where('id', isEqualTo: data.data['masalah']).snapshots().listen((data3) {
          masalah = data3.documents[0].data['masalah'];
        });

        Firestore.instance.collection('lokasi').where('id', isEqualTo: data.data['lokasi']).snapshots().listen((data4) {
          lokasi = data4.documents[0].data['lokasi'];
        });

        Firestore.instance.collection('outlet').where('id', isEqualTo: data.data['area']).snapshots().listen((data7) {
          area = data7.documents[0].data['nama_outlet'];
        });

        Firestore.instance.collection('perbaikanCategory').where('id', isEqualTo: data.data['category']).snapshots().listen((data5) {
          category = data5.documents[0].data['category'];
        });
      });
    });

    CollectionReference reference = Firestore.instance.collection('user');
    reference.orderBy('nama', descending: false).snapshots().listen((data) {
      data.documentChanges.forEach((change) {
        setState(() {
          if (change.document.data['departmentID'] == 3) {
            if (change.document.data['id'] != widget.idUser) {
              listPIC.add(LeaderBoard(change.document.data['nama'], change.document.data['id']));
            }
          }
        });
      });
    });

    animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(
      from: animationController.value == 0.0
        ? 1.0
        : animationController.value
    );

    Firestore.instance.collection('user').where('grade', isEqualTo: 'Manager').where('department', isEqualTo: 'IT').snapshots().listen((getDataManagerIT) {
      setState(() {
        managerIT = getDataManagerIT.documents[0].data['id'];
      });
    });

    Firestore.instance.collection('user').where('grade', isEqualTo: 'Assistant Manager').where('department', isEqualTo: 'IT').snapshots().listen((getAsManagerIT) {
      setState(() {
        asManagerIT = getAsManagerIT.documents[0].data['id'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double size = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.25,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Text('Detail', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black),),
              )
            ],
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: _bodyForm(size),
        ),
      ),
    );
  }

  Widget _bodyForm(double size) {
    return Scrollbar(
      child: ListView(
        children: <Widget>[
          AnimatedBuilder(
            animation: animationController,
            builder: (_, Widget child) {
              return animationController.isAnimating
                ? Container(
                    child: Center(
                      child:CircularProgressIndicator()
                    ),
                  )
                : Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(bottom: 5.0, top: 20.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Data Permintaan',
                                        style: TextStyle(
                                          fontSize: 15.0, color: Colors.black87, fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        '# Report',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        no.toString().padLeft(4, '0'),
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Tgl Permintaan',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        tanggal.toDate().toString().substring(8, 10) + '/' + tanggal.toDate().toString().substring(5, 7) + '/' + tanggal.toDate().toString().substring(0, 4),
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Dibuat Oleh',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        nama,
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Department',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        departmentCreated,
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 5.0),
                          child: Divider(
                            height: 5.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Data Asset',
                                        style: TextStyle(
                                          fontSize: 15.0, color: Colors.black87, fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Area',
                                        style: TextStyle(
                                            fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        area,
                                        style: TextStyle(
                                            fontSize: 13.0,
                                            color: Colors.black38,
                                            fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Asset',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        item,
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Nomor',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        identitasNo,
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Lokasi',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        lokasi,
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 5.0),
                          child: Divider(
                            height: 5.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Data Masalah',
                                        style: TextStyle(
                                          fontSize: 15.0, color: Colors.black87, fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Kategori Masalah',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        category,
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Masalah',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        masalah,
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                        ),
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Detail Masalah',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        detailMasalah,
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                        ),
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        asManagerIT == widget.idUser
                          ? Container(
                              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Tooltip(
                                    message: '14 hari',
                                    child: ButtonTheme(
                                      height: 30.0,
                                      child: RaisedButton(
                                        shape: new RoundedRectangleBorder(
                                          borderRadius:
                                          new BorderRadius.circular(5.0),
                                          side:
                                          BorderSide(
                                            width: 1.5,
                                            color: _colorLowSe == Colors.grey ? Colors.green : Colors.white,
                                          ),
                                        ),
                                        child: Text(
                                          'Low',
                                          style: TextStyle(
                                              color: _colorLowSe == Colors.grey ? Colors.green : Colors.white),
                                          textAlign:
                                          TextAlign
                                              .center,
                                        ),
                                        color: _colorLowSe == Colors.grey ? Colors.white : Colors.green,
                                        onPressed: () {
                                          setState(() {
                                            _colorLowSe = Colors.green[400];
                                            _colorMedSe = Colors.grey;
                                            _colorHighSe = Colors.grey;

                                            dueDate = DateTime.now().add(Duration(days: 14));
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Tooltip(
                                    message: '7 hari',
                                    child: ButtonTheme(
                                      height: 30.0,
                                      child: RaisedButton(
                                        shape:
                                        new RoundedRectangleBorder(
                                          borderRadius:
                                          new BorderRadius
                                              .circular(
                                              5.0),
                                          side:
                                          BorderSide(
                                            width: 1.5,
                                            color: _colorMedSe == Colors.grey ? Colors.orangeAccent : Colors.white,
                                          ),
                                        ),
                                        child: Text(
                                          'Medium',
                                          style: TextStyle(
                                              color: _colorMedSe == Colors.grey ? Colors.orangeAccent : Colors.white),
                                          textAlign:
                                          TextAlign
                                              .center,
                                        ),
                                        color: _colorMedSe == Colors.grey ? Colors.white : Colors.orangeAccent,
                                        onPressed: () {
                                          setState(() {
                                            _colorLowSe = Colors.grey;
                                            _colorMedSe = Colors.orangeAccent;
                                            _colorHighSe = Colors.grey;

                                            dueDate = DateTime.now().add(Duration(days: 7));
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Tooltip(
                                    message: '1 hari',
                                    child: ButtonTheme(
                                      height: 30.0,
                                      child: RaisedButton(
                                        shape:
                                        new RoundedRectangleBorder(
                                          borderRadius:
                                          new BorderRadius
                                              .circular(
                                              5.0),
                                          side:
                                          BorderSide(
                                            width: 1.5,
                                            color: _colorHighSe == Colors.grey ? Colors.redAccent : Colors.white,
                                          ),
                                        ),
                                        child: Text(
                                          'High',
                                          style: TextStyle(
                                              color: _colorHighSe == Colors.grey ? Colors.redAccent : Colors.white),
                                          textAlign:
                                          TextAlign
                                              .center,
                                        ),
                                        color: _colorHighSe == Colors.grey ? Colors.white : Colors.redAccent,
                                        onPressed: () {
                                          setState(() {
                                            _colorLowSe = Colors.grey;
                                            _colorMedSe = Colors.grey;
                                            _colorHighSe = Colors.redAccent;

                                            dueDate = DateTime.now().add(Duration(days: 1));
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                        asManagerIT == widget.idUser
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
                              child: SearchWidget<LeaderBoard>(
                                dataList: listPIC,
                                hideSearchBoxWhenItemSelected: true,
                                listContainerHeight: MediaQuery.of(context).size.height / 4,
                                queryBuilder: (String query, List<LeaderBoard> list) {
                                  return list.where((LeaderBoard item) => item.name.toLowerCase().contains(query.toLowerCase())).toList();
                                },
                                popupListItemBuilder: (LeaderBoard item) {
                                  return Container(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text(
                                      item.name,
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  );
                                },
                                selectedItemBuilder: (LeaderBoard selectedItem, VoidCallback deleteSelectedItem) {
                                  selectedPIC = selectedItem.id;

                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 2.0,
                                      horizontal: 4.0,
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 16,
                                              right: 16,
                                              top: 8,
                                              bottom: 8,
                                            ),
                                            child: Text(
                                              selectedItem.name,
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.delete_outline, size: 22),
                                          color: Colors.grey[700],
                                          onPressed: deleteSelectedItem,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                // widget customization
                                noItemsFoundWidget: Container(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Icon(
                                        Icons.folder_open,
                                        size: 24,
                                        color: Colors.grey[900].withOpacity(0.7),
                                      ),
                                      SizedBox(width: 10.0),
                                      Text(
                                        "No Items Found",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.grey[900].withOpacity(0.7),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                textFieldBuilder: (TextEditingController controllerCategory, FocusNode focusNodeCategory) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                    child: TextField(
                                      controller: controllerCategory,
                                      focusNode: focusNodeCategory,
                                      style: new TextStyle(fontSize: 16, color: Colors.grey[600]),
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Color(0x4437474F)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                        ),
                                        border: InputBorder.none,
                                        hintText: "PIC",
                                        hintStyle: TextStyle(
                                          fontSize: 14.0
                                        ),
                                        contentPadding: EdgeInsets.only(
                                          left: 16,
                                          right: 20,
                                          top: 14,
                                          bottom: 14,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Container(),
                        asManagerIT == widget.idUser
                          ? Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              padding: const EdgeInsets.fromLTRB(0.0, 20.0, 10.0, 20.0),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                dueDate == null ? 'Due Date' : dueDate.toString().substring(8, 10) + '/' + dueDate.toString().substring(5, 7) + '/' + dueDate.toString().substring(0, 4),
                                style: TextStyle(
                                  color: Colors.black87
                                ),
                              )
                            )
                          : Container(),
                        asManagerIT == widget.idUser
                          ? Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                            child: ButtonTheme(
                              minWidth: 50.0,
                              height: 40.0,
                              child: RaisedButton(
                                elevation: 0.0,
                                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
                                textColor: Colors.white,
                                color: AbubaPallate.greenabuba,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    isProcess
                                      ? Container(
                                          padding: EdgeInsets.symmetric(vertical: 5.0),
                                          child: Center(
                                            child: SizedBox(
                                              height: 15.0,
                                              width: 15.0,
                                              child: CircularProgressIndicator(
                                                valueColor: AlwaysStoppedAnimation(Colors.white),
                                                strokeWidth: 1.5,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                    isProcess
                                      ? SizedBox(
                                          width: 10.0,
                                        )
                                      : Container(),
                                    Text(
                                      'SAVE'
                                    )
                                  ],
                                ),
                                onPressed: () {
                                  if (selectedPIC != null && dueDate != null) {
                                    if (isProcess == false) {
                                      setState(() {
                                        isProcess = true;
                                      });

                                      DocumentReference docReference = Firestore.instance.collection('perbaikanIT').document(widget.index);

                                      docReference.updateData({
                                        'pic': int.tryParse(selectedPIC.toString()),
                                        'dueDate': dueDate,
                                        'status': 'OPEN',
                                        'statusPerbaikan': 'OPEN'
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
                                                    height: 50.0,
                                                    child: Center(
                                                      child: Text(
                                                        'SUCCESSFUL!',
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
                                                      'Perbaikan No. PRB-${no.toString().padLeft(4, '0')}',
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
                                        ).whenComplete(() {
                                          Navigator.pushReplacement(context,
                                            MaterialPageRoute(
                                              builder: (_) => WorkingOrder(departmentUser: widget.departmentUser, idUser: widget.idUser, namaUser: widget.namaUser)
                                            )
                                          );
                                        });
                                      }).catchError((error) {
                                        print(error);
                                      });
                                    } else {

                                    }
                                  } else {
                                    setState(() {
                                      isProcess = false;
                                    });
                                  }
                                },
                              ),
                            )
                          )
                        : Container(),
                      ],
                    )
                  );
            },
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
//        itemCount: 10,
      ),
    );
  }
}
