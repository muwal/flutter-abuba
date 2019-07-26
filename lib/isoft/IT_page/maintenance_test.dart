import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_abuba/isoft/operation_page/workinginstruction/list/form_list.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class FormMaintenanceTest extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  int count;
  FormMaintenanceTest({this.idUser, this.namaUser, this.departmentUser, this.count});

  _FormMaintenanceTestState createState() => _FormMaintenanceTestState();
}

class _FormMaintenanceTestState extends State<FormMaintenanceTest> with TickerProviderStateMixin {
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
  List<dynamic> picID = [];
  List<String> qrCode = [];
  var indexx = [];
  List<dynamic> status = [];
  List<dynamic> userCreated = [];
  List<dynamic> job = [];
  List<dynamic> jobStatus = [];

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
  List<dynamic> picIDSkip = [];
  List<String> qrCodeSkip = [];
  var indexxSkip = [];
  List<dynamic> statusSkip = [];
  List<dynamic> userCreatedSkip = [];
  List<dynamic> jobSkip = [];
  List<dynamic> jobStatusSkip = [];
  List<dynamic> jobTimeSkip = [];

  bool isFilter = false;
  String filterFreq = '';
  String filterArea = '';
  String filterLokasi = '';
  List<dynamic> areaName = [];
  List<dynamic> areaID = [];
  List<dynamic> lokasiName = [];
  List<dynamic> lokasiID = [];

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
                  departmentUser: widget.departmentUser,
                  idUser: widget.idUser,
                  namaUser: widget.namaUser,
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

    // preparation data for filter
    CollectionReference ref = Firestore.instance.collection('outlet');
    ref.orderBy('nama_outlet', descending: false).snapshots().listen((data) {
      data.documentChanges.forEach((getData) {
        setState(() {
          areaID.add(getData.document.data['id']);
          areaName.add(getData.document.data['nama_outlet']);
        });
      });
    });

    CollectionReference ref2 = Firestore.instance.collection('lokasi');
    ref2.orderBy('lokasi', descending: false).snapshots().listen((data2) {
      data2.documentChanges.forEach((getData2) {
        setState(() {
          lokasiID.add(getData2.document.data['id']);
          lokasiName.add(getData2.document.data['lokasi']);
        });
      });
    });
    // end of preparation data for filter

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
          picID.add(change.document.data['pic']);

          job.add(change.document.data['jobdesc']);
          jobStatus.add(change.document.data['jobdesc_status']);

          Firestore.instance.collection('outlet').where('id', isEqualTo: change.document.data['outlet']).snapshots().listen((data) {
            outlet.add(data.documents[0].data['nama_outlet']);
          });

          Firestore.instance.collection('lokasi').where('id', isEqualTo: change.document.data['lokasi']).snapshots().listen((data2) {
            lokasi.add(data2.documents[0].data['lokasi']);
          });

          merek.add(change.document.data['merek']);
          indexx.add(change.document.documentID);
          item.add(change.document.data['item']);
          itemNo.add(change.document.data['itemNo']);
          qrCode.add(change.document.data['itemNo']);

