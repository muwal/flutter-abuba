import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:intl/intl.dart';

class FormProblem extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  FormProblem({this.idUser, this.namaUser, this.departmentUser});

  @override
  _FormProblemState createState() => _FormProblemState();
}

class _FormProblemState extends State<FormProblem> with TickerProviderStateMixin {
  bool _isProccess = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  final dateFormat2 = DateFormat("MMMM d, yyyy  h:mm a");
  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime dateWhen;

  List<int> whoID = [];
  List<String> whoName = [];
  List<int> participantsID = [];
  List<String> participantsName = [];
  String _whatSelection;
  String _whoSelection;
  String _whoSelection2;
  String _shiftSelection;
  String howSevere;
  bool team = false;
  String _departmentSelection;
  String _divisiSelection;
  String _areaSelection;
  String _whySelection;
  String _championSelection;
  String championName;
  String _leaderSelection;
  String leaderName;
  String _recordSelection;
  String recordName;
  String _participantSelection;
  String _participantSelection2;
  List<int> partisipanID = [];
  List<String> partisipanName = [];
  DateTime waktuPelaksanaan;
  String _pelaksanaSelection;

  TextEditingController tindakanSegera =TextEditingController();

  String tindakanPermanen;
  String whoTindakanPermanen;
  DateTime whenTindakanPermanen;
  String bukti = '';
  String efektifitas;

  String verifikasiWho;
  DateTime verifikasiWhen;
  String validasiWho;
  DateTime validasiWhen;

  TextEditingController taskLeader =TextEditingController();
  DateTime duedateLeader;
  List<String> taskLeaderArray = [];
  List<DateTime> duedateLeaderArray = [];
  List<bool> statusTaskLeader = [];

  TextEditingController taskRecordKeeper =TextEditingController();
  DateTime duedateRecordKeeper;
  List<String> taskRecordKeeperArray = [];
  List<DateTime> duedateRecordKeeperArray = [];
  List<bool> statusTaskRecordKeeper = [];

  TextEditingController taskParticipants =TextEditingController();
  DateTime duedateParticipants;
  List<String> taskParticipantsArray = [];
  List<DateTime> duedateParticipantsArray = [];
  List<int> whoParticipantsID = [];
  List<String> whoParticipantsName = [];
  List<bool> statusTaskParticipants = [];

  bool noteWhat = false;
  bool noteWhen = false;
  bool noteWhere = false;
  bool noteWhy = false;
  bool noteHowSevere = false;
  bool noteWhatTindakanPermanen = false;
  bool noteWhoTindakanPermanen = false;
  bool noteWhenTindakanPermanen = false;
  bool noteBukti = false;
  bool noteEfektifitas = false;

  TextEditingController controllernoteWhat = TextEditingController();
  TextEditingController controllernoteWhen = TextEditingController();
  TextEditingController controllernoteWhere = TextEditingController();
  TextEditingController controllernoteWhy = TextEditingController();
  TextEditingController controllernoteHowSevere = TextEditingController();
  TextEditingController controllernoteWhatTindakanPermanen = TextEditingController();
  TextEditingController controllernoteWhoTindakanPermanen = TextEditingController();
  TextEditingController controllernoteWhenTindakanPermanen = TextEditingController();
  TextEditingController controllernoteBukti = TextEditingController();
  TextEditingController controllernoteEfektifitas = TextEditingController();

  Color _colorLowSe = Colors.grey;
  Color _colorMedSe = Colors.grey;
  Color _colorHighSe = Colors.grey;

  List<Map> _title = [
    {'nomor': 1},{'nomor': 2},{'nomor': 3},{'nomor': 4},{'nomor': 5},{'nomor': 6},{'nomor': 7},{'nomor': 8},{'nomor': 9},{'nomor': 10},{'nomor': 11},{'nomor': 12},{'nomor': 13},{'nomor': 14},{'nomor': 15},{'nomor': 16},{'nomor': 17},{'nomor': 18},{'nomor': 19},{'nomor': 20},{'nomor': 21},{'nomor': 22},{'nomor': 23},{'nomor': 24},{'nomor': 25},{'nomor': 26},{'nomor': 27},{'nomor': 28},{'nomor': 29},{'nomor': 30},{'nomor': 31},{'nomor': 32},{'nomor': 33},{'nomor': 34},{'nomor': 35},
  ];

  TabController _cardController;
  var maxidProblemSolving;
  var indexProblemSolving;

