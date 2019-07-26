import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'detail_report.dart';

class FormReport extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  FormReport({this.idUser, this.namaUser, this.departmentUser});

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
                'Voice of Customer',
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
                  ? Firestore.instance.collection('voiceCustomer').where('dateCreated', isGreaterThanOrEqualTo: dateStart).orderBy('dateCreated', descending: false).snapshots()
                  : Firestore.instance.collection('voiceCustomer').orderBy('dateCreated', descending: false).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData)
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );

                  return Column(
                    children: List.generate(snapshot.data.documents.length, (index) {
                      Timestamp tanggalStart = snapshot.data.documents[index].data['dateCreated'];
                      DateTime tanggalBantu = DateTime.tryParse(tanggalStart.toDate().toString());
                      if (showDataFiltered && dateEnd != null && dateStart != null) {
                        if (tanggalBantu.isAfter(dateEnd.subtract(Duration(days: -1))) == true) {
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
                                      'Voice of Customer No. VOC-${snapshot.data.documents[index].data['voiceCustomerNo'].toString().padLeft(4, '0')}',
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
                                      tanggalStart.toDate().toString().substring(8, 10) + '/' + tanggalStart.toDate().toString().substring(5, 7) + '/' +tanggalStart.toDate().toString().substring(0, 4),
                                      style: TextStyle(
                                          fontSize: 12.0, color: Colors.black54),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            trailing: Container(
                              alignment: Alignment.centerRight,
                              width: MediaQuery.of(context).size.width * 0.3,
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
                                            builder: (context) => DetailReport(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser, index: snapshot.data.documents[index].documentID)));
                                  },
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
                                    'Voice of Customer No. VOC-${snapshot.data.documents[index].data['voiceCustomerNo'].toString().padLeft(4, '0')}',
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
                                    tanggalStart.toDate().toString().substring(8, 10) + '/' + tanggalStart.toDate().toString().substring(5, 7) + '/' +tanggalStart.toDate().toString().substring(0, 4),
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.black54),
                                  ),
                                )
                              ],
                            ),
                          ),
                          trailing: Container(
                            alignment: Alignment.centerRight,
                            width: MediaQuery.of(context).size.width * 0.3,
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
                                          builder: (context) => DetailReport(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser, index: snapshot.data.documents[index].documentID)));
                                },
                              ),
                            ),
                          ),
                        );
                      }
                    }).toList(),
                  );
                },
              )
            ],
          ),
        )
      ],
    );
  }
}
