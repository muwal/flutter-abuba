import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormScreen extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  FormScreen({this.idUser, this.namaUser, this.departmentUser});

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> with TickerProviderStateMixin {
  AnimationController animationController;
  List<Map> _listData = [
    {'nomor': '1'},
    {'nomor': '2'},
    {'nomor': '3'},
    {'nomor': '4'},
    {'nomor': '5'},
    {'nomor': '6'},
  ];

  bool _isProccess = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  TextEditingController projectName = TextEditingController();
  TextEditingController descProject = TextEditingController();
  TextEditingController numerik = TextEditingController();

  TextEditingController noteSatu = TextEditingController();
  bool _note1 = false;

  Color _colorLowSe = Colors.grey;
  Color _colorMedSe = Colors.grey;
  Color _colorHighSe = Colors.grey;

  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime tanggal;
  DateTime dateCollected;

  TabController _cardController;

  String _parameterProjectSelection;
  List<Map> _parameterProjectJson = [
    {"id": 1, "parameter": "Complaint"},
    {"id": 2, "parameter": "Waste"},
    {"id": 3, "parameter": "Produktifitas"},
    {"id": 4, "parameter": "Lead Time"},
  ];

  String _scoreSelection;
  List<Map> _scoreJson = [
    {"id": 1},
    {"id": 2},
    {"id": 3},
    {"id": 4},
    {"id": 5},
    {"id": 6},
    {"id": 7},
    {"id": 8},
    {"id": 9},
    {"id": 10},

  ];

  String _scoreDuaSelection;
  List<Map> _scoreDuaJson = [
    {"id": 1},
    {"id": 2},
    {"id": 3},

  ];

  var maxid_dataCollection;
  var index_dataCollection;

  @override
  void initState() {
    super.initState();
    _cardController = new TabController(vsync: this, length: _listData.length);
    Firestore.instance.collection('dumper_maxid').snapshots().listen((data) {
      setState(() {
        maxid_dataCollection =
            data.documents[0].data['maxid_dataCollection'] + 1;
        index_dataCollection = data.documents[0].documentID;
      });
    });

    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(
        from:
            animationController.value == 0.0 ? 1.0 : animationController.value);
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
          child: AnimatedBuilder(
              animation: animationController,
              builder: (_, Widget child) {
                return animationController.isAnimating
                    ? Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Center(
                        child: Form(
                          autovalidate: _autoValidate,
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: TabBarView(
                                    controller: _cardController,
                                    physics: ScrollPhysics(),
                                    children: <Widget>[
                                      ListView(
                                        shrinkWrap: true,
                                        physics: ScrollPhysics(),
                                        children: <Widget>[
                                          PreferredSize(
                                            preferredSize:
                                                Size.fromHeight(55.0),
                                            child: Column(
                                              children: <Widget>[
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 55.0,
                                                  child: Container(
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    10.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Text(
                                                              '1. General Information',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      14.0),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                            ),
                                                            Text(
                                                              '1 of ${_listData.length.toString()}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      14.0),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xFF2F592F))),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            color: Colors.white,
                                            alignment: Alignment.center,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.736,
                                            child: Column(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20.0,
                                                          left: 20.0,
                                                          right: 20.0),
                                                  child: TextFormField(
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    decoration: InputDecoration(
                                                      border:
                                                          UnderlineInputBorder(),
                                                      labelText: 'Nama Project',
                                                      labelStyle: TextStyle(
                                                          fontSize: 16.0),
                                                    ),
                                                    validator: (value) {
                                                      if (value.length < 5) {
                                                        return 'Project name must be more than 5 character';
                                                      } else if (value.length >
                                                          100) {
                                                        return 'Project name mush be less than 100 character';
                                                      } else {
                                                        return null;
                                                      }
                                                    },
                                                    controller: projectName,
                                                    style: TextStyle(
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        color: Colors.black87,
                                                        fontSize: 16.0),
                                                    onSaved: null,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20.0,
                                                          left: 20.0,
                                                          right: 20.0),
                                                  child: TextFormField(
                                                    textCapitalization:
                                                        TextCapitalization
                                                            .sentences,
                                                    decoration: InputDecoration(
                                                      border:
                                                          UnderlineInputBorder(),
                                                      labelText:
                                                          'Deskripsi Project',
                                                      labelStyle: TextStyle(
                                                          fontSize: 16.0),
                                                    ),
                                                    validator: (value) {
                                                      if (value.length < 5) {
                                                        return 'Value name must be more than 5 character';
                                                      } else {
                                                        return null;
                                                      }
                                                    },
                                                    controller: descProject,
                                                    style: TextStyle(
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        color: Colors.black87,
                                                        fontSize: 16.0),
                                                    onSaved: null,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          PreferredSize(
                                            preferredSize: Size.fromHeight(
                                                MediaQuery.of(context)
                                                        .size
                                                        .height -
                                                    55.0 -
                                                    (MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.7)),
                                            child: Column(
                                              children: <Widget>[
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 55.0,
                                                  child: Container(
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    10.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: <Widget>[
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: <
                                                                  Widget>[
                                                                IconButton(
                                                                  splashColor:
                                                                      Colors
                                                                          .transparent,
                                                                  disabledColor:
                                                                      Colors
                                                                          .transparent,
                                                                  highlightColor:
                                                                      Colors
                                                                          .transparent,
                                                                  icon: Icon(
                                                                      Icons
                                                                          .arrow_forward_ios,
                                                                      color: Colors
                                                                          .white),
                                                                  onPressed:
                                                                      () {
                                                                    if (_formKey
                                                                        .currentState
                                                                        .validate()) {
                                                                      setState(
                                                                          () {
                                                                        _autoValidate =
                                                                            false;
                                                                      });
                                                                      _cardController.animateTo(
                                                                          _cardController.index +
                                                                              1);
                                                                      _formKey
                                                                          .currentState
                                                                          .save();
                                                                    } else {
                                                                      setState(
                                                                          () {
                                                                        _autoValidate =
                                                                            true;
                                                                      });
                                                                    }
                                                                  },
                                                                  tooltip:
                                                                      'Next',
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xFF2F592F))),
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
                                            preferredSize:
                                                Size.fromHeight(55.0),
                                            child: Column(
                                              children: <Widget>[
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 55.0,
                                                  child: Container(
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    10.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Text(
                                                              '2. Project Screen',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      14.0),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                            ),
                                                            Text(
                                                              '2 of ${_listData.length.toString()}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      14.0),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xFF2F592F))),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            color: Colors.white,
                                            alignment: Alignment.center,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.690,
                                            margin: EdgeInsets.all(15.0),
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 15.0),
                                                  height: MediaQuery.of(context).size.width,
                                                  child: Column(
                                                    children: <Widget>[
                                                      Flexible(
                                                          child:
                                                              AnimatedBuilder(
                                                        animation:
                                                            animationController,
                                                        builder:
                                                            (_, Widget child) {
                                                          return animationController
                                                                  .isAnimating
                                                              ? Container(
                                                                  child: Center(
                                                                    child:
                                                                        CircularProgressIndicator(),
                                                                  ),
                                                                )
                                                              : StreamBuilder(
                                                                  stream: Firestore.instance.collection('pertanyaanProjectScreen').snapshots(),
                                                                  builder: (BuildContext
                                                                          context,
                                                                      AsyncSnapshot<
                                                                              QuerySnapshot>
                                                                          snapshot) {
                                                                    if (!snapshot
                                                                        .hasData)
                                                                      return Container(
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              CircularProgressIndicator(),
                                                                        ),
                                                                      );

                                                                    var counter = 0;

                                                                    for (var i = 0; i < snapshot
                                                                        .data
                                                                        .documents
                                                                        .length; i++) {
                                                                      counter++;
                                                                    }

                                                                    return ListView
                                                                        .builder(
                                                                      scrollDirection:
                                                                          Axis.horizontal,
                                                                      itemCount: snapshot
                                                                          .data
                                                                          .documents
                                                                          .length,
                                                                      itemBuilder:
                                                                          (BuildContext context,
                                                                              int index) {
                                                                        return Container(
                                                                          width: 300.0,
                                                                          height: MediaQuery.of(context).size.width,
                                                                          margin: EdgeInsets.only(right: 10.0),
                                                                          decoration: BoxDecoration(
                                                                            border: Border(
                                                                              right: BorderSide( //                   <--- left side
                                                                                color: Colors.grey[400],
                                                                                width: 1.0,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          child: Padding(
                                                                            padding: const EdgeInsets.all(10.0),
                                                                            child: Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: <Widget>[
                                                                                Row(
                                                                                  mainAxisAlignment:
                                                                                  MainAxisAlignment
                                                                                      .center,
                                                                                  children: <Widget>[
                                                                                    Flexible(
                                                                                      child: Text(
                                                                                        snapshot.data.documents[index].data['judul'],
                                                                                        style: TextStyle(
                                                                                            fontSize: 22.0,
                                                                                            color: AbubaPallate.greenabuba,
                                                                                            fontWeight:
                                                                                            FontWeight
                                                                                                .w600),
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                  children: <Widget>[
                                                                                    Flexible(
                                                                                      child: Text(
                                                                                          snapshot.data.documents[index].data['pertanyaan'], textAlign: TextAlign.center, style: TextStyle(color: Colors.black45, fontWeight: FontWeight.w600, fontSize: 22.0),
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                  children: <Widget>[
                                                                                    ButtonTheme(
                                                                                      height: 30.0,
                                                                                      child: RaisedButton(
                                                                                        shape:
                                                                                        new RoundedRectangleBorder(
                                                                                          borderRadius:
                                                                                          new BorderRadius
                                                                                              .circular(
                                                                                              5.0),
                                                                                          side:
                                                                                          BorderSide(
                                                                                            width: 1.5,
                                                                                            color: _colorHighSe == Colors.grey ? Colors.redAccent : Colors.white,
                                                                                          ),
                                                                                        ),
                                                                                        child: Text(
                                                                                          'Tidak',
                                                                                          style: TextStyle(
                                                                                              color: _colorHighSe == Colors.grey ? Colors.redAccent : Colors.white),
                                                                                          textAlign:
                                                                                          TextAlign
                                                                                              .center,
                                                                                        ),
                                                                                        color: _colorHighSe == Colors.grey ? Colors.white : Colors.redAccent,
                                                                                        onPressed: () {
                                                                                          setState(() {
                                                                                            _colorLowSe = Colors.grey;
                                                                                            _colorMedSe = Colors.grey;
                                                                                            _colorHighSe = Colors.redAccent;
                                                                                          });
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                    ButtonTheme(
                                                                                      height: 30.0,
                                                                                      child: RaisedButton(
                                                                                        shape:
                                                                                        new RoundedRectangleBorder(
                                                                                          borderRadius:
                                                                                          new BorderRadius
                                                                                              .circular(
                                                                                              5.0),
                                                                                          side:
                                                                                          BorderSide(
                                                                                            width: 1.5,
                                                                                            color: _colorLowSe == Colors.grey ? Colors.green : Colors.white,
                                                                                          ),
                                                                                        ),
                                                                                        child: Text(
                                                                                          'Ya',
                                                                                          style: TextStyle(
                                                                                              color: _colorLowSe == Colors.grey ? Colors.green : Colors.white),
                                                                                          textAlign:
                                                                                          TextAlign
                                                                                              .center,
                                                                                        ),
                                                                                        color: _colorLowSe == Colors.grey ? Colors.white : Colors.green,
                                                                                        onPressed: () {
                                                                                          setState(() {

                                                                                            _colorLowSe = Colors.green[400];
                                                                                            _colorMedSe = Colors.grey;
                                                                                            _colorHighSe = Colors.grey;


                                                                                          });
                                                                                        },
                                                                                      ),
                                                                                    ),

                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    );
                                                                  },
                                                                );
                                                        },
                                                      )),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          PreferredSize(
                                            preferredSize: Size.fromHeight(
                                                MediaQuery.of(context)
                                                        .size
                                                        .height -
                                                    55.0 -
                                                    (MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.7)),
                                            child: Column(
                                              children: <Widget>[
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 55.0,
                                                  child: Container(
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    10.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: <Widget>[
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: <
                                                                  Widget>[
                                                                IconButton(
                                                                  splashColor:
                                                                      Colors
                                                                          .transparent,
                                                                  disabledColor:
                                                                      Colors
                                                                          .transparent,
                                                                  highlightColor:
                                                                      Colors
                                                                          .transparent,
                                                                  icon: Icon(
                                                                      Icons
                                                                          .arrow_back_ios,
                                                                      color: Colors
                                                                          .white),
                                                                  onPressed:
                                                                      () {
                                                                    _cardController
                                                                        .animateTo(
                                                                            _cardController.index -
                                                                                1);
                                                                  },
                                                                  tooltip:
                                                                      'Previous',
                                                                ),
                                                                IconButton(
                                                                  splashColor:
                                                                      Colors
                                                                          .transparent,
                                                                  disabledColor:
                                                                      Colors
                                                                          .transparent,
                                                                  highlightColor:
                                                                      Colors
                                                                          .transparent,
                                                                  icon: Icon(
                                                                      Icons
                                                                          .arrow_forward_ios,
                                                                      color: Colors
                                                                          .white),
                                                                  onPressed:
                                                                      () {
                                                                    if (_formKey
                                                                        .currentState
                                                                        .validate()) {
                                                                      setState(
                                                                          () {
                                                                        _autoValidate =
                                                                            false;
                                                                      });
                                                                      _cardController.animateTo(
                                                                          _cardController.index +
                                                                              1);
                                                                      _formKey
                                                                          .currentState
                                                                          .save();
                                                                    } else {
                                                                      setState(
                                                                          () {
                                                                        _autoValidate =
                                                                            true;
                                                                      });
                                                                    }
                                                                  },
                                                                  tooltip:
                                                                      'Next',
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xFF2F592F))),
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
                                            preferredSize:
                                            Size.fromHeight(55.0),
                                            child: Column(
                                              children: <Widget>[
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 55.0,
                                                  child: Container(
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                            horizontal:
                                                            10.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: <Widget>[
                                                            Text(
                                                              '3. Project Type',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                  14.0),
                                                              textAlign:
                                                              TextAlign
                                                                  .start,
                                                            ),
                                                            Text(
                                                              '3 of ${_listData.length.toString()}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                  14.0),
                                                              textAlign:
                                                              TextAlign
                                                                  .start,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xFF2F592F))),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            color: Colors.white,
                                            alignment: Alignment.center,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.690,
                                            margin: EdgeInsets.all(15.0),
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 15.0),
                                                  height: MediaQuery.of(context).size.width,
                                                  child: Column(
                                                    children: <Widget>[
                                                      Flexible(
                                                          child:
                                                          AnimatedBuilder(
                                                            animation:
                                                            animationController,
                                                            builder:
                                                                (_, Widget child) {
                                                              return animationController
                                                                  .isAnimating
                                                                  ? Container(
                                                                child: Center(
                                                                  child:
                                                                  CircularProgressIndicator(),
                                                                ),
                                                              )
                                                                  : StreamBuilder(
                                                                stream: Firestore.instance.collection('pertanyaanProjectType').snapshots(),
                                                                builder: (BuildContext
                                                                context,
                                                                    AsyncSnapshot<
                                                                        QuerySnapshot>
                                                                    snapshot) {
                                                                  if (!snapshot
                                                                      .hasData)
                                                                    return Container(
                                                                      child:
                                                                      Center(
                                                                        child:
                                                                        CircularProgressIndicator(),
                                                                      ),
                                                                    );

                                                                  var counter = 0;

                                                                  for (var i = 0; i < snapshot
                                                                      .data
                                                                      .documents
                                                                      .length; i++) {
                                                                    counter++;
                                                                  }

                                                                  return ListView
                                                                      .builder(
                                                                    scrollDirection:
                                                                    Axis.horizontal,
                                                                    itemCount: snapshot
                                                                        .data
                                                                        .documents
                                                                        .length,
                                                                    itemBuilder:
                                                                        (BuildContext context,
                                                                        int index) {
                                                                      return Container(
                                                                        width: 300.0,
                                                                        height: MediaQuery.of(context).size.width,
                                                                        margin: EdgeInsets.only(right: 10.0),
                                                                        decoration: BoxDecoration(
                                                                          border: Border(
                                                                            right: BorderSide( //                   <--- left side
                                                                              color: Colors.grey[400],
                                                                              width: 1.0,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        child: Padding(
                                                                          padding: const EdgeInsets.all(10.0),
                                                                          child: Column(
                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                            mainAxisSize: MainAxisSize.min,
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: <Widget>[
                                                                              Row(
                                                                                mainAxisAlignment:
                                                                                MainAxisAlignment
                                                                                    .center,
                                                                                children: <Widget>[
                                                                                  Flexible(
                                                                                    child: Text(
                                                                                      snapshot.data.documents[index].data['judul'],
                                                                                      style: TextStyle(
                                                                                          fontSize: 22.0,
                                                                                          color: AbubaPallate.greenabuba,
                                                                                          fontWeight:
                                                                                          FontWeight
                                                                                              .w600),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                children: <Widget>[
                                                                                  Flexible(
                                                                                    child: Text(
                                                                                      snapshot.data.documents[index].data['pertanyaan'], textAlign: TextAlign.center, style: TextStyle(color: Colors.black45, fontWeight: FontWeight.w600, fontSize: 22.0),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                children: <Widget>[
                                                                                  ButtonTheme(
                                                                                    height: 30.0,
                                                                                    child: RaisedButton(
                                                                                      shape:
                                                                                      new RoundedRectangleBorder(
                                                                                        borderRadius:
                                                                                        new BorderRadius
                                                                                            .circular(
                                                                                            5.0),
                                                                                        side:
                                                                                        BorderSide(
                                                                                          width: 1.5,
                                                                                          color: _colorHighSe == Colors.grey ? Colors.redAccent : Colors.white,
                                                                                        ),
                                                                                      ),
                                                                                      child: Text(
                                                                                        'Tidak',
                                                                                        style: TextStyle(
                                                                                            color: _colorHighSe == Colors.grey ? Colors.redAccent : Colors.white),
                                                                                        textAlign:
                                                                                        TextAlign
                                                                                            .center,
                                                                                      ),
                                                                                      color: _colorHighSe == Colors.grey ? Colors.white : Colors.redAccent,
                                                                                      onPressed: () {
                                                                                        setState(() {
                                                                                          _colorLowSe = Colors.grey;
                                                                                          _colorMedSe = Colors.grey;
                                                                                          _colorHighSe = Colors.redAccent;
                                                                                        });
                                                                                      },
                                                                                    ),
                                                                                  ),
                                                                                  ButtonTheme(
                                                                                    height: 30.0,
                                                                                    child: RaisedButton(
                                                                                      shape:
                                                                                      new RoundedRectangleBorder(
                                                                                        borderRadius:
                                                                                        new BorderRadius
                                                                                            .circular(
                                                                                            5.0),
                                                                                        side:
                                                                                        BorderSide(
                                                                                          width: 1.5,
                                                                                          color: _colorLowSe == Colors.grey ? Colors.green : Colors.white,
                                                                                        ),
                                                                                      ),
                                                                                      child: Text(
                                                                                        'Ya',
                                                                                        style: TextStyle(
                                                                                            color: _colorLowSe == Colors.grey ? Colors.green : Colors.white),
                                                                                        textAlign:
                                                                                        TextAlign
                                                                                            .center,
                                                                                      ),
                                                                                      color: _colorLowSe == Colors.grey ? Colors.white : Colors.green,
                                                                                      onPressed: () {
                                                                                        setState(() {

                                                                                          _colorLowSe = Colors.green[400];
                                                                                          _colorMedSe = Colors.grey;
                                                                                          _colorHighSe = Colors.grey;


                                                                                        });
                                                                                      },
                                                                                    ),
                                                                                  ),

                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                              );
                                                            },
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          PreferredSize(
                                            preferredSize: Size.fromHeight(
                                                MediaQuery.of(context)
                                                    .size
                                                    .height -
                                                    55.0 -
                                                    (MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.7)),
                                            child: Column(
                                              children: <Widget>[
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 55.0,
                                                  child: Container(
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                            horizontal:
                                                            10.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .end,
                                                          children: <Widget>[
                                                            Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                              children: <
                                                                  Widget>[
                                                                IconButton(
                                                                  splashColor:
                                                                  Colors
                                                                      .transparent,
                                                                  disabledColor:
                                                                  Colors
                                                                      .transparent,
                                                                  highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                                  icon: Icon(
                                                                      Icons
                                                                          .arrow_back_ios,
                                                                      color: Colors
                                                                          .white),
                                                                  onPressed:
                                                                      () {
                                                                    _cardController
                                                                        .animateTo(
                                                                        _cardController.index -
                                                                            1);
                                                                  },
                                                                  tooltip:
                                                                  'Previous',
                                                                ),
                                                                IconButton(
                                                                  splashColor:
                                                                  Colors
                                                                      .transparent,
                                                                  disabledColor:
                                                                  Colors
                                                                      .transparent,
                                                                  highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                                  icon: Icon(
                                                                      Icons
                                                                          .arrow_forward_ios,
                                                                      color: Colors
                                                                          .white),
                                                                  onPressed:
                                                                      () {
                                                                    if (_formKey
                                                                        .currentState
                                                                        .validate()) {
                                                                      setState(
                                                                              () {
                                                                            _autoValidate =
                                                                            false;
                                                                          });
                                                                      _cardController.animateTo(
                                                                          _cardController.index +
                                                                              1);
                                                                      _formKey
                                                                          .currentState
                                                                          .save();
                                                                    } else {
                                                                      setState(
                                                                              () {
                                                                            _autoValidate =
                                                                            true;
                                                                          });
                                                                    }
                                                                  },
                                                                  tooltip:
                                                                  'Next',
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xFF2F592F))),
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
                                            preferredSize:
                                            Size.fromHeight(55.0),
                                            child: Column(
                                              children: <Widget>[
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 55.0,
                                                  child: Container(
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                            horizontal:
                                                            10.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: <Widget>[
                                                            Text(
                                                              '4. Clarify the Project Goal',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                  14.0),
                                                              textAlign:
                                                              TextAlign
                                                                  .start,
                                                            ),
                                                            Text(
                                                              '4 of ${_listData.length.toString()}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                  14.0),
                                                              textAlign:
                                                              TextAlign
                                                                  .start,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xFF2F592F))),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            color: Colors.white,
                                            alignment: Alignment.center,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.690,
                                            margin: EdgeInsets.all(15.0),
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 15.0),
                                                  height: MediaQuery.of(context).size.width,
                                                  child: Column(
                                                    children: <Widget>[
                                                      Flexible(
                                                          child:
                                                          AnimatedBuilder(
                                                            animation:
                                                            animationController,
                                                            builder:
                                                                (_, Widget child) {
                                                              return animationController
                                                                  .isAnimating
                                                                  ? Container(
                                                                child: Center(
                                                                  child:
                                                                  CircularProgressIndicator(),
                                                                ),
                                                              )
                                                                  : StreamBuilder(
                                                                stream: Firestore.instance.collection('pertanyaanProjectGoal').orderBy('id', descending: false).snapshots(),
                                                                builder: (BuildContext
                                                                context,
                                                                    AsyncSnapshot<
                                                                        QuerySnapshot>
                                                                    snapshot) {
                                                                  if (!snapshot
                                                                      .hasData)
                                                                    return Container(
                                                                      child:
                                                                      Center(
                                                                        child:
                                                                        CircularProgressIndicator(),
                                                                      ),
                                                                    );

                                                                  var counter = 0;

                                                                  for (var i = 0; i < snapshot
                                                                      .data
                                                                      .documents
                                                                      .length; i++) {
                                                                    counter++;
                                                                  }

                                                                  return ListView
                                                                      .builder(
                                                                    scrollDirection:
                                                                    Axis.horizontal,
                                                                    itemCount: snapshot
                                                                        .data
                                                                        .documents
                                                                        .length,
                                                                    itemBuilder:
                                                                        (BuildContext context,
                                                                        int index) {
                                                                      return Container(
                                                                        width: 300.0,
                                                                        height: MediaQuery.of(context).size.width,
                                                                        margin: EdgeInsets.only(right: 10.0),
                                                                        decoration: BoxDecoration(
                                                                          border: Border(
                                                                            right: BorderSide( //                   <--- left side
                                                                              color: Colors.grey[400],
                                                                              width: 1.0,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        child: Padding(
                                                                          padding: const EdgeInsets.all(10.0),
                                                                          child: Column(
                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                            mainAxisSize: MainAxisSize.min,
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: <Widget>[
                                                                              Row(
                                                                                mainAxisAlignment:
                                                                                MainAxisAlignment
                                                                                    .center,
                                                                                children: <Widget>[
                                                                                  Flexible(
                                                                                    child: Text(
                                                                                      snapshot.data.documents[index].data['judul'],
                                                                                      style: TextStyle(
                                                                                          fontSize: 22.0,
                                                                                          color: AbubaPallate.greenabuba,
                                                                                          fontWeight:
                                                                                          FontWeight
                                                                                              .w600),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                children: <Widget>[
                                                                                  Flexible(
                                                                                    child: Text(
                                                                                      snapshot.data.documents[index].data['pertanyaan'], textAlign: TextAlign.center, style: TextStyle(color: Colors.black45, fontWeight: FontWeight.w600, fontSize: 22.0),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              snapshot.data.documents[index].data['id'] == 2 ?
                                                                              Container(
                                                                                width: 260.0,
                                                                                child: DropdownButtonFormField<String>(
                                                                                  decoration: InputDecoration(
                                                                                    labelText:
                                                                                    'Select value',
                                                                                    labelStyle:
                                                                                    TextStyle(fontSize: 14.0),
                                                                                  ),
                                                                                  validator: (value) {
                                                                                    if (value == null) {
                                                                                      return 'Please select';
                                                                                    } else {
                                                                                      return null;
                                                                                    }
                                                                                  },
                                                                                  value:
                                                                                  _parameterProjectSelection,
                                                                                  onChanged: (String value) {
                                                                                    setState(() {
                                                                                      _parameterProjectSelection =
                                                                                          value;
                                                                                    });
                                                                                  },
                                                                                  items: _parameterProjectJson
                                                                                      .map((Map map) {
                                                                                    return DropdownMenuItem(
                                                                                      value: map['id'].toString(),
                                                                                      child: Text(
                                                                                          map[
                                                                                          'parameter'],
                                                                                          style: TextStyle(
                                                                                              fontSize: 16.0,
                                                                                              color: Colors.black87,
                                                                                              fontStyle:
                                                                                              FontStyle.normal)),
                                                                                    );
                                                                                  }).toList(),
                                                                                ),
                                                                              ) : snapshot.data.documents[index].data['id'] == 3 ?
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: <Widget>[
                                                                                  Container(
                                                                                    width: 130.0,
                                                                                    child: TextFormField(
                                                                                      textCapitalization:
                                                                                      TextCapitalization.sentences,
                                                                                      keyboardType: TextInputType.number,
                                                                                      decoration: InputDecoration(
                                                                                        border: UnderlineInputBorder(),
                                                                                        labelText: 'Numerik',
                                                                                        labelStyle: TextStyle(fontSize: 16.0),
                                                                                      ),
                                                                                      validator: (value) {
                                                                                        if (value.length < 1) {
                                                                                          return 'Value must be fill';
                                                                                        } else {
                                                                                          return null;
                                                                                        }
                                                                                      },
                                                                                      controller: numerik,
                                                                                      style: TextStyle(
                                                                                          fontStyle: FontStyle.normal,
                                                                                          color: Colors.black87,
                                                                                          fontSize: 16.0),
                                                                                      onSaved: null,
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                width: 130.0,
                                                                                child: DropdownButtonFormField<String>(
                                                                                  decoration: InputDecoration(
                                                                                    labelText:
                                                                                    '%, Case, Jam, Menit',
                                                                                    labelStyle:
                                                                                    TextStyle(fontSize: 14.0),
                                                                                  ),
                                                                                  validator: (value) {
                                                                                    if (value == null) {
                                                                                      return 'Please select';
                                                                                    } else {
                                                                                      return null;
                                                                                    }
                                                                                  },
                                                                                  value:
                                                                                  _parameterProjectSelection,
                                                                                  onChanged: (String value) {
                                                                                    setState(() {
                                                                                      _parameterProjectSelection =
                                                                                          value;
                                                                                    });
                                                                                  },
                                                                                  items: _parameterProjectJson
                                                                                      .map((Map map) {
                                                                                    return DropdownMenuItem(
                                                                                      value: map['id'].toString(),
                                                                                      child: Text(
                                                                                          map[
                                                                                          'parameter'],
                                                                                          style: TextStyle(
                                                                                              fontSize: 16.0,
                                                                                              color: Colors.black87,
                                                                                              fontStyle:
                                                                                              FontStyle.normal)),
                                                                                    );
                                                                                  }).toList(),
                                                                                ),
                                                                              )
                                                                                ],
                                                                              ) : snapshot.data.documents[index].data['id'] == 4 ?
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                children: <Widget>[
                                                                                  Container(
                                                                                    width: 130.0,
                                                                                    child: TextFormField(
                                                                                      textCapitalization:
                                                                                      TextCapitalization.sentences,
                                                                                      keyboardType: TextInputType.number,
                                                                                      decoration: InputDecoration(
                                                                                        border: UnderlineInputBorder(),
                                                                                        labelText: 'Numerik',
                                                                                        labelStyle: TextStyle(fontSize: 16.0),
                                                                                      ),
                                                                                      validator: (value) {
                                                                                        if (value.length < 1) {
                                                                                          return 'Value must be fill';
                                                                                        } else {
                                                                                          return null;
                                                                                        }
                                                                                      },
                                                                                      controller: numerik,
                                                                                      style: TextStyle(
                                                                                          fontStyle: FontStyle.normal,
                                                                                          color: Colors.black87,
                                                                                          fontSize: 16.0),
                                                                                      onSaved: null,
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    width: 130.0,
                                                                                    child: DropdownButtonFormField<String>(
                                                                                      decoration: InputDecoration(
                                                                                        labelText:
                                                                                        '%, Case, Jam, Menit',
                                                                                        labelStyle:
                                                                                        TextStyle(fontSize: 14.0),
                                                                                      ),
                                                                                      validator: (value) {
                                                                                        if (value == null) {
                                                                                          return 'Please select';
                                                                                        } else {
                                                                                          return null;
                                                                                        }
                                                                                      },
                                                                                      value:
                                                                                      _parameterProjectSelection,
                                                                                      onChanged: (String value) {
                                                                                        setState(() {
                                                                                          _parameterProjectSelection =
                                                                                              value;
                                                                                        });
                                                                                      },
                                                                                      items: _parameterProjectJson
                                                                                          .map((Map map) {
                                                                                        return DropdownMenuItem(
                                                                                          value: map['id'].toString(),
                                                                                          child: Text(
                                                                                              map[
                                                                                              'parameter'],
                                                                                              style: TextStyle(
                                                                                                  fontSize: 16.0,
                                                                                                  color: Colors.black87,
                                                                                                  fontStyle:
                                                                                                  FontStyle.normal)),
                                                                                        );
                                                                                      }).toList(),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ) :
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                children: <Widget>[
                                                                                  ButtonTheme(
                                                                                    height: 30.0,
                                                                                    child: RaisedButton(
                                                                                      shape:
                                                                                      new RoundedRectangleBorder(
                                                                                        borderRadius:
                                                                                        new BorderRadius
                                                                                            .circular(
                                                                                            5.0),
                                                                                        side:
                                                                                        BorderSide(
                                                                                          width: 1.5,
                                                                                          color: _colorHighSe == Colors.grey ? Colors.redAccent : Colors.white,
                                                                                        ),
                                                                                      ),
                                                                                      child: Text(
                                                                                        'Tidak',
                                                                                        style: TextStyle(
                                                                                            color: _colorHighSe == Colors.grey ? Colors.redAccent : Colors.white),
                                                                                        textAlign:
                                                                                        TextAlign
                                                                                            .center,
                                                                                      ),
                                                                                      color: _colorHighSe == Colors.grey ? Colors.white : Colors.redAccent,
                                                                                      onPressed: () {
                                                                                        setState(() {
                                                                                          _colorLowSe = Colors.grey;
                                                                                          _colorMedSe = Colors.grey;
                                                                                          _colorHighSe = Colors.redAccent;
                                                                                        });
                                                                                      },
                                                                                    ),
                                                                                  ),
                                                                                  ButtonTheme(
                                                                                    height: 30.0,
                                                                                    child: RaisedButton(
                                                                                      shape:
                                                                                      new RoundedRectangleBorder(
                                                                                        borderRadius:
                                                                                        new BorderRadius
                                                                                            .circular(
                                                                                            5.0),
                                                                                        side:
                                                                                        BorderSide(
                                                                                          width: 1.5,
                                                                                          color: _colorLowSe == Colors.grey ? Colors.green : Colors.white,
                                                                                        ),
                                                                                      ),
                                                                                      child: Text(
                                                                                        'Ya',
                                                                                        style: TextStyle(
                                                                                            color: _colorLowSe == Colors.grey ? Colors.green : Colors.white),
                                                                                        textAlign:
                                                                                        TextAlign
                                                                                            .center,
                                                                                      ),
                                                                                      color: _colorLowSe == Colors.grey ? Colors.white : Colors.green,
                                                                                      onPressed: () {
                                                                                        setState(() {

                                                                                          _colorLowSe = Colors.green[400];
                                                                                          _colorMedSe = Colors.grey;
                                                                                          _colorHighSe = Colors.grey;


                                                                                        });
                                                                                      },
                                                                                    ),
                                                                                  ),

                                                                                ],
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                              );
                                                            },
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          PreferredSize(
                                            preferredSize: Size.fromHeight(
                                                MediaQuery.of(context)
                                                    .size
                                                    .height -
                                                    55.0 -
                                                    (MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.7)),
                                            child: Column(
                                              children: <Widget>[
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 55.0,
                                                  child: Container(
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                            horizontal:
                                                            10.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .end,
                                                          children: <Widget>[
                                                            Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                              children: <
                                                                  Widget>[
                                                                IconButton(
                                                                  splashColor:
                                                                  Colors
                                                                      .transparent,
                                                                  disabledColor:
                                                                  Colors
                                                                      .transparent,
                                                                  highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                                  icon: Icon(
                                                                      Icons
                                                                          .arrow_back_ios,
                                                                      color: Colors
                                                                          .white),
                                                                  onPressed:
                                                                      () {
                                                                    _cardController
                                                                        .animateTo(
                                                                        _cardController.index -
                                                                            1);
                                                                  },
                                                                  tooltip:
                                                                  'Previous',
                                                                ),
                                                                IconButton(
                                                                  splashColor:
                                                                  Colors
                                                                      .transparent,
                                                                  disabledColor:
                                                                  Colors
                                                                      .transparent,
                                                                  highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                                  icon: Icon(
                                                                      Icons
                                                                          .arrow_forward_ios,
                                                                      color: Colors
                                                                          .white),
                                                                  onPressed:
                                                                      () {
                                                                    if (_formKey
                                                                        .currentState
                                                                        .validate()) {
                                                                      setState(
                                                                              () {
                                                                            _autoValidate =
                                                                            false;
                                                                          });
                                                                      _cardController.animateTo(
                                                                          _cardController.index +
                                                                              1);
                                                                      _formKey
                                                                          .currentState
                                                                          .save();
                                                                    } else {
                                                                      setState(
                                                                              () {
                                                                            _autoValidate =
                                                                            true;
                                                                          });
                                                                    }
                                                                  },
                                                                  tooltip:
                                                                  'Next',
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xFF2F592F))),
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
                                            preferredSize:
                                            Size.fromHeight(55.0),
                                            child: Column(
                                              children: <Widget>[
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 55.0,
                                                  child: Container(
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                            horizontal:
                                                            10.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: <Widget>[
                                                            Text(
                                                              '5. Organization Level Criteria',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                  14.0),
                                                              textAlign:
                                                              TextAlign
                                                                  .start,
                                                            ),
                                                            Text(
                                                              '5 of ${_listData.length.toString()}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                  14.0),
                                                              textAlign:
                                                              TextAlign
                                                                  .start,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xFF2F592F))),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            color: Colors.white,
                                            alignment: Alignment.center,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.690,
                                            margin: EdgeInsets.all(15.0),
                                            child: ListView(
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 20.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'IMPACT CRITERIA',
                                                          style: TextStyle(
                                                              fontSize: 20.0,
                                                              color: AbubaPallate.greenabuba,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        'Beri nilai ( skala 1 – 10 ) untuk menggambarkan seberapa penting impact yang diberikan kriteria dibawah ini bagi perusahaan Anda ?',
                                                        style: TextStyle(
                                                            fontSize: 14.0,
                                                        ),
                                                          textAlign: TextAlign.center,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 15.0),
                                                  height: MediaQuery.of(context).size.width,
                                                  child: Column(
                                                    children: <Widget>[
                                                      Flexible(
                                                          child:
                                                          AnimatedBuilder(
                                                            animation:
                                                            animationController,
                                                            builder:
                                                                (_, Widget child) {
                                                              return animationController
                                                                  .isAnimating
                                                                  ? Container(
                                                                child: Center(
                                                                  child:
                                                                  CircularProgressIndicator(),
                                                                ),
                                                              )
                                                                  : StreamBuilder(
                                                                stream: Firestore.instance.collection('pertanyaanImpactCriteria').snapshots(),
                                                                builder: (BuildContext
                                                                context,
                                                                    AsyncSnapshot<
                                                                        QuerySnapshot>
                                                                    snapshot) {
                                                                  if (!snapshot
                                                                      .hasData)
                                                                    return Container(
                                                                      child:
                                                                      Center(
                                                                        child:
                                                                        CircularProgressIndicator(),
                                                                      ),
                                                                    );

                                                                  var counter = 0;

                                                                  for (var i = 0; i < snapshot
                                                                      .data
                                                                      .documents
                                                                      .length; i++) {
                                                                    counter++;
                                                                  }

                                                                  return ListView
                                                                      .builder(
                                                                    scrollDirection:
                                                                    Axis.vertical,
                                                                    itemCount: snapshot
                                                                        .data
                                                                        .documents
                                                                        .length,
                                                                    itemBuilder:
                                                                        (BuildContext context,
                                                                        int index) {
                                                                      return Container(
                                                                        width: 200.0,
                                                                        height: 60.0,
                                                                        margin: EdgeInsets.only(right: 10.0),

                                                                        child: Padding(
                                                                          padding: const EdgeInsets.all(10.0),
                                                                          child: Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: <Widget>[
                                                                              Container(
                                                                                width: 150.0,
                                                                                child: Row(
                                                                                  children: <Widget>[
                                                                                    Flexible(
                                                                                      child: Text(snapshot.data.documents[index].data['pertanyaan']),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                width: 120.0,
                                                                                child: DropdownButtonFormField<String>(
                                                                                  decoration: InputDecoration(
                                                                                    labelText:
                                                                                    '1-10',
                                                                                    labelStyle:
                                                                                    TextStyle(fontSize: 14.0),
                                                                                  ),
                                                                                  validator: (value) {
                                                                                    if (value == null) {
                                                                                      return 'Please select';
                                                                                    } else {
                                                                                      return null;
                                                                                    }
                                                                                  },
                                                                                  value:
                                                                                  _scoreSelection,
                                                                                  onChanged: (String value) {
                                                                                    setState(() {
                                                                                      _scoreSelection =
                                                                                          value;
                                                                                    });
                                                                                  },
                                                                                  items: _scoreJson
                                                                                      .map((Map map) {
                                                                                    return DropdownMenuItem(
                                                                                      value: map['id'].toString(),
                                                                                      child: Text(
                                                                                          map[
                                                                                          'id'].toString(),
                                                                                          style: TextStyle(
                                                                                              fontSize: 16.0,
                                                                                              color: Colors.black87,
                                                                                              fontStyle:
                                                                                              FontStyle.normal)),
                                                                                    );
                                                                                  }).toList(),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                              );
                                                            },
                                                          ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 20.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'EFFORT CRITERIA',
                                                          style: TextStyle(
                                                              fontSize: 20.0,
                                                              color: AbubaPallate.greenabuba,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        'Beri nilai ( skala 1 – 10 ) untuk menggambarkan seberapa penting impact yang diberikan kriteria dibawah ini bagi perusahaan Anda ?',
                                                        style: TextStyle(
                                                          fontSize: 14.0,
                                                        ),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 15.0),
                                                  height: MediaQuery.of(context).size.width,
                                                  child: Column(
                                                    children: <Widget>[
                                                      Flexible(
                                                        child:
                                                        AnimatedBuilder(
                                                          animation:
                                                          animationController,
                                                          builder:
                                                              (_, Widget child) {
                                                            return animationController
                                                                .isAnimating
                                                                ? Container(
                                                              child: Center(
                                                                child:
                                                                CircularProgressIndicator(),
                                                              ),
                                                            )
                                                                : StreamBuilder(
                                                              stream: Firestore.instance.collection('pertanyaanEffortCriteria').snapshots(),
                                                              builder: (BuildContext
                                                              context,
                                                                  AsyncSnapshot<
                                                                      QuerySnapshot>
                                                                  snapshot) {
                                                                if (!snapshot
                                                                    .hasData)
                                                                  return Container(
                                                                    child:
                                                                    Center(
                                                                      child:
                                                                      CircularProgressIndicator(),
                                                                    ),
                                                                  );

                                                                var counter = 0;

                                                                for (var i = 0; i < snapshot
                                                                    .data
                                                                    .documents
                                                                    .length; i++) {
                                                                  counter++;
                                                                }

                                                                return ListView
                                                                    .builder(
                                                                  scrollDirection:
                                                                  Axis.vertical,
                                                                  itemCount: snapshot
                                                                      .data
                                                                      .documents
                                                                      .length,
                                                                  itemBuilder:
                                                                      (BuildContext context,
                                                                      int index) {
                                                                    return Container(
                                                                      width: 200.0,
                                                                      height: 60.0,
                                                                      margin: EdgeInsets.only(right: 10.0),
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.all(10.0),
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: <Widget>[
                                                                            Container(
                                                                              width: 150.0,
                                                                              child: Row(
                                                                                children: <Widget>[
                                                                                  Flexible(
                                                                                    child: Text(snapshot.data.documents[index].data['pertanyaan']),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              width: 120.0,
                                                                              child: DropdownButtonFormField<String>(
                                                                                decoration: InputDecoration(
                                                                                  labelText:
                                                                                  '1-10',
                                                                                  labelStyle:
                                                                                  TextStyle(fontSize: 14.0),
                                                                                ),
                                                                                validator: (value) {
                                                                                  if (value == null) {
                                                                                    return 'Please select';
                                                                                  } else {
                                                                                    return null;
                                                                                  }
                                                                                },
                                                                                value:
                                                                                _scoreSelection,
                                                                                onChanged: (String value) {
                                                                                  setState(() {
                                                                                    _scoreSelection =
                                                                                        value;
                                                                                  });
                                                                                },
                                                                                items: _scoreJson
                                                                                    .map((Map map) {
                                                                                  return DropdownMenuItem(
                                                                                    value: map['id'].toString(),
                                                                                    child: Text(
                                                                                        map[
                                                                                        'id'].toString(),
                                                                                        style: TextStyle(
                                                                                            fontSize: 16.0,
                                                                                            color: Colors.black87,
                                                                                            fontStyle:
                                                                                            FontStyle.normal)),
                                                                                  );
                                                                                }).toList(),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          PreferredSize(
                                            preferredSize: Size.fromHeight(
                                                MediaQuery.of(context)
                                                    .size
                                                    .height -
                                                    55.0 -
                                                    (MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.7)),
                                            child: Column(
                                              children: <Widget>[
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 55.0,
                                                  child: Container(
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                            horizontal:
                                                            10.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .end,
                                                          children: <Widget>[
                                                            Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                              children: <
                                                                  Widget>[
                                                                IconButton(
                                                                  splashColor:
                                                                  Colors
                                                                      .transparent,
                                                                  disabledColor:
                                                                  Colors
                                                                      .transparent,
                                                                  highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                                  icon: Icon(
                                                                      Icons
                                                                          .arrow_back_ios,
                                                                      color: Colors
                                                                          .white),
                                                                  onPressed:
                                                                      () {
                                                                    _cardController
                                                                        .animateTo(
                                                                        _cardController.index -
                                                                            1);
                                                                  },
                                                                  tooltip:
                                                                  'Previous',
                                                                ),
                                                                IconButton(
                                                                  splashColor:
                                                                  Colors
                                                                      .transparent,
                                                                  disabledColor:
                                                                  Colors
                                                                      .transparent,
                                                                  highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                                  icon: Icon(
                                                                      Icons
                                                                          .arrow_forward_ios,
                                                                      color: Colors
                                                                          .white),
                                                                  onPressed:
                                                                      () {
                                                                    if (_formKey
                                                                        .currentState
                                                                        .validate()) {
                                                                      setState(
                                                                              () {
                                                                            _autoValidate =
                                                                            false;
                                                                          });
                                                                      _cardController.animateTo(
                                                                          _cardController.index +
                                                                              1);
                                                                      _formKey
                                                                          .currentState
                                                                          .save();
                                                                    } else {
                                                                      setState(
                                                                              () {
                                                                            _autoValidate =
                                                                            true;
                                                                          });
                                                                    }
                                                                  },
                                                                  tooltip:
                                                                  'Next',
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xFF2F592F))),
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
                                            preferredSize:
                                            Size.fromHeight(55.0),
                                            child: Column(
                                              children: <Widget>[
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 55.0,
                                                  child: Container(
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                            horizontal:
                                                            10.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: <Widget>[
                                                            Text(
                                                              '6. Project Performance Criteria',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                  14.0),
                                                              textAlign:
                                                              TextAlign
                                                                  .start,
                                                            ),
                                                            Text(
                                                              '6 of ${_listData.length.toString()}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                  14.0),
                                                              textAlign:
                                                              TextAlign
                                                                  .start,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xFF2F592F))),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            color: Colors.white,
                                            alignment: Alignment.center,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.690,
                                            margin: EdgeInsets.all(15.0),
                                            child: ListView(
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 20.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'IMPACT CRITERIA',
                                                          style: TextStyle(
                                                              fontSize: 20.0,
                                                              color: AbubaPallate.greenabuba,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        'Beri nilai ( skala 1 – 3 ) untuk menggambarkan seberapa penting impact yang diberikan kriteria dibawah ini bagi perusahaan Anda ?',
                                                        style: TextStyle(
                                                          fontSize: 14.0,
                                                        ),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 15.0),
                                                  height: MediaQuery.of(context).size.width,
                                                  child: Column(
                                                    children: <Widget>[
                                                      Flexible(
                                                        child:
                                                        AnimatedBuilder(
                                                          animation:
                                                          animationController,
                                                          builder:
                                                              (_, Widget child) {
                                                            return animationController
                                                                .isAnimating
                                                                ? Container(
                                                              child: Center(
                                                                child:
                                                                CircularProgressIndicator(),
                                                              ),
                                                            )
                                                                : StreamBuilder(
                                                              stream: Firestore.instance.collection('pertanyaanImpactCriteria').snapshots(),
                                                              builder: (BuildContext
                                                              context,
                                                                  AsyncSnapshot<
                                                                      QuerySnapshot>
                                                                  snapshot) {
                                                                if (!snapshot
                                                                    .hasData)
                                                                  return Container(
                                                                    child:
                                                                    Center(
                                                                      child:
                                                                      CircularProgressIndicator(),
                                                                    ),
                                                                  );

                                                                var counter = 0;

                                                                for (var i = 0; i < snapshot
                                                                    .data
                                                                    .documents
                                                                    .length; i++) {
                                                                  counter++;
                                                                }

                                                                return ListView
                                                                    .builder(
                                                                  scrollDirection:
                                                                  Axis.vertical,
                                                                  itemCount: snapshot
                                                                      .data
                                                                      .documents
                                                                      .length,
                                                                  itemBuilder:
                                                                      (BuildContext context,
                                                                      int index) {
                                                                    return Container(
                                                                      width: 200.0,
                                                                      height: 60.0,
                                                                      margin: EdgeInsets.only(right: 10.0),
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.all(10.0),
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: <Widget>[
                                                                            Container(
                                                                              width: 150.0,
                                                                              child: Row(
                                                                                children: <Widget>[
                                                                                  Flexible(
                                                                                    child: Text(snapshot.data.documents[index].data['pertanyaan']),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              width: 120.0,
                                                                              child: DropdownButtonFormField<String>(
                                                                                decoration: InputDecoration(
                                                                                  labelText:
                                                                                  '1-3',
                                                                                  labelStyle:
                                                                                  TextStyle(fontSize: 14.0),
                                                                                ),
                                                                                validator: (value) {
                                                                                  if (value == null) {
                                                                                    return 'Please select';
                                                                                  } else {
                                                                                    return null;
                                                                                  }
                                                                                },
                                                                                value:
                                                                                _scoreDuaSelection,
                                                                                onChanged: (String value) {
                                                                                  setState(() {
                                                                                    _scoreDuaSelection =
                                                                                        value;
                                                                                  });
                                                                                },
                                                                                items: _scoreDuaJson
                                                                                    .map((Map map) {
                                                                                  return DropdownMenuItem(
                                                                                    value: map['id'].toString(),
                                                                                    child: Text(
                                                                                        map[
                                                                                        'id'].toString(),
                                                                                        style: TextStyle(
                                                                                            fontSize: 16.0,
                                                                                            color: Colors.black87,
                                                                                            fontStyle:
                                                                                            FontStyle.normal)),
                                                                                  );
                                                                                }).toList(),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 20.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'EFFORT CRITERIA',
                                                          style: TextStyle(
                                                              fontSize: 20.0,
                                                              color: AbubaPallate.greenabuba,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        'Beri nilai ( skala 1 – 3 ) untuk menggambarkan seberapa penting impact yang diberikan kriteria dibawah ini bagi perusahaan Anda ?',
                                                        style: TextStyle(
                                                          fontSize: 14.0,
                                                        ),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 15.0),
                                                  height: MediaQuery.of(context).size.width,
                                                  child: Column(
                                                    children: <Widget>[
                                                      Flexible(
                                                        child:
                                                        AnimatedBuilder(
                                                          animation:
                                                          animationController,
                                                          builder:
                                                              (_, Widget child) {
                                                            return animationController
                                                                .isAnimating
                                                                ? Container(
                                                              child: Center(
                                                                child:
                                                                CircularProgressIndicator(),
                                                              ),
                                                            )
                                                                : StreamBuilder(
                                                              stream: Firestore.instance.collection('pertanyaanEffortCriteria').snapshots(),
                                                              builder: (BuildContext
                                                              context,
                                                                  AsyncSnapshot<
                                                                      QuerySnapshot>
                                                                  snapshot) {
                                                                if (!snapshot
                                                                    .hasData)
                                                                  return Container(
                                                                    child:
                                                                    Center(
                                                                      child:
                                                                      CircularProgressIndicator(),
                                                                    ),
                                                                  );

                                                                var counter = 0;

                                                                for (var i = 0; i < snapshot
                                                                    .data
                                                                    .documents
                                                                    .length; i++) {
                                                                  counter++;
                                                                }

                                                                return ListView
                                                                    .builder(
                                                                  scrollDirection:
                                                                  Axis.vertical,
                                                                  itemCount: snapshot
                                                                      .data
                                                                      .documents
                                                                      .length,
                                                                  itemBuilder:
                                                                      (BuildContext context,
                                                                      int index) {
                                                                    return Container(
                                                                      width: 200.0,
                                                                      height: 60.0,
                                                                      margin: EdgeInsets.only(right: 10.0),
                                                                      child: Padding(
                                                                        padding: const EdgeInsets.all(10.0),
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: <Widget>[
                                                                            Container(
                                                                              width: 150.0,
                                                                              child: Row(
                                                                                children: <Widget>[
                                                                                  Flexible(
                                                                                    child: Text(snapshot.data.documents[index].data['pertanyaan']),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              width: 120.0,
                                                                              child: DropdownButtonFormField<String>(
                                                                                decoration: InputDecoration(
                                                                                  labelText:
                                                                                  '1-3',
                                                                                  labelStyle:
                                                                                  TextStyle(fontSize: 14.0),
                                                                                ),
                                                                                validator: (value) {
                                                                                  if (value == null) {
                                                                                    return 'Please select';
                                                                                  } else {
                                                                                    return null;
                                                                                  }
                                                                                },
                                                                                value:
                                                                                _scoreDuaSelection,
                                                                                onChanged: (String value) {
                                                                                  setState(() {
                                                                                    _scoreDuaSelection =
                                                                                        value;
                                                                                  });
                                                                                },
                                                                                items: _scoreDuaJson
                                                                                    .map((Map map) {
                                                                                  return DropdownMenuItem(
                                                                                    value: map['id'].toString(),
                                                                                    child: Text(
                                                                                        map[
                                                                                        'id'].toString(),
                                                                                        style: TextStyle(
                                                                                            fontSize: 16.0,
                                                                                            color: Colors.black87,
                                                                                            fontStyle:
                                                                                            FontStyle.normal)),
                                                                                  );
                                                                                }).toList(),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          PreferredSize(
                                            preferredSize: Size.fromHeight(
                                                MediaQuery.of(context)
                                                    .size
                                                    .height -
                                                    55.0 -
                                                    (MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                        0.7)),
                                            child: Column(
                                              children: <Widget>[
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 55.0,
                                                  child: Container(
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                            horizontal:
                                                            10.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .end,
                                                          children: <Widget>[
                                                            Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                              children: <
                                                                  Widget>[
                                                                IconButton(
                                                                  splashColor:
                                                                  Colors
                                                                      .transparent,
                                                                  disabledColor:
                                                                  Colors
                                                                      .transparent,
                                                                  highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                                  icon: Icon(
                                                                      Icons
                                                                          .arrow_back_ios,
                                                                      color: Colors
                                                                          .white),
                                                                  onPressed:
                                                                      () {
                                                                    _cardController
                                                                        .animateTo(
                                                                        _cardController.index -
                                                                            1);
                                                                  },
                                                                  tooltip:
                                                                  'Previous',
                                                                ),
                                                                IconButton(
                                                                  splashColor:
                                                                  Colors
                                                                      .transparent,
                                                                  disabledColor:
                                                                  Colors
                                                                      .transparent,
                                                                  highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                                  icon: Icon(
                                                                      Icons
                                                                          .save,
                                                                      color: Colors
                                                                          .white),
                                                                  onPressed:
                                                                      () {

                                                                  },
                                                                  tooltip:
                                                                  'Next',
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xFF2F592F))),
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
                      );
              }),
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
