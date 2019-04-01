import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FormCreate extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  FormCreate({this.idUser, this.namaUser, this.departmentUser});
  
  @override
  _FormCreateState createState() => _FormCreateState();
}

class _FormCreateState extends State<FormCreate> {
  bool _noteSatu = false;
  bool _noteDua = false;
  bool _noteTiga = false;
  bool _noteEmpat = false;
  bool _noteLima = false;
  bool _noteEnam = false;
  TextEditingController controllerNoteSatu = new TextEditingController();
  TextEditingController controllerNoteDua = new TextEditingController();
  TextEditingController controllerNoteTiga = new TextEditingController();

  TextEditingController controllerNoteEmpat = new TextEditingController();
  TextEditingController controllerNoteLima = new TextEditingController();
  TextEditingController controllerNoteEnam = new TextEditingController();

  final dateFormat = DateFormat("MMMM d, yyyy");

  bool _isProccess = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  File imageWhatsHappening;
  String filenameWhatsHappening;
  String imageSave = '';
  String _problem;
  String _man;
  String _material;
  String _method;
  String _environment;
  String _deskripsi;
  var selectedImage;
  String financialImprovement;
  String financialSaving;
  String quality;
  DateTime dateFinancialImprovement;
  DateTime dateFinancialSaving;
  DateTime dateQuality;

  String financialImprovementHasil;
  String financialSavingHasil;
  String qualityHasil;
  DateTime dateFinancialImprovementHasil;
  DateTime dateFinancialSavingHasil;
  DateTime dateQualityHasil;

  DateTime dateDefine;
  DateTime dateMeasure;
  DateTime dateAnalysis;
  DateTime dateImprove;
  DateTime dateControl;

  var maxid;
  var index;

