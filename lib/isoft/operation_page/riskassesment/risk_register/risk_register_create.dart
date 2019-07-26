import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:search_widget/search_widget.dart';
import '../beranda_risk_register.dart';

class LeaderBoard {
  final String name;
  final int id;

  LeaderBoard(this.name, this.id);
}

class RiskRegisterCreate extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  RiskRegisterCreate({
    this.departmentUser,
    this.idUser,
    this.namaUser,
  });

  _RiskRegisterCreateState createState() => _RiskRegisterCreateState();
}

class _RiskRegisterCreateState extends State<RiskRegisterCreate>
    with TickerProviderStateMixin {
  AnimationController animationController;
  ScrollController _scrollController;
  bool _isOnTop = true;

  List<String> sumberName = [];
  String _selectionSumber2;
  String _selectionSumber;

  List<String> dampakName = [];
  List<String> deskripsiName = [];
  List<String> pemantauanName = [];
  List<String> jenisName = [];

  String _selectionJenis;
  String _selectionKategori;
  String _selectionSOP;
  String _selectionPengendalian;
  String _selectionDampak;

  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime timenow = DateTime.now();
  DateTime tanggal;

  var dumperID;
  int maxid_riskAssesment;
  var index_riskAssesment;

  bool _isProccess = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  String _selectionPIC;
  String _selectionVerifikator;

  TextEditingController sumberController = TextEditingController();
  TextEditingController jenisController = TextEditingController();
  TextEditingController dampakController = TextEditingController();
  TextEditingController pengendalianController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();
  TextEditingController pemantauanController = TextEditingController();

  List<String> tampungJenis = [];
  List<String> tampungDampak = [];
  List<String> tampungPengendalian = [];
  List<String> tampungDeskripsi = [];
  List<String> tampungPemantauan = [];
  List<String> tampungSumber = [];
  List<String> tampungRisk = [];
  List<String> tampungSeverity = [];
  List<String> tampungLikelihood = [];
  List<String> tampungPIC = [];
  List<String> tampungVerifikator = [];

  Color _colorLowSe = Colors.grey;
  Color _colorMedSe = Colors.grey;
  Color _colorHighSe = Colors.grey;

  Color _colorLowLi = Colors.grey;
  Color _colorMedLi = Colors.grey;
  Color _colorHighLi = Colors.grey;

  String severity = '';
  String likelihood = '';
  int bantuSeverity = 0;
  int bantuLikelihood = 0;

  String _risk = '';
  Color _colorRisk = Colors.grey;

  List<LeaderBoard> listCategory = <LeaderBoard>[];
  List<LeaderBoard> listSOP = <LeaderBoard>[];
  List<LeaderBoard> listPengendalian = <LeaderBoard>[];
  List<LeaderBoard> listPIC = <LeaderBoard>[];
  List<LeaderBoard> listVerifikator = <LeaderBoard>[];
  List<LeaderBoard> listJRCategory = <LeaderBoard>[];
  List<LeaderBoard> listSRCategory = <LeaderBoard>[];
  List<LeaderBoard> listDRCategory = <LeaderBoard>[];

  String selectedCategory;
  String selectedSOP;
  String selectedPengendalian;
  String selectedPIC;
  String selectedVerifikator;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    Firestore.instance.collection('dumper_maxid').snapshots().listen((data) {
      setState(() {
        maxid_riskAssesment = data.documents[0].data['maxid_riskAssesment'];
        dumperID = data.documents[0].data['maxid_riskAssesment'] + 1;
        index_riskAssesment = data.documents[0].documentID;
      });
    });

    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(
        from:
        animationController.value == 0.0 ? 1.0 : animationController.value);
    
    CollectionReference reference3 = Firestore.instance.collection('kategoriRisk');
    reference3.orderBy('kategori', descending: false).snapshots().listen((data2) {
      data2.documentChanges.forEach((change3) {
        setState(() {
          listCategory.add(LeaderBoard(change3.document.data['kategori'], 0));
        });
      });
    });

    CollectionReference reference4 = Firestore.instance.collection('sopRisk');
    reference4.orderBy('sop', descending: false).snapshots().listen((data2) {
      data2.documentChanges.forEach((change4) {
        setState(() {
          listSOP.add(LeaderBoard(change4.document.data['sop'], 0));
        });
      });
    });

    CollectionReference reference5 = Firestore.instance.collection('pengendalianRisk');
    reference5.orderBy('pengendalian', descending: false).snapshots().listen((data2) {
      data2.documentChanges.forEach((change5) {
        setState(() {
          listPengendalian.add(LeaderBoard(change5.document.data['pengendalian'], 0));
        });
      });
    });

    CollectionReference reference6 = Firestore.instance.collection('user');
    reference6.orderBy('nama', descending: false).snapshots().listen((data2) {
      data2.documentChanges.forEach((change6) {
        setState(() {
          listPIC.add(LeaderBoard(change6.document.data['nama'], 0));
          listVerifikator.add(LeaderBoard(change6.document.data['nama'], 0));
        });
      });
    });

    CollectionReference reference7 = Firestore.instance.collection('jenisRisk');
    reference7.orderBy('jenis', descending: false).snapshots().listen((data2) {
      data2.documentChanges.forEach((change7) {
        setState(() {
          listJRCategory.add(LeaderBoard(change7.document.data['jenis'], 0));
        });
      });
    });

    CollectionReference reference8 = Firestore.instance.collection('sumberRisk');
    reference8.orderBy('sumber', descending: false).snapshots().listen((data2) {
      data2.documentChanges.forEach((change8) {
        setState(() {
          listSRCategory.add(LeaderBoard(change8.document.data['sumber'], 0));
        });
      });
    });

    CollectionReference reference9 = Firestore.instance.collection('dampakRisk');
    reference9.orderBy('dampak', descending: false).snapshots().listen((data2) {
      data2.documentChanges.forEach((change9) {
        setState(() {
          listDRCategory.add(LeaderBoard(change9.document.data['dampak'], 0));
        });
      });
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  final itemSize = 100.0;

  _moveUp() {
    _scrollController.animateTo(_scrollController.position.minScrollExtent,
        curve: Curves.linear, duration: Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

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
            child: Center(
              child: _buildFormRisk(width, context),
            ),
          )
      ),
    );
  }

  Widget _buildFormRisk(double width, BuildContext context) {
    return Scrollbar(
      child: AnimatedBuilder(animation: animationController, builder: (_, Widget child) {
        return animationController.isAnimating ? Container (
          child: Center(
            child: CircularProgressIndicator(),
          ),
        )
            : ListView(
          controller: _scrollController,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Risk Assesment',
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
                      'Create New',
                      style: TextStyle(
                          color: AbubaPallate.greenabuba, fontSize: 12.0),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              /*padding: EdgeInsets.symmetric(horizontal: 15.0),*/
              color: Colors.white,
              child: Form(
                autovalidate: _autoValidate,
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SearchWidget<LeaderBoard>(
                      dataList: listCategory,
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
                        selectedCategory = selectedItem.name;
                        
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
                              hintText: "Category",
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
                    SearchWidget<LeaderBoard>(
                      dataList: listSOP,
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
                        selectedSOP = selectedItem.name;
                        
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
                              hintText: "SOP",
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
                    SearchWidget<LeaderBoard>(
                      dataList: listJRCategory,
                      hideSearchBoxWhenItemSelected: false,
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
                        if (jenisName.contains(selectedItem.name)) {

                        } else {
                          jenisName.add(selectedItem.name);
                        }
                        deleteSelectedItem();
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
                              hintText: "Jenis Resiko - Category",
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
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: jenisName.length == 0 ? 0.0 : 10.0, bottom: jenisName.length == 0 ? 0.0 : 0.0),
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        runAlignment: WrapAlignment.start,
                        direction: Axis.horizontal,
                        children: jenisName.length == 0
                            ? [Container()]
                            : jenisName.map((String name) => Chip(
                          label: Text(name),
                          deleteIcon: jenisName[jenisName.indexWhere((result) => result.startsWith(name))] == jenisName ? Icon(Icons.close, color: Colors.transparent,) : null,
                          onDeleted: () {
                            if (jenisName[jenisName.indexWhere((result) => result.startsWith(name))] == jenisName) {

                            } else {
                              setState(() {
                                jenisName.removeAt(jenisName.indexOf(name));
                                jenisName.remove(name);
                              });
                            }
                          },
                        )).toList(),
                      ),
                    ),
                    ListTile(
                      title: Container(
                        width: 270.0,
                        child: TextFormField(
                          validator: (value) {
                            if (value == '') {
                              return 'Form can\'t be null';
                            } else {
                              return null;
                            }
                          },
                          controller: jenisController,
                          maxLines: 3,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Jenis Resiko - Deskripsi',
                              labelStyle: TextStyle(fontSize: 14.0, color: jenisController.text == '' ? Colors.grey : AbubaPallate.greenabuba,),
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: jenisController.text == '' ? Colors.grey : AbubaPallate.greenabuba,))
                          ),
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              color: Colors.black87,
                              fontSize: 14.0),
                          onSaved: null,
                        ),
                      )
                    ),
                    SearchWidget<LeaderBoard>(
                      dataList: listSRCategory,
                      hideSearchBoxWhenItemSelected: false,
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
                        if (sumberName.contains(selectedItem.name)) {

                        } else {
                          sumberName.add(selectedItem.name);
                        }
                        deleteSelectedItem();
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
                              hintText: "Sumber Resiko - Category",
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
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: sumberName.length == 0 ? 0.0 : 10.0, bottom: sumberName.length == 0 ? 0.0 : 0.0),
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        runAlignment: WrapAlignment.start,
                        direction: Axis.horizontal,
                        children: sumberName.length == 0
                            ? [Container()]
                            : sumberName.map((String name) => Chip(
                          label: Text(name),
                          deleteIcon: sumberName[sumberName.indexWhere((result) => result.startsWith(name))] == sumberName ? Icon(Icons.close, color: Colors.transparent,) : null,
                          onDeleted: () {
                            if (sumberName[sumberName.indexWhere((result) => result.startsWith(name))] == sumberName) {

                            } else {
                              setState(() {
                                sumberName.removeAt(sumberName.indexOf(name));
                                sumberName.remove(name);
                              });
                            }
                          },
                        )).toList(),
                      ),
                    ),
                    ListTile(
                      title: Container(
                        width: 270.0,
                        child: TextFormField(
                          validator: (value) {
                            if (value == '') {
                              return 'Form can\'t be null';
                            } else {
                              return null;
                            }
                          },
                          controller: sumberController,
                          maxLines: 3,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Sumber Resiko - Deskripsi',
                              labelStyle: TextStyle(fontSize: 14.0, color: sumberController.text == '' ? Colors.grey : AbubaPallate.greenabuba,),
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: sumberController.text == '' ? Colors.grey : AbubaPallate.greenabuba,))
                          ),
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              color: Colors.black87,
                              fontSize: 14.0),
                          onSaved: null,
                        ),
                      ),
                      trailing: Container(
                          width: 30.0
                      ),
                    ),
                    SearchWidget<LeaderBoard>(
                      dataList: listDRCategory,
                      hideSearchBoxWhenItemSelected: false,
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
                        if (dampakName.contains(selectedItem.name)) {

                        } else {
                          dampakName.add(selectedItem.name);
                        }
                        deleteSelectedItem();
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
                              hintText: "Dampak Resiko - Category",
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
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: dampakName.length == 0 ? 0.0 : 10.0, bottom: dampakName.length == 0 ? 0.0 : 0.0),
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        runAlignment: WrapAlignment.start,
                        direction: Axis.horizontal,
                        children: dampakName.length == 0
                            ? [Container()]
                            : dampakName.map((String name) => Chip(
                          label: Text(name),
                          deleteIcon: dampakName[dampakName.indexWhere((result) => result.startsWith(name))] == dampakName ? Icon(Icons.close, color: Colors.transparent,) : null,
                          onDeleted: () {
                            if (dampakName[dampakName.indexWhere((result) => result.startsWith(name))] == dampakName) {

                            } else {
                              setState(() {
                                dampakName.removeAt(dampakName.indexOf(name));
                                dampakName.remove(name);
                              });
                            }
                          },
                        )).toList(),
                      ),
                    ),
                    ListTile(
                      title: Container(
                        width: 270.0,
                        child: TextFormField(
                          validator: (value) {
                            if (value == '') {
                              return 'Form can\'t be null';
                            } else {
                              return null;
                            }
                          },
                          controller: dampakController,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Dampak Resiko - Deskripsi',
                              labelStyle: TextStyle(fontSize: 14.0, color: dampakController.text == '' ? Colors.grey : AbubaPallate.greenabuba,),
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: dampakController.text == '' ? Colors.grey : AbubaPallate.greenabuba,))
                          ),
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              color: Colors.black87,
                              fontSize: 14.0),
                          onSaved: null,
                        ),
                      ),
                    ),
                    /*Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        Container(
                          width: 30.0,
                          child: IconButton(
                            icon: Icon(Icons.add, color: AbubaPallate.greenabuba),
                            onPressed: () {
                              setState(() {
                                if (dampakName.contains(dampakController.text)) {

                                } else {
                                  dampakName.add(dampakController.text);
                                }
                                dampakController.clear();
                              });
                            },
                          ),
                        )
                      ],
                    ),*/
                    /*Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 0.0, right: 0.0, top: dampakName.length == 0 ? 0.0 : 10.0, bottom: dampakName.length == 0 ? 0.0 : 0.0),
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        runAlignment: WrapAlignment.start,
                        direction: Axis.horizontal,
                        children: dampakName.length == 0
                            ? [Container()]
                            : dampakName.map((String name) => Chip(
                          label: Text(name),
                          onDeleted: () {
                            setState(() {
                              dampakName.remove(name);
                            });
                          },
                        )).toList(),
                      ),
                    ),*/
                    Padding(
                      padding: EdgeInsets.only(top: 30.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Severity',
                              style: TextStyle(color: Colors.black54),
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
                                      'Low',
                                      style: TextStyle(
                                          color: _colorLowSe == Colors.grey ? Colors.green : Colors.white),
                                      textAlign:
                                      TextAlign
                                          .center,
                                    ),
                                    color: _colorLowSe == Colors.grey ? Colors.white : Colors.green,
                                    onPressed: () {
                                      setState(() {
                                        severity = 'Low';
                                        bantuSeverity = 1;
                                        _colorLowSe = Colors.green[400];
                                        _colorMedSe = Colors.grey;
                                        _colorHighSe = Colors.grey;

                                        if (bantuSeverity != 0 &&
                                            bantuLikelihood != 0) {
                                          if (bantuSeverity > bantuLikelihood) {
                                            if (bantuSeverity == 1) {
                                              _risk = 'Low';
                                              _colorRisk = Colors.green[400];
                                            } else if (bantuSeverity == 2) {
                                              _risk = 'Medium';
                                              _colorRisk = Colors.orangeAccent;
                                            } else if (bantuSeverity == 3) {
                                              _risk = 'High';
                                              _colorRisk = Colors.redAccent;
                                            }
                                          } else if (bantuSeverity <
                                              bantuLikelihood) {
                                            if (bantuLikelihood == 1) {
                                              _risk = 'Low';
                                              _colorRisk = Colors.green[400];
                                            } else if (bantuLikelihood == 2) {
                                              _risk = 'Medium';
                                              _colorRisk = Colors.orangeAccent;
                                            } else if (bantuLikelihood == 3) {
                                              _risk = 'High';
                                              _colorRisk = Colors.redAccent;
                                            }
                                          } else if (bantuSeverity ==
                                              bantuLikelihood) {
                                            if (bantuSeverity == 1) {
                                              _risk = 'Low';
                                              _colorRisk = Colors.green[400];
                                            } else if (bantuSeverity == 2) {
                                              _risk = 'Medium';
                                              _colorRisk = Colors.orangeAccent;
                                            } else if (bantuSeverity == 3) {
                                              _risk = 'High';
                                              _colorRisk = Colors.redAccent;
                                            }
                                          }
                                        } else {
                                          _risk = '';
                                        }
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
                                        color: _colorMedSe == Colors.grey ? Colors.orangeAccent : Colors.white,
                                      ),
                                    ),
                                    child: Text(
                                      'Medium',
                                      style: TextStyle(
                                          color: _colorMedSe == Colors.grey ? Colors.orangeAccent : Colors.white),
                                      textAlign:
                                      TextAlign
                                          .center,
                                    ),
                                    color: _colorMedSe == Colors.grey ? Colors.white : Colors.orangeAccent,
                                    onPressed: () {
                                      setState(() {
                                        severity = 'Medium';
                                        bantuSeverity = 2;
                                        _colorLowSe = Colors.grey;
                                        _colorMedSe = Colors.orangeAccent;
                                        _colorHighSe = Colors.grey;

                                        if (bantuSeverity != 0 &&
                                            bantuLikelihood != 0) {
                                          if (bantuSeverity > bantuLikelihood) {
                                            if (bantuSeverity == 1) {
                                              _risk = 'Low';
                                              _colorRisk = Colors.green[400];
                                            } else if (bantuSeverity == 2) {
                                              _risk = 'Medium';
                                              _colorRisk = Colors.orangeAccent;
                                            } else if (bantuSeverity == 3) {
                                              _risk = 'High';
                                              _colorRisk = Colors.redAccent;
                                            }
                                          } else if (bantuSeverity <
                                              bantuLikelihood) {
                                            if (bantuLikelihood == 1) {
                                              _risk = 'Low';
                                              _colorRisk = Colors.green[400];
                                            } else if (bantuLikelihood == 2) {
                                              _risk = 'Medium';
                                              _colorRisk = Colors.orangeAccent;
                                            } else if (bantuLikelihood == 3) {
                                              _risk = 'High';
                                              _colorRisk = Colors.redAccent;
                                            }
                                          } else if (bantuSeverity ==
                                              bantuLikelihood) {
                                            if (bantuSeverity == 1) {
                                              _risk = 'Low';
                                              _colorRisk = Colors.green[400];
                                            } else if (bantuSeverity == 2) {
                                              _risk = 'Medium';
                                              _colorRisk = Colors.orangeAccent;
                                            } else if (bantuSeverity == 3) {
                                              _risk = 'High';
                                              _colorRisk = Colors.redAccent;
                                            }
                                          }
                                        } else {
                                          _risk = '';
                                        }
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
                                        color: _colorHighSe == Colors.grey ? Colors.redAccent : Colors.white,
                                      ),
                                    ),
                                    child: Text(
                                      'High',
                                      style: TextStyle(
                                          color: _colorHighSe == Colors.grey ? Colors.redAccent : Colors.white),
                                      textAlign:
                                      TextAlign
                                          .center,
                                    ),
                                    color: _colorHighSe == Colors.grey ? Colors.white : Colors.redAccent,
                                    onPressed: () {
                                      setState(() {
                                        severity = 'High';
                                        bantuSeverity = 3;
                                        _colorLowSe = Colors.grey;
                                        _colorMedSe = Colors.grey;
                                        _colorHighSe = Colors.redAccent;

                                        if (bantuSeverity != 0 &&
                                            bantuLikelihood != 0) {
                                          if (bantuSeverity > bantuLikelihood) {
                                            if (bantuSeverity == 1) {
                                              _risk = 'Low';
                                              _colorRisk = Colors.green[400];
                                            } else if (bantuSeverity == 2) {
                                              _risk = 'Medium';
                                              _colorRisk = Colors.orangeAccent;
                                            } else if (bantuSeverity == 3) {
                                              _risk = 'High';
                                              _colorRisk = Colors.redAccent;
                                            }
                                          } else if (bantuSeverity <
                                              bantuLikelihood) {
                                            if (bantuLikelihood == 1) {
                                              _risk = 'Low';
                                              _colorRisk = Colors.green[400];
                                            } else if (bantuLikelihood == 2) {
                                              _risk = 'Medium';
                                              _colorRisk = Colors.orangeAccent;
                                            } else if (bantuLikelihood == 3) {
                                              _risk = 'High';
                                              _colorRisk = Colors.redAccent;
                                            }
                                          } else if (bantuSeverity ==
                                              bantuLikelihood) {
                                            if (bantuSeverity == 1) {
                                              _risk = 'Low';
                                              _colorRisk = Colors.green[400];
                                            } else if (bantuSeverity == 2) {
                                              _risk = 'Medium';
                                              _colorRisk = Colors.orangeAccent;
                                            } else if (bantuSeverity == 3) {
                                              _risk = 'High';
                                              _colorRisk = Colors.redAccent;
                                            }
                                          }
                                        } else {
                                          _risk = '';
                                        }
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
                      padding: EdgeInsets.only(top: 20.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Likelihood',
                              style: TextStyle(color: Colors.black54),
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
                                        color: _colorLowLi == Colors.grey ? Colors.green : Colors.white,
                                      ),
                                    ),
                                    child: Text(
                                      'Low',
                                      style: TextStyle(
                                          color: _colorLowLi == Colors.grey ? Colors.green : Colors.white),
                                      textAlign:
                                      TextAlign
                                          .center,
                                    ),
                                    color: _colorLowLi == Colors.grey ? Colors.white : Colors.green,
                                    onPressed: () {
                                      setState(() {
                                        likelihood = 'Low';
                                        bantuLikelihood = 1;
                                        _colorLowLi = Colors.green[400];
                                        _colorMedLi = Colors.grey;
                                        _colorHighLi = Colors.grey;

                                        // _risk = 'Low';
                                        // _colorRisk = Colors.green[400];

                                        if (bantuSeverity != 0 &&
                                            bantuLikelihood != 0) {
                                          if (bantuSeverity > bantuLikelihood) {
                                            if (bantuSeverity == 1) {
                                              _risk = 'Low';
                                              _colorRisk = Colors.green[400];
                                            } else if (bantuSeverity == 2) {
                                              _risk = 'Medium';
                                              _colorRisk = Colors.orangeAccent;
                                            } else if (bantuSeverity == 3) {
                                              _risk = 'High';
                                              _colorRisk = Colors.redAccent;
                                            }
                                          } else if (bantuSeverity <
                                              bantuLikelihood) {
                                            if (bantuLikelihood == 1) {
                                              _risk = 'Low';
                                              _colorRisk = Colors.green[400];
                                            } else if (bantuLikelihood == 2) {
                                              _risk = 'Medium';
                                              _colorRisk = Colors.orangeAccent;
                                            } else if (bantuLikelihood == 3) {
                                              _risk = 'High';
                                              _colorRisk = Colors.redAccent;
                                            }
                                          } else if (bantuSeverity ==
                                              bantuLikelihood) {
                                            if (bantuSeverity == 1) {
                                              _risk = 'Low';
                                              _colorRisk = Colors.green[400];
                                            } else if (bantuSeverity == 2) {
                                              _risk = 'Medium';
                                              _colorRisk = Colors.orangeAccent;
                                            } else if (bantuSeverity == 3) {
                                              _risk = 'High';
                                              _colorRisk = Colors.redAccent;
                                            }
                                          }
                                        } else {
                                          _risk = '';
                                        }
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
                                        color: _colorMedLi == Colors.grey ? Colors.orangeAccent : Colors.white,
                                      ),
                                    ),
                                    child: Text(
                                      'Medium',
                                      style: TextStyle(
                                          color: _colorMedLi == Colors.grey ? Colors.orangeAccent : Colors.white),
                                      textAlign:
                                      TextAlign
                                          .center,
                                    ),
                                    color: _colorMedLi == Colors.grey ? Colors.white : Colors.orangeAccent,
                                    onPressed: () {
                                      setState(() {
                                        likelihood = 'Medium';
                                        bantuLikelihood = 2;
                                        _colorLowLi = Colors.grey;
                                        _colorMedLi = Colors.orangeAccent;
                                        _colorHighLi = Colors.grey;

                                        // _risk = 'Medium';
                                        // _colorRisk = Colors.orangeAccent;

                                        if (bantuSeverity != 0 &&
                                            bantuLikelihood != 0) {
                                          if (bantuSeverity > bantuLikelihood) {
                                            if (bantuSeverity == 1) {
                                              _risk = 'Low';
                                              _colorRisk = Colors.green[400];
                                            } else if (bantuSeverity == 2) {
                                              _risk = 'Medium';
                                              _colorRisk = Colors.orangeAccent;
                                            } else if (bantuSeverity == 3) {
                                              _risk = 'High';
                                              _colorRisk = Colors.redAccent;
                                            }
                                          } else if (bantuSeverity <
                                              bantuLikelihood) {
                                            if (bantuLikelihood == 1) {
                                              _risk = 'Low';
                                              _colorRisk = Colors.green[400];
                                            } else if (bantuLikelihood == 2) {
                                              _risk = 'Medium';
                                              _colorRisk = Colors.orangeAccent;
                                            } else if (bantuLikelihood == 3) {
                                              _risk = 'High';
                                              _colorRisk = Colors.redAccent;
                                            }
                                          } else if (bantuSeverity ==
                                              bantuLikelihood) {
                                            if (bantuSeverity == 1) {
                                              _risk = 'Low';
                                              _colorRisk = Colors.green[400];
                                            } else if (bantuSeverity == 2) {
                                              _risk = 'Medium';
                                              _colorRisk = Colors.orangeAccent;
                                            } else if (bantuSeverity == 3) {
                                              _risk = 'High';
                                              _colorRisk = Colors.redAccent;
                                            }
                                          }
                                        } else {
                                          _risk = '';
                                        }
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
                                        color: _colorHighLi == Colors.grey ? Colors.redAccent : Colors.white,
                                      ),
                                    ),
                                    child: Text(
                                      'High',
                                      style: TextStyle(
                                          color: _colorHighLi == Colors.grey ? Colors.redAccent : Colors.white),
                                      textAlign:
                                      TextAlign
                                          .center,
                                    ),
                                    color: _colorHighLi == Colors.grey ? Colors.white : Colors.redAccent,
                                    onPressed: () {
                                      setState(() {
                                        likelihood = 'High';
                                        bantuLikelihood = 3;
                                        _colorLowLi = Colors.grey;
                                        _colorMedLi = Colors.grey;
                                        _colorHighLi = Colors.redAccent;

                                        // _risk = 'High';
                                        // _colorRisk = Colors.redAccent;

                                        if (bantuSeverity != 0 &&
                                            bantuLikelihood != 0) {
                                          if (bantuSeverity > bantuLikelihood) {
                                            if (bantuSeverity == 1) {
                                              _risk = 'Low';
                                              _colorRisk = Colors.green[400];
                                            } else if (bantuSeverity == 2) {
                                              _risk = 'Medium';
                                              _colorRisk = Colors.orangeAccent;
                                            } else if (bantuSeverity == 3) {
                                              _risk = 'High';
                                              _colorRisk = Colors.redAccent;
                                            }
                                          } else if (bantuSeverity <
                                              bantuLikelihood) {
                                            if (bantuLikelihood == 1) {
                                              _risk = 'Low';
                                              _colorRisk = Colors.green[400];
                                            } else if (bantuLikelihood == 2) {
                                              _risk = 'Medium';
                                              _colorRisk = Colors.orangeAccent;
                                            } else if (bantuLikelihood == 3) {
                                              _risk = 'High';
                                              _colorRisk = Colors.redAccent;
                                            }
                                          } else if (bantuSeverity ==
                                              bantuLikelihood) {
                                            if (bantuSeverity == 1) {
                                              _risk = 'Low';
                                              _colorRisk = Colors.green[400];
                                            } else if (bantuSeverity == 2) {
                                              _risk = 'Medium';
                                              _colorRisk = Colors.orangeAccent;
                                            } else if (bantuSeverity == 3) {
                                              _risk = 'High';
                                              _colorRisk = Colors.redAccent;
                                            }
                                          }
                                        } else {
                                          _risk = '';
                                        }
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
                      padding: EdgeInsets.only(top: 20.0, right: 15.0, left: 15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(bottom: 10.0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Risk',
                              style: TextStyle(color: Colors.black54),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.centerStart,
                            children: <Widget>[
                              Container(
                                color: _colorRisk,
                                height: 50.0,
                              ),
                              Container(
                                child: Text(
                                  _risk,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16.0),
                                ),
                                alignment: Alignment.center,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    ListTile(
                      title: Container(
                        width: 270.0,
                        child: StreamBuilder(
                          stream: Firestore.instance.collection('pengendalianRisk').orderBy('pengendalian', descending: false).snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData)
                              return Container(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );

                            return DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  labelText: 'Pengendalian',
                                    labelStyle: TextStyle(fontSize: 14.0, color: _selectionPengendalian == null ? Colors.grey : AbubaPallate.greenabuba,),
                                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: _selectionPengendalian == null ? Colors.grey : AbubaPallate.greenabuba,))
                                ),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select pengendalian';
                                  } else {
                                    return null;
                                  }
                                },
                                value: _selectionPengendalian,
                                onChanged: (String value) {
                                  setState(() {
                                    _selectionPengendalian = value;
                                  });
                                },
                                items: snapshot.data.documents.map((DocumentSnapshot document) {
                                  return DropdownMenuItem(
                                    value: document['pengendalian'].toString(),
                                    child: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: RichText(
                                        overflow: TextOverflow.visible,
                                        text: TextSpan(
                                            text: document['pengendalian'].toString(),
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
                      ),
                      trailing: Container(width: 30.0,),
                    ),
                    ListTile(
                      title: Container(
                        width: 270.0,
                        child: TextFormField(
                          /*validator: (value) {
                            if (value == '') {
                              return 'Form can\'t be null';
                            } else {
                              return null;
                            }
                          },*/
                          controller: deskripsiController,
                          maxLines: 3,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Deskripsi',
                              labelStyle: TextStyle(fontSize: 14.0, color: deskripsiController.text == '' ? Colors.grey : AbubaPallate.greenabuba,),
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: deskripsiController.text == '' ? Colors.grey : AbubaPallate.greenabuba,))
                          ),
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              color: Colors.black87,
                              fontSize: 14.0),
                          onSaved: null,
                        ),
                      ),
                      trailing: Container(
                        width: 30.0,
                        child: IconButton(
                          icon: Icon(Icons.add, color: AbubaPallate.greenabuba),
                          onPressed: () {
                            setState(() {
                              if (deskripsiName.contains(deskripsiController.text)) {

                              } else {
                                deskripsiName.add(deskripsiController.text);
                              }
                              deskripsiController.clear();
                            });
                          },
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: deskripsiName.length == 0 ? 0.0 : 10.0, bottom: deskripsiName.length == 0 ? 0.0 : 0.0),
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        runAlignment: WrapAlignment.start,
                        direction: Axis.horizontal,
                        children: deskripsiName.length == 0
                            ? [Container()]
                            : deskripsiName.map((String name) => Chip(
                          label: Text(name),
                          onDeleted: () {
                            setState(() {
                              deskripsiName.remove(name);
                            });
                          },
                        )).toList(),
                      ),
                    ),
                    ListTile(
                      title: Container(
                          width: 270.0,
                          child: TextFormField(
                            /*validator: (value) {
                            if (value == '') {
                              return 'Form can\'t be null';
                            } else {
                              return null;
                            }
                          },*/
                            controller: pemantauanController,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Pemantauan',
                              labelStyle: TextStyle(fontSize: 14.0, color: pemantauanController.text == '' ? Colors.grey : AbubaPallate.greenabuba,),
                              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: pemantauanController.text == '' ? Colors.grey : AbubaPallate.greenabuba,)),
                              hintText: 'Pemantauan',
                            ),
                            style: TextStyle(
                                fontStyle: FontStyle.normal,
                                color: Colors.black87,
                                fontSize: 14.0),
                            onSaved: null,
                          )
                      ),
                      trailing: Container(
                        width: 30.0,
                        child: IconButton(
                          icon: Icon(Icons.add, color: AbubaPallate.greenabuba),
                          onPressed: () {
                            setState(() {
                              if (pemantauanName.contains(pemantauanController.text)) {

                              } else {
                                pemantauanName.add(pemantauanController.text);
                              }
                              pemantauanController.clear();
                            });
                          },
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: pemantauanName.length == 0 ? 0.0 : 10.0, bottom: pemantauanName.length == 0 ? 0.0 : 0.0),
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        runAlignment: WrapAlignment.start,
                        direction: Axis.horizontal,
                        children: pemantauanName.length == 0
                            ? [Container()]
                            : pemantauanName.map((String name) => Chip(
                          label: Text(name),
                          onDeleted: () {
                            setState(() {
                              pemantauanName.remove(name);
                            });
                          },
                        )).toList(),
                      ),
                    ),
                    SearchWidget<LeaderBoard>(
                      dataList: listPIC,
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
                        selectedPIC = selectedItem.name;
                        
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
                              hintText: "PIC",
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
                    SearchWidget<LeaderBoard>(
                      dataList: listVerifikator,
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
                        selectedVerifikator = selectedItem.name;
                        
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
                              hintText: "Verifikator",
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
                    Padding(
                      padding: EdgeInsets.only(top: 20.0, bottom: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child:
                            GestureDetector(
                              onTap: () {
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    _isProccess =
                                    true;
                                    _autoValidate =
                                    false;
                                  });

                                  _formKey.currentState.save();

                                  DocumentReference documentReference2 = Firestore.instance.collection('risk_assesment').document();

                                  documentReference2.setData({
                                    'createdBy': widget.namaUser,
                                    'createdTime': timenow,
                                    'idRisk': dumperID,
                                    'maxid': dumperID,
                                    'kategori': selectedCategory,
                                    'sop': selectedSOP,
                                    'jenis': jenisName,
                                    'jenisDesk': jenisController.text,
                                    'sumber': sumberName,
                                    'sumberDesk': sumberController.text,
                                    'dampak': dampakName,
                                    'dampakDesk': dampakController.text,
                                    'severity': severity,
                                    'likelihood': likelihood,
                                    'risk': _risk,
                                    'pengendalian': selectedPengendalian,
                                    'deskripsi': deskripsiName,
                                    'pemantauan': pemantauanName,
                                    'pic': selectedPIC,
                                    'verifikator': selectedVerifikator,
                                  }).then((doc) {
                                    setState(() {
                                      _isProccess =
                                      false;
                                    });

                                    /*_isOnTop ? _scrollToBottom : _scrollToTop;*/
                                    sumberController.clear();
                                    jenisController.clear();
                                    dampakController.clear();
                                    _colorLowSe = Colors.grey;
                                    _colorMedSe = Colors.grey;
                                    _colorHighSe = Colors.grey;
                                    _colorLowLi = Colors.grey;
                                    _colorMedLi = Colors.grey;
                                    _colorHighLi = Colors.grey;
                                    severity = '';
                                    likelihood = '';
                                    bantuSeverity = 0;
                                    bantuLikelihood = 0;
                                    _risk = '';
                                    _colorRisk = Colors.grey;

                                    /*jenisName.clear();
                                    sumberName.clear();
                                    dampakName.clear();*/
                                    deskripsiName.clear();
                                    pemantauanName.clear();

                                    DocumentReference documentReference = Firestore.instance.collection('dumper_maxid').document(index_riskAssesment);

                                    documentReference.updateData({
                                      'maxid_riskAssesment': dumperID
                                    }).then((doc2) {
                                      print('success');
                                    }).catchError((error2) {
                                      print(error2);
                                    });

                                    showDialog(
                                        barrierDismissible: true,
                                        context: context,
                                        builder: (context) => Dialog(
                                          child: Container(
                                            height: 170.0,
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  color: AbubaPallate.greenabuba,
                                                  height: 50.0,
                                                  child: Center(
                                                    child: Text(
                                                      'Silahkan Pilih',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16.0,
                                                          fontWeight: FontWeight.w700),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20.0,
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: const EdgeInsets.only(right: 8.0, top: 10.0, bottom: 10.0),
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
                                                        child:
                                                        RaisedButton(
                                                          shape:
                                                          new RoundedRectangleBorder(
                                                            borderRadius:
                                                            new BorderRadius
                                                                .circular(
                                                                5.0),
                                                            side:
                                                            BorderSide(
                                                              width: 1.5,
                                                              color: AbubaPallate.menuBluebird,
                                                            ),
                                                          ),
                                                          child: Text(
                                                            'TAMBAH',
                                                            style:
                                                            TextStyle(
                                                              color: AbubaPallate.menuBluebird,
                                                            ),
                                                            textAlign:
                                                            TextAlign
                                                                .center,
                                                          ),
                                                          color: Colors.white,
                                                          onPressed: () {
                                                            Navigator.of(
                                                                context,
                                                                rootNavigator: true)
                                                                .pop('dialog');
                                                            _moveUp();
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(right: 8.0, top: 10.0, bottom: 10.0),
                                                      child: ButtonTheme(
                                                        minWidth: 30.0,
                                                        height: 30.0,
                                                        child:
                                                        RaisedButton(
                                                          shape:
                                                          new RoundedRectangleBorder(
                                                            borderRadius:
                                                            new BorderRadius
                                                                .circular(
                                                                5.0),
                                                            side:
                                                            BorderSide(
                                                              width: 1.5,
                                                              color: Colors.green,
                                                            ),
                                                          ),
                                                          child: Text(
                                                            'SAVE',
                                                            style:
                                                            TextStyle(
                                                              color: Colors.green,
                                                            ),
                                                            textAlign:
                                                            TextAlign
                                                                .center,
                                                          ),
                                                          color: Colors.white,
                                                          onPressed: () {
                                                            Navigator.push(context,
                                                                MyCustomRoute(
                                                                    builder: (context) => new BerandaRiskRegister()
                                                                )
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      /**/
                                    );
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
                                  Icon(Icons.add_circle,
                                    color: Colors
                                        .green, size: 30.0,)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      })
    );
  }
}
