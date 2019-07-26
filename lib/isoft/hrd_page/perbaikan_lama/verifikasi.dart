import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_abuba/isoft/hrd_page/perbaikan/detail_verifikasi.dart';

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
    CollectionReference reference = Firestore.instance.collection('perbaikan');
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
          Firestore.instance.collection('user').where('id', isEqualTo: change.document.data['userVerifikasi']).snapshots().listen((data2) {
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
    return SafeArea(
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
                            return Container(
                              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                              child: Card(
                                elevation: 4.0,
                                child: Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.symmetric(vertical: 15.0),
                                  child: Column(
                                    children: <Widget>[
                                      Center(
                                        child: RichText(
                                          softWrap: true,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.visible,
                                          text: TextSpan(
                                            text: masalah[index],
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                              fontSize: 18.0,
                                            ),
                                          )
                                        )
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  tanggal[index].toDate().toString().substring(8, 10) + '/' + tanggal[index].toDate().toString().substring(5, 7) + '/' +tanggal[index].toDate().toString().substring(0, 4),
                                                  style: TextStyle(
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black87
                                                  ),
                                                ),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: <Widget>[
                                                    RichText(
                                                      softWrap: true,
                                                      textAlign: TextAlign.center,
                                                      overflow: TextOverflow.visible,
                                                      text: TextSpan(
                                                        text: userVerifikasi[index],
                                                        style: TextStyle(
                                                          fontSize: 14.0,
                                                          fontWeight: FontWeight.w300,
                                                          color: Colors.black45
                                                        ),
                                                      ),
                                                    ),
                                                    RichText(
                                                      softWrap: true,
                                                      textAlign: TextAlign.center,
                                                      overflow: TextOverflow.visible,
                                                      text: TextSpan(
                                                        text: location[index],
                                                        style: TextStyle(
                                                          fontSize: 14.0,
                                                          fontWeight: FontWeight.w300,
                                                          color: Colors.black45
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 5.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: <Widget>[
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
                                            )
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ),
                              ),
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
          Image.asset(
            'assets/images/logo2.png',
            height: 150.0,
            width: 120.0,
          ),
          new Container(
            child: new Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        color: Colors.red[500],
                        size: 20.0,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        '41 pts',
                        style: TextStyle(fontSize: 12.0, color: Colors.grey),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
