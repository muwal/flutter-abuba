import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/isoft/operation_page/correctiveaction/verifikasiPage.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Verifikasi extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  Verifikasi({this.idUser, this.namaUser, this.departmentUser});

  @override
  _VerifikasiState createState() => _VerifikasiState();
}

class _VerifikasiState extends State<Verifikasi> with TickerProviderStateMixin {
  AnimationController animationController;

  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime dateStart;
  DateTime dateEnd;

  bool showDataFiltered = false;
  bool showHelper = false;
  String helperText = '';

  List<dynamic> tanggal = [];
  List<dynamic> kategori = [];
  List<dynamic> noCar = [];
  List<dynamic> status = [];
  List<dynamic> userVerify = [];
  var docID = [];

  @override
  void initState() {
    super.initState();
    CollectionReference reference = Firestore.instance.collection('correctiveAction');
    reference.where('userCreated', isEqualTo: widget.idUser).where('status', isEqualTo: 'DONE').snapshots().listen((data) {
      data.documentChanges.forEach((change) {
        setState(() {
          status.add(change.document.data['status']);
          tanggal.add(change.document.data['dateCreated']);
          noCar.add(change.document.data['carNo']);
          userVerify.add(change.document.data['userCreated']);
          docID.add(change.document.documentID);

          Firestore.instance.collection('correctiveAction_category').where('id', isEqualTo: change.document.data['category']).snapshots().listen((data2) {
            kategori.add(data2.documents[0].data['category']);
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
            Container(
              margin: const EdgeInsets.only(bottom: 10.0, right: 15.0, left: 15.0, top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Corrective Action',
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
                      'Verification',
                      style:
                      TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: width,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: width * 0.2,
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Date',
                                  style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: width * 0.4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Detail',
                                  style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: width * 0.3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Status',
                                  style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
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
                      width: width,
                      color: noCar.length == 0 ? Colors.transparent : Colors.white,
                      child: Column(
                        children: noCar.length == 0
                          ? <Widget>[
                              Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Center(
                                  child: Text(
                                    'No Data',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0
                                    ),
                                  ),
                                ),
                              ),
                            ]
                          : List.generate(noCar.length, (index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5.0),
                                child: ListTile(
                                  leading: Container(
                                    padding: EdgeInsets.only(top: 5.0),
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width * 0.3,
                                    child: Row(
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            tanggal[index].toDate().toString().substring(8, 10) + '/' + tanggal[index].toDate().toString().substring(5, 7) + '/' + tanggal[index].toDate().toString().substring(0, 4),
                                            style: TextStyle(
                                                fontSize: 12.0, color: Colors.black54),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  title: Container(
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width * 0.3,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.3,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Flexible(
                                                fit: FlexFit.loose,
                                                child: RichText(
                                                  softWrap: true,
                                                  textAlign: TextAlign.start,
                                                  overflow: TextOverflow.visible,
                                                  text: TextSpan(
                                                    text: kategori[index],
                                                    style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.black
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.3,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Flexible(
                                                fit: FlexFit.loose,
                                                child: RichText(
                                                  softWrap: true,
                                                  textAlign: TextAlign.start,
                                                  overflow: TextOverflow.visible,
                                                  text: TextSpan(
                                                    text: 'CAR-${noCar[index].toString().padLeft(4, '0')}',
                                                    style: TextStyle(
                                                      fontSize: 11.0,
                                                      fontWeight: FontWeight.w300,
                                                      color: status[index] == 'OPEN' ? Colors.green : status[index] == 'ONGOING' ? Colors.orangeAccent : status[index] == 'DONE' ? AbubaPallate.menuBluebird : Colors.redAccent
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                      ],
                                    )
                                  ),
                                  trailing: Container(
                                    alignment: Alignment.centerRight,
                                    width: MediaQuery.of(context).size.width * 0.3,
                                    child: ButtonTheme(
                                      padding: EdgeInsets.all(0.0),
                                      minWidth: 80.0,
                                      height: 30.0,
                                      child: OutlineButton(
                                        child: Text(
                                          'Verify',
                                          style: TextStyle(fontSize: 12.0, color: AbubaPallate.menuBluebird),
                                        ),
                                        borderSide: BorderSide(
                                            color: AbubaPallate.menuBluebird),
                                        highlightedBorderColor: AbubaPallate.menuBluebird,
                                        onPressed: () {
                                          Navigator.pushReplacement(context,
                                            MaterialPageRoute(
                                              builder: (_) => VerifikasiLanjutan(departmentUser: widget.departmentUser, idUser: widget.idUser, namaUser: widget.namaUser, status: status[index], index: docID[index])
                                            )
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList()
                      ),
                    );
              },
            )
          ],
        )
      ),
    );
  }
}
