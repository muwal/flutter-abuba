import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:intl/intl.dart';

class FormFiveWhy extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  FormFiveWhy({this.idUser, this.namaUser, this.departmentUser});

  @override
  _FormFiveWhyState createState() => _FormFiveWhyState();
}

class _FormFiveWhyState extends State<FormFiveWhy> with TickerProviderStateMixin {
  bool _isProccess = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  final dateFormat = DateFormat("MMMM d, yyyy");
  final dateFormat2 = DateFormat("MMMM d, yyyy  h:mm a");

  List<Map> _listData = [ {'nomor': '1'}, {'nomor': '2'}, {'nomor': '3'}, {'nomor': '4'}, {'nomor': '5'}, {'nomor': '6'}];

  TextEditingController customerComplaint =TextEditingController();
  List<int> whoID = [];
  List<String> whoName = [];
  DateTime dateWhen;
  TimeOfDay timeWhen;
  DateTime dateWhy1;
  DateTime dateWhy2;
  DateTime dateWhy3;
  DateTime dateWhy4;
  DateTime dateWhy5;
  TextEditingController _controllerWhy1 = TextEditingController();
  TextEditingController _controllerWhy2 = TextEditingController();
  TextEditingController _controllerWhy3 = TextEditingController();
  TextEditingController _controllerWhy4 = TextEditingController();
  TextEditingController _controllerWhy5 = TextEditingController();
  TextEditingController tindakanPerbaikan1 = TextEditingController();
  TextEditingController tindakanPerbaikan2 = TextEditingController();
  TextEditingController tindakanPerbaikan3 = TextEditingController();
  TextEditingController tindakanPerbaikan4 = TextEditingController();
  TextEditingController tindakanPerbaikan5 = TextEditingController();

  bool _noteWhen = false;
  TextEditingController _controllerNoteWhen = new TextEditingController();
  bool _noteWhere = false;
  TextEditingController _controllerNoteWhere = new TextEditingController();

  String _whoSelection;
  String _whoSelection2;
  String _who;

  String _pelaksanaSelection;
  String _pelaksanaSelection2;
  String _pelaksanaSelectionDua;
  String _pelaksanaSelectionDua2;
  String _pelaksanaSelectionTiga;
  String _pelaksanaSelectionTiga2;
  String _pelaksanaSelectionEmpat;
  String _pelaksanaSelectionEmpat2;
  String _pelaksanaSelectionLima;
  String _pelaksanaSelectionLima2;

  List<int> pelaksanaID = [];
  List<String> pelaksanaName = [];
  List<int> pelaksanaIDDua = [];
  List<String> pelaksanaNameDua = [];
  List<int> pelaksanaIDTiga = [];
  List<String> pelaksanaNameTiga = [];
  List<int> pelaksanaIDEmpat = [];
  List<String> pelaksanaNameEmpat = [];
  List<int> pelaksanaIDLima = [];
  List<String> pelaksanaNameLima = [];
  String _shiftSelection;
  String _departmentSelection;
  String _divisiSelection;
  String _areaSelection;

  TabController _cardController;
  var maxid_fiveWhys;
  var index_fiveWhys;

