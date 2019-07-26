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
  String barcode;
  List<dynamic> status = [];
  List<dynamic> userCreated = [];
  List<dynamic> job = [];
  List<dynamic> jobStatus = [];
  List<dynamic> jobTime = [];

  List<dynamic> rescheduleBy = [];
  List<dynamic> newDueDate2 = [];

  var docID = [];

  String result;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    CollectionReference refAlasan = Firestore.instance.collection('maintenance_alasan');
    refAlasan.snapshots().listen((dataAlasan) {
      dataAlasan.documentChanges.forEach((getAlasan) {
        setState(() {
          alasanID.add(getAlasan.document.data['id'].toString());
          alasanName.add(getAlasan.document.data['alasan']);
        });
      });
    });

    CollectionReference reference = Firestore.instance.collection('maintenance_IT');
    reference.snapshots().listen((querySnapshot) {
      querySnapshot.documentChanges.forEach((change) {
        setState(() {
          dueDate.add(change.document.data['dueDate']);
          maintenanceNo.add(change.document.data['maintenanceNo']);
          frequency.add(change.document.data['frequency']);
          status.add(change.document.data['status']);
          userCreated.add(change.document.data['userCreated']);
          job.add(change.document.data['jobdesc']);
          jobStatus.add(change.document.data['jobdesc_status']);
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

          merek.add(change.document.data['merek']);
          item.add(change.document.data['item']);
          itemNo.add(change.document.data['itemNo']);
          qrCode.add(change.document.data['itemNo']);

          Firestore.instance.collection('user').where('id', isEqualTo: change.document.data['pic']).snapshots().listen((data5) {
            pic.add(data5.documents[0].data['nama']);
          });
        });
      });
    });

    animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(from: animationController.value == 0.0
      ? 1.0
      : animationController.value
    );
  }

  @override
  Widget build(BuildContext context) {
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
                    Column(
                      children: List.generate(docID.length, (index) {
                        if (status[index] == 'SKIP') {
                          if (rescheduleBy[index] == widget.idUser) {
                            if (newDueDate2[index] == null) {
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
                                                      '${outlet[index]} - ${lokasi[index]}',
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
                                              padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 20.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      '${merek[index]} - ${item[index]} - # ${itemNo[index]}',
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
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                ButtonTheme(
                                                  minWidth: MediaQuery.of(context).size.width * 0.35,
                                                  height: 30.0,
                                                  child: OutlineButton(
                                                    child: Row(
                                                      children: <Widget>[
                                                        Container(
                                                          width: MediaQuery.of(context).size.width * 0.15,
                                                          alignment: Alignment.centerLeft,
                                                          child: Text(
                                                            'Detail',
                                                            style: TextStyle(
                                                              fontSize: 13.0,
                                                              color: AbubaPallate.menuBluebird,
                                                              fontWeight: FontWeight.bold
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: MediaQuery.of(context).size.width * 0.15,
                                                          alignment: Alignment.centerRight,
                                                          child: Icon(Icons.close, color: AbubaPallate.menuBluebird, size: 18.0),
                                                        )
                                                      ],
                                                    ),
                                                    borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 2.0),
                                                    highlightedBorderColor: AbubaPallate.menuBluebird,
                                                    splashColor: Colors.white,
                                                    onPressed: () {
                                                      showModalBottomSheet(
                                                        context: context,
                                                        builder: (builder) {
                                                          return DialogBottomDetail(
                                                            job: job[index],
                                                            jobStatus: jobStatus[index]
                                                          );
                                                        }
                                                      ).then((value) {
                                                        print('berhasil');
                                                      });
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5.0,
                                                ),
                                                ButtonTheme(
                                                  minWidth: MediaQuery.of(context).size.width * 0.35,
                                                  height: 30.0,
                                                  child: RaisedButton(
                                                    child: Row(
                                                      children: <Widget>[
                                                        Container(
                                                          width: MediaQuery.of(context).size.width * 0.15,
                                                          alignment: Alignment.centerLeft,
                                                          child: Text(
                                                            'Reschedule',
                                                            style: TextStyle(
                                                              fontSize: 13.0,
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.bold
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: MediaQuery.of(context).size.width * 0.15,
                                                          alignment: Alignment.centerRight,
                                                          child: Icon(Icons.visibility, color: Colors.white, size: 18.0),
                                                        )
                                                      ],
                                                    ),
                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                                                    textColor: Colors.white,
                                                    color: AbubaPallate.greenabuba,
                                                    splashColor: AbubaPallate.greenabuba,
                                                    onPressed: () {
                                                      showDialog(
                                                        barrierDismissible: false,
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return DialogReschedule(
                                                            outlet: outlet[index],
                                                            merek: merek[index],
                                                            lokasi: lokasi[index],
                                                            item: item[index],
                                                            itemNo: itemNo[index],
                                                            frequency: frequency[index],
                                                            pic: pic[index],
                                                            idUser: widget.idUser,
                                                            departmentUser: widget.departmentUser,
                                                            namaUser: widget.namaUser,
                                                            docID: docID[index],
                                                          );
                                                        }
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            )
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

class DialogReschedule extends StatefulWidget {
  final String outlet;
  final String merek;
  final String lokasi;
  final String item;
  final String itemNo;
  final String frequency;
  final String pic;
  final int idUser;
  final String departmentUser;
  final String namaUser;
  var docID;

  DialogReschedule({this.frequency, this.item, this.itemNo, this.lokasi, this.merek, this.outlet, this.pic, this.namaUser, this.departmentUser, this.idUser, this.docID});
  @override
  _DialogRescheduleState createState() => _DialogRescheduleState();
}

class _DialogRescheduleState extends State<DialogReschedule> {
  bool showAlert = false;
  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime newDueDate;

  bool isProses = false;

  @override
  Widget build(BuildContext context) {
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
                    fontWeight: FontWeight.w700
                  ),
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                isProses
                                  ? SizedBox(
                                      height: 15.0,
                                      width: 15.0,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 1.5,
                                        value: null, valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      ),
                                    )
                                  : Container(),
                                isProses
                                  ? SizedBox(
                                      width: 10.0,
                                    )
                                  : Container(),
                                Text(
                                  'OK',
                                  style: TextStyle(color: Colors.white, fontSize: 12.0),
                                ),
                              ],
                            ),
                            onPressed: () {
                              setState(() {
                                if (newDueDate == null) {
                                  showAlert = true;
                                  isProses = false;
                                } else {
                                  if (isProses == false) {
                                    isProses = true;
                                    DocumentReference docReference = Firestore.instance.collection('maintenance_IT').document(widget.docID);

                                    docReference.updateData({
                                      'newDueDate': newDueDate,
                                      'status': 'RESCHEDULE'
                                    }).then((doc) async {
                                      showAlert = false;
                                      isProses = false;
                                      Navigator.pop(context);
                                      Navigator.pushReplacement(context,
                                        MaterialPageRoute(
                                          builder: (_) => SkippedMaintenance(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)
                                        )
                                      );
                                    }).catchError((error) {
                                      print(error);
                                    });
                                  } else {}
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

class DialogBottomDetail extends StatefulWidget {
  List<dynamic> job;
  List<dynamic> jobStatus;

  DialogBottomDetail({this.job, this.jobStatus});
  @override
  _DialogBottomDetailState createState() => _DialogBottomDetailState();
}

class _DialogBottomDetailState extends State<DialogBottomDetail> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF737373),
      height: MediaQuery.of(context).size.height * 0.35,
      child: Container(
        decoration: BoxDecoration(
          color: AbubaPallate.menuBluebird,
          borderRadius: BorderRadius.only(
            topRight: const Radius.circular(20.0),
            topLeft: const Radius.circular(20.0),
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      'Detail Maintenance',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.35 - 40.0,
              color: Colors.white,
              child: widget.job.length == 0
                ? Center(
                    child: Text(
                      'No Data',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                : Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView.builder(
                          physics: ScrollPhysics(),
                          itemCount: widget.job.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        '${index + 1}. ${widget.job[index]}',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              trailing: Container(
                                alignment: Alignment.centerRight,
                                width: MediaQuery.of(context).size.width * 0.15,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        widget.jobStatus[index],
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: AbubaPallate.menuBluebird,
                                          fontWeight: FontWeight.w700
                                        ),
                                        textAlign: TextAlign.end,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                        )
                      ),
                    ],
                  ),
            )
          ],
        )
      ),
    );
  }
}