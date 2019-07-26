import 'dart:async';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class SkippedMaintenance extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  int count;
  final int countAll;
  SkippedMaintenance({this.idUser, this.namaUser, this.departmentUser, this.count, this.countAll});

  _SkippedMaintenanceState createState() => _SkippedMaintenanceState();
}

class _SkippedMaintenanceState extends State<SkippedMaintenance> with TickerProviderStateMixin {
  List<dynamic> alasanID = [];
  List<dynamic> alasanName = [];

  List<bool> showDetail = [];
  AnimationController animationController;
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
  String barcode;
  List<dynamic> status = [];
  List<dynamic> userCreated = [];
  List<dynamic> job = [];
  List<dynamic> jobTime = [];
  int count = 0;
  bool showAlert = false;

  List<dynamic> rescheduleBy = [];
  List<dynamic> newDueDate2 = [];
  List<dynamic> jobdesc2 = [];
  List<dynamic> jobdescDone2 = [];

  var docID = [];

  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime newDueDate;

  String result;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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

    CollectionReference reference = Firestore.instance.collection('maintenance');
    reference.snapshots().listen((querySnapshot) {
      querySnapshot.documentChanges.forEach((change) {
        setState(() {
          // if (change.document.data['status'] == 'SKIP') {
          //   if (change.document.data['rescheduleBy'] == widget.idUser) {
          //     if (change.document.data['newDueDate'] == null) {
          dueDate.add(change.document.data['dueDate']);
          maintenanceNo.add(change.document.data['maintenanceNo']);
          frequency.add(change.document.data['frequency']);
          status.add(change.document.data['status']);
          userCreated.add(change.document.data['userCreated']);
          jobdesc2.add(change.document.data['jobdesc']);
          job.add(change.document.data['jobdesc']);
          jobdescDone2.add(change.document.data['jobdesc_done']);
          jobTime.add(change.document.data['jobdesc_done']);

          rescheduleBy.add(change.document.data['rescheduleBy']);
          newDueDate2.add(change.document.data['newDueDate']);
          docID.add(change.document.documentID);

          Firestore.instance.collection('outlet').where('id', isEqualTo: change.document.data['outlet']).snapshots().listen((data) {
            outlet.add(data.documents[0].data['nama_outlet']);
          });

          Firestore.instance.collection('lokasi').where('id', isEqualTo: change.document.data['lokasi']).snapshots().listen((data2) {
            lokasi.add(data2.documents[0].data['lokasi']);
          });

          Firestore.instance.collection('maintenance_merek').where('id', isEqualTo: change.document.data['merek']).snapshots().listen((data3) {
            merek.add(data3.documents[0].data['merek']);
          });

          indexx.add(change.document.documentID);

          Firestore.instance.collection('maintenance_item').where('id', isEqualTo: change.document.data['item']).snapshots().listen((data4) {
            item.add(data4.documents[0].data['item']);
            itemNo.add(data4.documents[0].data['kode']);
            qrCode.add(data4.documents[0].data['kode']);
          });

          Firestore.instance.collection('user').where('id', isEqualTo: change.document.data['pic']).snapshots().listen((data5) {
            pic.add(data5.documents[0].data['nama']);
          });
          //     }
          //   }
          // }
        });
      });
    });

