import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormDataCollection extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  FormDataCollection({this.idUser, this.namaUser, this.departmentUser});

  @override
  _FormDataCollectionState createState() => _FormDataCollectionState();
}

class _FormDataCollectionState extends State<FormDataCollection>
    with TickerProviderStateMixin {
  List<Map> _listData = [
    {'nomor': '1'},
    {'nomor': '2'},
    {'nomor': '3'}
  ];

  bool _isProccess = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  TextEditingController projectName = TextEditingController();
  TextEditingController performanceMeasure = TextEditingController();
  TextEditingController operationalDefinition = TextEditingController();
  TextEditingController sampleSize = TextEditingController();
  TextEditingController noteDataSource = TextEditingController();
  TextEditingController noteDataLocation = TextEditingController();
  TextEditingController noteWhoCollect = TextEditingController();
  TextEditingController noteHowCollect = TextEditingController();
  TextEditingController noteHowUsed = TextEditingController();
  TextEditingController noteAdditionalCollect = TextEditingController();
  TextEditingController tanggalControl = TextEditingController();

  bool _note1 = false;
  bool _note2 = false;
  bool _note3 = false;
  bool _note4 = false;
  bool _note5 = false;
  bool _note6 = false;

  String _whoSelection;
  String _whoSelection2;
  List<String> _whoSelectedName = [];
  List<int> _whoSelectedID = [];

  String _dataSourceSelection;
  String _dataSource;
  List<Map> _dataSourceJson = [
    {"id": 1, "dataSource": "Source 1"},
    {"id": 2, "dataSource": "Source 2"},
  ];

  String _dataLocationSelection;
  String _dataLocation;
  List<Map> _dataLocationJson = [
    {"id": 1, "dataLocation": "Location 1"},
    {"id": 2, "dataLocation": "Location 2"},
  ];

  String _whoCollectDataSelection;
  String _whoCollectData;
  List<Map> _whoCollectDataJson = [
    {"id": 1, "whoCollectData": "Ridwan"},
    {"id": 2, "whoCollectData": "Sony"},
  ];

  String _howDataCollectedSelection;
  String _howDataCollected;
  List<Map> _howDataCollectedJson = [
    {"id": 1, "howDataCollected": "Daily"},
    {"id": 2, "howDataCollected": "Weekly"},
  ];

  String _dataUsedSelection;
  String _dataUsed;
  List<Map> _dataUsedJson = [
    {"id": 1, "dataUsed": "Statistically"},
    {"id": 2, "dataUsed": "Random"},
  ];

  String _additionalDataCollectedSelection;
  String _additionalDataCollected;
  List<Map> _additionalDataCollectedJson = [
    {"id": 1, "additionalDataCollected": "Revenue"},
    {"id": 2, "additionalDataCollected": "Cost Saving"},
  ];

  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime tanggal;
  DateTime dateCollected;

  TabController _cardController;

  var maxid_dataCollection;
  var index_dataCollection;

  @override
  void initState() {
    super.initState();
    _cardController = new TabController(vsync: this, length: _listData.length);
    Firestore.instance.collection('dumper_maxid').snapshots().listen((data) {
      setState(() {
        maxid_dataCollection= data.documents[0].data['maxid_dataCollection'] + 1;
        index_dataCollection = data.documents[0].documentID;
      });
    });
  }

  @override
  void dispose() {
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _appBar(),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Center(
            child: Form(
              autovalidate: _autoValidate,
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TabBarView(
                        controller: _cardController,
                        physics: NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          ListView(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            children: <Widget>[
                              PreferredSize(
                                preferredSize: Size.fromHeight(55.0),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 55.0,
                                      child: Container(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  '1. General Information',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.0),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  '1 of ${_listData.length.toString()}',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.0),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              color: Color(0xFF2F592F))),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                color: Colors.white,
                                alignment: Alignment.center,
                                height:
                                    MediaQuery.of(context).size.height * 0.736,
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20.0, left: 20.0, right: 20.0),
                                      child: TextFormField(
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText: 'Nama Project',
                                          labelStyle: TextStyle(fontSize: 16.0),
                                        ),
                                        validator: (value) {
                                          if (value.length < 5) {
                                            return 'Project name must be more than 5 character';
                                          } else if (value.length > 100) {
                                            return 'Project name mush be less than 100 character';
                                          } else {
                                            return null;
                                          }
                                        },
                                        controller: projectName,
                                        style: TextStyle(
                                            fontStyle: FontStyle.normal,
                                            color: Colors.black87,
                                            fontSize: 16.0),
                                        onSaved: null,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, left: 20.0, right: 20.0),
                                      child: DateTimePickerFormField(
                                        format: dateFormat,
                                        onChanged: (dt) =>
                                            setState(() => tanggal = dt),
                                        dateOnly: true,
                                        controller: tanggalControl,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black87,
                                        ),
                                        decoration: InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelStyle:
                                                TextStyle(fontSize: 16.0),
                                            labelText: 'Tanggal'),
                                        validator: (value) {
                                          if (value == null) {
                                            return 'Please select date';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, left: 20.0, right: 20.0),
                                        child: StreamBuilder(
                                          stream: Firestore.instance
                                              .collection('user')
                                              .orderBy('nama',
                                                  descending: false)
                                              .snapshots(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<QuerySnapshot>
                                                  snapshot) {
                                            if (!snapshot.hasData)
                                              return Container(
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              );

                                            return DropdownButtonFormField<
                                                    String>(
                                                decoration: InputDecoration(
                                                  labelText: 'Di buat oleh',
                                                  labelStyle:
                                                      TextStyle(fontSize: 16.0),
                                                ),
                                                validator: (value) {
                                                  if (value == null) {
                                                    return 'Please select';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                value: _whoSelection,
                                                onChanged: (String value) {
                                                  setState(() {
                                                    _whoSelection = value;
                                                  });
                                                },
                                                items: snapshot.data.documents
                                                    .map((DocumentSnapshot
                                                        document) {
                                                  return DropdownMenuItem(
                                                    value: document['id']
                                                        .toString(),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(10.0),
                                                      child: RichText(
                                                        overflow: TextOverflow
                                                            .visible,
                                                        text: TextSpan(
                                                            text:
                                                                document['nama']
                                                                    .toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    14.0)),
                                                      ),
                                                    ),
                                                  );
                                                }).toList());
                                          },
                                        )),
                                  ],
                                ),
                              ),
                              PreferredSize(
                                preferredSize: Size.fromHeight(
                                    MediaQuery.of(context).size.height -
                                        55.0 -
                                        (MediaQuery.of(context).size.height *
                                            0.7)),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 55.0,
                                      child: Container(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    IconButton(
                                                      splashColor:
                                                          Colors.transparent,
                                                      disabledColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      icon: Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          color: Colors.white),
                                                      onPressed: () {
                                                        if (_formKey
                                                            .currentState
                                                            .validate()) {
                                                          setState(() {
                                                            _autoValidate =
                                                                false;
                                                          });
                                                          _cardController
                                                              .animateTo(
                                                                  _cardController
                                                                          .index +
                                                                      1);
                                                          _formKey.currentState
                                                              .save();
                                                        } else {
                                                          setState(() {
                                                            _autoValidate =
                                                                true;
                                                          });
                                                        }
                                                      },
                                                      tooltip: 'Next',
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              color: Color(0xFF2F592F))),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          ListView(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            children: <Widget>[
                              PreferredSize(
                                preferredSize: Size.fromHeight(55.0),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 55.0,
                                      child: Container(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  '1. General Information',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.0),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  '2 of ${_listData.length.toString()}',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.0),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              color: Color(0xFF2F592F))),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                color: Colors.white,
                                alignment: Alignment.center,
                                height:
                                    MediaQuery.of(context).size.height * 0.736,
                                child: Column(
                                  children: <Widget>[
                                    ListTile(
                                      title: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 0.0),
                                        child: TextFormField(
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          decoration: InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelText: 'Performance Measure',
                                            labelStyle:
                                                TextStyle(fontSize: 16.0),
                                          ),
                                          validator: (value) {
                                            if (value.length < 10) {
                                              return 'Problem or issue must be more than 10 character';
                                            } else if (value.length > 250) {
                                              return 'Problem or issue mush be less than 250 character';
                                            } else {
                                              return null;
                                            }
                                          },
                                          controller: performanceMeasure,
                                          style: TextStyle(
                                              fontStyle: FontStyle.normal,
                                              color: Colors.black87,
                                              fontSize: 16.0),
                                          onSaved: null,
                                        ),
                                      ),
                                      trailing: IconButton(
                                        icon: Icon(Icons.add,
                                            color: Colors.white),
                                        onPressed: null,
                                      ),
                                    ),
                                    ListTile(
                                      title: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: TextFormField(
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          decoration: InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelText: 'Operational Definition',
                                            labelStyle:
                                                TextStyle(fontSize: 16.0),
                                          ),
                                          validator: (value) {
                                            if (value.length < 10) {
                                              return 'Problem or issue must be more than 10 character';
                                            } else if (value.length > 250) {
                                              return 'Problem or issue mush be less than 250 character';
                                            } else {
                                              return null;
                                            }
                                          },
                                          controller: operationalDefinition,
                                          style: TextStyle(
                                              fontStyle: FontStyle.normal,
                                              color: Colors.black87,
                                              fontSize: 16.0),
                                          onSaved: null,
                                        ),
                                      ),
                                      trailing: IconButton(
                                        icon: Icon(Icons.add,
                                            color: Colors.white),
                                        onPressed: null,
                                      ),
                                    ),
                                    ListTile(
                                      title: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: DropdownButtonFormField<String>(
                                          decoration: InputDecoration(
                                            labelText: 'Data Source',
                                            labelStyle:
                                                TextStyle(fontSize: 16.0),
                                          ),
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Please select';
                                            } else {
                                              return null;
                                            }
                                          },
                                          value: _dataSourceSelection,
                                          onChanged: (String value) {
                                            setState(() {
                                              _dataSourceSelection = value;
                                            });
                                          },
                                          items: _dataSourceJson.map((Map map) {
                                            return DropdownMenuItem(
                                              value: map['id'].toString(),
                                              child: Text(map['dataSource'],
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.black87,
                                                      fontStyle:
                                                          FontStyle.normal)),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      trailing: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 25.0,
                                        child: RaisedButton(
                                          color: AbubaPallate.menuBluebird,
                                          elevation: 0.0,
                                          child: Text(
                                            'Note',
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.white),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _note2 = !_note2;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    _note2
                                        ? Container(
                                            padding: const EdgeInsets.only(
                                                top: 10.0,
                                                left: 20.0,
                                                right: 20.0),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: 'Note',
                                                  labelStyle: TextStyle(
                                                      fontSize: 16.0)),
                                              maxLines: 3,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16.0),
                                              controller: noteDataSource,
                                            ),
                                          )
                                        : Container(),
                                    ListTile(
                                      title: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: DropdownButtonFormField<String>(
                                          decoration: InputDecoration(
                                            labelText: 'Data Location',
                                            labelStyle:
                                                TextStyle(fontSize: 16.0),
                                          ),
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Please select';
                                            } else {
                                              return null;
                                            }
                                          },
                                          value: _dataLocationSelection,
                                          onChanged: (String value) {
                                            setState(() {
                                              _dataLocationSelection = value;
                                            });
                                          },
                                          items:
                                              _dataLocationJson.map((Map map) {
                                            return DropdownMenuItem(
                                              value: map['id'].toString(),
                                              child: Text(map['dataLocation'],
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.black87,
                                                      fontStyle:
                                                          FontStyle.normal)),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      trailing: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 25.0,
                                        child: RaisedButton(
                                          color: AbubaPallate.menuBluebird,
                                          elevation: 0.0,
                                          child: Text(
                                            'Note',
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.white),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _note1 = !_note1;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    _note1
                                        ? Container(
                                            padding: const EdgeInsets.only(
                                                top: 10.0,
                                                left: 20.0,
                                                right: 20.0),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: 'Note',
                                                  labelStyle: TextStyle(
                                                      fontSize: 16.0)),
                                              maxLines: 3,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16.0),
                                              controller: noteDataLocation,
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                              PreferredSize(
                                preferredSize: Size.fromHeight(
                                    MediaQuery.of(context).size.height -
                                        55.0 -
                                        (MediaQuery.of(context).size.height *
                                            0.7)),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 55.0,
                                      child: Container(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    IconButton(
                                                      splashColor:
                                                          Colors.transparent,
                                                      disabledColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      icon: Icon(
                                                          Icons.arrow_back_ios,
                                                          color: Colors.white),
                                                      onPressed: () {
                                                        _cardController
                                                            .animateTo(
                                                                _cardController
                                                                        .index -
                                                                    1);
                                                      },
                                                      tooltip: 'Previous',
                                                    ),
                                                    IconButton(
                                                      splashColor:
                                                          Colors.transparent,
                                                      disabledColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      icon: Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          color: Colors.white),
                                                      onPressed: () {
                                                        if (_formKey
                                                            .currentState
                                                            .validate()) {
                                                          setState(() {
                                                            _autoValidate =
                                                                false;
                                                          });
                                                          _cardController
                                                              .animateTo(
                                                                  _cardController
                                                                          .index +
                                                                      1);
                                                          _formKey.currentState
                                                              .save();
                                                        } else {
                                                          setState(() {
                                                            _autoValidate =
                                                                true;
                                                          });
                                                        }
                                                      },
                                                      tooltip: 'Next',
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              color: Color(0xFF2F592F))),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          ListView(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            children: <Widget>[
                              PreferredSize(
                                preferredSize: Size.fromHeight(55.0),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 55.0,
                                      child: Container(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  '2. Detail Information',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.0),
                                                  textAlign: TextAlign.start,
                                                ),
                                                Text(
                                                  '3 of ${_listData.length.toString()}',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.0),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              color: Color(0xFF2F592F))),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  color: Colors.white,
                                  alignment: Alignment.center,
                                  height: MediaQuery.of(context).size.height *
                                      0.736,
                                  child: ListView(
                                    children: <Widget>[
                                      ListTile(
                                        title: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 15.0),
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              border: UnderlineInputBorder(),
                                              labelText: 'Sample Size',
                                              labelStyle:
                                                  TextStyle(fontSize: 16.0),
                                            ),
                                            validator: (value) {
                                              if (value.length < 1) {
                                                return 'This form can not be null';
                                              } else {
                                                return null;
                                              }
                                            },
                                            controller: sampleSize,
                                            keyboardType: TextInputType.number,
                                            style: TextStyle(
                                                fontStyle: FontStyle.normal,
                                                color: Colors.black87,
                                                fontSize: 16.0),
                                            onSaved: null,
                                          ),
                                        ),
                                        trailing: IconButton(
                                          icon: Icon(Icons.add,
                                              color: Colors.white),
                                          onPressed: null,
                                        ),
                                      ),
                                      ListTile(
                                        title: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: StreamBuilder(
                                            stream: Firestore.instance
                                                .collection('user')
                                                .orderBy('nama',
                                                descending: false)
                                                .snapshots(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<QuerySnapshot>
                                                snapshot) {
                                              if (!snapshot.hasData)
                                                return Container(
                                                  child: Center(
                                                    child:
                                                    CircularProgressIndicator(),
                                                  ),
                                                );

                                              return DropdownButtonFormField<
                                                  String>(
                                                  decoration: InputDecoration(
                                                    labelText: 'Who will collect data',
                                                    labelStyle:
                                                    TextStyle(fontSize: 16.0),
                                                  ),
                                                  validator: (value) {
                                                    if (value == null) {
                                                      return 'Please select';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  value: _whoCollectDataSelection,
                                                  onChanged: (String value) {
                                                    setState(() {
                                                      _whoCollectDataSelection = value;
                                                    });
                                                  },
                                                  items: snapshot.data.documents
                                                      .map((DocumentSnapshot
                                                  document) {
                                                    return DropdownMenuItem(
                                                      value: document['id']
                                                          .toString(),
                                                      child: Padding(
                                                        padding:
                                                        EdgeInsets.all(10.0),
                                                        child: RichText(
                                                          overflow: TextOverflow
                                                              .visible,
                                                          text: TextSpan(
                                                              text:
                                                              document['nama']
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                  14.0)),
                                                        ),
                                                      ),
                                                    );
                                                  }).toList());
                                            },
                                          )

                                        ),
                                        trailing: ButtonTheme(
                                          minWidth: 50.0,
                                          height: 25.0,
                                          child: RaisedButton(
                                            color: AbubaPallate.menuBluebird,
                                            elevation: 0.0,
                                            child: Text(
                                              'Note',
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _note3 = !_note3;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      _note3
                                          ? Container(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0,
                                                  left: 20.0,
                                                  right: 20.0),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    labelText: 'Note',
                                                    labelStyle: TextStyle(
                                                        fontSize: 16.0)),
                                                maxLines: 3,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16.0),
                                                controller: noteWhoCollect,
                                              ),
                                            )
                                          : Container(),
                                      ListTile(
                                        title: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: DateTimePickerFormField(
                                            format: dateFormat,
                                            onChanged: (dt) => setState(
                                                () => dateCollected = dt),
                                            dateOnly: true,
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black87,
                                            ),
                                            decoration: InputDecoration(
                                                border: UnderlineInputBorder(),
                                                labelStyle:
                                                    TextStyle(fontSize: 16.0),
                                                labelText:
                                                    'When will data be collected'),
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Please select date';
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ),
                                        trailing: IconButton(
                                          icon: Icon(Icons.add,
                                              color: Colors.white),
                                          onPressed: null,
                                        ),
                                      ),
                                      ListTile(
                                        title: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child:
                                              DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              labelText:
                                                  'How will data be collected',
                                              labelStyle:
                                                  TextStyle(fontSize: 16.0),
                                            ),
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Please select';
                                              } else {
                                                return null;
                                              }
                                            },
                                            value: _howDataCollectedSelection,
                                            onChanged: (String value) {
                                              setState(() {
                                                _howDataCollectedSelection =
                                                    value;
                                              });
                                            },
                                            items: _howDataCollectedJson
                                                .map((Map map) {
                                              return DropdownMenuItem(
                                                value: map['id'].toString(),
                                                child: Text(
                                                    map['howDataCollected'],
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.black87,
                                                        fontStyle:
                                                            FontStyle.normal)),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        trailing: ButtonTheme(
                                          minWidth: 50.0,
                                          height: 25.0,
                                          child: RaisedButton(
                                            color: AbubaPallate.menuBluebird,
                                            elevation: 0.0,
                                            child: Text(
                                              'Note',
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _note4 = !_note4;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      _note4
                                          ? Container(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0,
                                                  left: 20.0,
                                                  right: 20.0),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    labelText: 'Note',
                                                    labelStyle: TextStyle(
                                                        fontSize: 16.0)),
                                                maxLines: 3,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16.0),
                                                controller: noteHowCollect,
                                              ),
                                            )
                                          : Container(),
                                      ListTile(
                                        title: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child:
                                              DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              labelText:
                                                  'How will data be used',
                                              labelStyle:
                                                  TextStyle(fontSize: 16.0),
                                            ),
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Please select';
                                              } else {
                                                return null;
                                              }
                                            },
                                            value: _dataUsedSelection,
                                            onChanged: (String value) {
                                              setState(() {
                                                _dataUsedSelection = value;
                                              });
                                            },
                                            items: _dataUsedJson.map((Map map) {
                                              return DropdownMenuItem(
                                                value: map['id'].toString(),
                                                child: Text(map['dataUsed'],
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.black87,
                                                        fontStyle:
                                                            FontStyle.normal)),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        trailing: ButtonTheme(
                                          minWidth: 50.0,
                                          height: 25.0,
                                          child: RaisedButton(
                                            color: AbubaPallate.menuBluebird,
                                            elevation: 0.0,
                                            child: Text(
                                              'Note',
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _note5 = !_note5;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      _note5
                                          ? Container(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0,
                                                  left: 20.0,
                                                  right: 20.0),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    labelText: 'Note',
                                                    labelStyle: TextStyle(
                                                        fontSize: 16.0)),
                                                maxLines: 3,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16.0),
                                                controller: noteHowUsed,
                                              ),
                                            )
                                          : Container(),
                                      ListTile(
                                        title: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10.0, bottom: 10.0),
                                          child:
                                              DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              labelText:
                                                  'Additional data to be collected',
                                              labelStyle:
                                                  TextStyle(fontSize: 16.0),
                                            ),
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Please select';
                                              } else {
                                                return null;
                                              }
                                            },
                                            value:
                                                _additionalDataCollectedSelection,
                                            onChanged: (String value) {
                                              setState(() {
                                                _additionalDataCollectedSelection =
                                                    value;
                                              });
                                            },
                                            items: _additionalDataCollectedJson
                                                .map((Map map) {
                                              return DropdownMenuItem(
                                                value: map['id'].toString(),
                                                child: Text(
                                                    map[
                                                        'additionalDataCollected'],
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.black87,
                                                        fontStyle:
                                                            FontStyle.normal)),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        trailing: ButtonTheme(
                                          minWidth: 50.0,
                                          height: 25.0,
                                          child: RaisedButton(
                                            color: AbubaPallate.menuBluebird,
                                            elevation: 0.0,
                                            child: Text(
                                              'Note',
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _note6 = !_note6;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      _note6
                                          ? Container(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0,
                                                  bottom: 10.0,
                                                  left: 20.0,
                                                  right: 20.0),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    labelText: 'Note',
                                                    labelStyle: TextStyle(
                                                        fontSize: 16.0)),
                                                maxLines: 3,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16.0),
                                                controller: noteAdditionalCollect,
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  )),
                              PreferredSize(
                                preferredSize: Size.fromHeight(
                                    MediaQuery.of(context).size.height -
                                        55.0 -
                                        (MediaQuery.of(context).size.height *
                                            0.7)),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 55.0,
                                      child: Container(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    IconButton(
                                                      splashColor:
                                                          Colors.transparent,
                                                      disabledColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      icon: Icon(
                                                          Icons.arrow_back_ios,
                                                          color: Colors.white),
                                                      onPressed: () {
                                                        _cardController
                                                            .animateTo(
                                                                _cardController
                                                                        .index -
                                                                    1);
                                                      },
                                                      tooltip: 'Previous',
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0,
                                                              right: 10.0),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          if (_formKey
                                                              .currentState
                                                              .validate()) {
                                                            setState(() {
                                                              _isProccess =
                                                                  true;
                                                              _autoValidate =
                                                                  false;
                                                            });

                                                            _formKey.currentState.save();

                                                            DocumentReference docReference = Firestore.instance.collection('dataCollection').document();

                                                            docReference.setData({
                                                              'userCreated': widget.idUser,
                                                              'dataCollectionNo':maxid_dataCollection,
                                                              'dateCreated': DateTime.now(),
                                                              'projectName':projectName.text,
                                                              'date': tanggal,
                                                              'createdBy': int.tryParse(_whoSelection),
                                                              'performanceMeasure':performanceMeasure.text,
                                                              'operationalDefinition':operationalDefinition.text,
                                                              'dataSource': int.tryParse(_dataSourceSelection),
                                                              'noteDataSource':noteDataSource.text,
                                                              'dataLocation':int.tryParse(_dataLocationSelection),
                                                              'noteDataLocation':noteDataLocation.text,
                                                              'sampleSize':int.tryParse(sampleSize.text),
                                                              'whoCollectData':int.tryParse(_whoCollectDataSelection),
                                                              'noteCollectData':noteWhoCollect.text,
                                                              'whenCollect': dateCollected,
                                                              'howDataCollected':int.tryParse(_howDataCollectedSelection),
                                                              'noteDataCollected':noteHowCollect.text,
                                                              'howDataUsed':int.tryParse(_dataUsedSelection),
                                                              'noteDataUsed':noteHowUsed.text,
                                                              'additionalData':int.tryParse(_additionalDataCollectedSelection),
                                                              'noteAdditionalData':noteAdditionalCollect.text,
                                                            }).then((doc) {
                                                              setState(() {
                                                                _isProccess =
                                                                false;
                                                              });
                                                              DocumentReference documentReference =Firestore.instance.collection('dumper_maxid').document(index_dataCollection);

                                                              documentReference.updateData({
                                                                'maxid_dataCollection':maxid_dataCollection
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
                                                                              'Project',
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
                                                              _autoValidate =
                                                                  true;
                                                            });
                                                          }
                                                        },
                                                        child: Tooltip(
                                                            message: 'Save',
                                                            child:
                                                                _isProccess
                                                                ? SizedBox(
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                      valueColor: AlwaysStoppedAnimation<
                                                                              Color>(
                                                                          Colors
                                                                              .white),
                                                                      strokeWidth:
                                                                          2.0,
                                                                    ),
                                                                    height:
                                                                        25.0,
                                                                    width: 25.0,
                                                                  )
                                                                :
                                                                Icon(Icons.save,
                                                                    color: Colors
                                                                        .white)),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              color: Color(0xFF2F592F))),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ),
//        bottomNavigationBar: _bottomBar(),
      ),
    );
  }

  /*Widget _bottomBar() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 55.0,
      child: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () {
                        _cardController.animateTo(_cardController.index - 1);
                      },
                      tooltip: 'Previous',
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            _autoValidate = false;
                          });
                          _cardController.animateTo(_cardController.index + 1);
                          _formKey.currentState.save();
                        } else {
                          setState(() {
                            _autoValidate = true;
                          });
                        }
                      },
                      tooltip: 'Next',
                    ),
                  ],
                )
              ],
            ),
          ),
          decoration: BoxDecoration(color: Color(0xFF2F592F))),
    );
  }*/

  Widget _appBar() {
    return AppBar(
      elevation: 0.25,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      title: Image.asset(
        'assets/images/logo2.png',
        height: 150.0,
        width: 120.0,
      ),
    );
  }
}
