import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormA3Report extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  FormA3Report({this.idUser, this.namaUser, this.departmentUser});

  @override
  _FormA3ReportState createState() => _FormA3ReportState();
}

class _FormA3ReportState extends State<FormA3Report> with TickerProviderStateMixin {
  bool _isProccess = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  List<Map> _listData = [ {'nomor': '1'}, {'nomor': '2'}, {'nomor': '3'}, {'nomor': '4'}, {'nomor': '5'}, {'nomor': '6'}, {'nomor': '7'}];

  String _issueBackgroundSelection;
  String _contextSelection;
  String _whoSelection;
  String _whoSelection2;
  String _whereSelection;
  TextEditingController problemIssue = TextEditingController();
  String importance;
  bool errorImportance = false;
  TextEditingController situation = TextEditingController();
  TextEditingController highligtedProblem = TextEditingController();
  TextEditingController performanceMeasure = TextEditingController();
  TextEditingController problem = TextEditingController();
  TextEditingController cause = TextEditingController();
  TextEditingController fiveWhys = TextEditingController();
  TextEditingController proposed = TextEditingController();
  TextEditingController countermeasure = TextEditingController();
  TextEditingController measurable = TextEditingController();
  TextEditingController what =TextEditingController();
  TextEditingController cost =TextEditingController();
  List<int> who = [];
  List<String> who2 = [];
  TextEditingController measurePlan = TextEditingController();
  TextEditingController marksPlan = TextEditingController();
  TextEditingController schedulePlan = TextEditingController();
  TextEditingController measureResult = TextEditingController();
  TextEditingController marksResult = TextEditingController();
  TextEditingController scheduleResult = TextEditingController();

  Color _colorLowSe = Colors.grey;
  Color _colorMedSe = Colors.grey;
  Color _colorHighSe = Colors.grey;

  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime dateWhen;

  Color _opening = Colors.green;
  Color _middle = Colors.grey;
  bool plan = true;
  bool result = false;

  TabController _cardController;

  var maxid_a3Report;
  var index_a3Report;

