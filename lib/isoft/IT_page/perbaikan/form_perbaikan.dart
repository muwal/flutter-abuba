import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:intl/intl.dart';
import 'package:search_widget/search_widget.dart';

class LeaderBoard {
  final String name;
  final int id;

  LeaderBoard(this.name, this.id);
}

class FormPerbaikan extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  final List<dynamic> itemMaintenance;

  FormPerbaikan({this.idUser, this.namaUser, this.departmentUser, this.itemMaintenance});

  @override
  _FormPerbaikanState createState() => _FormPerbaikanState();
}

class _FormPerbaikanState extends State<FormPerbaikan> with TickerProviderStateMixin {
  AnimationController animationController;

  bool _isProccess = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  var maxidPerbaikan;
  var indexPerbaikan;

  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime dueDate;
  TextEditingController detailMasalah = TextEditingController();

  List<LeaderBoard> listCategory = <LeaderBoard>[];
  List<LeaderBoard> listArea = <LeaderBoard>[];
  List<LeaderBoard> listLokasi = <LeaderBoard>[];
  List<LeaderBoard> listItem = <LeaderBoard>[];
  List<LeaderBoard> listMasalah = <LeaderBoard>[];

  int selectedCategory;
  int selectedArea;
  int selectedLokasi;
  String selectedItemNo;
  int selectedMasalah;

  @override
  void initState() {
    super.initState();
    Firestore.instance.collection('dumper_perbaikan').snapshots().listen((data) {
      setState(() {
        maxidPerbaikan = data.documents[0].data['maxid_perbaikan'] + 1;
        indexPerbaikan = data.documents[0].documentID;
      });
    });

    CollectionReference ref3 = Firestore.instance.collection('perbaikanCategory');
    ref3.orderBy('category', descending: false).snapshots().listen((data3) {
      data3.documentChanges.forEach((getData3) {
        setState(() {
          listCategory.add(LeaderBoard(getData3.document.data['category'], getData3.document.data['id']));
        });
      });
    });

    CollectionReference ref4 = Firestore.instance.collection('outlet');
    ref4.orderBy('nama_outlet', descending: false).snapshots().listen((data4) {
      data4.documentChanges.forEach((getData4) {
        setState(() {
          listArea.add(LeaderBoard(getData4.document.data['nama_outlet'], getData4.document.data['id']));
        });
      });
    });

    CollectionReference ref5 = Firestore.instance.collection('lokasi');
    ref5.orderBy('lokasi', descending: false).snapshots().listen((data5) {
      data5.documentChanges.forEach((getData5) {
        setState(() {
          listLokasi.add(LeaderBoard(getData5.document.data['lokasi'], getData5.document.data['id']));
        });
      });
    });

    CollectionReference ref6 = Firestore.instance.collection('perbaikanMasalah');
    ref6.orderBy('masalah', descending: false).snapshots().listen((data6) {
      data6.documentChanges.forEach((getData6) {
        setState(() {
          listMasalah.add(LeaderBoard(getData6.document.data['masalah'], getData6.document.data['id']));
        });
      });
    });

    for (int q = 0; q < widget.itemMaintenance.length; q++) {
      listItem.add(LeaderBoard(widget.itemMaintenance[q], 0));
    }

    animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(
        from: animationController.value == 0.0
            ? 1.0
            : animationController.value
    );
  }

