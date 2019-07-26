import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormCreateCritic extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  FormCreateCritic({this.idUser, this.namaUser, this.departmentUser});

  @override
  _FormCreateCriticState createState() => _FormCreateCriticState();
}

class _FormCreateCriticState extends State<FormCreateCritic>
    with TickerProviderStateMixin {
  List<Map> _listData = [
    {'nomor': '1'},
    {'nomor': '2'},
  ];

  bool _isProccess = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  TextEditingController projectName = TextEditingController();
  TextEditingController ideAnda = TextEditingController();
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
  List<int> whoID = [];
  List<String> whoName = [];

  String _dataUsedSelection;
  String _dataUsed;
  List<Map> _dataUsedJson = [
    {"id": 1, "dataUsed": "Statistically"},
    {"id": 2, "dataUsed": "Random"},
  ];

  String _additionalDataCollectedSelection;
  String _additionalDataCollected;
  List<Map> _additionalDataCollectedJson = [
    {"id": 1, "additionalDataCollected": "Data Collection"},
    {"id": 2, "additionalDataCollected": "Research"},
    {"id": 3, "additionalDataCollected": "Interview"},
    {"id": 4, "additionalDataCollected": "Analysis"},
  ];

  String _pengaruhIdePotSelection;
  List<Map> _pengaruhIdePotJson = [
    {"id": 1, "pengaruhIdePot": "Cost Saving"},
    {"id": 2, "pengaruhIdePot": "Time Efficiency"},
    {"id": 3, "pengaruhIdePot": "Waste Reduction"},
  ];

  String _apabilaStakeholderSelection;
  List<Map> _apabilaStakeholderJson = [
    {"id": 1, "apabilaStakeholder": "Happy"},
    {"id": 2, "apabilaStakeholder": "Optimistic"},
    {"id": 3, "apabilaStakeholder": "Pessimistic"},
    {"id": 4, "apabilaStakeholder": "Angry"},
  ];

  String _mengecewakanStakeholderSelection;
  List<Map> _mengecewakanStakeholderJson = [
    {"id": 1, "mengecewakanStakeholder": "Time"},
    {"id": 2, "mengecewakanStakeholder": "Cost"},
    {"id": 3, "mengecewakanStakeholder": "Resource"},
    {"id": 4, "mengecewakanStakeholder": "Low Impact"},
  ];

  String _faktorPertimbanganSelection;
  List<Map> _faktorPertimbanganJson = [
    {"id": 1, "faktorPertimbangan": "Time"},
    {"id": 2, "faktorPertimbangan": "Cost"},
    {"id": 3, "faktorPertimbangan": "Resource"},
    {"id": 4, "faktorPertimbangan": "Technology"},
  ];

  String _ideBiayaSelection;
  List<Map> _ideBiayaJson = [
    {"id": 1, "ideBiaya": "Positive"},
    {"id": 2, "ideBiaya": "Negative"},
    {"id": 3, "ideBiaya": "Not Rellevant"},
  ];

  String _5ideSelection;
  List<Map> _5ideJson = [
    {"id": 1, "5ide": "Design"},
    {"id": 2, "5ide": "Time"},
    {"id": 3, "5ide": "Method"},
    {"id": 4, "5ide": "Material"},
    {"id": 5, "5ide": "Budget"},
    {"id": 6, "5ide": "Team"},
  ];

  String _halTerburukSelection;
  String _merugikanPerusahaanSelection;
  List<Map> _halTerburukJson = [
    {"id": 1, "halTerburuk": "Overtime"},
    {"id": 2, "halTerburuk": "Turnover"},
    {"id": 3, "halTerburuk": "Wasting money"},
    {"id": 4, "halTerburuk": "Wasting material"},
  ];

  String _ideGagalSelection;
  List<Map> _ideGagalJson = [
    {"id": 1, "ideGagal": "Ya"},
    {"id": 2, "ideGagal": "Tidak"},
    {"id": 3, "ideGagal": "Ide Baru"},
  ];

  String _pendekatanMasaSelection;
  List<Map> _pendekatanMasaJson = [
    {"id": 1, "pendekatanMasa": "Eliminate"},
    {"id": 2, "pendekatanMasa": "Change"},
    {"id": 3, "pendekatanMasa": "Substitute"},
    {"id": 4, "pendekatanMasa": "Minimaze"},
  ];

  String _kerugianPerusahaanSelection;
  List<Map> _kerugianPerusahaanJson = [
    {"id": 1, "kerugianPerusahaan": "Time"},
    {"id": 2, "kerugianPerusahaan": "Money"},
    {"id": 3, "kerugianPerusahaan": "Resource"},
    {"id": 4, "kerugianPerusahaan": "Product"},
    {"id": 5, "kerugianPerusahaan": "Tidak ada"},
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
                                                  '1. Finding Someone to Challenge Your Idea',
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
                                    ListTile(
                                      title: Container(
                                        width: 260.0,
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
                                      trailing: Container(
                                        width: 40.0,
                                      ),
                                    ),
                                    ListTile(
                                      title: Container(
                                        width: 260.0,
                                        child: TextFormField(
                                          textCapitalization:
                                          TextCapitalization.sentences,
                                          decoration: InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelText: 'Jelaskan Ide Anda',
                                            labelStyle: TextStyle(fontSize: 16.0),
                                          ),
                                          validator: (value) {
                                            if (value.length < 5) {
                                              return 'Value must be more than 5 character';
                                            } else {
                                              return null;
                                            }
                                          },
                                          controller: ideAnda,
                                          style: TextStyle(
                                              fontStyle: FontStyle.normal,
                                              color: Colors.black87,
                                              fontSize: 16.0),
                                          onSaved: null,
                                        ),
                                      ),
                                      trailing: Container(
                                        width: 40.0,
                                      ),
                                    ),
                                    ListTile(
                                      title: Container(
                                          width: 260.0,
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
                                                    labelText: 'Siapa saja pihak yang mungkin akan memiliki perbedaan perspektif dengan Anda dalam project ini',
                                                    labelStyle: TextStyle(fontSize: 14.0),
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
                                                                  fontSize: 12.0
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
                                      trailing: Container(
                                        width: 40.0,
                                        child: IconButton(
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
                                          deleteIcon: whoID[whoName.indexWhere((result) => result.startsWith(name))] == widget.idUser ? Icon(Icons.close, color: Colors.transparent,) : null,
                                          onDeleted: () {
                                            if (whoID[whoName.indexWhere((result) => result.startsWith(name))] == widget.idUser) {

                                            } else {
                                              setState(() {
                                                whoID.removeAt(whoName.indexOf(name));
                                                whoName.remove(name);
                                              });
                                            }
                                          },
                                        )).toList(),
                                      ),
                                    ),

                                    ListTile(
                                      title: Container(
                                          width: 260.0,
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
                                                    labelText: 'Siapa saja yang paling sering tidak sependapat dengan Anda di project sebelumnya',
                                                    labelStyle: TextStyle(fontSize: 14.0),
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
                                                                  fontSize: 12.0
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
                                      trailing: Container(
                                        width: 40.0,
                                        child: IconButton(
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
                                          deleteIcon: whoID[whoName.indexWhere((result) => result.startsWith(name))] == widget.idUser ? Icon(Icons.close, color: Colors.transparent,) : null,
                                          onDeleted: () {
                                            if (whoID[whoName.indexWhere((result) => result.startsWith(name))] == widget.idUser) {

                                            } else {
                                              setState(() {
                                                whoID.removeAt(whoName.indexOf(name));
                                                whoName.remove(name);
                                              });
                                            }
                                          },
                                        )).toList(),
                                      ),
                                    ),

                                    ListTile(
                                      title: Container(
                                          width: 260.0,
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
                                                    labelText: 'Siapa saja pihak yang memiliki “gaya bekerja” yang berbeda dengan Anda',
                                                    labelStyle: TextStyle(fontSize: 14.0),
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
                                                                  fontSize: 12.0
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
                                      trailing: Container(
                                        width: 40.0,
                                        child: IconButton(
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
                                          deleteIcon: whoID[whoName.indexWhere((result) => result.startsWith(name))] == widget.idUser ? Icon(Icons.close, color: Colors.transparent,) : null,
                                          onDeleted: () {
                                            if (whoID[whoName.indexWhere((result) => result.startsWith(name))] == widget.idUser) {

                                            } else {
                                              setState(() {
                                                whoID.removeAt(whoName.indexOf(name));
                                                whoName.remove(name);
                                              });
                                            }
                                          },
                                        )).toList(),
                                      ),
                                    ),

                                    ListTile(
                                      title: Container(
                                          width: 260.0,
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
                                                    labelText: 'Siapa saja yang pendapatnya Anda hargai namun sering tidak Anda jalankan',
                                                    labelStyle: TextStyle(fontSize: 14.0),
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
                                                                  fontSize: 12.0
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
                                      trailing: Container(
                                        width: 40.0,
                                        child: IconButton(
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
                                          deleteIcon: whoID[whoName.indexWhere((result) => result.startsWith(name))] == widget.idUser ? Icon(Icons.close, color: Colors.transparent,) : null,
                                          onDeleted: () {
                                            if (whoID[whoName.indexWhere((result) => result.startsWith(name))] == widget.idUser) {

                                            } else {
                                              setState(() {
                                                whoID.removeAt(whoName.indexOf(name));
                                                whoName.remove(name);
                                              });
                                            }
                                          },
                                        )).toList(),
                                      ),
                                    ),
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
                                                  '2. Potential Critics',
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
                                  height: MediaQuery.of(context).size.height *
                                      0.736,
                                  child: ListView(
                                    children: <Widget>[
                                      ListTile(
                                        title: Container(
                                            width: 260.0,
                                            child: DropdownButtonFormField<String>(
                                              decoration: InputDecoration(
                                                labelText:
                                                'Apa yang kira kira Anda lupa atau terlewatkan saat mengajukan ide ini ?',
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
                                        trailing: Container(
                                          width: 40.0,
                                          child: IconButton(
                                            icon: Icon(Icons.add, color: AbubaPallate.greenabuba),
                                            onPressed: () {
                                              setState(() {
                                                /*if (whoID.contains(int.tryParse(_whoSelection))) {

                                                } else {
                                                  whoID.add(int.tryParse(_whoSelection));
                                                }
                                                if (whoName.contains(_whoSelection2)) {

                                                } else {
                                                  whoName.add(_whoSelection2);
                                                }*/
                                              });
                                            },
                                          ),
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
                                            deleteIcon: whoID[whoName.indexWhere((result) => result.startsWith(name))] == widget.idUser ? Icon(Icons.close, color: Colors.transparent,) : null,
                                            onDeleted: () {
                                              if (whoID[whoName.indexWhere((result) => result.startsWith(name))] == widget.idUser) {

                                              } else {
                                                setState(() {
                                                  whoID.removeAt(whoName.indexOf(name));
                                                  whoName.remove(name);
                                                });
                                              }
                                            },
                                          )).toList(),
                                        ),
                                      ),

                                      ListTile(
                                        title: Container(
                                          width: 260.0,
                                          child: DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              labelText:
                                              'Apa saja pengaruh yang dihasilkan dari ide Anda ini ?',
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
                                            _pengaruhIdePotSelection,
                                            onChanged: (String value) {
                                              setState(() {
                                                _pengaruhIdePotSelection =
                                                    value;
                                              });
                                            },
                                            items: _pengaruhIdePotJson
                                                .map((Map map) {
                                              return DropdownMenuItem(
                                                value: map['id'].toString(),
                                                child: Text(
                                                    map[
                                                    'pengaruhIdePot'],
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.black87,
                                                        fontStyle:
                                                        FontStyle.normal)),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        trailing: Container(
                                          width: 40.0,
                                          child: IconButton(
                                            icon: Icon(Icons.add, color: AbubaPallate.greenabuba),
                                            onPressed: () {
                                              setState(() {
                                                /*if (whoID.contains(int.tryParse(_whoSelection))) {

                                                } else {
                                                  whoID.add(int.tryParse(_whoSelection));
                                                }
                                                if (whoName.contains(_whoSelection2)) {

                                                } else {
                                                  whoName.add(_whoSelection2);
                                                }*/
                                              });
                                            },
                                          ),
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
                                            deleteIcon: whoID[whoName.indexWhere((result) => result.startsWith(name))] == widget.idUser ? Icon(Icons.close, color: Colors.transparent,) : null,
                                            onDeleted: () {
                                              if (whoID[whoName.indexWhere((result) => result.startsWith(name))] == widget.idUser) {

                                              } else {
                                                setState(() {
                                                  whoID.removeAt(whoName.indexOf(name));
                                                  whoName.remove(name);
                                                });
                                              }
                                            },
                                          )).toList(),
                                        ),
                                      ),

                                      ListTile(
                                        title: Container(
                                          width: 260.0,
                                          child: DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              labelText:
                                              'Apabila Anda menjadi stakeholder, apa yang akan Anda pikirkan ?',
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
                                            _apabilaStakeholderSelection,
                                            onChanged: (String value) {
                                              setState(() {
                                                _apabilaStakeholderSelection =
                                                    value;
                                              });
                                            },
                                            items: _apabilaStakeholderJson
                                                .map((Map map) {
                                              return DropdownMenuItem(
                                                value: map['id'].toString(),
                                                child: Text(
                                                    map[
                                                    'apabilaStakeholder'],
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.black87,
                                                        fontStyle:
                                                        FontStyle.normal)),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        trailing: Container(
                                          width: 40.0,
                                          child: IconButton(
                                            icon: Icon(Icons.add, color: AbubaPallate.greenabuba),
                                            onPressed: () {
                                              setState(() {
                                                /*if (whoID.contains(int.tryParse(_whoSelection))) {

                                                } else {
                                                  whoID.add(int.tryParse(_whoSelection));
                                                }
                                                if (whoName.contains(_whoSelection2)) {

                                                } else {
                                                  whoName.add(_whoSelection2);
                                                }*/
                                              });
                                            },
                                          ),
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
                                            deleteIcon: whoID[whoName.indexWhere((result) => result.startsWith(name))] == widget.idUser ? Icon(Icons.close, color: Colors.transparent,) : null,
                                            onDeleted: () {
                                              if (whoID[whoName.indexWhere((result) => result.startsWith(name))] == widget.idUser) {

                                              } else {
                                                setState(() {
                                                  whoID.removeAt(whoName.indexOf(name));
                                                  whoName.remove(name);
                                                });
                                              }
                                            },
                                          )).toList(),
                                        ),
                                      ),

                                      ListTile(
                                        title: Container(
                                          width: 260.0,
                                          child: DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              labelText:
                                              'Apa saja yang kira – kira akan mengecewakan stakeholder ?',
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
                                            _mengecewakanStakeholderSelection,
                                            onChanged: (String value) {
                                              setState(() {
                                                _mengecewakanStakeholderSelection =
                                                    value;
                                              });
                                            },
                                            items: _mengecewakanStakeholderJson
                                                .map((Map map) {
                                              return DropdownMenuItem(
                                                value: map['id'].toString(),
                                                child: Text(
                                                    map[
                                                    'mengecewakanStakeholder'],
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.black87,
                                                        fontStyle:
                                                        FontStyle.normal)),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        trailing: Container(
                                          width: 40.0,
                                          child: IconButton(
                                            icon: Icon(Icons.add, color: AbubaPallate.greenabuba),
                                            onPressed: () {
                                              setState(() {
                                                /*if (whoID.contains(int.tryParse(_whoSelection))) {

                                                } else {
                                                  whoID.add(int.tryParse(_whoSelection));
                                                }
                                                if (whoName.contains(_whoSelection2)) {

                                                } else {
                                                  whoName.add(_whoSelection2);
                                                }*/
                                              });
                                            },
                                          ),
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
                                            deleteIcon: whoID[whoName.indexWhere((result) => result.startsWith(name))] == widget.idUser ? Icon(Icons.close, color: Colors.transparent,) : null,
                                            onDeleted: () {
                                              if (whoID[whoName.indexWhere((result) => result.startsWith(name))] == widget.idUser) {

                                              } else {
                                                setState(() {
                                                  whoID.removeAt(whoName.indexOf(name));
                                                  whoName.remove(name);
                                                });
                                              }
                                            },
                                          )).toList(),
                                        ),
                                      ),

                                      ListTile(
                                        title: Container(
                                          width: 260.0,
                                          child: DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              labelText:
                                              'Faktor apa saja yang belum Anda pertimbangkan ?',
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
                                            _faktorPertimbanganSelection,
                                            onChanged: (String value) {
                                              setState(() {
                                                _faktorPertimbanganSelection =
                                                    value;
                                              });
                                            },
                                            items: _faktorPertimbanganJson
                                                .map((Map map) {
                                              return DropdownMenuItem(
                                                value: map['id'].toString(),
                                                child: Text(
                                                    map[
                                                    'faktorPertimbangan'],
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.black87,
                                                        fontStyle:
                                                        FontStyle.normal)),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        trailing: Container(
                                          width: 40.0,
                                          child: IconButton(
                                            icon: Icon(Icons.add, color: AbubaPallate.greenabuba),
                                            onPressed: () {
                                              setState(() {
                                                /*if (whoID.contains(int.tryParse(_whoSelection))) {

                                                } else {
                                                  whoID.add(int.tryParse(_whoSelection));
                                                }
                                                if (whoName.contains(_whoSelection2)) {

                                                } else {
                                                  whoName.add(_whoSelection2);
                                                }*/
                                              });
                                            },
                                          ),
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
                                            deleteIcon: whoID[whoName.indexWhere((result) => result.startsWith(name))] == widget.idUser ? Icon(Icons.close, color: Colors.transparent,) : null,
                                            onDeleted: () {
                                              if (whoID[whoName.indexWhere((result) => result.startsWith(name))] == widget.idUser) {

                                              } else {
                                                setState(() {
                                                  whoID.removeAt(whoName.indexOf(name));
                                                  whoName.remove(name);
                                                });
                                              }
                                            },
                                          )).toList(),
                                        ),
                                      ),

                                      ListTile(
                                        title: Container(
                                          width: 260.0,
                                          child: DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              labelText:
                                              'Bagaimana pengaruhnya ide ini terhadap biaya ?',
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
                                            _ideBiayaSelection,
                                            onChanged: (String value) {
                                              setState(() {
                                                _ideBiayaSelection =
                                                    value;
                                              });
                                            },
                                            items: _ideBiayaJson
                                                .map((Map map) {
                                              return DropdownMenuItem(
                                                value: map['id'].toString(),
                                                child: Text(
                                                    map[
                                                    'ideBiaya'],
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.black87,
                                                        fontStyle:
                                                        FontStyle.normal)),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        trailing: Container(
                                          width: 40.0,
                                          child: IconButton(
                                            icon: Icon(Icons.add, color: AbubaPallate.greenabuba),
                                            onPressed: () {
                                              setState(() {
                                                /*if (whoID.contains(int.tryParse(_whoSelection))) {

                                                } else {
                                                  whoID.add(int.tryParse(_whoSelection));
                                                }
                                                if (whoName.contains(_whoSelection2)) {

                                                } else {
                                                  whoName.add(_whoSelection2);
                                                }*/
                                              });
                                            },
                                          ),
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
                                            deleteIcon: whoID[whoName.indexWhere((result) => result.startsWith(name))] == widget.idUser ? Icon(Icons.close, color: Colors.transparent,) : null,
                                            onDeleted: () {
                                              if (whoID[whoName.indexWhere((result) => result.startsWith(name))] == widget.idUser) {

                                              } else {
                                                setState(() {
                                                  whoID.removeAt(whoName.indexOf(name));
                                                  whoName.remove(name);
                                                });
                                              }
                                            },
                                          )).toList(),
                                        ),
                                      ),

                                      ListTile(
                                        title: Container(
                                          width: 260.0,
                                          child: DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              labelText:
                                              'Sebutkan 5 hal yang mungkin salah dengan ide Anda ini !',
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
                                            _5ideSelection,
                                            onChanged: (String value) {
                                              setState(() {
                                                _5ideSelection =
                                                    value;
                                              });
                                            },
                                            items: _5ideJson
                                                .map((Map map) {
                                              return DropdownMenuItem(
                                                value: map['id'].toString(),
                                                child: Text(
                                                    map[
                                                    '5ide'],
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.black87,
                                                        fontStyle:
                                                        FontStyle.normal)),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        trailing: Container(
                                          width: 40.0,
                                          child: IconButton(
                                            icon: Icon(Icons.add, color: AbubaPallate.greenabuba),
                                            onPressed: () {
                                              setState(() {
                                                /*if (whoID.contains(int.tryParse(_whoSelection))) {

                                                } else {
                                                  whoID.add(int.tryParse(_whoSelection));
                                                }
                                                if (whoName.contains(_whoSelection2)) {

                                                } else {
                                                  whoName.add(_whoSelection2);
                                                }*/
                                              });
                                            },
                                          ),
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
                                            deleteIcon: whoID[whoName.indexWhere((result) => result.startsWith(name))] == widget.idUser ? Icon(Icons.close, color: Colors.transparent,) : null,
                                            onDeleted: () {
                                              if (whoID[whoName.indexWhere((result) => result.startsWith(name))] == widget.idUser) {

                                              } else {
                                                setState(() {
                                                  whoID.removeAt(whoName.indexOf(name));
                                                  whoName.remove(name);
                                                });
                                              }
                                            },
                                          )).toList(),
                                        ),
                                      ),

                                      ListTile(
                                        title: Container(
                                          width: 260.0,
                                          child: DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              labelText:
                                              'Apa hal terburuk yang mungkin terjadi karena kesalahan tersebut di atas ?',
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
                                            _halTerburukSelection,
                                            onChanged: (String value) {
                                              setState(() {
                                                _halTerburukSelection =
                                                    value;
                                              });
                                            },
                                            items: _halTerburukJson
                                                .map((Map map) {
                                              return DropdownMenuItem(
                                                value: map['id'].toString(),
                                                child: Text(
                                                    map[
                                                    'halTerburuk'],
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.black87,
                                                        fontStyle:
                                                        FontStyle.normal)),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        trailing: Container(
                                          width: 40.0,
                                          child: IconButton(
                                            icon: Icon(Icons.add, color: AbubaPallate.greenabuba),
                                            onPressed: () {
                                              setState(() {
                                                /*if (whoID.contains(int.tryParse(_whoSelection))) {

                                                } else {
                                                  whoID.add(int.tryParse(_whoSelection));
                                                }
                                                if (whoName.contains(_whoSelection2)) {

                                                } else {
                                                  whoName.add(_whoSelection2);
                                                }*/
                                              });
                                            },
                                          ),
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
                                            deleteIcon: whoID[whoName.indexWhere((result) => result.startsWith(name))] == widget.idUser ? Icon(Icons.close, color: Colors.transparent,) : null,
                                            onDeleted: () {
                                              if (whoID[whoName.indexWhere((result) => result.startsWith(name))] == widget.idUser) {

                                              } else {
                                                setState(() {
                                                  whoID.removeAt(whoName.indexOf(name));
                                                  whoName.remove(name);
                                                });
                                              }
                                            },
                                          )).toList(),
                                        ),
                                      ),

                                      ListTile(
                                        title: Container(
                                          width: 260.0,
                                          child: DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              labelText:
                                              'Apa kira – kira yang akan berpotensi merugikan perusahaan dari ide Anda ini ?',
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
                                            _merugikanPerusahaanSelection,
                                            onChanged: (String value) {
                                              setState(() {
                                                _merugikanPerusahaanSelection =
                                                    value;
                                              });
                                            },
                                            items: _halTerburukJson
                                                .map((Map map) {
                                              return DropdownMenuItem(
                                                value: map['id'].toString(),
                                                child: Text(
                                                    map[
                                                    'halTerburuk'],
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.black87,
                                                        fontStyle:
                                                        FontStyle.normal)),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        trailing: Container(
                                          width: 40.0,
                                          child: IconButton(
                                            icon: Icon(Icons.add, color: AbubaPallate.greenabuba),
                                            onPressed: () {
                                              setState(() {
                                                /*if (whoID.contains(int.tryParse(_whoSelection))) {

                                                } else {
                                                  whoID.add(int.tryParse(_whoSelection));
                                                }
                                                if (whoName.contains(_whoSelection2)) {

                                                } else {
                                                  whoName.add(_whoSelection2);
                                                }*/
                                              });
                                            },
                                          ),
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
                                            deleteIcon: whoID[whoName.indexWhere((result) => result.startsWith(name))] == widget.idUser ? Icon(Icons.close, color: Colors.transparent,) : null,
                                            onDeleted: () {
                                              if (whoID[whoName.indexWhere((result) => result.startsWith(name))] == widget.idUser) {

                                              } else {
                                                setState(() {
                                                  whoID.removeAt(whoName.indexOf(name));
                                                  whoName.remove(name);
                                                });
                                              }
                                            },
                                          )).toList(),
                                        ),
                                      ),

                                      ListTile(
                                        title: Container(
                                          width: 260.0,
                                          child: DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              labelText:
                                              'Apakah ide ini pernah gagal di masa lalu ? Jelaskan',
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
                                            _ideGagalSelection,
                                            onChanged: (String value) {
                                              setState(() {
                                                _ideGagalSelection =
                                                    value;
                                              });
                                            },
                                            items: _ideGagalJson
                                                .map((Map map) {
                                              return DropdownMenuItem(
                                                value: map['id'].toString(),
                                                child: Text(
                                                    map[
                                                    'ideGagal'],
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.black87,
                                                        fontStyle:
                                                        FontStyle.normal)),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        trailing: Container(
                                          width: 40.0,
                                          child: IconButton(
                                            icon: Icon(Icons.add, color: AbubaPallate.greenabuba),
                                            onPressed: () {
                                              setState(() {
                                                /*if (whoID.contains(int.tryParse(_whoSelection))) {

                                                } else {
                                                  whoID.add(int.tryParse(_whoSelection));
                                                }
                                                if (whoName.contains(_whoSelection2)) {

                                                } else {
                                                  whoName.add(_whoSelection2);
                                                }*/
                                              });
                                            },
                                          ),
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
                                            deleteIcon: whoID[whoName.indexWhere((result) => result.startsWith(name))] == widget.idUser ? Icon(Icons.close, color: Colors.transparent,) : null,
                                            onDeleted: () {
                                              if (whoID[whoName.indexWhere((result) => result.startsWith(name))] == widget.idUser) {

                                              } else {
                                                setState(() {
                                                  whoID.removeAt(whoName.indexOf(name));
                                                  whoName.remove(name);
                                                });
                                              }
                                            },
                                          )).toList(),
                                        ),
                                      ),

                                      ListTile(
                                        title: Container(
                                          width: 260.0,
                                          child: DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              labelText:
                                              'Apakah ide ini pernah gagal di masa lalu ? Jelaskan',
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
                                            _ideGagalSelection,
                                            onChanged: (String value) {
                                              setState(() {
                                                _ideGagalSelection =
                                                    value;
                                              });
                                            },
                                            items: _ideGagalJson
                                                .map((Map map) {
                                              return DropdownMenuItem(
                                                value: map['id'].toString(),
                                                child: Text(
                                                    map[
                                                    'ideGagal'],
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.black87,
                                                        fontStyle:
                                                        FontStyle.normal)),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        trailing: Container(
                                          width: 40.0,
                                          child: IconButton(
                                            icon: Icon(Icons.add, color: AbubaPallate.greenabuba),
                                            onPressed: () {
                                              setState(() {
                                                /*if (whoID.contains(int.tryParse(_whoSelection))) {

                                                } else {
                                                  whoID.add(int.tryParse(_whoSelection));
                                                }
                                                if (whoName.contains(_whoSelection2)) {

                                                } else {
                                                  whoName.add(_whoSelection2);
                                                }*/
                                              });
                                            },
                                          ),
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
                                            deleteIcon: whoID[whoName.indexWhere((result) => result.startsWith(name))] == widget.idUser ? Icon(Icons.close, color: Colors.transparent,) : null,
                                            onDeleted: () {
                                              if (whoID[whoName.indexWhere((result) => result.startsWith(name))] == widget.idUser) {

                                              } else {
                                                setState(() {
                                                  whoID.removeAt(whoName.indexOf(name));
                                                  whoName.remove(name);
                                                });
                                              }
                                            },
                                          )).toList(),
                                        ),
                                      ),

                                      ListTile(
                                        title: Container(
                                          width: 260.0,
                                          child: DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              labelText:
                                              'Pendekatan apa yang lebih baik dan harus dilakukan agar masalah di masa lalu tidak terulang lagi ? ',
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
                                            _pendekatanMasaSelection,
                                            onChanged: (String value) {
                                              setState(() {
                                                _pendekatanMasaSelection =
                                                    value;
                                              });
                                            },
                                            items: _pendekatanMasaJson
                                                .map((Map map) {
                                              return DropdownMenuItem(
                                                value: map['id'].toString(),
                                                child: Text(
                                                    map[
                                                    'pendekatanMasa'],
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.black87,
                                                        fontStyle:
                                                        FontStyle.normal)),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        trailing: Container(
                                          width: 40.0,
                                          child: IconButton(
                                            icon: Icon(Icons.add, color: AbubaPallate.greenabuba),
                                            onPressed: () {
                                              setState(() {
                                                /*if (whoID.contains(int.tryParse(_whoSelection))) {

                                                } else {
                                                  whoID.add(int.tryParse(_whoSelection));
                                                }
                                                if (whoName.contains(_whoSelection2)) {

                                                } else {
                                                  whoName.add(_whoSelection2);
                                                }*/
                                              });
                                            },
                                          ),
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
                                            deleteIcon: whoID[whoName.indexWhere((result) => result.startsWith(name))] == widget.idUser ? Icon(Icons.close, color: Colors.transparent,) : null,
                                            onDeleted: () {
                                              if (whoID[whoName.indexWhere((result) => result.startsWith(name))] == widget.idUser) {

                                              } else {
                                                setState(() {
                                                  whoID.removeAt(whoName.indexOf(name));
                                                  whoName.remove(name);
                                                });
                                              }
                                            },
                                          )).toList(),
                                        ),
                                      ),

                                      ListTile(
                                        title: Container(
                                          width: 260.0,
                                          child: DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              labelText:
                                              'Apa kerugian bagi perusahaan atau proses bila ide Anda ini tidak dijalankan ?',
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
                                            _kerugianPerusahaanSelection,
                                            onChanged: (String value) {
                                              setState(() {
                                                _kerugianPerusahaanSelection =
                                                    value;
                                              });
                                            },
                                            items: _kerugianPerusahaanJson
                                                .map((Map map) {
                                              return DropdownMenuItem(
                                                value: map['id'].toString(),
                                                child: Text(
                                                    map[
                                                    'kerugianPerusahaan'],
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.black87,
                                                        fontStyle:
                                                        FontStyle.normal)),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        trailing: Container(
                                          width: 40.0,
                                          child: IconButton(
                                            icon: Icon(Icons.add, color: AbubaPallate.greenabuba),
                                            onPressed: () {
                                              setState(() {
                                                /*if (whoID.contains(int.tryParse(_whoSelection))) {

                                                } else {
                                                  whoID.add(int.tryParse(_whoSelection));
                                                }
                                                if (whoName.contains(_whoSelection2)) {

                                                } else {
                                                  whoName.add(_whoSelection2);
                                                }*/
                                              });
                                            },
                                          ),
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
                                            deleteIcon: whoID[whoName.indexWhere((result) => result.startsWith(name))] == widget.idUser ? Icon(Icons.close, color: Colors.transparent,) : null,
                                            onDeleted: () {
                                              if (whoID[whoName.indexWhere((result) => result.startsWith(name))] == widget.idUser) {

                                              } else {
                                                setState(() {
                                                  whoID.removeAt(whoName.indexOf(name));
                                                  whoName.remove(name);
                                                });
                                              }
                                            },
                                          )).toList(),
                                        ),
                                      ),
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
                                                          /*if (_formKey.currentState.validate()) {
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
                                                          }*/
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
