import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_abuba/isoft/operation_page/internalaudit/beranda_audit.dart';

class FormCreateNew extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;

  FormCreateNew({this.idUser, this.namaUser, this.departmentUser});

  @override
  _FormCreateNewState createState() => _FormCreateNewState();
}

class _FormCreateNewState extends State<FormCreateNew> with TickerProviderStateMixin {
  TabController _tabController;
  AnimationController animationController;

  final List<Tab> internalAuditTabs = <Tab>[
    new Tab(child: Text('Period', style: TextStyle(color: Colors.grey[400]))),
    new Tab(child: Text('Schedule', style: TextStyle(color: Colors.grey[400]))),
    new Tab(child: Text('Team', style: TextStyle(color: Colors.grey[400]))),
    new Tab(child: Text('Preview ', style: TextStyle(color: Colors.grey[400]))),
  ];
  FocusNode focusNode;

  List<String> departmentName = [];
  List<int> departmentID = [];
  List<String> object = [];
  List<int> objectID = [];
  List<bool> value = [];

  List<String> selectedDepartment = [];
  List<int> selectedDepartmentID = [];
  List<int> selectedObjectID = [];
  List<String> selectedObject = [];
  List<DateTime> selectedTanggal = [];

  final now = DateTime.now();
  List<DateTime> selectedDate = [];
  
  List<String> leadAuditorName = [];
  List<String> leadAuditorNameID = [];
  List<String> auditeeName = [];
  List<String> auditeeNameID = [];
  List<String> auditorName = [];
  List<String> auditorNameID = [];
  List<List<String>> auditorNameForSave = [];
  List<List<int>> auditorNameIDForSave = [];

  List<List<String>> auditorFinal = [];
  List<String> subArea = [];

  String mySelection;
  DateTime dateStart = null;
  DateTime dateEnd = null;
  bool isProcess = false;

  var maxidIA;
  var indexIA;

  @override
  void initState() {
    super.initState();
    focusNode = new FocusNode();
    _tabController = TabController(vsync: this, length: internalAuditTabs.length);

    Firestore.instance.collection('dumper_IA').snapshots().listen((data) {
      setState(() {
        maxidIA = data.documents[0].data['maxid_ia'] + 1;
        indexIA = data.documents[0].documentID;
      });
    }); 

    CollectionReference reference = Firestore.instance.collection('audit_object');
    reference.orderBy('department', descending: false).snapshots().listen((data) {
      data.documentChanges.forEach((change) {
        setState(() {
          object.add(change.document.data['object']);
          objectID.add(change.document.data['id']);
          value.add(false);
          selectedDate.add(null);

          Firestore.instance.collection('department').where('id', isEqualTo: change.document.data['department']).snapshots().listen((data2) {
            departmentName.add(data2.documents[0].data['name']);
            departmentID.add(data2.documents[0].data['id']);
          });
        });
      });
    });

    CollectionReference reference2 = Firestore.instance.collection('audit_subArea');
    reference2.orderBy('id', descending: false).snapshots().listen((data3) {
      data3.documentChanges.forEach((change2) {
        setState(() {
          subArea.add(change2.document.data['sub']);
        });
      });
    });

    animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(
      from: animationController.value == 0.0
        ? 1.0
        : animationController.value
    );
  }

