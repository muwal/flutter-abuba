import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'detail_report.dart';

class KitchenReport extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  KitchenReport({
    this.departmentUser,
    this.idUser,
    this.namaUser,
  });

  _KitchenReportState createState() => _KitchenReportState();
}

class _KitchenReportState extends State<KitchenReport>
    with TickerProviderStateMixin {
  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime dateStart;
  DateTime dateEnd;

  bool showDataFiltered = false;
  bool showHelper = false;
  String helperText = '';

  List<dynamic> pertanyaanKitchen = [];
  List<dynamic> scoreKitchen = [];

  String status;

  List<dynamic> no = [];
  List<bool> buttonView = [];

  String colorStatus;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
                'Kitchen',
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
                padding:
                    const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
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
                              color: showHelper
                                  ? Colors.redAccent
                                  : Colors.black38,
                              fontStyle: showHelper
                                  ? FontStyle.italic
                                  : FontStyle.normal,
                              fontSize: 14.0),
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
                padding: const EdgeInsets.only(
                    top: 10.0, left: 20.0, right: 20.0, bottom: 20.0),
                child: ButtonTheme(
                  minWidth: width / 2.5,
                  height: 40.0,
                  child: RaisedButton(
                    color: Colors.green,
                    child: Text(
                      'SEARCH',
                      style: TextStyle(fontSize: 13.0, color: Colors.white),
                    ),
                    onPressed: () {
                      setState(() {
                        if (dateStart.isAfter(dateEnd) == false) {
                          showDataFiltered = true;
                          showHelper = false;
                          helperText = '';
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
        Container(
          width: width,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              StreamBuilder(
                stream: showDataFiltered
                    ? Firestore.instance
                        .collection('kitchen')
                        .where('dateCreated', isGreaterThanOrEqualTo: dateStart)
                        .orderBy('dateCreated', descending: false)
                        .snapshots()
                    : Firestore.instance
                        .collection('kitchen')
                        .orderBy('dateCreated', descending: false)
                        .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData)
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );

                  for (int i = 0; i < snapshot.data.documents.length; i++) {
                    buttonView.add(false);
                  }

                  return Column(
                    children:
                        List.generate(snapshot.data.documents.length, (index) {
                      Timestamp tanggalStart =
                          snapshot.data.documents[index].data['dateCreated'];
                      DateTime tanggalBantu =
                          DateTime.tryParse(tanggalStart.toDate().toString());
                      status = snapshot.data.documents[index].data['status'];
                      if (showDataFiltered &&
                          dateEnd != null &&
                          dateStart != null) {
                        if (tanggalBantu.isAfter(
                                dateEnd.subtract(Duration(days: -1))) ==
                            true) {
                          return Container();
                        } else {
                          return ListTile(
                            leading: Container(
                              padding: EdgeInsets.only(top: 5.0),
                              alignment: Alignment.centerRight,
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Kitchen No. K-${snapshot.data.documents[index].data['maxid'].toString().padLeft(4, '0')}',
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black54),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            title: Container(
                              alignment: Alignment.centerRight,
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      tanggalStart
                                              .toDate()
                                              .toString()
                                              .substring(8, 10) +
                                          '/' +
                                          tanggalStart
                                              .toDate()
                                              .toString()
                                              .substring(5, 7) +
                                          '/' +
                                          tanggalStart
                                              .toDate()
                                              .toString()
                                              .substring(0, 4),
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black54),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            trailing: GestureDetector(
                              onTap: () async {
                                Firestore.instance
                                    .collection('kitchen')
                                    .document(snapshot
                                        .data.documents[index].documentID)
                                    .snapshots()
                                    .listen((data) {
                                  setState(() {
                                    pertanyaanKitchen = data.data['pertanyaan'];
                                    scoreKitchen = data.data['scorePertanyaan'];
                                  });
                                });

                                setState(() {
                                  buttonView.removeAt(index);
                                  buttonView.insert(index, true);
                                });
                                await new Future.delayed(Duration(seconds: 3));
                                setState(() {
                                  buttonView.removeAt(index);
                                  buttonView.insert(index, false);
                                });

                                Navigator.push(
                                    context,
                                    MyCustomRoute(
                                        builder: (context) => DetailReport(
                                            idUser: widget.idUser,
                                            namaUser: widget.namaUser,
                                            departmentUser:
                                                widget.departmentUser,
                                            index: snapshot.data
                                                .documents[index].documentID,
                                        pertanyaan: pertanyaanKitchen, score: scoreKitchen)));
                              },
                              child: Container(
                                alignment: Alignment.centerRight,
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        buttonView[index]
                                            ? 'Preparing data ...'
                                            : status,
                                        style: TextStyle(
                                            fontSize: 13.0,
                                            color: buttonView[index]
                                                ? Colors.black54
                                                : status == 'Approved' ? AbubaPallate.green : status == 'Rejected' ? AbubaPallate.menuFood : Colors.blue),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      } else {
                        return ListTile(
                          leading: Container(
                            padding: EdgeInsets.only(top: 5.0),
                            alignment: Alignment.centerRight,
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Kitchen No. K-${snapshot.data.documents[index].data['maxid'].toString().padLeft(4, '0')}',
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.black54),
                                  ),
                                )
                              ],
                            ),
                          ),
                          title: Container(
                            alignment: Alignment.centerRight,
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    tanggalStart
                                            .toDate()
                                            .toString()
                                            .substring(8, 10) +
                                        '/' +
                                        tanggalStart
                                            .toDate()
                                            .toString()
                                            .substring(5, 7) +
                                        '/' +
                                        tanggalStart
                                            .toDate()
                                            .toString()
                                            .substring(0, 4),
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.black54),
                                  ),
                                )
                              ],
                            ),
                          ),
                          trailing: GestureDetector(
                            onTap: () async {
                              Firestore.instance
                                  .collection('kitchen')
                                  .document(snapshot
                                  .data.documents[index].documentID)
                                  .snapshots()
                                  .listen((data) {
                                setState(() {
                                  pertanyaanKitchen = data.data['pertanyaan'];
                                  scoreKitchen = data.data['scorePertanyaan'];
                                });
                              });

                              setState(() {
                                buttonView.removeAt(index);
                                buttonView.insert(index, true);
                              });
                              await new Future.delayed(Duration(seconds: 3));
                              setState(() {
                                buttonView.removeAt(index);
                                buttonView.insert(index, false);
                              });

                              Navigator.push(
                                  context,
                                  MyCustomRoute(
                                      builder: (context) => DetailReport(
                                          idUser: widget.idUser,
                                          namaUser: widget.namaUser,
                                          departmentUser: widget.departmentUser,
                                          index: snapshot.data.documents[index]
                                              .documentID,
                                          pertanyaan: pertanyaanKitchen, score: scoreKitchen)));
                            },
                            child: Container(
                              alignment: Alignment.centerRight,
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 30.0,
                              decoration: BoxDecoration(border: Border.all(width: 1.0, color: buttonView[index]
                                  ? Colors.black54
                                  : status == 'Approved' ? AbubaPallate.green : status == 'Rejected' ? AbubaPallate.menuFood : Colors.blue)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      buttonView[index]
                                          ? 'Preparing data ...'
                                          : status,
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          color: buttonView[index]
                                              ? Colors.black54
                                              : status == 'Approved' ? AbubaPallate.green : status == 'Rejected' ? AbubaPallate.menuFood : Colors.blue),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    }).toList(),
                  );
                },
              ),
              /*Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 100.0,
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              '17 January 2018',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black54),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 100.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Department A',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black54),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 100.0,
                      child: ButtonTheme(
                        padding: EdgeInsets.all(0.0),
                        height: 20.0,
                        child: OutlineButton(
                          child: Text(
                            'Report',
                            style: TextStyle(fontSize: 13.0, color: AbubaPallate.menuBluebird),
                          ),
                          borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                          highlightedBorderColor: AbubaPallate.menuBluebird,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MyCustomRoute(
                                    builder: (context) => DetailReport()));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 100.0,
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              '17 January 2018',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black54),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 100.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Department A',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black54),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 100.0,
                      child: ButtonTheme(
                        padding: EdgeInsets.all(0.0),
                        height: 20.0,
                        child: OutlineButton(
                          child: Text(
                            'Report',
                            style: TextStyle(fontSize: 13.0, color: AbubaPallate.menuBluebird),
                          ),
                          borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                          highlightedBorderColor: AbubaPallate.menuBluebird,
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              )*/
            ],
          ),
        )
      ],
    );
  }
}