  @override
  void initState() {
    super.initState();
    _cardController = new TabController(vsync: this, length: _listData.length);
    Firestore.instance.collection('dumper_fiveWhys').snapshots().listen((data) {
      setState(() {
        maxid_fiveWhys = data.documents[0].data['maxid_fiveWhys'] + 1;
        index_fiveWhys = data.documents[0].documentID;
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
                                              '1. Define The Problem',
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
                                            'WHAT',
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Flexible(
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 10.0, left: 20.0, top: 20.0, bottom: 20.0),
                                          child: Text(
                                            'Apa masalah yang sedang terjadi ?',
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 24.0
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                                    child: TextFormField(
                                      textCapitalization: TextCapitalization.sentences,
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelText: 'Customer Complaint',
                                        labelStyle: TextStyle(fontSize: 16.0),
                                      ),
                                      maxLines: 3,
                                      maxLength: 250,
                                      keyboardType: TextInputType.multiline,
                                      validator: (value) {
                                        if (value.length < 10) {
                                          return 'Customer complaint must be more than 10 character';
                                        } else if (value.length > 250) {
                                          return 'Customer complaint must be less than 250 character';
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller: customerComplaint,
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
                                              '1. Define The Problem',
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
                              padding: EdgeInsets.symmetric(vertical: 75.0),
                              color: Colors.white,
                              child: ListView(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Flexible(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                                          child: Text(
                                            'WHO',
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
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Flexible(
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 10.0, left: 20.0, top: 20.0, bottom: 20.0),
                                            child: Text(
                                              'Siapa yang terlibat dengan masalah ini ?',
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 24.0
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ListTile(
                                    title: Padding(
                                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0),
                                      child: StreamBuilder(
                                        stream: Firestore.instance.collection('user').orderBy('nama', descending: false).snapshots(),
                                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                          if (!snapshot.hasData)
                                            return Container(
                                              child: Center(
                                                child: CircularProgressIndicator(),
                                              ),
                                            );

                                          return DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              labelText: 'Who',
                                              labelStyle: TextStyle(fontSize: 16.0),
                                            ),
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Please select person';
                                              } else {
                                                return null;
                                              }
                                            },
                                            value: _whoSelection,
                                            onChanged: (String value) {
                                              Firestore.instance.collection('user').where('id', isEqualTo: int.tryParse(value)).snapshots().listen((data) {
                                                setState(() {
                                                  _whoSelection2 = data.documents[0].data['nama'];
                                                  _whoSelection = value;
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
                                          if (whoID.contains(int.tryParse(_whoSelection))) {

                                          } else {
                                            whoID.add(int.tryParse(_whoSelection));
                                          }
                                          if (whoName.contains(_whoSelection2)) {

                                          } else {
                                            whoName.add(_whoSelection2);
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(left: 15.0, right: 10.0, top: whoName.length == 0 ? 0.0 : 10.0, bottom: whoName.length == 0 ? 0.0 : 20.0),
                                    child: Wrap(
                                      spacing: 8.0,
                                      runSpacing: 4.0,
                                      runAlignment: WrapAlignment.start,
                                      direction: Axis.horizontal,
                                      children: whoName.length == 0
                                        ? [Container()]
                                        : whoName.map((String name) => Chip(
                                            label: Text(name),
                                            onDeleted: () {
                                              setState(() {
                                                whoID.removeAt(whoName.indexOf(name));
                                                whoName.remove(name);
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
                                                    if (_formKey.currentState.validate() && whoID.length > 0 && whoName.length > 0) {
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
                                              '1. Define The Problem',
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
                              height: MediaQuery.of(context).size.height * 0.7,
                              padding: EdgeInsets.symmetric(vertical: 25.0),
                              color: Colors.white,
                              alignment: Alignment.center,
                              child: ListView(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Flexible(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                                          child: Text(
                                            'WHEN',
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Flexible(
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 10.0, left: 20.0, top: 20.0, bottom: 20.0),
                                          child: Text(
                                            'Kapan masalah ini terjadi ?',
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 24.0
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
                                    child: DateTimePickerFormField(
                                      format: dateFormat2,
                                      onChanged: (dt) => setState(() => dateWhen = dt),
                                      dateOnly: false,
                                      editable: false,
                                      resetIcon: null,
                                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelStyle: TextStyle(fontSize: 16.0),
                                        labelText: 'Date and Time'
                                      ),
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
                                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
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
                                              return 'Please select shift';
                                            } else {
                                              return null;
                                            }
                                          },
                                          value: _shiftSelection,
                                          onChanged: (String value) {
                                            setState(() {
                                              _shiftSelection = value;
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(right: 20.0),
                                        child: ButtonTheme(
                                          minWidth: 50.0,
                                          height: 35.0,
                                          child: RaisedButton(
                                            color: AbubaPallate.menuBluebird,
                                            child: Text(
                                              'Note',
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _noteWhen = !_noteWhen;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  _noteWhen
                                    ? Container(
                                        padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                                        width: MediaQuery.of(context).size.width,
                                        child: TextField(
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Note',
                                            labelStyle: TextStyle(fontSize: 16.0)),
                                          maxLines: 3,
                                          maxLength: 250,
                                          controller: _controllerNoteWhen,
                                          style: TextStyle(color: Colors.black, fontSize: 16.0),
                                        ),
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
                                              '1. Define The Problem',
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
                              height: MediaQuery.of(context).size.height * 0.7,
                              padding: EdgeInsets.symmetric(vertical: 25.0),
                              color: Colors.white,
                              alignment: Alignment.center,
                              child: ListView(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Flexible(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                                          child: Text(
                                            'WHERE',
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Flexible(
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 10.0, left: 20.0, top: 20.0, bottom: 20.0),
                                          child: Text(
                                            'Dimana lokasi masalah ditemukan ?',
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 24.0
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
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
                                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
                                    child: StreamBuilder(
                                      stream: Firestore.instance.collection('divisi').orderBy('divisi', descending: false).snapshots(),
                                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (!snapshot.hasData)
                                          return Container(
                                            child: Center(
                                              child: CircularProgressIndicator(),
                                            ),
                                          );

                                        return DropdownButtonFormField<String>(
                                          decoration: InputDecoration(
                                            labelText: 'Divisi',
                                            labelStyle: TextStyle(fontSize: 16.0),
                                          ),
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Please select divisi';
                                            } else {
                                              return null;
                                            }
                                          },
                                          value: _divisiSelection,
                                          onChanged: (String value) {
                                            setState(() {
                                              _divisiSelection = value;
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
                                                    text: document['divisi'].toString(),
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
                                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
                                    child: StreamBuilder(
                                      stream: Firestore.instance.collection('area').orderBy('area', descending: false).snapshots(),
                                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (!snapshot.hasData)
                                          return Container(
                                            child: Center(
                                              child: CircularProgressIndicator(),
                                            ),
                                          );

                                        return DropdownButtonFormField<String>(
                                          decoration: InputDecoration(
                                            labelText: 'Area',
                                            labelStyle: TextStyle(fontSize: 16.0),
                                          ),
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Please select area';
                                            } else {
                                              return null;
                                            }
                                          },
                                          value: _areaSelection,
                                          onChanged: (String value) {
                                            setState(() {
                                              _areaSelection = value;
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
                                                    text: document['area'].toString(),
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(right: 20.0),
                                        child: ButtonTheme(
                                          minWidth: 50.0,
                                          height: 35.0,
                                          child: RaisedButton(
                                            color: AbubaPallate.menuBluebird,
                                            child: Text(
                                              'Note',
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _noteWhere = !_noteWhere;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  _noteWhere
                                    ? Container(
                                        padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                                        width: MediaQuery.of(context).size.width,
                                        child: TextField(
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Note',
                                              labelStyle: TextStyle(fontSize: 16.0)),
                                          maxLines: 3,
                                          maxLength: 250,
                                          controller: _controllerNoteWhere,
                                          style: TextStyle(color: Colors.black, fontSize: 16.0),
                                        ),
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
                                              '2. Primary Cause',
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
                              height: MediaQuery.of(context).size.height * 0.7,
                              padding: EdgeInsets.symmetric(vertical: 25.0),
                              color: Colors.white,
                              child: ListView(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                                    child: TextFormField(
                                      textCapitalization: TextCapitalization.sentences,
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelText: 'WHY 1 - Mengapa hal tersebut bisa terjadi ?',
                                        labelStyle: TextStyle(fontSize: 16.0),
                                      ),
                                      maxLines: 3,
                                      keyboardType: TextInputType.multiline,
                                      maxLength: 250,
                                      validator: (value) {
                                        if (value.length < 10) {
                                          return 'Why 1 must be more than 10 character';
                                        } else if (value.length > 250) {
                                          return 'Why 1 must be less than 250 character';
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller: _controllerWhy1,
                                      style: TextStyle(
                                        fontStyle: FontStyle.normal,
                                        color: Colors.black87,
                                        fontSize: 16.0),
                                      onSaved: null,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                                    child: TextFormField(
                                      textCapitalization: TextCapitalization.sentences,
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelText: 'WHY 2 - Mengapa begitu ?',
                                        labelStyle: TextStyle(fontSize: 16.0),
                                      ),
                                      maxLines: 3,
                                      keyboardType: TextInputType.multiline,
                                      controller: _controllerWhy2,
                                      maxLength: 250,
                                      validator: (value) {
                                        if (value.length < 10) {
                                          return 'Why 2 must be more than 10 character';
                                        } else if (value.length > 250) {
                                          return 'Why 2 must be less than 250 character';
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
                                    child: TextFormField(
                                      textCapitalization: TextCapitalization.sentences,
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelText: 'WHY 3 - Mengapa begitu ?',
                                        labelStyle: TextStyle(fontSize: 16.0),
                                      ),
                                      maxLines: 3,
                                      keyboardType: TextInputType.multiline,
                                      controller: _controllerWhy3,
                                      maxLength: 250,
                                      validator: (value) {
                                        if (value.length < 10) {
                                          return 'Why 3 must be more than 10 character';
                                        } else if (value.length > 250) {
                                          return 'Why 3 must be less than 250 character';
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
                                    child: TextFormField(
                                      textCapitalization: TextCapitalization.sentences,
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelText: 'WHY 4 - Mengapa begitu ?',
                                        labelStyle: TextStyle(fontSize: 16.0),
                                      ),
                                      maxLines: 3,
                                      keyboardType: TextInputType.multiline,
                                      controller: _controllerWhy4,
                                      maxLength: 250,
                                      validator: (value) {
                                        if (value.length < 10) {
                                          return 'Why 4 must be more than 10 character';
                                        } else if (value.length > 250) {
                                          return 'Why 4 must be less than 250 character';
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
                                    child: TextFormField(
                                      textCapitalization: TextCapitalization.sentences,
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(),
                                        labelText: 'WHY 5 - Mengapa begitu ?',
                                        labelStyle: TextStyle(fontSize: 16.0),
                                      ),
                                      maxLines: 3,
                                      keyboardType: TextInputType.multiline,
                                      controller: _controllerWhy5,
                                      maxLength: 250,
                                      validator: (value) {
                                        if (value.length < 10) {
                                          return 'Why 5 must be more than 10 character';
                                        } else if (value.length > 250) {
                                          return 'Why 5 must be less than 250 character';
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
                                              '3. Corrective Action',
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
                              height: MediaQuery.of(context).size.height * 0.7,
                              padding: EdgeInsets.symmetric(vertical: 15.0),
                              color: Colors.white,
                              child: ListView(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                children: <Widget>[
                                  Container(
                                    color: Colors.white,
                                    child: ExpansionTile(
                                      title: Text(
                                        'WHY 1',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
                                          child: Text(
                                            _controllerWhy1.text.isEmpty ? 'Keterangan Why 1' : _controllerWhy1.text,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black38
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                          child: TextFormField(
                                            textCapitalization: TextCapitalization.sentences,
                                            decoration: InputDecoration(
                                              border: UnderlineInputBorder(),
                                              labelText: 'Tindakan Perbaikan',
                                              labelStyle: TextStyle(fontSize: 16.0),
                                            ),
                                            maxLines: 3,
                                            keyboardType: TextInputType.multiline,
                                            maxLength: 250,
                                            controller: tindakanPerbaikan1,
                                            validator: (value) {
                                              if (value.length < 10) {
                                                return 'Tindakan perbaikan must be more than 5 character';
                                              } else if (value.length > 250) {
                                                return 'Tindakan perbaikan mush be less than 100 character';
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
                                          padding: EdgeInsets.only(bottom: 15.0, left: 15.0, right: 15.0),
                                          child: DateTimePickerFormField(
                                            format: dateFormat,
                                            onChanged: (dt) => setState(() => dateWhy1 = dt),
                                            dateOnly: true,
                                            editable: false,
                                            resetIcon: null,
                                            style: TextStyle(fontSize: 16.0, color: Colors.black),
                                            decoration: InputDecoration(
                                              border: UnderlineInputBorder(),
                                              labelStyle: TextStyle(fontSize: 16.0),
                                              labelText: 'Date'
                                            ),
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Please select date';
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ),
                                        ListTile(
                                          title: Padding(
                                            padding: EdgeInsets.only(bottom: 10.0),
                                            child: StreamBuilder(
                                              stream: Firestore.instance.collection('user').orderBy('nama', descending: false).snapshots(),
                                              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                                if (!snapshot.hasData)
                                                  return Container(
                                                    child: Center(
                                                      child: CircularProgressIndicator(),
                                                    ),
                                                  );

                                                return DropdownButtonFormField<String>(
                                                  decoration: InputDecoration(
                                                    labelText: 'Pelaksana',
                                                    labelStyle: TextStyle(fontSize: 16.0),
                                                  ),
                                                  validator: (value) {
                                                    if (value == null) {
                                                      return 'Please select pelaksana';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  value: _pelaksanaSelection,
                                                  onChanged: (String value) {
                                                    Firestore.instance.collection('user').where('id', isEqualTo: int.tryParse(value)).snapshots().listen((data) {
                                                      setState(() {
                                                        _pelaksanaSelection2 = data.documents[0].data['nama'];
                                                        _pelaksanaSelection = value;
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
                                                if (pelaksanaID.contains(int.tryParse(_pelaksanaSelection))) {

                                                } else {
                                                  pelaksanaID.add(int.tryParse(_pelaksanaSelection));
                                                }
                                                if (pelaksanaName.contains(_pelaksanaSelection2)) {

                                                } else {
                                                  pelaksanaName.add(_pelaksanaSelection2);
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.only(left: 15.0, right: 10.0, top: pelaksanaName.length == 0 ? 0.0 : 10.0, bottom: pelaksanaName.length == 0 ? 0.0 : 20.0),
                                          child: Wrap(
                                            spacing: 8.0,
                                            runSpacing: 4.0,
                                            runAlignment: WrapAlignment.start,
                                            direction: Axis.horizontal,
                                            children: pelaksanaName.length == 0
                                              ? [Container()]
                                              : pelaksanaName.map((String name) => Chip(
                                                  label: Text(name),
                                                  onDeleted: () {
                                                    setState(() {
                                                      pelaksanaID.removeAt(pelaksanaName.indexOf(name));
                                                      pelaksanaName.remove(name);
                                                    });
                                                  },
                                                )).toList(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    color: Colors.white,
                                    child: ExpansionTile(
                                      title: Text(
                                        'WHY 2',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
                                          child: Text(
                                            _controllerWhy2.text.isEmpty ? 'Keterangan Why 2' : _controllerWhy2.text,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black38
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                          child: TextFormField(
                                            textCapitalization: TextCapitalization.sentences,
                                            decoration: InputDecoration(
                                              border: UnderlineInputBorder(),
                                              labelText: 'Tindakan Perbaikan',
                                              labelStyle: TextStyle(fontSize: 16.0),
                                            ),
                                            maxLines: 3,
                                            keyboardType: TextInputType.multiline,
                                            maxLength: 250,
                                            controller: tindakanPerbaikan2,
                                            validator: (value) {
                                              if (value.length < 10) {
                                                return 'Tindakan perbaikan must be more than 5 character';
                                              } else if (value.length > 250) {
                                                return 'Tindakan perbaikan mush be less than 100 character';
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
                                          padding: EdgeInsets.only(bottom: 15.0, left: 15.0, right: 15.0),
                                          child: DateTimePickerFormField(
                                            format: dateFormat,
                                            onChanged: (dt) => setState(() => dateWhy2 = dt),
                                            dateOnly: true,
                                            editable: false,
                                            resetIcon: null,
                                            style: TextStyle(fontSize: 16.0, color: Colors.black),
                                            decoration: InputDecoration(
                                              border: UnderlineInputBorder(),
                                              labelStyle: TextStyle(fontSize: 16.0),
                                              labelText: 'Date'
                                            ),
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Please select date';
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ),
                                        ListTile(
                                          title: Padding(
                                            padding: EdgeInsets.only(bottom: 10.0),
                                            child: StreamBuilder(
                                              stream: Firestore.instance.collection('user').orderBy('nama', descending: false).snapshots(),
                                              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                                if (!snapshot.hasData)
                                                  return Container(
                                                    child: Center(
                                                      child: CircularProgressIndicator(),
                                                    ),
                                                  );

                                                return DropdownButtonFormField<String>(
                                                  decoration: InputDecoration(
                                                    labelText: 'Pelaksana',
                                                    labelStyle: TextStyle(fontSize: 16.0),
                                                  ),
                                                  validator: (value) {
                                                    if (value == null) {
                                                      return 'Please select pelaksana';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  value: _pelaksanaSelectionDua,
                                                  onChanged: (String value) {
                                                    Firestore.instance.collection('user').where('id', isEqualTo: int.tryParse(value)).snapshots().listen((data) {
                                                      setState(() {
                                                        _pelaksanaSelectionDua2 = data.documents[0].data['nama'];
                                                        _pelaksanaSelectionDua = value;
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
                                                if (pelaksanaIDDua.contains(int.tryParse(_pelaksanaSelectionDua))) {

                                                } else {
                                                  pelaksanaIDDua.add(int.tryParse(_pelaksanaSelectionDua));
                                                }
                                                if (pelaksanaNameDua.contains(_pelaksanaSelectionDua2)) {

                                                } else {
                                                  pelaksanaNameDua.add(_pelaksanaSelectionDua2);
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.only(left: 15.0, right: 10.0, top: pelaksanaNameDua.length == 0 ? 0.0 : 10.0, bottom: pelaksanaNameDua.length == 0 ? 0.0 : 20.0),
                                          child: Wrap(
                                            spacing: 8.0,
                                            runSpacing: 4.0,
                                            runAlignment: WrapAlignment.start,
                                            direction: Axis.horizontal,
                                            children: pelaksanaNameDua.length == 0
                                              ? [Container()]
                                              : pelaksanaNameDua.map((String name) => Chip(
                                                  label: Text(name),
                                                  onDeleted: () {
                                                    setState(() {
                                                      pelaksanaIDDua.removeAt(pelaksanaNameDua.indexOf(name));
                                                      pelaksanaNameDua.remove(name);
                                                    });
                                                  },
                                                )).toList(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    color: Colors.white,
                                    child: ExpansionTile(
                                      title: Text(
                                        'WHY 3',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
                                          child: Text(
                                            _controllerWhy3.text.isEmpty ? 'Keterangan Why 3' : _controllerWhy3.text,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black38
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                          child: TextFormField(
                                            textCapitalization: TextCapitalization.sentences,
                                            decoration: InputDecoration(
                                              border: UnderlineInputBorder(),
                                              labelText: 'Tindakan Perbaikan',
                                              labelStyle: TextStyle(fontSize: 16.0),
                                            ),
                                            maxLines: 3,
                                            keyboardType: TextInputType.multiline,
                                            maxLength: 250,
                                            controller: tindakanPerbaikan3,
                                            validator: (value) {
                                              if (value.length < 10) {
                                                return 'Tindakan perbaikan must be more than 5 character';
                                              } else if (value.length > 250) {
                                                return 'Tindakan perbaikan mush be less than 100 character';
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
                                          padding: EdgeInsets.only(bottom: 15.0, left: 15.0, right: 15.0),
                                          child: DateTimePickerFormField(
                                            format: dateFormat,
                                            onChanged: (dt) => setState(() => dateWhy3 = dt),
                                            dateOnly: true,
                                            editable: false,
                                            resetIcon: null,
                                            style: TextStyle(fontSize: 16.0, color: Colors.black),
                                            decoration: InputDecoration(
                                              border: UnderlineInputBorder(),
                                              labelStyle: TextStyle(fontSize: 16.0),
                                              labelText: 'Date'
                                            ),
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Please select date';
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ),
                                        ListTile(
                                          title: Padding(
                                            padding: EdgeInsets.only(bottom: 10.0),
                                            child: StreamBuilder(
                                              stream: Firestore.instance.collection('user').orderBy('nama', descending: false).snapshots(),
                                              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                                if (!snapshot.hasData)
                                                  return Container(
                                                    child: Center(
                                                      child: CircularProgressIndicator(),
                                                    ),
                                                  );

                                                return DropdownButtonFormField<String>(
                                                  decoration: InputDecoration(
                                                    labelText: 'Pelaksana',
                                                    labelStyle: TextStyle(fontSize: 16.0),
                                                  ),
                                                  validator: (value) {
                                                    if (value == null) {
                                                      return 'Please select pelaksana';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  value: _pelaksanaSelectionTiga,
                                                  onChanged: (String value) {
                                                    Firestore.instance.collection('user').where('id', isEqualTo: int.tryParse(value)).snapshots().listen((data) {
                                                      setState(() {
                                                        _pelaksanaSelectionTiga2 = data.documents[0].data['nama'];
                                                        _pelaksanaSelectionTiga = value;
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
                                                if (pelaksanaIDTiga.contains(int.tryParse(_pelaksanaSelectionTiga))) {

                                                } else {
                                                  pelaksanaIDTiga.add(int.tryParse(_pelaksanaSelectionTiga));
                                                }
                                                if (pelaksanaNameTiga.contains(_pelaksanaSelectionTiga2)) {

                                                } else {
                                                  pelaksanaNameTiga.add(_pelaksanaSelectionTiga2);
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.only(left: 15.0, right: 10.0, top: pelaksanaNameTiga.length == 0 ? 0.0 : 10.0, bottom: pelaksanaNameTiga.length == 0 ? 0.0 : 20.0),
                                          child: Wrap(
                                            spacing: 8.0,
                                            runSpacing: 4.0,
                                            runAlignment: WrapAlignment.start,
                                            direction: Axis.horizontal,
                                            children: pelaksanaNameTiga.length == 0
                                              ? [Container()]
                                              : pelaksanaNameTiga.map((String name) => Chip(
                                                  label: Text(name),
                                                  onDeleted: () {
                                                    setState(() {
                                                      pelaksanaIDTiga.removeAt(pelaksanaNameTiga.indexOf(name));
                                                      pelaksanaNameTiga.remove(name);
                                                    });
                                                  },
                                                )).toList(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    color: Colors.white,
                                    child: ExpansionTile(
                                      title: Text(
                                        'WHY 4',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
                                          child: Text(
                                            _controllerWhy4.text.isEmpty ? 'Keterangan Why 4' : _controllerWhy4.text,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black38
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                          child: TextFormField(
                                            textCapitalization: TextCapitalization.sentences,
                                            decoration: InputDecoration(
                                              border: UnderlineInputBorder(),
                                              labelText: 'Tindakan Perbaikan',
                                              labelStyle: TextStyle(fontSize: 16.0),
                                            ),
                                            maxLines: 3,
                                            keyboardType: TextInputType.multiline,
                                            maxLength: 250,
                                            controller: tindakanPerbaikan4,
                                            validator: (value) {
                                              if (value.length < 10) {
                                                return 'Tindakan perbaikan must be more than 5 character';
                                              } else if (value.length > 250) {
                                                return 'Tindakan perbaikan mush be less than 100 character';
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
                                          padding: EdgeInsets.only(bottom: 15.0, left: 15.0, right: 15.0),
                                          child: DateTimePickerFormField(
                                            format: dateFormat,
                                            onChanged: (dt) => setState(() => dateWhy4 = dt),
                                            dateOnly: true,
                                            editable: false,
                                            resetIcon: null,
                                            style: TextStyle(fontSize: 16.0, color: Colors.black),
                                            decoration: InputDecoration(
                                              border: UnderlineInputBorder(),
                                              labelStyle: TextStyle(fontSize: 16.0),
                                              labelText: 'Date'
                                            ),
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Please select date';
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ),
                                        ListTile(
                                          title: Padding(
                                            padding: EdgeInsets.only(bottom: 10.0),
                                            child: StreamBuilder(
                                              stream: Firestore.instance.collection('user').orderBy('nama', descending: false).snapshots(),
                                              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                                if (!snapshot.hasData)
                                                  return Container(
                                                    child: Center(
                                                      child: CircularProgressIndicator(),
                                                    ),
                                                  );

                                                return DropdownButtonFormField<String>(
                                                  decoration: InputDecoration(
                                                    labelText: 'Pelaksana',
                                                    labelStyle: TextStyle(fontSize: 16.0),
                                                  ),
                                                  validator: (value) {
                                                    if (value == null) {
                                                      return 'Please select pelaksana';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  value: _pelaksanaSelectionEmpat,
                                                  onChanged: (String value) {
                                                    Firestore.instance.collection('user').where('id', isEqualTo: int.tryParse(value)).snapshots().listen((data) {
                                                      setState(() {
                                                        _pelaksanaSelectionEmpat2 = data.documents[0].data['nama'];
                                                        _pelaksanaSelectionEmpat = value;
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
                                                if (pelaksanaIDEmpat.contains(int.tryParse(_pelaksanaSelectionEmpat))) {

                                                } else {
                                                  pelaksanaIDEmpat.add(int.tryParse(_pelaksanaSelectionEmpat));
                                                }
                                                if (pelaksanaNameEmpat.contains(_pelaksanaSelectionEmpat2)) {

                                                } else {
                                                  pelaksanaNameEmpat.add(_pelaksanaSelectionEmpat2);
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.only(left: 15.0, right: 10.0, top: pelaksanaNameEmpat.length == 0 ? 0.0 : 10.0, bottom: pelaksanaNameEmpat.length == 0 ? 0.0 : 20.0),
                                          child: Wrap(
                                            spacing: 8.0,
                                            runSpacing: 4.0,
                                            runAlignment: WrapAlignment.start,
                                            direction: Axis.horizontal,
                                            children: pelaksanaNameEmpat.length == 0
                                              ? [Container()]
                                              : pelaksanaNameEmpat.map((String name) => Chip(
                                                  label: Text(name),
                                                  onDeleted: () {
                                                    setState(() {
                                                      pelaksanaIDEmpat.removeAt(pelaksanaNameEmpat.indexOf(name));
                                                      pelaksanaNameEmpat.remove(name);
                                                    });
                                                  },
                                                )).toList(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    color: Colors.white,
                                    child: ExpansionTile(
                                      title: Text(
                                        'WHY 5',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
                                          child: Text(
                                            _controllerWhy5.text.isEmpty ? 'Keterangan Why 5' : _controllerWhy5.text,
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black38
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                                          child: TextFormField(
                                            textCapitalization: TextCapitalization.sentences,
                                            decoration: InputDecoration(
                                              border: UnderlineInputBorder(),
                                              labelText: 'Tindakan Perbaikan',
                                              labelStyle: TextStyle(fontSize: 16.0),
                                            ),
                                            maxLines: 3,
                                            keyboardType: TextInputType.multiline,
                                            maxLength: 250,
                                            controller: tindakanPerbaikan5,
                                            validator: (value) {
                                              if (value.length < 10) {
                                                return 'Tindakan perbaikan must be more than 5 character';
                                              } else if (value.length > 250) {
                                                return 'Tindakan perbaikan mush be less than 100 character';
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
                                          padding: EdgeInsets.only(bottom: 15.0, left: 15.0, right: 15.0),
                                          child: DateTimePickerFormField(
                                            format: dateFormat,
                                            onChanged: (dt) => setState(() => dateWhy5 = dt),
                                            dateOnly: true,
                                            editable: false,
                                            resetIcon: null,
                                            style: TextStyle(fontSize: 16.0, color: Colors.black),
                                            decoration: InputDecoration(
                                              border: UnderlineInputBorder(),
                                              labelStyle: TextStyle(fontSize: 16.0),
                                              labelText: 'Date'
                                            ),
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Please select date';
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ),
                                        ListTile(
                                          title: Padding(
                                            padding: EdgeInsets.only(bottom: 10.0),
                                            child: StreamBuilder(
                                              stream: Firestore.instance.collection('user').orderBy('nama', descending: false).snapshots(),
                                              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                                if (!snapshot.hasData)
                                                  return Container(
                                                    child: Center(
                                                      child: CircularProgressIndicator(),
                                                    ),
                                                  );

                                                return DropdownButtonFormField<String>(
                                                  decoration: InputDecoration(
                                                    labelText: 'Pelaksana',
                                                    labelStyle: TextStyle(fontSize: 16.0),
                                                  ),
                                                  validator: (value) {
                                                    if (value == null) {
                                                      return 'Please select pelaksana';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  value: _pelaksanaSelectionLima,
                                                  onChanged: (String value) {
                                                    Firestore.instance.collection('user').where('id', isEqualTo: int.tryParse(value)).snapshots().listen((data) {
                                                      setState(() {
                                                        _pelaksanaSelectionLima2 = data.documents[0].data['nama'];
                                                        _pelaksanaSelectionLima = value;
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
                                                if (pelaksanaIDLima.contains(int.tryParse(_pelaksanaSelectionLima))) {

                                                } else {
                                                  pelaksanaIDLima.add(int.tryParse(_pelaksanaSelectionLima));
                                                }
                                                if (pelaksanaNameLima.contains(_pelaksanaSelectionLima2)) {

                                                } else {
                                                  pelaksanaNameLima.add(_pelaksanaSelectionLima2);
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.only(left: 15.0, right: 10.0, top: pelaksanaNameLima.length == 0 ? 0.0 : 10.0, bottom: pelaksanaNameLima.length == 0 ? 0.0 : 20.0),
                                          child: Wrap(
                                            spacing: 8.0,
                                            runSpacing: 4.0,
                                            runAlignment: WrapAlignment.start,
                                            direction: Axis.horizontal,
                                            children: pelaksanaNameLima.length == 0
                                              ? [Container()]
                                              : pelaksanaNameLima.map((String name) => Chip(
                                                  label: Text(name),
                                                  onDeleted: () {
                                                    setState(() {
                                                      pelaksanaIDLima.removeAt(pelaksanaNameLima.indexOf(name));
                                                      pelaksanaNameLima.remove(name);
                                                    });
                                                  },
                                                )).toList(),
                                          ),
                                        ),
                                      ],
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

                                                        DocumentReference docReference = Firestore.instance.collection('fiveWhys').document();

                                                        docReference.setData({
                                                          'userCreated': widget.idUser,
                                                          'dateCreated': DateTime.now(),
                                                          'customerComplaint':customerComplaint.text,
                                                          'whoID':whoID,
                                                          'whoName':whoName,
                                                          'dateWhen':dateWhen,
                                                          'shift': int.tryParse(_shiftSelection),
                                                          'noteWhen':_controllerNoteWhen.text,
                                                          'department':int.tryParse(_departmentSelection),
                                                          'divisi':int.tryParse(_divisiSelection),
                                                          'area':int.tryParse(_areaSelection),
                                                          'noteWhere':_controllerNoteWhere.text,
                                                          'why1':_controllerWhy1.text,
                                                          'why2':_controllerWhy2.text,
                                                          'why3':_controllerWhy3.text,
                                                          'why4':_controllerWhy4.text,
                                                          'why5':_controllerWhy5.text,
                                                          'perbaikan1': tindakanPerbaikan1.text,
                                                          'perbaikan2': tindakanPerbaikan2.text,
                                                          'perbaikan3': tindakanPerbaikan3.text,
                                                          'perbaikan4': tindakanPerbaikan4.text,
                                                          'perbaikan5': tindakanPerbaikan5.text,
                                                          'dateWhy1':dateWhy1,
                                                          'dateWhy2':dateWhy2,
                                                          'dateWhy3':dateWhy3,
                                                          'dateWhy4':dateWhy4,
                                                          'dateWhy5':dateWhy5,
                                                          'pelaksanaID1':pelaksanaID,
                                                          'pelaksanaName1':pelaksanaName,
                                                          'pelaksanaID2':pelaksanaIDDua,
                                                          'pelaksanaName2':pelaksanaNameDua,
                                                          'pelaksanaID3':pelaksanaIDTiga,
                                                          'pelaksanaName3':pelaksanaNameTiga,
                                                          'pelaksanaID4':pelaksanaIDEmpat,
                                                          'pelaksanaName4':pelaksanaNameEmpat,
                                                          'pelaksanaID5':pelaksanaIDLima,
                                                          'pelaksanaName5':pelaksanaNameLima,
                                                          'fiveWhysNo':maxid_fiveWhys,
                                                        }).then((doc) {
                                                          setState(() {
                                                            _isProccess = false;
                                                          });

                                                          DocumentReference documentReference =Firestore.instance.collection('dumper_fiveWhys').document(index_fiveWhys);

                                                          documentReference.updateData({
                                                            'maxid_fiveWhys':maxid_fiveWhys
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
                                                                        '5 Why No. FHY-${maxid_fiveWhys.toString().padLeft(4, '0')}',
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