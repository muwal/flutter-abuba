import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:intl/intl.dart';
import 'package:search_widget/search_widget.dart';

class LeaderBoard {
  final String name;
  final int id;

  LeaderBoard(this.name, this.id);
}

class ManagementCreate extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  ManagementCreate({this.idUser, this.namaUser, this.departmentUser});

  _ManagementCreateState createState() => _ManagementCreateState();
}

class _ManagementCreateState extends State<ManagementCreate> with TickerProviderStateMixin {
  AnimationController animationController;
  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime tglImplementasi;
  String _kategori;
  String personID;
  String personName;
  List<int> personIDArray = [];
  List<String> personNameArray = [];
  List<DateTime> personReviewDate = [];
  List<String> personReviewNote = [];
  List<String> personReviewStatus = [];
  String prioritas = '';
  bool showAlert = false;
  bool showAlert2 = false;
  TextEditingController controllerAlasan = TextEditingController();
  TextEditingController controllerDeskripsi = TextEditingController();
  bool _isProccess = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  int approveBy = 0;

  Color _colorLowSe = Colors.grey;
  Color _colorMedSe = Colors.grey;
  Color _colorHighSe = Colors.grey;

  var maxidMgmt;
  var maxidMgmtBantu;
  var indexMgmt;

  List<LeaderBoard> listKirimKepada = <LeaderBoard>[];
  List<LeaderBoard> listCategory = <LeaderBoard>[];
  int selectedCategory;