  @override
  void initState() {
    super.initState();
    _cardController = new TabController(vsync: this, length: _listData.length);
    Firestore.instance.collection('dumper_a3Report').snapshots().listen((data) {
      setState(() {
        maxid_a3Report = data.documents[0].data['maxid'] + 1;
        index_a3Report = data.documents[0].documentID;
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
        backgroundColor: Color(0xFF2F592F),
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
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '1. Theme',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '1 of ${_listData.length.toString()}',
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(color: Color(0xFF2F592F))
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.7,
                              padding: EdgeInsets.symmetric(vertical: 75.0),
                              color: Colors.white,
                              alignment: Alignment.center,
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Flexible(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                                          child: Text(
                                            'What Are You Trying to Accomplish ?',
                                            style: TextStyle(
                                              color: Color(0xFF2F592F),
                                              fontSize: 32.0,
                                              fontWeight: FontWeight.bold
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                                    child: TextFormField(
                                      textCapitalization: TextCapitalization.sentences,
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelText: 'Problem or Issue',
                                        labelStyle: TextStyle(fontSize: 16.0),
                                      ),
                                      maxLines: 3,
                                      maxLength: 250,
                                      keyboardType: TextInputType.multiline,
                                      validator: (value) {
                                        if (value.length < 10) {
                                          return 'Problem or issue must be more than 10 character';
                                        } else if (value.length > 250) {
                                          return 'Problem or issue must be less than 250 character';
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller: problemIssue,
                                      style: TextStyle(
                                        fontStyle: FontStyle.normal,
                                        color: Colors.black87,
                                        fontSize: 16.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            PreferredSize(
                              preferredSize: Size.fromHeight(MediaQuery.of(context).size.height - 55.0 - (MediaQuery.of(context).size.height * 0.7)),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
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
                                                  splashColor: Colors.transparent,
                                                  disabledColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
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
                                      decoration: BoxDecoration(color: Color(0xFF2F592F))
                                    ),
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
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '2. Background',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '2 of ${_listData.length.toString()}',
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(color: Color(0xFF2F592F))
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.7,
                              color: Colors.white,
                              alignment: Alignment.center,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                                    child: StreamBuilder(
                                      stream: Firestore.instance.collection('issueBackground').orderBy('issue', descending: false).snapshots(),
                                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (!snapshot.hasData)
                                          return Container(
                                            child: Center(
                                              child: CircularProgressIndicator(),
                                            ),
                                          );

                                        return DropdownButtonFormField<String>(
                                          // isExpanded: true,
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Please select issue background';
                                            } else {
                                              return null;
                                            }
                                          },
                                          hint: Text('Issue Background', style: TextStyle(fontSize: 16.0)),
                                          value: _issueBackgroundSelection,
                                          onChanged: (String newValue) {
                                            setState(() {
                                              _issueBackgroundSelection = newValue;
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
                                                    text: document['issue'].toString(),
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
                                    padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                                    child: StreamBuilder(
                                      stream: Firestore.instance.collection('context').orderBy('context', descending: false).snapshots(),
                                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (!snapshot.hasData)
                                          return Container(
                                            child: Center(
                                              child: CircularProgressIndicator(),
                                            ),
                                          );

                                        return DropdownButtonFormField<String>(
                                          // isExpanded: true,
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Please select context';
                                            } else {
                                              return null;
                                            }
                                          },
                                          hint: Text('Context', style: TextStyle(fontSize: 16.0)),
                                          value: _contextSelection,
                                          onChanged: (String newValue) {
                                            setState(() {
                                              _contextSelection = newValue;
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
                                                    text: document['context'].toString(),
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
                                    padding: const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Importance',
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 16.0
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(top: 5.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              ButtonTheme(
                                                height: 30.0,
                                                child: OutlineButton(
                                                  child: Text(
                                                    'Low',
                                                    style: TextStyle(
                                                      color: _colorLowSe,
                                                      fontSize: 16.0
                                                    ),
                                                  ),
                                                  borderSide: BorderSide(
                                                    color: _colorLowSe,
                                                    width: 1.0
                                                  ),
                                                  highlightedBorderColor: _colorLowSe,
                                                  onPressed: () {
                                                    setState(() {
                                                      errorImportance = false;
                                                      importance = 'Low';
                                                      _colorLowSe = Colors.green[400];
                                                      _colorMedSe = Colors.grey;
                                                      _colorHighSe = Colors.grey;
                                                    });
                                                  },
                                                ),
                                              ),
                                              ButtonTheme(
                                                height: 30.0,
                                                child: OutlineButton(
                                                  child: Text(
                                                    'Medium',
                                                    style: TextStyle(
                                                      color: _colorMedSe,
                                                      fontSize: 16.0
                                                    ),
                                                  ),
                                                  borderSide: BorderSide(
                                                    color: _colorMedSe,
                                                    width: 1.0
                                                  ),
                                                  highlightedBorderColor: _colorMedSe,
                                                  onPressed: () {
                                                    setState(() {
                                                      errorImportance = false;
                                                      importance = 'Medium';
                                                      _colorLowSe = Colors.grey;
                                                      _colorMedSe = Colors.orangeAccent;
                                                      _colorHighSe = Colors.grey;
                                                    });
                                                  },
                                                ),
                                              ),
                                              ButtonTheme(
                                                height: 30.0,
                                                child: OutlineButton(
                                                  child: Text(
                                                    'High',
                                                    style: TextStyle(
                                                      color: _colorHighSe,
                                                      fontSize: 16.0
                                                    ),
                                                  ),
                                                  borderSide: BorderSide(
                                                    color: _colorHighSe,
                                                    width: 1.0
                                                  ),
                                                  highlightedBorderColor: _colorHighSe,
                                                  onPressed: () {
                                                    setState(() {
                                                      errorImportance = false;
                                                      importance = 'High';
                                                      _colorLowSe = Colors.grey;
                                                      _colorMedSe = Colors.grey;
                                                      _colorHighSe = Colors.redAccent;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        errorImportance
                                          ? Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Please select importance',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 13.0
                                                ),
                                              ),
                                            )
                                          : Container()
                                      ],
                                    )
                                  ),
                                ],
                              ),
                            ),
                            PreferredSize(
                              preferredSize: Size.fromHeight(MediaQuery.of(context).size.height - 55.0 - (MediaQuery.of(context).size.height * 0.7)),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
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
                                                  splashColor: Colors.transparent,
                                                  disabledColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                                                  onPressed: () {
                                                    _cardController.animateTo(_cardController.index - 1);
                                                  },
                                                  tooltip: 'Previous',
                                                ),
                                                IconButton(
                                                  splashColor: Colors.transparent,
                                                  disabledColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                                                  onPressed: () {
                                                    if (_formKey.currentState.validate() && importance.isNotEmpty) {
                                                      setState(() {
                                                        errorImportance = false;
                                                        _autoValidate = false;
                                                      });
                                                      _cardController.animateTo(_cardController.index + 1);
                                                      _formKey.currentState.save();
                                                    } else {
                                                      setState(() {
                                                        errorImportance = true;
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
                                      decoration: BoxDecoration(color: Color(0xFF2F592F))
                                    ),
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
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '3. Current Condition',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '3 of ${_listData.length.toString()}',
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(color: Color(0xFF2F592F))
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              height: MediaQuery.of(context).size.height * 0.7,
                              alignment: Alignment.center,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                                    child: TextFormField(
                                      textCapitalization: TextCapitalization.sentences,
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelText: 'Situation / Process Diagram',
                                        labelStyle: TextStyle(fontSize: 16.0),
                                      ),
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 3,
                                      maxLength: 250,
                                      validator: (value) {
                                        if (value.length < 10) {
                                          return 'Situation / process diagram must be more than 10 character';
                                        } else if (value.length > 250) {
                                          return 'Situation / process diagram must be less than 250 character';
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller: situation,
                                      style: TextStyle(
                                        fontStyle: FontStyle.normal,
                                        color: Colors.black87,
                                        fontSize: 16.0),
                                      onSaved: null,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                                    child: TextFormField(
                                      textCapitalization: TextCapitalization.sentences,
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelText: 'Highlighted Problem',
                                        labelStyle: TextStyle(fontSize: 16.0),
                                      ),
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 3,
                                      maxLength: 250,
                                      validator: (value) {
                                        if (value.length < 10) {
                                          return 'Highlighted problem must be more than 10 character';
                                        } else if (value.length > 250) {
                                          return 'Highlighted problem must be less than 250 character';
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller: highligtedProblem,
                                      style: TextStyle(
                                        fontStyle: FontStyle.normal,
                                        color: Colors.black87,
                                        fontSize: 16.0),
                                      onSaved: null,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                                    child: TextFormField(
                                      textCapitalization: TextCapitalization.sentences,
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelText: 'Performance Measures',
                                        labelStyle: TextStyle(fontSize: 16.0),
                                      ),
                                      maxLength: 100,
                                      validator: (value) {
                                        if (value.length < 10) {
                                          return 'Performance measures must be more than 10 character';
                                        } else if (value.length > 100) {
                                          return 'Performance measures must be less than 100 character';
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
                                ],
                              ),
                            ),
                            PreferredSize(
                              preferredSize: Size.fromHeight(MediaQuery.of(context).size.height - 55.0 - (MediaQuery.of(context).size.height * 0.7)),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
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
                                                  splashColor: Colors.transparent,
                                                  disabledColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                                                  onPressed: () {
                                                    _cardController.animateTo(_cardController.index - 1);
                                                  },
                                                  tooltip: 'Previous',
                                                ),
                                                IconButton(
                                                  splashColor: Colors.transparent,
                                                  disabledColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
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
                                      decoration: BoxDecoration(color: Color(0xFF2F592F))
                                    ),
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
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '4. Cause Analysis',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '4 of ${_listData.length.toString()}',
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(color: Color(0xFF2F592F))
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              alignment: Alignment.center,
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                                    child: TextFormField(
                                      textCapitalization: TextCapitalization.sentences,
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelText: 'Problem',
                                        labelStyle: TextStyle(fontSize: 16.0),
                                      ),
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 3,
                                      maxLength: 250,
                                      validator: (value) {
                                        if (value.length < 10) {
                                          return 'Problem must be more than 10 character';
                                        } else if (value.length > 250) {
                                          return 'Problem must be less than 250 character';
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller: problem,
                                      style: TextStyle(
                                        fontStyle: FontStyle.normal,
                                        color: Colors.black87,
                                        fontSize: 16.0),
                                      onSaved: null,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                                    child: TextFormField(
                                      textCapitalization: TextCapitalization.sentences,
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelText: 'Cause',
                                        labelStyle: TextStyle(fontSize: 16.0),
                                      ),
                                      validator: (value) {
                                        if (value.length < 10) {
                                          return 'Cause must be more than 10 character';
                                        } else if (value.length > 100) {
                                          return 'Cause must be less than 100 character';
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller: cause,
                                      style: TextStyle(
                                        fontStyle: FontStyle.normal,
                                        color: Colors.black87,
                                        fontSize: 16.0),
                                      onSaved: null,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                                    child: TextFormField(
                                      textCapitalization: TextCapitalization.sentences,
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelText: "5 Why\'s",
                                        labelStyle: TextStyle(fontSize: 16.0),
                                      ),
                                      validator: (value) {
                                        if (value.length < 10) {
                                          return '5 Why\'s must be more than 10 character';
                                        } else if (value.length > 100) {
                                          return '5 Why\'s must be less than 100 character';
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller: fiveWhys,
                                      style: TextStyle(
                                        fontStyle: FontStyle.normal,
                                        color: Colors.black87,
                                        fontSize: 16.0),
                                      onSaved: null,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            PreferredSize(
                              preferredSize: Size.fromHeight(MediaQuery.of(context).size.height - 55.0 - (MediaQuery.of(context).size.height * 0.7)),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
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
                                                  splashColor: Colors.transparent,
                                                  disabledColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                                                  onPressed: () {
                                                    _cardController.animateTo(_cardController.index - 1);
                                                  },
                                                  tooltip: 'Previous',
                                                ),
                                                IconButton(
                                                  splashColor: Colors.transparent,
                                                  disabledColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
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
                                      decoration: BoxDecoration(color: Color(0xFF2F592F))
                                    ),
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
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '5. Target Condition',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '5 of ${_listData.length.toString()}',
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(color: Color(0xFF2F592F))
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              alignment: Alignment.center,
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                                    child: TextFormField(
                                      textCapitalization: TextCapitalization.sentences,
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelText: 'Proposed Process Diagram',
                                        labelStyle: TextStyle(fontSize: 16.0, color: Colors.redAccent),
                                      ),
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 3,
                                      maxLength: 250,
                                      validator: (value) {
                                        if (value.length < 10) {
                                          return 'Proposed process diagram must be more than 10 character';
                                        } else if (value.length > 250) {
                                          return 'Proposed process diagram must be less than 250 character';
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller: proposed,
                                      style: TextStyle(
                                        fontStyle: FontStyle.normal,
                                        color: Colors.black87,
                                        fontSize: 16.0),
                                      onSaved: null,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                                    child: TextFormField(
                                      textCapitalization: TextCapitalization.sentences,
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelText: 'Countermeasures',
                                        labelStyle: TextStyle(fontSize: 16.0),
                                      ),
                                      validator: (value) {
                                        if (value.length < 10) {
                                          return 'Countermeasures must be more than 10 character';
                                        } else if (value.length > 100) {
                                          return 'Countermeasures must be less than 100 character';
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller: countermeasure,
                                      style: TextStyle(
                                        fontStyle: FontStyle.normal,
                                        color: Colors.black87,
                                        fontSize: 16.0),
                                      onSaved: null,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                                    child: TextFormField(
                                      textCapitalization: TextCapitalization.sentences,
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelText: 'Measurable Targets',
                                        labelStyle: TextStyle(fontSize: 16.0),
                                      ),
                                      validator: (value) {
                                        if (value.length < 10) {
                                          return 'Measurable targets must be more than 10 character';
                                        } else if (value.length > 100) {
                                          return 'Measurable targets must be less than 100 character';
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller: measurable,
                                      style: TextStyle(
                                        fontStyle: FontStyle.normal,
                                        color: Colors.black87,
                                        fontSize: 16.0),
                                      onSaved: null,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            PreferredSize(
                              preferredSize: Size.fromHeight(MediaQuery.of(context).size.height - 55.0 - (MediaQuery.of(context).size.height * 0.7)),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
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
                                                  splashColor: Colors.transparent,
                                                  disabledColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                                                  onPressed: () {
                                                    _cardController.animateTo(_cardController.index - 1);
                                                  },
                                                  tooltip: 'Previous',
                                                ),
                                                IconButton(
                                                  splashColor: Colors.transparent,
                                                  disabledColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
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
                                      decoration: BoxDecoration(color: Color(0xFF2F592F))
                                    ),
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
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '6. Implementation Plan',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '6 of ${_listData.length.toString()}',
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(color: Color(0xFF2F592F))
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ListView(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              children: <Widget>[
                                Container(
                                  color: Colors.white,
                                  alignment: Alignment.center,
                                  height: who2.length == 0 ? MediaQuery.of(context).size.height * 0.7 : null,
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        title: Padding(
                                          padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                                          child: TextFormField(
                                            keyboardType: TextInputType.multiline,
                                            textCapitalization: TextCapitalization.sentences,
                                            decoration: InputDecoration(
                                              border: UnderlineInputBorder(),
                                              labelText: 'WHAT - Requirement Actions',
                                              labelStyle: TextStyle(fontSize: 16.0),
                                            ),
                                            maxLines: 3,
                                            maxLength: 250,
                                            validator: (value) {
                                              if (value.length < 10) {
                                                return 'Requirement actions must be more than 10 character';
                                              } else if (value.length > 250) {
                                                return 'Requirement actions must be less than 250 character';
                                              } else {
                                                return null;
                                              }
                                            },
                                            controller: what,
                                            style: TextStyle(
                                              fontStyle: FontStyle.normal,
                                              color: Colors.black87,
                                              fontSize: 16.0),
                                            onSaved: null,
                                          ),
                                        ),
                                        trailing: IconButton(
                                          icon: Icon(Icons.add, color: Colors.white),
                                          onPressed: null,
                                        ),
                                      ),
                                      ListTile(
                                        title: Padding(
                                          padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                                          child: StreamBuilder(
                                            stream: Firestore.instance.collection('user').where('aksesStatus', isEqualTo: 'owner').snapshots(),
                                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                              if (!snapshot.hasData)
                                                return Container(
                                                  child: Center(
                                                    child: CircularProgressIndicator(),
                                                  ),
                                                );

                                              return DropdownButtonFormField<String>(
                                                // isExpanded: true,
                                                hint: Text('WHO - Person Responsible', style: TextStyle(fontSize: 16.0)),
                                                value: _whoSelection,
                                                onChanged: (String newValue) {
                                                  Firestore.instance.collection('user').where('id', isEqualTo: int.tryParse(newValue)).snapshots().listen((data) {
                                                    setState(() {
                                                      _whoSelection2 = data.documents[0].data['nama'];
                                                      _whoSelection = newValue;
                                                    });
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
                                                          text: document['nama'].toString(),
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
                                        trailing: IconButton(
                                          icon: Icon(Icons.add, color: AbubaPallate.greenabuba),
                                          onPressed: () {
                                            setState(() {
                                              if (who.contains(int.tryParse(_whoSelection))) {

                                              } else {
                                                who.add(int.tryParse(_whoSelection));
                                              }
                                              if (who2.contains(_whoSelection2)) {

                                              } else {
                                                who2.add(_whoSelection2);
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.only(left: 15.0, right: 10.0, top: who2.length == 0 ? 0.0 : 10.0, bottom: who2.length == 0 ? 0.0 : 20.0),
                                        child: Wrap(
                                          spacing: 8.0,
                                          runSpacing: 4.0,
                                          runAlignment: WrapAlignment.start,
                                          direction: Axis.horizontal,
                                          children: who2.length == 0
                                            ? [Container()]
                                            : who2.map((String name) => Chip(
                                                label: Text(name),
                                                onDeleted: () {
                                                  setState(() {
                                                    who.removeAt(who2.indexOf(name));
                                                    who2.remove(name);
                                                  });
                                                },
                                              )).toList(),
                                        ),
                                      ),
                                      ListTile(
                                        title: Padding(
                                          padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                                          child: DateTimePickerFormField(
                                            format: dateFormat,
                                            onChanged: (dt) =>
                                                setState(() => dateWhen = dt),
                                            dateOnly: true,
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Please select date';
                                              } else {
                                                return null;
                                              }
                                            },
                                            editable: false,
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black87,
                                            ),
                                            decoration: InputDecoration(
                                              border: UnderlineInputBorder(),
                                              labelStyle: TextStyle(fontSize: 16.0),
                                              labelText: 'WHEN - Dates'
                                            ),
                                          ),
                                        ),
                                        trailing: IconButton(
                                          icon: Icon(Icons.add, color: Colors.white),
                                          onPressed: null,
                                        ),
                                      ),
                                      ListTile(
                                        title: Padding(
                                          padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                                          child: StreamBuilder(
                                            stream: Firestore.instance.collection('outlet').orderBy('nama_outlet', descending: false).snapshots(),
                                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                              if (!snapshot.hasData)
                                                return Container(
                                                  child: Center(
                                                    child: CircularProgressIndicator(),
                                                  ),
                                                );

                                              return DropdownButtonFormField<String>(
                                                // isExpanded: true,
                                                validator: (value) {
                                                  if (value == null) {
                                                    return 'Please select location';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                hint: Text('WHERE - Location(s)', style: TextStyle(fontSize: 16.0)),
                                                value: _whereSelection,
                                                onChanged: (String newValue) {
                                                  setState(() {
                                                    _whereSelection = newValue;
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
                                                          text: document['nama_outlet'].toString(),
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
                                        trailing: IconButton(
                                          icon: Icon(Icons.add, color: Colors.white),
                                          onPressed: null,
                                        ),
                                      ),
                                      ListTile(
                                        title: Padding(
                                          padding: const EdgeInsets.only(top: 10.0, left: 10.0, bottom: 20.0),
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              border: UnderlineInputBorder(),
                                              labelText: 'COST - IDR',
                                              labelStyle: TextStyle(fontSize: 16.0),
                                            ),
                                            validator: (value) {
                                              if (value.length == 0) {
                                                return 'Cost must be more than 1';
                                              } else {
                                                return null;
                                              }
                                            },
                                            controller: cost,
                                            style: TextStyle(
                                              fontStyle: FontStyle.normal,
                                              color: Colors.black87,
                                              fontSize: 16.0),
                                            onSaved: null,
                                          ),
                                        ),
                                        trailing: IconButton(
                                          icon: Icon(Icons.add, color: Colors.white),
                                          onPressed: null,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            PreferredSize(
                              preferredSize: Size.fromHeight(MediaQuery.of(context).size.height - 55.0 - (MediaQuery.of(context).size.height * 0.7)),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
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
                                                  splashColor: Colors.transparent,
                                                  disabledColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                                                  onPressed: () {
                                                    _cardController.animateTo(_cardController.index - 1);
                                                  },
                                                  tooltip: 'Previous',
                                                ),
                                                IconButton(
                                                  splashColor: Colors.transparent,
                                                  disabledColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                                                  onPressed: () {
                                                    print(who);
                                                    print(who2);
                                                    if (_formKey.currentState.validate() && who2.length > 0 && who.length > 0) {
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
                                      decoration: BoxDecoration(color: Color(0xFF2F592F))
                                    ),
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
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '7. Follow Up',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '7 of ${_listData.length.toString()}',
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(color: Color(0xFF2F592F))
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              alignment: Alignment.center,
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 5.0, top: 30.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _opening = Colors.green;
                                              _middle = Colors.grey;
                                              plan = true;
                                              result = false;
                                            });
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context).size.width / 4,
                                            child: Column(
                                              children: <Widget>[
                                                Text(
                                                  'PLAN',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: _opening
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                                                  child: Divider(
                                                    height: 10.0,
                                                    color: _opening,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _opening = Colors.grey;
                                              _middle = Colors.green;
                                              plan = false;
                                              result = true;
                                            });
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context).size.width / 4,
                                            child: Column(
                                              children: <Widget>[
                                                Text(
                                                  'RESULT',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: _middle
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                                                  child: Divider(
                                                    height: 10.0,
                                                    color: _middle,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ),
                                  plan
                                    ? Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                                            child: TextFormField(
                                              textCapitalization: TextCapitalization.sentences,
                                              decoration: InputDecoration(
                                                border: UnderlineInputBorder(),
                                                labelText: 'Measure',
                                                labelStyle: TextStyle(fontSize: 16.0),
                                              ),
                                              validator: (value) {
                                                if (value.length < 10) {
                                                  return 'Measure must be more than 10 character';
                                                } else if (value.length > 100) {
                                                  return 'Measure must be less than 100 character';
                                                } else {
                                                  return null;
                                                }
                                              },
                                              controller: measurePlan,
                                              style: TextStyle(
                                                fontStyle: FontStyle.normal,
                                                color: Colors.black87,
                                                fontSize: 16.0),
                                              onSaved: null,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                                            child: TextFormField(
                                              textCapitalization: TextCapitalization.sentences,
                                              decoration: InputDecoration(
                                                border: UnderlineInputBorder(),
                                                labelText: 'Marks of Success',
                                                labelStyle: TextStyle(fontSize: 16.0),
                                              ),
                                              validator: (value) {
                                                if (value.length < 10) {
                                                  return 'Marks of success must be more than 10 character';
                                                } else if (value.length > 100) {
                                                  return 'Marks of success must be less than 100 character';
                                                } else {
                                                  return null;
                                                }
                                              },
                                              controller: marksPlan,
                                              style: TextStyle(
                                                fontStyle: FontStyle.normal,
                                                color: Colors.black87,
                                                fontSize: 16.0),
                                              onSaved: null,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                                            child: TextFormField(
                                              textCapitalization: TextCapitalization.sentences,
                                              decoration: InputDecoration(
                                                border: UnderlineInputBorder(),
                                                labelText: 'Scheduled Checks',
                                                labelStyle: TextStyle(fontSize: 16.0),
                                              ),
                                              validator: (value) {
                                                if (value.length < 10) {
                                                  return 'Scheduled checks must be more than 10 character';
                                                } else if (value.length > 100) {
                                                  return 'Scheduled checks must be less than 100 character';
                                                } else {
                                                  return null;
                                                }
                                              },
                                              controller: schedulePlan,
                                              style: TextStyle(
                                                fontStyle: FontStyle.normal,
                                                color: Colors.black87,
                                                fontSize: 16.0),
                                              onSaved: null,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Container(),
                                  result
                                    ? Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                                            child: TextFormField(
                                              textCapitalization: TextCapitalization.sentences,
                                              decoration: InputDecoration(
                                                border: UnderlineInputBorder(),
                                                labelText: 'Measure',
                                                labelStyle: TextStyle(fontSize: 16.0),
                                              ),
                                              validator: (value) {
                                                if (value.length < 10) {
                                                  return 'Measure must be more than 10 character';
                                                } else if (value.length > 100) {
                                                  return 'Measure must be less than 100 character';
                                                } else {
                                                  return null;
                                                }
                                              },
                                              controller: measureResult,
                                              style: TextStyle(
                                                fontStyle: FontStyle.normal,
                                                color: Colors.black87,
                                                fontSize: 16.0),
                                              onSaved: null,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                                            child: TextFormField(
                                              textCapitalization: TextCapitalization.sentences,
                                              decoration: InputDecoration(
                                                border: UnderlineInputBorder(),
                                                labelText: 'Marks of Success',
                                                labelStyle: TextStyle(fontSize: 16.0),
                                              ),
                                              validator: (value) {
                                                if (value.length < 10) {
                                                  return 'Marks of success must be more than 10 character';
                                                } else if (value.length > 100) {
                                                  return 'Marks of success must be less than 100 character';
                                                } else {
                                                  return null;
                                                }
                                              },
                                              controller: marksResult,
                                              style: TextStyle(
                                                fontStyle: FontStyle.normal,
                                                color: Colors.black87,
                                                fontSize: 16.0),
                                              onSaved: null,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                                            child: TextFormField(
                                              textCapitalization: TextCapitalization.sentences,
                                              decoration: InputDecoration(
                                                border: UnderlineInputBorder(),
                                                labelText: 'Scheduled Checks',
                                                labelStyle: TextStyle(fontSize: 16.0),
                                              ),
                                              validator: (value) {
                                                if (value.length < 10) {
                                                  return 'Scheduled checks must be more than 10 character';
                                                } else if (value.length > 100) {
                                                  return 'Scheduled checks must be less than 100 character';
                                                } else {
                                                  return null;
                                                }
                                              },
                                              controller: scheduleResult,
                                              style: TextStyle(
                                                fontStyle: FontStyle.normal,
                                                color: Colors.black87,
                                                fontSize: 16.0),
                                              onSaved: null,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Container()
                                ],
                              ),
                            ),
                            PreferredSize(
                              preferredSize: Size.fromHeight(MediaQuery.of(context).size.height - 55.0 - (MediaQuery.of(context).size.height * 0.7)),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
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
                                                  splashColor: Colors.transparent,
                                                  disabledColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                                                  onPressed: () {
                                                    _cardController.animateTo(_cardController.index - 1);
                                                  },
                                                  tooltip: 'Previous',
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      if (_formKey.currentState.validate()) {
                                                        setState(() {
                                                          _isProccess = true;
                                                          _autoValidate = false;
                                                        });
                                                        _formKey.currentState.save();

                                                        DocumentReference docReference = Firestore.instance.collection('a3Report').document();

                                                        docReference.setData({
                                                          'userCreated': widget.idUser,
                                                          'dateCreated': DateTime.now(),
                                                          'a3ReportNo': maxid_a3Report,
                                                          'problemIssue': problemIssue.text,
                                                          'issueBackground': int.tryParse(_issueBackgroundSelection),
                                                          'context': int.tryParse(_contextSelection),
                                                          'importance': importance,
                                                          'situation':situation.text,
                                                          'highligtedProblem':highligtedProblem.text,
                                                          'performanceMeasure': performanceMeasure.text,
                                                          'problem': problem.text,
                                                          'cause': cause.text,
                                                          '5Whys':fiveWhys.text,
                                                          'proposed':proposed.text,
                                                          'countermeasures':countermeasure.text,
                                                          'measurableTargets': measurable.text,
                                                          'what': what.text,
                                                          'whoID': who,
                                                          'whoName': who2,
                                                          'when':dateWhen,
                                                          'where': int.tryParse(_whereSelection),
                                                          'cost': cost.text,
                                                          'measurePlan': measurePlan.text,
                                                          'marksPlan':marksPlan.text,
                                                          'schedulePlan':schedulePlan.text,
                                                          'measureResult':measureResult.text,
                                                          'marksResult':marksResult.text,
                                                          'scheduleResult':scheduleResult.text
                                                        }).then((doc) {
                                                          setState(() {
                                                            _isProccess = false;
                                                          });

                                                          DocumentReference documentReference =Firestore.instance.collection('dumper_a3Report').document(index_a3Report);

                                                          documentReference.updateData({
                                                            'maxid':maxid_a3Report
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
                                                                        'A3 Report No. ATR-${maxid_a3Report.toString().padLeft(4, '0')}',
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
                                                    child: Tooltip(
                                                      message: 'Save',
                                                      child: _isProccess
                                                        ? SizedBox(
                                                            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white), strokeWidth: 2.0,),
                                                            height: 25.0,
                                                            width: 25.0,
                                                          )
                                                        : Icon(Icons.save, color: Colors.white)
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(color: Color(0xFF2F592F))
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ]
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

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