          Firestore.instance.collection('user').where('id', isEqualTo: change.document.data['pic']).snapshots().listen((data5) {
            pic.add(data5.documents[0].data['nama']);
          });
        });
      });
    });

    CollectionReference reference2 = Firestore.instance.collection('maintenance_IT');
    reference2.snapshots().listen((querySnapshot2) {
      querySnapshot2.documentChanges.forEach((change2) {
        setState(() {
          dueDateSkip.add(change2.document.data['newDueDate']);
          maintenanceNoSkip.add(change2.document.data['maintenanceNo']);
          frequencySkip.add(change2.document.data['frequency']);
          statusSkip.add(change2.document.data['status']);
          userCreatedSkip.add(change2.document.data['userCreated']);
          picIDSkip.add(change2.document.data['pic']);

          jobSkip.add(change2.document.data['jobdesc']);
          jobStatusSkip.add(change2.document.data['jobdesc_status']);

          Firestore.instance.collection('outlet').where('id', isEqualTo: change2.document.data['outlet']).snapshots().listen((data) {
            outletSkip.add(data.documents[0].data['nama_outlet']);
          });

          Firestore.instance.collection('lokasi').where('id', isEqualTo: change2.document.data['lokasi']).snapshots().listen((data2) {
            lokasiSkip.add(data2.documents[0].data['lokasi']);
          });

          merekSkip.add(change2.document.data['merek']);
          indexxSkip.add(change2.document.documentID);
          itemSkip.add(change2.document.data['item']);
          itemNoSkip.add(change2.document.data['itemNo']);
          qrCodeSkip.add(change2.document.data['itemNo']);

          Firestore.instance.collection('user').where('id', isEqualTo: change2.document.data['pic']).snapshots().listen((data5) {
            picSkip.add(data5.documents[0].data['nama']);
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
                  Container(
                    width: MediaQuery.of(context).size.width * 0.14,
                    height: MediaQuery.of(context).size.width * 0.14,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                      child: Container(
                        padding: EdgeInsets.only(right: 10.0, bottom: 10.0, left: 10.0),
                        alignment: Alignment.centerRight,
                        decoration: new BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            image: AssetImage('assets/images/filter.png'),
                            fit: BoxFit.fitWidth,
                          )
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return FilterBox(
                              selectedChoise: filterFreq,
                              selectedChoiseArea: filterArea,
                              selectedChoiseLokasi: filterLokasi,
                              areaID: areaID,
                              areaName: areaName,
                              lokasiID: lokasiID,
                              lokasiName: lokasiName,
                              onResult: (value) {
                                setState(() {
                                  if (value[1] == '' && value[2] == '' && value[3] == '') {
                                    isFilter = false;
                                    filterFreq = '';
                                    filterArea = '';
                                    filterLokasi = '';
                                  } else {
                                    isFilter = value[0];
                                    filterFreq = value[1];
                                    filterArea = value[2];
                                    filterLokasi = value[3];
                                  }
                                });
                              },
                            );
                          }
                        );
                      },
                    ),
                  ),
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
                      'All Task',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  ), // 1st Tab
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
                    ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: indexx.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (picID[index] == widget.idUser) {
                          if (status[index] == 'OPEN') {
                            if (dueDate[index].toDate().toString().substring(8, 10) + '/' + dueDate[index].toDate().toString().substring(5, 7) + '/' + dueDate[index].toDate().toString().substring(0, 4) == DateTime.now().toString().substring(8, 10) + '/' + DateTime.now().toString().substring(5, 7) + '/' + DateTime.now().toString().substring(0, 4)) {
                              if (isFilter) {
                                if (filterFreq != '' && filterArea != '' && filterLokasi != '') {
                                  if (frequency[index] == filterFreq && outlet[index] == filterArea && lokasi[index] == filterLokasi) {
                                    // filter frequency area lokasi
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
                                                Flexible(
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            'FREQUENCY',
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
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            frequency[index],
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
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
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
                                                            'Detail',
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
                                                      showModalBottomSheet(
                                                        context: context,
                                                        builder: (builder) {
                                                          return DialogBottomDetail(
                                                            job: job[index],
                                                            jobStatus: jobStatus[index],
                                                            departmentUser: widget.departmentUser,
                                                            idUser: widget.idUser,
                                                            namaUser: widget.namaUser,
                                                          );
                                                        }
                                                      ).then((value) {
                                                        print('berhasil');
                                                      });
                                                    },
                                                  ),
                                                ),
                                                dueDate[index].toDate().toString().substring(8, 10) + '/' + dueDate[index].toDate().toString().substring(5, 7) + '/' + dueDate[index].toDate().toString().substring(0, 4) == DateTime.now().toString().substring(8, 10) + '/' + DateTime.now().toString().substring(5, 7) + '/' + DateTime.now().toString().substring(0, 4)
                                                  ? Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
                                                        ButtonTheme(
                                                          minWidth: MediaQuery.of(context).size.width * 0.20,
                                                          height: 30.0,
                                                          child: OutlineButton(
                                                            child: Row(
                                                              children: <Widget>[
                                                                Container(
                                                                  width: MediaQuery.of(context).size.width * 0.10,
                                                                  alignment: Alignment.centerLeft,
                                                                  child: Text(
                                                                    'Skip',
                                                                    style: TextStyle(
                                                                      fontSize: 13.0,
                                                                      color: AbubaPallate.menuBluebird,
                                                                      fontWeight: FontWeight.bold
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: MediaQuery.of(context).size.width * 0.10,
                                                                  alignment: Alignment.centerRight,
                                                                  child: Icon(Icons.close, color: AbubaPallate.menuBluebird, size: 18.0),
                                                                )
                                                              ],
                                                            ),
                                                            borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 2.0),
                                                            highlightedBorderColor: AbubaPallate.menuBluebird,
                                                            splashColor: Colors.white,
                                                            onPressed: () {
                                                              showDialog(
                                                                barrierDismissible: false,
                                                                context: context,
                                                                builder: (context) {
                                                                  return Checkbox2(
                                                                    alasan: alasanName,
                                                                    valueCheck: alasanID,
                                                                    frequency: frequency[index],
                                                                    indexx: indexx[index],
                                                                    item: item[index],
                                                                    itemNo: itemNo[index],
                                                                    lokasi: lokasi[index],
                                                                    merek: merek[index],
                                                                    outlet: outlet[index],
                                                                    pic: pic[index],
                                                                    onCancelResult: (cancelResult) {},
                                                                    onResult: (finalResult) {},
                                                                    jobStatus: jobStatus[index],
                                                                    job: job[index],
                                                                    userCreated: userCreated[index],
                                                                    idUser: widget.idUser,
                                                                    departmentUser: widget.departmentUser,
                                                                    namaUser: widget.namaUser,                                                                  
                                                                  );
                                                                }
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10.0,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            scan(outlet[index], lokasi[index], qrCode[index], merek[index], item[index], itemNo[index], pic[index], frequency[index], indexx[index], index, job[index], userCreated[index], 'save');
                                                          },
                                                          child: Container(
                                                            width: MediaQuery.of(context).size.width * 0.1,
                                                            height: MediaQuery.of(context).size.width * 0.1,
                                                            padding: EdgeInsets.only(right: 10.0, bottom: 10.0, left: 10.0),
                                                            alignment: Alignment.centerRight,
                                                            decoration: new BoxDecoration(
                                                              color: Colors.transparent,
                                                              shape: BoxShape.rectangle,
                                                              image: DecorationImage(
                                                                image: AssetImage('assets/images/scanner.png'),
                                                                fit: BoxFit.fitWidth
                                                              )
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : Container()
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
                                } else if (filterFreq != '' && filterArea != '' && filterLokasi == '') {
                                  if (frequency[index] == filterFreq && outlet[index] == filterArea) {
                                    // filter frequency area
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
                                                Flexible(
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            'FREQUENCY',
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
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            frequency[index],
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
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
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
                                                            'Detail',
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
                                                      showModalBottomSheet(
                                                        context: context,
                                                        builder: (builder) {
                                                          return DialogBottomDetail(
                                                            job: job[index],
                                                            jobStatus: jobStatus[index],
                                                            departmentUser: widget.departmentUser,
                                                            idUser: widget.idUser,
                                                            namaUser: widget.namaUser,
                                                          );
                                                        }
                                                      ).then((value) {
                                                        print('berhasil');
                                                      });
                                                    },
                                                  ),
                                                ),
                                                dueDate[index].toDate().toString().substring(8, 10) + '/' + dueDate[index].toDate().toString().substring(5, 7) + '/' + dueDate[index].toDate().toString().substring(0, 4) == DateTime.now().toString().substring(8, 10) + '/' + DateTime.now().toString().substring(5, 7) + '/' + DateTime.now().toString().substring(0, 4)
                                                  ? Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
                                                        ButtonTheme(
                                                          minWidth: MediaQuery.of(context).size.width * 0.20,
                                                          height: 30.0,
                                                          child: OutlineButton(
                                                            child: Row(
                                                              children: <Widget>[
                                                                Container(
                                                                  width: MediaQuery.of(context).size.width * 0.10,
                                                                  alignment: Alignment.centerLeft,
                                                                  child: Text(
                                                                    'Skip',
                                                                    style: TextStyle(
                                                                      fontSize: 13.0,
                                                                      color: AbubaPallate.menuBluebird,
                                                                      fontWeight: FontWeight.bold
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: MediaQuery.of(context).size.width * 0.10,
                                                                  alignment: Alignment.centerRight,
                                                                  child: Icon(Icons.close, color: AbubaPallate.menuBluebird, size: 18.0),
                                                                )
                                                              ],
                                                            ),
                                                            borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 2.0),
                                                            highlightedBorderColor: AbubaPallate.menuBluebird,
                                                            splashColor: Colors.white,
                                                            onPressed: () {
                                                              showDialog(
                                                                barrierDismissible: false,
                                                                context: context,
                                                                builder: (context) {
                                                                  return Checkbox2(
                                                                    alasan: alasanName,
                                                                    valueCheck: alasanID,
                                                                    frequency: frequency[index],
                                                                    indexx: indexx[index],
                                                                    item: item[index],
                                                                    itemNo: itemNo[index],
                                                                    lokasi: lokasi[index],
                                                                    merek: merek[index],
                                                                    outlet: outlet[index],
                                                                    pic: pic[index],
                                                                    onCancelResult: (cancelResult) {},
                                                                    onResult: (finalResult) {},
                                                                    jobStatus: jobStatus[index],
                                                                    job: job[index],
                                                                    userCreated: userCreated[index],
                                                                    idUser: widget.idUser,
                                                                    departmentUser: widget.departmentUser,
                                                                    namaUser: widget.namaUser,                                                                  
                                                                  );
                                                                }
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10.0,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            scan(outlet[index], lokasi[index], qrCode[index], merek[index], item[index], itemNo[index], pic[index], frequency[index], indexx[index], index, job[index], userCreated[index], 'save');
                                                          },
                                                          child: Container(
                                                            width: MediaQuery.of(context).size.width * 0.1,
                                                            height: MediaQuery.of(context).size.width * 0.1,
                                                            padding: EdgeInsets.only(right: 10.0, bottom: 10.0, left: 10.0),
                                                            alignment: Alignment.centerRight,
                                                            decoration: new BoxDecoration(
                                                              color: Colors.transparent,
                                                              shape: BoxShape.rectangle,
                                                              image: DecorationImage(
                                                                image: AssetImage('assets/images/scanner.png'),
                                                                fit: BoxFit.fitWidth
                                                              )
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : Container()
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
                                } else if (filterFreq != '' && filterArea == '' && filterLokasi != '') {
                                  if (frequency[index] == filterFreq && lokasi[index] == filterLokasi) {
                                    // filter frequency lokasi
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
                                                Flexible(
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            'FREQUENCY',
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
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            frequency[index],
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
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
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
                                                            'Detail',
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
                                                      showModalBottomSheet(
                                                        context: context,
                                                        builder: (builder) {
                                                          return DialogBottomDetail(
                                                            job: job[index],
                                                            jobStatus: jobStatus[index],
                                                            departmentUser: widget.departmentUser,
                                                            idUser: widget.idUser,
                                                            namaUser: widget.namaUser,
                                                          );
                                                        }
                                                      ).then((value) {
                                                        print('berhasil');
                                                      });
                                                    },
                                                  ),
                                                ),
                                                dueDate[index].toDate().toString().substring(8, 10) + '/' + dueDate[index].toDate().toString().substring(5, 7) + '/' + dueDate[index].toDate().toString().substring(0, 4) == DateTime.now().toString().substring(8, 10) + '/' + DateTime.now().toString().substring(5, 7) + '/' + DateTime.now().toString().substring(0, 4)
                                                  ? Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
                                                        ButtonTheme(
                                                          minWidth: MediaQuery.of(context).size.width * 0.20,
                                                          height: 30.0,
                                                          child: OutlineButton(
                                                            child: Row(
                                                              children: <Widget>[
                                                                Container(
                                                                  width: MediaQuery.of(context).size.width * 0.10,
                                                                  alignment: Alignment.centerLeft,
                                                                  child: Text(
                                                                    'Skip',
                                                                    style: TextStyle(
                                                                      fontSize: 13.0,
                                                                      color: AbubaPallate.menuBluebird,
                                                                      fontWeight: FontWeight.bold
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: MediaQuery.of(context).size.width * 0.10,
                                                                  alignment: Alignment.centerRight,
                                                                  child: Icon(Icons.close, color: AbubaPallate.menuBluebird, size: 18.0),
                                                                )
                                                              ],
                                                            ),
                                                            borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 2.0),
                                                            highlightedBorderColor: AbubaPallate.menuBluebird,
                                                            splashColor: Colors.white,
                                                            onPressed: () {
                                                              showDialog(
                                                                barrierDismissible: false,
                                                                context: context,
                                                                builder: (context) {
                                                                  return Checkbox2(
                                                                    alasan: alasanName,
                                                                    valueCheck: alasanID,
                                                                    frequency: frequency[index],
                                                                    indexx: indexx[index],
                                                                    item: item[index],
                                                                    itemNo: itemNo[index],
                                                                    lokasi: lokasi[index],
                                                                    merek: merek[index],
                                                                    outlet: outlet[index],
                                                                    pic: pic[index],
                                                                    onCancelResult: (cancelResult) {},
                                                                    onResult: (finalResult) {},
                                                                    jobStatus: jobStatus[index],
                                                                    job: job[index],
                                                                    userCreated: userCreated[index],
                                                                    idUser: widget.idUser,
                                                                    departmentUser: widget.departmentUser,
                                                                    namaUser: widget.namaUser,                                                                  
                                                                  );
                                                                }
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10.0,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            scan(outlet[index], lokasi[index], qrCode[index], merek[index], item[index], itemNo[index], pic[index], frequency[index], indexx[index], index, job[index], userCreated[index], 'save');
                                                          },
                                                          child: Container(
                                                            width: MediaQuery.of(context).size.width * 0.1,
                                                            height: MediaQuery.of(context).size.width * 0.1,
                                                            padding: EdgeInsets.only(right: 10.0, bottom: 10.0, left: 10.0),
                                                            alignment: Alignment.centerRight,
                                                            decoration: new BoxDecoration(
                                                              color: Colors.transparent,
                                                              shape: BoxShape.rectangle,
                                                              image: DecorationImage(
                                                                image: AssetImage('assets/images/scanner.png'),
                                                                fit: BoxFit.fitWidth
                                                              )
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : Container()
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
                                } else if (filterFreq != '' && filterArea == '' && filterLokasi == '') {
                                  if (frequency[index] == filterFreq) {
                                    // filter frequency 
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
                                                Flexible(
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            'FREQUENCY',
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
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            frequency[index],
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
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
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
                                                            'Detail',
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
                                                      showModalBottomSheet(
                                                        context: context,
                                                        builder: (builder) {
                                                          return DialogBottomDetail(
                                                            job: job[index],
                                                            jobStatus: jobStatus[index],
                                                            departmentUser: widget.departmentUser,
                                                            idUser: widget.idUser,
                                                            namaUser: widget.namaUser,
                                                          );
                                                        }
                                                      ).then((value) {
                                                        print('berhasil');
                                                      });
                                                    },
                                                  ),
                                                ),
                                                dueDate[index].toDate().toString().substring(8, 10) + '/' + dueDate[index].toDate().toString().substring(5, 7) + '/' + dueDate[index].toDate().toString().substring(0, 4) == DateTime.now().toString().substring(8, 10) + '/' + DateTime.now().toString().substring(5, 7) + '/' + DateTime.now().toString().substring(0, 4)
                                                  ? Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
                                                        ButtonTheme(
                                                          minWidth: MediaQuery.of(context).size.width * 0.20,
                                                          height: 30.0,
                                                          child: OutlineButton(
                                                            child: Row(
                                                              children: <Widget>[
                                                                Container(
                                                                  width: MediaQuery.of(context).size.width * 0.10,
                                                                  alignment: Alignment.centerLeft,
                                                                  child: Text(
                                                                    'Skip',
                                                                    style: TextStyle(
                                                                      fontSize: 13.0,
                                                                      color: AbubaPallate.menuBluebird,
                                                                      fontWeight: FontWeight.bold
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: MediaQuery.of(context).size.width * 0.10,
                                                                  alignment: Alignment.centerRight,
                                                                  child: Icon(Icons.close, color: AbubaPallate.menuBluebird, size: 18.0),
                                                                )
                                                              ],
                                                            ),
                                                            borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 2.0),
                                                            highlightedBorderColor: AbubaPallate.menuBluebird,
                                                            splashColor: Colors.white,
                                                            onPressed: () {
                                                              showDialog(
                                                                barrierDismissible: false,
                                                                context: context,
                                                                builder: (context) {
                                                                  return Checkbox2(
                                                                    alasan: alasanName,
                                                                    valueCheck: alasanID,
                                                                    frequency: frequency[index],
                                                                    indexx: indexx[index],
                                                                    item: item[index],
                                                                    itemNo: itemNo[index],
                                                                    lokasi: lokasi[index],
                                                                    merek: merek[index],
                                                                    outlet: outlet[index],
                                                                    pic: pic[index],
                                                                    onCancelResult: (cancelResult) {},
                                                                    onResult: (finalResult) {},
                                                                    jobStatus: jobStatus[index],
                                                                    job: job[index],
                                                                    userCreated: userCreated[index],
                                                                    idUser: widget.idUser,
                                                                    departmentUser: widget.departmentUser,
                                                                    namaUser: widget.namaUser,                                                                  
                                                                  );
                                                                }
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10.0,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            scan(outlet[index], lokasi[index], qrCode[index], merek[index], item[index], itemNo[index], pic[index], frequency[index], indexx[index], index, job[index], userCreated[index], 'save');
                                                          },
                                                          child: Container(
                                                            width: MediaQuery.of(context).size.width * 0.1,
                                                            height: MediaQuery.of(context).size.width * 0.1,
                                                            padding: EdgeInsets.only(right: 10.0, bottom: 10.0, left: 10.0),
                                                            alignment: Alignment.centerRight,
                                                            decoration: new BoxDecoration(
                                                              color: Colors.transparent,
                                                              shape: BoxShape.rectangle,
                                                              image: DecorationImage(
                                                                image: AssetImage('assets/images/scanner.png'),
                                                                fit: BoxFit.fitWidth
                                                              )
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : Container()
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
                                } else if (filterFreq == '' && filterArea != '' && filterLokasi != '') {
                                  if (outlet[index] == filterArea && lokasi[index] == filterLokasi) {
                                    // filter area lokasi
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
                                                Flexible(
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            'FREQUENCY',
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
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            frequency[index],
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
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
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
                                                            'Detail',
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
                                                      showModalBottomSheet(
                                                        context: context,
                                                        builder: (builder) {
                                                          return DialogBottomDetail(
                                                            job: job[index],
                                                            jobStatus: jobStatus[index],
                                                            departmentUser: widget.departmentUser,
                                                            idUser: widget.idUser,
                                                            namaUser: widget.namaUser,
                                                          );
                                                        }
                                                      ).then((value) {
                                                        print('berhasil');
                                                      });
                                                    },
                                                  ),
                                                ),
                                                dueDate[index].toDate().toString().substring(8, 10) + '/' + dueDate[index].toDate().toString().substring(5, 7) + '/' + dueDate[index].toDate().toString().substring(0, 4) == DateTime.now().toString().substring(8, 10) + '/' + DateTime.now().toString().substring(5, 7) + '/' + DateTime.now().toString().substring(0, 4)
                                                  ? Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
                                                        ButtonTheme(
                                                          minWidth: MediaQuery.of(context).size.width * 0.20,
                                                          height: 30.0,
                                                          child: OutlineButton(
                                                            child: Row(
                                                              children: <Widget>[
                                                                Container(
                                                                  width: MediaQuery.of(context).size.width * 0.10,
                                                                  alignment: Alignment.centerLeft,
                                                                  child: Text(
                                                                    'Skip',
                                                                    style: TextStyle(
                                                                      fontSize: 13.0,
                                                                      color: AbubaPallate.menuBluebird,
                                                                      fontWeight: FontWeight.bold
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: MediaQuery.of(context).size.width * 0.10,
                                                                  alignment: Alignment.centerRight,
                                                                  child: Icon(Icons.close, color: AbubaPallate.menuBluebird, size: 18.0),
                                                                )
                                                              ],
                                                            ),
                                                            borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 2.0),
                                                            highlightedBorderColor: AbubaPallate.menuBluebird,
                                                            splashColor: Colors.white,
                                                            onPressed: () {
                                                              showDialog(
                                                                barrierDismissible: false,
                                                                context: context,
                                                                builder: (context) {
                                                                  return Checkbox2(
                                                                    alasan: alasanName,
                                                                    valueCheck: alasanID,
                                                                    frequency: frequency[index],
                                                                    indexx: indexx[index],
                                                                    item: item[index],
                                                                    itemNo: itemNo[index],
                                                                    lokasi: lokasi[index],
                                                                    merek: merek[index],
                                                                    outlet: outlet[index],
                                                                    pic: pic[index],
                                                                    onCancelResult: (cancelResult) {},
                                                                    onResult: (finalResult) {},
                                                                    jobStatus: jobStatus[index],
                                                                    job: job[index],
                                                                    userCreated: userCreated[index],
                                                                    idUser: widget.idUser,
                                                                    departmentUser: widget.departmentUser,
                                                                    namaUser: widget.namaUser,                                                                  
                                                                  );
                                                                }
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10.0,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            scan(outlet[index], lokasi[index], qrCode[index], merek[index], item[index], itemNo[index], pic[index], frequency[index], indexx[index], index, job[index], userCreated[index], 'save');
                                                          },
                                                          child: Container(
                                                            width: MediaQuery.of(context).size.width * 0.1,
                                                            height: MediaQuery.of(context).size.width * 0.1,
                                                            padding: EdgeInsets.only(right: 10.0, bottom: 10.0, left: 10.0),
                                                            alignment: Alignment.centerRight,
                                                            decoration: new BoxDecoration(
                                                              color: Colors.transparent,
                                                              shape: BoxShape.rectangle,
                                                              image: DecorationImage(
                                                                image: AssetImage('assets/images/scanner.png'),
                                                                fit: BoxFit.fitWidth
                                                              )
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : Container()
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
                                } else if (filterFreq == '' && filterArea != '' && filterLokasi == '') {
                                  if (outlet[index] == filterArea) {
                                    // filter area
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
                                                Flexible(
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            'FREQUENCY',
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
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            frequency[index],
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
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
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
                                                            'Detail',
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
                                                      showModalBottomSheet(
                                                        context: context,
                                                        builder: (builder) {
                                                          return DialogBottomDetail(
                                                            job: job[index],
                                                            jobStatus: jobStatus[index],
                                                            departmentUser: widget.departmentUser,
                                                            idUser: widget.idUser,
                                                            namaUser: widget.namaUser,
                                                          );
                                                        }
                                                      ).then((value) {
                                                        print('berhasil');
                                                      });
                                                    },
                                                  ),
                                                ),
                                                dueDate[index].toDate().toString().substring(8, 10) + '/' + dueDate[index].toDate().toString().substring(5, 7) + '/' + dueDate[index].toDate().toString().substring(0, 4) == DateTime.now().toString().substring(8, 10) + '/' + DateTime.now().toString().substring(5, 7) + '/' + DateTime.now().toString().substring(0, 4)
                                                  ? Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
                                                        ButtonTheme(
                                                          minWidth: MediaQuery.of(context).size.width * 0.20,
                                                          height: 30.0,
                                                          child: OutlineButton(
                                                            child: Row(
                                                              children: <Widget>[
                                                                Container(
                                                                  width: MediaQuery.of(context).size.width * 0.10,
                                                                  alignment: Alignment.centerLeft,
                                                                  child: Text(
                                                                    'Skip',
                                                                    style: TextStyle(
                                                                      fontSize: 13.0,
                                                                      color: AbubaPallate.menuBluebird,
                                                                      fontWeight: FontWeight.bold
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: MediaQuery.of(context).size.width * 0.10,
                                                                  alignment: Alignment.centerRight,
                                                                  child: Icon(Icons.close, color: AbubaPallate.menuBluebird, size: 18.0),
                                                                )
                                                              ],
                                                            ),
                                                            borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 2.0),
                                                            highlightedBorderColor: AbubaPallate.menuBluebird,
                                                            splashColor: Colors.white,
                                                            onPressed: () {
                                                              showDialog(
                                                                barrierDismissible: false,
                                                                context: context,
                                                                builder: (context) {
                                                                  return Checkbox2(
                                                                    alasan: alasanName,
                                                                    valueCheck: alasanID,
                                                                    frequency: frequency[index],
                                                                    indexx: indexx[index],
                                                                    item: item[index],
                                                                    itemNo: itemNo[index],
                                                                    lokasi: lokasi[index],
                                                                    merek: merek[index],
                                                                    outlet: outlet[index],
                                                                    pic: pic[index],
                                                                    onCancelResult: (cancelResult) {},
                                                                    onResult: (finalResult) {},
                                                                    jobStatus: jobStatus[index],
                                                                    job: job[index],
                                                                    userCreated: userCreated[index],
                                                                    idUser: widget.idUser,
                                                                    departmentUser: widget.departmentUser,
                                                                    namaUser: widget.namaUser,                                                                  
                                                                  );
                                                                }
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10.0,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            scan(outlet[index], lokasi[index], qrCode[index], merek[index], item[index], itemNo[index], pic[index], frequency[index], indexx[index], index, job[index], userCreated[index], 'save');
                                                          },
                                                          child: Container(
                                                            width: MediaQuery.of(context).size.width * 0.1,
                                                            height: MediaQuery.of(context).size.width * 0.1,
                                                            padding: EdgeInsets.only(right: 10.0, bottom: 10.0, left: 10.0),
                                                            alignment: Alignment.centerRight,
                                                            decoration: new BoxDecoration(
                                                              color: Colors.transparent,
                                                              shape: BoxShape.rectangle,
                                                              image: DecorationImage(
                                                                image: AssetImage('assets/images/scanner.png'),
                                                                fit: BoxFit.fitWidth
                                                              )
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : Container()
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
                                } else if (filterFreq == '' && filterArea == '' && filterLokasi != '') {
                                  if (lokasi[index] == filterLokasi) {
                                    // filter lokasi
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
                                                Flexible(
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            'FREQUENCY',
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
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            frequency[index],
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
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
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
                                                            'Detail',
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
                                                      showModalBottomSheet(
                                                        context: context,
                                                        builder: (builder) {
                                                          return DialogBottomDetail(
                                                            job: job[index],
                                                            jobStatus: jobStatus[index],
                                                            departmentUser: widget.departmentUser,
                                                            idUser: widget.idUser,
                                                            namaUser: widget.namaUser,
                                                          );
                                                        }
                                                      ).then((value) {
                                                        print('berhasil');
                                                      });
                                                    },
                                                  ),
                                                ),
                                                dueDate[index].toDate().toString().substring(8, 10) + '/' + dueDate[index].toDate().toString().substring(5, 7) + '/' + dueDate[index].toDate().toString().substring(0, 4) == DateTime.now().toString().substring(8, 10) + '/' + DateTime.now().toString().substring(5, 7) + '/' + DateTime.now().toString().substring(0, 4)
                                                  ? Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
                                                        ButtonTheme(
                                                          minWidth: MediaQuery.of(context).size.width * 0.20,
                                                          height: 30.0,
                                                          child: OutlineButton(
                                                            child: Row(
                                                              children: <Widget>[
                                                                Container(
                                                                  width: MediaQuery.of(context).size.width * 0.10,
                                                                  alignment: Alignment.centerLeft,
                                                                  child: Text(
                                                                    'Skip',
                                                                    style: TextStyle(
                                                                      fontSize: 13.0,
                                                                      color: AbubaPallate.menuBluebird,
                                                                      fontWeight: FontWeight.bold
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: MediaQuery.of(context).size.width * 0.10,
                                                                  alignment: Alignment.centerRight,
                                                                  child: Icon(Icons.close, color: AbubaPallate.menuBluebird, size: 18.0),
                                                                )
                                                              ],
                                                            ),
                                                            borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 2.0),
                                                            highlightedBorderColor: AbubaPallate.menuBluebird,
                                                            splashColor: Colors.white,
                                                            onPressed: () {
                                                              showDialog(
                                                                barrierDismissible: false,
                                                                context: context,
                                                                builder: (context) {
                                                                  return Checkbox2(
                                                                    alasan: alasanName,
                                                                    valueCheck: alasanID,
                                                                    frequency: frequency[index],
                                                                    indexx: indexx[index],
                                                                    item: item[index],
                                                                    itemNo: itemNo[index],
                                                                    lokasi: lokasi[index],
                                                                    merek: merek[index],
                                                                    outlet: outlet[index],
                                                                    pic: pic[index],
                                                                    onCancelResult: (cancelResult) {},
                                                                    onResult: (finalResult) {},
                                                                    jobStatus: jobStatus[index],
                                                                    job: job[index],
                                                                    userCreated: userCreated[index],
                                                                    idUser: widget.idUser,
                                                                    departmentUser: widget.departmentUser,
                                                                    namaUser: widget.namaUser,                                                                  
                                                                  );
                                                                }
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10.0,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            scan(outlet[index], lokasi[index], qrCode[index], merek[index], item[index], itemNo[index], pic[index], frequency[index], indexx[index], index, job[index], userCreated[index], 'save');
                                                          },
                                                          child: Container(
                                                            width: MediaQuery.of(context).size.width * 0.1,
                                                            height: MediaQuery.of(context).size.width * 0.1,
                                                            padding: EdgeInsets.only(right: 10.0, bottom: 10.0, left: 10.0),
                                                            alignment: Alignment.centerRight,
                                                            decoration: new BoxDecoration(
                                                              color: Colors.transparent,
                                                              shape: BoxShape.rectangle,
                                                              image: DecorationImage(
                                                                image: AssetImage('assets/images/scanner.png'),
                                                                fit: BoxFit.fitWidth
                                                              )
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : Container()
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
                                                Flexible(
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            'FREQUENCY',
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
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            frequency[index],
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
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
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
                                                            'Detail',
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
                                                      showModalBottomSheet(
                                                        context: context,
                                                        builder: (builder) {
                                                          return DialogBottomDetail(
                                                            job: job[index],
                                                            jobStatus: jobStatus[index],
                                                            departmentUser: widget.departmentUser,
                                                            idUser: widget.idUser,
                                                            namaUser: widget.namaUser,
                                                          );
                                                        }
                                                      ).then((value) {
                                                        print('berhasil');
                                                      });
                                                    },
                                                  ),
                                                ),
                                                dueDate[index].toDate().toString().substring(8, 10) + '/' + dueDate[index].toDate().toString().substring(5, 7) + '/' + dueDate[index].toDate().toString().substring(0, 4) == DateTime.now().toString().substring(8, 10) + '/' + DateTime.now().toString().substring(5, 7) + '/' + DateTime.now().toString().substring(0, 4)
                                                  ? Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
                                                        ButtonTheme(
                                                          minWidth: MediaQuery.of(context).size.width * 0.20,
                                                          height: 30.0,
                                                          child: OutlineButton(
                                                            child: Row(
                                                              children: <Widget>[
                                                                Container(
                                                                  width: MediaQuery.of(context).size.width * 0.10,
                                                                  alignment: Alignment.centerLeft,
                                                                  child: Text(
                                                                    'Skip',
                                                                    style: TextStyle(
                                                                      fontSize: 13.0,
                                                                      color: AbubaPallate.menuBluebird,
                                                                      fontWeight: FontWeight.bold
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: MediaQuery.of(context).size.width * 0.10,
                                                                  alignment: Alignment.centerRight,
                                                                  child: Icon(Icons.close, color: AbubaPallate.menuBluebird, size: 18.0),
                                                                )
                                                              ],
                                                            ),
                                                            borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 2.0),
                                                            highlightedBorderColor: AbubaPallate.menuBluebird,
                                                            splashColor: Colors.white,
                                                            onPressed: () {
                                                              showDialog(
                                                                barrierDismissible: false,
                                                                context: context,
                                                                builder: (context) {
                                                                  return Checkbox2(
                                                                    alasan: alasanName,
                                                                    valueCheck: alasanID,
                                                                    frequency: frequency[index],
                                                                    indexx: indexx[index],
                                                                    item: item[index],
                                                                    itemNo: itemNo[index],
                                                                    lokasi: lokasi[index],
                                                                    merek: merek[index],
                                                                    outlet: outlet[index],
                                                                    pic: pic[index],
                                                                    onCancelResult: (cancelResult) {},
                                                                    onResult: (finalResult) {},
                                                                    jobStatus: jobStatus[index],
                                                                    job: job[index],
                                                                    userCreated: userCreated[index],
                                                                    idUser: widget.idUser,
                                                                    departmentUser: widget.departmentUser,
                                                                    namaUser: widget.namaUser,                                                                  
                                                                  );
                                                                }
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10.0,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            scan(outlet[index], lokasi[index], qrCode[index], merek[index], item[index], itemNo[index], pic[index], frequency[index], indexx[index], index, job[index], userCreated[index], 'save');
                                                          },
                                                          child: Container(
                                                            width: MediaQuery.of(context).size.width * 0.1,
                                                            height: MediaQuery.of(context).size.width * 0.1,
                                                            padding: EdgeInsets.only(right: 10.0, bottom: 10.0, left: 10.0),
                                                            alignment: Alignment.centerRight,
                                                            decoration: new BoxDecoration(
                                                              color: Colors.transparent,
                                                              shape: BoxShape.rectangle,
                                                              image: DecorationImage(
                                                                image: AssetImage('assets/images/scanner.png'),
                                                                fit: BoxFit.fitWidth
                                                              )
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : Container()
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
                              }
                            } else {
                              return Container();
                            }
                          } else {
                            return Container();
                          }
                        } else {
                          return Container();
                        }
                      },
                    ),
                    // batas today
                    ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: indexx.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (picID[index] == widget.idUser) {
                          if (status[index] == 'OPEN') {
                            if (dueDate[index].toDate() != DateTime.now()) {
                              if (dueDate[index].toDate().isAfter(DateTime.now()) || dueDate[index].toDate().isBefore(DateTime.now())) {
                                if (isFilter) {
                                  if (filterFreq != '' && filterArea != '' && filterLokasi != '') {
                                    if (frequency[index] == filterFreq && outlet[index] == filterArea && lokasi[index] == filterLokasi) {
                                      // filter frequency area lokasi
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        verticalDirection: VerticalDirection.down,
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                                            color: Colors.white,
                                            child: Container(
                                              // decoration: BoxDecoration(
                                              //   color: Colors.white,
                                              //   borderRadius: BorderRadius.circular(30.0),
                                              //   border: Border.all(
                                              //     width: 1.0,
                                              //     color: Colors.black12
                                              //   )
                                              // ),
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
                                                        Flexible(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: <Widget>[
                                                                Flexible(
                                                                  child: Text(
                                                                    'FREQUENCY',
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
                                                        ),
                                                        Flexible(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: <Widget>[
                                                                Flexible(
                                                                  child: Text(
                                                                    'DUE DATE',
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
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: <Widget>[
                                                                Flexible(
                                                                  child: Text(
                                                                    frequency[index],
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
                                                        ),
                                                        Flexible(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: <Widget>[
                                                                Flexible(
                                                                  child: Text(
                                                                    dueDate[index].toDate().toString().substring(8, 10) + '/' + dueDate[index].toDate().toString().substring(5, 7) + '/' + dueDate[index].toDate().toString().substring(0, 4),
                                                                    style: TextStyle(
                                                                      fontSize: 14.0,
                                                                      fontWeight: FontWeight.w500,
                                                                      color: dueDate[index].toDate().isBefore(DateTime.now()) ? Colors.redAccent : Colors.black54,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
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
                                                                    'Detail',
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
                                                              showModalBottomSheet(
                                                                context: context,
                                                                builder: (builder) {
                                                                  return DialogBottomDetail(
                                                                    job: job[index],
                                                                    jobStatus: jobStatus[index],
                                                            departmentUser: widget.departmentUser,
                                                            idUser: widget.idUser,
                                                            namaUser: widget.namaUser,
                                                                  );
                                                                }
                                                              ).then((value) {
                                                                print('berhasil');
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        DateTime.now().isAfter(dueDate[index].toDate())
                                                          ? Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: <Widget>[
                                                                ButtonTheme(
                                                                  minWidth: MediaQuery.of(context).size.width * 0.20,
                                                                  height: 30.0,
                                                                  child: OutlineButton(
                                                                    child: Row(
                                                                      children: <Widget>[
                                                                        Container(
                                                                          width: MediaQuery.of(context).size.width * 0.10,
                                                                          alignment: Alignment.centerLeft,
                                                                          child: Text(
                                                                            'Skip',
                                                                            style: TextStyle(
                                                                              fontSize: 13.0,
                                                                              color: AbubaPallate.menuBluebird,
                                                                              fontWeight: FontWeight.bold
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          width: MediaQuery.of(context).size.width * 0.10,
                                                                          alignment: Alignment.centerRight,
                                                                          child: Icon(Icons.close, color: AbubaPallate.menuBluebird, size: 18.0),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 2.0),
                                                                    highlightedBorderColor: AbubaPallate.menuBluebird,
                                                                    splashColor: Colors.white,
                                                                    onPressed: () {
                                                                      showDialog(
                                                                        barrierDismissible: false,
                                                                        context: context,
                                                                        builder: (context) {
                                                                          return Checkbox2(
                                                                            alasan: alasanName,
                                                                            valueCheck: alasanID,
                                                                            frequency: frequency[index],
                                                                            indexx: indexx[index],
                                                                            item: item[index],
                                                                            itemNo: itemNo[index],
                                                                            lokasi: lokasi[index],
                                                                            merek: merek[index],
                                                                            outlet: outlet[index],
                                                                            pic: pic[index],
                                                                            onCancelResult: (cancelResult) {},
                                                                            onResult: (finalResult) {},
                                                                            jobStatus: jobStatus[index],
                                                                            job: job[index],
                                                                            userCreated: userCreated[index],
                                                                            idUser: widget.idUser,
                                                                            departmentUser: widget.departmentUser,
                                                                            namaUser: widget.namaUser,                                                                  
                                                                          );
                                                                        }
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 10.0,
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    scan(outlet[index], lokasi[index], qrCode[index], merek[index], item[index], itemNo[index], pic[index], frequency[index], indexx[index], index, job[index], userCreated[index], 'save');
                                                                  },
                                                                  child: Container(
                                                                    width: MediaQuery.of(context).size.width * 0.1,
                                                                    height: MediaQuery.of(context).size.width * 0.1,
                                                                    padding: EdgeInsets.only(right: 10.0, bottom: 10.0, left: 10.0),
                                                                    alignment: Alignment.centerRight,
                                                                    decoration: new BoxDecoration(
                                                                      color: Colors.transparent,
                                                                      shape: BoxShape.rectangle,
                                                                      image: DecorationImage(
                                                                        image: AssetImage('assets/images/scanner.png'),
                                                                        fit: BoxFit.fitWidth
                                                                      )
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : Container()
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
                                  } else if (filterFreq != '' && filterArea != '' && filterLokasi == '') {
                                    if (frequency[index] == filterFreq && outlet[index] == filterArea) {
                                      // filter frequency area
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        verticalDirection: VerticalDirection.down,
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                                            color: Colors.white,
                                            child: Container(
                                              // decoration: BoxDecoration(
                                              //   color: Colors.white,
                                              //   borderRadius: BorderRadius.circular(30.0),
                                              //   border: Border.all(
                                              //     width: 1.0,
                                              //     color: Colors.black12
                                              //   )
                                              // ),
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
                                                        Flexible(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: <Widget>[
                                                                Flexible(
                                                                  child: Text(
                                                                    'FREQUENCY',
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
                                                        ),
                                                        Flexible(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: <Widget>[
                                                                Flexible(
                                                                  child: Text(
                                                                    'DUE DATE',
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
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: <Widget>[
                                                                Flexible(
                                                                  child: Text(
                                                                    frequency[index],
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
                                                        ),
                                                        Flexible(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: <Widget>[
                                                                Flexible(
                                                                  child: Text(
                                                                    dueDate[index].toDate().toString().substring(8, 10) + '/' + dueDate[index].toDate().toString().substring(5, 7) + '/' + dueDate[index].toDate().toString().substring(0, 4),
                                                                    style: TextStyle(
                                                                      fontSize: 14.0,
                                                                      fontWeight: FontWeight.w500,
                                                                      color: dueDate[index].toDate().isBefore(DateTime.now()) ? Colors.redAccent : Colors.black54,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
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
                                                                    'Detail',
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
                                                              showModalBottomSheet(
                                                                context: context,
                                                                builder: (builder) {
                                                                  return DialogBottomDetail(
                                                                    job: job[index],
                                                                    jobStatus: jobStatus[index],
                                                            departmentUser: widget.departmentUser,
                                                            idUser: widget.idUser,
                                                            namaUser: widget.namaUser,
                                                                  );
                                                                }
                                                              ).then((value) {
                                                                print('berhasil');
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        DateTime.now().isAfter(dueDate[index].toDate())
                                                          ? Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: <Widget>[
                                                                ButtonTheme(
                                                                  minWidth: MediaQuery.of(context).size.width * 0.20,
                                                                  height: 30.0,
                                                                  child: OutlineButton(
                                                                    child: Row(
                                                                      children: <Widget>[
                                                                        Container(
                                                                          width: MediaQuery.of(context).size.width * 0.10,
                                                                          alignment: Alignment.centerLeft,
                                                                          child: Text(
                                                                            'Skip',
                                                                            style: TextStyle(
                                                                              fontSize: 13.0,
                                                                              color: AbubaPallate.menuBluebird,
                                                                              fontWeight: FontWeight.bold
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          width: MediaQuery.of(context).size.width * 0.10,
                                                                          alignment: Alignment.centerRight,
                                                                          child: Icon(Icons.close, color: AbubaPallate.menuBluebird, size: 18.0),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 2.0),
                                                                    highlightedBorderColor: AbubaPallate.menuBluebird,
                                                                    splashColor: Colors.white,
                                                                    onPressed: () {
                                                                      showDialog(
                                                                        barrierDismissible: false,
                                                                        context: context,
                                                                        builder: (context) {
                                                                          return Checkbox2(
                                                                            alasan: alasanName,
                                                                            valueCheck: alasanID,
                                                                            frequency: frequency[index],
                                                                            indexx: indexx[index],
                                                                            item: item[index],
                                                                            itemNo: itemNo[index],
                                                                            lokasi: lokasi[index],
                                                                            merek: merek[index],
                                                                            outlet: outlet[index],
                                                                            pic: pic[index],
                                                                            onCancelResult: (cancelResult) {},
                                                                            onResult: (finalResult) {},
                                                                            jobStatus: jobStatus[index],
                                                                            job: job[index],
                                                                            userCreated: userCreated[index],
                                                                            idUser: widget.idUser,
                                                                            departmentUser: widget.departmentUser,
                                                                            namaUser: widget.namaUser,                                                                  
                                                                          );
                                                                        }
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 10.0,
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    scan(outlet[index], lokasi[index], qrCode[index], merek[index], item[index], itemNo[index], pic[index], frequency[index], indexx[index], index, job[index], userCreated[index], 'save');
                                                                  },
                                                                  child: Container(
                                                                    width: MediaQuery.of(context).size.width * 0.1,
                                                                    height: MediaQuery.of(context).size.width * 0.1,
                                                                    padding: EdgeInsets.only(right: 10.0, bottom: 10.0, left: 10.0),
                                                                    alignment: Alignment.centerRight,
                                                                    decoration: new BoxDecoration(
                                                                      color: Colors.transparent,
                                                                      shape: BoxShape.rectangle,
                                                                      image: DecorationImage(
                                                                        image: AssetImage('assets/images/scanner.png'),
                                                                        fit: BoxFit.fitWidth
                                                                      )
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : Container()
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
                                  } else if (filterFreq != '' && filterArea == '' && filterLokasi != '') {
                                    if (frequency[index] == filterFreq && lokasi[index] == filterLokasi) {
                                      // filter frequency lokasi
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        verticalDirection: VerticalDirection.down,
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                                            color: Colors.white,
                                            child: Container(
                                              // decoration: BoxDecoration(
                                              //   color: Colors.white,
                                              //   borderRadius: BorderRadius.circular(30.0),
                                              //   border: Border.all(
                                              //     width: 1.0,
                                              //     color: Colors.black12
                                              //   )
                                              // ),
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
                                                        Flexible(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: <Widget>[
                                                                Flexible(
                                                                  child: Text(
                                                                    'FREQUENCY',
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
                                                        ),
                                                        Flexible(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: <Widget>[
                                                                Flexible(
                                                                  child: Text(
                                                                    'DUE DATE',
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
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: <Widget>[
                                                                Flexible(
                                                                  child: Text(
                                                                    frequency[index],
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
                                                        ),
                                                        Flexible(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: <Widget>[
                                                                Flexible(
                                                                  child: Text(
                                                                    dueDate[index].toDate().toString().substring(8, 10) + '/' + dueDate[index].toDate().toString().substring(5, 7) + '/' + dueDate[index].toDate().toString().substring(0, 4),
                                                                    style: TextStyle(
                                                                      fontSize: 14.0,
                                                                      fontWeight: FontWeight.w500,
                                                                      color: dueDate[index].toDate().isBefore(DateTime.now()) ? Colors.redAccent : Colors.black54,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
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
                                                                    'Detail',
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
                                                              showModalBottomSheet(
                                                                context: context,
                                                                builder: (builder) {
                                                                  return DialogBottomDetail(
                                                                    job: job[index],
                                                                    jobStatus: jobStatus[index],
                                                            departmentUser: widget.departmentUser,
                                                            idUser: widget.idUser,
                                                            namaUser: widget.namaUser,
                                                                  );
                                                                }
                                                              ).then((value) {
                                                                print('berhasil');
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        DateTime.now().isAfter(dueDate[index].toDate())
                                                          ? Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: <Widget>[
                                                                ButtonTheme(
                                                                  minWidth: MediaQuery.of(context).size.width * 0.20,
                                                                  height: 30.0,
                                                                  child: OutlineButton(
                                                                    child: Row(
                                                                      children: <Widget>[
                                                                        Container(
                                                                          width: MediaQuery.of(context).size.width * 0.10,
                                                                          alignment: Alignment.centerLeft,
                                                                          child: Text(
                                                                            'Skip',
                                                                            style: TextStyle(
                                                                              fontSize: 13.0,
                                                                              color: AbubaPallate.menuBluebird,
                                                                              fontWeight: FontWeight.bold
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          width: MediaQuery.of(context).size.width * 0.10,
                                                                          alignment: Alignment.centerRight,
                                                                          child: Icon(Icons.close, color: AbubaPallate.menuBluebird, size: 18.0),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 2.0),
                                                                    highlightedBorderColor: AbubaPallate.menuBluebird,
                                                                    splashColor: Colors.white,
                                                                    onPressed: () {
                                                                      showDialog(
                                                                        barrierDismissible: false,
                                                                        context: context,
                                                                        builder: (context) {
                                                                          return Checkbox2(
                                                                            alasan: alasanName,
                                                                            valueCheck: alasanID,
                                                                            frequency: frequency[index],
                                                                            indexx: indexx[index],
                                                                            item: item[index],
                                                                            itemNo: itemNo[index],
                                                                            lokasi: lokasi[index],
                                                                            merek: merek[index],
                                                                            outlet: outlet[index],
                                                                            pic: pic[index],
                                                                            onCancelResult: (cancelResult) {},
                                                                            onResult: (finalResult) {},
                                                                            jobStatus: jobStatus[index],
                                                                            job: job[index],
                                                                            userCreated: userCreated[index],
                                                                            idUser: widget.idUser,
                                                                            departmentUser: widget.departmentUser,
                                                                            namaUser: widget.namaUser,                                                                  
                                                                          );
                                                                        }
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 10.0,
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    scan(outlet[index], lokasi[index], qrCode[index], merek[index], item[index], itemNo[index], pic[index], frequency[index], indexx[index], index, job[index], userCreated[index], 'save');
                                                                  },
                                                                  child: Container(
                                                                    width: MediaQuery.of(context).size.width * 0.1,
                                                                    height: MediaQuery.of(context).size.width * 0.1,
                                                                    padding: EdgeInsets.only(right: 10.0, bottom: 10.0, left: 10.0),
                                                                    alignment: Alignment.centerRight,
                                                                    decoration: new BoxDecoration(
                                                                      color: Colors.transparent,
                                                                      shape: BoxShape.rectangle,
                                                                      image: DecorationImage(
                                                                        image: AssetImage('assets/images/scanner.png'),
                                                                        fit: BoxFit.fitWidth
                                                                      )
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : Container()
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
                                  } else if (filterFreq != '' && filterArea == '' && filterLokasi == '') {
                                    if (frequency[index] == filterFreq) {
                                      // filter frequency 
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        verticalDirection: VerticalDirection.down,
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                                            color: Colors.white,
                                            child: Container(
                                              // decoration: BoxDecoration(
                                              //   color: Colors.white,
                                              //   borderRadius: BorderRadius.circular(30.0),
                                              //   border: Border.all(
                                              //     width: 1.0,
                                              //     color: Colors.black12
                                              //   )
                                              // ),
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
                                                        Flexible(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: <Widget>[
                                                                Flexible(
                                                                  child: Text(
                                                                    'FREQUENCY',
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
                                                        ),
                                                        Flexible(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: <Widget>[
                                                                Flexible(
                                                                  child: Text(
                                                                    'DUE DATE',
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
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: <Widget>[
                                                                Flexible(
                                                                  child: Text(
                                                                    frequency[index],
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
                                                        ),
                                                        Flexible(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: <Widget>[
                                                                Flexible(
                                                                  child: Text(
                                                                    dueDate[index].toDate().toString().substring(8, 10) + '/' + dueDate[index].toDate().toString().substring(5, 7) + '/' + dueDate[index].toDate().toString().substring(0, 4),
                                                                    style: TextStyle(
                                                                      fontSize: 14.0,
                                                                      fontWeight: FontWeight.w500,
                                                                      color: dueDate[index].toDate().isBefore(DateTime.now()) ? Colors.redAccent : Colors.black54,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
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
                                                                    'Detail',
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
                                                              showModalBottomSheet(
                                                                context: context,
                                                                builder: (builder) {
                                                                  return DialogBottomDetail(
                                                                    job: job[index],
                                                                    jobStatus: jobStatus[index],
                                                            departmentUser: widget.departmentUser,
                                                            idUser: widget.idUser,
                                                            namaUser: widget.namaUser,
                                                                  );
                                                                }
                                                              ).then((value) {
                                                                print('berhasil');
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        DateTime.now().isAfter(dueDate[index].toDate())
                                                          ? Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: <Widget>[
                                                                ButtonTheme(
                                                                  minWidth: MediaQuery.of(context).size.width * 0.20,
                                                                  height: 30.0,
                                                                  child: OutlineButton(
                                                                    child: Row(
                                                                      children: <Widget>[
                                                                        Container(
                                                                          width: MediaQuery.of(context).size.width * 0.10,
                                                                          alignment: Alignment.centerLeft,
                                                                          child: Text(
                                                                            'Skip',
                                                                            style: TextStyle(
                                                                              fontSize: 13.0,
                                                                              color: AbubaPallate.menuBluebird,
                                                                              fontWeight: FontWeight.bold
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          width: MediaQuery.of(context).size.width * 0.10,
                                                                          alignment: Alignment.centerRight,
                                                                          child: Icon(Icons.close, color: AbubaPallate.menuBluebird, size: 18.0),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 2.0),
                                                                    highlightedBorderColor: AbubaPallate.menuBluebird,
                                                                    splashColor: Colors.white,
                                                                    onPressed: () {
                                                                      showDialog(
                                                                        barrierDismissible: false,
                                                                        context: context,
                                                                        builder: (context) {
                                                                          return Checkbox2(
                                                                            alasan: alasanName,
                                                                            valueCheck: alasanID,
                                                                            frequency: frequency[index],
                                                                            indexx: indexx[index],
                                                                            item: item[index],
                                                                            itemNo: itemNo[index],
                                                                            lokasi: lokasi[index],
                                                                            merek: merek[index],
                                                                            outlet: outlet[index],
                                                                            pic: pic[index],
                                                                            onCancelResult: (cancelResult) {},
                                                                            onResult: (finalResult) {},
                                                                            jobStatus: jobStatus[index],
                                                                            job: job[index],
                                                                            userCreated: userCreated[index],
                                                                            idUser: widget.idUser,
                                                                            departmentUser: widget.departmentUser,
                                                                            namaUser: widget.namaUser,                                                                  
                                                                          );
                                                                        }
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 10.0,
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    scan(outlet[index], lokasi[index], qrCode[index], merek[index], item[index], itemNo[index], pic[index], frequency[index], indexx[index], index, job[index], userCreated[index], 'save');
                                                                  },
                                                                  child: Container(
                                                                    width: MediaQuery.of(context).size.width * 0.1,
                                                                    height: MediaQuery.of(context).size.width * 0.1,
                                                                    padding: EdgeInsets.only(right: 10.0, bottom: 10.0, left: 10.0),
                                                                    alignment: Alignment.centerRight,
                                                                    decoration: new BoxDecoration(
                                                                      color: Colors.transparent,
                                                                      shape: BoxShape.rectangle,
                                                                      image: DecorationImage(
                                                                        image: AssetImage('assets/images/scanner.png'),
                                                                        fit: BoxFit.fitWidth
                                                                      )
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : Container()
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
                                  } else if (filterFreq == '' && filterArea != '' && filterLokasi != '') {
                                    if (outlet[index] == filterArea && lokasi[index] == filterLokasi) {
                                      // filter area lokasi
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        verticalDirection: VerticalDirection.down,
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                                            color: Colors.white,
                                            child: Container(
                                              // decoration: BoxDecoration(
                                              //   color: Colors.white,
                                              //   borderRadius: BorderRadius.circular(30.0),
                                              //   border: Border.all(
                                              //     width: 1.0,
                                              //     color: Colors.black12
                                              //   )
                                              // ),
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
                                                        Flexible(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: <Widget>[
                                                                Flexible(
                                                                  child: Text(
                                                                    'FREQUENCY',
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
                                                        ),
                                                        Flexible(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: <Widget>[
                                                                Flexible(
                                                                  child: Text(
                                                                    'DUE DATE',
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
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: <Widget>[
                                                                Flexible(
                                                                  child: Text(
                                                                    frequency[index],
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
                                                        ),
                                                        Flexible(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: <Widget>[
                                                                Flexible(
                                                                  child: Text(
                                                                    dueDate[index].toDate().toString().substring(8, 10) + '/' + dueDate[index].toDate().toString().substring(5, 7) + '/' + dueDate[index].toDate().toString().substring(0, 4),
                                                                    style: TextStyle(
                                                                      fontSize: 14.0,
                                                                      fontWeight: FontWeight.w500,
                                                                      color: dueDate[index].toDate().isBefore(DateTime.now()) ? Colors.redAccent : Colors.black54,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
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
                                                                    'Detail',
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
                                                              showModalBottomSheet(
                                                                context: context,
                                                                builder: (builder) {
                                                                  return DialogBottomDetail(
                                                                    job: job[index],
                                                                    jobStatus: jobStatus[index],
                                                            departmentUser: widget.departmentUser,
                                                            idUser: widget.idUser,
                                                            namaUser: widget.namaUser,
                                                                  );
                                                                }
                                                              ).then((value) {
                                                                print('berhasil');
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        DateTime.now().isAfter(dueDate[index].toDate())
                                                          ? Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: <Widget>[
                                                                ButtonTheme(
                                                                  minWidth: MediaQuery.of(context).size.width * 0.20,
                                                                  height: 30.0,
                                                                  child: OutlineButton(
                                                                    child: Row(
                                                                      children: <Widget>[
                                                                        Container(
                                                                          width: MediaQuery.of(context).size.width * 0.10,
                                                                          alignment: Alignment.centerLeft,
                                                                          child: Text(
                                                                            'Skip',
                                                                            style: TextStyle(
                                                                              fontSize: 13.0,
                                                                              color: AbubaPallate.menuBluebird,
                                                                              fontWeight: FontWeight.bold
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          width: MediaQuery.of(context).size.width * 0.10,
                                                                          alignment: Alignment.centerRight,
                                                                          child: Icon(Icons.close, color: AbubaPallate.menuBluebird, size: 18.0),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 2.0),
                                                                    highlightedBorderColor: AbubaPallate.menuBluebird,
                                                                    splashColor: Colors.white,
                                                                    onPressed: () {
                                                                      showDialog(
                                                                        barrierDismissible: false,
                                                                        context: context,
                                                                        builder: (context) {
                                                                          return Checkbox2(
                                                                            alasan: alasanName,
                                                                            valueCheck: alasanID,
                                                                            frequency: frequency[index],
                                                                            indexx: indexx[index],
                                                                            item: item[index],
                                                                            itemNo: itemNo[index],
                                                                            lokasi: lokasi[index],
                                                                            merek: merek[index],
                                                                            outlet: outlet[index],
                                                                            pic: pic[index],
                                                                            onCancelResult: (cancelResult) {},
                                                                            onResult: (finalResult) {},
                                                                            jobStatus: jobStatus[index],
                                                                            job: job[index],
                                                                            userCreated: userCreated[index],
                                                                            idUser: widget.idUser,
                                                                            departmentUser: widget.departmentUser,
                                                                            namaUser: widget.namaUser,                                                                  
                                                                          );
                                                                        }
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 10.0,
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    scan(outlet[index], lokasi[index], qrCode[index], merek[index], item[index], itemNo[index], pic[index], frequency[index], indexx[index], index, job[index], userCreated[index], 'save');
                                                                  },
                                                                  child: Container(
                                                                    width: MediaQuery.of(context).size.width * 0.1,
                                                                    height: MediaQuery.of(context).size.width * 0.1,
                                                                    padding: EdgeInsets.only(right: 10.0, bottom: 10.0, left: 10.0),
                                                                    alignment: Alignment.centerRight,
                                                                    decoration: new BoxDecoration(
                                                                      color: Colors.transparent,
                                                                      shape: BoxShape.rectangle,
                                                                      image: DecorationImage(
                                                                        image: AssetImage('assets/images/scanner.png'),
                                                                        fit: BoxFit.fitWidth
                                                                      )
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : Container()
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
                                  } else if (filterFreq == '' && filterArea != '' && filterLokasi == '') {
                                    if (outlet[index] == filterArea) {
                                      // filter area
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        verticalDirection: VerticalDirection.down,
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                                            color: Colors.white,
                                            child: Container(
                                              // decoration: BoxDecoration(
                                              //   color: Colors.white,
                                              //   borderRadius: BorderRadius.circular(30.0),
                                              //   border: Border.all(
                                              //     width: 1.0,
                                              //     color: Colors.black12
                                              //   )
                                              // ),
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
                                                        Flexible(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: <Widget>[
                                                                Flexible(
                                                                  child: Text(
                                                                    'FREQUENCY',
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
                                                        ),
                                                        Flexible(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: <Widget>[
                                                                Flexible(
                                                                  child: Text(
                                                                    'DUE DATE',
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
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: <Widget>[
                                                                Flexible(
                                                                  child: Text(
                                                                    frequency[index],
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
                                                        ),
                                                        Flexible(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: <Widget>[
                                                                Flexible(
                                                                  child: Text(
                                                                    dueDate[index].toDate().toString().substring(8, 10) + '/' + dueDate[index].toDate().toString().substring(5, 7) + '/' + dueDate[index].toDate().toString().substring(0, 4),
                                                                    style: TextStyle(
                                                                      fontSize: 14.0,
                                                                      fontWeight: FontWeight.w500,
                                                                      color: dueDate[index].toDate().isBefore(DateTime.now()) ? Colors.redAccent : Colors.black54,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
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
                                                                    'Detail',
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
                                                              showModalBottomSheet(
                                                                context: context,
                                                                builder: (builder) {
                                                                  return DialogBottomDetail(
                                                                    job: job[index],
                                                                    jobStatus: jobStatus[index],
                                                            departmentUser: widget.departmentUser,
                                                            idUser: widget.idUser,
                                                            namaUser: widget.namaUser,
                                                                  );
                                                                }
                                                              ).then((value) {
                                                                print('berhasil');
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        DateTime.now().isAfter(dueDate[index].toDate())
                                                          ? Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: <Widget>[
                                                                ButtonTheme(
                                                                  minWidth: MediaQuery.of(context).size.width * 0.20,
                                                                  height: 30.0,
                                                                  child: OutlineButton(
                                                                    child: Row(
                                                                      children: <Widget>[
                                                                        Container(
                                                                          width: MediaQuery.of(context).size.width * 0.10,
                                                                          alignment: Alignment.centerLeft,
                                                                          child: Text(
                                                                            'Skip',
                                                                            style: TextStyle(
                                                                              fontSize: 13.0,
                                                                              color: AbubaPallate.menuBluebird,
                                                                              fontWeight: FontWeight.bold
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          width: MediaQuery.of(context).size.width * 0.10,
                                                                          alignment: Alignment.centerRight,
                                                                          child: Icon(Icons.close, color: AbubaPallate.menuBluebird, size: 18.0),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 2.0),
                                                                    highlightedBorderColor: AbubaPallate.menuBluebird,
                                                                    splashColor: Colors.white,
                                                                    onPressed: () {
                                                                      showDialog(
                                                                        barrierDismissible: false,
                                                                        context: context,
                                                                        builder: (context) {
                                                                          return Checkbox2(
                                                                            alasan: alasanName,
                                                                            valueCheck: alasanID,
                                                                            frequency: frequency[index],
                                                                            indexx: indexx[index],
                                                                            item: item[index],
                                                                            itemNo: itemNo[index],
                                                                            lokasi: lokasi[index],
                                                                            merek: merek[index],
                                                                            outlet: outlet[index],
                                                                            pic: pic[index],
                                                                            onCancelResult: (cancelResult) {},
                                                                            onResult: (finalResult) {},
                                                                            jobStatus: jobStatus[index],
                                                                            job: job[index],
                                                                            userCreated: userCreated[index],
                                                                            idUser: widget.idUser,
                                                                            departmentUser: widget.departmentUser,
                                                                            namaUser: widget.namaUser,                                                                  
                                                                          );
                                                                        }
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 10.0,
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    scan(outlet[index], lokasi[index], qrCode[index], merek[index], item[index], itemNo[index], pic[index], frequency[index], indexx[index], index, job[index], userCreated[index], 'save');
                                                                  },
                                                                  child: Container(
                                                                    width: MediaQuery.of(context).size.width * 0.1,
                                                                    height: MediaQuery.of(context).size.width * 0.1,
                                                                    padding: EdgeInsets.only(right: 10.0, bottom: 10.0, left: 10.0),
                                                                    alignment: Alignment.centerRight,
                                                                    decoration: new BoxDecoration(
                                                                      color: Colors.transparent,
                                                                      shape: BoxShape.rectangle,
                                                                      image: DecorationImage(
                                                                        image: AssetImage('assets/images/scanner.png'),
                                                                        fit: BoxFit.fitWidth
                                                                      )
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : Container()
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
                                  } else if (filterFreq == '' && filterArea == '' && filterLokasi != '') {
                                    if (lokasi[index] == filterLokasi) {
                                      // filter lokasi
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        verticalDirection: VerticalDirection.down,
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                                            color: Colors.white,
                                            child: Container(
                                              // decoration: BoxDecoration(
                                              //   color: Colors.white,
                                              //   borderRadius: BorderRadius.circular(30.0),
                                              //   border: Border.all(
                                              //     width: 1.0,
                                              //     color: Colors.black12
                                              //   )
                                              // ),
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
                                                        Flexible(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: <Widget>[
                                                                Flexible(
                                                                  child: Text(
                                                                    'FREQUENCY',
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
                                                        ),
                                                        Flexible(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: <Widget>[
                                                                Flexible(
                                                                  child: Text(
                                                                    'DUE DATE',
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
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: <Widget>[
                                                                Flexible(
                                                                  child: Text(
                                                                    frequency[index],
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
                                                        ),
                                                        Flexible(
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: <Widget>[
                                                                Flexible(
                                                                  child: Text(
                                                                    dueDate[index].toDate().toString().substring(8, 10) + '/' + dueDate[index].toDate().toString().substring(5, 7) + '/' + dueDate[index].toDate().toString().substring(0, 4),
                                                                    style: TextStyle(
                                                                      fontSize: 14.0,
                                                                      fontWeight: FontWeight.w500,
                                                                      color: dueDate[index].toDate().isBefore(DateTime.now()) ? Colors.redAccent : Colors.black54,
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
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
                                                                    'Detail',
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
                                                              showModalBottomSheet(
                                                                context: context,
                                                                builder: (builder) {
                                                                  return DialogBottomDetail(
                                                                    job: job[index],
                                                                    jobStatus: jobStatus[index],
                                                            departmentUser: widget.departmentUser,
                                                            idUser: widget.idUser,
                                                            namaUser: widget.namaUser,
                                                                  );
                                                                }
                                                              ).then((value) {
                                                                print('berhasil');
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        DateTime.now().isAfter(dueDate[index].toDate())
                                                          ? Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: <Widget>[
                                                                ButtonTheme(
                                                                  minWidth: MediaQuery.of(context).size.width * 0.20,
                                                                  height: 30.0,
                                                                  child: OutlineButton(
                                                                    child: Row(
                                                                      children: <Widget>[
                                                                        Container(
                                                                          width: MediaQuery.of(context).size.width * 0.10,
                                                                          alignment: Alignment.centerLeft,
                                                                          child: Text(
                                                                            'Skip',
                                                                            style: TextStyle(
                                                                              fontSize: 13.0,
                                                                              color: AbubaPallate.menuBluebird,
                                                                              fontWeight: FontWeight.bold
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          width: MediaQuery.of(context).size.width * 0.10,
                                                                          alignment: Alignment.centerRight,
                                                                          child: Icon(Icons.close, color: AbubaPallate.menuBluebird, size: 18.0),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 2.0),
                                                                    highlightedBorderColor: AbubaPallate.menuBluebird,
                                                                    splashColor: Colors.white,
                                                                    onPressed: () {
                                                                      showDialog(
                                                                        barrierDismissible: false,
                                                                        context: context,
                                                                        builder: (context) {
                                                                          return Checkbox2(
                                                                            alasan: alasanName,
                                                                            valueCheck: alasanID,
                                                                            frequency: frequency[index],
                                                                            indexx: indexx[index],
                                                                            item: item[index],
                                                                            itemNo: itemNo[index],
                                                                            lokasi: lokasi[index],
                                                                            merek: merek[index],
                                                                            outlet: outlet[index],
                                                                            pic: pic[index],
                                                                            onCancelResult: (cancelResult) {},
                                                                            onResult: (finalResult) {},
                                                                            jobStatus: jobStatus[index],
                                                                            job: job[index],
                                                                            userCreated: userCreated[index],
                                                                            idUser: widget.idUser,
                                                                            departmentUser: widget.departmentUser,
                                                                            namaUser: widget.namaUser,                                                                  
                                                                          );
                                                                        }
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 10.0,
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    scan(outlet[index], lokasi[index], qrCode[index], merek[index], item[index], itemNo[index], pic[index], frequency[index], indexx[index], index, job[index], userCreated[index], 'save');
                                                                  },
                                                                  child: Container(
                                                                    width: MediaQuery.of(context).size.width * 0.1,
                                                                    height: MediaQuery.of(context).size.width * 0.1,
                                                                    padding: EdgeInsets.only(right: 10.0, bottom: 10.0, left: 10.0),
                                                                    alignment: Alignment.centerRight,
                                                                    decoration: new BoxDecoration(
                                                                      color: Colors.transparent,
                                                                      shape: BoxShape.rectangle,
                                                                      image: DecorationImage(
                                                                        image: AssetImage('assets/images/scanner.png'),
                                                                        fit: BoxFit.fitWidth
                                                                      )
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : Container()
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
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    verticalDirection: VerticalDirection.down,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        color: Colors.white,
                                        child: Container(
                                          // decoration: BoxDecoration(
                                          //   color: Colors.white,
                                          //   borderRadius: BorderRadius.circular(30.0),
                                          //   border: Border.all(
                                          //     width: 1.0,
                                          //     color: Colors.black12
                                          //   )
                                          // ),
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
                                                    Flexible(
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: <Widget>[
                                                            Flexible(
                                                              child: Text(
                                                                'FREQUENCY',
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
                                                    ),
                                                    Flexible(
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: <Widget>[
                                                            Flexible(
                                                              child: Text(
                                                                'DUE DATE',
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
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: <Widget>[
                                                            Flexible(
                                                              child: Text(
                                                                frequency[index],
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
                                                    ),
                                                    Flexible(
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: <Widget>[
                                                            Flexible(
                                                              child: Text(
                                                                dueDate[index].toDate().toString().substring(8, 10) + '/' + dueDate[index].toDate().toString().substring(5, 7) + '/' + dueDate[index].toDate().toString().substring(0, 4),
                                                                style: TextStyle(
                                                                  fontSize: 14.0,
                                                                  fontWeight: FontWeight.w500,
                                                                  color: dueDate[index].toDate().isBefore(DateTime.now()) ? Colors.redAccent : Colors.black54,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
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
                                                                'Detail',
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
                                                          showModalBottomSheet(
                                                            context: context,
                                                            builder: (builder) {
                                                              return DialogBottomDetail(
                                                                job: job[index],
                                                                jobStatus: jobStatus[index],
                                                            departmentUser: widget.departmentUser,
                                                            idUser: widget.idUser,
                                                            namaUser: widget.namaUser,
                                                              );
                                                            }
                                                          ).then((value) {
                                                            print('berhasil');
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                    DateTime.now().isAfter(dueDate[index].toDate())
                                                      ? Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: <Widget>[
                                                            ButtonTheme(
                                                              minWidth: MediaQuery.of(context).size.width * 0.20,
                                                              height: 30.0,
                                                              child: OutlineButton(
                                                                child: Row(
                                                                  children: <Widget>[
                                                                    Container(
                                                                      width: MediaQuery.of(context).size.width * 0.10,
                                                                      alignment: Alignment.centerLeft,
                                                                      child: Text(
                                                                        'Skip',
                                                                        style: TextStyle(
                                                                          fontSize: 13.0,
                                                                          color: AbubaPallate.menuBluebird,
                                                                          fontWeight: FontWeight.bold
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      width: MediaQuery.of(context).size.width * 0.10,
                                                                      alignment: Alignment.centerRight,
                                                                      child: Icon(Icons.close, color: AbubaPallate.menuBluebird, size: 18.0),
                                                                    )
                                                                  ],
                                                                ),
                                                                borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 2.0),
                                                                highlightedBorderColor: AbubaPallate.menuBluebird,
                                                                splashColor: Colors.white,
                                                                onPressed: () {
                                                                  showDialog(
                                                                    barrierDismissible: false,
                                                                    context: context,
                                                                    builder: (context) {
                                                                      return Checkbox2(
                                                                        alasan: alasanName,
                                                                        valueCheck: alasanID,
                                                                        frequency: frequency[index],
                                                                        indexx: indexx[index],
                                                                        item: item[index],
                                                                        itemNo: itemNo[index],
                                                                        lokasi: lokasi[index],
                                                                        merek: merek[index],
                                                                        outlet: outlet[index],
                                                                        pic: pic[index],
                                                                        onCancelResult: (cancelResult) {},
                                                                        onResult: (finalResult) {},
                                                                        jobStatus: jobStatus[index],
                                                                        job: job[index],
                                                                        userCreated: userCreated[index],
                                                                        idUser: widget.idUser,
                                                                        departmentUser: widget.departmentUser,
                                                                        namaUser: widget.namaUser,                                                                  
                                                                      );
                                                                    }
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10.0,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                scan(outlet[index], lokasi[index], qrCode[index], merek[index], item[index], itemNo[index], pic[index], frequency[index], indexx[index], index, job[index], userCreated[index], 'save');
                                                              },
                                                              child: Container(
                                                                width: MediaQuery.of(context).size.width * 0.1,
                                                                height: MediaQuery.of(context).size.width * 0.1,
                                                                padding: EdgeInsets.only(right: 10.0, bottom: 10.0, left: 10.0),
                                                                alignment: Alignment.centerRight,
                                                                decoration: new BoxDecoration(
                                                                  color: Colors.transparent,
                                                                  shape: BoxShape.rectangle,
                                                                  image: DecorationImage(
                                                                    image: AssetImage('assets/images/scanner.png'),
                                                                    fit: BoxFit.fitWidth
                                                                  )
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : Container()
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
                                }
                              } else {
                                return Container();
                              }
                            } else {
                              return Container();
                            }
                          } else {
                            return Container();
                          }
                        } else {
                          return Container();
                        }
                      },
                    ),
                    // batas skipped
                    ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: indexxSkip.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (picIDSkip[index] == widget.idUser) {
                          if (statusSkip[index] == 'RESCHEDULE') {
                            if (isFilter) {
                                if (filterFreq != '' && filterArea != '' && filterLokasi != '') {
                                  if (frequency[index] == filterFreq && outlet[index] == filterArea && lokasi[index] == filterLokasi) {
                                    // filter frequency area lokasi
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
                                                    '${outletSkip[index]} - ${lokasiSkip[index]}',
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
                                                    '${merekSkip[index]} - ${itemSkip[index]} - # ${itemNoSkip[index]}',
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
                                              Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'FREQUENCY',
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
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'DUE DATE',
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
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          frequencySkip[index],
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
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          dueDateSkip[index].toDate().toString().substring(8, 10) + '/' + dueDateSkip[index].toDate().toString().substring(5, 7) + '/' + dueDateSkip[index].toDate().toString().substring(0, 4),
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
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
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
                                                          'Detail',
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
                                                    showModalBottomSheet(
                                                      context: context,
                                                      builder: (builder) {
                                                        return DialogBottomDetail(
                                                          job: jobSkip[index],
                                                          jobStatus: jobStatusSkip[index],
                                                            departmentUser: widget.departmentUser,
                                                            idUser: widget.idUser,
                                                            namaUser: widget.namaUser,
                                                        );
                                                      }
                                                    ).then((value) {
                                                      print('berhasil');
                                                    });
                                                  },
                                                ),
                                              ),
                                              dueDateSkip[index].toDate().toString().substring(8, 10) + '/' + dueDateSkip[index].toDate().toString().substring(5, 7) + '/' + dueDateSkip[index].toDate().toString().substring(0, 4) == DateTime.now().toString().substring(8, 10) + '/' + DateTime.now().toString().substring(5, 7) + '/' + DateTime.now().toString().substring(0, 4) || DateTime.now().isAfter(dueDateSkip[index].toDate())
                                                ? GestureDetector(
                                                    onTap: () {
                                                      scan(outlet[index], lokasi[index], qrCode[index], merek[index], item[index], itemNo[index], pic[index], frequency[index], indexx[index], index, job[index], userCreated[index], 'skip');
                                                    },
                                                    child: Container(
                                                      width: MediaQuery.of(context).size.width * 0.1,
                                                      height: MediaQuery.of(context).size.width * 0.1,
                                                      padding: EdgeInsets.only(right: 10.0, bottom: 10.0, left: 10.0),
                                                      alignment: Alignment.centerRight,
                                                      decoration: new BoxDecoration(
                                                        color: Colors.transparent,
                                                        shape: BoxShape.rectangle,
                                                        image: DecorationImage(
                                                          image: AssetImage('assets/images/scanner.png'),
                                                          fit: BoxFit.fitWidth
                                                        )
                                                      ),
                                                    ),
                                                  )
                                                : Container()
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
                                } else if (filterFreq != '' && filterArea != '' && filterLokasi == '') {
                                  if (frequency[index] == filterFreq && outlet[index] == filterArea) {
                                    // filter frequency area
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
                                                    '${outletSkip[index]} - ${lokasiSkip[index]}',
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
                                                    '${merekSkip[index]} - ${itemSkip[index]} - # ${itemNoSkip[index]}',
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
                                              Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'FREQUENCY',
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
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'DUE DATE',
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
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          frequencySkip[index],
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
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          dueDateSkip[index].toDate().toString().substring(8, 10) + '/' + dueDateSkip[index].toDate().toString().substring(5, 7) + '/' + dueDateSkip[index].toDate().toString().substring(0, 4),
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
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
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
                                                          'Detail',
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
                                                    showModalBottomSheet(
                                                      context: context,
                                                      builder: (builder) {
                                                        return DialogBottomDetail(
                                                          job: jobSkip[index],
                                                          jobStatus: jobStatusSkip[index],
                                                            departmentUser: widget.departmentUser,
                                                            idUser: widget.idUser,
                                                            namaUser: widget.namaUser,
                                                        );
                                                      }
                                                    ).then((value) {
                                                      print('berhasil');
                                                    });
                                                  },
                                                ),
                                              ),
                                              dueDateSkip[index].toDate().toString().substring(8, 10) + '/' + dueDateSkip[index].toDate().toString().substring(5, 7) + '/' + dueDateSkip[index].toDate().toString().substring(0, 4) == DateTime.now().toString().substring(8, 10) + '/' + DateTime.now().toString().substring(5, 7) + '/' + DateTime.now().toString().substring(0, 4) || DateTime.now().isAfter(dueDateSkip[index].toDate())
                                                ? GestureDetector(
                                                    onTap: () {
                                                      scan(outlet[index], lokasi[index], qrCode[index], merek[index], item[index], itemNo[index], pic[index], frequency[index], indexx[index], index, job[index], userCreated[index], 'skip');
                                                    },
                                                    child: Container(
                                                      width: MediaQuery.of(context).size.width * 0.1,
                                                      height: MediaQuery.of(context).size.width * 0.1,
                                                      padding: EdgeInsets.only(right: 10.0, bottom: 10.0, left: 10.0),
                                                      alignment: Alignment.centerRight,
                                                      decoration: new BoxDecoration(
                                                        color: Colors.transparent,
                                                        shape: BoxShape.rectangle,
                                                        image: DecorationImage(
                                                          image: AssetImage('assets/images/scanner.png'),
                                                          fit: BoxFit.fitWidth
                                                        )
                                                      ),
                                                    ),
                                                  )
                                                : Container()
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
                                } else if (filterFreq != '' && filterArea == '' && filterLokasi != '') {
                                  if (frequency[index] == filterFreq && lokasi[index] == filterLokasi) {
                                    // filter frequency lokasi
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
                                                    '${outletSkip[index]} - ${lokasiSkip[index]}',
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
                                                    '${merekSkip[index]} - ${itemSkip[index]} - # ${itemNoSkip[index]}',
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
                                              Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'FREQUENCY',
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
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'DUE DATE',
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
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          frequencySkip[index],
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
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          dueDateSkip[index].toDate().toString().substring(8, 10) + '/' + dueDateSkip[index].toDate().toString().substring(5, 7) + '/' + dueDateSkip[index].toDate().toString().substring(0, 4),
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
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
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
                                                          'Detail',
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
                                                    showModalBottomSheet(
                                                      context: context,
                                                      builder: (builder) {
                                                        return DialogBottomDetail(
                                                          job: jobSkip[index],
                                                          jobStatus: jobStatusSkip[index],
                                                            departmentUser: widget.departmentUser,
                                                            idUser: widget.idUser,
                                                            namaUser: widget.namaUser,
                                                        );
                                                      }
                                                    ).then((value) {
                                                      print('berhasil');
                                                    });
                                                  },
                                                ),
                                              ),
                                              dueDateSkip[index].toDate().toString().substring(8, 10) + '/' + dueDateSkip[index].toDate().toString().substring(5, 7) + '/' + dueDateSkip[index].toDate().toString().substring(0, 4) == DateTime.now().toString().substring(8, 10) + '/' + DateTime.now().toString().substring(5, 7) + '/' + DateTime.now().toString().substring(0, 4) || DateTime.now().isAfter(dueDateSkip[index].toDate())
                                                ? GestureDetector(
                                                    onTap: () {
                                                      scan(outlet[index], lokasi[index], qrCode[index], merek[index], item[index], itemNo[index], pic[index], frequency[index], indexx[index], index, job[index], userCreated[index], 'skip');
                                                    },
                                                    child: Container(
                                                      width: MediaQuery.of(context).size.width * 0.1,
                                                      height: MediaQuery.of(context).size.width * 0.1,
                                                      padding: EdgeInsets.only(right: 10.0, bottom: 10.0, left: 10.0),
                                                      alignment: Alignment.centerRight,
                                                      decoration: new BoxDecoration(
                                                        color: Colors.transparent,
                                                        shape: BoxShape.rectangle,
                                                        image: DecorationImage(
                                                          image: AssetImage('assets/images/scanner.png'),
                                                          fit: BoxFit.fitWidth
                                                        )
                                                      ),
                                                    ),
                                                  )
                                                : Container()
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
                                } else if (filterFreq != '' && filterArea == '' && filterLokasi == '') {
                                  if (frequency[index] == filterFreq) {
                                    // filter frequency 
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
                                                    '${outletSkip[index]} - ${lokasiSkip[index]}',
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
                                                    '${merekSkip[index]} - ${itemSkip[index]} - # ${itemNoSkip[index]}',
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
                                              Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'FREQUENCY',
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
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'DUE DATE',
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
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          frequencySkip[index],
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
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          dueDateSkip[index].toDate().toString().substring(8, 10) + '/' + dueDateSkip[index].toDate().toString().substring(5, 7) + '/' + dueDateSkip[index].toDate().toString().substring(0, 4),
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
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
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
                                                          'Detail',
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
                                                    showModalBottomSheet(
                                                      context: context,
                                                      builder: (builder) {
                                                        return DialogBottomDetail(
                                                          job: jobSkip[index],
                                                          jobStatus: jobStatusSkip[index],
                                                            departmentUser: widget.departmentUser,
                                                            idUser: widget.idUser,
                                                            namaUser: widget.namaUser,
                                                        );
                                                      }
                                                    ).then((value) {
                                                      print('berhasil');
                                                    });
                                                  },
                                                ),
                                              ),
                                              dueDateSkip[index].toDate().toString().substring(8, 10) + '/' + dueDateSkip[index].toDate().toString().substring(5, 7) + '/' + dueDateSkip[index].toDate().toString().substring(0, 4) == DateTime.now().toString().substring(8, 10) + '/' + DateTime.now().toString().substring(5, 7) + '/' + DateTime.now().toString().substring(0, 4) || DateTime.now().isAfter(dueDateSkip[index].toDate())
                                                ? GestureDetector(
                                                    onTap: () {
                                                      scan(outlet[index], lokasi[index], qrCode[index], merek[index], item[index], itemNo[index], pic[index], frequency[index], indexx[index], index, job[index], userCreated[index], 'skip');
                                                    },
                                                    child: Container(
                                                      width: MediaQuery.of(context).size.width * 0.1,
                                                      height: MediaQuery.of(context).size.width * 0.1,
                                                      padding: EdgeInsets.only(right: 10.0, bottom: 10.0, left: 10.0),
                                                      alignment: Alignment.centerRight,
                                                      decoration: new BoxDecoration(
                                                        color: Colors.transparent,
                                                        shape: BoxShape.rectangle,
                                                        image: DecorationImage(
                                                          image: AssetImage('assets/images/scanner.png'),
                                                          fit: BoxFit.fitWidth
                                                        )
                                                      ),
                                                    ),
                                                  )
                                                : Container()
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
                                } else if (filterFreq == '' && filterArea != '' && filterLokasi != '') {
                                  if (outlet[index] == filterArea && lokasi[index] == filterLokasi) {
                                    // filter area lokasi
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
                                                    '${outletSkip[index]} - ${lokasiSkip[index]}',
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
                                                    '${merekSkip[index]} - ${itemSkip[index]} - # ${itemNoSkip[index]}',
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
                                              Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'FREQUENCY',
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
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'DUE DATE',
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
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          frequencySkip[index],
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
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          dueDateSkip[index].toDate().toString().substring(8, 10) + '/' + dueDateSkip[index].toDate().toString().substring(5, 7) + '/' + dueDateSkip[index].toDate().toString().substring(0, 4),
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
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
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
                                                          'Detail',
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
                                                    showModalBottomSheet(
                                                      context: context,
                                                      builder: (builder) {
                                                        return DialogBottomDetail(
                                                          job: jobSkip[index],
                                                          jobStatus: jobStatusSkip[index],
                                                            departmentUser: widget.departmentUser,
                                                            idUser: widget.idUser,
                                                            namaUser: widget.namaUser,
                                                        );
                                                      }
                                                    ).then((value) {
                                                      print('berhasil');
                                                    });
                                                  },
                                                ),
                                              ),
                                              dueDateSkip[index].toDate().toString().substring(8, 10) + '/' + dueDateSkip[index].toDate().toString().substring(5, 7) + '/' + dueDateSkip[index].toDate().toString().substring(0, 4) == DateTime.now().toString().substring(8, 10) + '/' + DateTime.now().toString().substring(5, 7) + '/' + DateTime.now().toString().substring(0, 4) || DateTime.now().isAfter(dueDateSkip[index].toDate())
                                                ? GestureDetector(
                                                    onTap: () {
                                                      scan(outlet[index], lokasi[index], qrCode[index], merek[index], item[index], itemNo[index], pic[index], frequency[index], indexx[index], index, job[index], userCreated[index], 'skip');
                                                    },
                                                    child: Container(
                                                      width: MediaQuery.of(context).size.width * 0.1,
                                                      height: MediaQuery.of(context).size.width * 0.1,
                                                      padding: EdgeInsets.only(right: 10.0, bottom: 10.0, left: 10.0),
                                                      alignment: Alignment.centerRight,
                                                      decoration: new BoxDecoration(
                                                        color: Colors.transparent,
                                                        shape: BoxShape.rectangle,
                                                        image: DecorationImage(
                                                          image: AssetImage('assets/images/scanner.png'),
                                                          fit: BoxFit.fitWidth
                                                        )
                                                      ),
                                                    ),
                                                  )
                                                : Container()
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
                                } else if (filterFreq == '' && filterArea != '' && filterLokasi == '') {
                                  if (outlet[index] == filterArea) {
                                    // filter area
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
                                                    '${outletSkip[index]} - ${lokasiSkip[index]}',
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
                                                    '${merekSkip[index]} - ${itemSkip[index]} - # ${itemNoSkip[index]}',
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
                                              Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'FREQUENCY',
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
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'DUE DATE',
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
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          frequencySkip[index],
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
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          dueDateSkip[index].toDate().toString().substring(8, 10) + '/' + dueDateSkip[index].toDate().toString().substring(5, 7) + '/' + dueDateSkip[index].toDate().toString().substring(0, 4),
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
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
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
                                                          'Detail',
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
                                                    showModalBottomSheet(
                                                      context: context,
                                                      builder: (builder) {
                                                        return DialogBottomDetail(
                                                          job: jobSkip[index],
                                                          jobStatus: jobStatusSkip[index],
                                                            departmentUser: widget.departmentUser,
                                                            idUser: widget.idUser,
                                                            namaUser: widget.namaUser,
                                                        );
                                                      }
                                                    ).then((value) {
                                                      print('berhasil');
                                                    });
                                                  },
                                                ),
                                              ),
                                              dueDateSkip[index].toDate().toString().substring(8, 10) + '/' + dueDateSkip[index].toDate().toString().substring(5, 7) + '/' + dueDateSkip[index].toDate().toString().substring(0, 4) == DateTime.now().toString().substring(8, 10) + '/' + DateTime.now().toString().substring(5, 7) + '/' + DateTime.now().toString().substring(0, 4) || DateTime.now().isAfter(dueDateSkip[index].toDate())
                                                ? GestureDetector(
                                                    onTap: () {
                                                      scan(outlet[index], lokasi[index], qrCode[index], merek[index], item[index], itemNo[index], pic[index], frequency[index], indexx[index], index, job[index], userCreated[index], 'skip');
                                                    },
                                                    child: Container(
                                                      width: MediaQuery.of(context).size.width * 0.1,
                                                      height: MediaQuery.of(context).size.width * 0.1,
                                                      padding: EdgeInsets.only(right: 10.0, bottom: 10.0, left: 10.0),
                                                      alignment: Alignment.centerRight,
                                                      decoration: new BoxDecoration(
                                                        color: Colors.transparent,
                                                        shape: BoxShape.rectangle,
                                                        image: DecorationImage(
                                                          image: AssetImage('assets/images/scanner.png'),
                                                          fit: BoxFit.fitWidth
                                                        )
                                                      ),
                                                    ),
                                                  )
                                                : Container()
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
                                } else if (filterFreq == '' && filterArea == '' && filterLokasi != '') {
                                  if (lokasi[index] == filterLokasi) {
                                    // filter lokasi
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
                                                    '${outletSkip[index]} - ${lokasiSkip[index]}',
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
                                                    '${merekSkip[index]} - ${itemSkip[index]} - # ${itemNoSkip[index]}',
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
                                              Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'FREQUENCY',
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
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'DUE DATE',
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
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          frequencySkip[index],
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
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          dueDateSkip[index].toDate().toString().substring(8, 10) + '/' + dueDateSkip[index].toDate().toString().substring(5, 7) + '/' + dueDateSkip[index].toDate().toString().substring(0, 4),
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
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
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
                                                          'Detail',
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
                                                    showModalBottomSheet(
                                                      context: context,
                                                      builder: (builder) {
                                                        return DialogBottomDetail(
                                                          job: jobSkip[index],
                                                          jobStatus: jobStatusSkip[index],
                                                            departmentUser: widget.departmentUser,
                                                            idUser: widget.idUser,
                                                            namaUser: widget.namaUser,
                                                        );
                                                      }
                                                    ).then((value) {
                                                      print('berhasil');
                                                    });
                                                  },
                                                ),
                                              ),
                                              dueDateSkip[index].toDate().toString().substring(8, 10) + '/' + dueDateSkip[index].toDate().toString().substring(5, 7) + '/' + dueDateSkip[index].toDate().toString().substring(0, 4) == DateTime.now().toString().substring(8, 10) + '/' + DateTime.now().toString().substring(5, 7) + '/' + DateTime.now().toString().substring(0, 4) || DateTime.now().isAfter(dueDateSkip[index].toDate())
                                                ? GestureDetector(
                                                    onTap: () {
                                                      scan(outlet[index], lokasi[index], qrCode[index], merek[index], item[index], itemNo[index], pic[index], frequency[index], indexx[index], index, job[index], userCreated[index], 'skip');
                                                    },
                                                    child: Container(
                                                      width: MediaQuery.of(context).size.width * 0.1,
                                                      height: MediaQuery.of(context).size.width * 0.1,
                                                      padding: EdgeInsets.only(right: 10.0, bottom: 10.0, left: 10.0),
                                                      alignment: Alignment.centerRight,
                                                      decoration: new BoxDecoration(
                                                        color: Colors.transparent,
                                                        shape: BoxShape.rectangle,
                                                        image: DecorationImage(
                                                          image: AssetImage('assets/images/scanner.png'),
                                                          fit: BoxFit.fitWidth
                                                        )
                                                      ),
                                                    ),
                                                  )
                                                : Container()
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
                                                    '${outletSkip[index]} - ${lokasiSkip[index]}',
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
                                                    '${merekSkip[index]} - ${itemSkip[index]} - # ${itemNoSkip[index]}',
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
                                              Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'FREQUENCY',
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
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'DUE DATE',
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
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          frequencySkip[index],
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
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          dueDateSkip[index].toDate().toString().substring(8, 10) + '/' + dueDateSkip[index].toDate().toString().substring(5, 7) + '/' + dueDateSkip[index].toDate().toString().substring(0, 4),
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
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
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
                                                          'Detail',
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
                                                    showModalBottomSheet(
                                                      context: context,
                                                      builder: (builder) {
                                                        return DialogBottomDetail(
                                                          job: jobSkip[index],
                                                          jobStatus: jobStatusSkip[index],
                                                            departmentUser: widget.departmentUser,
                                                            idUser: widget.idUser,
                                                            namaUser: widget.namaUser,
                                                        );
                                                      }
                                                    ).then((value) {
                                                      print('berhasil');
                                                    });
                                                  },
                                                ),
                                              ),
                                              dueDateSkip[index].toDate().toString().substring(8, 10) + '/' + dueDateSkip[index].toDate().toString().substring(5, 7) + '/' + dueDateSkip[index].toDate().toString().substring(0, 4) == DateTime.now().toString().substring(8, 10) + '/' + DateTime.now().toString().substring(5, 7) + '/' + DateTime.now().toString().substring(0, 4) || DateTime.now().isAfter(dueDateSkip[index].toDate())
                                                ? GestureDetector(
                                                    onTap: () {
                                                      scan(outlet[index], lokasi[index], qrCode[index], merek[index], item[index], itemNo[index], pic[index], frequency[index], indexx[index], index, job[index], userCreated[index], 'skip');
                                                    },
                                                    child: Container(
                                                      width: MediaQuery.of(context).size.width * 0.1,
                                                      height: MediaQuery.of(context).size.width * 0.1,
                                                      padding: EdgeInsets.only(right: 10.0, bottom: 10.0, left: 10.0),
                                                      alignment: Alignment.centerRight,
                                                      decoration: new BoxDecoration(
                                                        color: Colors.transparent,
                                                        shape: BoxShape.rectangle,
                                                        image: DecorationImage(
                                                          image: AssetImage('assets/images/scanner.png'),
                                                          fit: BoxFit.fitWidth
                                                        )
                                                      ),
                                                    ),
                                                  )
                                                : Container()
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
                              }
                          } else {
                            return Container();
                          }
                        } else {
                          return Container();
                        }
                      },
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

class DialogBottomDetail extends StatefulWidget {
  List<dynamic> job;
  List<dynamic> jobStatus;
  final int idUser;
  final String departmentUser;
  final String namaUser;

  DialogBottomDetail({this.job, this.jobStatus, this.departmentUser, this.idUser, this.namaUser});
  @override
  _DialogBottomDetailState createState() => _DialogBottomDetailState();
}

class _DialogBottomDetailState extends State<DialogBottomDetail> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Text(
                    'Detail Maintenance',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.3 - 40.0,
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
                      child: Scrollbar(
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
                                          fontSize: 14.0,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500
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
                                          fontSize: 14.0,
                                          color: AbubaPallate.menuBluebird,
                                          fontWeight: FontWeight.w500
                                        ),
                                        textAlign: TextAlign.end,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                        ),
                      )
                    ),
                  ],
                ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            width: MediaQuery.of(context).size.width * 0.4,
            child: ButtonTheme(
              minWidth: MediaQuery.of(context).size.width * 0.3,
              height: 35.0,
              child: OutlineButton(
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Working Instruction',
                          style: TextStyle(
                            fontSize: 13.0,
                            color: AbubaPallate.menuBluebird,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                    ],
                  )
                ),
                borderSide: BorderSide(color: Colors.grey[350], width: 2.0),
                highlightedBorderColor: Colors.grey[350],
                splashColor: Colors.white,
                onPressed: () {
                  Navigator.pushReplacement(context, 
                    MaterialPageRoute(
                      builder: (_) => FormListWorking(departmentUser: widget.departmentUser, namaUser: widget.namaUser, idUser: widget.idUser, type: 'maintenanceIT')
                    )
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Checkbox extends StatefulWidget {
  Checkbox({this.onSelectedAlasanListChanged,this.jobdesc,this.outlet,this.lokasi,this.item,this.itemNo,this.merek,this.frequency,this.indexx,this.pic, this.alasan, this.valueCheck, this.onCancelResult, this.onResult, this.userCreated, this.type, this.departmentUser, this.idUser, this.namaUser});

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
  final int idUser;
  final String departmentUser;
  final String namaUser;

  @override
  _CheckboxState createState() => new _CheckboxState();
}

class _CheckboxState extends State<Checkbox> with TickerProviderStateMixin {
  List<String> _tempSelectedAlasan = [];
  List<bool> _tempSelectedAlasanBool = [];
  List<String> _tempSelectedValueAlasan = [];
  AnimationController animationController2;

  List<dynamic> job2 = [];
  var timejob2;
  var timejob3;
  bool showAlasan = false;
  int value = 0;
  bool showAlert = false;
  bool isProcess = false;
  bool isProcess2 = false;
  
  Timestamp dueDate;
  int lokasiID;
  var maxidMaintenance;
  var indexMaintenance;
  int outletID;
  int picID;
  int userCreatedID;

  @override
  void initState() {
    _tempSelectedAlasan = [];
    _tempSelectedValueAlasan = [];
    _tempSelectedAlasanBool = [];
    super.initState();

    setState(() {
      job2 = widget.jobdesc;
    });

    for (int x = 0; x < widget.jobdesc.length; x++) {
      Firestore.instance.collection('maintenance_IT').document(widget.indexx).snapshots().listen((data) {
        setState(() {
          timejob2 = List<dynamic>.from(data.data['jobdesc_done']);
          timejob3 = List<dynamic>.from(data.data['jobdesc_done']);

          dueDate = data.data['dueDate'];
          lokasiID = data.data['lokasi'];
          outletID = data.data['outlet'];
          picID = data.data['pic'];
          userCreatedID = data.data['userCreated'];
        });
      });
      _tempSelectedAlasanBool.add(false);
    }

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
                                      if (value == 0 || value == null) {
                                        showAlert = true;
                                      } else {
                                        showAlert = false;
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return AfterSkipDialog2(
                                              alasanValue: value,
                                              departmentUser: widget.departmentUser,
                                              idUser: widget.idUser,
                                              indexx: widget.indexx,
                                              job2: job2,
                                              namaUser: widget.namaUser,
                                              timejob2: timejob2,
                                              userCreated: widget.userCreated,
                                            );
                                          }
                                        );
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
                                              fontSize: 12.0, color: Colors.black87
                                            ),
                                          ),
                                        ),
                                        value: _tempSelectedAlasanBool[index],
                                        onChanged: (value) {
                                          setState(() {
                                            _tempSelectedAlasanBool[index] = !_tempSelectedAlasanBool[index];
                                          });
                                          if (_tempSelectedAlasan.contains(job2[index]) == false) {
                                            setState(() {
                                              _tempSelectedAlasan.add(job2[index]);
                                              _tempSelectedValueAlasan.add(job2[index]);
                                              timejob2.removeAt(index);
                                              timejob2.insert(index, DateTime.now());
                                            });
                                          } else {
                                            setState(() {
                                              _tempSelectedAlasan.removeWhere((city) => city == job2[index]);
                                              _tempSelectedValueAlasan.removeWhere((city) => city == job2[index]);
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    isProcess
                                      ? SizedBox(
                                          height: 15.0,
                                          width: 15.0,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 1.5,
                                            value: null, valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                          ),
                                        )
                                      : Container(),
                                    isProcess
                                      ? SizedBox(
                                          width: 10.0,
                                        )
                                      : Container(),
                                    Text(
                                      'SAVE',
                                      style:
                                      TextStyle(fontSize: 13.0, color: Colors.white),
                                    ),
                                  ],
                                ),
                              color: AbubaPallate.greenabuba,
                              onPressed: () async {
                                setState(() {
                                  isProcess = true;
                                });

                                if (timejob2.contains(null)) {
                                  if (widget.type == 'skip') {
                                    setState(() {
                                      isProcess = false;
                                    });
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
                                                          setState(() {
                                                            isProcess = false;
                                                          });
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
                                  if (widget.type == 'skip') {
                                    Navigator.pop(context);
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return AfterScanDialog(
                                          indexx: widget.indexx,
                                          idUser: widget.idUser,
                                          departmentUser: widget.departmentUser,
                                          namaUser: widget.namaUser,
                                          dueDate: dueDate,
                                          timejob3: timejob3,
                                          frequency: widget.frequency,
                                          item: widget.item,
                                          itemNo: widget.itemNo,
                                          jobdesc: widget.jobdesc,
                                          lokasiID: lokasiID,
                                          merek: widget.merek,
                                          outletID: outletID,
                                          picID: picID,
                                          userCreatedID: userCreatedID,
                                        );
                                      }
                                    );
                                  } else {
                                    Navigator.pop(context);
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return AfterScanDialog2(
                                          indexx: widget.indexx,
                                          idUser: widget.idUser,
                                          departmentUser: widget.departmentUser,
                                          namaUser: widget.namaUser,
                                          dueDate: dueDate,
                                          tempSelectedAlasanBool: _tempSelectedAlasanBool,
                                          timejob2: timejob2,
                                          frequency: widget.frequency,
                                          item: widget.item,
                                          itemNo: widget.itemNo,
                                          jobdesc: widget.jobdesc,
                                          lokasiID: lokasiID,
                                          merek: widget.merek,
                                          outletID: outletID,
                                          picID: picID,
                                          userCreatedID: userCreatedID,
                                        );
                                      }
                                    );
                                  }
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

class AfterSkipDialog2 extends StatefulWidget {
  final List<dynamic> timejob2;
  final List<dynamic> job2;
  final int alasanValue;
  final int userCreated;
  final int idUser;
  final String departmentUser;
  final String namaUser;
  var indexx;

  AfterSkipDialog2({this.timejob2, this.namaUser, this.departmentUser, this.idUser, this.userCreated, this.alasanValue, this.indexx, this.job2});
  @override
  _AfterSkipDialog2State createState() => _AfterSkipDialog2State();
}

class _AfterSkipDialog2State extends State<AfterSkipDialog2> {
  bool isProses = false;
  TextEditingController controllerSkip2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: TextFormField(
        maxLines: 2,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          labelText: 'Skip Note (optional)',
          labelStyle: TextStyle(fontSize: 12.0),
        ),
        controller: controllerSkip2,
        maxLength: 250,
        textCapitalization: TextCapitalization.sentences,
        style: TextStyle(
          color: Colors.black,
          fontSize: 13.0
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Colors.black38
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              isProses
                ? SizedBox(
                    height: 15.0,
                    width: 15.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 1.5,
                      value: null, valueColor: AlwaysStoppedAnimation<Color>(AbubaPallate.greenabuba),
                    ),
                  )
                : Container(),
              isProses
                ? SizedBox(
                    width: 10.0,
                  )
                : Container(),
              Text(
                'Save',
              ),
            ],
          ),
          onPressed: () {
            setState(() {
              if (isProses == false) {
                isProses = true;

                List<String> jobStatusSkipSave = [];
                List<dynamic> jobSkipHistory = [];
                for (int e = 0; e < widget.timejob2.length; e++) {
                  if (widget.timejob2[e] == null) {
                    jobStatusSkipSave.add('SKIP');
                    jobSkipHistory.add(widget.job2[e]);
                  } else {
                    jobStatusSkipSave.add('DONE');
                  }
                }
                
                DocumentReference docReference = Firestore.instance.collection('maintenance_IT').document(widget.indexx);

                docReference.updateData({
                  'alasan': widget.alasanValue,
                  'jobdesc_skip': jobSkipHistory,
                  'status': 'SKIP',
                  'skippedDate': DateTime.now(),
                  'jobdesc_done': widget.timejob2,
                  'jobdesc_status': jobStatusSkipSave,
                  'rescheduleBy': widget.userCreated,
                  'noteSkip': controllerSkip2.text == '' ? null : controllerSkip2.text
                }).then((doc) {
                  print('success');
                  Navigator.pop(context);
                  Navigator.pushReplacement(context,
                    MaterialPageRoute(
                      builder: (_) => FormMaintenanceTest(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)
                    )
                  );
                }).catchError((error) {
                  print(error);
                });
              } else {}
            });
          },
        ),
      ],
    );
  }
}

class AfterScanDialog2 extends StatefulWidget {
  final List<dynamic> tempSelectedAlasanBool;
  final List<dynamic> timejob2;
  final String frequency;
  final Timestamp dueDate;
  final String item;
  final String itemNo;
  final List<dynamic> jobdesc;
  final int lokasiID;
  final String merek;
  final int outletID;
  final int picID;
  final int userCreatedID;
  final int idUser;
  final String departmentUser;
  final String namaUser;
  var indexx;

  AfterScanDialog2({this.namaUser, this.departmentUser, this.idUser, this.dueDate, this.frequency, this.item, this.itemNo, this.jobdesc, this.lokasiID, this.merek, this.outletID, this.picID, this.tempSelectedAlasanBool, this.userCreatedID, this.indexx, this.timejob2});

  @override
  AfterScanDialog2State createState() => AfterScanDialog2State();
}

class AfterScanDialog2State extends State<AfterScanDialog2> {
  bool isProcess = false;
  TextEditingController controllerSave = TextEditingController();
  var maxidMaintenance;
  var indexMaintenance;

  @override
  void initState() {
    Firestore.instance.collection('dumper_maintenance').snapshots().listen((data) {
      setState(() {
        maxidMaintenance = data.documents[0].data['maxid_mtcIT'] + 1;
        indexMaintenance = data.documents[0].documentID;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: TextFormField(
        maxLines: 2,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          labelText: 'Note (optional)',
          labelStyle: TextStyle(fontSize: 12.0),
        ),
        controller: controllerSave,
        maxLength: 250,
        textCapitalization: TextCapitalization.sentences,
        style: TextStyle(
          color: Colors.black,
          fontSize: 13.0
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Colors.black38
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              isProcess
                ? SizedBox(
                    height: 15.0,
                    width: 15.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 1.5,
                      value: null, valueColor: AlwaysStoppedAnimation<Color>(AbubaPallate.greenabuba),
                    ),
                  )
                : Container(),
              isProcess
                ? SizedBox(
                    width: 10.0,
                  )
                : Container(),
              Text(
                'Save',
              ),
            ],
          ),
          onPressed: () {
            setState(() async {
              if (isProcess == false) {
                isProcess = true;

                DocumentReference docReference = Firestore.instance.collection('maintenance_IT').document(widget.indexx);

                List<String> jobdescStatus = [];
                List<dynamic> jobdescDoneNew = [];
                List<dynamic> jobdescStatusNew = [];
                for (int y = 0; y < widget.tempSelectedAlasanBool.length; y++) {
                  setState(() {
                    jobdescDoneNew.add(null);
                    jobdescStatusNew.add('OPEN');
                    if (widget.tempSelectedAlasanBool[y]) {
                      jobdescStatus.add('DONE');
                    } else {
                      jobdescStatus.add('SKIP');
                    }
                  });
                }

                DocumentReference docReference2 = Firestore.instance.collection('maintenance_IT').document();
                List<String> arrFrequency = widget.frequency.split(' ');
                print('Due Date : ' + widget.dueDate.toDate().toString());

                if (arrFrequency.length == 2) {
                  if (arrFrequency[1].toString().toLowerCase() == 'month') {
                    var newDueDate = DateTime(widget.dueDate.toDate().year, widget.dueDate.toDate().month + int.tryParse(arrFrequency[0]), widget.dueDate.toDate().day, widget.dueDate.toDate().hour, widget.dueDate.toDate().minute, widget.dueDate.toDate().second, widget.dueDate.toDate().millisecond);
                    print('New Due Date : ' + newDueDate.toString());

                    docReference2.setData({
                      'alasan': null,
                      'dateCreated': DateTime.now(),
                      'dueDate': newDueDate,
                      'frequency': widget.frequency,
                      'item': widget.item,
                      'itemNo': widget.itemNo,
                      'jobdesc': widget.jobdesc,
                      'jobdesc_done': jobdescDoneNew,
                      'jobdesc_status': jobdescStatusNew,
                      'lokasi': widget.lokasiID,
                      'maintenanceNo': maxidMaintenance,
                      'merek': widget.merek,
                      'newDueDate': null,
                      'outlet': widget.outletID,
                      'pic': widget.picID,
                      'rescheduleBy': null,
                      'status': 'OPEN',
                      'userCreated': widget.userCreatedID
                    }).then((doc2) {
                      DocumentReference documentReference3 = Firestore.instance.collection('dumper_maintenance').document(indexMaintenance);

                      documentReference3.updateData({
                        'maxid_mtcIT':maxidMaintenance
                      }).then((doc2) {
                        print('success');
                      }).catchError((error2) {
                        print(error2);
                      });
                    }).catchError((error) {
                      print(error);
                    });
                  }
                } else {
                  if (widget.frequency.toString().toLowerCase() == 'monthly') {
                    var newDueDate = DateTime(widget.dueDate.toDate().year, widget.dueDate.toDate().month + 1, widget.dueDate.toDate().day, widget.dueDate.toDate().hour, widget.dueDate.toDate().minute, widget.dueDate.toDate().second, widget.dueDate.toDate().millisecond);
                    print('monthly');
                    print('New Due Date : ' + newDueDate.toString());

                    docReference2.setData({
                      'alasan': null,
                      'dateCreated': DateTime.now(),
                      'dueDate': newDueDate,
                      'frequency': widget.frequency,
                      'item': widget.item,
                      'itemNo': widget.itemNo,
                      'jobdesc': widget.jobdesc,
                      'jobdesc_done': jobdescDoneNew,
                      'jobdesc_status': jobdescStatusNew,
                      'lokasi': widget.lokasiID,
                      'maintenanceNo': maxidMaintenance,
                      'merek': widget.merek,
                      'newDueDate': null,
                      'outlet': widget.outletID,
                      'pic': widget.picID,
                      'rescheduleBy': null,
                      'status': 'OPEN',
                      'userCreated': widget.userCreatedID
                    }).then((doc2) {
                      DocumentReference documentReference3 = Firestore.instance.collection('dumper_maintenance').document(indexMaintenance);

                      documentReference3.updateData({
                        'maxid_mtcIT':maxidMaintenance
                      }).then((doc2) {
                        print('success');
                      }).catchError((error2) {
                        print(error2);
                      });
                    }).catchError((error) {
                      print(error);
                    });
                  } else if (widget.frequency.toString().toLowerCase() == 'yearly') {
                    var newDueDate = DateTime(widget.dueDate.toDate().year + 1, widget.dueDate.toDate().month, widget.dueDate.toDate().day, widget.dueDate.toDate().hour, widget.dueDate.toDate().minute, widget.dueDate.toDate().second, widget.dueDate.toDate().millisecond);
                    print('yearly');
                    print('New Due Date : ' + newDueDate.toString());

                    docReference2.setData({
                      'alasan': null,
                      'dateCreated': DateTime.now(),
                      'dueDate': newDueDate,
                      'frequency': widget.frequency,
                      'item': widget.item,
                      'itemNo': widget.itemNo,
                      'jobdesc': widget.jobdesc,
                      'jobdesc_done': jobdescDoneNew,
                      'jobdesc_status': jobdescStatusNew,
                      'lokasi': widget.lokasiID,
                      'maintenanceNo': maxidMaintenance,
                      'merek': widget.merek,
                      'newDueDate': null,
                      'outlet': widget.outletID,
                      'pic': widget.picID,
                      'rescheduleBy': null,
                      'status': 'OPEN',
                      'userCreated': widget.userCreatedID
                    }).then((doc2) {
                      DocumentReference documentReference3 = Firestore.instance.collection('dumper_maintenance').document(indexMaintenance);

                      documentReference3.updateData({
                        'maxid_mtcIT':maxidMaintenance
                      }).then((doc2) {
                        print('success');
                      }).catchError((error2) {
                        print(error2);
                      });
                    }).catchError((error) {
                      print(error);
                    });
                  } else if (widget.frequency.toString().toLowerCase() == 'weekly') {
                    var newDueDate = DateTime(widget.dueDate.toDate().year, widget.dueDate.toDate().month, widget.dueDate.toDate().day + 7, widget.dueDate.toDate().hour, widget.dueDate.toDate().minute, widget.dueDate.toDate().second, widget.dueDate.toDate().millisecond);
                    print('weekly');
                    print('New Due Date : ' + newDueDate.toString());

                    docReference2.setData({
                      'alasan': null,
                      'dateCreated': DateTime.now(),
                      'dueDate': newDueDate,
                      'frequency': widget.frequency,
                      'item': widget.item,
                      'itemNo': widget.itemNo,
                      'jobdesc': widget.jobdesc,
                      'jobdesc_done': jobdescDoneNew,
                      'jobdesc_status': jobdescStatusNew,
                      'lokasi': widget.lokasiID,
                      'maintenanceNo': maxidMaintenance,
                      'merek': widget.merek,
                      'newDueDate': null,
                      'outlet': widget.outletID,
                      'pic': widget.picID,
                      'rescheduleBy': null,
                      'status': 'OPEN',
                      'userCreated': widget.userCreatedID
                    }).then((doc2) {
                      DocumentReference documentReference3 = Firestore.instance.collection('dumper_maintenance').document(indexMaintenance);

                      documentReference3.updateData({
                        'maxid_mtcIT':maxidMaintenance
                      }).then((doc2) {
                        print('success');
                      }).catchError((error2) {
                        print(error2);
                      });
                    }).catchError((error) {
                      print(error);
                    });
                  } else {
                    print('else');
                  }
                }

                await new Future.delayed(Duration(
                  seconds: 3
                ));

                docReference.updateData({
                  'jobdesc_done': widget.timejob2,
                  'jobdesc_status': jobdescStatus,
                  'status': 'DONE',
                  'noteSave': controllerSave.text == '' ? null : controllerSave.text
                }).then((doc) {
                  setState(() {
                    isProcess = false;
                  });
                  Navigator.pop(context);
                  Navigator.pushReplacement(context,
                    MaterialPageRoute(
                      builder: (_) => FormMaintenanceTest(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)
                    )
                  );
                }).catchError((error) {
                  print(error);
                });
              } else {}
            });
          },
        ),
      ],
    );
  }
}

class AfterScanDialog extends StatefulWidget {
  final List<dynamic> timejob3;
  final String frequency;
  final Timestamp dueDate;
  final String item;
  final String itemNo;
  final List<dynamic> jobdesc;
  final int lokasiID;
  final String merek;
  final int outletID;
  final int picID;
  final int userCreatedID;
  final int idUser;
  final String departmentUser;
  final String namaUser;
  var indexx;

  AfterScanDialog({this.namaUser, this.departmentUser, this.idUser, this.dueDate, this.frequency, this.item, this.itemNo, this.jobdesc, this.lokasiID, this.merek, this.outletID, this.picID, this.timejob3, this.userCreatedID, this.indexx});

  @override
  AfterScanDialogState createState() => AfterScanDialogState();
}

class AfterScanDialogState extends State<AfterScanDialog> {
  bool isProcess = false;
  TextEditingController controllerSaveSkip = TextEditingController();
  var maxidMaintenance;
  var indexMaintenance;

  @override
  void initState() {
    Firestore.instance.collection('dumper_maintenance').snapshots().listen((data) {
      setState(() {
        maxidMaintenance = data.documents[0].data['maxid_mtcIT'] + 1;
        indexMaintenance = data.documents[0].documentID;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: TextFormField(
        maxLines: 2,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          labelText: 'Note (optional)',
          labelStyle: TextStyle(fontSize: 12.0),
        ),
        controller: controllerSaveSkip,
        maxLength: 250,
        textCapitalization: TextCapitalization.sentences,
        style: TextStyle(
          color: Colors.black,
          fontSize: 13.0
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Colors.black38
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              isProcess
                ? SizedBox(
                    height: 15.0,
                    width: 15.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 1.5,
                      value: null, valueColor: AlwaysStoppedAnimation<Color>(AbubaPallate.greenabuba),
                    ),
                  )
                : Container(),
              isProcess
                ? SizedBox(
                    width: 10.0,
                  )
                : Container(),
              Text(
                'Save',
              ),
            ],
          ),
          onPressed: () {
            setState(() async {
              if (isProcess == false) {
                isProcess = true;

                DocumentReference docReference = Firestore.instance.collection('maintenance_IT').document(widget.indexx);

                List<String> jobdescStatus = [];
                List<DateTime> jobdescDone = [];
                List<dynamic> jobdescDoneNew = [];
                List<dynamic> jobdescStatusNew = [];
                for (int y = 0; y < widget.timejob3.length; y++) {
                  setState(() {
                    jobdescDoneNew.add(null);
                    jobdescStatusNew.add('OPEN');
                    if (widget.timejob3[y] != null) {
                      jobdescStatus.add('DONE');
                      Timestamp timebantu = widget.timejob3[y];
                      jobdescDone.add(timebantu.toDate());
                    } else {
                      jobdescDone.add(DateTime.now());
                      jobdescStatus.add('DONE');
                    }
                  });
                }

                DocumentReference docReference2 = Firestore.instance.collection('maintenance_IT').document();
                List<String> arrFrequency = widget.frequency.split(' ');
                print('Due Date : ' + widget.dueDate.toDate().toString());

                if (arrFrequency.length == 2) {
                  if (arrFrequency[1].toString().toLowerCase() == 'month') {
                    var newDueDate = DateTime(widget.dueDate.toDate().year, widget.dueDate.toDate().month + int.tryParse(arrFrequency[0]), widget.dueDate.toDate().day, widget.dueDate.toDate().hour, widget.dueDate.toDate().minute, widget.dueDate.toDate().second, widget.dueDate.toDate().millisecond);
                    print('New Due Date : ' + newDueDate.toString());

                    docReference2.setData({
                      'alasan': null,
                      'dateCreated': DateTime.now(),
                      'dueDate': newDueDate,
                      'frequency': widget.frequency,
                      'item': widget.item,
                      'itemNo': widget.itemNo,
                      'jobdesc': widget.jobdesc,
                      'jobdesc_done': jobdescDoneNew,
                      'jobdesc_status': jobdescStatusNew,
                      'lokasi': widget.lokasiID,
                      'maintenanceNo': maxidMaintenance,
                      'merek': widget.merek,
                      'newDueDate': null,
                      'outlet': widget.outletID,
                      'pic': widget.picID,
                      'rescheduleBy': null,
                      'status': 'OPEN',
                      'userCreated': widget.userCreatedID
                    }).then((doc2) {
                      DocumentReference documentReference3 = Firestore.instance.collection('dumper_maintenance').document(indexMaintenance);

                      documentReference3.updateData({
                        'maxid_mtcIT':maxidMaintenance
                      }).then((doc2) {
                        print('success');
                      }).catchError((error2) {
                        print(error2);
                      });
                    }).catchError((error) {
                      print(error);
                    });
                  }
                } else {
                  if (widget.frequency.toString().toLowerCase() == 'monthly') {
                    var newDueDate = DateTime(widget.dueDate.toDate().year, widget.dueDate.toDate().month + 1, widget.dueDate.toDate().day, widget.dueDate.toDate().hour, widget.dueDate.toDate().minute, widget.dueDate.toDate().second, widget.dueDate.toDate().millisecond);
                    print('monthly');
                    print('New Due Date : ' + newDueDate.toString());

                    docReference2.setData({
                      'alasan': null,
                      'dateCreated': DateTime.now(),
                      'dueDate': newDueDate,
                      'frequency': widget.frequency,
                      'item': widget.item,
                      'itemNo': widget.itemNo,
                      'jobdesc': widget.jobdesc,
                      'jobdesc_done': jobdescDoneNew,
                      'jobdesc_status': jobdescStatusNew,
                      'lokasi': widget.lokasiID,
                      'maintenanceNo': maxidMaintenance,
                      'merek': widget.merek,
                      'newDueDate': null,
                      'outlet': widget.outletID,
                      'pic': widget.picID,
                      'rescheduleBy': null,
                      'status': 'OPEN',
                      'userCreated': widget.userCreatedID
                    }).then((doc2) {
                      DocumentReference documentReference3 = Firestore.instance.collection('dumper_maintenance').document(indexMaintenance);

                      documentReference3.updateData({
                        'maxid_mtcIT':maxidMaintenance
                      }).then((doc2) {
                        print('success');
                      }).catchError((error2) {
                        print(error2);
                      });
                    }).catchError((error) {
                      print(error);
                    });
                  } else if (widget.frequency.toString().toLowerCase() == 'yearly') {
                    var newDueDate = DateTime(widget.dueDate.toDate().year + 1, widget.dueDate.toDate().month, widget.dueDate.toDate().day, widget.dueDate.toDate().hour, widget.dueDate.toDate().minute, widget.dueDate.toDate().second, widget.dueDate.toDate().millisecond);
                    print('yearly');
                    print('New Due Date : ' + newDueDate.toString());

                    docReference2.setData({
                      'alasan': null,
                      'dateCreated': DateTime.now(),
                      'dueDate': newDueDate,
                      'frequency': widget.frequency,
                      'item': widget.item,
                      'itemNo': widget.itemNo,
                      'jobdesc': widget.jobdesc,
                      'jobdesc_done': jobdescDoneNew,
                      'jobdesc_status': jobdescStatusNew,
                      'lokasi': widget.lokasiID,
                      'maintenanceNo': maxidMaintenance,
                      'merek': widget.merek,
                      'newDueDate': null,
                      'outlet': widget.outletID,
                      'pic': widget.picID,
                      'rescheduleBy': null,
                      'status': 'OPEN',
                      'userCreated': widget.userCreatedID
                    }).then((doc2) {
                      DocumentReference documentReference3 = Firestore.instance.collection('dumper_maintenance').document(indexMaintenance);

                      documentReference3.updateData({
                        'maxid_mtcIT':maxidMaintenance
                      }).then((doc2) {
                        print('success');
                      }).catchError((error2) {
                        print(error2);
                      });
                    }).catchError((error) {
                      print(error);
                    });
                  } else if (widget.frequency.toString().toLowerCase() == 'weekly') {
                    var newDueDate = DateTime(widget.dueDate.toDate().year, widget.dueDate.toDate().month, widget.dueDate.toDate().day + 7, widget.dueDate.toDate().hour, widget.dueDate.toDate().minute, widget.dueDate.toDate().second, widget.dueDate.toDate().millisecond);
                    print('weekly');
                    print('New Due Date : ' + newDueDate.toString());

                    docReference2.setData({
                      'alasan': null,
                      'dateCreated': DateTime.now(),
                      'dueDate': newDueDate,
                      'frequency': widget.frequency,
                      'item': widget.item,
                      'itemNo': widget.itemNo,
                      'jobdesc': widget.jobdesc,
                      'jobdesc_done': jobdescDoneNew,
                      'jobdesc_status': jobdescStatusNew,
                      'lokasi': widget.lokasiID,
                      'maintenanceNo': maxidMaintenance,
                      'merek': widget.merek,
                      'newDueDate': null,
                      'outlet': widget.outletID,
                      'pic': widget.picID,
                      'rescheduleBy': null,
                      'status': 'OPEN',
                      'userCreated': widget.userCreatedID
                    }).then((doc2) {
                      DocumentReference documentReference3 = Firestore.instance.collection('dumper_maintenance').document(indexMaintenance);

                      documentReference3.updateData({
                        'maxid_mtcIT':maxidMaintenance
                      }).then((doc2) {
                        print('success');
                      }).catchError((error2) {
                        print(error2);
                      });
                    }).catchError((error) {
                      print(error);
                    });
                  } else {
                    print('else');
                  }
                }

                await new Future.delayed(Duration(
                  seconds: 3
                ));

                docReference.updateData({
                  'jobdesc_done': jobdescDone,
                  'jobdesc_status': jobdescStatus,
                  'status': 'DONE',
                  'noteSkipSave': controllerSaveSkip.text == '' ? null : controllerSaveSkip.text,
                }).then((doc) {
                  setState(() {
                    isProcess = false;
                  });
                  Navigator.pop(context);
                  Navigator.pushReplacement(context,
                    MaterialPageRoute(
                      builder: (_) => FormMaintenanceTest(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)
                    )
                  );
                }).catchError((error) {
                  print(error);
                });
              } else {}
            });
          },
        ),
      ],
    );
  }
}

class Checkbox2 extends StatefulWidget {
  Checkbox2({this.alasan, this.onCancelResult, this.valueCheck, this.indexx, this.frequency, this.itemNo, this.pic, this.item, this.lokasi, this.merek, this.outlet, this.onResult, this.jobStatus, this.idUser, this.namaUser, this.departmentUser, this.job, this.userCreated});

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
  List<dynamic> jobStatus;
  List<dynamic> job;
  int userCreated;
  final int idUser;
  final String departmentUser;
  final String namaUser;

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
                                    Navigator.pop(context);
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return AfterSkipDialog(
                                          departmentUser: widget.departmentUser,
                                          idUser: widget.idUser,
                                          namaUser: widget.namaUser,
                                          job: widget.job,
                                          userCreated: widget.userCreated,
                                          valueAlasan: value,
                                          jobStatus: widget.jobStatus,
                                          indexx: widget.indexx,
                                        );
                                      }
                                    );
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

class AfterSkipDialog extends StatefulWidget {
  final int valueAlasan;
  final List<dynamic> job;
  final List<dynamic> jobStatus;
  final int userCreated;
  final int idUser;
  final String departmentUser;
  final String namaUser;
  var indexx;

  AfterSkipDialog({this.idUser, this.userCreated, this.departmentUser, this.job, this.namaUser, this.valueAlasan, this.jobStatus, this.indexx});
  @override
  _AfterSkipDialogState createState() => _AfterSkipDialogState();
}

class _AfterSkipDialogState extends State<AfterSkipDialog> {
  bool isProses = false;
  TextEditingController controllerSkip = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: TextFormField(
        maxLines: 2,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          labelText: 'Skip Note (optional)',
          labelStyle: TextStyle(fontSize: 12.0),
        ),
        controller: controllerSkip,
        maxLength: 250,
        textCapitalization: TextCapitalization.sentences,
        style: TextStyle(
          color: Colors.black,
          fontSize: 13.0
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Colors.black38
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              isProses
                ? SizedBox(
                    height: 15.0,
                    width: 15.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 1.5,
                      value: null, valueColor: AlwaysStoppedAnimation<Color>(AbubaPallate.greenabuba),
                    ),
                  )
                : Container(),
              isProses
                ? SizedBox(
                    width: 10.0,
                  )
                : Container(),
              Text(
                'Save',
              ),
            ],
          ),
          onPressed: () {
            setState(() {
              if (isProses == false) {
                isProses = true;

                List<String> jobdescStatusSaveSkip = [];
                for (int w = 0; w < widget.jobStatus.length; w++) {
                  jobdescStatusSaveSkip.add('SKIP');
                }
                DocumentReference docReference = Firestore.instance.collection('maintenance_IT').document(widget.indexx);

                docReference.updateData({
                  'alasan': widget.valueAlasan,
                  'jobdesc_skip': widget.job,
                  'jobdesc_status': jobdescStatusSaveSkip,
                  'status': 'SKIP',
                  'skippedDate': DateTime.now(),
                  'rescheduleBy': widget.userCreated,
                  'noteSkip': controllerSkip.text != '' ? controllerSkip.text : null
                }).then((doc) async {
                  isProses = false;
                  Navigator.pop(context);
                  Navigator.pushReplacement(context,
                    MaterialPageRoute(
                      builder: (_) => FormMaintenanceTest(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)
                    )
                  );
                }).catchError((error) {
                  print(error);
                });
              } else {}
            });
          },
        ),
      ],
    );
  }
}

class FilterBox extends StatefulWidget {
  final ValueChanged<List<dynamic>> onResult;
  final List<dynamic> areaID;
  final List<dynamic> areaName;
  final List<dynamic> lokasiID;
  final List<dynamic> lokasiName;

  final String selectedChoise;
  final String selectedChoiseArea;
  final String selectedChoiseLokasi;

  FilterBox({this.onResult, this.areaID, this.areaName, this.lokasiID, this.lokasiName, this.selectedChoiseLokasi, this.selectedChoiseArea, this.selectedChoise});

  @override
  _FilterBoxState createState() => new _FilterBoxState();
}

class _FilterBoxState extends State<FilterBox> with TickerProviderStateMixin {
  List<String> frequencyFilter = ['Weekly', 'Monthly', '3 Month', '6 Month', '12 Month'];
  String selectedChoise = '';
  String selectedChoiseArea = '';
  String selectedChoiseLokasi = '';

  @override
  void initState() {
    selectedChoise = widget.selectedChoise;
    selectedChoiseArea = widget.selectedChoiseArea;
    selectedChoiseLokasi = widget.selectedChoiseLokasi;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        child: Column(
          children: <Widget>[
            Container(
              color: AbubaPallate.greenabuba,
              height: 50.0,
              child: ListTile(
                leading: IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text(
                  'Filter',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w700
                  ),
                ),
              )
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.45,
              padding: EdgeInsets.only(bottom: 5.0),
              child: Column(
                children: <Widget>[
                  Flexible(
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: ExpansionTile(
                                  title: Row(
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
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(top: 5.0),
                                      width: MediaQuery.of(context).size.width * 0.75,
                                      height: MediaQuery.of(context).size.height * 0.19,
                                      child: Column(
                                        children: <Widget>[
                                          Flexible(
                                            child: ListView(
                                              children: <Widget>[
                                                Wrap(
                                                  children: List.generate(widget.areaName.length, (index) {
                                                    return Container(
                                                      padding: EdgeInsets.all(2.0),
                                                      child: ChoiceChip(
                                                        backgroundColor: Colors.grey[200],
                                                        label: Text(
                                                          widget.areaName[index],
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.w400
                                                          ),
                                                        ),
                                                        selected: selectedChoiseArea == widget.areaName[index],
                                                        onSelected: (selected) {
                                                          setState(() {
                                                            selectedChoiseArea = widget.areaName[index];
                                                          });
                                                        },
                                                      ),
                                                    );
                                                  }).toList()
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ),
                                  ],
                                )
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Divider(
                            color: Colors.black38,
                            height: 2.0,
                          )
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: ExpansionTile(
                                  title: Row(
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
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(top: 5.0),
                                      width: MediaQuery.of(context).size.width * 0.75,
                                      height: MediaQuery.of(context).size.height * 0.19,
                                      child: Column(
                                        children: <Widget>[
                                          Flexible(
                                            child: ListView(
                                              children: <Widget>[
                                                Wrap(
                                                  children: List.generate(widget.lokasiName.length, (index) {
                                                    return Container(
                                                      padding: EdgeInsets.all(2.0),
                                                      child: ChoiceChip(
                                                        backgroundColor: Colors.grey[200],
                                                        label: Text(
                                                          widget.lokasiName[index],
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.w400
                                                          ),
                                                        ),
                                                        selected: selectedChoiseLokasi == widget.lokasiName[index],
                                                        onSelected: (selected) {
                                                          setState(() {
                                                            selectedChoiseLokasi = widget.lokasiName[index];
                                                          });
                                                        },
                                                      ),
                                                    );
                                                  }).toList()
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ),
                                  ],
                                )
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Divider(
                            color: Colors.black38,
                            height: 2.0,
                          )
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0, bottom: 5.0, top: 20.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Frequency',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 5.0),
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: Wrap(
                                  children: List.generate(frequencyFilter.length, (index) {
                                    return Container(
                                      padding: EdgeInsets.all(2.0),
                                      child: ChoiceChip(
                                        backgroundColor: Colors.grey[200],
                                        label: Text(
                                          frequencyFilter[index],
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400
                                          ),
                                        ),
                                        selected: selectedChoise == frequencyFilter[index],
                                        onSelected: (selected) {
                                          setState(() {
                                            selectedChoise = frequencyFilter[index];
                                          });
                                        },
                                      ),
                                    );
                                  }).toList()
                                )
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0, top: 10.0),
                          child: Divider(
                            color: Colors.black38,
                            height: 2.0,
                          )
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 20.0, bottom: 5.0, right: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              ButtonTheme(
                                minWidth: MediaQuery.of(context).size.width * 0.35,
                                height: 35.0,
                                child: FlatButton(
                                  child: Text(
                                    'CLEAR FILTER',
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                                  textColor: Colors.black54,
                                  color: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  onPressed: () {
                                    setState(() {
                                      selectedChoise = '';
                                      selectedChoiseArea = '';
                                      selectedChoiseLokasi = '';
                                    });
                                    widget.onResult([false, '', '', '']);
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              ButtonTheme(
                                minWidth: MediaQuery.of(context).size.width * 0.35,
                                height: 35.0,
                                child: RaisedButton(
                                  child: Text(
                                    'SELESAI',
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                                  textColor: Colors.white,
                                  color: AbubaPallate.greenabuba,
                                  splashColor: AbubaPallate.greenabuba,
                                  onPressed: () {
                                    widget.onResult([true, selectedChoise, selectedChoiseArea, selectedChoiseLokasi]);
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ],
                          )
                        ),
                      ],
                    ),
                  )
                ],
              )
            )
          ],
        )
      ),
    );
  }
}