  void setFocus() {
    FocusScope.of(context).requestFocus(focusNode);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _appBar() {
    return AppBar(
      elevation: 0.25,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.asset(
            'assets/images/logo2.png',
            height: 150.0,
            width: 120.0,
          ),
          new Container(
            child: new Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        color: Colors.red[500],
                        size: 20.0,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        '41 pts',
                        style: TextStyle(fontSize: 12.0, color: Colors.grey),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
      bottom: new TabBar(
        controller: _tabController,
        isScrollable: true,
        indicatorColor: AbubaPallate.greenabuba,
        tabs: internalAuditTabs,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: _appBar(),
          body: AnimatedBuilder(
            animation: animationController,
            builder: (_, Widget child) {
              return  animationController.isAnimating
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 125.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                width: 250.0,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: Colors.black87),
                                  ),
                                ),
                                child: FlatButton(
                                  onPressed: () async {
                                    final DateTime picked = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2019, 1),
                                      lastDate: DateTime(2101));
                                    if (picked != null && picked != dateStart)
                                      setState(() {
                                        dateStart = picked;
                                      });
                                  },
                                  child: Text(
                                    dateStart == null ? 'Start' : dateStart.toString().substring(8, 10) + '/' + dateStart.toString().substring(5, 7) + '/' + dateStart.toString().substring(0, 4),
                                    style: TextStyle(
                                      color: Colors.black45
                                    ),
                                  ),
                                )
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                width: 250.0,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: Colors.black87),
                                  ),
                                ),
                                child: FlatButton(
                                  onPressed: () async {
                                    final DateTime picked = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2019, 1),
                                      lastDate: DateTime(2101));
                                    if (picked != null && picked != dateEnd)
                                      setState(() {
                                        dateEnd = picked;
                                      });
                                  },
                                  child: Text(
                                    dateEnd == null ? 'End' : dateEnd.toString().substring(8, 10) + '/' + dateEnd.toString().substring(5, 7) + '/' + dateEnd.toString().substring(0, 4),
                                    style: TextStyle(
                                      color: Colors.black45
                                    ),
                                  ),
                                )
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 10.0, right: 60.0),
                                    child: ButtonTheme(
                                      minWidth: 50.0,
                                      height: 30.0,
                                      child: OutlineButton(
                                        child: Text(
                                          'NEXT',
                                          style: TextStyle(fontSize: 13.0, color: Colors.blue),
                                        ),
                                        borderSide: BorderSide(color: Colors.blue, width: 1.0),
                                        highlightedBorderColor: Colors.blue,
                                        onPressed: () {
                                          _tabController.animateTo((_tabController.index + 1) % 2);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      ListView(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 35.0,
                                  child: Container(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Department',
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 12.0),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Flexible(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Divisi',
                                                style: TextStyle(
                                                    color: Colors.white, fontSize: 12.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF2F592F),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: List.generate(object.length, (index) {
                              return Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.3,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  departmentName[index],
                                                  style: TextStyle(color: Colors.grey[500], fontSize: 13.0, fontWeight: FontWeight.w500)
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.6 - 40.0,
                                          child: CheckboxListTile(
                                            value: value[index],
                                            onChanged: (valueChange) async {
                                              if (valueChange) {
                                                final DateTime picked = await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2019, 1),
                                                  lastDate: DateTime(2101),
                                                );

                                                if (!selectedObject.contains(object[index])) {
                                                  setState(() {
                                                    selectedObjectID.add(objectID[index]);
                                                    selectedObject.add(object[index]);
                                                    selectedDepartment.add(departmentName[index]);
                                                    selectedDepartmentID.add(departmentID[index]);
                                                    selectedTanggal.add(picked);
                                                    leadAuditorNameID.add(null);
                                                    leadAuditorName.add(null);
                                                    auditeeNameID.add(null);
                                                    auditeeName.add(null);
                                                    auditorNameID.add(null);
                                                    auditorName.add(null);
                                                    auditorNameForSave.add([]);
                                                    auditorNameIDForSave.add([]);
                                                    auditorFinal.add([]);
                                                    value.removeAt(index);
                                                    value.insert(index, true);
                                                    },
                                                  );
                                                }
                                                if (picked != null && picked != selectedDate[index]) {
                                                  if (dateStart != null && dateEnd != null) {
                                                    if (picked.isAfter(dateEnd) == false && picked.isBefore(dateStart) == false) {
                                                      setState(() {
                                                        selectedDate.removeAt(index);
                                                        selectedDate.insert(index, picked);
                                                      });
                                                    } else {
                                                      int indexWhere = 0;
                                                      setState(() {
                                                        indexWhere = selectedObjectID.indexWhere((int result) => result == objectID[index]);
                                                      });
                                                      selectedDepartment.removeAt(indexWhere);
                                                      selectedTanggal.removeAt(indexWhere);
                                                      selectedDepartmentID.removeAt(indexWhere);
                                                      selectedObject.removeWhere((String city) => city == object[index]);
                                                      selectedObjectID.removeWhere((int city) => city == objectID[index]);
                                                      leadAuditorNameID.removeLast();
                                                      leadAuditorName.removeLast();
                                                      auditeeNameID.removeLast();
                                                      auditeeName.removeLast();
                                                      auditorNameID.removeLast();
                                                      auditorName.removeLast();
                                                      auditorNameForSave.removeLast();
                                                      auditorNameIDForSave.removeLast();
                                                      auditorFinal.removeLast();

                                                      selectedDate.removeAt(index);
                                                      selectedDate.insert(index, null);
                                                      value.removeAt(index);
                                                      value.insert(index, false);
                                                      
                                                      showDialog(
                                                        barrierDismissible: false,
                                                        context: context,
                                                        builder: (context) => Dialog(
                                                          child: Container(
                                                            height: 180.0,
                                                            child: Column(
                                                              children: <Widget>[
                                                                Container(
                                                                  color: Colors.orangeAccent,
                                                                  height: 50.0,
                                                                  child: Center(
                                                                    child: Text(
                                                                      'Alert!',
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
                                                                    'Date not in period',
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
                                                      );
                                                    }
                                                  } else {
                                                    int indexWhere = 0;
                                                    setState(() {
                                                      indexWhere = selectedObjectID.indexWhere((int result) => result == objectID[index]);
                                                    });
                                                    selectedDepartment.removeAt(indexWhere);
                                                    selectedTanggal.removeAt(indexWhere);
                                                    selectedDepartmentID.removeAt(indexWhere);
                                                    selectedObject.removeWhere((String city) => city == object[index]);
                                                    selectedObjectID.removeWhere((int city) => city == objectID[index]);
                                                    leadAuditorNameID.removeLast();
                                                    leadAuditorName.removeLast();
                                                    auditeeNameID.removeLast();
                                                    auditeeName.removeLast();
                                                    auditorNameID.removeLast();
                                                    auditorName.removeLast();
                                                    auditorNameForSave.removeLast();
                                                    auditorNameIDForSave.removeLast();
                                                    auditorFinal.removeLast();

                                                    selectedDate.removeAt(index);
                                                    selectedDate.insert(index, null);
                                                    value.removeAt(index);
                                                    value.insert(index, false);

                                                    showDialog(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder: (context) => Dialog(
                                                        child: Container(
                                                          height: 180.0,
                                                          child: Column(
                                                            children: <Widget>[
                                                              Container(
                                                                color: Colors.orangeAccent,
                                                                height: 50.0,
                                                                child: Center(
                                                                  child: Text(
                                                                    'Alert!',
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
                                                                  'Period is empty',
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
                                                    );
                                                  }
                                                } else {
                                                  int indexWhere = 0;
                                                  setState(() {
                                                    indexWhere = selectedObjectID.indexWhere((int result) => result == objectID[index]);
                                                  });
                                                  selectedDepartment.removeAt(indexWhere);
                                                  selectedTanggal.removeAt(indexWhere);
                                                  selectedDepartmentID.removeAt(indexWhere);
                                                  selectedObject.removeWhere((String city) => city == object[index]);
                                                  selectedObjectID.removeWhere((int city) => city == objectID[index]);
                                                  leadAuditorNameID.removeLast();
                                                  leadAuditorName.removeLast();
                                                  auditeeNameID.removeLast();
                                                  auditeeName.removeLast();
                                                  auditorNameID.removeLast();
                                                  auditorName.removeLast();
                                                  auditorNameForSave.removeLast();
                                                  auditorNameIDForSave.removeLast();
                                                  auditorFinal.removeLast();

                                                  selectedDate.removeAt(index);
                                                  selectedDate.insert(index, null);
                                                  value.removeAt(index);
                                                  value.insert(index, false);
                                                }
                                              } else {
                                                int indexWhere = 0;
                                                if (selectedObject.contains(object[index])) {
                                                  setState(() {
                                                    indexWhere = selectedObjectID.indexWhere((int result) => result == objectID[index]);
                                                    selectedDepartment.removeAt(indexWhere);
                                                    selectedTanggal.removeAt(indexWhere);
                                                    selectedDepartmentID.removeAt(indexWhere);
                                                    selectedObject.removeWhere((String city) => city == object[index]);
                                                    selectedObjectID.removeWhere((int city) => city == objectID[index]);
                                                    leadAuditorNameID.removeLast();
                                                    leadAuditorName.removeLast();
                                                    auditeeNameID.removeLast();
                                                    auditeeName.removeLast();
                                                    auditorNameID.removeLast();
                                                    auditorName.removeLast();
                                                    auditorNameForSave.removeLast();
                                                    auditorNameIDForSave.removeLast();
                                                    auditorFinal.removeLast();
                                                    },
                                                  );
                                                }
                                                setState(() {
                                                  selectedDate.removeAt(index);
                                                  selectedDate.insert(index, null);
                                                  value.removeAt(index);
                                                  value.insert(index, false);
                                                });
                                              }

                                              print(selectedDepartment);
                                              print(selectedObject);
                                              print(selectedObjectID);
                                              print(selectedTanggal);
                                            },
                                            subtitle: RichText(
                                              softWrap: true,
                                              overflow: TextOverflow.visible,
                                              text: TextSpan(
                                                text: selectedDate[index] == null ? '-' : selectedDate[index].toString().substring(8, 10) + '/' + selectedDate[index].toString().substring(5, 7) + '/' + selectedDate[index].toString().substring(0, 4),
                                                style: TextStyle(color: Colors.grey[500], fontSize: 12.0, fontWeight: FontWeight.w500),
                                              )
                                            ),
                                            title: RichText(
                                              softWrap: true,
                                              overflow: TextOverflow.visible,
                                              text: TextSpan(
                                                text: object[index],
                                                style: TextStyle(color: Colors.grey[500], fontSize: 12.0, fontWeight: FontWeight.w500),
                                              )
                                            ),
                                            controlAffinity: ListTileControlAffinity.leading,
                                            activeColor: AbubaPallate.greenabuba,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.green,
                                    height: 15.0,
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0, right: 20.0),
                                child: ButtonTheme(
                                  minWidth: 50.0,
                                  height: 30.0,
                                  child: OutlineButton(
                                    child: Text(
                                      'NEXT',
                                      style:
                                          TextStyle(fontSize: 13.0, color: Colors.blue),
                                    ),
                                    borderSide:
                                        BorderSide(color: Colors.blue, width: 1.0),
                                    highlightedBorderColor: Colors.blue,
                                    onPressed: () {
                                      _tabController.animateTo((_tabController.index + 1));
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      ListView(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 35.0,
                                  child: Container(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Department',
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 12.0),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Flexible(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Auditor',
                                                style: TextStyle(
                                                    color: Colors.white, fontSize: 12.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF2F592F),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: List.generate(selectedObject.length, (index) {
                              return Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 10.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.3,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          selectedDepartment[index],
                                                          style: TextStyle(color: Colors.grey[500], fontSize: 13.0, fontWeight: FontWeight.w700)
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 3.0,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          selectedObject[index],
                                                          style: TextStyle(color: AbubaPallate.greenabuba, fontSize: 13.0, fontWeight: FontWeight.w700)
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 3.0,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          selectedTanggal[index].toString().substring(8, 10) + '/' + selectedTanggal[index].toString().substring(5, 7) + '/' + selectedTanggal[index].toString().substring(0, 4),
                                                          style: TextStyle(color: Colors.grey[500], fontSize: 13.0, fontWeight: FontWeight.w700)
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),

                                            // auditee setting up
                                            selectedDepartment[index] == 'Operational'
                                              ? Container(
                                                  width: MediaQuery.of(context).size.width * 0.55,
                                                  child: StreamBuilder(
                                                    stream: Firestore.instance.collection('user').where('outlet', isEqualTo: selectedObjectID[index]).where('role', arrayContains: 'auditee').snapshots(),
                                                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                                      if (!snapshot.hasData)
                                                        return Container(
                                                          child: Center(
                                                            child: CircularProgressIndicator(),
                                                          ),
                                                        );

                                                      return DropdownButtonFormField<String>(
                                                        decoration: InputDecoration(
                                                          labelText: 'Auditee',
                                                          labelStyle: TextStyle(fontSize: 12.0),
                                                        ),
                                                        validator: (value) {
                                                          if (value == null) {
                                                            return 'Please select auditee';
                                                          } else {
                                                            return null;
                                                          }
                                                        },
                                                        value: auditeeNameID[index],
                                                        onChanged: (String value) {
                                                          Firestore.instance.collection('user').where('id', isEqualTo: int.tryParse(value)).snapshots().listen((data) {
                                                            setState(() {
                                                              auditeeName.removeAt(index);
                                                              auditeeName.insert(index, data.documents[0].data['nama']);
                                                              auditeeNameID.removeAt(index);
                                                              auditeeNameID.insert(index, value);
                                                            });
                                                          });
                                                        },
                                                        items: List.generate(snapshot.data.documents.length, (index2) {
                                                          return DropdownMenuItem(
                                                            value: snapshot.data.documents[index2]['id'].toString(),
                                                            child: Container(
                                                              padding: EdgeInsets.all(10.0),
                                                              child: RichText(
                                                                overflow: TextOverflow.visible,
                                                                text: TextSpan(
                                                                  text: snapshot.data.documents[index2]['nama'].toString(),
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
                                                )
                                              : Container(
                                                  width: MediaQuery.of(context).size.width * 0.55,
                                                  child: StreamBuilder(
                                                    stream: Firestore.instance.collection('user').where('departmentID', isEqualTo: selectedDepartmentID[index]).snapshots(),
                                                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                                      if (!snapshot.hasData)
                                                        return Container(
                                                          child: Center(
                                                            child: CircularProgressIndicator(),
                                                          ),
                                                        );

                                                      return DropdownButtonFormField<String>(
                                                        decoration: InputDecoration(
                                                          labelText: 'Auditee',
                                                          labelStyle: TextStyle(fontSize: 12.0),
                                                        ),
                                                        validator: (value) {
                                                          if (value == null) {
                                                            return 'Please select auditee';
                                                          } else {
                                                            return null;
                                                          }
                                                        },
                                                        value: auditeeNameID[index],
                                                        onChanged: (String value) {
                                                          Firestore.instance.collection('user').where('id', isEqualTo: int.tryParse(value)).snapshots().listen((data) {
                                                            setState(() {
                                                              auditeeName.removeAt(index);
                                                              auditeeName.insert(index, data.documents[0].data['nama']);
                                                              auditeeNameID.removeAt(index);
                                                              auditeeNameID.insert(index, value);
                                                            });
                                                          });
                                                        },
                                                        items: List.generate(snapshot.data.documents.length, (index2) {
                                                          return DropdownMenuItem(
                                                            value: snapshot.data.documents[index2]['id'].toString(),
                                                            child: Container(
                                                              padding: EdgeInsets.all(10.0),
                                                              child: RichText(
                                                                overflow: TextOverflow.visible,
                                                                text: TextSpan(
                                                                  text: snapshot.data.documents[index2]['nama'].toString(),
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
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.3,
                                              child: Text(' ')
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.55,
                                              child: StreamBuilder(
                                                stream: Firestore.instance.collection('user').where('role', arrayContains: 'leadAuditor').snapshots(),
                                                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                                  if (!snapshot.hasData)
                                                    return Container(
                                                      child: Center(
                                                        child: CircularProgressIndicator(),
                                                      ),
                                                    );

                                                  return DropdownButtonFormField<String>(
                                                    decoration: InputDecoration(
                                                      labelText: 'Lead Auditor',
                                                      labelStyle: TextStyle(fontSize: 12.0),
                                                    ),
                                                    validator: (value) {
                                                      if (value == null) {
                                                        return 'Please select lead auditor';
                                                      } else {
                                                        return null;
                                                      }
                                                    },
                                                    value: leadAuditorNameID[index],
                                                    onChanged: (String value) {
                                                      Firestore.instance.collection('user').where('id', isEqualTo: int.tryParse(value)).snapshots().listen((data) {
                                                        setState(() {
                                                          leadAuditorName.removeAt(index);
                                                          leadAuditorName.insert(index, data.documents[0].data['nama']);
                                                          leadAuditorNameID.removeAt(index);
                                                          leadAuditorNameID.insert(index, value);
                                                        });
                                                      });
                                                    },
                                                    items: snapshot.data.documents.map((DocumentSnapshot document) {
                                                      return DropdownMenuItem(
                                                        value: document['id'].toString(),
                                                        child: Container(
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
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.3,
                                              child: Text(' ')
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.55,
                                              // child: ListTile(
                                                // title: 
                                                child: StreamBuilder(
                                                  stream: Firestore.instance.collection('user').where('role', arrayContains: 'auditor').snapshots(),
                                                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                                    if (!snapshot.hasData)
                                                      return Container(
                                                        child: Center(
                                                          child: CircularProgressIndicator(),
                                                        ),
                                                      );

                                                    return DropdownButtonFormField<String>(
                                                      decoration: InputDecoration(
                                                        labelText: 'Auditor',
                                                        labelStyle: TextStyle(fontSize: 12.0),
                                                      ),
                                                      validator: (value) {
                                                        if (value == null) {
                                                          return 'Please select auditor';
                                                        } else {
                                                          return null;
                                                        }
                                                      },
                                                      value: auditorNameID[index],
                                                      onChanged: (String value) {
                                                        Firestore.instance.collection('user').where('id', isEqualTo: int.tryParse(value)).snapshots().listen((data) {
                                                          setState(() {
                                                            auditorName.removeAt(index);
                                                            auditorName.insert(index, data.documents[0].data['nama']);
                                                            auditorNameID.removeAt(index);
                                                            auditorNameID.insert(index, value);

                                                            if (auditorNameIDForSave[index].contains(int.tryParse(auditorNameID[index]))) {

                                                            } else {
                                                              auditorNameIDForSave[index].add(int.tryParse(auditorNameID[index]));
                                                            }
                                                            if (auditorNameForSave[index].contains(auditorName[index])) {

                                                            } else {
                                                              auditorNameForSave[index].add(auditorName[index]);
                                                            }

                                                            if (auditorFinal[index].length == 0 || auditorFinal[index].length < 10) {
                                                              for (int s = 0; s < subArea.length; s++) {
                                                                auditorFinal[index].add(null);
                                                              }
                                                            }
                                                            print(auditorNameForSave);
                                                            print(auditorNameIDForSave);
                                                            print(auditorFinal);
                                                          });
                                                        });
                                                      },
                                                      items: snapshot.data.documents.map((DocumentSnapshot document) {
                                                        return DropdownMenuItem(
                                                          value: document['id'].toString(),
                                                          child: Container(
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
                                                ),
                                              //   trailing: GestureDetector(
                                              //     child: Icon(Icons.add, color: AbubaPallate.menuBluebird),
                                              //     onTap: () {
                                                    // setState(() {
                                                    //   if (auditorNameIDForSave[index].contains(int.tryParse(auditorNameID[index]))) {

                                                    //   } else {
                                                    //     auditorNameIDForSave[index].add(int.tryParse(auditorNameID[index]));
                                                    //   }
                                                    //   if (auditorNameForSave[index].contains(auditorName[index])) {

                                                    //   } else {
                                                    //     auditorNameForSave[index].add(auditorName[index]);
                                                    //   }

                                                    //   if (auditorFinal[index].length == 0 || auditorFinal[index].length < 10) {
                                                    //     for (int s = 0; s < subArea.length; s++) {
                                                    //       auditorFinal[index].add(null);
                                                    //     }
                                                    //   }
                                                    // });
                                                    // print(auditorNameForSave);
                                                    // print(auditorNameIDForSave);
                                                    // print(auditorFinal);
                                              //     },
                                              //   )
                                              // )
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width,
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.only(top: auditorNameForSave[index].length == 0 ? 0.0 : 10.0, bottom: auditorNameForSave[index].length == 0 ? 0.0 : 20.0),
                                          child: Wrap(
                                            spacing: 8.0,
                                            runSpacing: 4.0,
                                            runAlignment: WrapAlignment.start,
                                            direction: Axis.horizontal,
                                            children: auditorNameForSave[index].length == 0
                                              ? [Container()]
                                              : auditorNameForSave[index].map((String name) => Chip(
                                                  label: Text(name),
                                                  onDeleted: () {
                                                    setState(() {
                                                      auditorNameIDForSave[index].removeAt(auditorNameForSave[index].indexOf(name));
                                                      auditorNameForSave[index].remove(name);
                                                    });
                                                  },
                                                )).toList(),
                                          ),
                                        )
                                      ],
                                    )
                                  ),
                                  Divider(
                                    color: Colors.green,
                                    height: 15.0,
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0, right: 20.0),
                                child: ButtonTheme(
                                  minWidth: 50.0,
                                  height: 30.0,
                                  child: OutlineButton(
                                    child: Text(
                                      'NEXT',
                                      style: TextStyle(
                                          fontSize: 13.0, color: Colors.blue),
                                    ),
                                    borderSide:
                                        BorderSide(color: Colors.blue, width: 1.0),
                                    highlightedBorderColor: Colors.blue,
                                    onPressed: () {
                                      _tabController.animateTo(_tabController.index + 1);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      ListView(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 35.0,
                                  child: Container(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Department',
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 12.0),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Flexible(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Sub Area',
                                                style: TextStyle(
                                                    color: Colors.white, fontSize: 12.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF2F592F),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: List.generate(selectedObject.length, (index) {
                              return Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 10.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              alignment: Alignment.topLeft,
                                              width: MediaQuery.of(context).size.width * 0.3,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          selectedDepartment[index],
                                                          style: TextStyle(color: Colors.grey[500], fontSize: 13.0, fontWeight: FontWeight.w700)
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 3.0,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          selectedObject[index],
                                                          style: TextStyle(color: AbubaPallate.greenabuba, fontSize: 13.0, fontWeight: FontWeight.w700)
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 3.0,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          selectedTanggal[index].toString().substring(8, 10) + '/' + selectedTanggal[index].toString().substring(5, 7) + '/' + selectedTanggal[index].toString().substring(0, 4),
                                                          style: TextStyle(color: Colors.grey[500], fontSize: 13.0, fontWeight: FontWeight.w700)
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 20.0,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'Auditee',
                                                          style: TextStyle(color: AbubaPallate.greenabuba, fontSize: 13.0, fontWeight: FontWeight.w700)
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 3.0,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          auditeeName[index] == null ? '-' : auditeeName[index],
                                                          style: TextStyle(color: Colors.grey[500], fontSize: 13.0, fontWeight: FontWeight.w700)
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 20.0,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'Lead Auditor',
                                                          style: TextStyle(color: AbubaPallate.greenabuba, fontSize: 13.0, fontWeight: FontWeight.w700)
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 3.0,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          leadAuditorName[index] == null ? '-' : leadAuditorName[index],
                                                          style: TextStyle(color: Colors.grey[500], fontSize: 13.0, fontWeight: FontWeight.w700)
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width * 0.55,
                                              child: Column(
                                                children: List.generate(subArea.length, (index2) {
                                                  return DropdownButtonFormField<String>(
                                                    decoration: InputDecoration(
                                                      labelText: '${subArea[index2]} - Auditor',
                                                      labelStyle: TextStyle(color: Colors.grey[500], fontSize: 13.0, fontWeight: FontWeight.w700),
                                                    ),
                                                    validator: (value) {
                                                      if (value == null) {
                                                        return 'Please select auditor';
                                                      } else {
                                                        return null;
                                                      }
                                                    },
                                                    value: auditorFinal[index].length == 0 ? mySelection : auditorFinal[index][index2],
                                                    onChanged: (String value) {
                                                      setState(() {
                                                        auditorFinal[index].removeAt(index2);
                                                        auditorFinal[index].insert(index2, value);
                                                      });
                                                      print(index);
                                                      print(index2);
                                                      print(auditorFinal);

                                                      //sini baru
                                                    },
                                                    items: List.generate(auditorNameForSave[index].length, (index3) {
                                                      return DropdownMenuItem(
                                                        value: auditorNameIDForSave[index][index3].toString(),
                                                        child: Container(
                                                          padding: EdgeInsets.all(10.0),
                                                          child: RichText(
                                                            overflow: TextOverflow.visible,
                                                            text: TextSpan(
                                                              text: auditorNameForSave[index][index3].toString(),
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
                                                }).toList()
                                              )
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ),
                                  Divider(
                                    color: Colors.green,
                                    height: 15.0,
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0, right: 20.0),
                                child: isProcess
                                  ? SizedBox(
                                      height: 25.0,
                                      width: 25.0,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 3.0,
                                      ),
                                    )
                                  : ButtonTheme(
                                      minWidth: 50.0,
                                      height: 30.0,
                                      child: OutlineButton(
                                        child: Text(
                                          'INVITE',
                                          style: TextStyle(
                                              fontSize: 13.0, color: Colors.green),
                                        ),
                                        borderSide:
                                            BorderSide(color: Colors.green, width: 1.0),
                                        highlightedBorderColor: Colors.green,
                                        onPressed: () {
                                          var bantuStatusInvite = [];
                                          for (int q = 0; q < auditorFinal.length; q++) {
                                            if (auditorFinal[q].contains(null) || auditorFinal[q].isEmpty || auditorFinal[q].length == 0) {
                                              setState(() {
                                                bantuStatusInvite.add('no');
                                              });
                                            } else {
                                              setState(() {
                                                bantuStatusInvite.add('yes');
                                              });
                                            }
                                          }

                                          if (bantuStatusInvite.contains('no') || auditeeNameID.contains(null) || leadAuditorNameID.contains(null)) {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text(
                                                    'Lengkapi Data',
                                                    style: TextStyle(
                                                      fontSize: 14.0
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    FlatButton(
                                                      child: Text(
                                                        'OK'
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                    )
                                                  ],
                                                );
                                              }
                                            );
                                          } else {
                                            // invite function
                                            setState(() {
                                              isProcess = true;
                                            });

                                            List<DateTime> checkIn = [];
                                            List<DateTime> checkout = [];
                                            List<String> auditorConfirm = [];

                                            for(int i = 0; i < subArea.length; i++) {
                                              checkIn.add(null);
                                              checkout.add(null);
                                              auditorConfirm.add(null);
                                            }

                                            for (int q = 0; q < selectedObject.length; q++) {
                                              DocumentReference docReference = Firestore.instance.collection('audit_internal').document();
                                              docReference.setData({
                                                'userCreated': widget.idUser,
                                                'dateCreated': DateTime.now(),
                                                'dateAudit':selectedTanggal[q],
                                                'periodStart': dateStart,
                                                'periodEnd': dateEnd,
                                                'status': 'OPEN',
                                                'pesertaHadir': [],
                                                'pesertaStatus': [],
                                                'checkInPeserta': checkIn,
                                                'checkOutPeserta': checkout,
                                                'auditStart': null,
                                                'auditEnd': null,
                                                'subArea': subArea,
                                                'subAreaAuditor': auditorFinal[q],
                                                'auditorConfirm': auditorFinal[q],
                                                'leadAuditorConfirm': int.tryParse(leadAuditorNameID[q]),
                                                'auditeeConfirm': int.tryParse(auditeeNameID[q]),
                                                'leadAuditorCheckIn': null,
                                                'leadAuditorCheckOut': null,
                                                'leadAuditorStatus': null,
                                                'auditeeCheckIn': null,
                                                'auditeeCheckOut': null,
                                                'auditeeStatus': null,
                                                'object': selectedObjectID[q],
                                                'leadAuditor': int.tryParse(leadAuditorNameID[q]),
                                                'auditee': int.tryParse(auditeeNameID[q]),
                                                'department': selectedDepartmentID[q],
                                                'FSSubBab': [],
                                                'FSAuditor': [],
                                                'FSAuditorID': [],
                                                'FSCritical': [],
                                                'FSArea': [],
                                                'FSProblem': [],
                                                'FSDivisi': selectedObject[q],
                                                'FSDepartment': null,
                                                'FSDepartmentID': null,
                                                'FSCategory': null,
                                                'FSCarNo': [],
                                                'FSRekomendasi': [],
                                                'iaNo': maxidIA,
                                              }).then((doc) {
                                                print('success');

                                                DocumentReference documentReference =Firestore.instance.collection('dumper_IA').document(indexIA);

                                                documentReference.updateData({
                                                  'maxid_ia':maxidIA
                                                }).then((doc2) {
                                                  print('success');

                                                  setState(() {
                                                    isProcess = false;
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
                                                                'Internal Audit Data Saved',
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
                                                                    Navigator.pushReplacement(context,
                                                                      MaterialPageRoute(
                                                                        builder: (_) => MenuAudit(departmentUser: widget.departmentUser, namaUser: widget.namaUser, idUser: widget.idUser)
                                                                      )
                                                                    );
                                                                  },
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  );
                                                }).catchError((error2) {
                                                  print(error2);
                                                });
                                              }).catchError((error) {
                                                print(error);
                                              });
                                            }
                                          }
                                        },
                                      ),
                                    ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  );
            },
          )
        ),
      ),
    );
  }
}
