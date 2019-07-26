import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:search_widget/search_widget.dart';

class LeaderBoard {
  final String name;
  final int id;

  LeaderBoard(this.name, this.id);
}

class FormCreateNew extends StatefulWidget {
  FormCreateNew({this.idUser, this.namaUser, this.departmentUser, this.status});

  final int idUser;
  final String namaUser;
  final String departmentUser;
  final String status;

  @override
  _FormCreateNewState createState() => _FormCreateNewState();
}

class _FormCreateNewState extends State<FormCreateNew> with TickerProviderStateMixin {
  TabController _tabController;
  AnimationController animationController;
  bool _isProccess = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  final List<Tab> internalAuditTabs = <Tab>[
    new Tab(child: Text('Problem', style: TextStyle(color: Colors.grey[400]))),
  ];

  var maxidCorrectiveAction;
  var indexCorrectiveAction;

  List<dynamic> namaUser = [];
  List<dynamic> idUser = [];
  List<dynamic> departmentUser = [];
  List<dynamic> departmentListID = [];
  List<dynamic> departmentListName = [];
  List<dynamic> departmentListKode = [];
  String departmentBantu;

  List<LeaderBoard> listDepartment = <LeaderBoard>[];
  List<LeaderBoard> listDivisi = <LeaderBoard>[];
  List<LeaderBoard> listArea = <LeaderBoard>[];
  List<LeaderBoard> listUserPelaksana = <LeaderBoard>[];

  String selectedDepartment;
  String selectedDivisi;
  String selectedArea;
  int selectedUserPelaksana;

  int departmentUserCreated;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(from: animationController.value == 0.0 ? 1.0 : animationController.value);

    _tabController = TabController(vsync: this, length: internalAuditTabs.length);
    Firestore.instance.collection('dumper_correctiveAction').snapshots().listen((data) {
      setState(() {
        maxidCorrectiveAction = data.documents[0].data['maxid_correctiveAction'] + 1;
        indexCorrectiveAction = data.documents[0].documentID;
      });
    });

    CollectionReference reference = Firestore.instance.collection('user');
    reference.orderBy('department', descending: false).snapshots().listen((data) {
      data.documentChanges.forEach((change) {
        setState(() {
          if (change.document.data['id'] != widget.idUser) {
            namaUser.add(change.document.data['nama']);
            idUser.add(change.document.data['id']);
            departmentUser.add(change.document.data['departmentID']);

            listUserPelaksana.add(LeaderBoard(change.document.data['department'] + ' - ' + change.document.data['nama'], change.document.data['id']));
          }
        });
      });
    });

    CollectionReference reference2 = Firestore.instance.collection('department');
    reference2.orderBy('department', descending: false).snapshots().listen((data2) {
      data2.documentChanges.forEach((change2) {
        setState(() {
          departmentListID.add(change2.document.data['id']);
          departmentListName.add(change2.document.data['name']);
          departmentListKode.add(change2.document.data['department']);

          listDepartment.add(LeaderBoard(change2.document.data['name'] + ' (' + change2.document.data['department'] + ')', 0));
        });
      });
    });

    CollectionReference reference3 = Firestore.instance.collection('divisi');
    reference3.orderBy('divisi', descending: false).snapshots().listen((data2) {
      data2.documentChanges.forEach((change3) {
        setState(() {
          listDivisi.add(LeaderBoard(change3.document.data['divisi'], 0));
        });
      });
    });

    CollectionReference reference4 = Firestore.instance.collection('area');
    reference4.orderBy('area', descending: false).snapshots().listen((data2) {
      data2.documentChanges.forEach((change4) {
        setState(() {
          listArea.add(LeaderBoard(change4.document.data['area'], 0));
        });
      });
    });