  @override
  void initState() {
    super.initState();

    Firestore.instance.collection('dumper_changeMgmt').snapshots().listen((data) {
      setState(() {
        maxidMgmt = data.documents[0].data['maxid_mgmt'] + 1;
        maxidMgmtBantu = data.documents[0].data['maxid_mgmt'] + 1;
        indexMgmt = data.documents[0].documentID;
      });
    });

    Firestore.instance.collection('user').where('grade', isEqualTo: 'Direktur').snapshots().listen((data2) {
      setState(() {
        approveBy = data2.documents[0].data['id'];
      });
    });

    animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(
      from: animationController.value == 0.0
        ? 1.0
        : animationController.value
    );

    CollectionReference reference = Firestore.instance.collection('user');
    reference.orderBy('department', descending: false).snapshots().listen((data) {
      data.documentChanges.forEach((change) {
        setState(() {
          if (change.document.data['id'] != widget.idUser) {
            listKirimKepada.add(LeaderBoard(change.document.data['department'] + ' - ' +change.document.data['nama'], change.document.data['id']));
          }
        });
      });
    });

    CollectionReference reference2 = Firestore.instance.collection('changeMgmt_Category');
    reference2.orderBy('category', descending: false).snapshots().listen((data) {
      data.documentChanges.forEach((change2) {
        setState(() {
          listCategory.add(LeaderBoard(change2.document.data['category'], change2.document.data['id']));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
          child: Form(
            autovalidate: _autoValidate,
            key: _formKey,
            child: Scrollbar(
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Change Management',
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
                              child: CircularProgressIndicator()
                            ),
                          )
                        : Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    padding:
                                    EdgeInsets.only(bottom: 10.0),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Change #',
                                      style: TextStyle(
                                          color: Colors.black54),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  Stack(
                                    alignment: AlignmentDirectional
                                        .centerStart,
                                    children: <Widget>[
                                      Container(
                                        color: Colors.grey[400],
                                        height: 40.0,
                                      ),
                                      Container(
                                        child: Text(
                                          maxidMgmt.toString().padLeft(4, '0'),
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w700
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                              child: DateTimePickerFormField(
                                format: dateFormat,
                                onChanged: (dt) => setState(() => tglImplementasi = dt),
                                dateOnly: true,
                                editable: false,
                                resetIcon: null,
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please select implementation date';
                                  } else {
                                    return null;
                                  }
                                },
                                style: TextStyle(fontSize: 16.0, color: Colors.black),
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelStyle: TextStyle(fontSize: 14.0),
                                  labelText: 'Tanggal Implementasi Perubahan'
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Prioritas',
                                      style: TextStyle(
                                          color: Colors.black54),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
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
                                              style: TextStyle(color: _colorLowSe),
                                            ),
                                            borderSide: BorderSide(color: _colorLowSe,width: 1.0),
                                            highlightedBorderColor:
                                            _colorLowSe,
                                            onPressed: () {
                                              setState(() {
                                                prioritas = 'Low';
                                                showAlert = false;
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
                                                  color: _colorMedSe),
                                            ),
                                            borderSide: BorderSide(
                                                color: _colorMedSe,
                                                width: 1.0),
                                            highlightedBorderColor:
                                            _colorMedSe,
                                            onPressed: () {
                                              setState(() {
                                                prioritas = 'Medium';
                                                showAlert = false;
                                                _colorLowSe =
                                                    Colors.grey;
                                                _colorMedSe = Colors
                                                    .orangeAccent;
                                                _colorHighSe =
                                                    Colors.grey;
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
                                                  color:
                                                  _colorHighSe),
                                            ),
                                            borderSide: BorderSide(
                                                color: _colorHighSe,
                                                width: 1.0),
                                            highlightedBorderColor:
                                            _colorHighSe,
                                            onPressed: () {
                                              setState(() {
                                                prioritas = 'High';
                                                showAlert = false;
                                                _colorLowSe =
                                                    Colors.grey;
                                                _colorMedSe =
                                                    Colors.grey;
                                                _colorHighSe =
                                                    Colors.redAccent;
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
                            showAlert
                              ? Container(
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                                  child: Text(
                                    'Please select prioritas',
                                    style: TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 12.0,
                                      fontStyle: FontStyle.italic
                                    ),
                                  ),
                                )
                              : Container(),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
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
                                        hintText: "Kategori Perubahan",
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
                              padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                              child: TextFormField(
                                maxLines: 3,
                                validator: (value) {
                                  if (value.length < 10 ) {
                                    return 'Alasan perubahan must be more than 10 character';
                                  } else if (value.length > 250) {
                                    return 'Alasan perubahan must be less than 250 character';
                                  } else {
                                    return null;
                                  }
                                },
                                textCapitalization: TextCapitalization.sentences,
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Alasan Perubahan',
                                  labelStyle: TextStyle(fontSize: 14.0),
                                ),
                                maxLength: 250,
                                controller: controllerAlasan,
                                style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  color: Colors.black87,
                                  fontSize: 14.0
                                ),
                                onSaved: null,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                              child: TextFormField(
                                maxLines: 3,
                                validator: (value) {
                                  if (value.length < 10 ) {
                                    return 'Deskripsi perubahan must be more than 10 character';
                                  } else if (value.length > 250) {
                                    return 'Deskripsi perubahan must be less than 250 character';
                                  } else {
                                    return null;
                                  }
                                },
                                textCapitalization: TextCapitalization.sentences,
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Deskripsi Perubahan',
                                  labelStyle: TextStyle(fontSize: 14.0),
                                ),
                                maxLength: 250,
                                controller: controllerDeskripsi,
                                style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  color: Colors.black87,
                                  fontSize: 14.0
                                ),
                                onSaved: null,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: SearchWidget<LeaderBoard>(
                                dataList: listKirimKepada,
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
                                  var bantu = selectedItem.name.split(' - ');
                                  showAlert2 = false;
                                  if (personIDArray.contains(int.tryParse(selectedItem.id.toString()))) {

                                  } else {
                                    personIDArray.add(int.tryParse(selectedItem.id.toString()));
                                  }
                                  if (personNameArray.contains(bantu[1])) {

                                  } else {
                                    personNameArray.add(bantu[1]);
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
                                        hintText: "Participant",
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
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 15.0, right: 10.0, top: personNameArray.length == 0 ? 0.0 : 10.0, bottom: personNameArray.length == 0 ? 0.0 : 20.0),
                              child: Wrap(
                                spacing: 8.0,
                                runSpacing: 4.0,
                                runAlignment: WrapAlignment.start,
                                direction: Axis.horizontal,
                                children: personNameArray.length == 0
                                  ? [Container()]
                                  : personNameArray.map((String name) => Chip(
                                      label: Text(name),
                                      onDeleted: () {
                                        setState(() {
                                          personIDArray.removeAt(personNameArray.indexOf(name));
                                          personNameArray.remove(name);
                                        });
                                      },
                                    )).toList(),
                              ),
                            ),
                            showAlert2
                              ? Container(
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                                  child: Text(
                                    'Please select person',
                                    style: TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 12.0,
                                      fontStyle: FontStyle.italic
                                    ),
                                  ),
                                )
                              : Container(),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              padding: EdgeInsets.all(10.0),
                              child: ButtonTheme(
                                minWidth: 50.0,
                                height: 40.0,
                                child: RaisedButton(
                                  elevation: 0.0,
                                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
                                  child: _isProccess
                                    ? Container(
                                        padding: EdgeInsets.symmetric(vertical: 5.0),
                                        child: Center(
                                          child: SizedBox(
                                            height: 20.0,
                                            width: 20.0,
                                            child: CircularProgressIndicator(
                                              valueColor: AlwaysStoppedAnimation(Colors.white),
                                              strokeWidth: 2.0,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Text(
                                        'SEND'
                                      ),
                                  onPressed: () {
                                    if (_formKey.currentState.validate() && personIDArray.length > 0 && personNameArray.length > 0) {
                                      setState(() {
                                        _autoValidate = false;
                                        _isProccess = true;
                                      });
                                      _formKey.currentState.save();

                                      DocumentReference docReference = Firestore.instance.collection('changeMgmt').document();

                                      for (int i = 0; i < personIDArray.length; i++) {
                                        setState(() {
                                          personReviewDate.add(null);
                                          personReviewNote.add(null);
                                          personReviewStatus.add('OPEN');
                                        });
                                      }

                                      docReference.setData({
                                        'userCreated': widget.idUser,
                                        'dateCreated': DateTime.now(),
                                        'changeNo': maxidMgmt,
                                        'tglImplementasi': tglImplementasi,
                                        'prioritas': prioritas,
                                        'category': int.tryParse(selectedCategory.toString()),
                                        'alasan': controllerAlasan.text,
                                        'deskripsi': controllerDeskripsi.text,
                                        'personReview': personIDArray,
                                        'personReviewDate': personReviewDate,
                                        'personReviewNote': personReviewNote,
                                        'personReviewStatus': personReviewStatus,
                                        'approveBy': approveBy,
                                        'approveDate': null,
                                        'approveNote': null,
                                        'statusApprove': false,
                                        'finalStatus': 'OPEN',
                                      }).then((doc) {
                                        setState(() {
                                          _isProccess = false;
                                        });

                                        DocumentReference documentReference = Firestore.instance.collection('dumper_changeMgmt').document(indexMgmt);

                                        documentReference.updateData({
                                          'maxid_mgmt':maxidMgmt
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
                                                        'Data Saved',
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
                                      setState(() {
                                        _autoValidate = true;
                                        showAlert = true;
                                        showAlert2 = true;
                                      });
                                    }
                                  },
                                  textColor: Colors.white,
                                  color: AbubaPallate.greenabuba,
                                ),
                              )
                            ),
                          ],
                        );
                    },
                  )
                ],
              ),
            ),
          )
        )
      ),
    );
  }
}