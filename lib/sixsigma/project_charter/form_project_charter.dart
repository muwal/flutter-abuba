import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormProjectCharter extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  FormProjectCharter({this.idUser, this.namaUser, this.departmentUser});

  @override
  _FormProjectCharterState createState() => _FormProjectCharterState();
}

class _FormProjectCharterState extends State<FormProjectCharter> with TickerProviderStateMixin {
  bool _isProccess = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  List<Map> _listData = [ {'nomor': '1'}, {'nomor': '2'}, {'nomor': '3'}, {'nomor': '4'}, {'nomor': '5'}, {'nomor': '6'}, {'nomor': '7'}, {'nomor': '8'}, {'nomor': '9'}];

  TextEditingController projectName =TextEditingController();
  TextEditingController expectedSavings =TextEditingController();
  TextEditingController estimatedCost =TextEditingController();
  TextEditingController problemIssue =TextEditingController();
  TextEditingController purpose =TextEditingController();
  TextEditingController businessCase =TextEditingController();
  TextEditingController expectedDeliverables =TextEditingController();
  TextEditingController withingScope =TextEditingController();
  TextEditingController outsideScope =TextEditingController();
  TextEditingController rate =TextEditingController();
  TextEditingController quantity =TextEditingController();
  TextEditingController amount =TextEditingController();
  TextEditingController exptectedBenefit =TextEditingController();
  TextEditingController basisEstimated =TextEditingController();
  TextEditingController estimatedBenefit =TextEditingController();
  TextEditingController risks =TextEditingController();
  TextEditingController constraints =TextEditingController();
  TextEditingController assumption =TextEditingController();

  DateTime fromProjectTeamStart;
  DateTime fromProjectTeamEnd;
  DateTime preliminaryStart;
  DateTime preliminaryEnd;
  DateTime defineStart;
  DateTime defineEnd;
  DateTime measurementStart;
  DateTime measurementEnd;
  DateTime analysisStart;
  DateTime analysisEnd;
  DateTime improvementStart;
  DateTime improvementEnd;
  DateTime controlStart;
  DateTime controlEnd;
  DateTime projectSummaryStart;
  DateTime projectSummaryEnd;
  DateTime closeOutStart;
  DateTime closeOutEnd;

  List<int> projectTeamID = [];
  List<String> projectTeamName = [];
  List<int> supportResourcesID = [];
  List<String> supportResourcesName = [];
  List<int> specialNeedsID = [];
  List<String> specialNeedsName = [];

  String _projectSponsorSelection;
  String _projectManagerSelection;
  String _departmentSelection;
  String _processImpactedSelection;
  String _greenBeltSelection;
  String _blackBeltSelection;
  String _goalsSelection;
  String _projectTeamSelection;
  String _supportResourcesSelection;
  String _specialNeedsSelection;
  String _projectTeamSelection2;
  String _supportResourcesSelection2;
  String _specialNeedsSelection2;
  String _costTypeSelection;
  String _vendorSelection;

  String _processOwnerSelection;
  String _keyStakeholdersSelection;
  String _keyStakeholders;
  List<Map> _keyStakeholdersJson = [
    {"id": 1, "keyStakeholders": "Supplier"},
    {"id": 2, "keyStakeholders": "Customer"},
  ];
  String _finalCustomerSelection;
  String _typeOfBenefitSelection;

  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime dateStart;
  DateTime dateCompletion;

  TabController _cardController;
  var maxid_projectCharter;
  var index_projectCharter;

