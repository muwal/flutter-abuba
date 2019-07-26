import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/isoft/hrd_page/perbaikan/working_order.dart';
import 'package:intl/intl.dart';

class DetailWorkingOrder extends StatefulWidget {
  DetailWorkingOrder({this.idUser, this.namaUser, this.departmentUser, this.index});

  final int idUser;
  final String namaUser;
  final String departmentUser;
  var index;

  @override
  _DetailWorkingOrderState createState() => _DetailWorkingOrderState();
}

class _DetailWorkingOrderState extends State<DetailWorkingOrder> with TickerProviderStateMixin {
  AnimationController animationController;

  Timestamp tanggal;
  int no;
  String nama;
  String category;
  String area;
  String lokasi;
  String item;
  String masalah;
  String detailMasalah;
  String pic;
  String identitasNo;
  bool showNote = false;
  String statusPerbaikan;
  String status;
  DateTime dueDate;
  final dateFormat = DateFormat("MMMM d, yyyy");
  String departmentCreated;

  bool isProcess = false;

  List<dynamic> data2 = [];
  List<dynamic> data3 = [];

  @override
  void initState() {
    super.initState();
    
    Firestore.instance.collection('perbaikan').document(widget.index).snapshots().listen((data) {
      setState(() {
        no = data.data['perbaikanNo'];
        tanggal = data.data['dateCreated'];
        detailMasalah = data.data['detailMasalah'];
        statusPerbaikan = data.data['statusPerbaikan'];
        status = data.data['status'];

        Firestore.instance.collection('user').where('id', isEqualTo: data.data['userCreated']).snapshots().listen((data2) {
          nama = data2.documents[0].data['nama'];
          Firestore.instance.collection('department').where('id', isEqualTo: data2.documents[0].data['departmentID']).snapshots().listen((dataDepartment) {
            departmentCreated = dataDepartment.documents[0].data['department'];
          });
        });

        Firestore.instance.collection('perbaikanMasalah').where('id', isEqualTo: data.data['masalah']).snapshots().listen((data3) {
          masalah = data3.documents[0].data['masalah'];
        });

        Firestore.instance.collection('lokasi').where('id', isEqualTo: data.data['lokasi']).snapshots().listen((data4) {
          lokasi = data4.documents[0].data['lokasi'];
        });

        Firestore.instance.collection('outlet').where('id', isEqualTo: data.data['area']).snapshots().listen((data7) {
          area = data7.documents[0].data['nama_outlet'];
        });

        Firestore.instance.collection('perbaikanCategory').where('id', isEqualTo: data.data['category']).snapshots().listen((data5) {
          category = data5.documents[0].data['category'];
        });

        Firestore.instance.collection('maintenance_item').where('id', isEqualTo: data.data['item']).snapshots().listen((data6) {
          item = data6.documents[0].data['item'];
          identitasNo = data6.documents[0].data['kode'];
        });
      });
    });

    CollectionReference reference = Firestore.instance.collection('user');
      reference.snapshots().listen((data) {
        data.documentChanges.forEach((change) {
          setState(() {
            if (change.document.data['departmentID'] == 1 || change.document.data['departmentID'] == 3) {
              data2.add(change.document.data['nama']);
              data3.add(change.document.data['id']);
            }
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

  @override
  Widget build(BuildContext context) {
    final double size = MediaQuery.of(context).size.width;

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
          child: _bodyForm(size),
        ),
      ),
    );
  }

  Widget _bodyForm(double size) {
    return Scrollbar(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Perbaikan',
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
                    'Detail Working Order',
                    style: TextStyle(
                        color: AbubaPallate.greenabuba, fontSize: 12.0),
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
                      child:CircularProgressIndicator()
                    ),
                  )
                : Container(
                    color: Colors.white,
                    padding: EdgeInsets.only(bottom: 5.0, top: 20.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Data Permintaan',
                                        style: TextStyle(
                                          fontSize: 15.0, color: Colors.black87, fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        '# Report',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        no.toString().padLeft(4, '0'),
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Tgl Permintaan',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        tanggal.toDate().toString().substring(8, 10) + '/' + tanggal.toDate().toString().substring(5, 7) + '/' + tanggal.toDate().toString().substring(0, 4),
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Dibuat Oleh',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        nama,
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Department',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        departmentCreated,
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 5.0),
                          child: Divider(
                            height: 5.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Data Asset',
                                        style: TextStyle(
                                          fontSize: 15.0, color: Colors.black87, fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Area',
                                        style: TextStyle(
                                            fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        area,
                                        style: TextStyle(
                                            fontSize: 13.0,
                                            color: Colors.black38,
                                            fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Asset',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        item,
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Nomor',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        identitasNo,
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Lokasi',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        lokasi,
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 5.0),
                          child: Divider(
                            height: 5.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Data Masalah',
                                        style: TextStyle(
                                          fontSize: 15.0, color: Colors.black87, fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Kategori Masalah',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        category,
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Masalah',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        masalah,
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Detail Masalah',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        detailMasalah,
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                        ),
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                              labelText: 'PIC',
                              labelStyle: TextStyle(fontSize: 12.0),
                            ),
                            validator: (value) {
                              if (value == null) {
                                return 'Please select PIC';
                              } else {
                                return null;
                              }
                            },
                            value: pic,
                            onChanged: (String value) {
                              setState(() {
                                pic = value;
                                });
                            },
                            items: List.generate(data2.length, (index) {
                              return DropdownMenuItem(
                                value: data3[index].toString(),
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: RichText(
                                    overflow: TextOverflow.visible,
                                    text: TextSpan(
                                      text: data2[index].toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12.0
                                      )
                                    ),
                                  ),
                                ),
                              );
                            }).toList()
                          )
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          padding: const EdgeInsets.fromLTRB(0.0, 20.0, 10.0, 20.0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.black54),
                            ),
                          ),
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () async {
                              final DateTime picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2019, 1),
                                lastDate: DateTime(2101)
                              );
                              if (picked != null && picked != dueDate)
                                setState(() {
                                  dueDate = picked;
                                });
                            },
                            child: Text(
                              dueDate == null ? 'Due Date' : dueDate.toString().substring(8, 10) + '/' + dueDate.toString().substring(5, 7) + '/' + dueDate.toString().substring(0, 4),
                              style: TextStyle(
                                color: Colors.black87
                              ),
                            ),
                          )
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                          child: ButtonTheme(
                            minWidth: 50.0,
                            height: 40.0,
                            child: RaisedButton(
                              elevation: 0.0,
                              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
                              textColor: Colors.white,
                              color: AbubaPallate.greenabuba,
                              child: isProcess
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
                                    'SAVE'
                                  ),
                              onPressed: () {
                                if (pic != null && dueDate != null) {
                                  setState(() {
                                    isProcess = true;
                                  });

                                  DocumentReference docReference = Firestore.instance.collection('perbaikan').document(widget.index);
                                  
                                  docReference.updateData({
                                    'pic': int.tryParse(pic),
                                    'dueDate': dueDate,
                                    'status': 'OPEN',
                                    'statusPerbaikan': 'OPEN'
                                  }).then((doc) {
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
                                                  'Perbaikan No. PRB-${no.toString().padLeft(4, '0')}',
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
                                      Navigator.pushReplacement(context,
                                        MaterialPageRoute(
                                          builder: (_) => WorkingOrder(departmentUser: widget.departmentUser, idUser: widget.idUser, namaUser: widget.namaUser)
                                        )
                                      );
                                    });
                                  }).catchError((error) {
                                    print(error);
                                  });
                                } else {
                                  setState(() {
                                  isProcess = false;
                                  });
                                }
                              },
                            ),
                          )
                        )
                      ],
                    )
                  );
            },
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
//        itemCount: 10,
      ),
    );
  }
}
