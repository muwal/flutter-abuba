import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class RDcreate extends StatefulWidget {
  final int idUser;
  
  RDcreate({Key key, this.idUser}) : super(key: key);
  _RDcreateState createState() => _RDcreateState();
}

class _RDcreateState extends State<RDcreate>{
  TabController _tabController;
  bool _isProccess = false;

  String documentID;
  int maxID;

  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime dateEksperimen;

  var maxidMeeting;
  var indexMeeting;
  String _mySelection;

  List<int> parameterID = [];
  List<String> parameterName = [];
  String _parameterSelection;
  String _parameterSelection2;

  List<int> whoID = [];
  List<String> whoName = [];
  String _whoSelection;
  String _whoSelection2;

  List<double> scoreParameter = [];
  List<String> statusApprove = [];
  List<DateTime> dateApprove = [];
  List<String> note = [];

  String _produk_;
  String _kategori_;
  TextEditingController _komposisi_ = new TextEditingController();
  TextEditingController _tujuan_ = new TextEditingController();
  
  List<String> _dataKomposisi_ = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firestore.instance.collection('dumper_eksperimen').snapshots().listen((data) {
      documentID = data.documents[0].documentID;
      maxID = data.documents[0].data['maxid_eksperimen'];
    });
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
        body: _buildFormRisk(width)
      ),
    );
  }

  Widget _buildFormRisk(double width) {
    return Scrollbar(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'R&D',
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
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 5.0, right: 5.0),
            child: ListTile(
              title: Container(
                width: 250,
                child: StreamBuilder(
                  stream: Firestore.instance.collection('product_complaint-mg').orderBy('product', descending: false).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData)
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );

                    return DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Produk',
                        labelStyle: TextStyle(fontSize: 14.0),
                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select Produk';
                        } else {
                          return null;
                        }
                      },
                      value: _produk_,
                      onChanged: (String value) {
                        setState(() {
                          _produk_ = value;
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
                                text: document['product'].toString(),
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
              trailing: Container(
                width: 50.0,
                child: IconButton(
                  icon: Icon(Icons.add),
                  color: Colors.transparent,
                  onPressed: () {},
                )
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 5.0, right: 5.0),
            child: ListTile(
              title: Container(
                width: 250,
                child: TextFormField(
                  textCapitalization:
                  TextCapitalization.words,
                  decoration: InputDecoration(
                    border:
                    UnderlineInputBorder(),
                    labelText: 'Komposisi',
                    labelStyle:
                    TextStyle(fontSize: 14.0),
                    hintText: 'Komposisi',
                  ),
                  controller: _komposisi_,
                  style: TextStyle(
                      fontStyle: FontStyle.normal,
                      color: Colors.black87,
                      fontSize: 14.0),
                  onSaved: null,
                ),
              ),
              trailing: Container(
                width: 50.0,
                child: IconButton(
                  icon: Icon(Icons.add),
                  color: AbubaPallate.greenabuba,
                  onPressed: () {

                    setState(() {
                      _dataKomposisi_.add(_komposisi_.text);
                      _komposisi_.text = '';
                    });

                  },
                )
              )
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 15.0, right: 10.0, top: _dataKomposisi_.length == 0 ? 0.0 : 10.0, bottom: _dataKomposisi_.length == 0 ? 0.0 : 20.0),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              runAlignment: WrapAlignment.start,
              direction: Axis.horizontal,
              children: _dataKomposisi_.length == 0
                ? [Container()]
                : _dataKomposisi_.map((String name) => Chip(
                    label: Text(name),
                    onDeleted: () {
                      setState(() {
                        _dataKomposisi_.removeAt(_dataKomposisi_.indexOf(name));
                        _dataKomposisi_.remove(name);
                      });
                    },
                  )).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 5.0, right: 5.0),
            child: ListTile(
              title: Container(
                width: 250,
                child: DateTimePickerFormField(
                  format: dateFormat,
                  onChanged: (dt) => setState(() => dateEksperimen = dt),
                  dateOnly: true,
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelStyle: TextStyle(fontSize: 14.0),
                    labelText: 'Date Experiment'
                  ),
                ),
              ),
              trailing: Container(
                width: 50.0,
                child: IconButton(
                  icon: Icon(Icons.add),
                  color: Colors.transparent,
                  onPressed: () {},
                )
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 5.0, right: 5.0),
            child: ListTile(
              title: Container(
                width: 250,
                child: StreamBuilder(
                  stream: Firestore.instance.collection('rnd_eksperimen_category').orderBy('category', descending: false).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData)
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );

                    return DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Category Experiment',
                        labelStyle: TextStyle(fontSize: 14.0),
                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select Category Experiment';
                        } else {
                          return null;
                        }
                      },
                      value: _kategori_,
                      onChanged: (String value) {
                        setState(() {
                          _kategori_ = value;
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
                                text: document['category'].toString(),
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
              trailing: Container(
                width: 50.0,
                child: IconButton(
                  icon: Icon(Icons.add),
                  color: Colors.transparent,
                  onPressed: () {},
                )
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 5.0, right: 5.0),
            child: ListTile(
              title: Container(
                width: 250,
                child: TextFormField(
                  textCapitalization:
                  TextCapitalization.words,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Tujuan Experiment',
                    labelStyle: TextStyle(fontSize: 14.0),
                  ),
                  controller: _tujuan_,
                  style: TextStyle(
                      fontStyle: FontStyle.normal,
                      color: Colors.black87,
                      fontSize: 14.0),
                  onSaved: null,
                ),
              ),
              trailing: Container(
                width: 50.0,
                child: IconButton(
                  icon: Icon(Icons.add),
                  color: Colors.transparent,
                  onPressed: () {},
                )
              )
            ),
          ),
           ListTile(
            title: Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: StreamBuilder(
                stream: Firestore.instance.collection('rnd_parameter').orderBy('parameter', descending: false).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData)
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );

                  return DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Parameter',
                      labelStyle: TextStyle(fontSize: 12.0),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select parameter';
                      } else {
                        return null;
                      }
                    },
                    value: _parameterSelection,
                    onChanged: (String value) {
                      Firestore.instance.collection('rnd_parameter').where('id', isEqualTo: int.tryParse(value)).snapshots().listen((data) {
                        setState(() {
                          _parameterSelection2 = data.documents[0].data['parameter'];
                          _parameterSelection = value;
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
                              text: document['parameter'].toString(),
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
            trailing: IconButton(
              icon: Icon(Icons.add, color: AbubaPallate.greenabuba),
              onPressed: () {
                setState(() {
                  if (parameterID.contains(int.tryParse(_parameterSelection))) {

                  } else {
                    parameterID.add(int.tryParse(_parameterSelection));
                  }
                  if (parameterName.contains(_parameterSelection2)) {

                  } else {
                    parameterName.add(_parameterSelection2);
                  }
                });
              },
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 15.0, right: 10.0, top: parameterName.length == 0 ? 0.0 : 10.0, bottom: parameterName.length == 0 ? 0.0 : 20.0),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              runAlignment: WrapAlignment.start,
              direction: Axis.horizontal,
              children: parameterName.length == 0
                ? [Container()]
                : parameterName.map((String name) => Chip(
                    label: Text(name),
                    onDeleted: () {
                      setState(() {
                        parameterID.removeAt(parameterName.indexOf(name));
                        parameterName.remove(name);
                      });
                    },
                  )).toList(),
            ),
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
                      labelText: 'Kirim Kepada',
                      labelStyle: TextStyle(fontSize: 12.0),
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

          Padding(
            padding: EdgeInsets.only(top: 20.0, left: 60.0, right: 60.0, bottom: 20.0),
            child: RaisedButton(
              child: _isProccess
                ? Container(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: Center(
                      child: SizedBox(
                        height: 15.0,
                        width: 15.0,
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
                setState(() {
                  _isProccess = true;
                });
                DocumentReference documentReference2 = Firestore.instance.collection('dumper_eksperimen').document(documentID);

                documentReference2.updateData({
                  'maxid_eksperimen': maxID + 1
                }).then((doc2) {
                  print('success');
                  setState(() {
                    _isProccess = false;
                  });
                }).catchError((error2) {
                  print(error2);
                });

                for(int q = 0; q < whoID.length; q++) {
                  setState(() {
                    statusApprove.add('OPEN');
                    dateApprove.add(null);
                    note.add(null);
                    scoreParameter.add(0.0);
                  });
                }

                DocumentReference documentReference = Firestore.instance.collection('rnd_eksperimen').document();
    
                documentReference.setData({
                  'id': maxID + 1,
                  'id_product': int.tryParse(_produk_),
                  'komposisi': _dataKomposisi_,
                  'id_eksperimen_category': int.tryParse(_kategori_),
                  'date_eksperimen': dateEksperimen,
                  'tujuan': _tujuan_.text,
                  'id_parameter': parameterID,
                  'kirim_kepada': whoID,
                  'status': 'OPEN',
                  'userCreated': widget.idUser,
                  'dateCreated': DateTime.now(),
                  'scoreParameter': scoreParameter,
                  'status': statusApprove,
                  'approveDate': dateApprove,
                  'catatan': note
                }).then((doc2) {
                  print('success');
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
                                  'NOTIFICATION',
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
                                'Data Saved Successfully',
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
              },
              textColor: Colors.white,
              color: Colors.green,
            )
          ),
        ],
      ),
    );
  }
}