  @override
  void initState() {
    super.initState();
    _cardController = new TabController(vsync: this, length: _listData.length);
    Firestore.instance.collection('dumper_maxid').snapshots().listen((data) {
      setState(() {
        maxid_projectCharter = data.documents[0].data['maxid_projectCharter'] + 1;
        index_projectCharter = data.documents[0].documentID;
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
                                              '1. General Information',
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
                              color: Colors.white,
                              alignment: Alignment.center,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                                    child: TextFormField(
                                      textCapitalization: TextCapitalization.sentences,
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelText: 'Project Name',
                                        labelStyle: TextStyle(fontSize: 16.0),
                                      ),
                                      maxLength: 100,
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
                                    padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                                    child: StreamBuilder(
                                      stream: Firestore.instance.collection('project-sponsor').orderBy('sponsor', descending: false).snapshots(),
                                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (!snapshot.hasData)
                                          return Container(
                                            child: Center(
                                              child: CircularProgressIndicator(),
                                            ),
                                          );

                                        return DropdownButtonFormField<String>(
                                          decoration: InputDecoration(
                                            labelText: 'Project Sponsor',
                                            labelStyle: TextStyle(fontSize: 16.0),
                                          ),
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Please select project sponsor';
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
                                                    text: document['sponsor'].toString(),
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
                                      stream: Firestore.instance.collection('user').where('aksesStatus', isEqualTo: 'owner').snapshots(),
                                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (!snapshot.hasData)
                                          return Container(
                                            child: Center(
                                              child: CircularProgressIndicator(),
                                            ),
                                          );

                                        return DropdownButtonFormField<String>(
                                          decoration: InputDecoration(
                                            labelText: 'Project Manager',
                                            labelStyle: TextStyle(fontSize: 16.0),
                                          ),
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Please select project manager';
                                            } else {
                                              return null;
                                            }
                                          },
                                          value: _projectManagerSelection,
                                          onChanged: (String value) {
                                            setState(() {
                                              _projectManagerSelection = value;
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
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                                    child: StreamBuilder(
                                      stream: Firestore.instance.collection('department').orderBy('department', descending: false).snapshots(),
                                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (!snapshot.hasData)
                                          return Container(
                                            child: Center(
                                              child: CircularProgressIndicator(),
                                            ),
                                          );

                                        return DropdownButtonFormField<String>(
                                          decoration: InputDecoration(
                                            labelText: 'Department',
                                            labelStyle: TextStyle(fontSize: 16.0),
                                          ),
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Please select department';
                                            } else {
                                              return null;
                                            }
                                          },
                                          value: _departmentSelection,
                                          onChanged: (String value) {
                                            setState(() {
                                              _departmentSelection = value;
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
                                                    text: document['department'].toString(),
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
                                      stream: Firestore.instance.collection('process-impacted').orderBy('impacted', descending: false).snapshots(),
                                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (!snapshot.hasData)
                                          return Container(
                                            child: Center(
                                              child: CircularProgressIndicator(),
                                            ),
                                          );

                                        return DropdownButtonFormField<String>(
                                          decoration: InputDecoration(
                                            labelText: 'Process Impacted',
                                            labelStyle: TextStyle(fontSize: 16.0),
                                          ),
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Please select process impacted';
                                            } else {
                                              return null;
                                            }
                                          },
                                          value: _processImpactedSelection,
                                          onChanged: (String value) {
                                            setState(() {
                                              _processImpactedSelection = value;
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
                                                    text: document['impacted'].toString(),
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
                                    child: DateTimePickerFormField(
                                      format: dateFormat,
                                      onChanged: (dt) => setState(() => dateStart = dt),
                                      dateOnly: true,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.black87,
                                      ),
                                      editable: false,
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Please select expected start date ';
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelStyle: TextStyle(fontSize: 16.0),
                                        labelText: 'Expected Start Date'
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                                    child: DateTimePickerFormField(
                                      format: dateFormat,
                                      onChanged: (dc) => setState(() => dateCompletion = dc),
                                      dateOnly: true,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.black87,
                                      ),
                                      editable: false,
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Please select expected completion date';
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelStyle: TextStyle(fontSize: 16.0),
                                        labelText: 'Expected Completion Date'
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelText: 'Expected Savings',
                                        labelStyle: TextStyle(fontSize: 16.0),
                                      ),
                                      controller: expectedSavings,
                                      validator: (value) {
                                        if (value.length < 1) {
                                          return 'Please input expected savings';
                                        } else {
                                          return null;
                                        }
                                      },
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
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelText: 'Estimated Cost',
                                        labelStyle: TextStyle(fontSize: 16.0),
                                      ),
                                      controller: estimatedCost,
                                      validator: (value) {
                                        if (value.length < 1) {
                                          return 'Please input estimated cost';
                                        } else {
                                          return null;
                                        }
                                      },
                                      style: TextStyle(
                                        fontStyle: FontStyle.normal,
                                        color: Colors.black87,
                                        fontSize: 16.0),
                                      onSaved: null,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                                    child: StreamBuilder(
                                      stream: Firestore.instance.collection('green-belt').orderBy('greenBelt', descending: false).snapshots(),
                                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (!snapshot.hasData)
                                          return Container(
                                            child: Center(
                                              child: CircularProgressIndicator(),
                                            ),
                                          );

                                        return DropdownButtonFormField<String>(
                                          decoration: InputDecoration(
                                            labelText: 'Green Belt Assigned',
                                            labelStyle: TextStyle(fontSize: 16.0),
                                          ),
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Please select green belt assigned';
                                            } else {
                                              return null;
                                            }
                                          },
                                          value: _greenBeltSelection,
                                          onChanged: (String value) {
                                            setState(() {
                                              _greenBeltSelection = value;
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
                                                    text: document['greenBelt'].toString(),
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
                                    child: StreamBuilder(
                                      stream: Firestore.instance.collection('black-belt').orderBy('blackBelt', descending: false).snapshots(),
                                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (!snapshot.hasData)
                                          return Container(
                                            child: Center(
                                              child: CircularProgressIndicator(),
                                            ),
                                          );

                                        return DropdownButtonFormField<String>(
                                          decoration: InputDecoration(
                                            labelText: 'Black Belt Assigned',
                                            labelStyle: TextStyle(fontSize: 16.0),
                                          ),
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Please select black belt assigned';
                                            } else {
                                              return null;
                                            }
                                          },
                                          value: _blackBeltSelection,
                                          onChanged: (String value) {
                                            setState(() {
                                              _blackBeltSelection = value;
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
                                                    text: document['blackBelt'].toString(),
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
                                              '2. Problem, Goals, Objectives, and Deliverable',
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
                              color: Colors.white,
                              alignment: Alignment.center,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                                    child: TextFormField(
                                      textCapitalization: TextCapitalization.sentences,
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelText: 'Problem or Issue',
                                        labelStyle: TextStyle(fontSize: 16.0),
                                      ),
                                      maxLength: 250,
                                      validator: (value) {
                                        if (value.length < 10) {
                                          return 'Problem or issue must be more than 10 character';
                                        } else if (value.length > 250) {
                                          return 'Problem or issue mush be less than 250 character';
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller: problemIssue,
                                      maxLines: 3,
                                      keyboardType: TextInputType.multiline,
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
                                        labelText: 'Purpose or Project',
                                        labelStyle: TextStyle(fontSize: 16.0),
                                      ),
                                      maxLength: 250,
                                      maxLines: 3,
                                      controller: purpose,
                                      validator: (value) {
                                        if (value.length < 10) {
                                          return 'Purpose or project must be more than 10 character';
                                        } else if (value.length > 250) {
                                          return 'Purpose or project mush be less than 250 character';
                                        } else {
                                          return null;
                                        }
                                      },
                                      keyboardType: TextInputType.multiline,
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
                                        labelText: 'Business Case',
                                        labelStyle: TextStyle(fontSize: 16.0),
                                      ),
                                      maxLength: 250,
                                      maxLines: 3,
                                      controller: businessCase,
                                      validator: (value) {
                                        if (value.length < 10) {
                                          return 'Business case must be more than 10 character';
                                        } else if (value.length > 250) {
                                          return 'Business case mush be less than 250 character';
                                        } else {
                                          return null;
                                        }
                                      },
                                      keyboardType: TextInputType.multiline,
                                      style: TextStyle(
                                        fontStyle: FontStyle.normal,
                                        color: Colors.black87,
                                        fontSize: 16.0),
                                      onSaved: null,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                                    child: StreamBuilder(
                                      stream: Firestore.instance.collection('goals-metric').orderBy('goals', descending: false).snapshots(),
                                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (!snapshot.hasData)
                                          return Container(
                                            child: Center(
                                              child: CircularProgressIndicator(),
                                            ),
                                          );

                                        return DropdownButtonFormField<String>(
                                          decoration: InputDecoration(
                                            labelText: 'Goals Metric',
                                            labelStyle: TextStyle(fontSize: 16.0),
                                          ),
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Please select goals metric';
                                            } else {
                                              return null;
                                            }
                                          },
                                          value: _goalsSelection,
                                          onChanged: (String value) {
                                            setState(() {
                                              _goalsSelection = value;
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
                                                    text: document['goals'].toString(),
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
                                    padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelText: 'Expected Deliverables',
                                        labelStyle: TextStyle(fontSize: 16.0),
                                      ),
                                      controller: expectedDeliverables,
                                      validator: (value) {
                                        if (value.length < 1) {
                                          return 'Please input expected deliverables';
                                        } else {
                                          return null;
                                        }
                                      },
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
                                              '3. Project Scope',
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
                                        labelText: 'Within Scope',
                                        labelStyle: TextStyle(fontSize: 16.0),
                                      ),
                                      controller: withingScope,
                                      maxLength: 100,
                                      validator: (value) {
                                        if (value.length < 5) {
                                          return 'Within scope must be more than 5 character';
                                        } else if (value.length > 100) {
                                          return 'Within scope must be less than 100 character';
                                        } else {
                                          return null;
                                        }
                                      },
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
                                        labelText: 'Outside of Scope',
                                        labelStyle: TextStyle(fontSize: 16.0),
                                      ),
                                      maxLength: 100,
                                      controller: outsideScope,
                                      validator: (value) {
                                        if (value.length < 5) {
                                          return 'Outside of scope must be more than 5 character';
                                        } else if (value.length > 100) {
                                          return 'Outside of scope must be less than 100 character';
                                        } else {
                                          return null;
                                        }
                                      },
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
                                              '4. Tentative Schedule',
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
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(left: 10.0),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'From Project Team',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.0),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(top: 5.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Container(
                                                width: MediaQuery.of(context).size.width / 2.5,
                                                child: DateTimePickerFormField(
                                                  format: dateFormat,
                                                  onChanged: (dt) =>
                                                      setState(() => fromProjectTeamStart = dt),
                                                  dateOnly: true,
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.black87,
                                                  ),
                                                  editable: false,
                                                  validator: (value) {
                                                    if (value == null) {
                                                      return 'Please select from project team start date';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    border: UnderlineInputBorder(),
                                                    labelStyle: TextStyle(fontSize: 16.0),
                                                    labelText: 'Start'
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context).size.width / 2.5,
                                                child: DateTimePickerFormField(
                                                  format: dateFormat,
                                                  onChanged: (dt) =>
                                                      setState(() => fromProjectTeamEnd = dt),
                                                  dateOnly: true,
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.black87,
                                                  ),
                                                  editable: false,
                                                  validator: (value) {
                                                    if (value == null) {
                                                      return 'Please select from project team complete date';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    border: UnderlineInputBorder(),
                                                    labelStyle: TextStyle(fontSize: 16.0),
                                                    labelText: 'Complete'
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(left: 10.0),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Preliminary Review',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.0),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(top: 5.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Container(
                                                width: MediaQuery.of(context).size.width / 2.5,
                                                child: DateTimePickerFormField(
                                                  format: dateFormat,
                                                  onChanged: (dt) =>
                                                      setState(() => preliminaryStart = dt),
                                                  dateOnly: true,
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.black87,
                                                  ),
                                                  editable: false,
                                                  validator: (value) {
                                                    if (value == null) {
                                                      return 'Please select preliminary review start date';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    border: UnderlineInputBorder(),
                                                    labelStyle: TextStyle(fontSize: 16.0),
                                                    labelText: 'Start'
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context).size.width / 2.5,
                                                child: DateTimePickerFormField(
                                                  format: dateFormat,
                                                  onChanged: (dt) =>
                                                      setState(() => preliminaryEnd = dt),
                                                  dateOnly: true,
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.black87,
                                                  ),
                                                  editable: false,
                                                  validator: (value) {
                                                    if (value == null) {
                                                      return 'Please select preliminary review complete date';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    border: UnderlineInputBorder(),
                                                    labelStyle: TextStyle(fontSize: 16.0),
                                                    labelText: 'Complete'
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(left: 10.0),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Define Scope',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.0),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(top: 5.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Container(
                                                width: MediaQuery.of(context).size.width / 2.5,
                                                child: DateTimePickerFormField(
                                                  format: dateFormat,
                                                  onChanged: (dt) =>
                                                      setState(() => defineStart = dt),
                                                  dateOnly: true,
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.black87,
                                                  ),
                                                  editable: false,
                                                  validator: (value) {
                                                    if (value == null) {
                                                      return 'Please select define scope start date';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    border: UnderlineInputBorder(),
                                                    labelStyle: TextStyle(fontSize: 16.0),
                                                    labelText: 'Start'
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context).size.width / 2.5,
                                                child: DateTimePickerFormField(
                                                  format: dateFormat,
                                                  onChanged: (dt) =>
                                                      setState(() => defineEnd = dt),
                                                  dateOnly: true,
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.black87,
                                                  ),
                                                  editable: false,
                                                  validator: (value) {
                                                    if (value == null) {
                                                      return 'Please select define scope complete date';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    border: UnderlineInputBorder(),
                                                    labelStyle: TextStyle(fontSize: 16.0),
                                                    labelText: 'Complete'
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(left: 10.0),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Measurement Phase',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.0),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(top: 5.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Container(
                                                width: MediaQuery.of(context).size.width / 2.5,
                                                child: DateTimePickerFormField(
                                                  format: dateFormat,
                                                  onChanged: (dt) =>
                                                      setState(() => measurementStart = dt),
                                                  dateOnly: true,
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.black87,
                                                  ),
                                                  editable: false,
                                                  validator: (value) {
                                                    if (value == null) {
                                                      return 'Please select measurement phase start date';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    border: UnderlineInputBorder(),
                                                    labelStyle: TextStyle(fontSize: 16.0),
                                                    labelText: 'Start'
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context).size.width / 2.5,
                                                child: DateTimePickerFormField(
                                                  format: dateFormat,
                                                  onChanged: (dt) =>
                                                      setState(() => measurementEnd = dt),
                                                  dateOnly: true,
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.black87,
                                                  ),
                                                  editable: false,
                                                  validator: (value) {
                                                    if (value == null) {
                                                      return 'Please select measurement phase complete date';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    border: UnderlineInputBorder(),
                                                    labelStyle: TextStyle(fontSize: 16.0),
                                                    labelText: 'Complete'
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(left: 10.0),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Analysis Phase',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.0),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(top: 5.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Container(
                                                width: MediaQuery.of(context).size.width / 2.5,
                                                child: DateTimePickerFormField(
                                                  format: dateFormat,
                                                  onChanged: (dt) =>
                                                      setState(() => analysisStart = dt),
                                                  dateOnly: true,
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.black87,
                                                  ),
                                                  editable: false,
                                                  validator: (value) {
                                                    if (value == null) {
                                                      return 'Please select analysis phase start date';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    border: UnderlineInputBorder(),
                                                    labelStyle: TextStyle(fontSize: 16.0),
                                                    labelText: 'Start'
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context).size.width / 2.5,
                                                child: DateTimePickerFormField(
                                                  format: dateFormat,
                                                  onChanged: (dt) =>
                                                      setState(() => analysisEnd = dt),
                                                  dateOnly: true,
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.black87,
                                                  ),
                                                  editable: false,
                                                  validator: (value) {
                                                    if (value == null) {
                                                      return 'Please select analysis phase complete date';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    border: UnderlineInputBorder(),
                                                    labelStyle: TextStyle(fontSize: 16.0),
                                                    labelText: 'Complete'
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(left: 10.0),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Improvement Phase',
                                            style: TextStyle(
                                                color: Colors.black, fontSize: 16.0),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(top: 5.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Container(
                                                width: MediaQuery.of(context).size.width / 2.5,
                                                child: DateTimePickerFormField(
                                                  format: dateFormat,
                                                  onChanged: (dt) =>
                                                      setState(() => improvementStart = dt),
                                                  dateOnly: true,
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.black87,
                                                  ),
                                                  editable: false,
                                                  validator: (value) {
                                                    if (value == null) {
                                                      return 'Please select improvement phase start date';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    border: UnderlineInputBorder(),
                                                    labelStyle: TextStyle(fontSize: 16.0),
                                                    labelText: 'Start'
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context).size.width / 2.5,
                                                child: DateTimePickerFormField(
                                                  format: dateFormat,
                                                  onChanged: (dt) =>
                                                      setState(() => improvementEnd = dt),
                                                  dateOnly: true,
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.black87,
                                                  ),
                                                  editable: false,
                                                  validator: (value) {
                                                    if (value == null) {
                                                      return 'Please select improvement phase complete date';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    border: UnderlineInputBorder(),
                                                    labelStyle: TextStyle(fontSize: 16.0),
                                                    labelText: 'Complete'
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(left: 10.0),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Control Phase',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.0),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(top: 5.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Container(
                                                width: MediaQuery.of(context).size.width / 2.5,
                                                child: DateTimePickerFormField(
                                                  format: dateFormat,
                                                  onChanged: (dt) =>
                                                      setState(() => controlStart = dt),
                                                  dateOnly: true,
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.black87,
                                                  ),
                                                  editable: false,
                                                  validator: (value) {
                                                    if (value == null) {
                                                      return 'Please select control phase start date';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    border: UnderlineInputBorder(),
                                                    labelStyle: TextStyle(fontSize: 16.0),
                                                    labelText: 'Start'
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context).size.width / 2.5,
                                                child: DateTimePickerFormField(
                                                  format: dateFormat,
                                                  onChanged: (dt) =>
                                                      setState(() => controlEnd= dt),
                                                  dateOnly: true,
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.black87,
                                                  ),
                                                  editable: false,
                                                  validator: (value) {
                                                    if (value == null) {
                                                      return 'Please select control phase complete date';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    border: UnderlineInputBorder(),
                                                    labelStyle: TextStyle(fontSize: 16.0),
                                                    labelText: 'Complete'
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(left: 10.0),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Project Summary Report',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.0),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(top: 5.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Container(
                                                width: MediaQuery.of(context).size.width / 2.5,
                                                child: DateTimePickerFormField(
                                                  format: dateFormat,
                                                  onChanged: (dt) =>
                                                      setState(() => projectSummaryStart = dt),
                                                  dateOnly: true,
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.black87,
                                                  ),
                                                  editable: false,
                                                  validator: (value) {
                                                    if (value == null) {
                                                      return 'Please select project summary report start date';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    border: UnderlineInputBorder(),
                                                    labelStyle: TextStyle(fontSize: 16.0),
                                                    labelText: 'Start'
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context).size.width / 2.5,
                                                child: DateTimePickerFormField(
                                                  format: dateFormat,
                                                  onChanged: (dt) =>
                                                      setState(() => projectSummaryEnd = dt),
                                                  dateOnly: true,
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.black87,
                                                  ),
                                                  editable: false,
                                                  validator: (value) {
                                                    if (value == null) {
                                                      return 'Please select project summary report complete date';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    border: UnderlineInputBorder(),
                                                    labelStyle: TextStyle(fontSize: 16.0),
                                                    labelText: 'Complete'
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(left: 10.0),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Close Out',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.0),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(top: 5.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Container(
                                                width: MediaQuery.of(context).size.width / 2.5,
                                                child: DateTimePickerFormField(
                                                  format: dateFormat,
                                                  onChanged: (dt) =>
                                                      setState(() => closeOutStart = dt),
                                                  dateOnly: true,
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.black87,
                                                  ),
                                                  editable: false,
                                                  validator: (value) {
                                                    if (value == null) {
                                                      return 'Please select close out start date';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    border: UnderlineInputBorder(),
                                                    labelStyle: TextStyle(fontSize: 16.0),
                                                    labelText: 'Start'
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context).size.width / 2.5,
                                                child: DateTimePickerFormField(
                                                  format: dateFormat,
                                                  onChanged: (dt) =>
                                                      setState(() => closeOutEnd = dt),
                                                  dateOnly: true,
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.black87,
                                                  ),
                                                  editable: false,
                                                  validator: (value) {
                                                    if (value == null) {
                                                      return 'Please select close out complete date';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    border: UnderlineInputBorder(),
                                                    labelStyle: TextStyle(fontSize: 16.0),
                                                    labelText: 'Complete'
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
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
                        Column(
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
                                              '5. Project Resources and Costs',
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
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: ListView(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                children: <Widget>[
                                  ListTile(
                                    title: Padding(
                                      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                                      child: StreamBuilder(
                                        stream: Firestore.instance.collection('project-team').orderBy('name', descending: false).snapshots(),
                                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                          if (!snapshot.hasData)
                                            return Container(
                                              child: Center(
                                                child: CircularProgressIndicator(),
                                              ),
                                            );

                                          return DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              labelText: 'Project Team',
                                              labelStyle: TextStyle(fontSize: 16.0),
                                            ),
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Please select project team';
                                              } else {
                                                return null;
                                              }
                                            },
                                            value: _projectTeamSelection,
                                            onChanged: (String value) {
                                              Firestore.instance.collection('project-team').where('id', isEqualTo: int.tryParse(value)).snapshots().listen((data) {
                                                setState(() {
                                                  _projectTeamSelection2 = data.documents[0].data['name'];
                                                  _projectTeamSelection = value;
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
                                                      text: document['name'].toString(),
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
                                          if (projectTeamID.contains(int.tryParse(_projectTeamSelection))) {

                                          } else {
                                            projectTeamID.add(int.tryParse(_projectTeamSelection));
                                          }
                                          if (projectTeamName.contains(_projectTeamSelection2)) {

                                          } else {
                                            projectTeamName.add(_projectTeamSelection2);
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(left: 15.0, right: 10.0, top: projectTeamName.length == 0 ? 0.0 : 10.0, bottom: projectTeamName.length == 0 ? 0.0 : 20.0),
                                    child: Wrap(
                                      spacing: 8.0,
                                      runSpacing: 4.0,
                                      runAlignment: WrapAlignment.start,
                                      direction: Axis.horizontal,
                                      children: projectTeamName.length == 0
                                        ? [Container()]
                                        : projectTeamName.map((String name) => Chip(
                                            label: Text(name),
                                            onDeleted: () {
                                              setState(() {
                                                projectTeamID.removeAt(projectTeamName.indexOf(name));
                                                projectTeamName.remove(name);
                                              });
                                            },
                                          )).toList(),
                                    ),
                                  ),
                                  ListTile(
                                    title: Padding(
                                      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                                      child: StreamBuilder(
                                        stream: Firestore.instance.collection('support-resources').orderBy('support', descending: false).snapshots(),
                                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                          if (!snapshot.hasData)
                                            return Container(
                                              child: Center(
                                                child: CircularProgressIndicator(),
                                              ),
                                            );

                                          return DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              labelText: 'Support Resources',
                                              labelStyle: TextStyle(fontSize: 16.0),
                                            ),
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Please select support resources';
                                              } else {
                                                return null;
                                              }
                                            },
                                            value: _supportResourcesSelection,
                                            onChanged: (String value) {
                                              Firestore.instance.collection('support-resources').where('id', isEqualTo: int.tryParse(value)).snapshots().listen((data) {
                                                setState(() {
                                                  _supportResourcesSelection2 = data.documents[0].data['support'];
                                                  _supportResourcesSelection = value;
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
                                                      text: document['support'].toString(),
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
                                          if (supportResourcesID.contains(int.tryParse(_supportResourcesSelection))) {

                                          } else {
                                            supportResourcesID.add(int.tryParse(_supportResourcesSelection));
                                          }
                                          if (supportResourcesName.contains(_supportResourcesSelection2)) {

                                          } else {
                                            supportResourcesName.add(_supportResourcesSelection2);
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(left: 15.0, right: 10.0, top: supportResourcesName.length == 0 ? 0.0 : 10.0, bottom: supportResourcesName.length == 0 ? 0.0 : 20.0),
                                    child: Wrap(
                                      spacing: 8.0,
                                      runSpacing: 4.0,
                                      runAlignment: WrapAlignment.start,
                                      direction: Axis.horizontal,
                                      children: supportResourcesName.length == 0
                                        ? [Container()]
                                        : supportResourcesName.map((String name) => Chip(
                                            label: Text(name),
                                            onDeleted: () {
                                              setState(() {
                                                supportResourcesID.removeAt(supportResourcesName.indexOf(name));
                                                supportResourcesName.remove(name);
                                              });
                                            },
                                          )).toList(),
                                    ),
                                  ),
                                  ListTile(
                                    title: Padding(
                                      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                                      child: StreamBuilder(
                                        stream: Firestore.instance.collection('special-needs').orderBy('special', descending: false).snapshots(),
                                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                          if (!snapshot.hasData)
                                            return Container(
                                              child: Center(
                                                child: CircularProgressIndicator(),
                                              ),
                                            );

                                          return DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              labelText: 'Special Needs',
                                              labelStyle: TextStyle(fontSize: 16.0),
                                            ),
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Please select special needs';
                                              } else {
                                                return null;
                                              }
                                            },
                                            value: _specialNeedsSelection,
                                            onChanged: (String value) {
                                              Firestore.instance.collection('special-needs').where('id', isEqualTo: int.tryParse(value)).snapshots().listen((data) {
                                                setState(() {
                                                  _specialNeedsSelection2 = data.documents[0].data['special'];
                                                  _specialNeedsSelection = value;
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
                                                      text: document['special'].toString(),
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
                                          if (specialNeedsID.contains(int.tryParse(_specialNeedsSelection))) {

                                          } else {
                                            specialNeedsID.add(int.tryParse(_specialNeedsSelection));
                                          }
                                          if (specialNeedsName.contains(_specialNeedsSelection2)) {

                                          } else {
                                            specialNeedsName.add(_specialNeedsSelection2);
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(left: 15.0, right: 10.0, top: specialNeedsName.length == 0 ? 0.0 : 10.0, bottom: specialNeedsName.length == 0 ? 0.0 : 20.0),
                                    child: Wrap(
                                      spacing: 8.0,
                                      runSpacing: 4.0,
                                      runAlignment: WrapAlignment.start,
                                      direction: Axis.horizontal,
                                      children: specialNeedsName.length == 0
                                        ? [Container()]
                                        : specialNeedsName.map((String name) => Chip(
                                            label: Text(name),
                                            onDeleted: () {
                                              setState(() {
                                                specialNeedsID.removeAt(specialNeedsName.indexOf(name));
                                                specialNeedsName.remove(name);
                                              });
                                            },
                                          )).toList(),
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
                                              '6. Costing',
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
                            Container(
                              color: Colors.white,
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Padding(
                                      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                                      child: StreamBuilder(
                                        stream: Firestore.instance.collection('cost-type').orderBy('type', descending: false).snapshots(),
                                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                          if (!snapshot.hasData)
                                            return Container(
                                              child: Center(
                                                child: CircularProgressIndicator(),
                                              ),
                                            );

                                          return DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              labelText: 'Cost Type',
                                              labelStyle: TextStyle(fontSize: 16.0),
                                            ),
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Please select cost type';
                                              } else {
                                                return null;
                                              }
                                            },
                                            value: _costTypeSelection,
                                            onChanged: (String value) {
                                              setState(() {
                                                _costTypeSelection = value;
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
                                                      text: document['type'].toString(),
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
                                      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                                      child: StreamBuilder(
                                        stream: Firestore.instance.collection('vendor').orderBy('vendor', descending: false).snapshots(),
                                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                          if (!snapshot.hasData)
                                            return Container(
                                              child: Center(
                                                child: CircularProgressIndicator(),
                                              ),
                                            );

                                          return DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              labelText: 'Vendor',
                                              labelStyle: TextStyle(fontSize: 16.0),
                                            ),
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Please select vendor';
                                              } else {
                                                return null;
                                              }
                                            },
                                            value: _vendorSelection,
                                            onChanged: (String value) {
                                              setState(() {
                                                _vendorSelection = value;
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
                                                      text: document['vendor'].toString(),
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
                                      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText: 'Rate (IDR)',
                                          labelStyle: TextStyle(fontSize: 16.0),
                                        ),
                                        controller: rate,
                                        validator: (value) {
                                          if (value.length < 1) {
                                            return 'Please input rate (IDR)';
                                          } else {
                                            return null;
                                          }
                                        },
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
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText: 'Quantity',
                                          labelStyle: TextStyle(fontSize: 16.0),
                                        ),
                                        controller: quantity,
                                        validator: (value) {
                                          if (value.length < 1) {
                                            return 'Please input quantity';
                                          } else {
                                            return null;
                                          }
                                        },
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
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText: 'Amount',
                                          labelStyle: TextStyle(fontSize: 16.0),
                                        ),
                                        controller: amount,
                                        validator: (value) {
                                          if (value.length < 1) {
                                            return 'Please input amount';
                                          } else {
                                            return null;
                                          }
                                        },
                                        style: TextStyle(
                                          fontStyle: FontStyle.normal,
                                          color: Colors.black87,
                                          fontSize: 16.0),
                                        onSaved: null,
                                      ),
                                    ),
                                    trailing: IconButton(
                                      icon: Icon(Icons.add, color: AbubaPallate.greenabuba),
                                      onPressed: () {},
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
                                              '7. Project Benefits and Customers',
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
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
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
                                          decoration: InputDecoration(
                                            labelText: 'Process Owner',
                                            labelStyle: TextStyle(fontSize: 16.0),
                                          ),
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Please select process owner';
                                            } else {
                                              return null;
                                            }
                                          },
                                          value: _processOwnerSelection,
                                          onChanged: (String value) {
                                            setState(() {
                                              _processOwnerSelection = value;
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
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                                    child: DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        labelText: 'Key Stakeholders',
                                        labelStyle: TextStyle(fontSize: 16.0),
                                      ),
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Please select key stakeholders';
                                        } else {
                                          return null;
                                        }
                                      },
                                      value: _keyStakeholdersSelection,
                                      onChanged: (String value) {
                                        setState(() {
                                          switch (int.tryParse(value)) {
                                            case 1:
                                              _keyStakeholders = 'Supplier';
                                              break;
                                            case 2:
                                              _keyStakeholders = 'Customer';
                                              break;
                                            default:
                                              _keyStakeholders = '-';
                                              break;
                                          }
                                          _keyStakeholdersSelection = value;
                                        });
                                      },
                                      items: _keyStakeholdersJson.map((Map map) {
                                        return DropdownMenuItem(
                                          value: map['id'].toString(),
                                          child: Text(map['keyStakeholders'], style: TextStyle(fontSize: 16.0, color: Colors.black87, fontStyle: FontStyle.normal)),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                                    child: StreamBuilder(
                                      stream: Firestore.instance.collection('department').orderBy('department', descending: false).snapshots(),
                                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (!snapshot.hasData)
                                          return Container(
                                            child: Center(
                                              child: CircularProgressIndicator(),
                                            ),
                                          );

                                        return DropdownButtonFormField<String>(
                                          decoration: InputDecoration(
                                            labelText: 'Final Customer',
                                            labelStyle: TextStyle(fontSize: 16.0),
                                          ),
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Please select final customer';
                                            } else {
                                              return null;
                                            }
                                          },
                                          value: _finalCustomerSelection,
                                          onChanged: (String value) {
                                            setState(() {
                                              _finalCustomerSelection = value;
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
                                                    text: document['department'].toString(),
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
                                    padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelText: 'Expected Benefits',
                                        labelStyle: TextStyle(fontSize: 16.0),
                                      ),
                                      controller: exptectedBenefit,
                                      validator: (value) {
                                        if (value.length < 1) {
                                          return 'Please input expected benefits';
                                        } else {
                                          return null;
                                        }
                                      },
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
                                                    // if (_formKey.currentState.validate()) {
                                                      setState(() {
                                                        _autoValidate = false;
                                                      });
                                                      _cardController.animateTo(_cardController.index + 1);
                                                      _formKey.currentState.save();
                                                    // } else {
                                                      setState(() {
                                                        _autoValidate = true;
                                                      });
                                                    // }
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
                                              '8. Estimated Benefit',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '8 of ${_listData.length.toString()}',
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
                                  ListTile(
                                    title: Padding(
                                      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                                      child: StreamBuilder(
                                        stream: Firestore.instance.collection('type-benefit').orderBy('type', descending: false).snapshots(),
                                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                          if (!snapshot.hasData)
                                            return Container(
                                              child: Center(
                                                child: CircularProgressIndicator(),
                                              ),
                                            );

                                          return DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              labelText: 'Type of Benefit',
                                              labelStyle: TextStyle(fontSize: 16.0),
                                            ),
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Please select type of benefit';
                                              } else {
                                                return null;
                                              }
                                            },
                                            value: _typeOfBenefitSelection,
                                            onChanged: (String value) {
                                              setState(() {
                                                _typeOfBenefitSelection = value;
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
                                                      text: document['type'].toString(),
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
                                      onPressed: () {},
                                    ),
                                  ),
                                  ListTile(
                                    title: Padding(
                                      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                                      child: TextFormField(
                                        textCapitalization: TextCapitalization.sentences,
                                        decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText: 'Describe Basis of Estimate',
                                          labelStyle: TextStyle(fontSize: 16.0),
                                        ),
                                        maxLines: 3,
                                        maxLength: 250,
                                        controller: basisEstimated,
                                        validator: (value) {
                                          if (value.length < 10) {
                                            return 'Describe basis of estimated must be more than 10 character';
                                          } else if (value.length > 250) {
                                            return 'Describe basis of estimated must be less than 250 character';
                                          } else {
                                            return null;
                                          }
                                        },
                                        keyboardType: TextInputType.multiline,
                                        style: TextStyle(
                                          fontStyle: FontStyle.normal,
                                          color: Colors.black87,
                                          fontSize: 16.0),
                                        onSaved: null,
                                      ),
                                    ),
                                    trailing: IconButton(
                                      icon: Icon(Icons.add, color: Colors.white),
                                      onPressed: () {},
                                    ),
                                  ),
                                  ListTile(
                                    title: Padding(
                                      padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText: 'Estimated Benefit',
                                          labelStyle: TextStyle(fontSize: 16.0),
                                        ),
                                        controller: estimatedBenefit,
                                        validator: (value) {
                                          if (value.length < 1) {
                                            return 'Please input estimated benefit';
                                          } else {
                                            return null;
                                          }
                                        },
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(
                                          fontStyle: FontStyle.normal,
                                          color: Colors.black87,
                                          fontSize: 16.0),
                                        onSaved: null,
                                      ),
                                    ),
                                    trailing: IconButton(
                                      icon: Icon(Icons.add, color: AbubaPallate.greenabuba),
                                      onPressed: () {},
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
                                              '9. Risk, Constraints and Assumption',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '9 of ${_listData.length.toString()}',
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
                                        labelText: 'Risks',
                                        labelStyle: TextStyle(fontSize: 16.0),
                                      ),
                                      maxLength: 100,
                                      controller: risks,
                                      validator: (value) {
                                        if (value.length < 5) {
                                          return 'Risks must be more than 5 character';
                                        } else if (value.length > 100) {
                                          return 'Risks must be less than 100 character';
                                        } else {
                                          return null;
                                        }
                                      },
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
                                        labelText: 'Constraints',
                                        labelStyle: TextStyle(fontSize: 16.0),
                                      ),
                                      maxLength: 100,
                                      controller: constraints,
                                      validator: (value) {
                                        if (value.length < 5) {
                                          return 'Constraints must be more than 5 character';
                                        } else if (value.length > 100) {
                                          return 'Constraints must be less than 100 character';
                                        } else {
                                          return null;
                                        }
                                      },
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
                                        labelText: 'Assumption',
                                        labelStyle: TextStyle(fontSize: 16.0),
                                      ),
                                      maxLength: 100,
                                      controller: assumption,
                                      validator: (value) {
                                        if (value.length < 5) {
                                          return 'Assumption must be more than 5 character';
                                        } else if (value.length > 100) {
                                          return 'Assumption must be less than 100 character';
                                        } else {
                                          return null;
                                        }
                                      },
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

                                                        DocumentReference docReference = Firestore.instance.collection('projectCharter').document();

                                                        docReference.setData({
                                                          'userCreated': widget.idUser,
                                                          'dateCreated': DateTime.now(),
                                                          'projectCharterNo':maxid_projectCharter,
                                                          'projectName':projectName.text,
                                                          'projectSponsor': int.tryParse(_projectSponsorSelection),
                                                          'projectManager':int.tryParse(_projectManagerSelection),
                                                          'department':int.tryParse(_departmentSelection),
                                                          'processImpacted':int.tryParse(_processImpactedSelection),
                                                          'expectedStart':dateStart,
                                                          'expectedCompletion':dateCompletion,
                                                          'expectedSavings':int.tryParse(expectedSavings.text),
                                                          'estimatedCost':int.tryParse(estimatedCost.text),
                                                          'greenBelt':int.tryParse(_greenBeltSelection),
                                                          'blackBelt':int.tryParse(_blackBeltSelection),
                                                          'problemIssue':problemIssue.text,
                                                          'purpose':purpose.text,
                                                          'businessCase':businessCase.text,
                                                          'goalsMetric':int.tryParse(_goalsSelection),
                                                          'expectedDeliverables':int.tryParse(expectedDeliverables.text),
                                                          'withinScope':withingScope.text,
                                                          'outsideScope':outsideScope.text,
                                                          'fromProjectTeamStart':fromProjectTeamStart,
                                                          'fromProjectTeamEnd':fromProjectTeamEnd,
                                                          'preliminaryStart':preliminaryStart,
                                                          'preliminaryEnd':preliminaryEnd,
                                                          'defineStart':defineStart,
                                                          'defineEnd':defineEnd,
                                                          'measurementStart':measurementStart,
                                                          'measurementEnd':measurementEnd,
                                                          'analysisStart':analysisStart,
                                                          'analysisEnd':analysisEnd,
                                                          'improvementStart':improvementStart,
                                                          'improvementEnd':improvementEnd,
                                                          'controlStart':controlStart,
                                                          'controlEnd':controlEnd,
                                                          'projectSummaryStart':projectSummaryStart,
                                                          'projectSummaryEnd':projectSummaryEnd,
                                                          'closeOutStart':closeOutStart,
                                                          'closeOutEnd':closeOutEnd,
                                                          'projectTeamID': projectTeamID,
                                                          'projectTeamName':projectTeamName,
                                                          'supportResourcesID':supportResourcesID,
                                                          'supportResourcesName':supportResourcesName,
                                                          'specialNeedsID':specialNeedsID,
                                                          'specialNeedsName':specialNeedsName,
                                                          'costType':int.tryParse(_costTypeSelection),
                                                          'vendor':int.tryParse(_vendorSelection),
                                                          'rate': int.tryParse(rate.text),
                                                          'quantity':int.tryParse(quantity.text),
                                                          'amount': int.tryParse(amount.text),
                                                          'processOwner':int.tryParse(_processOwnerSelection),
                                                          'keyStakeholders':_keyStakeholders,
                                                          'finalCustomer':int.tryParse(_finalCustomerSelection),
                                                          'expectedBenefit':int.tryParse(exptectedBenefit.text),
                                                          'typeBenefit':int.tryParse(_typeOfBenefitSelection),
                                                          'basisEstimate':basisEstimated.text,
                                                          'estimatedBenefit':int.tryParse(estimatedBenefit.text),
                                                          'risks':risks.text,
                                                          'constraints':constraints.text,
                                                          'assumption':assumption.text,
                                                        }).then((doc) {
                                                          setState(() {
                                                            _isProccess = false;
                                                          });

                                                          DocumentReference documentReference =Firestore.instance.collection('dumper_maxid').document(index_projectCharter);

                                                          documentReference.updateData({
                                                            'maxid_projectCharter':maxid_projectCharter
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
                                                                        'Project Charter No. CHA-${maxid_projectCharter.toString().padLeft(4, '0')}',
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
            )
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