  @override
  void initState() {
    super.initState();
    Firestore.instance.collection('dumper_creative-idea').snapshots().listen((data) {
      setState(() {
        maxid = data.documents[0].data['maxid'] + 1;
        index = data.documents[0].documentID;
      });
    });
  }

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
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: _buildCreate(context),
        ),
      ),
    );
  }

  Widget _buildCreate(context) {
    return Scrollbar(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Creative Idea',
                  style: TextStyle(color: Colors.black12, fontSize: 12.0),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    '|',
                    style: TextStyle(
                        color: AbubaPallate.greenabuba, fontSize: 12.0),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    'Create',
                    style: TextStyle(
                        color: AbubaPallate.greenabuba, fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(right: 20.0, left: 20.0, top: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Creative Ideas',
                          style: TextStyle(color: AbubaPallate.green),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 0.0, 20.0, 8.0),
                  child: ListTile(
                    onTap: null,
                    leading: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              "https://www.biography.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cg_face%2Cq_auto:good%2Cw_300/MTE5NTU2MzE2NDE4MzExNjkx/jackie-chan-9542080-1-402.jpg"),
                        ),
                      ),
                    ),
                    title: Text(
                      'Ridwan . Outlet Cipete . 2h',
                      style:
                          TextStyle(color: Colors.grey[500], fontSize: 12.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Form(
            autovalidate: _autoValidate,
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Problem',
                                style: TextStyle(color: AbubaPallate.green),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            maxLength: 50,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Problem',
                              labelStyle: TextStyle(fontSize: 12.0),
                              hintText: 'Problem',
                              hintStyle: TextStyle(fontSize: 12.0),
                            ),
                            validator: (value) {
                              if (value.length < 10) {
                                return 'Problem must be more than 10 character';
                              } else if (value.length > 50) {
                                return 'Problem must be less than 50 character';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              _problem = value;
                            },
                            textCapitalization: TextCapitalization.words,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
                        child: GestureDetector(
                          onTap: () async {
                            selectedImage = await ImagePicker.pickImage(source: ImageSource.gallery);
                            setState(() {
                              imageWhatsHappening = selectedImage;
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width - 33,
                            height: 150.0,
                            decoration: BoxDecoration(
                                border: Border.all(width: 1.0, color: Colors.black45)
                            ),
                            child: imageWhatsHappening == null
                              ? Icon(Icons.image, color: Colors.black45, size: 40.0)
                              : Image.file(imageWhatsHappening)
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Akar Masalah',
                                style: TextStyle(color: AbubaPallate.green),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            maxLength: 100,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Man',
                              labelStyle: TextStyle(fontSize: 12.0),
                              hintText: 'Man',
                              hintStyle: TextStyle(fontSize: 12.0),
                            ),
                            validator: (value) {
                              if (value.length < 5) {
                                return 'must be more than 5 character';
                              } else if (value.length > 100) {
                                return 'must be less than 100 character';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              _man = value;
                            },
                            textCapitalization: TextCapitalization.sentences,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            maxLength: 100,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Material',
                              labelStyle: TextStyle(fontSize: 12.0),
                              hintText: 'Material',
                              hintStyle: TextStyle(fontSize: 12.0),
                            ),
                            validator: (value) {
                              if (value.length < 5) {
                                return 'must be more than 5 character';
                              } else if (value.length > 100) {
                                return 'must be less than 100 character';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              _material = value;
                            },
                            textCapitalization: TextCapitalization.sentences,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            maxLength: 100,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Method',
                              labelStyle: TextStyle(fontSize: 12.0),
                              hintText: 'Method',
                              hintStyle: TextStyle(fontSize: 12.0),
                            ),
                            validator: (value) {
                              if (value.length < 5) {
                                return 'must be more than 5 character';
                              } else if (value.length > 100) {
                                return 'must be less than 100 character';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              _method = value;
                            },
                            textCapitalization: TextCapitalization.sentences,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            maxLength: 100,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Environment',
                              labelStyle: TextStyle(fontSize: 12.0),
                              hintText: 'Environment',
                              hintStyle: TextStyle(fontSize: 12.0),
                            ),
                            validator: (value) {
                              if (value.length < 5) {
                                return 'must be more than 5 character';
                              } else if (value.length > 100) {
                                return 'must be less than 100 character';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              _environment = value;
                            },
                            textCapitalization: TextCapitalization.sentences,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Ide',
                                style: TextStyle(color: AbubaPallate.green),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: TextFormField(
                            maxLines: 3,
                            maxLength: 250,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Description',
                              labelStyle: TextStyle(fontSize: 12.0),
                              hintText: 'Description',
                              hintStyle: TextStyle(fontSize: 12.0),
                            ),
                            validator: (value) {
                              if (value.length < 10) {
                                return 'Description must be more than 10 character';
                              } else if (value.length > 250) {
                                return 'Description must be less than 250 character';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              _deskripsi = value;
                            },
                            textCapitalization: TextCapitalization.sentences,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 3.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: 150.0,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Financial Improvement',
                                  labelStyle: TextStyle(fontSize: 12.0),
                                  hintText: 'Financial Improvement',
                                  hintStyle: TextStyle(fontSize: 12.0),
                                ),
                                validator: (value) {
                                  if (value.length == 0 ) {
                                    return 'must be more than 1 character';
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  financialImprovement = value;
                                },
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Container(
                              width: 150.0,
                              child: DateTimePickerFormField(
                                format: dateFormat,
                                onChanged: (dt) => setState(() => dateFinancialImprovement = dt),
                                dateOnly: true,
                                style: TextStyle(fontSize: 14.0, color: Colors.black),
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelStyle: TextStyle(fontSize: 12.0),
                                  labelText: 'Date'
                                ),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Date not valid';
                                  } else {
                                    return null;
                                  }
                                },
                                editable: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            ButtonTheme(
                              minWidth: 30.0,
                              height: 25.0,
                              child: OutlineButton(
                                child: Text(
                                  'Note',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: AbubaPallate.menuBluebird),
                                ),
                                borderSide:
                                    BorderSide(color: AbubaPallate.menuBluebird),
                                onPressed: () {
                                  setState(() {
                                    _noteSatu = !_noteSatu;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                        child: _noteSatu
                          ? Container(
                              width: 330.0,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                controller: controllerNoteSatu,
                                maxLines: 3,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            )
                          : Container(),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 3.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: 150.0,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Financial Saving',
                                  labelStyle: TextStyle(fontSize: 12.0),
                                  hintText: 'Financial Saving',
                                  hintStyle: TextStyle(fontSize: 12.0),
                                ),
                                validator: (value) {
                                  if (value.length == 0 ) {
                                    return 'must be more than 1 character';
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  financialSaving = value;
                                },
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Container(
                              width: 150.0,
                              child: DateTimePickerFormField(
                                format: dateFormat,
                                onChanged: (dt) => setState(() => dateFinancialSaving = dt),
                                dateOnly: true,
                                style: TextStyle(fontSize: 14.0, color: Colors.black),
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelStyle: TextStyle(fontSize: 12.0),
                                  labelText: 'Date'
                                ),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Date not valid';
                                  } else {
                                    return null;
                                  }
                                },
                                editable: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            ButtonTheme(
                              minWidth: 30.0,
                              height: 25.0,
                              child: OutlineButton(
                                child: Text(
                                  'Note',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: AbubaPallate.menuBluebird),
                                ),
                                borderSide:
                                    BorderSide(color: AbubaPallate.menuBluebird),
                                onPressed: () {
                                  setState(() {
                                    _noteDua = !_noteDua;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                        child: _noteDua
                          ? Container(
                              width: 330.0,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                controller: controllerNoteDua,
                                maxLines: 3,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            )
                          : Container(),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 3.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: 150.0,
                              child: TextFormField(
                                maxLength: 100,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: 'Quality',
                                  labelStyle: TextStyle(fontSize: 12.0),
                                  hintText: 'Quality',
                                  hintStyle: TextStyle(fontSize: 12.0),
                                ),
                                textCapitalization: TextCapitalization.sentences,
                                validator: (value) {
                                  if (value.length < 5) {
                                    return 'must be more than 5 character';
                                  } else if (value.length > 100) {
                                    return 'must be less than 100 character';
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  quality = value;
                                },
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Container(
                              width: 150.0,
                              child: DateTimePickerFormField(
                                format: dateFormat,
                                onChanged: (dt) => setState(() => dateQuality = dt),
                                dateOnly: true,
                                style: TextStyle(fontSize: 14.0, color: Colors.black),
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelStyle: TextStyle(fontSize: 12.0),
                                  labelText: 'Date'
                                ),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Date not valid';
                                  } else {
                                    return null;
                                  }
                                },
                                editable: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            ButtonTheme(
                              minWidth: 30.0,
                              height: 25.0,
                              child: OutlineButton(
                                child: Text(
                                  'Note',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: AbubaPallate.menuBluebird),
                                ),
                                borderSide:
                                    BorderSide(color: AbubaPallate.menuBluebird),
                                onPressed: () {
                                  setState(() {
                                    _noteTiga = !_noteTiga;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                        child: _noteTiga
                            ? Container(
                                width: 330.0,
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  controller: controllerNoteTiga,
                                  maxLines: 3,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            : Container(),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Timeline',
                                style: TextStyle(color: AbubaPallate.green),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                        child: Container(
                          child: DateTimePickerFormField(
                            format: dateFormat,
                            onChanged: (dt) => setState(() => dateDefine = dt),
                            dateOnly: true,
                            style: TextStyle(fontSize: 14.0, color: Colors.black),
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelStyle: TextStyle(fontSize: 12.0),
                              labelText: 'Define'
                            ),
                            validator: (value) {
                              if (value == null) {
                                return 'Date not valid';
                              } else {
                                return null;
                              }
                            },
                            editable: false,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                        child: Container(
                          child: DateTimePickerFormField(
                            format: dateFormat,
                            onChanged: (dt) => setState(() => dateMeasure = dt),
                            dateOnly: true,
                            style: TextStyle(fontSize: 14.0, color: Colors.black),
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelStyle: TextStyle(fontSize: 12.0),
                              labelText: 'Measure'
                            ),
                            validator: (value) {
                              if (value == null) {
                                return 'Date not valid';
                              } else {
                                return null;
                              }
                            },
                            editable: false,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                        child: Container(
                          child: DateTimePickerFormField(
                            format: dateFormat,
                            onChanged: (dt) => setState(() => dateAnalysis = dt),
                            dateOnly: true,
                            style: TextStyle(fontSize: 14.0, color: Colors.black),
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelStyle: TextStyle(fontSize: 12.0),
                              labelText: 'Analysis'
                            ),
                            validator: (value) {
                              if (value == null) {
                                return 'Date not valid';
                              } else {
                                return null;
                              }
                            },
                            editable: false,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                        child: Container(
                          child: DateTimePickerFormField(
                            format: dateFormat,
                            onChanged: (dt) => setState(() => dateImprove = dt),
                            dateOnly: true,
                            style: TextStyle(fontSize: 14.0, color: Colors.black),
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelStyle: TextStyle(fontSize: 12.0),
                              labelText: 'Improve'
                            ),
                            validator: (value) {
                              if (value == null) {
                                return 'Date not valid';
                              } else {
                                return null;
                              }
                            },
                            editable: false,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                        child: Container(
                          child: DateTimePickerFormField(
                            format: dateFormat,
                            onChanged: (dt) => setState(() => dateControl = dt),
                            dateOnly: true,
                            style: TextStyle(fontSize: 14.0, color: Colors.black),
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelStyle: TextStyle(fontSize: 12.0),
                              labelText: 'Control'
                            ),
                            validator: (value) {
                              if (value == null) {
                                return 'Date not valid';
                              } else {
                                return null;
                              }
                            },
                            editable: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Hasil',
                                style: TextStyle(color: AbubaPallate.green),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 3.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: 150.0,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Financial Improvement',
                                  labelStyle: TextStyle(fontSize: 12.0),
                                  hintText: 'Financial Improvement',
                                  hintStyle: TextStyle(fontSize: 12.0),
                                ),
                                validator: (value) {
                                  if (value.length == 0 ) {
                                    return 'must be more than 1 character';
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  financialImprovementHasil = value;
                                },
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Container(
                              width: 150.0,
                              child: DateTimePickerFormField(
                                format: dateFormat,
                                onChanged: (dt) => setState(() => dateFinancialImprovementHasil = dt),
                                dateOnly: true,
                                style: TextStyle(fontSize: 14.0, color: Colors.black),
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelStyle: TextStyle(fontSize: 12.0),
                                  labelText: 'Date'
                                ),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Date not valid';
                                  } else {
                                    return null;
                                  }
                                },
                                editable: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            ButtonTheme(
                              minWidth: 30.0,
                              height: 25.0,
                              child: OutlineButton(
                                child: Text(
                                  'Note',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: AbubaPallate.menuBluebird),
                                ),
                                borderSide:
                                    BorderSide(color: AbubaPallate.menuBluebird),
                                onPressed: () {
                                  setState(() {
                                    _noteEmpat = !_noteEmpat;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                        child: _noteEmpat
                            ? Container(
                                width: 330.0,
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  controller: controllerNoteEmpat,
                                  maxLines: 3,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            : Container(),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 3.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: 150.0,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Financial Saving',
                                  labelStyle: TextStyle(fontSize: 12.0),
                                  hintText: 'Financial Saving',
                                  hintStyle: TextStyle(fontSize: 12.0),
                                ),
                                validator: (value) {
                                  if (value.length == 0 ) {
                                    return 'must be more than 1 character';
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  financialSavingHasil = value;
                                },
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Container(
                              width: 150.0,
                              child: DateTimePickerFormField(
                                format: dateFormat,
                                onChanged: (dt) => setState(() => dateFinancialSavingHasil = dt),
                                dateOnly: true,
                                style: TextStyle(fontSize: 14.0, color: Colors.black),
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelStyle: TextStyle(fontSize: 12.0),
                                  labelText: 'Date'
                                ),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Date not valid';
                                  } else {
                                    return null;
                                  }
                                },
                                editable: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            ButtonTheme(
                              minWidth: 30.0,
                              height: 25.0,
                              child: OutlineButton(
                                child: Text(
                                  'Note',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: AbubaPallate.menuBluebird),
                                ),
                                borderSide:
                                    BorderSide(color: AbubaPallate.menuBluebird),
                                onPressed: () {
                                  setState(() {
                                    _noteLima = !_noteLima;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                        child: _noteLima
                            ? Container(
                                width: 330.0,
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  controller: controllerNoteLima,
                                  maxLines: 3,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            : Container(),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 3.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: 150.0,
                              child: TextFormField(
                                maxLength: 100,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: 'Quality',
                                  labelStyle: TextStyle(fontSize: 12.0),
                                  hintText: 'Quality',
                                  hintStyle: TextStyle(fontSize: 12.0),
                                ),
                                textCapitalization: TextCapitalization.sentences,
                                validator: (value) {
                                  if (value.length < 5) {
                                    return 'must be more than 5 character';
                                  } else if (value.length > 100) {
                                    return 'must be less than 100 character';
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (value) {
                                  qualityHasil = value;
                                },
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Container(
                              width: 150.0,
                              child: DateTimePickerFormField(
                                format: dateFormat,
                                onChanged: (dt) => setState(() => dateQualityHasil = dt),
                                dateOnly: true,
                                style: TextStyle(fontSize: 14.0, color: Colors.black),
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelStyle: TextStyle(fontSize: 12.0),
                                  labelText: 'Date'
                                ),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Date not valid';
                                  } else {
                                    return null;
                                  }
                                },
                                editable: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            ButtonTheme(
                              minWidth: 30.0,
                              height: 25.0,
                              child: OutlineButton(
                                child: Text(
                                  'Note',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: AbubaPallate.menuBluebird),
                                ),
                                borderSide:
                                    BorderSide(color: AbubaPallate.menuBluebird),
                                onPressed: () {
                                  setState(() {
                                    _noteEnam = !_noteEnam;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 15.0),
                        child: _noteEnam
                            ? Container(
                                width: 330.0,
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  controller: controllerNoteEnam,
                                  maxLines: 3,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            : Container(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
            child: ButtonTheme(
              minWidth: 50.0,
              height: 40.0,
              child: RaisedButton(
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
                child: _isProccess
                  ? CircularProgressIndicator()
                  : Text(
                      'SAVE',
                      style: TextStyle(
                        fontSize: 13.0,
                        color: Colors.white
                      ),
                    ),
                elevation: 0.0,
                color: _isProccess ? Colors.transparent : Colors.green[500],
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      _isProccess = true;
                    });
                    _formKey.currentState.save();
                    
                    filenameWhatsHappening = basename(imageWhatsHappening.path);

                    StorageReference strRef = FirebaseStorage.instance.ref().child(filenameWhatsHappening);
                    StorageUploadTask uploadTask = strRef.putFile(imageWhatsHappening);

                    var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
                    setState(() {
                      imageSave = downUrl.toString();
                    });
                      
                      DocumentReference docReference = Firestore.instance.collection('creative-idea').document();

                      docReference.setData({
                        'userCreated': widget.namaUser,
                        'userDepartment': widget.departmentUser,
                        'levelCreated': 'staff',
                        'problem':_problem,
                        'man': _man,
                        'material':_material,
                        'method':_method,
                        'environment':_environment,
                        'description': _deskripsi,
                        'financial_improvement':financialImprovement,
                        'dateFinancialImprovement':dateFinancialImprovement,
                        'noteFinancialImprovement':controllerNoteSatu.text,
                        'financial_saving':financialSaving,
                        'dateFinancialSaving':dateFinancialSaving,
                        'noteFinancialSaving':controllerNoteDua.text,
                        'quality':quality,
                        'dateQuality':dateQuality,
                        'noteQuality':controllerNoteTiga.text,
                        'define':dateDefine,
                        'measure':dateMeasure,
                        'analysis':dateAnalysis,
                        'improve':dateImprove,
                        'control':dateControl,
                        'financial_improvement_hasil':financialImprovementHasil,
                        'dateFinancialImprovementHasil':dateFinancialImprovementHasil,
                        'noteFinancialImprovementHasil':controllerNoteEmpat.text,
                        'financial_saving_hasil':financialSavingHasil,
                        'dateFinancialSavingHasil':dateFinancialSavingHasil,
                        'noteFinancialSavingHasil':controllerNoteLima.text,
                        'quality_hasil':qualityHasil,
                        'dateQualityHasil':dateQualityHasil,
                        'noteQualityHasil':controllerNoteEnam.text,
                        'dateCreated': DateTime.now(),
                        'image': imageSave,
                        'status': 'Submited',
                        'likes': [],
                        'comments': [],
                        'creativeIdeaNo': maxid
                      }).then((doc) {
                        setState(() {
                          _isProccess = false;
                        });
                        DocumentReference docReference2 = Firestore.instance.collection('dumper_creative-idea').document(index);

                        docReference2.updateData({
                          'maxid': maxid
                        }).then((doc2) {
                          print('success');
                        }).catchError((error2) {
                          print(error2);
                        });

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
                                        'SUCCESSFUL!',
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
                                      'Data Successfully Saved',
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
                        ).whenComplete(() {
                          Navigator.pop(context);
                        });
                      }).catchError((error) {
                        print(error);
                      });
                  } else {
                    setState(() {
                      _autoValidate = true;
                    });
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
