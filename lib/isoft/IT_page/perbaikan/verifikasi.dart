import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_abuba/isoft/IT_page/perbaikan/detail_verifikasi.dart';
import 'package:flutter/services.dart';

class FormVerifikasi extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  FormVerifikasi({this.idUser, this.namaUser, this.departmentUser});

  @override
  _FormVerifikasiState createState() => _FormVerifikasiState();
}

class _FormVerifikasiState extends State<FormVerifikasi> with TickerProviderStateMixin {
  AnimationController animationController;

  List<dynamic> location = [];
  List<dynamic> userVerifikasi = [];
  List<dynamic> masalah = [];
  List<Timestamp> tanggal = [];
  var docID = [];
  List<String> status = [];
  List<String> statusPerbaikan = [];
  List<int> userVerifikasiID = [];

  @override
  void initState() {
    super.initState();
    CollectionReference reference = Firestore.instance.collection('perbaikanIT');
    reference.snapshots().listen((querySnapshot) {
      querySnapshot.documentChanges.forEach((change) {
        setState(() {
          docID.add(change.document.documentID);
          tanggal.add(change.document.data['dueDate']);
          userVerifikasiID.add(change.document.data['userVerifikasi']);
          status.add(change.document.data['status']);
          statusPerbaikan.add(change.document.data['statusPerbaikan']);

          Firestore.instance.collection('lokasi').where('id', isEqualTo: change.document.data['lokasi']).snapshots().listen((data) {
            location.add(data.documents[0].data['lokasi']);
          });
          Firestore.instance.collection('user').where('id', isEqualTo: change.document.data['pic']).snapshots().listen((data2) {
            userVerifikasi.add(data2.documents[0].data['nama']);
          });
          Firestore.instance.collection('perbaikanMasalah').where('id', isEqualTo: change.document.data['masalah']).snapshots().listen((data2) {
            masalah.add(data2.documents[0].data['masalah']);
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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Color(0xfff9f9f9),),
      child: SafeArea(
        child: Scaffold(
          appBar: _appBar(),
          body: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
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
                      children: List.generate(masalah.length, (index) {
                        if (status[index] == 'APPROVED') {
                          return Container();
                        } else {
                          if (userVerifikasiID[index] == widget.idUser) {
                            if (statusPerbaikan[index] == 'CLOSE') {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                verticalDirection: VerticalDirection.down,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                                    color: Colors.white,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 15.0, bottom: 15.0),
                                        child: Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Icon(Icons.location_on, color: Colors.grey, size: 16.0),
                                                  Flexible(
                                                    child: Text(
                                                      location[index],
                                                      style: TextStyle(
                                                          fontSize: 15.0,
                                                          fontWeight: FontWeight.w400,
                                                          color: Colors.black87
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      masalah[index],
                                                      style: TextStyle(
                                                          fontSize: 20.0,
                                                          fontWeight: FontWeight.w700,
                                                          color: AbubaPallate.greenabuba
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 15.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      tanggal[index].toDate().toString().substring(8, 10) + '/' + tanggal[index].toDate().toString().substring(5, 7) + '/' +tanggal[index].toDate().toString().substring(0, 4),
                                                      style: TextStyle(
                                                          fontSize: 14.0,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.black54
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Column(
                                                    children: <Widget>[
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: <Widget>[
                                                            Flexible(
                                                              child: Text(
                                                                'PIC',
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
                                                        padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: <Widget>[
                                                            Flexible(
                                                              child: Text(
                                                                userVerifikasi[index],
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
                                                ButtonTheme(
                                                  minWidth: 50.0,
                                                  height: 30.0,
                                                  child: OutlineButton(
                                                    child: Text(
                                                      'FOLLOW UP',
                                                      style: TextStyle(
                                                          fontSize: 13.0,
                                                          color: AbubaPallate.menuBluebird,
                                                          fontWeight: FontWeight.bold
                                                      ),
                                                    ),
                                                    borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 2.0),
                                                    highlightedBorderColor: AbubaPallate.menuBluebird,
                                                    splashColor: AbubaPallate.menuBluebird,
                                                    onPressed: () {
                                                      Navigator.pushReplacement(context,
                                                          MaterialPageRoute(
                                                              builder: (_) => DetailVerifikasi(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser, index: docID[index])
                                                          )
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.black26,
                                    height: 1.0,
                                  )
                                ],
                              );
                            } else {
                              return Container();
                            }
                          } else {
                            return Container();
                          }
                        }
                      }).toList()
                  );
                },
              )
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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text('Verifikasi', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black),),
          )
        ],
      ),
    );
  }
}