    for (int i = 0; i < widget.count; i++) {
      showDetail.add(false);
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
        length: 2,
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
                    : ListView(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  children: <Widget>[
                    // Padding(
                    //   padding: EdgeInsets.only(top: 20.0, bottom: 10.0, left: 15.0, right: 10.0),
                    //   child: Text(
                    //     'Skipped\'s Tasks : ${count.toString()}',
                    //     style: TextStyle(
                    //       fontSize: 18.0,
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.black87
                    //     ),
                    //   ),
                    // ),
                    Column(
                        children: List.generate(maintenanceNo.length, (index) {
                          if (status[index] == 'SKIP') {
                            if (rescheduleBy[index] == widget.idUser) {
                              if (newDueDate2[index] == null) {
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
                                                                  //   jobTime.clear();
                                                                  //   for (int i = 0; i < jobdesc2[index].length; i++) {
                                                                  //     Firestore.instance.collection('maintenance_jobdesc').where('id', isEqualTo: jobdesc2[index][i]).snapshots().listen((data) {
                                                                  //       setState(() {
                                                                  //         job.add(data.documents[0].data['jobdesc']);
                                                                  //       });
                                                                  //     });
                                                                  //     jobTime.add(jobdescDone2[index][i]);
                                                                  //   }
                                                                  // } else {
                                                                  //   job.clear();
                                                                  //   jobTime.clear();
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
                                                Tooltip(
                                                  message: 'Reschedule Skipped\'s Tasks ',
                                                  child: ButtonTheme(
                                                    minWidth: 50.0,
                                                    height: 30.0,
                                                    child: OutlineButton(
                                                      child: Text(
                                                        'RESCHEDULE',
                                                        style: TextStyle(
                                                            fontSize: 13.0,
                                                            color: AbubaPallate.menuBluebird,
                                                            fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                      borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                                                      highlightedBorderColor: AbubaPallate.menuBluebird,
                                                      onPressed: () {
                                                        showDialog(
                                                            barrierDismissible: false,
                                                            context: context,
                                                            builder: (BuildContext context) {
                                                              return Dialog(
                                                                child: Container(
                                                                    height: MediaQuery.of(context).size.height * 0.5,
                                                                    child: Column(
                                                                      children: <Widget>[
                                                                        Container(
                                                                          color: AbubaPallate.greenabuba,
                                                                          height: 50.0,
                                                                          child: Center(
                                                                            child: Text(
                                                                              'RESCHEDULE',
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
                                                                                              outlet[index],
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
                                                                                              merek[index],
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
                                                                                              lokasi[index],
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
                                                                                              '${item[index]} - # ${itemNo[index]}',
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
                                                                                      width: MediaQuery.of(context).size.width * 0.35,
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
                                                                                padding: EdgeInsets.only(bottom: 5.0, top: 20.0, left: 10.0, right: 10.0),
                                                                                child: DateTimePickerFormField(
                                                                                  format: dateFormat,
                                                                                  onChanged: (dt) => setState(() {
                                                                                    newDueDate = dt;
                                                                                    showAlert = false;
                                                                                  }),
                                                                                  dateOnly: true,
                                                                                  editable: false,
                                                                                  resetIcon: null,
                                                                                  style: TextStyle(fontSize: 14.0, color: Colors.black),
                                                                                  decoration: InputDecoration(
                                                                                      border: UnderlineInputBorder(),
                                                                                      labelStyle: TextStyle(fontSize: 12.0),
                                                                                      labelText: 'New Due Date'
                                                                                  ),
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
                                                                                        text: 'Please input new due date',
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
                                                                                            if (newDueDate == null) {
                                                                                              showAlert = true;
                                                                                            } else {
                                                                                              showAlert = false;
                                                                                              DocumentReference docReference = Firestore.instance.collection('maintenance').document(docID[index]);

                                                                                              docReference.updateData({
                                                                                                'newDueDate': newDueDate,
                                                                                                'status': 'RESCHEDULE'
                                                                                              }).then((doc) async {
                                                                                                if (count > 0){
                                                                                                  count = count - 1;
                                                                                                } else {
                                                                                                  count = 0;
                                                                                                }
                                                                                                Navigator.pop(context);
                                                                                                // print('success');
                                                                                              }).catchError((error) {
                                                                                                print(error);
                                                                                              });
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
                                                        );
                                                      },
                                                    ),
                                                  ),
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
                                                            children: List.generate(job[index].length, (index2) {
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
                                                                          text: '${(index2 + 1).toString()}. ${job[index][index2]}',
                                                                          style: TextStyle(
                                                                              fontSize: 12.0, color: Colors.black87),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width: 5.0,
                                                                      ),
                                                                      Tooltip(
                                                                        child: jobTime[index][index2] == null ? Icon(Icons.remove_circle, color: Colors.redAccent, size: 14.0) : Icon(Icons.check_circle, color: AbubaPallate.greenabuba, size: 14.0),
                                                                        message: jobTime[index][index2] == null ? 'Skipped' : 'Done',
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
                    )
                  ],
                );
              },
            )
        ),
      ),
    );
  }
}