  @override
  void initState() {
    super.initState();
    _cardController = new TabController(vsync: this, length: 35);
    Firestore.instance.collection('dumper_problemSolving').snapshots().listen((data) {
      setState(() {
        maxidProblemSolving = data.documents[0].data['maxid_problemSolving'] + 1;
        indexProblemSolving = data.documents[0].documentID;
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
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height * 0.7;

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
                      physics: ScrollPhysics(),
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
                                    width: width,
                                    height: 55.0,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '1. Identify Problem',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '1 of ${_title.length.toString()}',
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
                              height: height,
                              padding: EdgeInsets.symmetric(vertical: 75.0),
                              color: Colors.white,
                              alignment: Alignment.center,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                                                child: Text(
                                                  '1. Sebutkan dengan jelas masalah yang akan diselesaikan\n\n2. Gunakan metode 5W2H. Who ? What ? Why ? Where ? When ? How ? How Many ?',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 18.0),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
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
                                                    _cardController.animateTo(_cardController.index + 1);
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
                                    width: width,
                                    height: 55.0,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '1. Identify Problem',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '2 of ${_title.length.toString()}',
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
                              height: height,
                              padding: EdgeInsets.symmetric(vertical: 25.0),
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
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
                                                    fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                                                child: Text(
                                                  'Apa masalah yang sedang terjadi ?',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 18.0),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                          child: StreamBuilder(
                                            stream: Firestore.instance.collection('what_problemSolving').orderBy('what', descending: false).snapshots(),
                                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                              if (!snapshot.hasData)
                                                return Container(
                                                  child: Center(
                                                    child: CircularProgressIndicator(),
                                                  ),
                                                );

                                              return DropdownButtonFormField<String>(
                                                decoration: InputDecoration(
                                                  labelText: 'What',
                                                  labelStyle: TextStyle(fontSize: 16.0),
                                                ),
                                                validator: (value) {
                                                  if (value == null) {
                                                    return 'Please select problem';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                value: _whatSelection,
                                                onChanged: (String value) {
                                                  setState(() {
                                                    _whatSelection = value;
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
                                                          text: document['what'].toString(),
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
                                            ButtonTheme(
                                              minWidth: 30.0,
                                              height: 25.0,
                                              child: RaisedButton(
                                                color: AbubaPallate.menuBluebird,
                                                child: Text(
                                                  'Note',
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.white),
                                                ),
                                                onPressed: () {
                                                  setState(() => noteWhat = !noteWhat);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        noteWhat
                                          ? Container(
                                              padding: const EdgeInsets.only(top: 10.0),
                                              width: width,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: 'Note',
                                                  labelStyle: TextStyle(fontSize: 12.0)
                                                ),
                                                maxLines: 3,
                                                maxLength: 250,
                                                controller: controllernoteWhat,
                                                style: TextStyle(color: Colors.black,),
                                              ),
                                            )
                                          : Container()
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
                                    width: width,
                                    height: 55.0,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '1. Identify Problem',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '3 of ${_title.length.toString()}',
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
                              height: height,
                              padding: EdgeInsets.symmetric(vertical: 25.0),
                              color: Colors.white,
                              child: ListView(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Column(
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
                                                    fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                                                child: Text(
                                                  'Siapa yang terlibat dengan masalah ini ?',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 18.0),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        ListTile(
                                          title: Padding(
                                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
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
                                    width: width,
                                    height: 55.0,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '1. Identify Problem',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '4 of ${_title.length.toString()}',
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
                              height: height,
                              padding: EdgeInsets.symmetric(vertical: 25.0),
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
                                              fontSize: 18.0
                                            ),
                                            textAlign: TextAlign.center,
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
                                                noteWhen= !noteWhen;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  noteWhen
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
                                          controller: controllernoteWhen,
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
                                    width: width,
                                    height: 55.0,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '1. Identify Problem',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '5 of ${_title.length.toString()}',
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
                              height: height,
                              padding: EdgeInsets.symmetric(vertical: 25.0),
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
                                              fontSize: 18.0
                                            ),
                                            textAlign: TextAlign.center,
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
                                                  fontSize: 14.0,
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                noteWhere= !noteWhere;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  noteWhere
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
                                          controller: controllernoteWhere,
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
                                    width: width,
                                    height: 55.0,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '1. Identify Problem',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '6 of ${_title.length.toString()}',
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
                              height: height,
                              padding: EdgeInsets.symmetric(vertical: 25.0),
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                                child: Text(
                                                  'WHY',
                                                  style: TextStyle(
                                                    color: Color(0xFF2F592F),
                                                    fontSize: 32.0,
                                                    fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                                                child: Text(
                                                  'Mengapa temuan / issue ini bisa menjadi masalah ? Apa konsekuensi dari masalah ini ?',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 18.0),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                          child: StreamBuilder(
                                            stream: Firestore.instance.collection('konsekuensi_problemSolving').orderBy('konsekuensi', descending: false).snapshots(),
                                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                              if (!snapshot.hasData)
                                                return Container(
                                                  child: Center(
                                                    child: CircularProgressIndicator(),
                                                  ),
                                                );

                                              return DropdownButtonFormField<String>(
                                                decoration: InputDecoration(
                                                  labelText: 'Why',
                                                  labelStyle: TextStyle(fontSize: 16.0),
                                                ),
                                                validator: (value) {
                                                  if (value == null) {
                                                    return 'Please select konsekuensi';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                value: _whySelection,
                                                onChanged: (String value) {
                                                  setState(() {
                                                    _whySelection = value;
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
                                                          text: document['konsekuensi'].toString(),
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
                                            ButtonTheme(
                                              minWidth: 30.0,
                                              height: 25.0,
                                              child: RaisedButton(
                                                color: AbubaPallate.menuBluebird,
                                                child: Text(
                                                  'Note',
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.white),
                                                ),
                                                onPressed: () {
                                                  setState(() => noteWhy = !noteWhy);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        noteWhy
                                          ? Container(
                                              padding: const EdgeInsets.only(top: 10.0),
                                              width: width,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: 'Note',
                                                  labelStyle: TextStyle(fontSize: 12.0)
                                                ),
                                                maxLines: 3,
                                                maxLength: 250,
                                                controller: controllernoteWhy,
                                                style: TextStyle(color: Colors.black,),
                                              ),
                                            )
                                          : Container()
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
                                    width: width,
                                    height: 55.0,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '1. Identify Problem',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '7 of ${_title.length.toString()}',
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
                              height: height,
                              padding: EdgeInsets.symmetric(vertical: 25.0),
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                                child: Text(
                                                  'HOW SEVERE',
                                                  style: TextStyle(
                                                    color: Color(0xFF2F592F),
                                                    fontSize: 32.0,
                                                    fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                                                child: Text(
                                                  'Seberapa parah akibat yang ditimbulkan dari masalah ?',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 18.0),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                padding:
                                                    EdgeInsets.only(top: 5.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: <Widget>[
                                                    ButtonTheme(
                                                      height: 30.0,
                                                      child: OutlineButton(
                                                        child: Text(
                                                          'Low',
                                                          style: TextStyle(color:_colorLowSe),
                                                        ),
                                                        borderSide: BorderSide(
                                                          color: _colorLowSe,
                                                          width: 1.0),
                                                        highlightedBorderColor: _colorLowSe,
                                                        onPressed: () {
                                                          setState(() {
                                                            _colorLowSe = Colors.green[400];
                                                            _colorMedSe = Colors.grey;
                                                            _colorHighSe = Colors.grey;
                                                            howSevere = 'Low';
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                    ButtonTheme(
                                                      height: 30.0,
                                                      child: OutlineButton(
                                                        child: Text(
                                                          'Medium',
                                                          style: TextStyle(color:_colorMedSe),
                                                        ),
                                                        borderSide: BorderSide(color: _colorMedSe,width: 1.0),
                                                        highlightedBorderColor:_colorMedSe,
                                                        onPressed: () {
                                                          setState(() {
                                                            _colorLowSe = Colors.grey;
                                                            _colorMedSe = Colors.orangeAccent;
                                                            _colorHighSe = Colors.grey;
                                                            howSevere = 'Medium';
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                    ButtonTheme(
                                                      height: 30.0,
                                                      child: OutlineButton(
                                                        child: Text(
                                                          'High',
                                                          style: TextStyle(color:_colorHighSe),
                                                        ),
                                                        borderSide: BorderSide(
                                                          color: _colorHighSe,
                                                          width: 1.0),
                                                        highlightedBorderColor: _colorHighSe,
                                                        onPressed: () {
                                                          setState(() {
                                                            _colorLowSe = Colors.grey;
                                                            _colorMedSe = Colors.grey;
                                                            _colorHighSe = Colors.redAccent;
                                                            howSevere = 'High';
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            ButtonTheme(
                                              minWidth: 30.0,
                                              height: 25.0,
                                              child: RaisedButton(
                                                color: AbubaPallate.menuBluebird,
                                                child: Text(
                                                  'Note',
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.white),
                                                ),
                                                onPressed: () {
                                                  setState(() => noteHowSevere = !noteHowSevere);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        noteHowSevere
                                          ? Container(
                                              padding: const EdgeInsets.only(top: 10.0),
                                              width: width,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: 'Note',
                                                  labelStyle: TextStyle(fontSize: 12.0)
                                                ),
                                                maxLines: 3,
                                                maxLength: 250,
                                                controller: controllernoteHowSevere,
                                                style: TextStyle(color: Colors.black,),
                                              ),
                                            )
                                          : Container()
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
                                    width: width,
                                    height: 55.0,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '2. Identify Team',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '8 of ${_title.length.toString()}',
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
                              height: height,
                              padding: EdgeInsets.symmetric(vertical: 25.0),
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                                child: Text(
                                                  'TEAM',
                                                  style: TextStyle(
                                                    color: Color(0xFF2F592F),
                                                    fontSize: 32.0,
                                                    fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                                                child: Text(
                                                  'Apakah untuk menyelesaikan masalah ini perlu dibentuk tim khusus ?',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 18.0),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 30.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              ButtonTheme(
                                                height: 30.0,
                                                child: OutlineButton(
                                                  child: Text(
                                                    'TIDAK',
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.redAccent),
                                                  ),
                                                  borderSide: BorderSide(
                                                    color: Colors.redAccent,
                                                    width: 1.0),
                                                  highlightedBorderColor: Colors.redAccent,
                                                  onPressed: () {
                                                    setState(() {
                                                      _championSelection = '';
                                                      championName = '';
                                                      _leaderSelection = '';
                                                      leaderName = '';
                                                      _recordSelection = '';
                                                      recordName = '';
                                                      _participantSelection = '';
                                                      _participantSelection2 = '';
                                                      team = false;
                                                    });
                                                    _cardController.animateTo(_cardController.index + 7);
                                                  },
                                                ),
                                              ),
                                              ButtonTheme(
                                                height: 30.0,
                                                child: OutlineButton(
                                                  child: Text(
                                                    'YA',
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: AbubaPallate.greenabuba),
                                                  ),
                                                  borderSide: BorderSide(
                                                    color: AbubaPallate.greenabuba,
                                                    width: 1.0),
                                                  highlightedBorderColor: AbubaPallate.greenabuba,
                                                  onPressed: () {
                                                    setState(() {
                                                      team = true;
                                                    });
                                                    _cardController.animateTo(_cardController.index + 1);
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                                    width: width,
                                    height: 55.0,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '2. Identify Team',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '9 of ${_title.length.toString()}',
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
                              height: height,
                              padding: EdgeInsets.symmetric(vertical: 25.0),
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                                child: Text(
                                                  'TEAM',
                                                  style: TextStyle(
                                                    color: Color(0xFF2F592F),
                                                    fontSize: 32.0,
                                                    fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                                                child: Text(
                                                  'Pilih anggota tim dari berbagai departemen yang memiliki wewenang untuk menyelesaikan masalah',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 18.0),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 20.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              ButtonTheme(
                                                height: 40.0,
                                                child: RaisedButton(
                                                  child: Text(
                                                    'PAHAM',
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white),
                                                  ),
                                                  color: Colors.blue,
                                                  onPressed: () {
                                                    _cardController.animateTo(_cardController.index + 1);
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                                    width: width,
                                    height: 55.0,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '2. Identify Team',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '10 of ${_title.length.toString()}',
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
                              height: height,
                              padding: EdgeInsets.symmetric(vertical: 25.0),
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                                child: Text(
                                                  'TEAM',
                                                  style: TextStyle(
                                                    color: Color(0xFF2F592F),
                                                    fontSize: 32.0,
                                                    fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                                                child: Text(
                                                  'Harus jelas siapa yang menjadi Champion, Leader, Record Keeper, dan Participants',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 18.0),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 20.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              ButtonTheme(
                                                height: 40.0,
                                                child: RaisedButton(
                                                  child: Text(
                                                    'PAHAM',
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white),
                                                  ),
                                                  color: Colors.blue,
                                                  onPressed: () {
                                                    _cardController.animateTo(_cardController.index + 1);
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                                    width: width,
                                    height: 55.0,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '2. Identify Team',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '11 of ${_title.length.toString()}',
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
                              height: height,
                              padding: EdgeInsets.symmetric(vertical: 25.0),
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                                child: Text(
                                                  'CHAMPION',
                                                  style: TextStyle(
                                                    color: Color(0xFF2F592F),
                                                    fontSize: 32.0,
                                                    fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                                                child: Text(
                                                  'Mentor, mengarahkan dan membantu tim menjelaskan ke pihak management',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 18.0),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
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
                                                  labelText: 'Champion',
                                                  labelStyle: TextStyle(fontSize: 16.0),
                                                ),
                                                value: _championSelection,
                                                onChanged: (String value) {
                                                  setState(() {
                                                    Firestore.instance.collection('user').where('id', isEqualTo: int.tryParse(value)).snapshots().listen((data) {
                                                      championName = data.documents[0].data['nama'];
                                                    });
                                                    _championSelection = value;
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
                                                IconButton(
                                                  splashColor: Colors.transparent,
                                                  disabledColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                                                  onPressed: () {
                                                    _cardController.animateTo(_cardController.index + 1);
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
                                    width: width,
                                    height: 55.0,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '2. Identify Team',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '12 of ${_title.length.toString()}',
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
                              height: height,
                              padding: EdgeInsets.symmetric(vertical: 25.0),
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                                child: Text(
                                                  'LEADER',
                                                  style: TextStyle(
                                                    color: Color(0xFF2F592F),
                                                    fontSize: 32.0,
                                                    fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                                                child: Text(
                                                  'Bertanggungjawab pada pelaksana teknis, mengadakan meeting, menyiapkan fasilitas pada team, dan report kepada champion',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 18.0),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
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
                                                  labelText: 'Leader',
                                                  labelStyle: TextStyle(fontSize: 16.0),
                                                ),
                                                value: _leaderSelection,
                                                onChanged: (String value) {
                                                  setState(() {
                                                    Firestore.instance.collection('user').where('id', isEqualTo: int.tryParse(value)).snapshots().listen((data) {
                                                      leaderName = data.documents[0].data['nama'];
                                                    });
                                                    _leaderSelection = value;
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
                                                IconButton(
                                                  splashColor: Colors.transparent,
                                                  disabledColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                                                  onPressed: () {
                                                    _cardController.animateTo(_cardController.index + 1);
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
                                    width: width,
                                    height: 55.0,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '2. Identify Team',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '13 of ${_title.length.toString()}',
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
                              height: height,
                              padding: EdgeInsets.symmetric(vertical: 25.0),
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                                child: Text(
                                                  'RECORD KEEPER',
                                                  style: TextStyle(
                                                    color: Color(0xFF2F592F),
                                                    fontSize: 32.0,
                                                    fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                                                child: Text(
                                                  'Mencatat perkembangan penyelesaian masalah dan membuat minute of meeting',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 18.0),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
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
                                                  labelText: 'Record Keeper',
                                                  labelStyle: TextStyle(fontSize: 16.0),
                                                ),
                                                value: _recordSelection,
                                                onChanged: (String value) {
                                                  setState(() {
                                                    Firestore.instance.collection('user').where('id', isEqualTo: int.tryParse(value)).snapshots().listen((data) {
                                                      recordName = data.documents[0].data['nama'];
                                                    });
                                                    _recordSelection = value;
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
                                                IconButton(
                                                  splashColor: Colors.transparent,
                                                  disabledColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                                                  onPressed: () {
                                                    _cardController.animateTo(_cardController.index + 1);
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
                                    width: width,
                                    height: 55.0,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '2. Identify Team',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '14 of ${_title.length.toString()}',
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
                              height: height,
                              padding: EdgeInsets.symmetric(vertical: 25.0),
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                                child: Text(
                                                  'PARTICIPANTS',
                                                  style: TextStyle(
                                                    color: Color(0xFF2F592F),
                                                    fontSize: 32.0,
                                                    fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                                                child: Text(
                                                  'Memberi ide, menjalankan tugas dan melaporkan perkembangan kepada leader secara tepat waktu',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 18.0),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        ListTile(
                                          title: Padding(
                                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
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
                                                    labelText: 'Participants',
                                                    labelStyle: TextStyle(fontSize: 16.0),
                                                  ),
                                                  value: _participantSelection,
                                                  onChanged: (String value) {
                                                    Firestore.instance.collection('user').where('id', isEqualTo: int.tryParse(value)).snapshots().listen((data) {
                                                      setState(() {
                                                        _participantSelection2 = data.documents[0].data['nama'];
                                                        _participantSelection = value;
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
                                                if (participantsID.contains(int.tryParse(_participantSelection))) {

                                                } else {
                                                  participantsID.add(int.tryParse(_participantSelection));
                                                }
                                                if (participantsName.contains(_participantSelection2)) {

                                                } else {
                                                  participantsName.add(_participantSelection2);
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.only(left: 15.0, right: 10.0, top: participantsName.length == 0 ? 0.0 : 10.0, bottom: participantsName.length == 0 ? 0.0 : 20.0),
                                          child: Wrap(
                                            spacing: 8.0,
                                            runSpacing: 4.0,
                                            runAlignment: WrapAlignment.start,
                                            direction: Axis.horizontal,
                                            children: participantsName.length == 0
                                              ? [Container()]
                                              : participantsName.map((String name) => Chip(
                                                  label: Text(name),
                                                  onDeleted: () {
                                                    setState(() {
                                                      participantsID.removeAt(participantsName.indexOf(name));
                                                      participantsName.remove(name);
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
                                                IconButton(
                                                  splashColor: Colors.transparent,
                                                  disabledColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                                                  onPressed: () {
                                                    _cardController.animateTo(_cardController.index + 1);
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
                                    width: width,
                                    height: 55.0,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '3. Immediate Action',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '15 of ${_title.length.toString()}',
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
                              height: height,
                              padding: EdgeInsets.symmetric(vertical: 25.0),
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                                child: Text(
                                                  'TINDAKAN SEGERA',
                                                  style: TextStyle(
                                                    color: Color(0xFF2F592F),
                                                    fontSize: 32.0,
                                                    fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                                                child: Text(
                                                  'Tindakan apa yang harus dilakukan dengan segera agar masalah tidak membesar ?',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 18.0),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                                          child: TextFormField(
                                            textCapitalization: TextCapitalization.sentences,
                                            decoration: InputDecoration(
                                              border: UnderlineInputBorder(),
                                              labelText: 'Tindakan Segera',
                                              labelStyle: TextStyle(fontSize: 16.0),
                                            ),
                                            maxLength: 100,
                                            keyboardType: TextInputType.multiline,
                                            controller: tindakanSegera,
                                            validator: (value) {
                                              if (value.length < 5) {
                                                return 'Tindakan Segera must be more than 5 character';
                                              } else if (value.length > 100) {
                                                return 'Tindakan Segera must be less than 100 character';
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
                                                    if (team == true) {
                                                      _cardController.animateTo(_cardController.index - 1);
                                                    } else {
                                                      _cardController.animateTo(_cardController.index - 7);
                                                    }
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
                                    width: width,
                                    height: 55.0,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '3. Immediate Action',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '15 of ${_title.length.toString()}',
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
                              height: height,
                              padding: EdgeInsets.symmetric(vertical: 25.0),
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                                child: Text(
                                                  'WAKTU PELAKSANAAN',
                                                  style: TextStyle(
                                                    color: Color(0xFF2F592F),
                                                    fontSize: 32.0,
                                                    fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                                                child: Text(
                                                  'Kapan tindakan tersebut akan dilaksanakan ?',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 18.0),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                                          width: width,
                                          child: DateTimePickerFormField(
                                            format: dateFormat,
                                            onChanged: (dt) => setState(() => waktuPelaksanaan = dt),
                                            dateOnly: true,
                                            editable: false,
                                            resetIcon: null,
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Please select date';
                                              } else {
                                                return null;
                                              }
                                            },
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black),
                                            decoration: InputDecoration(
                                              border: UnderlineInputBorder(),
                                              labelStyle: TextStyle(fontSize: 14.0),
                                              labelText: 'Start'),
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
                                                    if (team == true) {
                                                      _cardController.animateTo(_cardController.index - 1);
                                                    } else {
                                                      _cardController.animateTo(_cardController.index - 7);
                                                    }
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
                                    width: width,
                                    height: 55.0,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '3. Immediate Action',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '16 of ${_title.length.toString()}',
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
                              height: height,
                              padding: EdgeInsets.symmetric(vertical: 25.0),
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                                child: Text(
                                                  'PELAKSANA',
                                                  style: TextStyle(
                                                    color: Color(0xFF2F592F),
                                                    fontSize: 32.0,
                                                    fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                                                child: Text(
                                                  'Siapa yang akan melakukan tindakan segera tersebut ?',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 18.0),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
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
                                                    return 'Please select person';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                value: _pelaksanaSelection,
                                                onChanged: (String value) {
                                                  setState(() {
                                                    _pelaksanaSelection = value;
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
                                    width: width,
                                    height: 55.0,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '3. Immediate Action',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '17 of ${_title.length.toString()}',
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
                              height: height,
                              padding: EdgeInsets.symmetric(vertical: 25.0),
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                                child: Text(
                                                  'INGAT !',
                                                  style: TextStyle(
                                                    color: Color(0xFF2F592F),
                                                    fontSize: 32.0,
                                                    fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                                                child: Text(
                                                  'Tindakan segera hanyalah action sementara sebelum corrective action dilakukan',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 18.0),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 20.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              ButtonTheme(
                                                height: 40.0,
                                                child: RaisedButton(
                                                  child: Text(
                                                    'PAHAM',
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white),
                                                  ),
                                                  color: Colors.blue,
                                                  onPressed: () {
                                                    _cardController.animateTo(_cardController.index + 1);
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                                    width: width,
                                    height: 55.0,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '4. Root Cause',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '18 of ${_title.length.toString()}',
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
                              height: height,
                              padding: EdgeInsets.symmetric(vertical: 25.0),
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                                child: Text(
                                                  'BRAINSTORMING',
                                                  style: TextStyle(
                                                    color: Color(0xFF2F592F),
                                                    fontSize: 32.0,
                                                    fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                                                child: Text(
                                                  'Gunakan Fishbone diagram, Pareto, dan 5 Why method untuk mencari tahu akar masalah',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 18.0),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 20.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              ButtonTheme(
                                                height: 40.0,
                                                child: RaisedButton(
                                                  child: Text(
                                                    'PAHAM',
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white),
                                                  ),
                                                  color: Colors.blue,
                                                  onPressed: () {
                                                    _cardController.animateTo(_cardController.index + 1);
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                                    width: width,
                                    height: 55.0,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '4. Root Cause',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '19 of ${_title.length.toString()}',
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
                              height: height,
                              padding: EdgeInsets.symmetric(vertical: 25.0),
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                                child: Text(
                                                  'FISHBONE DIAGRAM',
                                                  style: TextStyle(
                                                    color: Color(0xFF2F592F),
                                                    fontSize: 32.0,
                                                    fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                                                child: Text(
                                                  'Gunakan Fishbone diagram, Pareto, dan 5 Why method untuk mencari tahu akar masalah',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 18.0),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 20.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              ButtonTheme(
                                                height: 40.0,
                                                child: RaisedButton(
                                                  child: Text(
                                                    'PAHAM',
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white),
                                                  ),
                                                  color: Colors.blue,
                                                  onPressed: () {
                                                    _cardController.animateTo(_cardController.index + 1);
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                                    width: width,
                                    height: 55.0,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '5. Corrective Action Plan',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '20 of ${_title.length.toString()}',
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
                              height: height,
                              padding: EdgeInsets.symmetric(vertical: 25.0),
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
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
                                                    fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                                                child: Text(
                                                  'Apa tindakan permanen yang akan dilakukan untuk menyelesaikan masalah tersebut ?',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 18.0),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                          child: StreamBuilder(
                                            stream: Firestore.instance.collection('tindakanPermanen_problemSolving').orderBy('tindakan', descending: false).snapshots(),
                                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                              if (!snapshot.hasData)
                                                return Container(
                                                  child: Center(
                                                    child: CircularProgressIndicator(),
                                                  ),
                                                );

                                              return DropdownButtonFormField<String>(
                                                decoration: InputDecoration(
                                                  labelText: 'What',
                                                  labelStyle: TextStyle(fontSize: 16.0),
                                                ),
                                                validator: (value) {
                                                  if (value == null) {
                                                    return 'Please select tindakan permanen';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                value: tindakanPermanen,
                                                onChanged: (String value) {
                                                  setState(() {
                                                    tindakanPermanen = value;
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
                                                          text: document['tindakan'].toString(),
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
                                            ButtonTheme(
                                              minWidth: 30.0,
                                              height: 25.0,
                                              child: RaisedButton(
                                                color: AbubaPallate.menuBluebird,
                                                child: Text(
                                                  'Note',
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.white),
                                                ),
                                                onPressed: () {
                                                  setState(() => noteWhatTindakanPermanen = !noteWhatTindakanPermanen);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        noteWhatTindakanPermanen
                                          ? Container(
                                              padding: const EdgeInsets.only(top: 10.0),
                                              width: width,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: 'Note',
                                                  labelStyle: TextStyle(fontSize: 12.0)
                                                ),
                                                maxLines: 3,
                                                maxLength: 250,
                                                controller: controllernoteWhatTindakanPermanen,
                                                style: TextStyle(color: Colors.black,),
                                              ),
                                            )
                                          : Container()
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
                                                IconButton(
                                                  splashColor: Colors.transparent,
                                                  disabledColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                                                  onPressed: () {
                                                    _cardController.animateTo(_cardController.index + 1);
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
                                    width: width,
                                    height: 55.0,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '5. Corrective Action Plan',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '21 of ${_title.length.toString()}',
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
                              height: height,
                              padding: EdgeInsets.symmetric(vertical: 25.0),
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Column(
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
                                                    fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                                                child: Text(
                                                  'Siapa penanggungjawab dari tindakan permanen tersebut ?',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 18.0),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
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
                                                value: whoTindakanPermanen,
                                                onChanged: (String value) {
                                                  setState(() {
                                                    whoTindakanPermanen = value;
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
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            ButtonTheme(
                                              minWidth: 30.0,
                                              height: 25.0,
                                              child: RaisedButton(
                                                color: AbubaPallate.menuBluebird,
                                                child: Text(
                                                  'Note',
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.white),
                                                ),
                                                onPressed: () {
                                                  setState(() => noteWhoTindakanPermanen = !noteWhoTindakanPermanen);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        noteWhoTindakanPermanen
                                          ? Container(
                                              padding: const EdgeInsets.only(top: 10.0),
                                              width: width,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: 'Note',
                                                  labelStyle: TextStyle(fontSize: 12.0)
                                                ),
                                                maxLines: 3,
                                                maxLength: 250,
                                                controller: controllernoteWhoTindakanPermanen,
                                                style: TextStyle(color: Colors.black,),
                                              ),
                                            )
                                          : Container()
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
                                    width: width,
                                    height: 55.0,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '5. Corrective Action Plan',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '22 of ${_title.length.toString()}',
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
                              height: height,
                              padding: EdgeInsets.symmetric(vertical: 25.0),
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Column(
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
                                                    fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                                                child: Text(
                                                  'Kapan tindakan permanen itu akan dijalankan ?',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 18.0),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                          child: DateTimePickerFormField(
                                            format: dateFormat,
                                            onChanged: (dt) => setState(() => whenTindakanPermanen = dt),
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
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            ButtonTheme(
                                              minWidth: 30.0,
                                              height: 25.0,
                                              child: RaisedButton(
                                                color: AbubaPallate.menuBluebird,
                                                child: Text(
                                                  'Note',
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.white),
                                                ),
                                                onPressed: () {
                                                  setState(() => noteWhenTindakanPermanen = !noteWhenTindakanPermanen);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        noteWhenTindakanPermanen
                                          ? Container(
                                              padding: const EdgeInsets.only(top: 10.0),
                                              width: width,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: 'Note',
                                                  labelStyle: TextStyle(fontSize: 12.0)
                                                ),
                                                maxLines: 3,
                                                maxLength: 250,
                                                controller: controllernoteWhenTindakanPermanen,
                                                style: TextStyle(color: Colors.black,),
                                              ),
                                            )
                                          : Container()
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
                                    width: width,
                                    height: 55.0,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '5. Corrective Action Plan',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '23 of ${_title.length.toString()}',
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
                              height: height,
                              padding: EdgeInsets.symmetric(vertical: 25.0),
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                                child: Text(
                                                  'BUKTI',
                                                  style: TextStyle(
                                                    color: Color(0xFF2F592F),
                                                    fontSize: 32.0,
                                                    fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                                                child: Text(
                                                  'Lampirkan dokumen atau foto yang menunjukan bahwa tindakan permanen sudah dilakukan',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 18.0),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 20.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              ButtonTheme(
                                                height: 40.0,
                                                child: RaisedButton(
                                                  child: Text(
                                                    'FOTO',
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white),
                                                  ),
                                                  color: Colors.blue,
                                                  onPressed: () {
                                                    
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            ButtonTheme(
                                              minWidth: 30.0,
                                              height: 25.0,
                                              child: RaisedButton(
                                                color: AbubaPallate.menuBluebird,
                                                child: Text(
                                                  'Note',
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.white),
                                                ),
                                                onPressed: () {
                                                  setState(() => noteBukti = !noteBukti);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        noteBukti
                                          ? Container(
                                              padding: const EdgeInsets.only(top: 10.0),
                                              width: width,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: 'Note',
                                                  labelStyle: TextStyle(fontSize: 12.0)
                                                ),
                                                maxLines: 3,
                                                maxLength: 250,
                                                controller: controllernoteBukti,
                                                style: TextStyle(color: Colors.black,),
                                              ),
                                            )
                                          : Container()
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
                                                IconButton(
                                                  splashColor: Colors.transparent,
                                                  disabledColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                                                  onPressed: () {
                                                    _cardController.animateTo(_cardController.index + 1);
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
                                    width: width,
                                    height: 55.0,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '5. Corrective Action Plan',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '24 of ${_title.length.toString()}',
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
                              height: height,
                              padding: EdgeInsets.symmetric(vertical: 25.0),
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                                child: Text(
                                                  'EFFECTIVENESS',
                                                  style: TextStyle(
                                                    color: Color(0xFF2F592F),
                                                    fontSize: 32.0,
                                                    fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                                                child: Text(
                                                  'Bagaimana cara mengukur efektifitas dari tindakan permanen tersebut ?',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 18.0),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                          child: StreamBuilder(
                                            stream: Firestore.instance.collection('ukurEfektifitas_problemSolving').orderBy('ukur', descending: false).snapshots(),
                                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                              if (!snapshot.hasData)
                                                return Container(
                                                  child: Center(
                                                    child: CircularProgressIndicator(),
                                                  ),
                                                );

                                              return DropdownButtonFormField<String>(
                                                decoration: InputDecoration(
                                                  labelText: 'Effectiveness',
                                                  labelStyle: TextStyle(fontSize: 16.0),
                                                ),
                                                validator: (value) {
                                                  if (value == null) {
                                                    return 'Please select effectiveness';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                value: efektifitas,
                                                onChanged: (String value) {
                                                  setState(() {
                                                    efektifitas = value;
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
                                                          text: document['ukur'].toString(),
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
                                            ButtonTheme(
                                              minWidth: 30.0,
                                              height: 25.0,
                                              child: RaisedButton(
                                                color: AbubaPallate.menuBluebird,
                                                child: Text(
                                                  'Note',
                                                  style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.white),
                                                ),
                                                onPressed: () {
                                                  setState(() => noteEfektifitas = !noteEfektifitas);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        noteEfektifitas
                                          ? Container(
                                              padding: const EdgeInsets.only(top: 10.0),
                                              width: width,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: 'Note',
                                                  labelStyle: TextStyle(fontSize: 12.0)
                                                ),
                                                maxLines: 3,
                                                maxLength: 250,
                                                controller: controllernoteEfektifitas,
                                                style: TextStyle(color: Colors.black,),
                                              ),
                                            )
                                          : Container()
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
                                    width: width,
                                    height: 55.0,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '5. Corrective Action Plan',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '25 of ${_title.length.toString()}',
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
                              height: height,
                              padding: EdgeInsets.symmetric(vertical: 25.0),
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                                child: Text(
                                                  'VERIFICATION',
                                                  style: TextStyle(
                                                    color: Color(0xFF2F592F),
                                                    fontSize: 32.0,
                                                    fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                                                child: Text(
                                                  'Tindakan untuk memastikan bahwa action plan sudah dijalankan dan efektif',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 18.0),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 20.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              ButtonTheme(
                                                height: 40.0,
                                                child: RaisedButton(
                                                  child: Text(
                                                    'PAHAM',
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white),
                                                  ),
                                                  color: Colors.blue,
                                                  onPressed: () {
                                                    _cardController.animateTo(_cardController.index + 1);
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                                    width: width,
                                    height: 55.0,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '5. Corrective Action Plan',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '26 of ${_title.length.toString()}',
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
                              height: height,
                              padding: EdgeInsets.symmetric(vertical: 25.0),
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                                child: Text(
                                                  'VERIFICATION - WHO',
                                                  style: TextStyle(
                                                    color: Color(0xFF2F592F),
                                                    fontSize: 32.0,
                                                    fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                                                child: Text(
                                                  'Siapa yang bertanggungjawab melakukan verifikasi ?',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 18.0),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
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
                                                value: verifikasiWho,
                                                onChanged: (String value) {
                                                  setState(() {
                                                    verifikasiWho = value;
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
                                                IconButton(
                                                  splashColor: Colors.transparent,
                                                  disabledColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                                                  onPressed: () {
                                                    _cardController.animateTo(_cardController.index + 1);
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
                                    width: width,
                                    height: 55.0,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '5. Corrective Action Plan',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '27 of ${_title.length.toString()}',
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
                              height: height,
                              padding: EdgeInsets.symmetric(vertical: 25.0),
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                                child: Text(
                                                  'VERIFICATION - WHEN',
                                                  style: TextStyle(
                                                    color: Color(0xFF2F592F),
                                                    fontSize: 32.0,
                                                    fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                                                child: Text(
                                                  'Kapan verifikasi akan dilakukan ? Sebaiknya tidak lebih dari 7 hari setelah implementasi tindakan permanen',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 18.0),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                          child: DateTimePickerFormField(
                                            format: dateFormat,
                                            onChanged: (dt) => setState(() => verifikasiWhen = dt),
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
                                    width: width,
                                    height: 55.0,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '5. Corrective Action Plan',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '28 of ${_title.length.toString()}',
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
                              height: height,
                              padding: EdgeInsets.symmetric(vertical: 25.0),
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                                child: Text(
                                                  'VALIDATION',
                                                  style: TextStyle(
                                                    color: Color(0xFF2F592F),
                                                    fontSize: 32.0,
                                                    fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                                                child: Text(
                                                  'Tindakan untuk memastikan bahwa action plan sudah berjalan sesuai rencana dan masalah tidak muncul lagi setelah minimal 6 bulan sejak implementasi',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 18.0),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 20.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              ButtonTheme(
                                                height: 40.0,
                                                child: RaisedButton(
                                                  child: Text(
                                                    'PAHAM',
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white),
                                                  ),
                                                  color: Colors.blue,
                                                  onPressed: () {
                                                    _cardController.animateTo(_cardController.index + 1);
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                                    width: width,
                                    height: 55.0,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '5. Corrective Action Plan',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '29 of ${_title.length.toString()}',
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
                              height: height,
                              padding: EdgeInsets.symmetric(vertical: 25.0),
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                                child: Text(
                                                  'VALIDATION - WHO',
                                                  style: TextStyle(
                                                    color: Color(0xFF2F592F),
                                                    fontSize: 32.0,
                                                    fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                                                child: Text(
                                                  'Siapa yang bertanggungjawab melakukan validasi ?',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 18.0),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
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
                                                value: validasiWho,
                                                onChanged: (String value) {
                                                  setState(() {
                                                    validasiWho = value;
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
                                                IconButton(
                                                  splashColor: Colors.transparent,
                                                  disabledColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                                                  onPressed: () {
                                                    _cardController.animateTo(_cardController.index + 1);
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
                                    width: width,
                                    height: 55.0,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '5. Corrective Action Plan',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '30 of ${_title.length.toString()}',
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
                              height: height,
                              padding: EdgeInsets.symmetric(vertical: 25.0),
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                                child: Text(
                                                  'VALIDATION - WHEN',
                                                  style: TextStyle(
                                                    color: Color(0xFF2F592F),
                                                    fontSize: 32.0,
                                                    fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                                                child: Text(
                                                  'Kapan validasi akan dilakukan ? Sebaiknya dilakukan setelah 6 bulan pelaksanaan action plan',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 18.0),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                          child: DateTimePickerFormField(
                                            format: dateFormat,
                                            onChanged: (dt) => setState(() => validasiWhen = dt),
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
                                    width: width,
                                    height: 55.0,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '6. Complete Action Plan',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '31 of ${_title.length.toString()}',
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
                              height: height,
                              padding: EdgeInsets.symmetric(vertical: 25.0),
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                                child: Text(
                                                  'COMPLETE',
                                                  style: TextStyle(
                                                    color: Color(0xFF2F592F),
                                                    fontSize: 32.0,
                                                    fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                                                child: Text(
                                                  'Pastikan semua action plan dijalankan sesuai rencana.\n\nApabila ada action plan yang belum dijalankan, jangan dulu dilakukan verifikasi',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 18.0),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 20.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              _isProccess
                                                ? Container(
                                                    child: Center(
                                                      child: CircularProgressIndicator(),
                                                    ),
                                                  )
                                                : ButtonTheme(
                                                    height: 40.0,
                                                    child: RaisedButton(
                                                      child: Text(
                                                        team ? 'PAHAM' : 'SAVE',
                                                        style: TextStyle(
                                                          fontSize: 16.0,
                                                          color: Colors.white),
                                                      ),
                                                      color: Colors.blue,
                                                      onPressed: () {
                                                        if (team == true) {
                                                          _cardController.animateTo(_cardController.index + 1);
                                                        } else {
                                                          setState(() {
                                                            _isProccess = true;
                                                            _autoValidate = false;
                                                          });
                                                          _formKey.currentState.save();

                                                          for (int i = 0; i < taskLeaderArray.length; i++) {
                                                            statusTaskLeader.add(false);
                                                            statusTaskRecordKeeper.add(false);
                                                            statusTaskParticipants.add(false);
                                                          }

                                                          DocumentReference docReference = Firestore.instance.collection('problemSolving').document();

                                                          docReference.setData({
                                                            'userCreated': widget.idUser,
                                                            'dateCreated': DateTime.now(),
                                                            'problem': int.tryParse(_whatSelection),
                                                            'whoTerlibatID': whoID,
                                                            'whoTerlibatName': whoName,
                                                            'dateTerjadi': dateWhen,
                                                            'shift': int.tryParse(_shiftSelection),
                                                            'department': int.tryParse(_departmentSelection),
                                                            'divisi': int.tryParse(_divisiSelection),
                                                            'area': int.tryParse(_areaSelection),
                                                            'why': int.tryParse(_whySelection),
                                                            'howSevere':howSevere,
                                                            'team': team,
                                                            'champion': int.tryParse(_championSelection),
                                                            'leader': int.tryParse(_leaderSelection),
                                                            'recordKeeper': int.tryParse(_recordSelection),
                                                            'participantsID': participantsID,
                                                            'participantsName':participantsName,
                                                            'tindakanSegera': tindakanSegera.text,
                                                            'waktuPelaksanaan':waktuPelaksanaan,
                                                            'pelaksana': int.tryParse(_pelaksanaSelection),
                                                            'tindakanPermanen': int.tryParse(tindakanPermanen),
                                                            'whoTindakanPermanen': int.tryParse(whoTindakanPermanen),
                                                            'whenTindakanPermanen':whenTindakanPermanen,
                                                            'bukti':bukti,
                                                            'efektifitas': int.tryParse(efektifitas),
                                                            'whoVerifikasi': int.tryParse(verifikasiWho),
                                                            'whenVerifikasi': verifikasiWhen,
                                                            'whoValidasi': int.tryParse(validasiWho),
                                                            'whenValidasi':validasiWhen,
                                                            'taskLeader':taskLeaderArray,
                                                            'duedateLeader':duedateLeaderArray,
                                                            'taskRecordKeeper':taskRecordKeeperArray,
                                                            'duedateRecordKeeper':duedateRecordKeeperArray,
                                                            'taskParticipants':taskParticipantsArray,
                                                            'duedateParticipants':duedateParticipantsArray,
                                                            'personTaskID':whoParticipantsID,
                                                            'personTaskName':whoParticipantsName,
                                                            'statusTaskLeader':statusTaskLeader,
                                                            'statusTaskRecordKeeper': statusTaskRecordKeeper,
                                                            'statusTaskParticipants':statusTaskParticipants,
                                                            'problemSolvingNo':maxidProblemSolving,
                                                            'noteWhatMasalah':controllernoteWhat.text,
                                                            'noteWhenMasalah':controllernoteWhen.text,
                                                            'noteWhereMasalah':controllernoteWhere.text,
                                                            'noteWhyMasalah':controllernoteWhy.text,
                                                            'noteWhatTindakanPermanen':controllernoteWhatTindakanPermanen.text,
                                                            'noteWhoTindakanPermanen':controllernoteWhoTindakanPermanen.text,
                                                            'noteWhenTindakanPermanen':controllernoteWhenTindakanPermanen.text,
                                                            'noteBukti':controllernoteBukti.text,
                                                            'noteEfektifitas': controllernoteEfektifitas.text,
                                                          }).then((doc) {
                                                            setState(() {
                                                              _isProccess = false;
                                                            });

                                                            DocumentReference documentReference =Firestore.instance.collection('dumper_problemSolving').document(indexProblemSolving);

                                                            documentReference.updateData({
                                                              'maxid_problemSolving':maxidProblemSolving
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
                                                                          'Problem Solving No. PSV-${maxidProblemSolving.toString().padLeft(4, '0')}',
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
                                                        }
                                                      },
                                                    ),
                                                  ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                                    width: width,
                                    height: 55.0,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '6. Complete Action Plan',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '32 of ${_title.length.toString()}',
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
                              height: height,
                              padding: EdgeInsets.symmetric(vertical: 25.0),
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                                child: Text(
                                                  'LEADER - $leaderName',
                                                  style: TextStyle(
                                                    color: Color(0xFF2F592F),
                                                    fontSize: 32.0,
                                                    fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                                          child: TextFormField(
                                            textCapitalization: TextCapitalization.sentences,
                                            decoration: InputDecoration(
                                              border: UnderlineInputBorder(),
                                              labelText: 'Task',
                                              labelStyle: TextStyle(fontSize: 16.0),
                                            ),
                                            maxLength: 50,
                                            keyboardType: TextInputType.multiline,
                                            controller: taskLeader,
                                            validator: (value) {
                                              if (value.length < 5) {
                                                return 'Task must be more than 5 character';
                                              } else if (value.length > 50) {
                                                return 'Task must be less than 50 character';
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
                                        ListTile(
                                          title: Padding(
                                            padding: EdgeInsets.only(bottom: 10.0),
                                            child: DateTimePickerFormField(
                                              format: dateFormat,
                                              onChanged: (dt) => setState(() => duedateLeader = dt),
                                              dateOnly: true,
                                              editable: false,
                                              resetIcon: null,
                                              style: TextStyle(fontSize: 16.0, color: Colors.black),
                                              decoration: InputDecoration(
                                                border: UnderlineInputBorder(),
                                                labelStyle: TextStyle(fontSize: 16.0),
                                                labelText: 'Due Date'
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
                                          trailing: IconButton(
                                            icon: Icon(Icons.add, color: AbubaPallate.greenabuba),
                                            onPressed: () {
                                              setState(() {
                                                if (taskLeader.text.isNotEmpty && duedateLeader != null) {
                                                  if (taskLeaderArray.contains(taskLeader.text)) {

                                                  } else {
                                                    duedateLeaderArray.add(duedateLeader);
                                                    taskLeaderArray.add(taskLeader.text);
                                                    taskLeader.clear();
                                                  }
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                        Container(
                                          height: MediaQuery.of(context).size.height * 0.3,
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.only(left: 15.0, right: 15.0, top: taskLeaderArray.length == 0 ? 0.0 : 10.0, bottom: taskLeaderArray.length == 0 ? 0.0 : 10.0),
                                          child: Column(
                                            children: <Widget>[
                                              Expanded(
                                                child: ListView(
                                                children: <Widget>[
                                                  Wrap(
                                                    spacing: 8.0,
                                                    runSpacing: 4.0,
                                                    runAlignment: WrapAlignment.start,
                                                    direction: Axis.horizontal,
                                                    children: taskLeaderArray.length == 0
                                                      ? [Container()]
                                                      : taskLeaderArray.map((String name) => Chip(
                                                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                                          label: RichText(
                                                            overflow: TextOverflow.ellipsis,
                                                            text: TextSpan(
                                                              text: name,
                                                              style: TextStyle(
                                                                color: Colors.black,
                                                                fontSize: 12.0
                                                              )
                                                            ),
                                                          ),
                                                          onDeleted: () {
                                                            setState(() {
                                                              duedateLeaderArray.removeAt(taskLeaderArray.indexOf(name));
                                                              taskLeaderArray.remove(name);
                                                            });
                                                          },
                                                        )).toList(),
                                                  ),
                                                ],
                                              ),
                                              )
                                            ],
                                          )
                                        )
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
                                                IconButton(
                                                  splashColor: Colors.transparent,
                                                  disabledColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                                                  onPressed: () {
                                                    if (taskLeaderArray.length > 0) {
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
                                    width: width,
                                    height: 55.0,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '6. Complete Action Plan',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '33 of ${_title.length.toString()}',
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
                              height: height,
                              padding: EdgeInsets.symmetric(vertical: 25.0),
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                                child: Text(
                                                  'RECORD KEEPER - $recordName',
                                                  style: TextStyle(
                                                    color: Color(0xFF2F592F),
                                                    fontSize: 32.0,
                                                    fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                                          child: TextFormField(
                                            textCapitalization: TextCapitalization.sentences,
                                            decoration: InputDecoration(
                                              border: UnderlineInputBorder(),
                                              labelText: 'Task',
                                              labelStyle: TextStyle(fontSize: 16.0),
                                            ),
                                            maxLength: 50,
                                            keyboardType: TextInputType.multiline,
                                            controller: taskRecordKeeper,
                                            validator: (value) {
                                              if (value.length < 5) {
                                                return 'Task must be more than 5 character';
                                              } else if (value.length > 50) {
                                                return 'Task must be less than 50 character';
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
                                        ListTile(
                                          title: Padding(
                                            padding: EdgeInsets.only(bottom: 10.0),
                                            child: DateTimePickerFormField(
                                              format: dateFormat,
                                              onChanged: (dt) => setState(() => duedateRecordKeeper = dt),
                                              dateOnly: true,
                                              editable: false,
                                              resetIcon: null,
                                              style: TextStyle(fontSize: 16.0, color: Colors.black),
                                              decoration: InputDecoration(
                                                border: UnderlineInputBorder(),
                                                labelStyle: TextStyle(fontSize: 16.0),
                                                labelText: 'Due Date'
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
                                          trailing: IconButton(
                                            icon: Icon(Icons.add, color: AbubaPallate.greenabuba),
                                            onPressed: () {
                                              setState(() {
                                                if (taskRecordKeeper.text.isNotEmpty && duedateRecordKeeper != null) {
                                                  if (taskRecordKeeperArray.contains(taskRecordKeeper.text)) {

                                                  } else {
                                                    duedateRecordKeeperArray.add(duedateRecordKeeper);
                                                    taskRecordKeeperArray.add(taskRecordKeeper.text);
                                                    taskRecordKeeper.clear();
                                                  }
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                        Container(
                                          height: MediaQuery.of(context).size.height * 0.3,
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.only(left: 15.0, right: 15.0, top: taskRecordKeeperArray.length == 0 ? 0.0 : 10.0, bottom: taskRecordKeeperArray.length == 0 ? 0.0 : 10.0),
                                          child: Column(
                                            children: <Widget>[
                                              Expanded(
                                                child: ListView(
                                                  children: <Widget>[
                                                    Wrap(
                                                      spacing: 8.0,
                                                      runSpacing: 4.0,
                                                      runAlignment: WrapAlignment.start,
                                                      direction: Axis.horizontal,
                                                      children: taskRecordKeeperArray.length == 0
                                                        ? [Container()]
                                                        : taskRecordKeeperArray.map((String name) => Chip(
                                                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                                            label: RichText(
                                                              overflow: TextOverflow.ellipsis,
                                                              text: TextSpan(
                                                                text: name,
                                                                style: TextStyle(
                                                                  color: Colors.black,
                                                                  fontSize: 12.0
                                                                )
                                                              ),
                                                            ),
                                                            onDeleted: () {
                                                              setState(() {
                                                                duedateRecordKeeperArray.removeAt(taskRecordKeeperArray.indexOf(name));
                                                                taskRecordKeeperArray.remove(name);
                                                              });
                                                            },
                                                          )).toList(),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        )
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
                                                IconButton(
                                                  splashColor: Colors.transparent,
                                                  disabledColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                                                  onPressed: () {
                                                    if (taskRecordKeeperArray.length > 0) {
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
                                    width: width,
                                    height: 55.0,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '6. Complete Action Plan',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '34 of ${_title.length.toString()}',
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
                              height: height,
                              padding: EdgeInsets.symmetric(vertical: 15.0),
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                                child: Text(
                                                  'PARTICIPANTS',
                                                  style: TextStyle(
                                                    color: Color(0xFF2F592F),
                                                    fontSize: 32.0,
                                                    fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                                          child: TextFormField(
                                            textCapitalization: TextCapitalization.sentences,
                                            decoration: InputDecoration(
                                              border: UnderlineInputBorder(),
                                              labelText: 'Task',
                                              labelStyle: TextStyle(fontSize: 16.0),
                                            ),
                                            maxLength: 50,
                                            keyboardType: TextInputType.multiline,
                                            controller: taskParticipants,
                                            validator: (value) {
                                              if (value.length < 5) {
                                                return 'Task must be more than 5 character';
                                              } else if (value.length > 50) {
                                                return 'Task must be less than 50 character';
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
                                          padding: EdgeInsets.only(bottom: 10.0, left: 15.0, right: 15.0),
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
                                        ListTile(
                                          title: Padding(
                                            padding: EdgeInsets.only(bottom: 10.0),
                                            child: DateTimePickerFormField(
                                              format: dateFormat,
                                              onChanged: (dt) => setState(() => duedateParticipants = dt),
                                              dateOnly: true,
                                              editable: false,
                                              resetIcon: null,
                                              style: TextStyle(fontSize: 16.0, color: Colors.black),
                                              decoration: InputDecoration(
                                                border: UnderlineInputBorder(),
                                                labelStyle: TextStyle(fontSize: 16.0),
                                                labelText: 'Due Date'
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
                                          trailing: IconButton(
                                            icon: Icon(Icons.add, color: AbubaPallate.greenabuba),
                                            onPressed: () {
                                              setState(() {
                                                if (taskParticipants.text.isNotEmpty && duedateParticipants != null) {
                                                  if (taskParticipantsArray.contains(taskParticipants.text)) {

                                                  } else {
                                                    duedateParticipantsArray.add(duedateParticipants);
                                                    taskParticipantsArray.add(taskParticipants.text);
                                                    taskParticipants.clear();
                                                  }
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                        Container(
                                          height: MediaQuery.of(context).size.height * 0.25,
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.only(left: 15.0, right: 15.0, top: taskParticipantsArray.length == 0 ? 0.0 : 10.0, bottom: taskParticipantsArray.length == 0 ? 0.0 : 10.0),
                                          child: Column(
                                            children: <Widget>[
                                              Expanded(
                                                child: ListView(
                                                  shrinkWrap: true,
                                                  physics: ScrollPhysics(),
                                                  children: <Widget>[
                                                    Wrap(
                                                      spacing: 8.0,
                                                      runSpacing: 4.0,
                                                      runAlignment: WrapAlignment.start,
                                                      direction: Axis.horizontal,
                                                      children: taskParticipantsArray.length == 0
                                                        ? [Container()]
                                                        : taskParticipantsArray.map((String name) => Chip(
                                                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                                            label: RichText(
                                                              overflow: TextOverflow.ellipsis,
                                                              text: TextSpan(
                                                                text: name,
                                                                style: TextStyle(
                                                                  color: Colors.black,
                                                                  fontSize: 12.0
                                                                )
                                                              ),
                                                            ),
                                                            onDeleted: () {
                                                              setState(() {
                                                                duedateParticipantsArray.removeAt(taskParticipantsArray.indexOf(name));
                                                                taskParticipantsArray.remove(name);
                                                              });
                                                            },
                                                          )).toList(),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        )
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