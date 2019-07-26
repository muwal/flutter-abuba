import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class Testing extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  int count;
  Testing({this.idUser, this.namaUser, this.departmentUser, this.count});

  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> with TickerProviderStateMixin {
  String barcode;
  AnimationController animationController;
  List<dynamic> alasanID = [];
  List<dynamic> alasanName = [];

  List<bool> showDetail = [];
  List<dynamic> outlet = [];
  List<dynamic> dueDate = [];
  List<dynamic> lokasi = [];
  List<dynamic> maintenanceNo = [];
  List<dynamic> merek = [];
  List<dynamic> item = [];
  List<dynamic> itemNo = [];
  List<dynamic> frequency = [];
  List<dynamic> pic = [];
  List<String> qrCode = [];
  var indexx = [];
  List<dynamic> status = [];
  List<dynamic> userCreated = [];
  List<dynamic> job = [];
  int count = 0;

  List<bool> showDetailSkip = [];
  List<dynamic> outletSkip = [];
  List<dynamic> dueDateSkip = [];
  List<dynamic> lokasiSkip = [];
  List<dynamic> maintenanceNoSkip = [];
  List<dynamic> merekSkip = [];
  List<dynamic> itemSkip = [];
  List<dynamic> itemNoSkip = [];
  List<dynamic> frequencySkip = [];
  List<dynamic> picSkip = [];
  List<String> qrCodeSkip = [];
  var indexxSkip = [];
  List<dynamic> statusSkip = [];
  List<dynamic> userCreatedSkip = [];
  List<dynamic> jobSkip = [];
  List<dynamic> jobTimeSkip = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future scan(String outlet, String lokasi, String qrcode, String merek, String item, String itemNo, String pic, String frequency, var indexx, int indexData, List<dynamic> jobdesc, int userCreated, String type) async {
    try {
      String barcode = await scanner.scan();
      setState(() {
        this.barcode = barcode;
        if (qrcode == barcode) {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return Checkbox(
                  alasan: alasanName,
                  valueCheck: alasanID,
                  frequency: frequency,
                  userCreated: userCreated,
                  outlet: outlet,
                  lokasi: lokasi,
                  merek: merek,
                  item: item,
                  itemNo: itemNo,
                  indexx: indexx,
                  pic: pic,
                  jobdesc: jobdesc,
                  type: type,
                  onSelectedAlasanListChanged: (value) {
                    print(value);
                  },
                );
              }
          );
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
                          'Data not found',
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
      });
    } on PlatformException catch (e) {
      if (e.code == scanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
      'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      count = widget.count;
    });

    CollectionReference refAlasan = Firestore.instance.collection('maintenance_alasan');
    refAlasan.snapshots().listen((dataAlasan) {
      dataAlasan.documentChanges.forEach((getAlasan) {
        setState(() {
          alasanID.add(getAlasan.document.data['id'].toString());
          alasanName.add(getAlasan.document.data['alasan']);
        });
      });
    });

    CollectionReference reference = Firestore.instance.collection('maintenance_testing');
    reference.snapshots().listen((querySnapshot) {
      querySnapshot.documentChanges.forEach((change) {
        setState(() {
          dueDate.add(change.document.data['dueDate']);
          maintenanceNo.add(change.document.data['maintenanceNo']);
          frequency.add(change.document.data['frequency']);
          status.add(change.document.data['status']);
          userCreated.add(change.document.data['userCreated']);
          job.add(change.document.data['jobdesc']);
          merek.add(change.document.data['merek']);
          item.add(change.document.data['item']);
          itemNo.add(change.document.data['itemNo']);
          qrCode.add(change.document.data['itemNo']);

          Firestore.instance.collection('outlet').where('id', isEqualTo: change.document.data['outlet']).snapshots().listen((data) {
            outlet.add(data.documents[0].data['nama_outlet']);
          });

          Firestore.instance.collection('lokasi').where('id', isEqualTo: change.document.data['lokasi']).snapshots().listen((data2) {
            lokasi.add(data2.documents[0].data['lokasi']);
          });

          // Firestore.instance.collection('maintenance_merek').where('id', isEqualTo: change.document.data['merek']).snapshots().listen((data3) {
          //   merek.add(data3.documents[0].data['merek']);
          // });

          indexx.add(change.document.documentID);

          // Firestore.instance.collection('maintenance_item').where('id', isEqualTo: change.document.data['item']).snapshots().listen((data4) {
          //   item.add(data4.documents[0].data['item']);
          //   itemNo.add(data4.documents[0].data['kode']);
          //   qrCode.add(data4.documents[0].data['kode']);
          // });

          Firestore.instance.collection('user').where('id', isEqualTo: change.document.data['pic']).snapshots().listen((data5) {
            pic.add(data5.documents[0].data['nama']);
          });
        });
      });
    });

    CollectionReference reference2 = Firestore.instance.collection('maintenance_testing');
    reference2.snapshots().listen((querySnapshot2) {
      querySnapshot2.documentChanges.forEach((change2) {
        setState(() {
          dueDateSkip.add(change2.document.data['newDueDate']);
          maintenanceNoSkip.add(change2.document.data['maintenanceNo']);
          frequencySkip.add(change2.document.data['frequency']);
          statusSkip.add(change2.document.data['status']);
          userCreatedSkip.add(change2.document.data['userCreated']);
          jobSkip.add(change2.document.data['jobdesc']);
          jobTimeSkip.add(change2.document.data['jobdesc_done']);
          merekSkip.add(change2.document.data['merek']);
          itemSkip.add(change2.document.data['item']);
          itemNoSkip.add(change2.document.data['itemNo']);
          qrCodeSkip.add(change2.document.data['itemNo']);

          Firestore.instance.collection('outlet').where('id', isEqualTo: change2.document.data['outlet']).snapshots().listen((data) {
            outletSkip.add(data.documents[0].data['nama_outlet']);
          });

          Firestore.instance.collection('lokasi').where('id', isEqualTo: change2.document.data['lokasi']).snapshots().listen((data2) {
            lokasiSkip.add(data2.documents[0].data['lokasi']);
          });

          // Firestore.instance.collection('maintenance_merek').where('id', isEqualTo: change2.document.data['merek']).snapshots().listen((data3) {
          //   merekSkip.add(data3.documents[0].data['merek']);
          // });

          indexxSkip.add(change2.document.documentID);

          // Firestore.instance.collection('maintenance_item').where('id', isEqualTo: change2.document.data['item']).snapshots().listen((data4) {
          //   itemSkip.add(data4.documents[0].data['item']);
          //   itemNoSkip.add(data4.documents[0].data['kode']);
          //   qrCodeSkip.add(data4.documents[0].data['kode']);
          // });

          Firestore.instance.collection('user').where('id', isEqualTo: change2.document.data['pic']).snapshots().listen((data5) {
            picSkip.add(data5.documents[0].data['nama']);
          });
        });
      });
    });

    for (int i = 0; i < widget.count; i++) {
      showDetail.add(false);
    }

    for (int a = 0; a < widget.count; a++) {
      showDetailSkip.add(false);
    }

    animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(
        from: animationController.value == 0.0
            ? 1.0
            : animationController.value
    );
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;

    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
            key: _scaffoldKey,
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(
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
              bottom: new TabBar(
                isScrollable: false,
                indicatorColor: AbubaPallate.greenabuba,
                tabs: <Widget>[
                  new Tab(
                    child: Text(
                      'Today',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  ), // 1st Tab
                  new Tab(
                    child: Text(
                      'All',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  ),
                  new Tab(
                    child: Text(
                      'Skipped',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  ), // 1st Tab
                ],
              ),
            ),
            body: AnimatedBuilder(
              animation: animationController,
              builder: (_, Widget child) {
                return animationController.isAnimating
                    ? Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
                    : TabBarView(
                  children: <Widget>[
                    ListView(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      children: <Widget>[
                        // Padding(
                        //   padding: EdgeInsets.only(top: 20.0, bottom: 10.0, left: 15.0, right: 10.0),
                        //   child: Text(
                        //     'Today\'s Tasks : ${count.toString()}',
                        //     style: TextStyle(
                        //       fontSize: 18.0,
                        //       fontWeight: FontWeight.bold,
                        //       color: Colors.black87
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: 10.0,
                        ),
                        StreamBuilder(
                            stream: Firestore.instance.collection('maintenance_testing').snapshots(),
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData)
                                return Container(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );

                              return Column(
                                  children: List.generate(snapshot.data.documents.length, (index) {
                                    Timestamp dueDateView = snapshot.data.documents[index].data['dueDate'];
                                    if (snapshot.data.documents[index].data['pic'] == widget.idUser) {
                                      if (snapshot.data.documents[index].data['status'] == 'OPEN') {
                                        if (dueDateView.toDate().toString().substring(8, 10) + '/' + dueDateView.toDate().toString().substring(5, 7) + '/' + dueDateView.toDate().toString().substring(0, 4) == DateTime.now().toString().substring(8, 10) + '/' + DateTime.now().toString().substring(5, 7) + '/' +DateTime.now().toString().substring(0, 4)) {
                                          return Container(
                                            padding: EdgeInsets.only(bottom: 10.0, left: 15.0, right: 10.0),
                                            child: Card(
                                              elevation: 4.0,
                                              child: Container(
                                                  color: Colors.white,
                                                  padding: EdgeInsets.only(left: 15.0, right: 10.0, top: 10.0, bottom: 10.0),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: <Widget>[
                                                                Container(
                                                                  width: MediaQuery.of(context).size.width * 0.7,
                                                                  child: Row(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: <Widget>[
                                                                      Icon(Icons.location_on, color: Colors.grey, size: 16.0),
                                                                      Flexible(
                                                                        fit: FlexFit.loose,
                                                                        child: RichText(
                                                                          softWrap: true,
                                                                          textAlign: TextAlign.start,
                                                                          overflow: TextOverflow.visible,
                                                                          text: TextSpan(
                                                                            text: '${outlet[index]} - ${lokasi[index]}',
                                                                            style: TextStyle(
                                                                                fontSize: 11.0,
                                                                                fontWeight: FontWeight.w300,
                                                                                color: Colors.black45
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
                                                                  width: MediaQuery.of(context).size.width * 0.7,
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
                                                                            text: '${merek[index]} - ${item[index]} - # ${itemNo[index]}',
                                                                            style: TextStyle(
                                                                                fontSize: 13.0,
                                                                                color: Colors.black
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                Row(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  children: <Widget>[
                                                                    ButtonTheme(
                                                                      minWidth: 50.0,
                                                                      height: 30.0,
                                                                      child: RaisedButton(
                                                                        textColor: showDetail[index] ? Colors.black54 : Colors.white,
                                                                        color: showDetail[index] ? Colors.grey[200] : AbubaPallate.greenabuba,
                                                                        child: showDetail[index] ? Text('Close Detail') : Text('Detail'),
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(15.0)
                                                                        ),
                                                                        onPressed: () {
                                                                          setState(() {
                                                                            showDetail[index] = !showDetail[index];
                                                                            // if (showDetail[index] == true) {
                                                                            //   job.clear();
                                                                            //   for (int i = 0; i < snapshot.data.documents[index].data['jobdesc'].length; i++) {
                                                                            //     Firestore.instance.collection('maintenance_jobdesc').where('id', isEqualTo: snapshot.data.documents[index].data['jobdesc'][i]).snapshots().listen((data) {
                                                                            //       setState(() {
                                                                            //         job.add(data.documents[0].data['jobdesc']);
                                                                            //       });
                                                                            //     });
                                                                            //   }
                                                                            // } else {
                                                                            //   job.clear();
                                                                            // }
                                                                          });
                                                                        },
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 10.0,
                                                                    ),
                                                                    ButtonTheme(
                                                                      minWidth: 50.0,
                                                                      height: 30.0,
                                                                      child: new OutlineButton(
                                                                        child: new Text('Skip', style: TextStyle(color: AbubaPallate.menuBluebird)),
                                                                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
                                                                        borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 2.0),
                                                                        highlightedBorderColor: AbubaPallate.menuBluebird,
                                                                        onPressed: () {
                                                                          showDialog(
                                                                              barrierDismissible: false,
                                                                              context: context,
                                                                              builder: (context) {
                                                                                return Checkbox2(
                                                                                  alasan: alasanName,
                                                                                  valueCheck: alasanID,
                                                                                  frequency: frequency[index],
                                                                                  indexx: snapshot.data.documents[index].documentID,
                                                                                  item: item[index],
                                                                                  itemNo: itemNo[index],
                                                                                  lokasi: lokasi[index],
                                                                                  merek: merek[index],
                                                                                  outlet: outlet[index],
                                                                                  pic: pic[index],
                                                                                  onCancelResult: (cancelResult) {},
                                                                                  onResult: (finalResult) {
                                                                                    DocumentReference docReference = Firestore.instance.collection('maintenance_testing').document(snapshot.data.documents[index].documentID);

                                                                                    docReference.updateData({
                                                                                      'alasan': finalResult,
                                                                                      'status': 'SKIP',
                                                                                      'skippedDate': DateTime.now(),
                                                                                      'rescheduleBy': userCreated[index]
                                                                                    }).then((doc) async {
                                                                                      setState(() {
                                                                                        if (count > 0) {
                                                                                          count = count - 1;
                                                                                        } else {
                                                                                          count = 0;
                                                                                        }
                                                                                      });
                                                                                      print('success2');
                                                                                    }).catchError((error) {
                                                                                      print(error);
                                                                                    });
                                                                                  },
                                                                                );
                                                                              }
                                                                          );
                                                                        },
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                              onTap: () {
                                                                scan(outlet[index], lokasi[index], qrCode[index], merek[index], item[index], itemNo[index], pic[index], frequency[index], indexx[index], index, snapshot.data.documents[index].data['jobdesc'], userCreated[index], 'save');
                                                              },
                                                              child: Container(
                                                                padding: EdgeInsets.only(right: 10.0, bottom: 10.0, left: 10.0),
                                                                height: 60.0,
                                                                width: 60.0,
                                                                decoration: new BoxDecoration(
                                                                    color: Colors.transparent,
                                                                    shape: BoxShape.rectangle,
                                                                    image: DecorationImage(
                                                                        image: AssetImage('assets/images/qrcode.png'),
                                                                        fit: BoxFit.fitWidth
                                                                    )
                                                                ),
                                                              )
                                                          ),
                                                        ],
                                                      ),
                                                      showDetail[index]
                                                          ? Padding(
                                                        padding: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
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
                                                                              frequency[index],
                                                                              style: TextStyle(
                                                                                  fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                                              ),
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
                                                                              pic[index],
                                                                              style: TextStyle(
                                                                                  fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
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
                                                                              'Frequency',
                                                                              style: TextStyle(
                                                                                  fontSize: 12.0,
                                                                                  color: Colors.black38,
                                                                                  fontWeight: FontWeight.w700
                                                                              ),
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
                                                                              'PIC',
                                                                              style: TextStyle(
                                                                                  fontSize: 12.0,
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
                                                                  padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 5.0, top: 10.0),
                                                                  child: Container(
                                                                    width: size,
                                                                    height: 30.0,
                                                                    decoration: new BoxDecoration(
                                                                      color: AbubaPallate.greenabuba,
                                                                      shape: BoxShape.rectangle,
                                                                    ),
                                                                    child: Center(
                                                                        child: Text(
                                                                          'Detail Maintenance',
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 14.0
                                                                          ),
                                                                        )
                                                                    ),
                                                                  )
                                                              ),
                                                              Padding(
                                                                  padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 5.0, top: 10.0),
                                                                  child: Column(
                                                                      children: List.generate(snapshot.data.documents[index].data['jobdesc'].length, (index) {
                                                                        return Container(
                                                                            padding: EdgeInsets.symmetric(vertical: 3.0),
                                                                            alignment: Alignment.topLeft,
                                                                            width: size,
                                                                            child: RichText(
                                                                              softWrap: true,
                                                                              overflow: TextOverflow.visible,
                                                                              text: TextSpan(
                                                                                text: '${(index + 1).toString()}. ${snapshot.data.documents[index].data['jobdesc'][index]}',
                                                                                style: TextStyle(
                                                                                    fontSize: 12.0, color: Colors.black87),
                                                                              ),
                                                                            )
                                                                        );
                                                                      }).toList()
                                                                  )
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                          : Container()
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
                                    } else {
                                      return Container();
                                    }
                                  }).toList()
                              );
                            }
                        )
                      ],
                    ),
                    // batas pertama
                    ListView(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      children: <Widget>[
                        SizedBox(
                          height: 10.0,
                        ),
                        StreamBuilder(
                            stream: Firestore.instance.collection('maintenance_testing').snapshots(),
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData)
                                return Container(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );

                              return Column(
                                  children: List.generate(snapshot.data.documents.length, (index) {
                                    Timestamp dueDateView = snapshot.data.documents[index].data['dueDate'];
                                    if (snapshot.data.documents[index].data['pic'] == widget.idUser) {
                                      if (snapshot.data.documents[index].data['status'] == 'OPEN') {
                                        if (dueDateView.toDate().isBefore(DateTime.now())) {
                                          return Container(
                                            padding: EdgeInsets.only(bottom: 10.0, left: 15.0, right: 10.0),
                                            child: Card(
                                              elevation: 4.0,
                                              child: Container(
                                                  color: Colors.white,
                                                  padding: EdgeInsets.only(left: 15.0, right: 10.0, top: 10.0, bottom: 10.0),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: <Widget>[
                                                                Container(
                                                                  width: MediaQuery.of(context).size.width * 0.7,
                                                                  child: Row(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: <Widget>[
                                                                      Icon(Icons.location_on, color: Colors.grey, size: 16.0),
                                                                      Flexible(
                                                                        fit: FlexFit.loose,
                                                                        child: RichText(
                                                                          softWrap: true,
                                                                          textAlign: TextAlign.start,
                                                                          overflow: TextOverflow.visible,
                                                                          text: TextSpan(
                                                                            text: '${outlet[index]} - ${lokasi[index]}',
                                                                            style: TextStyle(
                                                                                fontSize: 11.0,
                                                                                fontWeight: FontWeight.w500,
                                                                                color: Colors.black54
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
                                                                  width: MediaQuery.of(context).size.width * 0.7,
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
                                                                            text: '${merek[index]} - ${item[index]} - # ${itemNo[index]}',
                                                                            style: TextStyle(
                                                                                fontSize: 13.0,
                                                                                fontWeight: FontWeight.w500,
                                                                                color: Colors.black87
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                Row(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  children: <Widget>[
                                                                    ButtonTheme(
                                                                      minWidth: 50.0,
                                                                      height: 30.0,
                                                                      child: RaisedButton(
                                                                        textColor: showDetail[index] ? Colors.black54 : Colors.white,
                                                                        color: showDetail[index] ? Colors.grey[200] : AbubaPallate.greenabuba,
                                                                        child: showDetail[index] ? Text('Close Detail') : Text('Detail'),
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(15.0)
                                                                        ),
                                                                        onPressed: () {
                                                                          setState(() {
                                                                            showDetail[index] = !showDetail[index];
                                                                          });
                                                                        },
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 10.0,
                                                                    ),
                                                                    ButtonTheme(
                                                                      minWidth: 50.0,
                                                                      height: 30.0,
                                                                      child: new OutlineButton(
                                                                        child: new Text('Skip', style: TextStyle(color: AbubaPallate.menuBluebird)),
                                                                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15.0)),
                                                                        borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 2.0),
                                                                        highlightedBorderColor: AbubaPallate.menuBluebird,
                                                                        onPressed: () {
                                                                          showDialog(
                                                                              barrierDismissible: false,
                                                                              context: context,
                                                                              builder: (context) {
                                                                                return Checkbox2(
                                                                                  alasan: alasanName,
                                                                                  valueCheck: alasanID,
                                                                                  frequency: frequency[index],
                                                                                  indexx: snapshot.data.documents[index].documentID,
                                                                                  item: item[index],
                                                                                  itemNo: itemNo[index],
                                                                                  lokasi: lokasi[index],
                                                                                  merek: merek[index],
                                                                                  outlet: outlet[index],
                                                                                  pic: pic[index],
                                                                                  onCancelResult: (cancelResult) {},
                                                                                  onResult: (finalResult) {
                                                                                    DocumentReference docReference = Firestore.instance.collection('maintenance_testing').document(snapshot.data.documents[index].documentID);

                                                                                    docReference.updateData({
                                                                                      'alasan': finalResult,
                                                                                      'status': 'SKIP',
                                                                                      'skippedDate': DateTime.now(),
                                                                                      'rescheduleBy': userCreated[index]
                                                                                    }).then((doc) async {
                                                                                      setState(() {
                                                                                        if (count > 0) {
                                                                                          count = count - 1;
                                                                                        } else {
                                                                                          count = 0;
                                                                                        }
                                                                                      });
                                                                                      print('success2');
                                                                                    }).catchError((error) {
                                                                                      print(error);
                                                                                    });
                                                                                  },
                                                                                );
                                                                              }
                                                                          );
                                                                        },
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                              onTap: () {
                                                                scan(outlet[index], lokasi[index], qrCode[index], merek[index], item[index], itemNo[index], pic[index], frequency[index], indexx[index], index, snapshot.data.documents[index].data['jobdesc'], userCreated[index], 'save');
                                                              },
                                                              child: Container(
                                                                padding: EdgeInsets.only(right: 10.0, bottom: 10.0, left: 10.0),
                                                                height: 60.0,
                                                                width: 60.0,
                                                                decoration: new BoxDecoration(
                                                                    color: Colors.transparent,
                                                                    shape: BoxShape.rectangle,
                                                                    image: DecorationImage(
                                                                        image: AssetImage('assets/images/qrcode.png'),
                                                                        fit: BoxFit.fitWidth
                                                                    )
                                                                ),
                                                              )
                                                          ),
                                                        ],
                                                      ),
                                                      showDetail[index]
                                                          ? Padding(
                                                        padding: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
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
                                                                              frequency[index],
                                                                              style: TextStyle(
                                                                                  fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                                              ),
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
                                                                              pic[index],
                                                                              style: TextStyle(
                                                                                  fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
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
                                                                              'Frequency',
                                                                              style: TextStyle(
                                                                                  fontSize: 12.0,
                                                                                  color: Colors.black38,
                                                                                  fontWeight: FontWeight.w700
                                                                              ),
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
                                                                              'PIC',
                                                                              style: TextStyle(
                                                                                  fontSize: 12.0,
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
                                                                  padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 5.0, top: 10.0),
                                                                  child: Container(
                                                                    width: size,
                                                                    height: 30.0,
                                                                    decoration: new BoxDecoration(
                                                                      color: AbubaPallate.greenabuba,
                                                                      shape: BoxShape.rectangle,
                                                                    ),
                                                                    child: Center(
                                                                        child: Text(
                                                                          'Detail Maintenance',
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 14.0
                                                                          ),
                                                                        )
                                                                    ),
                                                                  )
                                                              ),
                                                              Padding(
                                                                  padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 5.0, top: 10.0),
                                                                  child: Column(
                                                                      children: List.generate(snapshot.data.documents[index].data['jobdesc'].length, (index) {
                                                                        return Container(
                                                                            padding: EdgeInsets.symmetric(vertical: 3.0),
                                                                            alignment: Alignment.topLeft,
                                                                            width: size,
                                                                            child: RichText(
                                                                              softWrap: true,
                                                                              overflow: TextOverflow.visible,
                                                                              text: TextSpan(
                                                                                text: '${(index + 1).toString()}. ${snapshot.data.documents[index].data['jobdesc'][index]}',
                                                                                style: TextStyle(
                                                                                    fontSize: 12.0, color: Colors.black87),
                                                                              ),
                                                                            )
                                                                        );
                                                                      }).toList()
                                                                  )
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                          : Container()
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
                                    } else {
                                      return Container();
                                    }
                                  }).toList()
                              );
                            }
                        )
                      ],
                    ),
                    // batas kedua
                    ListView(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      children: <Widget>[
                        // Padding(
                        //   padding: EdgeInsets.only(top: 20.0, bottom: 10.0, left: 15.0, right: 10.0),
                        //   child: Text(
                        //     'Skipped\'s Tasks : ${countSkip.toString()}',
                        //     style: TextStyle(
                        //       fontSize: 18.0,
                        //       fontWeight: FontWeight.bold,
                        //       color: Colors.black87
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: 15.0,
                        ),
                        StreamBuilder(
                            stream: Firestore.instance.collection('maintenance_testing').snapshots(),
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData)
                                return Container(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );

                              return Column(
                                  children: List.generate(snapshot.data.documents.length, (index) {
                                    Timestamp newDueDateView = snapshot.data.documents[index].data['newDueDate'];
                                    if (snapshot.data.documents[index].data['pic'] == widget.idUser) {
                                      if (snapshot.data.documents[index].data['status'] == 'RESCHEDULE') {
                                        if (newDueDateView.toDate().toString().substring(8, 10) + '/' + newDueDateView.toDate().toString().substring(5, 7) + '/' + newDueDateView.toDate().toString().substring(0, 4) == DateTime.now().toString().substring(8, 10) + '/' + DateTime.now().toString().substring(5, 7) + '/' +DateTime.now().toString().substring(0, 4)) {
                                          return Container(
                                            padding: EdgeInsets.only(bottom: 10.0, left: 15.0, right: 10.0),
                                            child: Card(
                                              elevation: 4.0,
                                              child: Container(
                                                  color: Colors.white,
                                                  padding: EdgeInsets.only(left: 15.0, right: 10.0, top: 10.0, bottom: 10.0),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: <Widget>[
                                                                Container(
                                                                  width: MediaQuery.of(context).size.width * 0.7,
                                                                  child: Row(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: <Widget>[
                                                                      Icon(Icons.location_on, color: Colors.grey, size: 16.0),
                                                                      Flexible(
                                                                        fit: FlexFit.loose,
                                                                        child: RichText(
                                                                          softWrap: true,
                                                                          textAlign: TextAlign.start,
                                                                          overflow: TextOverflow.visible,
                                                                          text: TextSpan(
                                                                            text: '${outletSkip[index]} - ${lokasiSkip[index]}',
                                                                            style: TextStyle(
                                                                                fontSize: 11.0,
                                                                                fontWeight: FontWeight.w300,
                                                                                color: Colors.black45
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
                                                                  width: MediaQuery.of(context).size.width * 0.7,
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
                                                                            text: '${merekSkip[index]} - ${itemSkip[index]} - # ${itemNoSkip[index]}',
                                                                            style: TextStyle(
                                                                                fontSize: 13.0,
                                                                                color: Colors.black
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                Row(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  children: <Widget>[
                                                                    ButtonTheme(
                                                                      minWidth: 50.0,
                                                                      height: 30.0,
                                                                      child: RaisedButton(
                                                                        textColor: showDetailSkip[index] ? Colors.black54 : Colors.white,
                                                                        color: showDetailSkip[index] ? Colors.grey[200] : AbubaPallate.greenabuba,
                                                                        child: showDetailSkip[index] ? Text('Close Detail') : Text('Detail'),
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(15.0)
                                                                        ),
                                                                        onPressed: () {
                                                                          setState(() {
                                                                            showDetailSkip[index] = !showDetailSkip[index];
                                                                            // if (showDetailSkip[index] == true) {
                                                                            //   jobSkip.clear();
                                                                            //   jobTimeSkip.clear();
                                                                            //   for (int q = 0; q < snapshot.data.documents[index].data['jobdesc'].length; q++) {
                                                                            //     Firestore.instance.collection('maintenance_jobdesc').where('id', isEqualTo: snapshot.data.documents[index].data['jobdesc'][q]).snapshots().listen((data) {
                                                                            //       setState(() {
                                                                            //         jobSkip.add(data.documents[0].data['jobdesc']);
                                                                            //       });
                                                                            //     });
                                                                            //     jobTimeSkip.add(snapshot.data.documents[index].data['jobdesc_done'][q]);
                                                                            //   }
                                                                            // } else {
                                                                            //   jobSkip.clear();
                                                                            //   jobTimeSkip.clear();
                                                                            // }
                                                                          });
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                              onTap: () {
                                                                scan(outletSkip[index], lokasiSkip[index], qrCodeSkip[index], merekSkip[index], itemSkip[index], itemNoSkip[index], picSkip[index], frequencySkip[index], indexxSkip[index], index, snapshot.data.documents[index].data['jobdesc'], userCreatedSkip[index], 'skip');
                                                              },
                                                              child: Container(
                                                                padding: EdgeInsets.only(right: 10.0, bottom: 10.0, left: 10.0),
                                                                height: 60.0,
                                                                width: 60.0,
                                                                decoration: new BoxDecoration(
                                                                    color: Colors.transparent,
                                                                    shape: BoxShape.rectangle,
                                                                    image: DecorationImage(
                                                                        image: AssetImage('assets/images/qrcode.png'),
                                                                        fit: BoxFit.fitWidth
                                                                    )
                                                                ),
                                                              )
                                                          ),
                                                        ],
                                                      ),
                                                      showDetailSkip[index]
                                                          ? Padding(
                                                        padding: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
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
                                                                              frequencySkip[index],
                                                                              style: TextStyle(
                                                                                  fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                                              ),
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
                                                                              picSkip[index],
                                                                              style: TextStyle(
                                                                                  fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
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
                                                                              'Frequency',
                                                                              style: TextStyle(
                                                                                  fontSize: 12.0,
                                                                                  color: Colors.black38,
                                                                                  fontWeight: FontWeight.w700
                                                                              ),
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
                                                                              'PIC',
                                                                              style: TextStyle(
                                                                                  fontSize: 12.0,
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
                                                                  padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 5.0, top: 10.0),
                                                                  child: Container(
                                                                    width: size,
                                                                    height: 30.0,
                                                                    decoration: new BoxDecoration(
                                                                      color: AbubaPallate.greenabuba,
                                                                      shape: BoxShape.rectangle,
                                                                    ),
                                                                    child: Center(
                                                                        child: Text(
                                                                          'Detail Maintenance',
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 14.0
                                                                          ),
                                                                        )
                                                                    ),
                                                                  )
                                                              ),
                                                              Padding(
                                                                  padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 5.0, top: 10.0),
                                                                  child: Column(
                                                                      children: List.generate(snapshot.data.documents[index].data['jobdesc'].length, (index2) {
                                                                        return Container(
                                                                            padding: EdgeInsets.symmetric(vertical: 3.0),
                                                                            alignment: Alignment.topLeft,
                                                                            width: size,
                                                                            child: Row(
                                                                              children: <Widget>[
                                                                                RichText(
                                                                                  softWrap: true,
                                                                                  overflow: TextOverflow.visible,
                                                                                  text: TextSpan(
                                                                                    text: '${(index2 + 1).toString()}. ${snapshot.data.documents[index].data['jobdesc'][index2]}',
                                                                                    style: TextStyle(
                                                                                        fontSize: 12.0, color: Colors.black87),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 5.0,
                                                                                ),
                                                                                Tooltip(
                                                                                  child: snapshot.data.documents[index].data['jobdesc_done'][index2] == null ? Icon(Icons.remove_circle, color: Colors.redAccent, size: 14.0) : Icon(Icons.check_circle, color: AbubaPallate.greenabuba, size: 14.0),
                                                                                  message: snapshot.data.documents[index].data['jobdesc_done'][index2] == null ? 'Skipped' : 'Done',
                                                                                )
                                                                              ],
                                                                            )
                                                                        );
                                                                      }).toList()
                                                                  )
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                          : Container()
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
                                    } else {
                                      return Container();
                                    }
                                  }).toList()
                              );
                            }
                        )
                      ],
                    ),
                  ],
                );
              },
            )
        ),
      ),
    );
  }
}

class Checkbox extends StatefulWidget {
  Checkbox({this.onSelectedAlasanListChanged,this.jobdesc,this.outlet,this.lokasi,this.item,this.itemNo,this.merek,this.frequency,this.indexx,this.pic, this.alasan, this.valueCheck, this.onCancelResult, this.onResult, this.userCreated, this.type});

  final ValueChanged<List<String>> onSelectedAlasanListChanged;
  final ValueChanged<List<String>> onCancelResult;
  final ValueChanged<int> onResult;
  final int userCreated;
  final List<dynamic> alasan;
  final List<dynamic> valueCheck;
  final List<dynamic> jobdesc;
  final String outlet;
  final String lokasi;
  final String merek;
  final String item;
  final String itemNo;
  final String frequency;
  final String pic;
  final String type;
  var indexx;

  @override
  _CheckboxState createState() => new _CheckboxState();
}

class _CheckboxState extends State<Checkbox> with TickerProviderStateMixin {
  List<String> _tempSelectedAlasan = [];
  List<int> _tempSelectedValueAlasan = [];
  AnimationController animationController2;

  List<dynamic> job2 = [];
  var timejob2;
  var timejob3;
  bool showAlasan = false;
  int value = 0;
  bool showAlert = false;
  bool isProcess = false;

  @override
  void initState() {
    _tempSelectedAlasan = [];
    _tempSelectedValueAlasan = [];
    super.initState();

    setState(() {
      job2 = widget.jobdesc;
    });

    for (int x = 0; x < widget.jobdesc.length; x++) {
      Firestore.instance.collection('maintenance_testing').document(widget.indexx).snapshots().listen((data) {
        setState(() {
          timejob2 = List<dynamic>.from(data.data['jobdesc_done']);
          timejob3 = List<dynamic>.from(data.data['jobdesc_done']);
        });
      });
    }

    // for (int z = 0; z < widget.jobdesc.length; z++) {
    //   Firestore.instance.collection('maintenance_jobdesc').where('id', isEqualTo: widget.jobdesc[z]).snapshots().listen((data) {
    //     setState(() {
    //       job2.add(data.documents[0].data['jobdesc']);
    //     });
    //   });
    // }

    animationController2 = AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController2.reverse(
        from: animationController2.value == 0.0
            ? 1.0
            : animationController2.value
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            children: <Widget>[
              Container(
                color: AbubaPallate.greenabuba,
                height: 50.0,
                child: Center(
                  child: Text(
                    'DATA',
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
              Padding(
                padding: EdgeInsets.only(bottom: 5.0, top: 20.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    widget.outlet,
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
                                    widget.merek,
                                    style: TextStyle(
                                        fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
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
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    widget.lokasi,
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w700
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
                                    '${widget.item} - # ${widget.itemNo}',
                                    style: TextStyle(
                                        fontSize: 12.0,
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
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 5.0, top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    widget.frequency,
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
                                    widget.pic,
                                    style: TextStyle(
                                        fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
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
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Frequency',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w700
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
                                    'PIC',
                                    style: TextStyle(
                                        fontSize: 12.0,
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
                    showAlasan
                        ? Column(
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 10.0, top: 20.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Alasan Skip',
                                      style: TextStyle(
                                          fontSize: 16.0, color: AbubaPallate.greenabuba, fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.35,
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: Scrollbar(
                                  child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: widget.alasan.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        final AlasanValue = widget.alasan[index];
                                        final ValueFinal = widget.valueCheck[index];

                                        return Container(
                                            child: Row(
                                              children: <Widget>[
                                                Radio(
                                                  value: int.tryParse(ValueFinal.toString()),
                                                  groupValue: value,
                                                  activeColor: AbubaPallate.greenabuba,
                                                  onChanged: (valueChange) {
                                                    setState(() {
                                                      value = valueChange;
                                                      showAlert = false;
                                                    });
                                                  },
                                                ),
                                                Text(
                                                  AlasanValue,
                                                  style: TextStyle(fontSize: 14.0),
                                                ),
                                              ],
                                            )
                                        );
                                      }),
                                ),
                              ),
                            ],
                          ),
                        ),
                        showAlert
                            ? Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                            child: RichText(
                              softWrap: true,
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  text: 'Please select reason',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.w300,
                                      fontStyle: FontStyle.italic
                                  )
                              ),
                            )
                        )
                            : Container(),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: OutlineButton(
                                  child: new Text('CANCEL', style: TextStyle(color: Colors.red[300])),
                                  borderSide: BorderSide(color: Colors.red[300], width: 1.0),
                                  highlightedBorderColor: Colors.red[300],
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: RaisedButton(
                                  color: Colors.green[300],
                                  child: Text(
                                    'OK',
                                    style: TextStyle(color: Colors.white, fontSize: 12.0),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (value == 0) {
                                        showAlert = true;
                                      } else {
                                        showAlert = false;
                                        DocumentReference docReference = Firestore.instance.collection('maintenance_testing').document(widget.indexx);

                                        docReference.updateData({
                                          'alasan': value,
                                          'status': 'SKIP',
                                          'skippedDate': DateTime.now(),
                                          'jobdesc_done': timejob2,
                                          'rescheduleBy': widget.userCreated
                                        }).then((doc) async {
                                          setState(() {
                                            isProcess = false;
                                            if (_TestingState().count > 0) {
                                              _TestingState().count = _TestingState().count - 1;
                                            } else {
                                              _TestingState().count = 0;
                                            }
                                          });
                                          print('success');
                                        }).catchError((error) {
                                          print(error);
                                        });
                                        Navigator.pop(context);
                                      }
                                    });
                                  },
                                  splashColor: Colors.green[300],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                        : Column(
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 10.0, top: 20.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Detail Maintenance',
                                      style: TextStyle(
                                          fontSize: 16.0, color: AbubaPallate.greenabuba, fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ),
                        AnimatedBuilder(
                          animation: animationController2,
                          builder: (_, Widget child) {
                            return animationController2.isAnimating
                                ? Container(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                                : Container(
                                height: MediaQuery.of(context).size.height * 0.35,
                                padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 5.0),
                                child: ListView.builder(
                                  physics: ScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: widget.jobdesc.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    if (timejob3[index] == null) {
                                      return CheckboxListTile(
                                        controlAffinity: ListTileControlAffinity.leading,
                                        activeColor: AbubaPallate.greenabuba,
                                        title: RichText(
                                          softWrap: true,
                                          overflow: TextOverflow.visible,
                                          text: TextSpan(
                                            text: job2[index],
                                            style: TextStyle(
                                                fontSize: 12.0, color: Colors.black87),
                                          ),
                                        ),
                                        value: _tempSelectedAlasan.contains(job2[index]),
                                        onChanged: (value) {
                                          if (_tempSelectedAlasan.contains(job2[index]) == false) {
                                            setState(() {
                                              _tempSelectedAlasan.add(job2[index]);
                                              _tempSelectedValueAlasan.add(widget.jobdesc[index]);
                                              timejob2.removeAt(index);
                                              timejob2.insert(index, DateTime.now());
                                            });
                                          } else {
                                            setState(() {
                                              _tempSelectedAlasan.removeWhere((city) => city == job2[index]);
                                              _tempSelectedValueAlasan.removeWhere((city) => city == widget.jobdesc[index]);
                                              timejob2.removeAt(index);
                                              timejob2.insert(index, null);
                                            });
                                          }
                                        },
                                      );
                                    } else {
                                      return CheckboxListTile(
                                        controlAffinity: ListTileControlAffinity.leading,
                                        activeColor: AbubaPallate.greenabuba,
                                        title: RichText(
                                          softWrap: true,
                                          overflow: TextOverflow.visible,
                                          text: TextSpan(
                                            text: job2[index],
                                            style: TextStyle(
                                                fontSize: 12.0, color: Colors.black87),
                                          ),
                                        ),
                                        value: true,
                                        selected: true,
                                        onChanged: (value) {},
                                      );
                                    }
                                  },
                                )
                            );
                          },
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(10.0),
                          child: ButtonTheme(
                              minWidth: 50.0,
                              height: 40.0,
                              child: RaisedButton(
                                elevation: 0.0,
                                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
                                child: isProcess
                                    ? SizedBox(
                                    child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation(Colors.white),
                                        strokeWidth: 3.0
                                    ),
                                    height: 20.0,
                                    width: 20.0
                                )
                                    : Text(
                                  'SAVE',
                                  style:
                                  TextStyle(fontSize: 13.0, color: Colors.white),
                                ),
                                color: AbubaPallate.greenabuba,
                                onPressed: () {
                                  setState(() {
                                    isProcess = true;
                                  });
                                  DocumentReference docReference = Firestore.instance.collection('maintenance_testing').document(widget.indexx);

                                  if (timejob2.contains(null)) {
                                    setState(() {
                                      isProcess = false;
                                    });
                                    if (widget.type == 'skip') {
                                      showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return Dialog(
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
                                                        'Kerjakan semua tugas',
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
                                            );
                                          }
                                      );
                                    } else {
                                      setState(() {
                                        showAlasan = true;
                                      });
                                    }
                                  } else {
                                    docReference.updateData({
                                      'jobdesc_done': timejob2,
                                      'status': 'DONE',
                                    }).then((doc) {
                                      setState(() {
                                        isProcess = false;
                                        if (_TestingState().count > 0) {
                                          _TestingState().count = _TestingState().count - 1;
                                        } else {
                                          _TestingState().count = 0;
                                        }
                                      });
                                      Navigator.pop(context);
                                    }).catchError((error) {
                                      print(error);
                                    });
                                  }
                                },
                              )
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }
}

class Checkbox2 extends StatefulWidget {
  Checkbox2({this.alasan, this.onCancelResult, this.valueCheck, this.indexx, this.frequency, this.itemNo, this.pic, this.item, this.lokasi, this.merek, this.outlet, this.onResult});

  final List<dynamic> alasan;
  final List<dynamic> valueCheck;
  final ValueChanged<List<String>> onCancelResult;
  final ValueChanged<int> onResult;
  final String outlet;
  final String lokasi;
  final String merek;
  final String item;
  final String itemNo;
  final String frequency;
  final String pic;
  var indexx;

  @override
  _Checkbox2State createState() => new _Checkbox2State();
}

class _Checkbox2State extends State<Checkbox2> {
  int value = 0;
  bool showAlert = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            children: <Widget>[
              Container(
                color: AbubaPallate.greenabuba,
                height: 50.0,
                child: Center(
                  child: Text(
                    'DATA',
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
              Padding(
                padding: EdgeInsets.only(bottom: 5.0, top: 20.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    widget.outlet,
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
                                    widget.merek,
                                    style: TextStyle(
                                        fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
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
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    widget.lokasi,
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w700
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
                                    '${widget.item} - # ${widget.itemNo}',
                                    style: TextStyle(
                                        fontSize: 12.0,
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
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 5.0, top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    widget.frequency,
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
                                    widget.pic,
                                    style: TextStyle(
                                        fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
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
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Frequency',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w700
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
                                    'PIC',
                                    style: TextStyle(
                                        fontSize: 12.0,
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
                        padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 10.0, top: 20.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Alasan Skip',
                                  style: TextStyle(
                                      fontSize: 16.0, color: AbubaPallate.greenabuba, fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Scrollbar(
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: widget.alasan.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final AlasanValue = widget.alasan[index];
                                    final ValueFinal = widget.valueCheck[index];

                                    return Container(
                                        child: Row(
                                          children: <Widget>[
                                            Radio(
                                              value: int.tryParse(ValueFinal.toString()),
                                              groupValue: value,
                                              activeColor: AbubaPallate.greenabuba,
                                              onChanged: (valueChange) {
                                                setState(() {
                                                  value = valueChange;
                                                  showAlert = false;
                                                });
                                              },
                                            ),
                                            Text(
                                              AlasanValue,
                                              style: TextStyle(fontSize: 14.0),
                                            ),
                                          ],
                                        )
                                    );
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    showAlert
                        ? Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        child: RichText(
                          softWrap: true,
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: 'Please select reason',
                              style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FontStyle.italic
                              )
                          ),
                        )
                    )
                        : Container(),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: OutlineButton(
                              child: new Text('CANCEL', style: TextStyle(color: Colors.red[300])),
                              borderSide: BorderSide(color: Colors.red[300], width: 1.0),
                              highlightedBorderColor: Colors.red[300],
                              onPressed: () {
                                widget.onCancelResult([]);
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: RaisedButton(
                              color: Colors.green[300],
                              child: Text(
                                'OK',
                                style: TextStyle(color: Colors.white, fontSize: 12.0),
                              ),
                              onPressed: () {
                                setState(() {
                                  if (value == 0) {
                                    showAlert = true;
                                  } else {
                                    showAlert = false;
                                    widget.onResult(value);
                                    Navigator.pop(context);
                                  }
                                });
                              },
                              splashColor: Colors.green[300],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }
}