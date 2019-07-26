import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:datetime_picker_formfield/time_picker_formfield.dart';
import 'package:intl/intl.dart';

class FormEvent extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  FormEvent({this.idUser, this.namaUser, this.departmentUser});
  @override
  _FormEventState createState() => _FormEventState();
}

class _FormEventState extends State<FormEvent> {
  String _mySelection;
  String _jenisAcara;
  String _projectSponsorSelection;
  List<Map> _jenisAcaraJson = [
    {"id": 1, "jenis": "Pernikahan"},
    {"id": 2, "jenis": "Ulang tahun"}
  ];

  final timeFormat = DateFormat("h:mm a");
  final dateFormatProduction = DateFormat("MMMM d, yyyy h:mm a");
  DateTime time;

  TextEditingController namaCustomer = new TextEditingController();
  TextEditingController noTelp = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController pack = new TextEditingController();
  TextEditingController catatan = new TextEditingController();
  TextEditingController jumlahOrang = new TextEditingController();


  bool _isProccess = false;
  String documentID;
  String shift;
  int dumperID;
  List<dynamic> tampungJenisAcara = [];
  List<dynamic> tampungShift = [];
  List<dynamic> tampungNamaCustomer = [];
  List<dynamic> tampungNoTelp = [];
  List<dynamic> tampungEmail = [];
  List<dynamic> tampungPack = [];
  List<dynamic> tampungJumlahOrang = [];
  List<dynamic> tampungTanggal = [];
  List<dynamic> tampungCatatan = [];
  List<dynamic> tampungCreatedBy = [];
  
  List<String> textList = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firestore.instance.collection('dumper_event').snapshots().listen((data) {
      documentID = data.documents[0].documentID;
      dumperID = data.documents[0].data['id'];
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
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: _buildFormMenu(width)),
      ),
    );
  }

  Widget _buildFormMenu(double width) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Log Book MOD',
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
                  'Event(s)',
                  style:
                      TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                ),
              ),
            ],
          ),
        ),
        _buildCustomForm(width),
        SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: IconButton(
                  icon: Icon(
                    Icons.add_circle,
                    color: Colors.green,
                    size: 30.0,
                  ),
                  onPressed: () {
                    tampungJenisAcara.add(_mySelection);
                    tampungShift.add(_projectSponsorSelection);
                    tampungNamaCustomer.add(namaCustomer.text);
                    tampungNoTelp.add(noTelp.text);
                    tampungEmail.add(email.text);
                    tampungPack.add(pack.text);
                    tampungJumlahOrang.add(jumlahOrang.text);
                    tampungTanggal.add(time);
                    tampungCatatan.add(catatan.text);
                    tampungCreatedBy.add(widget.idUser);

                    print(tampungJenisAcara);
                    print(tampungShift);
                    print(tampungNamaCustomer);
                    print(tampungNoTelp);
                    print(tampungEmail);
                    print(tampungPack);                        
                    print(tampungJumlahOrang);                        
                    print(tampungTanggal);
                    print(tampungCatatan);
                    print(tampungCreatedBy);
                    // _projectSponsorSelection = '';
                    // _mySelection = "";
                    namaCustomer.text = '';
                    noTelp.text = '';
                    email.text = '';
                    pack.text = '';
                    jumlahOrang.text = '';
                    time = null;
                    catatan.text = ''; 
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 60.0, bottom: 20.0),
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
                        'SAVE'
                      ),
                  onPressed: () {
                    setState(() {
                      _isProccess = true;
                    });
                      
                      DocumentReference documentReference2 = Firestore.instance.collection('dumper_event').document(documentID);

                      documentReference2.updateData({
                        'id': dumperID + 1
                      }).then((doc2) {
                        setState(() {
                          _isProccess = false;
                        });
                        print('success');
                      }).catchError((error2) {
                        print(error2);
                      });

                      DocumentReference documentReference = Firestore.instance.collection('event').document();

                      documentReference.setData({
                        'id': dumperID + 1,
                        'id_shift': int.tryParse(_projectSponsorSelection),
                        'id_jenis_acara': int.tryParse(_mySelection),
                        'nama_customer': namaCustomer.text,
                        'no_telp': noTelp.text,
                        'email': email.text,
                        'pack': int.tryParse(pack.text),
                        'jumlah_orang': int.tryParse(jumlahOrang.text),
                        'waktu': time,
                        'catatan': catatan.text,
                        'created_by': widget.idUser
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
                      print(_isProccess);

                  },
                  textColor: Colors.white,
                  color: Colors.green,
                )
              ),
            ],
          )
        ),
      ],
    );
  }

  Widget _buildCustomForm(double width) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
          child: StreamBuilder(
            stream: Firestore.instance.collection('jenis_acara').orderBy('jenis_acara', descending: false).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData)
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );

              return DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Jenis Acara',
                  labelStyle: TextStyle(fontSize: 16.0),
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Please select Jenis Acara';
                  } else {
                    return null;
                  }
                },
                value: _mySelection,
                onChanged: (String value) {
                  setState(() {
                    _mySelection = value;
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
                          text: document['jenis_acara'].toString(),
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
                    return 'Please select Shift';
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
        Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
          child: TextFormField(
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Nama Customer',
              labelStyle: TextStyle(fontSize: 14.0),
            ),
            controller: namaCustomer,
            style: TextStyle(
              fontStyle: FontStyle.normal,
              color: Colors.black87,
              fontSize: 14.0
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
          child: TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Nomor Telepon',
              labelStyle: TextStyle(fontSize: 14.0),
            ),
            controller: noTelp,
            style: TextStyle(
              fontStyle: FontStyle.normal,
              color: Colors.black87,
              fontSize: 14.0
            ),
          ),
        ),
        Padding(
           padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
            child: TextFormField(
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Email',
                labelStyle: TextStyle(fontSize: 14.0),
              ),
              controller: email,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                fontStyle: FontStyle.normal,
                color: Colors.black87,
                fontSize: 14.0
              ),
            ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: width / 2.5,
                child: TextFormField(
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Pack',
                    labelStyle: TextStyle(fontSize: 14.0),
                  ),
                  controller: pack,
                  style: TextStyle(
                    fontStyle: FontStyle.normal,
                    color: Colors.black87,
                    fontSize: 14.0
                  ),
                ),
              ),
              Container(
                width: width / 2.5,
                child: TextFormField(
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Jumlah Orang',
                    labelStyle: TextStyle(fontSize: 14.0),
                  ),
                  controller: jumlahOrang,
                  style: TextStyle(
                    fontStyle: FontStyle.normal,
                    color: Colors.black87,
                    fontSize: 14.0
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
          child: Row(
            mainAxisAlignment:  MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: width / 1.8,
                child: DateTimePickerFormField(
                  format: dateFormatProduction,
                  onChanged: (dt) => setState(() => time = dt),
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Tanggal',
                    hintStyle: TextStyle(fontSize: 12.0),
                  ),
                  dateOnly: false,
                  editable: false,
                  resetIcon: null,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
          child: TextFormField(
            textCapitalization: TextCapitalization.words,
            maxLines: 3,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Catatan',
              labelStyle: TextStyle(fontSize: 14.0),
            ),
            controller: catatan,
            style: TextStyle(
              fontStyle: FontStyle.normal,
              color: Colors.black87,
              fontSize: 14.0
            ),
          ),
        ),
      ],
    );
  }
}