import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'detail_report.dart';

class FormReport extends StatefulWidget {
  @override
  _FormReportState createState() => _FormReportState();

  final int idUser;
  final String namaUser;
  final String departmentUser;
  FormReport({this.idUser, this.namaUser, this.departmentUser});
}

class _FormReportState extends State<FormReport> {
  String _mySelection;
  String _shift;
  List<Map> _shiftJson = [
    {"id": 1, "shift": "Shift A"},
    {"id": 2, "shift": "Shift B"}
  ];

  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime dateStart;
  DateTime dateEnd;

  var idCollection;

  String userName = '';
  String tanggal = '';
  String waktuStart = '';
  String waktuEnd = '';

  List<dynamic> AreaLuarScore = [];
  List<dynamic> AreaLuarNote = [];
  List<dynamic> DinningAreaScore = [];
  List<dynamic> DinningAreaNote = [];
  List<dynamic> ServiceScore = [];
  List<dynamic> ServiceNote = [];
  List<dynamic> CashierScore = [];
  List<dynamic> CashierNote = [];
  List<dynamic> CashierAccuracyScore = [];
  List<dynamic> CashierAccuracyNote = [];
  List<dynamic> BohScore = [];
  List<dynamic> BohNote = [];
  List<dynamic> WarehouseScore = [];
  List<dynamic> WarehouseNote = [];
  List<dynamic> SocialBlockScore = [];
  List<dynamic> SocialBlockNote = [];
  List<dynamic> PersonalScore = [];
  List<dynamic> PersonalNote = [];
  List<dynamic> FoodCookedScore = [];
  List<dynamic> FoodCookedNote = [];

  double hasilParking = 0;
  double hasilGreeting = 0;
  double hasilSeating = 0;
  double hasilTakingOrder = 0;
  double hasilServingProduct = 0;
  double hasilCleanliness = 0;
  double hasilPreBushing = 0;
  double hasilBilling = 0;
  double hasilThanking = 0;
  double hasilComplaint = 0;
  double hasilServingTime = 0;
  double hasilGrafik = 0;

  List<bool> buttonView = [];
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
                'Line Check Shifting',
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
              /*Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                child: DropdownButtonFormField(
                  hint: Text('Shift', style: TextStyle(fontSize: 14.0)),
                  value: _mySelection,
                  onChanged: (String newValue) {
                    setState(() {
                      switch (int.tryParse(newValue)) {
                        case 1:
                          _shift = 'Shift A';
                          break;
                        case 2:
                          _shift = 'Shift B';
                          break;
                        default:
                          _shift = '-';
                          break;
                      }
                      _mySelection = newValue;
                    });
                  },
                  items: _shiftJson.map((Map map) {
                    return new DropdownMenuItem(
                      value: map['id'].toString(),
                      child: Text(map['shift']),
                    );
                  }).toList(),
                ),
              ),*/
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
                          .collection('linecheck')
                          .where('timeDone', isGreaterThanOrEqualTo: dateStart)
                          .snapshots()
                      : Firestore.instance.collection('linecheck').snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData && snapshot.data == null)
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );

                    for (int i = 0; i < snapshot.data.documents.length; i++) {
                      buttonView.add(false);
                    }

                    return Column(
                      children: List.generate(snapshot.data.documents.length,
                          (index) {
                        DateTime tanggalBantu = DateTime.tryParse(snapshot
                            .data.documents[index].data['timeStart']
                            .toString());
                        return ListTile(
                          onTap: null,
                          title: Container(
                            width: 150.0,
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    snapshot.data.documents[index].data['timeDone'].toString(),
                                    style: TextStyle(fontSize: 14.0, color: Colors.black54, fontWeight: FontWeight.w700),
                                  ),
                                )
                              ],
                            ),
                          ),
                          trailing: GestureDetector(
                            onTap: () async {
                              Firestore.instance.collection('linecheck')
                                  .document(snapshot.data.documents[index].documentID)
                                  .snapshots().listen((data) {
                                    setState(() {
                                      idCollection = data.documentID;
                                      print(idCollection);
                                    });
                              });

                              Navigator.push(context,
                                  MyCustomRoute(
                                      builder: (context) => DetailReport(idCollection: idCollection, idUser: widget.idUser, namaUser: widget.namaUser)
                                  )
                              );
                            },
                            child: Container(
                              width: 150.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Report',
                                      style: TextStyle(
                                          fontSize: 13.0, color: buttonView[index] ? Colors.black54 : Colors.blue),
                                      textAlign: TextAlign.right,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  })
            ],
          ),
        )
      ],
    );
  }
}
