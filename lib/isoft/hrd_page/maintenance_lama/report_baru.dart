import 'dart:async';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormReport extends StatefulWidget {
  final int idUser;
  final String aksesStatus;
  FormReport({this.idUser, this.aksesStatus});

  @override
  _FormReportState createState() => _FormReportState();
}

class _FormReportState extends State<FormReport> with TickerProviderStateMixin {
  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime dateStart;
  DateTime dateEnd;

  AnimationController animationController;

  bool showDataFiltered = false;
  bool showHelper = false;
  String helperText = '';

  List<dynamic> date = [];
  List<dynamic> outlet = [];
  List<dynamic> lokasi = [];
  List<dynamic> item = [];
  List<dynamic> merek = [];
  List<dynamic> itemNo = [];
  List<dynamic> status = [];
  List<dynamic> pic = [];
  List<dynamic> frequency = [];
  List<dynamic> jobdescID = [];
  List<dynamic> jobdescNameDone = [];
  List<dynamic> jobdescNameSkip = [];
  List<dynamic> jobdescTime = [];
  List<dynamic> dueDate = [];
  List<dynamic> alasan = [];
  List<dynamic> newSchedule = [];
  List<dynamic> rescheduleBy = [];

  String alasanName = '';
  String rescheduleByName = '';

