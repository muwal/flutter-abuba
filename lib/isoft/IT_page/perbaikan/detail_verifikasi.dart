import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class DetailVerifikasi extends StatefulWidget {
  DetailVerifikasi({this.idUser, this.namaUser, this.departmentUser, this.index});

  final int idUser;
  final String namaUser;
  final String departmentUser;
  var index;

  @override
  _DetailVerifikasiState createState() => _DetailVerifikasiState();
}

class _DetailVerifikasiState extends State<DetailVerifikasi> with TickerProviderStateMixin {
  AnimationController animationController;
  bool verify = false;

  Timestamp tanggal;
  int no;
  String nama;
  String category;
  String lokasi;
  String item;
  String masalah;
  String detailMasalah;
  Timestamp dueDate;
  String pic;
  String identitasNo;
  bool showNote = false;
  String statusPerbaikan;
  String note;
  Timestamp doneDate;
  var ratingChiller = 0.0;

  @override
  void initState() {
    super.initState();
    
    Firestore.instance.collection('perbaikanIT').document(widget.index).snapshots().listen((data) {
      setState(() {
        no = data.data['perbaikanNo'];
        tanggal = data.data['dateCreated'];
        detailMasalah = data.data['detailMasalah'];
        dueDate = data.data['dueDate'];
        statusPerbaikan = data.data['statusPerbaikan'];
        note = data.data['notePerbaikan'];
        doneDate = data.data['datePerbaikan'];

        item = data.data['item'];
        identitasNo = data.data['itemNo'];

        Firestore.instance.collection('user').where('id', isEqualTo: data.data['userCreated']).snapshots().listen((data2) {
          nama = data2.documents[0].data['nama'];
        });

        Firestore.instance.collection('user').where('id', isEqualTo: data.data['pic']).snapshots().listen((data7) {
          pic = data7.documents[0].data['nama'];
        });

        Firestore.instance.collection('perbaikanMasalah').where('id', isEqualTo: data.data['masalah']).snapshots().listen((data3) {
          masalah = data3.documents[0].data['masalah'];
        });

        Firestore.instance.collection('lokasi').where('id', isEqualTo: data.data['lokasi']).snapshots().listen((data4) {
          lokasi = data4.documents[0].data['lokasi'];
        });

        Firestore.instance.collection('perbaikanCategory').where('id', isEqualTo: data.data['category']).snapshots().listen((data5) {
          category = data5.documents[0].data['category'];
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
                : statusPerbaikan == 'CLOSE'
                    ? Container(
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 15.0, bottom: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: size * 0.35,
                                    child: Row(
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            nama,
                                            style: TextStyle(
                                                fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: size * 0.35,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            '#PRB-${no.toString().padLeft(4, '0')}',
                                            style: TextStyle(
                                                fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: size * 0.35,
                                    child: Row(
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            'Verificator',
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black38,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: size * 0.35,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            tanggal.toDate().toString().substring(8, 10) + '/' + tanggal.toDate().toString().substring(5, 7) + '/' + tanggal.toDate().toString().substring(0, 4),
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black38,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12.0),
                              child: Divider(
                                height: 6.0,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: size * 0.35,
                                    child: Row(
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            category,
                                            style: TextStyle(
                                                fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: size * 0.35,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            identitasNo,
                                            style: TextStyle(
                                                fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: size * 0.35,
                                    child: Row(
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            item,
                                            style: TextStyle(
                                                fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: size * 0.35,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            'No. Identitas',
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black38,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12.0),
                              child: Divider(
                                height: 6.0,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: size * 0.25,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            nama,
                                            style: TextStyle(
                                                fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: size * 0.25,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            pic,
                                            style: TextStyle(
                                              fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: size * 0.25,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            statusPerbaikan == 'CLOSE'
                                              ? doneDate.toDate().toString().substring(8, 10) + '/' + doneDate.toDate().toString().substring(5, 7) + '/' + doneDate.toDate().toString().substring(0, 4)
                                              : dueDate.toDate().toString().substring(8, 10) + '/' + dueDate.toDate().toString().substring(5, 7) + '/' + dueDate.toDate().toString().substring(0, 4),
                                            style: TextStyle(
                                                fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: size * 0.25,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            'Dibuat oleh',
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black38,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: size * 0.25,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            'Pelaksana',
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black38,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: size * 0.25,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            statusPerbaikan == 'CLOSE'
                                              ? 'Terlaksana'
                                              : 'Pelaksanaan',
                                            style: TextStyle(
                                                fontSize: statusPerbaikan == 'CLOSE' ? 14.0 : 12.0,
                                                color: statusPerbaikan == 'CLOSE' ? Colors.green : Colors.black38,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: RichText(
                                      overflow: TextOverflow.visible,
                                      softWrap: true,
                                      text: TextSpan(
                                        text: 'Lokasi',
                                        style: TextStyle(
                                          fontSize: 11.0,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    )
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: RichText(
                                      overflow: TextOverflow.visible,
                                      softWrap: true,
                                      text: TextSpan(
                                        text: lokasi,
                                        style: TextStyle(
                                          fontSize: 10.0,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    )
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: RichText(
                                      overflow: TextOverflow.visible,
                                      softWrap: true,
                                      text: TextSpan(
                                        text: 'Masalah',
                                        style: TextStyle(
                                          fontSize: 11.0,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    )
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: RichText(
                                      overflow: TextOverflow.visible,
                                      softWrap: true,
                                      text: TextSpan(
                                        text: masalah,
                                        style: TextStyle(
                                          fontSize: 10.0,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    )
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: RichText(
                                      overflow: TextOverflow.visible,
                                      softWrap: true,
                                      text: TextSpan(
                                        text: 'Detail Masalah',
                                        style: TextStyle(
                                          fontSize: 11.0,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    )
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: RichText(
                                      overflow: TextOverflow.visible,
                                      softWrap: true,
                                      text: TextSpan(
                                        text: detailMasalah,
                                        style: TextStyle(
                                          fontSize: 11.0,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    )
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: RichText(
                                      overflow: TextOverflow.visible,
                                      softWrap: true,
                                      text: TextSpan(
                                        text: 'Rating',
                                        style: TextStyle(
                                          fontSize: 11.0,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    )
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(12.0, 0.0, 6.0, 12.0),
                                      child: SmoothStarRating(
                                        allowHalfRating: false,
                                        onRatingChanged: (v) {
                                          ratingChiller = v;
                                          setState(() {});
                                        },
                                        starCount: 5,
                                        rating: ratingChiller,
                                        size: 26.0,
                                        color: Colors.orangeAccent,
                                        borderColor: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
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
                                            'Note',
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
                                    Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              note == null ? '-' : note,
                                              style: TextStyle(
                                                color: Colors.black38,
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  // Container(
                                  //   padding: EdgeInsets.only(right: 15.0),
                                  //   alignment: Alignment.centerRight,
                                  //   child: SizedBox(
                                  //     height: 35.0,
                                  //     width: 95.0,
                                  //     child: OutlineButton(
                                  //       borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                                  //       highlightedBorderColor: AbubaPallate.menuBluebird,
                                  //       onPressed: () {
                                  //         setState(() {
                                  //           showNote = !showNote;
                                  //         });
                                  //       },
                                  //       child: Text(
                                  //         'NOTE',
                                  //         style: TextStyle(color: AbubaPallate.menuBluebird),
                                  //       ),
                                  //     ),
                                  //   )
                                  // ),
                                  statusPerbaikan == 'CLOSE'
                                    ? 
                                    Container(
                                        alignment: Alignment.centerRight,
                                        child: ButtonTheme(
                                          minWidth: 60.0,
                                          height: 35.0,
                                          child: RaisedButton(
                                            padding: const EdgeInsets.all(8.0),
                                            textColor: Colors.white,
                                            color: Colors.green,
                                            onPressed: () {
                                              setState(() {
                                                verify = true;
                                                if (statusPerbaikan == 'CLOSE') {                                                
                                                  DocumentReference docReference = Firestore.instance.collection('perbaikanIT').document(widget.index);

                                                  docReference.updateData({
                                                    'status': 'APPROVED',
                                                    'dateVerifikasi': DateTime.now(),
                                                    'rating': ratingChiller
                                                  }).then((doc) {
                                                    verify = false;
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
                                                                  'Perbaikan No. PRB-${no.toString().padLeft(4, '0')} successfully verified',
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
                                                      Navigator.pop(context);
                                                    });
                                                  }).catchError((error) {
                                                    print(error);
                                                  });
                                                } else {

                                                }
                                              });
                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                verify
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
                                                verify
                                                  ? SizedBox(
                                                      width: 10.0,
                                                    )
                                                  : Container(),
                                                Text(
                                                  'VERIFY'
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container()
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container();
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
