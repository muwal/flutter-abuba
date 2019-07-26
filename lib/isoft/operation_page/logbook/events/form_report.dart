import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:intl/intl.dart';

import 'detail_report.dart';

class FormReport extends StatefulWidget {
  @override
  _FormReportState createState() => _FormReportState();
}

class _FormReportState extends State<FormReport> {

  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime dateStart;
  DateTime dateEnd;

  bool showDataFiltered = false;
  bool showHelper = false;
  String helperText = '';
  
  String _mySelection;
  int _shift;
  String _projectSponsorSelection;
  
  List<Map> _shiftJson = [
    {"id": 1, "shift": "Shift A"},
    {"id": 2, "shift": "Shift B"}
  ];

  List<dynamic> dataShift = [];

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
                'Event(s)',
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
                padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: width / 2.5,
                      child: DateTimePickerFormField(
                        format: dateFormat,
                        onChanged: (dt) => setState(() => dateStart = dt),
                        dateOnly: true,
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelStyle: TextStyle(fontSize: 14.0),
                          labelText: 'From'
                        ),
                      ),
                    ),
                    Container(
                      width: width / 2.5,
                      child: DateTimePickerFormField(
                    format: dateFormat,
                    onChanged: (dt) => setState(() => dateEnd = dt),
                    dateOnly: true,
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelStyle: TextStyle(fontSize: 14.0),
                      labelText: 'To'
                    ),
                  ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                child: StreamBuilder(
                  stream: Firestore.instance.collection('shift').orderBy('shift', descending: false).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData)
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );

                    return DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Shift',
                        labelStyle: TextStyle(fontSize: 16.0),
                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select Shift';
                        } else {
                          return null;
                        }
                      },
                      value: _projectSponsorSelection,
                      onChanged: (String value) {
                        setState(() {
                          _projectSponsorSelection = value;
                        });
                      },
                      items: snapshot.data.documents.map((DocumentSnapshot document) {
                        return DropdownMenuItem(
                          value: document['id'].toString(),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: RichText(
                              overflow: TextOverflow.visible,
                              text: TextSpan(
                                text: document['shift'].toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0
                                )
                              ),
                            ),
                          ),
                        );
                      }).toList()
                    );
                  },
                )
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 20.0),
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
                          _shift = int.tryParse(_projectSponsorSelection);
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
          child: StreamBuilder(
            stream: showDataFiltered
                  ? Firestore.instance.collection('group_event').where('date_event', isGreaterThanOrEqualTo: dateStart).orderBy('date_event', descending: false).snapshots()
                  : Firestore.instance.collection('group_event').orderBy('date_event', descending: false).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData)
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );

                return Column(
                  children: List.generate(snapshot.data.documents.length, (index) {
                    Timestamp tanggal = snapshot.data.documents[index].data['date_event'];
                    DateTime tanggalBantu = DateTime.tryParse(snapshot.data.documents[index].data['date_event'].toDate().toString());
                    
                    if (showDataFiltered && dateEnd != null && dateStart != null) {
                        if (tanggalBantu.isAfter(dateEnd.subtract(Duration(days: -1))) == true) {
                          return Container();
                        } else {
                          if (_shift != snapshot.data.documents[index].data['id_shift']) {
                            return Container();
                          } else {
                            if (snapshot.data.documents[index].data['status'] == 'OPEN') {
                              return Padding(
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
                                              tanggal.toDate().toString().substring(8, 10) + '/' + tanggal.toDate().toString().substring(5, 7) + '/' + tanggal.toDate().toString().substring(0, 4),
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
                                              snapshot.data.documents[index].data['shift'],
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
                                                    builder: (context) => DetailReport(acaraID: snapshot.data.documents[index].data['id_shift'], tanggalAcara: snapshot.data.documents[index].data['date_event'] )));
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } 
                            }
                        }
                      } else {
                        // if (snapshot.data.documents[index].data['status'] != 'CLOSE') {
                        //   return Container();
                        // } else {
                         if (snapshot.data.documents[index].data['status'] == 'OPEN') {
                            return Padding(
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
                                            tanggal.toDate().toString().substring(8, 10) + '/' + tanggal.toDate().toString().substring(5, 7) + '/' + tanggal.toDate().toString().substring(0, 4),
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
                                            snapshot.data.documents[index].data['shift'],
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
                                                  builder: (context) => DetailReport(acaraID: snapshot.data.documents[index].data['id_shift'], tanggalAcara: snapshot.data.documents[index].data['date_event'] )));
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                         } else { 
                           return Container();
                         }
                        // }
                      }

                    // return Padding(
                    //   padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: <Widget>[
                    //       Container(
                    //         width: 100.0,
                    //         child: Row(
                    //           children: <Widget>[
                    //             Flexible(
                    //               child: Text(
                    //                 tanggal.toDate().toString().substring(8, 10) + '/' + tanggal.toDate().toString().substring(5, 7) + '/' + tanggal.toDate().toString().substring(0, 4),
                    //                 style: TextStyle(
                    //                     fontSize: 12.0, color: Colors.black54),
                    //               ),
                    //             )
                    //           ],
                    //         ),
                    //       ),
                    //       Container(
                    //         width: 100.0,
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: <Widget>[
                    //             Flexible(
                    //               child: Text(
                    //                 snapshot.data.documents[index].data['shift'],
                    //                 style: TextStyle(
                    //                     fontSize: 12.0, color: Colors.black54),
                    //               ),
                    //             )
                    //           ],
                    //         ),
                    //       ),
                    //       Container(
                    //         width: 100.0,
                    //         child: ButtonTheme(
                    //           padding: EdgeInsets.all(0.0),
                    //           height: 20.0,
                    //           child: OutlineButton(
                    //             child: Text(
                    //               'Report',
                    //               style: TextStyle(fontSize: 13.0, color: AbubaPallate.menuBluebird),
                    //             ),
                    //             borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                    //             highlightedBorderColor: AbubaPallate.menuBluebird,
                    //             onPressed: () {
                    //               Navigator.push(
                    //                   context,
                    //                   MyCustomRoute(
                    //                       builder: (context) => DetailReport(acaraID: snapshot.data.documents[index].data['id_shift'], tanggalAcara: snapshot.data.documents[index].data['date_event'] )));
                    //             },
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // );
                  }).toList()
                );
            },
          ),
        )
      ],
    );
  }
}