  @override
  void initState() {
    super.initState();
    // CollectionReference reference = Firestore.instance.collection('maintenance');
    // reference.snapshots().listen((data) {
    //   data.documentChanges.forEach((change) {
        
    //   });
    // });

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
        body: _buildReport(width),
      ),
    );
  }

  Widget _buildReport(double width) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Maintenance',
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
                  'Report',
                  style:
                      TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.white,
          width: width,
          child: ExpansionTile(
            title: Text(
              'Search',
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 0.0, left: 20.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: width / 2.5,
                      child: DateTimePickerFormField(
                        format: dateFormat,
                        onChanged: (dt) => setState(() => dateStart = dt),
                        dateOnly: true,
                        editable: false,
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelStyle: TextStyle(fontSize: 14.0),
                          labelText: 'From',
                          helperText: helperText,
                          helperStyle: TextStyle(
                            color: showHelper ? Colors.redAccent : Colors.black38,
                            fontStyle: showHelper ? FontStyle.italic : FontStyle.normal,
                            fontSize: 14.0
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: width / 2.5,
                      child: DateTimePickerFormField(
                        format: dateFormat,
                        onChanged: (dt) => setState(() => dateEnd = dt),
                        dateOnly: true,
                        editable: false,
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelStyle: TextStyle(fontSize: 14.0),
                          labelText: 'To',
                          helperText: '',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 15.0),
                child: ButtonTheme(
                  minWidth: width / 2.5,
                  height: 40.0,
                  child: RaisedButton(
                    color: Colors.green,
                    child: Text(
                      'SEARCH',
                      style: TextStyle(
                          fontSize: 13.0, color: Colors.white),
                    ),
                    onPressed: () {
                      setState(() {
                        if (dateStart.isAfter(dateEnd) == false) {
                          showDataFiltered = true;
                          showHelper = false;
                          helperText = '';
                          status.clear();
                          outlet.clear();
                          frequency.clear();
                          date.clear();
                          jobdescID.clear();
                          jobdescTime.clear();
                          dueDate.clear();
                          rescheduleBy.clear();
                          alasan.clear();
                          newSchedule.clear();
                          item.clear();
                          itemNo.clear();
                          merek.clear();
                          lokasi.clear();
                          pic.clear();
                          
                          if (showDataFiltered && dateEnd != null && dateStart != null) {
                            var query = Firestore.instance.collection('maintenance').where('dateCreated', isGreaterThanOrEqualTo: dateStart).orderBy('dateCreated', descending: false);
                            query.getDocuments().then((change) {
                              if (change.documents.length > 0) {
                                print(change.documents.length);
                                for (int qq = 0; qq < change.documents.length; qq++) {
                                  DateTime tanggalBantu = DateTime.tryParse(change.documents[qq].data['dateCreated'].toString());
                                  if (tanggalBantu.isAfter(dateEnd) == true) {
                                    
                                  } else {
                                    date.add(change.documents[qq].data['dateCreated'].toString().substring(8, 10) + '/' + change.documents[qq].data['dateCreated'].toString().substring(5, 7) + '/' +change.documents[qq].data['dateCreated'].toString().substring(0, 4));
                                    status.add(change.documents[qq].data['status']);
                                    frequency.add(change.documents[qq].data['frequency']);
                                    jobdescID.add(change.documents[qq].data['jobdesc']);
                                    jobdescTime.add(change.documents[qq].data['jobdesc_done']);
                                    dueDate.add(change.documents[qq].data['dueDate'].toString().substring(8, 10) + '/' + change.documents[qq].data['dueDate'].toString().substring(5, 7) + '/' +change.documents[qq].data['dueDate'].toString().substring(0, 4));
                                    rescheduleBy.add(change.documents[qq].data['rescheduleBy']);
                                    alasan.add(change.documents[qq].data['alasan']);

                                    if (change.documents[qq].data['newDueDate'] == null) {
                                      newSchedule.add(null);
                                    } else {
                                      newSchedule.add(change.documents[qq].data['newDueDate'].toString().substring(8, 10) + '/' + change.documents[qq].data['newDueDate'].toString().substring(5, 7) + '/' +change.documents[qq].data['newDueDate'].toString().substring(0, 4));
                                    }

                                    Firestore.instance.collection('maintenance_item').where('id', isEqualTo: change.documents[qq].data['item']).snapshots().listen((data2) {
                                      item.add(data2.documents[0].data['item']);
                                      itemNo.add(data2.documents[0].data['kode']);
                                    });

                                    Firestore.instance.collection('maintenance_merek').where('id', isEqualTo: change.documents[qq].data['merek']).snapshots().listen((data3) {
                                      merek.add(data3.documents[0].data['merek']);
                                    });

                                    Firestore.instance.collection('outlet').where('id', isEqualTo: change.documents[qq].data['outlet']).snapshots().listen((data4) {
                                      outlet.add(data4.documents[0].data['nama_outlet']);
                                    });

                                    Firestore.instance.collection('lokasi').where('id', isEqualTo: change.documents[qq].data['lokasi']).snapshots().listen((data5) {
                                      lokasi.add(data5.documents[0].data['lokasi']);
                                    });

                                    Firestore.instance.collection('user').where('id', isEqualTo: change.documents[qq].data['pic']).snapshots().listen((data6) {
                                      pic.add(data6.documents[0].data['nama']);
                                    });
                                  }
                                }
                              }
                            });
                          } else {
                            showDataFiltered = false;
                            showHelper = true;
                            helperText = "select date start and to";
                          }
                        } else {
                          showDataFiltered = false;
                          showHelper = true;
                          helperText = "can\'t back date";
                        }
                      });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        AnimatedBuilder(
          animation: animationController,
          builder: (_, Widget child) {
            return animationController.isAnimating
              ? Container(
                  child: Center(
                    child: CircularProgressIndicator()
                  )
                )
              : Container(
                  width: width,
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: width * 0.3,
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
                              width: width * 0.3,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Location / Item',
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
                      Column(
                        children: List.generate(outlet.length, (index) {
                          if (status[index] != 'OPEN') {
                            return Column(
                              children: <Widget>[
                                Padding(
                                  padding: index == status.length - 1 ? const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0) : const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: width * 0.3,
                                        child: Row(
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                date[index],
                                                style: TextStyle(
                                                    fontSize: 12.0, color: Colors.black),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: width * 0.3,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
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
                                                        text: outlet[index],
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
                                              height: 3.0,
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
                                                        text: lokasi[index],
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
                                                        text: '${merek[index]} - ${item[index]}',
                                                        style: TextStyle(
                                                          fontSize: 12.0,
                                                          color: Colors.black
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 3.0,
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
                                                        text: '# ${itemNo[index]}',
                                                        style: TextStyle(
                                                          fontSize: 11.0,
                                                          fontWeight: FontWeight.w300,
                                                          color: Colors.black45
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ),
                                      Container(
                                        width: width * 0.3,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Flexible(
                                              child: ButtonTheme(
                                                minWidth: 50.0,
                                                height: 30.0,
                                                splashColor: status[index] == 'DONE' ? AbubaPallate.greenabuba : Colors.redAccent,
                                                child: OutlineButton(
                                                  borderSide: BorderSide(
                                                      color: status[index] == 'DONE' ? AbubaPallate.greenabuba : Colors.redAccent),
                                                  child: Text(
                                                    status[index],
                                                    style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: status[index] == 'DONE' ? AbubaPallate.greenabuba : Colors.redAccent),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  onPressed: () async {
                                                    setState(() {
                                                      jobdescNameDone.clear();
                                                      jobdescNameSkip.clear();
                                                      alasanName = '';
                                                      rescheduleByName = '';
                                                      if (alasan[index] != null) {
                                                        Firestore.instance.collection('maintenance_alasan').where('id', isEqualTo: alasan[index]).snapshots().listen((dataAlasan) {
                                                          alasanName = dataAlasan.documents[0].data['alasan'];
                                                        });
                                                      } else {
                                                        alasanName = '-';
                                                      }

                                                      if (rescheduleBy[index] != null) {
                                                        Firestore.instance.collection('user').where('id', isEqualTo: rescheduleBy[index]).snapshots().listen((dataReschedule) {
                                                          rescheduleByName = dataReschedule.documents[0].data['nama'];
                                                        });
                                                      } else {
                                                        rescheduleByName = '-';
                                                      }
                                                      
                                                      for (int i = 0; i < jobdescID[index].length; i++) {
                                                        Firestore.instance.collection('maintenance_jobdesc').where('id', isEqualTo: jobdescID[index][i]).snapshots().listen((data) {
                                                          //sini  
                                                          if (jobdescTime[index][i].toString().substring(8, 10) + '/' + jobdescTime[index][i].toString().substring(5, 7) + '/' +jobdescTime[index][i].toString().substring(0, 4) == dueDate[index]) {
                                                            jobdescNameDone.add(data.documents[0].data['jobdesc']);
                                                          } else {
                                                            jobdescNameSkip.add(data.documents[0].data['jobdesc']);
                                                          }
                                                        });
                                                      }
                                                    });
                                                    await new Future.delayed(Duration(
                                                      milliseconds: 500
                                                    ));
                                                    showDialog(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      builder: (BuildContext context) {
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
                                                                Padding(
                                                                  padding: EdgeInsets.only(bottom: 5.0, top: 20.0),
                                                                  child: Column(
                                                                    children: <Widget>[
                                                                      Container(
                                                                        height: MediaQuery.of(context).size.height * 0.6,
                                                                        child: Column(
                                                                          children: <Widget>[
                                                                            Flexible(
                                                                              child: ListView(
                                                                                physics: ScrollPhysics(),
                                                                                shrinkWrap: true, 
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
                                                                                                  'General Info',
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
                                                                                                  outlet[index],
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
                                                                                                  merek[index],
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
                                                                                                  'Brand',
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
                                                                                                  item[index],
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
                                                                                                  'ID#',
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
                                                                                                  itemNo[index],
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
                                                                                                  'Schedule',
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
                                                                                          width: MediaQuery.of(context).size.width * 0.35,
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                                                            children: <Widget>[
                                                                                              Flexible(
                                                                                                child: Text(
                                                                                                  frequency[index],
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
                                                                                                  'Jadwal',
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
                                                                                                  dueDate[index],
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
                                                                                                  'Pelaksana',
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
                                                                                                  'Done',
                                                                                                  style: TextStyle(
                                                                                                    fontSize: 15.0, color: AbubaPallate.greenabuba, fontWeight: FontWeight.bold
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
                                                                                          width: MediaQuery.of(context).size.width * 0.2,
                                                                                          child: Row(
                                                                                            children: <Widget>[
                                                                                              Flexible(
                                                                                                child: Text(
                                                                                                  'Tugas',
                                                                                                  style: TextStyle(
                                                                                                    fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                        Container(
                                                                                          width: MediaQuery.of(context).size.width * 0.5,
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                                                            children: <Widget>[
                                                                                              Flexible(
                                                                                                child: Text(
                                                                                                  jobdescNameDone.length == 0 ? '-' : jobdescNameDone.join(', ').toString(),
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
                                                                                                  'Tgl Pelaksanaan',
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
                                                                                                  jobdescTime[index][0].toString().substring(8, 10) + '/' + jobdescTime[index][0].toString().substring(5, 7) + '/' +jobdescTime[index][0].toString().substring(0, 4),
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
                                                                                                  'Skipped',
                                                                                                  style: TextStyle(
                                                                                                    fontSize: 15.0, color: Colors.redAccent, fontWeight: FontWeight.bold
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
                                                                                          width: MediaQuery.of(context).size.width * 0.2,
                                                                                          child: Row(
                                                                                            children: <Widget>[
                                                                                              Flexible(
                                                                                                child: Text(
                                                                                                  'Tugas',
                                                                                                  style: TextStyle(
                                                                                                    fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                        Container(
                                                                                          width: MediaQuery.of(context).size.width * 0.5,
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                                                            children: <Widget>[
                                                                                              Flexible(
                                                                                                child: Text(
                                                                                                  jobdescNameSkip.length == 0 ? '-' : jobdescNameSkip.join(', ').toString(),
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
                                                                                                  'Jadwal Seharusnya',
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
                                                                                                  jobdescNameSkip.length == 0 ? '-' : dueDate[index],
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
                                                                                                  'Jadwal Baru',
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
                                                                                                  newSchedule[index] == null ? '-' : newSchedule[index],
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
                                                                                                  'Jadwal Diubah Oleh',
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
                                                                                                  rescheduleByName,
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
                                                                                                  'Alasan Ditunda',
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
                                                                                                  alasanName,
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
                                                                                ],
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets.only(right: 20.0),
                                                                  alignment: Alignment.centerRight,
                                                                  child: ButtonTheme(
                                                                    minWidth: 50.0,
                                                                    height: 30.0,
                                                                    splashColor: AbubaPallate.greenabuba,
                                                                    child: OutlineButton(
                                                                      borderSide: BorderSide(
                                                                        color: AbubaPallate.greenabuba
                                                                      ),
                                                                      child: Text(
                                                                        'Close',
                                                                        style: TextStyle(
                                                                          fontSize: 12.0,
                                                                          color: AbubaPallate.greenabuba),
                                                                        textAlign: TextAlign.center,
                                                                      ),
                                                                      onPressed: () {
                                                                        Navigator.pop(context);
                                                                      },
                                                                    )
                                                                  ),
                                                                )
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
                                      )
                                    ],
                                  ),
                                )
                              ],
                            );
                          } else {
                            return Container();
                          }
                        }).toList()
                      )
                    ],
                  ),
                );
          },
        )
      ],
    );
  }
}