    Firestore.instance.collection('user').where('id', isEqualTo: widget.idUser).snapshots().listen((data10) {
      setState(() {
        departmentUserCreated = data10.documents[0].data['departmentID'];
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime dateStart;
  DateTime dateEnd;
  DateTime dateSchedule;
  String category;
  TextEditingController problem =TextEditingController();
  DateTime when;
  String departmentWhere;
  String divisiWhere;
  String areaWhere;
  String howSevere;
  TextEditingController remarksProblem =TextEditingController();
  String userDituju;
  int departmentDituju;
  String status = 'OPEN';

  Color _colorLowSe = Colors.grey;
  Color _colorMedSe = Colors.grey;
  Color _colorHighSe = Colors.grey;

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
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Form(
            autovalidate: _autoValidate,
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 15.0, right: 15.0, left: 15.0, top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Corrective Action',
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
                          'Create',
                          style:
                          TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedBuilder(
                  animation: animationController,
                  builder: (_, Widget child) {
                    return animationController.isAnimating
                      ? Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Container(
                          width: MediaQuery.of(context).size.width,
        //                  color: AbubaPallate.greenabuba,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.all(15.0),
                                  decoration: BoxDecoration(border: Border.all(width: 1.0, color: Colors.white), borderRadius: BorderRadius.circular(2.0), color: Colors.white  ),
                                  child: Text(
                                    'Category Perbaikan : Non Internal Audit',
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.only(left: 5.0, bottom: 5.0, right: 5.0),
                                  decoration: BoxDecoration(border: Border.all(width: 1.0, color: Colors.white), borderRadius: BorderRadius.circular(2.0), color: Colors.white  ),
                                  child: TextFormField(
                                    maxLines: 3,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                      labelText: 'Masalah yang terjadi',
                                      labelStyle: TextStyle(fontSize: 12.0),
                                      border: InputBorder.none
                                    ),
                                    controller: problem,
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
                                    textCapitalization: TextCapitalization.sentences,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.only(left: 5.0, bottom: 5.0, right: 5.0),
                                  decoration: BoxDecoration(border: Border.all(width: 1.0, color: Colors.white), borderRadius: BorderRadius.circular(2.0), color: Colors.white  ),
                                  child: DateTimePickerFormField(
                                    format: dateFormat,
                                    onChanged: (dt) => setState(() => when = dt),
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
                                    style: TextStyle(fontSize: 14.0, color: Colors.black),
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelStyle: TextStyle(fontSize: 12.0),
                                        labelText: 'When'),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                child: SearchWidget<LeaderBoard>(
                                  dataList: listDepartment,
                                  hideSearchBoxWhenItemSelected: true,
                                  listContainerHeight: MediaQuery.of(context).size.height / 4,
                                  queryBuilder: (String query, List<LeaderBoard> list) {
                                    return list.where((LeaderBoard item) => item.name.toLowerCase().contains(query.toLowerCase())).toList();
                                  },
                                  popupListItemBuilder: (LeaderBoard item) {
                                    return Container(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        item.name,
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                    );
                                  },
                                  selectedItemBuilder: (LeaderBoard selectedItem, VoidCallback deleteSelectedItem) {
                                    var bantu = selectedItem.name.split('(');
                                    var bantu2 = bantu[1].toString().split(')');
                                    selectedDepartment = bantu2[0];

                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 2.0,
                                        horizontal: 4.0,
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 16,
                                                right: 16,
                                                top: 8,
                                                bottom: 8,
                                              ),
                                              child: Text(
                                                selectedItem.name,
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.delete_outline, size: 22),
                                            color: Colors.grey[700],
                                            onPressed: deleteSelectedItem,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  // widget customization
                                  noItemsFoundWidget: Container(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Icon(
                                          Icons.folder_open,
                                          size: 24,
                                          color: Colors.grey[900].withOpacity(0.7),
                                        ),
                                        SizedBox(width: 10.0),
                                        Text(
                                          "No Items Found",
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.grey[900].withOpacity(0.7),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  textFieldBuilder: (TextEditingController controllerCategory, FocusNode focusNodeCategory) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                      child: TextField(
                                        controller: controllerCategory,
                                        focusNode: focusNodeCategory,
                                        style: new TextStyle(fontSize: 16, color: Colors.grey[600]),
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Color(0x4437474F)),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                          ),
                                          border: InputBorder.none,
                                          hintText: "Department",
                                          hintStyle: TextStyle(
                                            fontSize: 14.0
                                          ),
                                          contentPadding: EdgeInsets.only(
                                            left: 16,
                                            right: 20,
                                            top: 14,
                                            bottom: 14,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                child: SearchWidget<LeaderBoard>(
                                  dataList: listDivisi,
                                  hideSearchBoxWhenItemSelected: true,
                                  listContainerHeight: MediaQuery.of(context).size.height / 4,
                                  queryBuilder: (String query, List<LeaderBoard> list) {
                                    return list.where((LeaderBoard item) => item.name.toLowerCase().contains(query.toLowerCase())).toList();
                                  },
                                  popupListItemBuilder: (LeaderBoard item) {
                                    return Container(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        item.name,
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                    );
                                  },
                                  selectedItemBuilder: (LeaderBoard selectedItem, VoidCallback deleteSelectedItem) {
                                    selectedDivisi = selectedItem.name;

                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 2.0,
                                        horizontal: 4.0,
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 16,
                                                right: 16,
                                                top: 8,
                                                bottom: 8,
                                              ),
                                              child: Text(
                                                selectedItem.name,
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.delete_outline, size: 22),
                                            color: Colors.grey[700],
                                            onPressed: deleteSelectedItem,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  // widget customization
                                  noItemsFoundWidget: Container(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Icon(
                                          Icons.folder_open,
                                          size: 24,
                                          color: Colors.grey[900].withOpacity(0.7),
                                        ),
                                        SizedBox(width: 10.0),
                                        Text(
                                          "No Items Found",
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.grey[900].withOpacity(0.7),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  textFieldBuilder: (TextEditingController controllerCategory, FocusNode focusNodeCategory) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                      child: TextField(
                                        controller: controllerCategory,
                                        focusNode: focusNodeCategory,
                                        style: new TextStyle(fontSize: 16, color: Colors.grey[600]),
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Color(0x4437474F)),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                          ),
                                          border: InputBorder.none,
                                          hintText: "Divisi",
                                          hintStyle: TextStyle(
                                            fontSize: 14.0
                                          ),
                                          contentPadding: EdgeInsets.only(
                                            left: 16,
                                            right: 20,
                                            top: 14,
                                            bottom: 14,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                child: SearchWidget<LeaderBoard>(
                                  dataList: listArea,
                                  hideSearchBoxWhenItemSelected: true,
                                  listContainerHeight: MediaQuery.of(context).size.height / 4,
                                  queryBuilder: (String query, List<LeaderBoard> list) {
                                    return list.where((LeaderBoard item) => item.name.toLowerCase().contains(query.toLowerCase())).toList();
                                  },
                                  popupListItemBuilder: (LeaderBoard item) {
                                    return Container(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        item.name,
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                    );
                                  },
                                  selectedItemBuilder: (LeaderBoard selectedItem, VoidCallback deleteSelectedItem) {
                                    selectedArea = selectedItem.name;

                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 2.0,
                                        horizontal: 4.0,
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 16,
                                                right: 16,
                                                top: 8,
                                                bottom: 8,
                                              ),
                                              child: Text(
                                                selectedItem.name,
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.delete_outline, size: 22),
                                            color: Colors.grey[700],
                                            onPressed: deleteSelectedItem,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  // widget customization
                                  noItemsFoundWidget: Container(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Icon(
                                          Icons.folder_open,
                                          size: 24,
                                          color: Colors.grey[900].withOpacity(0.7),
                                        ),
                                        SizedBox(width: 10.0),
                                        Text(
                                          "No Items Found",
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.grey[900].withOpacity(0.7),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  textFieldBuilder: (TextEditingController controllerCategory, FocusNode focusNodeCategory) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                      child: TextField(
                                        controller: controllerCategory,
                                        focusNode: focusNodeCategory,
                                        style: new TextStyle(fontSize: 16, color: Colors.grey[600]),
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Color(0x4437474F)),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                          ),
                                          border: InputBorder.none,
                                          hintText: "Area",
                                          hintStyle: TextStyle(
                                            fontSize: 14.0
                                          ),
                                          contentPadding: EdgeInsets.only(
                                            left: 16,
                                            right: 20,
                                            top: 14,
                                            bottom: 14,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        new Text(
                                          'SEBERAPA PARAH MASALAH INI?',
                                          style: new TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w700,
                                            color: Colors.black
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 5.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          ButtonTheme(
                                            height: 30.0,
                                            child: RaisedButton(
                                              child: Text(
                                                'LOW',
                                                style: TextStyle(
                                                    color: _colorLowSe == Colors.grey ? Colors.green : Colors.white),
                                              ),
                                              /*borderSide: BorderSide(
                                                  color: _colorLowSe == Colors.grey ? Colors.white: Colors.green,
                                                  width: 1.0),*/
                                              color: _colorLowSe == Colors.grey ? Colors.white : AbubaPallate.green,
                                              onPressed: () {
                                                setState(() {
                                                  _colorLowSe = Colors.green;
                                                  _colorMedSe = Colors.grey;
                                                  _colorHighSe = Colors.grey;
                                                  howSevere = 'Low';
                                                });
                                              },
                                            ),
                                          ),
                                          ButtonTheme(
                                            height: 30.0,
                                            child: RaisedButton(
                                              child: Text(
                                                'MEDIUM',
                                                style: TextStyle(
                                                    color: _colorMedSe == Colors.grey ? Colors.orangeAccent : Colors.white),
                                              ),
                                              color: _colorMedSe == Colors.grey ? Colors.white : Colors.orangeAccent,
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
                                            child: RaisedButton(
                                              child: Text(
                                                'HIGH',
                                                style: TextStyle(
                                                    color: _colorHighSe == Colors.grey ? Colors.redAccent : Colors.white),
                                              ),
                                              color: _colorHighSe == Colors.grey ? Colors.white : Colors.redAccent,
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
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                                child: SearchWidget<LeaderBoard>(
                                  dataList: listUserPelaksana,
                                  hideSearchBoxWhenItemSelected: true,
                                  listContainerHeight: MediaQuery.of(context).size.height / 4,
                                  queryBuilder: (String query, List<LeaderBoard> list) {
                                    return list.where((LeaderBoard item) => item.name.toLowerCase().contains(query.toLowerCase())).toList();
                                  },
                                  popupListItemBuilder: (LeaderBoard item) {
                                    return Container(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        item.name,
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                    );
                                  },
                                  selectedItemBuilder: (LeaderBoard selectedItem, VoidCallback deleteSelectedItem) {
                                    selectedUserPelaksana = selectedItem.id;

                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 2.0,
                                        horizontal: 4.0,
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 16,
                                                right: 16,
                                                top: 8,
                                                bottom: 8,
                                              ),
                                              child: Text(
                                                selectedItem.name,
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.delete_outline, size: 22),
                                            color: Colors.grey[700],
                                            onPressed: deleteSelectedItem,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  // widget customization
                                  noItemsFoundWidget: Container(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Icon(
                                          Icons.folder_open,
                                          size: 24,
                                          color: Colors.grey[900].withOpacity(0.7),
                                        ),
                                        SizedBox(width: 10.0),
                                        Text(
                                          "No Items Found",
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.grey[900].withOpacity(0.7),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  textFieldBuilder: (TextEditingController controllerCategory2, FocusNode focusNodeCategory2) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                      child: TextField(
                                        controller: controllerCategory2,
                                        focusNode: focusNodeCategory2,
                                        style: new TextStyle(fontSize: 16, color: Colors.grey[600]),
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Color(0x4437474F)),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                          ),
                                          border: InputBorder.none,
                                          hintText: "User Pelaksana",
                                          hintStyle: TextStyle(
                                            fontSize: 14.0
                                          ),
                                          contentPadding: EdgeInsets.only(
                                            left: 16,
                                            right: 20,
                                            top: 14,
                                            bottom: 14,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.only(left: 5.0, bottom: 5.0, right: 5.0),
                                  decoration: BoxDecoration(border: Border.all(width: 1.0, color: Colors.white), borderRadius: BorderRadius.circular(2.0), color: Colors.white  ),
                                  child: TextField(
                                    maxLines: 3,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                      labelText: 'Catatan - opsional',
                                      labelStyle: TextStyle(fontSize: 12.0),
                                      border: InputBorder.none
                                    ),
                                    maxLength: 250,
                                    controller: remarksProblem,
                                    textCapitalization: TextCapitalization.sentences,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0, right: 15.0, bottom: 10.0),
                                    child: _isProccess
                                        ? Container(
                                            child: Center(
                                              child: CircularProgressIndicator(),
                                            ),
                                          )
                                        : ButtonTheme(
                                            minWidth: 100.0,
                                            height: 40.0,
                                            child: RaisedButton(
                                              color: Colors.green,
                                              child: Text(
                                                'SAVE',
                                                style: TextStyle(
                                                    fontSize: 13.0, color: Colors.white),
                                              ),
                                              onPressed: () {
                                                if (selectedDepartment == null ||selectedDivisi == null ||selectedArea == null ||selectedUserPelaksana == null) {
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
                                                                  'ALERT!',
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
                                                                'Data belum lengkap',
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
                                                  // Scaffold.of(context).showSnackBar(
                                                  //   SnackBar(
                                                  //     content: Text('Data Belum Lengkap'),
                                                  //     duration: Duration(seconds: 2),
                                                  //     action: SnackBarAction(
                                                  //       label: 'OK',
                                                  //       onPressed: () {
                                                  //         Scaffold.of(context).removeCurrentSnackBar();
                                                  //       },
                                                  //     ),
                                                  //   )
                                                  // );
                                                } else {
                                                  setState(() {
                                                    _isProccess = true;
                                                  });

                                                  DocumentReference docReference = Firestore.instance.collection('correctiveAction').document();
                                                  DocumentReference documentReference = Firestore.instance.collection('dumper_correctiveAction').document(indexCorrectiveAction);

                                                  Firestore.instance.collection('user').where('id', isEqualTo: int.tryParse(selectedUserPelaksana.toString())).snapshots().listen((dataGet) {
                                                    docReference.setData({
                                                      'userCreated': widget.idUser,
                                                      'dateCreated': DateTime.now(),
                                                      'departmentCreated': int.tryParse(departmentUserCreated.toString()),
                                                      'carNo': maxidCorrectiveAction,
                                                      'category': 2,
                                                      'problem':problem.text,
                                                      'when': when,
                                                      'departmentWhere': selectedDepartment,
                                                      'divisiWhere': selectedDivisi,
                                                      'areaWhere': selectedArea,
                                                      'howSevere': howSevere,
                                                      'remarksProblem':remarksProblem.text,
                                                      'userDituju': int.tryParse(selectedUserPelaksana.toString()),
                                                      'departmentDituju':dataGet.documents[0].data['departmentID'],
                                                      'status':status
                                                    }).then((doc) {
                                                      documentReference.updateData({
                                                        'maxid_correctiveAction':maxidCorrectiveAction
                                                      }).then((doc2) {
                                                        print('success 2');
                                                        
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
                                                                      'Corrective Action No. CAR-${maxidCorrectiveAction.toString().padLeft(4, '0')}',
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
                                                      }).catchError((error2) {
                                                        print(error2);
                                                      });
                                                    }).catchError((error) {
                                                      print(error);
                                                    });
                                                  });
                                                }
                                              },
                                            ),
                                          )
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
