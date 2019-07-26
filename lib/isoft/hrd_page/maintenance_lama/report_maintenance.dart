import 'dart:async';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormReport extends StatefulWidget {
  final int idUser;
  final String namaUser;
  FormReport({this.idUser, this.namaUser});

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

  var _searchEdit = new TextEditingController();

  bool _isSearch = true;
  String _searchText = "";
  List<dynamic> _searchListItems;
  List<dynamic> statusListItems;
  List<dynamic> itemListItems;
  List<dynamic> lokasiListItems;
  List<dynamic> merekListItems;
  List<dynamic> itemNoListItems;
  List<dynamic> dueDateListItems;
  List<dynamic> dateListItems;
  List<dynamic> picListItems;
  List<dynamic> frequencyListItems;
  List<dynamic> jobdescIDListItems;
  List<dynamic> jobdescNameDoneListItems;
  List<dynamic> jobdescNameSkipListItems;
  List<dynamic> jobdescTimeListItems;
  List<dynamic> alasanListItems;
  List<dynamic> newScheduleListItems;
  List<dynamic> rescheduleByListItems;

  List<String> _socialListItems;

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
  String id;

  String alasanName = '';
  String rescheduleByName = '';

  @override
  void initState() {
    super.initState();
    CollectionReference reference = Firestore.instance.collection('maintenance');
    reference.snapshots().listen((data) {
      data.documentChanges.forEach((change) {
        setState(() {
          id = change.document.documentID;
          date.add(change.document.data['dateCreated']);
          status.add(change.document.data['status']);
          frequency.add(change.document.data['frequency']);
          jobdescID.add(change.document.data['jobdesc']);
          jobdescTime.add(change.document.data['jobdesc_done']);
          dueDate.add(change.document.data['dueDate']);
          rescheduleBy.add(change.document.data['rescheduleBy']);
          alasan.add(change.document.data['alasan']);

          if (change.document.data['newDueDate'] == null) {
            newSchedule.add(null);
          } else {
            newSchedule.add(change.document.data['newDueDate']);
          }

          Firestore.instance.collection('maintenance_item').where('id', isEqualTo: change.document.data['item']).snapshots().listen((data2) {
            item.add(data2.documents[0].data['item']);
            itemNo.add(data2.documents[0].data['kode']);
          });

          Firestore.instance.collection('maintenance_merek').where('id', isEqualTo: change.document.data['merek']).snapshots().listen((data3) {
            merek.add(data3.documents[0].data['merek']);
          });

          Firestore.instance.collection('outlet').where('id', isEqualTo: change.document.data['outlet']).snapshots().listen((data4) {
            outlet.add(data4.documents[0].data['nama_outlet']);
          });

          Firestore.instance.collection('lokasi').where('id', isEqualTo: change.document.data['lokasi']).snapshots().listen((data5) {
            lokasi.add(data5.documents[0].data['lokasi']);
          });

          Firestore.instance.collection('user').where('id', isEqualTo: change.document.data['pic']).snapshots().listen((data6) {
            pic.add(data6.documents[0].data['nama']);
          });

          /*date.sort();
          status.sort();
          frequency.sort();
          jobdescID.sort();
          jobdescTime.sort();
          dueDate.sort();
          newSchedule.sort();
          rescheduleBy.sort();
          alasan.sort();
          item.sort();
          itemNo.sort();
          merek.sort();
          outlet.sort();
          lokasi.sort();
          pic.sort();*/
        });
      });
    });

    _socialListItems = new List<String>();
    _socialListItems = [
      "Facebook",
      "Instagram",
      "Twitter",
      "LinkedIn",
      "Messenger",
      "WhatsApp",
      "Naukri",
      "Medium",
      "Tinder",
      "Gmail",
      "Hangouts",
      "Google Plus",
      "Snapchat",
      "True Caller",
      "WeChat",
      "Pinterest",
      "Quora"
    ];
    _socialListItems.sort();

    animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(
        from: animationController.value == 0.0
            ? 1.0
            : animationController.value
    );
  }

  _FormReportState() {
    _searchEdit.addListener(() {
      if (_searchEdit.text.isEmpty) {
        setState(() {
          _isSearch = true;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearch = false;
          _searchText = _searchEdit.text;
        });
      }
    });
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
          body:  GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: AnimatedBuilder(
                animation: animationController,
                builder: (_, Widget child) {
                  return animationController.isAnimating
                      ? Container(
                      child: Center(
                          child: CircularProgressIndicator()
                      )
                  )
                      : new Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(bottom: 10.0, right: 15.0, left: 15.0, top: 10.0),
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
                      _searchBox(),
                      Container(
                        width: width,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
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
                      ),
                      _isSearch ? _listView(width) : _searchListView()
                    ],
                  );
                },
              )
          )
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
                      // setState(() {
                      //   if (dateStart.isAfter(dateEnd) == false) {
                      //     showDataFiltered = true;
                      //     showHelper = false;
                      //     helperText = '';
                      //   } else {
                      //     showDataFiltered = false;
                      //     showHelper = true;
                      //     helperText = "can\'t back date";
                      //   }
                      // });
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
                        Timestamp dateView = date[index];
                        Timestamp dueDateView = dueDate[index];
                        Timestamp jobdescTimeView2;
                        if (jobdescTime[index][0] != null) {
                          jobdescTimeView2 = jobdescTime[index][0];
                        }
                        Timestamp newScheduleView;
                        if (newSchedule[index] != null) {
                          newScheduleView = newSchedule[index];
                        }
                        if (status[index] == 'RESCHEDULE') {
                          return Container();
                        } else if (status[index] != 'OPEN') {
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
                                              dateView.toDate().toString().substring(8, 10) + '/' + dateView.toDate().toString().substring(5, 7) + '/' +dateView.toDate().toString().substring(0, 4),
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
                                                      // Firestore.instance.collection('maintenance_jobdesc').where('id', isEqualTo: jobdescID[index][i]).snapshots().listen((data) {
                                                        //sini
                                                        Timestamp jobdescTimeView = jobdescTime[index][i];
                                                        if (jobdescTimeView.toDate().toString().substring(8, 10) + '/' + jobdescTimeView.toDate().toString().substring(5, 7) + '/' +jobdescTimeView.toDate().toString().substring(0, 4) == dueDateView.toDate().toString().substring(8, 10) + '/' + dueDateView.toDate().toString().substring(5, 7) + '/' +dueDateView.toDate().toString().substring(0, 4)) {
                                                          jobdescNameDone.add(jobdescID[index][i]);
                                                        } else {
                                                          jobdescNameSkip.add(jobdescID[index][i]);
                                                        }
                                                      // });
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
                                                                                      padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: <Widget>[
                                                                                          Container(
                                                                                            width: MediaQuery.of(context).size.width * 0.3,
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
                                                                                            width: MediaQuery.of(context).size.width * 0.3,
                                                                                            child: Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                                              children: <Widget>[
                                                                                                Flexible(
                                                                                                  child: Text(
                                                                                                    outlet[index],
                                                                                                    style: TextStyle(
                                                                                                        fontSize: 13.0,
                                                                                                        color: Colors.black38,
                                                                                                        fontWeight: FontWeight.w700
                                                                                                    ),
                                                                                                    textAlign: TextAlign.right,
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: <Widget>[
                                                                                          Container(
                                                                                            width: MediaQuery.of(context).size.width * 0.3,
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
                                                                                            width: MediaQuery.of(context).size.width * 0.3,
                                                                                            child: Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                                              children: <Widget>[
                                                                                                Flexible(
                                                                                                  child: Text(
                                                                                                    lokasi[index],
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
                                                                                      padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: <Widget>[
                                                                                          Container(
                                                                                            width: MediaQuery.of(context).size.width * 0.3,
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
                                                                                            width: MediaQuery.of(context).size.width * 0.3,
                                                                                            child: Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                                              children: <Widget>[
                                                                                                Flexible(
                                                                                                  child: Text(
                                                                                                    merek[index],
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
                                                                                      padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: <Widget>[
                                                                                          Container(
                                                                                            width: MediaQuery.of(context).size.width * 0.3,
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
                                                                                            width: MediaQuery.of(context).size.width * 0.3,
                                                                                            child: Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                                              children: <Widget>[
                                                                                                Flexible(
                                                                                                  child: Text(
                                                                                                    item[index],
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
                                                                                      padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: <Widget>[
                                                                                          Container(
                                                                                            width: MediaQuery.of(context).size.width * 0.3,
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
                                                                                            width: MediaQuery.of(context).size.width * 0.3,
                                                                                            child: Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                                              children: <Widget>[
                                                                                                Flexible(
                                                                                                  child: Text(
                                                                                                    itemNo[index],
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
                                                                                            width: MediaQuery.of(context).size.width * 0.3,
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
                                                                                      padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: <Widget>[
                                                                                          Container(
                                                                                            width: MediaQuery.of(context).size.width * 0.3,
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
                                                                                            width: MediaQuery.of(context).size.width * 0.3,
                                                                                            child: Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                                              children: <Widget>[
                                                                                                Flexible(
                                                                                                  child: Text(
                                                                                                    frequency[index],
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
                                                                                      padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: <Widget>[
                                                                                          Container(
                                                                                            width: MediaQuery.of(context).size.width * 0.3,
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
                                                                                            width: MediaQuery.of(context).size.width * 0.3,
                                                                                            child: Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                                              children: <Widget>[
                                                                                                Flexible(
                                                                                                  child: Text(
                                                                                                    dueDateView.toDate().toString().substring(8, 10) + '/' + dueDateView.toDate().toString().substring(5, 7) + '/' +dueDateView.toDate().toString().substring(0, 4),
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
                                                                                      padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: <Widget>[
                                                                                          Container(
                                                                                            width: MediaQuery.of(context).size.width * 0.3,
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
                                                                                            width: MediaQuery.of(context).size.width * 0.3,
                                                                                            child: Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                                              children: <Widget>[
                                                                                                Flexible(
                                                                                                  child: Text(
                                                                                                    pic[index],
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
                                                                                            width: MediaQuery.of(context).size.width * 0.3,
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
                                                                                      padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: <Widget>[
                                                                                          Container(
                                                                                            width: MediaQuery.of(context).size.width * 0.3,
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
                                                                                            alignment: Alignment.centerRight,
                                                                                            width: MediaQuery.of(context).size.width * 0.3,
                                                                                            child: Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                                              children: <Widget>[
                                                                                                Flexible(
                                                                                                  child: Text(
                                                                                                    jobdescNameDone.length == 0 ? '-' : jobdescNameDone.join(', ').toString(),
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
                                                                                      padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: <Widget>[
                                                                                          Container(
                                                                                            width: MediaQuery.of(context).size.width * 0.3,
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
                                                                                            width: MediaQuery.of(context).size.width * 0.3,
                                                                                            child: Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                                              children: <Widget>[
                                                                                                Flexible(
                                                                                                  child: Text(
                                                                                                    jobdescTime[index][0] != null
                                                                                                        ? jobdescTimeView2.toDate().toString().substring(8, 10) + '/' + jobdescTimeView2.toDate().toString().substring(5, 7) + '/' +jobdescTimeView2.toDate().toString().substring(0, 4)
                                                                                                        : '-',
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
                                                                                            width: MediaQuery.of(context).size.width * 0.3,
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
                                                                                      padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
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
                                                                                            width: MediaQuery.of(context).size.width * 0.3,
                                                                                            child: Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                                              children: <Widget>[
                                                                                                Flexible(
                                                                                                  child: Text(
                                                                                                    jobdescNameSkip.length == 0 ? '-' : jobdescNameSkip.join(', ').toString(),
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
                                                                                      padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: <Widget>[
                                                                                          Container(
                                                                                            width: MediaQuery.of(context).size.width * 0.3,
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
                                                                                            width: MediaQuery.of(context).size.width * 0.3,
                                                                                            child: Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                                              children: <Widget>[
                                                                                                Flexible(
                                                                                                  child: Text(
                                                                                                    jobdescNameSkip.length == 0 ? '-' : dueDateView.toDate().toString().substring(8, 10) + '/' + dueDateView.toDate().toString().substring(5, 7) + '/' +dueDateView.toDate().toString().substring(0, 4),
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
                                                                                      padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: <Widget>[
                                                                                          Container(
                                                                                            width: MediaQuery.of(context).size.width * 0.3,
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
                                                                                            width: MediaQuery.of(context).size.width * 0.3,
                                                                                            child: Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                                              children: <Widget>[
                                                                                                Flexible(
                                                                                                  child: Text(
                                                                                                    newSchedule[index] == null ? '-' : newScheduleView.toDate().toString().substring(8, 10) + '/' + newScheduleView.toDate().toString().substring(5, 7) + '/' +newScheduleView.toDate().toString().substring(0, 4),
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
                                                                                      padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: <Widget>[
                                                                                          Container(
                                                                                            width: MediaQuery.of(context).size.width * 0.3,
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
                                                                                            width: MediaQuery.of(context).size.width * 0.3,
                                                                                            child: Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                                              children: <Widget>[
                                                                                                Flexible(
                                                                                                  child: Text(
                                                                                                    rescheduleByName,
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
                                                                                      padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: <Widget>[
                                                                                          Container(
                                                                                            width: MediaQuery.of(context).size.width * 0.3,
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
                                                                                            width: MediaQuery.of(context).size.width * 0.3,
                                                                                            child: Row(
                                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                                              children: <Widget>[
                                                                                                Flexible(
                                                                                                  child: Text(
                                                                                                    alasanName,
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

  Widget _searchBox() {
    return new Container(
      margin: const EdgeInsets.only(bottom: 10.0, right: 15.0, left: 15.0),
      decoration: BoxDecoration(border: Border.all(width: 1.0, color: Colors.white), borderRadius: BorderRadius.circular(25.0), color: Colors.white  ),
      child: new TextField(
        controller: _searchEdit,
        decoration: InputDecoration(
            hintText: "Search",
            hintStyle: new TextStyle(color: Colors.black54),
            prefixIcon: Icon(Icons.search),
            prefixStyle: TextStyle(color: Colors.green),
            border: InputBorder.none
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _listView(width) {
    return new Flexible(
      child: new ListView.builder(
          itemCount: outlet.length,
          itemBuilder: (BuildContext context, int index) {
            Timestamp dateView = date[index];
            Timestamp dueDateView = dueDate[index];
            Timestamp jobdescTimeView2;
            if (jobdescTime[index][0] != null) {
              jobdescTimeView2 = jobdescTime[index][0];
            }
            Timestamp newScheduleView;
            if (newSchedule[index] != null) {
              newScheduleView = newSchedule[index];
            }
            if (status[index] == 'RESCHEDULE') {
              return Container();
            } else if (status[index] != 'OPEN') {
              return Container(
                width: width,
                padding: const EdgeInsets.only(right: 5.0, left: 5.0),
                color: Colors.white,
                child: Column(
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
                                    dateView.toDate().toString().substring(8, 10) + '/' + dateView.toDate().toString().substring(5, 7) + '/' +dateView.toDate().toString().substring(0, 4),
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
                                              text: '${outlet[index]}',
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
                                            // Firestore.instance.collection('maintenance_jobdesc').where('id', isEqualTo: jobdescID[index][i]).snapshots().listen((data) {
                                              //sini
                                              Timestamp jobdescTimeView = jobdescTime[index][i];
                                              if (jobdescTimeView.toDate().toString().substring(8, 10) + '/' + jobdescTimeView.toDate().toString().substring(5, 7) + '/' +jobdescTimeView.toDate().toString().substring(0, 4) == dueDateView.toDate().toString().substring(8, 10) + '/' + dueDateView.toDate().toString().substring(5, 7) + '/' +dueDateView.toDate().toString().substring(0, 4)) {
                                                jobdescNameDone.add(jobdescID[index][i]);
                                              } else {
                                                jobdescNameSkip.add(jobdescID[index][i]);
                                              }
                                            // });
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
                                                                            padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: <Widget>[
                                                                                Container(
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
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
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          outlet[index],
                                                                                          style: TextStyle(
                                                                                              fontSize: 13.0,
                                                                                              color: Colors.black38,
                                                                                              fontWeight: FontWeight.w700
                                                                                          ),
                                                                                          textAlign: TextAlign.right,
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: <Widget>[
                                                                                Container(
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
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
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          lokasi[index],
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
                                                                            padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: <Widget>[
                                                                                Container(
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
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
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          merek[index],
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
                                                                            padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: <Widget>[
                                                                                Container(
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
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
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          item[index],
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
                                                                            padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: <Widget>[
                                                                                Container(
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
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
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          itemNo[index],
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
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
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
                                                                            padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: <Widget>[
                                                                                Container(
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
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
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          frequency[index],
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
                                                                            padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: <Widget>[
                                                                                Container(
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
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
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          dueDateView.toDate().toString().substring(8, 10) + '/' + dueDateView.toDate().toString().substring(5, 7) + '/' +dueDateView.toDate().toString().substring(0, 4),
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
                                                                            padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: <Widget>[
                                                                                Container(
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
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
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          pic[index],
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
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
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
                                                                            padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: <Widget>[
                                                                                Container(
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
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
                                                                                  alignment: Alignment.centerRight,
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          jobdescNameDone.length == 0 ? '-' : jobdescNameDone.join(', ').toString(),
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
                                                                            padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: <Widget>[
                                                                                Container(
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
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
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          jobdescTime[index][0] != null
                                                                                              ? jobdescTimeView2.toDate().toString().substring(8, 10) + '/' + jobdescTimeView2.toDate().toString().substring(5, 7) + '/' +jobdescTimeView2.toDate().toString().substring(0, 4)
                                                                                              : '-',
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
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
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
                                                                            padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
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
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          jobdescNameSkip.length == 0 ? '-' : jobdescNameSkip.join(', ').toString(),
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
                                                                            padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: <Widget>[
                                                                                Container(
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
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
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          jobdescNameSkip.length == 0 ? '-' : dueDateView.toDate().toString().substring(8, 10) + '/' + dueDateView.toDate().toString().substring(5, 7) + '/' +dueDateView.toDate().toString().substring(0, 4),
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
                                                                            padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: <Widget>[
                                                                                Container(
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
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
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          newSchedule[index] == null ? '-' : newScheduleView.toDate().toString().substring(8, 10) + '/' + newScheduleView.toDate().toString().substring(5, 7) + '/' +newScheduleView.toDate().toString().substring(0, 4),
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
                                                                            padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: <Widget>[
                                                                                Container(
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
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
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          rescheduleByName,
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
                                                                            padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: <Widget>[
                                                                                Container(
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
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
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          alasanName,
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
                ),
              );
            } else {
              return Container();
            }
          }),
    );
  }

  Widget _searchListView() {
    final double width = MediaQuery.of(context).size.width;

    dateListItems = new List<dynamic>();
    statusListItems = new List<dynamic>();
    _searchListItems = new List<dynamic>();
    itemListItems = new List<dynamic>();
    lokasiListItems = new List<dynamic>();
    merekListItems = new List<dynamic>();
    itemNoListItems = new List<dynamic>();
    dueDateListItems = new List<dynamic>();
    jobdescTimeListItems = new List<dynamic>();
    newScheduleListItems = new List<dynamic>();
    alasanListItems = new List<dynamic>();
    rescheduleByListItems = new List<dynamic>();
    jobdescIDListItems = new List<dynamic>();
    frequencyListItems = new List<dynamic>();
    picListItems = new List<dynamic>();
    for (int i = 0; i < outlet.length; i++) {
      var outletDua = outlet[i];
      var statusDua = status[i];
      var itemDua = item[i];
      var dateDua = date[i];
      var lokasiDua = lokasi[i];
      var merekDua = merek[i];
      var itemNoDua = itemNo[i];
      var dueDateDua = dueDate[i];
      var jobdescTimeDua = jobdescTime[i];
      var newScheduleDua = newSchedule[i];
      var alasanDua = alasan[i];
      var rescheduleByDua = rescheduleBy[i];
      var jobdescIDDua = jobdescID[i];
      var frequencyDua = frequency[i];
      var picDua = pic[i];

      if (outletDua.toLowerCase().contains(_searchText.toLowerCase())) {
        _searchListItems.add(outletDua);
        statusListItems.add(statusDua);
        itemListItems.add(itemDua);
        dateListItems.add(dateDua);
        lokasiListItems.add(lokasiDua);
        merekListItems.add(merekDua);
        itemNoListItems.add(itemNoDua);
        dueDateListItems.add(dueDateDua);
        jobdescTimeListItems.add(jobdescTimeDua);
        newScheduleListItems.add(newScheduleDua);
        alasanListItems.add(alasanDua);
        rescheduleByListItems.add(rescheduleByDua);
        jobdescIDListItems.add(jobdescIDDua);
        frequencyListItems.add(frequencyDua);
        picListItems.add(picDua);
      } else  if (statusDua.toLowerCase().contains(_searchText.toLowerCase())) {
        _searchListItems.add(outletDua);
        statusListItems.add(statusDua);
        itemListItems.add(itemDua);
        dateListItems.add(dateDua);
        lokasiListItems.add(lokasiDua);
        merekListItems.add(merekDua);
        itemNoListItems.add(itemNoDua);
        dueDateListItems.add(dueDateDua);
        jobdescTimeListItems.add(jobdescTimeDua);
        newScheduleListItems.add(newScheduleDua);
        alasanListItems.add(alasanDua);
        rescheduleByListItems.add(rescheduleByDua);
        jobdescIDListItems.add(jobdescIDDua);
        frequencyListItems.add(frequencyDua);
        picListItems.add(picDua);
      } else  if (itemDua.toLowerCase().contains(_searchText.toLowerCase())) {
        _searchListItems.add(outletDua);
        statusListItems.add(statusDua);
        itemListItems.add(itemDua);
        dateListItems.add(dateDua);
        lokasiListItems.add(lokasiDua);
        merekListItems.add(merekDua);
        itemNoListItems.add(itemNoDua);
        dueDateListItems.add(dueDateDua);
        jobdescTimeListItems.add(jobdescTimeDua);
        newScheduleListItems.add(newScheduleDua);
        alasanListItems.add(alasanDua);
        rescheduleByListItems.add(rescheduleByDua);
        jobdescIDListItems.add(jobdescIDDua);
        frequencyListItems.add(frequencyDua);
        picListItems.add(picDua);
      } else  if (lokasiDua.toLowerCase().contains(_searchText.toLowerCase())) {
        _searchListItems.add(outletDua);
        statusListItems.add(statusDua);
        itemListItems.add(itemDua);
        dateListItems.add(dateDua);
        lokasiListItems.add(lokasiDua);
        merekListItems.add(merekDua);
        itemNoListItems.add(itemNoDua);
        dueDateListItems.add(dueDateDua);
        jobdescTimeListItems.add(jobdescTimeDua);
        newScheduleListItems.add(newScheduleDua);
        alasanListItems.add(alasanDua);
        rescheduleByListItems.add(rescheduleByDua);
        jobdescIDListItems.add(jobdescIDDua);
        frequencyListItems.add(frequencyDua);
        picListItems.add(picDua);
      } else  if (merekDua.toLowerCase().contains(_searchText.toLowerCase())) {
        _searchListItems.add(outletDua);
        statusListItems.add(statusDua);
        itemListItems.add(itemDua);
        dateListItems.add(dateDua);
        lokasiListItems.add(lokasiDua);
        merekListItems.add(merekDua);
        itemNoListItems.add(itemNoDua);
        dueDateListItems.add(dueDateDua);
        jobdescTimeListItems.add(jobdescTimeDua);
        newScheduleListItems.add(newScheduleDua);
        alasanListItems.add(alasanDua);
        rescheduleByListItems.add(rescheduleByDua);
        jobdescIDListItems.add(jobdescIDDua);
        frequencyListItems.add(frequencyDua);
        picListItems.add(picDua);
      }
    }
    return _searchAddList(width);
  }

  Widget _searchAddList(width) {
    return new Flexible(
      child: new ListView.builder(
          itemCount: _searchListItems.length,
          itemBuilder: (BuildContext context, int index) {
            Timestamp dateView = dateListItems[index];
            Timestamp dueDateView = dueDateListItems[index];
            Timestamp jobdescTimeView2;
            if (jobdescTimeListItems[index][0] != null) {
              jobdescTimeView2 = jobdescTimeListItems[index][0];
            }
            Timestamp newScheduleView;
            if (newScheduleListItems[index] != null) {
              newScheduleView = newScheduleListItems[index];
            }
            if (statusListItems[index] == 'RESCHEDULE') {
              return Container();
            } else if (statusListItems[index] != 'OPEN') {
              return Container(
                width: width,
                padding: const EdgeInsets.only(right: 5.0, left: 5.0),
                margin: const EdgeInsets.only(bottom: 5.0),
                color: Colors.grey[100],
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: index == statusListItems.length - 1 ? const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0) : const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: width * 0.3,
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    dateView.toDate().toString().substring(8, 10) + '/' + dateView.toDate().toString().substring(5, 7) + '/' +dateView.toDate().toString().substring(0, 4),
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
                                              text: '${_searchListItems[index]}',
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
                                              text: lokasiListItems[index],
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
                                              text: '${merekListItems[index]} - ${itemListItems[index]}',
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
                                              text: '# ${itemNoListItems[index]}',
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
                                    splashColor: statusListItems[index] == 'DONE' ? AbubaPallate.greenabuba : Colors.redAccent,
                                    child: OutlineButton(
                                      borderSide: BorderSide(
                                          color: statusListItems[index] == 'DONE' ? AbubaPallate.greenabuba : Colors.redAccent),
                                      child: Text(
                                        statusListItems[index],
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: statusListItems[index] == 'DONE' ? AbubaPallate.greenabuba : Colors.redAccent),
                                        textAlign: TextAlign.center,
                                      ),
                                      onPressed: () async {
                                        setState(() {
                                          jobdescNameDone.clear();
                                          jobdescNameSkip.clear();
                                          alasanName = '';
                                          rescheduleByName = '';
                                          if (alasanListItems[index] != null) {
                                            Firestore.instance.collection('maintenance_alasan').where('id', isEqualTo: alasanListItems[index]).snapshots().listen((dataAlasan) {
                                              alasanName = dataAlasan.documents[0].data['alasan'];
                                            });
                                          } else {
                                            alasanName = '-';
                                          }

                                          if (rescheduleByListItems[index] != null) {
                                            Firestore.instance.collection('user').where('id', isEqualTo: rescheduleByListItems[index]).snapshots().listen((dataReschedule) {
                                              rescheduleByName = dataReschedule.documents[0].data['nama'];
                                            });
                                          } else {
                                            rescheduleByName = '-';
                                          }

                                          for (int i = 0; i < jobdescIDListItems[index].length; i++) {
                                            // Firestore.instance.collection('maintenance_jobdesc').where('id', isEqualTo: jobdescIDListItems[index][i]).snapshots().listen((data) {
                                              //sini
                                              Timestamp jobdescTimeView = jobdescTimeListItems[index][i];
                                              if (jobdescTimeView.toDate().toString().substring(8, 10) + '/' + jobdescTimeView.toDate().toString().substring(5, 7) + '/' +jobdescTimeView.toDate().toString().substring(0, 4) == dueDateView.toDate().toString().substring(8, 10) + '/' + dueDateView.toDate().toString().substring(5, 7) + '/' +dueDateView.toDate().toString().substring(0, 4)) {
                                                jobdescNameDone.add(jobdescIDListItems[index][i]);
                                              } else {
                                                jobdescNameSkip.add(jobdescIDListItems[index][i]);
                                              }
                                            // });
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
                                                                            padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: <Widget>[
                                                                                Container(
                                                                                  width: width * 0.3,
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
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          _searchListItems[index],
                                                                                          style: TextStyle(
                                                                                              fontSize: 13.0,
                                                                                              color: Colors.black38,
                                                                                              fontWeight: FontWeight.w700
                                                                                          ),
                                                                                          textAlign: TextAlign.right,
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: <Widget>[
                                                                                Container(
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
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
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          lokasiListItems[index],
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
                                                                            padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: <Widget>[
                                                                                Container(
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
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
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          merekListItems[index],
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
                                                                            padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: <Widget>[
                                                                                Container(
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
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
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          itemListItems[index],
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
                                                                            padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: <Widget>[
                                                                                Container(
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
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
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          itemNoListItems[index],
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
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
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
                                                                            padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: <Widget>[
                                                                                Container(
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
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
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          frequencyListItems[index],
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
                                                                            padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: <Widget>[
                                                                                Container(
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
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
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          dueDateView.toDate().toString().substring(8, 10) + '/' + dueDateView.toDate().toString().substring(5, 7) + '/' +dueDateView.toDate().toString().substring(0, 4),
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
                                                                            padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: <Widget>[
                                                                                Container(
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
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
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          picListItems[index],
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
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
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
                                                                            padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
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
                                                                                  alignment: Alignment.centerRight,
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          jobdescNameDone.length == 0 ? '-' : jobdescNameDone.join(', ').toString(),
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
                                                                            padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: <Widget>[
                                                                                Container(
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
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
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          jobdescTimeListItems[index][0] != null
                                                                                              ? jobdescTimeView2.toDate().toString().substring(8, 10) + '/' + jobdescTimeView2.toDate().toString().substring(5, 7) + '/' +jobdescTimeView2.toDate().toString().substring(0, 4)
                                                                                              : '-',
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
                                                                            padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
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
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          jobdescNameSkip.length == 0 ? '-' : jobdescNameSkip.join(', ').toString(),
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
                                                                            padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: <Widget>[
                                                                                Container(
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
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
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          jobdescNameSkip.length == 0 ? '-' : dueDateView.toDate().toString().substring(8, 10) + '/' + dueDateView.toDate().toString().substring(5, 7) + '/' +dueDateView.toDate().toString().substring(0, 4),
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
                                                                            padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: <Widget>[
                                                                                Container(
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
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
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          newScheduleListItems[index] == null ? '-' : newScheduleView.toDate().toString().substring(8, 10) + '/' + newScheduleView.toDate().toString().substring(5, 7) + '/' +newScheduleView.toDate().toString().substring(0, 4),
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
                                                                            padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: <Widget>[
                                                                                Container(
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
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
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          rescheduleByName,
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
                                                                            padding: const EdgeInsets.only(left: 20.0, right: 15.0, bottom: 5.0),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: <Widget>[
                                                                                Container(
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
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
                                                                                  width: MediaQuery.of(context).size.width * 0.3,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                                    children: <Widget>[
                                                                                      Flexible(
                                                                                        child: Text(
                                                                                          alasanName,
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
                ),
              );
            } else {
              return Container();
            }
          }),
    );
  }
}