  Widget _appBar() {
    return AppBar(
      elevation: 0.25,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text('Perbaikan Baru', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black)),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Color(0xfff9f9f9),),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: _appBar(),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Form(
              autovalidate: _autoValidate,
              key: _formKey,
              child: AnimatedBuilder(
                animation: animationController,
                builder: (_, Widget child) {
                  return animationController.isAnimating
                    ? Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : ListView(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                            child: RichText(
                              softWrap: true,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.visible,
                              text: TextSpan(
                                text: 'ITEM',
                                style: TextStyle(
                                  color: AbubaPallate.greenabuba,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13.0,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
                            child: SearchWidget<LeaderBoard>(
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
                                selectedCategory = selectedItem.id;

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
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
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
                                selectedArea = selectedItem.id;

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
                            padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
                            child: SearchWidget<LeaderBoard>(
                              dataList: listLokasi,
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
                                selectedLokasi = selectedItem.id;

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
                                      hintText: "Location",
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
                            padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
                            child: SearchWidget<LeaderBoard>(
                              dataList: listItem,
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
                                selectedItemNo = selectedItem.name;

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
                                      hintText: "Item",
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
                            padding: const EdgeInsets.only(top: 12.0),
                            child: Divider(
                              height: 6.0,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                            child: RichText(
                              softWrap: true,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.visible,
                              text: TextSpan(
                                text: 'MASALAH',
                                style: TextStyle(
                                  color: AbubaPallate.greenabuba,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13.0,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
                            child: SearchWidget<LeaderBoard>(
                              dataList: listMasalah,
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
                                selectedMasalah = selectedItem.id;

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
                                      hintText: "Masalah",
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
                            padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
                            child: TextFormField(
                              maxLines: 3,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: 'Detail Masalah',
                                labelStyle: TextStyle(fontSize: 12.0),
                              ),
                              maxLength: 250,
                              controller: detailMasalah,
                              textCapitalization: TextCapitalization.sentences,
                              validator: (value) {
                                if (value.length < 10) {
                                  return 'Detail masalah must be more than 10 character';
                                } else if (value.length > 250) {
                                  return 'Detail masalah must be leses than 250 character';
                                } else {
                                  return null;
                                }
                              },
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                            child: ButtonTheme(
                              minWidth: 50.0,
                              height: 40.0,
                              child: Builder(
                                builder: (context) {
                                  return RaisedButton(
                                    elevation: 0.0,
                                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
                                    textColor: Colors.white,
                                    color: AbubaPallate.greenabuba,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        _isProccess
                                          ? Container(
                                              padding: EdgeInsets.symmetric(vertical: 5.0),
                                              child: Center(
                                                child: SizedBox(
                                                  height: 15.0,
                                                  width: 15.0,
                                                  child: CircularProgressIndicator(
                                                    valueColor: AlwaysStoppedAnimation(Colors.white),
                                                    strokeWidth: 1.5,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(),
                                        _isProccess
                                          ? SizedBox(
                                              width: 10.0,
                                            )
                                          : Container(),
                                        Text(
                                          'SUBMIT'
                                        )
                                      ],
                                    ),
                                    onPressed: () {
                                      if (selectedCategory == null || selectedArea == null || selectedLokasi == null || selectedItemNo == null || selectedMasalah == null || detailMasalah.text == '') {
                                        Scaffold.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Data Belum Lengkap'),
                                            duration: Duration(seconds: 2),
                                            action: SnackBarAction(
                                              label: 'OK',
                                              onPressed: () {
                                                Scaffold.of(context).removeCurrentSnackBar();
                                              },
                                            ),
                                          )
                                        );
                                      } else {
                                        if (_isProccess == false) {
                                          var split = selectedItemNo.toString().split(' - ');
                                        
                                          setState(() {
                                            _isProccess = true;
                                          });

                                          DocumentReference docReference = Firestore.instance.collection('perbaikanIT').document();
                                          
                                          docReference.setData({
                                            'userCreated': widget.idUser,
                                            'dateCreated': DateTime.now(),
                                            'perbaikanNo': maxidPerbaikan,
                                            'category': int.tryParse(selectedCategory.toString()),
                                            'area': int.tryParse(selectedArea.toString()),
                                            'lokasi': int.tryParse(selectedLokasi.toString()),
                                            'item': split[1],
                                            'itemNo': split[0],
                                            'masalah': int.tryParse(selectedMasalah.toString()),
                                            'detailMasalah': detailMasalah.text,
                                            'status': 'NOT READY',
                                            'userVerifikasi': widget.idUser,
                                            'dateVerifikasi': null,
                                            'datePerbaikan': null,
                                            'rating': 0,
                                            'notePerbaikan': null,
                                            'statusPerbaikan': 'NOT READY'
                                          }).then((doc) {
                                            setState(() {
                                              _isProccess = false;
                                            });

                                            DocumentReference documentReference =Firestore.instance.collection('dumper_perbaikan').document(indexPerbaikan);

                                            documentReference.updateData({
                                              'maxid_perbaikan':maxidPerbaikan
                                            }).then((doc2) {
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
                                                            'Perbaikan No. PRB-${maxidPerbaikan.toString().padLeft(4, '0')}',
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
                                        } else {

                                        }
                                      }
                                    },
                                  );
                                },
                              ),
                            )
                          )
                        ],
                      );
                },
              )
            ),
          ),
        ),
      ),
    );
  }
}