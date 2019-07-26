import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'material/form_material.dart';

class BerandaEvaluation extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;

  BerandaEvaluation({this.idUser, this.namaUser, this.departmentUser});

  @override
  _BerandaEvaluationState createState() => _BerandaEvaluationState();
}

class _BerandaEvaluationState extends State<BerandaEvaluation> {
  List<dynamic> supplierID = [];
  List<String> supplierName = [];
  List<dynamic> supplierKode = [];

  @override
  Widget build(BuildContext context) {
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
        body: _buildIsoMenu(),
      ),
    );
  }

  Widget _buildIsoMenu() {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Purchasing',
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
                  'Evaluation',
                  style:
                  TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return CheckboxDua(
                        departmentUser: widget.departmentUser,
                        idUser: widget.idUser,
                        namaUser: widget.namaUser,
                        onResult: (finalResult) {
                          if (finalResult != null) {
                            print(finalResult);
                          } else {
                            print('kosong');
                          }
                        },
                      );
                    },
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 70.0,
                      width: 70.0,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                              color: Colors.grey, width: 1.0),
                          borderRadius:
                          BorderRadius.all(Radius.circular(18.0)
                          )
                      ),
                      child: Icon(MdiIcons.heart,size: 25.0, color: Colors.grey),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Material',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {

                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 70.0,
                      width: 70.0,
                      child: Icon(MdiIcons.heart, size: 25.0, color: Colors.grey),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                              color: Colors.grey, width: 1.0),
                          borderRadius:
                          BorderRadius.all(Radius.circular(18.0))),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Jasa',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CheckboxDua extends StatefulWidget {
  CheckboxDua({this.onResult, this.departmentUser, this.idUser, this.namaUser});

  final ValueChanged<String> onResult;
  final int idUser;
  final String namaUser;
  final String departmentUser;

  @override
  _CheckboxDuaState createState() => new _CheckboxDuaState();
}

class _CheckboxDuaState extends State<CheckboxDua> {
  String _mySelection;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 250.0,
        child: Column(
          children: <Widget>[
            Container(
              color: AbubaPallate.greenabuba,
              height: 50.0,
              child: Center(
                child: Text(
                  'SUPPLIER',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: Scrollbar(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: StreamBuilder(
                    stream: Firestore.instance.collection('supplier').orderBy('supplier', descending: false).snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData)
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );

                      return DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Supplier',
                          labelStyle: TextStyle(fontSize: 12.0),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select supplier';
                          } else {
                            return null;
                          }
                        },
                        value: _mySelection,
                        onChanged: (String value) {
                          setState(() {
                            _mySelection = value;
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
                                  text: document['supplier'].toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.0
                                  )
                                ),
                              ),
                            ),
                          );
                        }).toList()
                      );
                    },
                  ),
                )
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: RaisedButton(
                      color: Colors.red[300],
                      child: Text(
                        'CANCEL',
                        style: TextStyle(color: Colors.white, fontSize: 12.0),
                      ),
                      onPressed: () {
                        widget.onResult(null);
                        Navigator.of(context).pop();
                      },
                      splashColor: Colors.red[300],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: RaisedButton(
                      color: Colors.green[300],
                      child: Text(
                        'CONFIRM',
                        style: TextStyle(color: Colors.white, fontSize: 12.0),
                      ),
                      onPressed: () {
                        // widget.onResult(_mySelection);
                        Navigator.of(context).pop();
                        Navigator.push(context,
                          MyCustomRoute(
                            builder: (context) => FormMaterial(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser, supplierID: int.tryParse(_mySelection))
                          )
                        );
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
    );
  }
}