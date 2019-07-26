import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class FormPerbaikan extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;

  FormPerbaikan({this.idUser, this.namaUser, this.departmentUser});

  @override
  _FormPerbaikanState createState() => _FormPerbaikanState();
}

class _FormPerbaikanState extends State<FormPerbaikan> with SingleTickerProviderStateMixin {
  bool _isProccess = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  var maxidPerbaikan;
  var indexPerbaikan;

  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime dueDate;
  String category;
  String area;
  String lokasi;
  String item;
  String pic;
  String identitasNo;
  String masalah;
  TextEditingController detailMasalah = TextEditingController();

  @override
  void initState() {
    super.initState();
    Firestore.instance.collection('dumper_perbaikan').snapshots().listen((data) {
      setState(() {
        maxidPerbaikan = data.documents[0].data['maxid_perbaikan'] + 1;
        indexPerbaikan = data.documents[0].documentID;
      });
    });
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
    );
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
          child: Form(
            autovalidate: _autoValidate,
            key: _formKey,
            child: ListView(
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
                  padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
                  child: StreamBuilder(
                    stream: Firestore.instance.collection('perbaikanCategory').orderBy('category', descending: false).snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData)
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );

                      return DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Category',
                          labelStyle: TextStyle(fontSize: 12.0),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select category';
                          } else {
                            return null;
                          }
                        },
                        value: category,
                        onChanged: (String value) {
                          setState(() {
                            category = value;
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
                Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
                    child: StreamBuilder(
                      stream: Firestore.instance.collection('outlet').orderBy('nama_outlet', descending: false).snapshots(),
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
                              labelStyle: TextStyle(fontSize: 12.0),
                            ),
                            validator: (value) {
                              if (value == null) {
                                return 'Please select area';
                              } else {
                                return null;
                              }
                            },
                            value: area,
                            onChanged: (String value) {
                              setState(() {
                                area = value;
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
                                        text: document['nama_outlet'].toString(),
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
                  child: StreamBuilder(
                    stream: Firestore.instance.collection('lokasi').orderBy('lokasi', descending: false).snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData)
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );

                      return DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Lokasi',
                          labelStyle: TextStyle(fontSize: 12.0),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select location';
                          } else {
                            return null;
                          }
                        },
                        value: lokasi,
                        onChanged: (String value) {
                          setState(() {
                            lokasi = value;
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
                                  text: document['lokasi'].toString(),
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
                  child: StreamBuilder(
                    stream: Firestore.instance.collection('maintenance_item').orderBy('item', descending: false).snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData)
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );

                      return DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Item',
                          labelStyle: TextStyle(fontSize: 12.0),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select item';
                          } else {
                            return null;
                          }
                        },
                        value: item,
                        onChanged: (String value) {
                          setState(() {
                            item = value;
                            identitasNo = value.split('////')[1];
                          });
                        },
                        items: snapshot.data.documents.map((DocumentSnapshot document) {
                          return DropdownMenuItem(
                            value: document['id'].toString() + '////' + document['kode'].toString(),
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: RichText(
                                overflow: TextOverflow.visible,
                                text: TextSpan(
                                  text: document['item'].toString(),
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
                  child: Stack(
                    alignment: AlignmentDirectional.centerStart,
                    children: <Widget>[
                      Container(
                        color: Colors.grey[200],
                        height: 40.0,
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                softWrap: true,
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                  text: 'No. Identitas',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 5.0),
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                softWrap: true,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.visible,
                                text: TextSpan(
                                  text: identitasNo == null ? '-' : identitasNo,
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    color: Colors.black87
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        alignment: Alignment.centerLeft,
                      )
                    ],
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 10.0),
                //   child: TextFormField(
                //     keyboardType: TextInputType.number,
                //     decoration: InputDecoration(
                //       labelText: 'No. Identitas',
                //       labelStyle: TextStyle(fontSize: 12.0),
                //     ),
                //     validator: (value) {
                //       if (value.length < 1) {
                //         return 'No. Identitas must be more than 10 character';
                //       } else if (value.length > 20) {
                //         return 'No. Identitas must be leses than 250 character';
                //       } else {
                //         return null;
                //       }
                //     },
                //     maxLength: 20,
                //     controller: identitasNo,
                //     style: TextStyle(
                //       color: Colors.black,
                //     ),
                //   ),
                // ),
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
                  padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
                  child: StreamBuilder(
                    stream: Firestore.instance.collection('perbaikanMasalah').orderBy('masalah', descending: false).snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData)
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );

                      return DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Masalah',
                          labelStyle: TextStyle(fontSize: 12.0),
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select masalah';
                          } else {
                            return null;
                          }
                        },
                        value: masalah,
                        onChanged: (String value) {
                          setState(() {
                            masalah = value;
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
                                  text: document['masalah'].toString(),
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
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
                //   child: StreamBuilder(
                //     stream: Firestore.instance.collection('user').orderBy('nama', descending: false).snapshots(),
                //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                //       if (!snapshot.hasData)
                //         return Container(
                //           child: Center(
                //             child: CircularProgressIndicator(),
                //           ),
                //         );

                //       return DropdownButtonFormField<String>(
                //         decoration: InputDecoration(
                //           labelText: 'PIC',
                //           labelStyle: TextStyle(fontSize: 12.0),
                //         ),
                //         validator: (value) {
                //           if (value == null) {
                //             return 'Please select PIC';
                //           } else {
                //             return null;
                //           }
                //         },
                //         value: pic,
                //         onChanged: (String value) {
                //           setState(() {
                //             pic = value;
                //             });
                //         },
                //         items: snapshot.data.documents.map((DocumentSnapshot document) {
                //           return DropdownMenuItem(
                //             value: document['id'].toString(),
                //             child: Padding(
                //               padding: EdgeInsets.all(10.0),
                //               child: RichText(
                //                 overflow: TextOverflow.visible,
                //                 text: TextSpan(
                //                   text: document['nama'].toString(),
                //                   style: TextStyle(
                //                     color: Colors.black,
                //                     fontSize: 12.0
                //                   )
                //                 ),
                //               ),
                //             ),
                //           );
                //         }).toList()
                //       );
                //     },
                //   )
                // ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 10.0),
                //   child: DateTimePickerFormField(
                //     format: dateFormat,
                //     onChanged: (dt) => setState(() => dueDate = dt),
                //     dateOnly: true,
                //     editable: false,
                //     resetIcon: null,
                //     validator: (value) {
                //       if (value == null) {
                //         return 'Please select due date';
                //       } else {
                //         return null;
                //       }
                //     },
                //     style: TextStyle(fontSize: 14.0, color: Colors.black),
                //     decoration: InputDecoration(
                //       border: UnderlineInputBorder(),
                //       labelStyle: TextStyle(fontSize: 12.0),
                //       labelText: 'Due Date'
                //     ),
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                  child: ButtonTheme(
                    minWidth: 50.0,
                    height: 40.0,
                    child: RaisedButton(
                      elevation: 0.0,
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
                      textColor: Colors.white,
                      color: AbubaPallate.greenabuba,
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
                          'SUBMIT'
                        ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            _autoValidate = false;
                            _isProccess = true;
                          });

                          _formKey.currentState.save();

                          DocumentReference docReference = Firestore.instance.collection('perbaikan').document();
                          
                          docReference.setData({
                            'userCreated': widget.idUser,
                            'dateCreated': DateTime.now(),
                            'perbaikanNo': maxidPerbaikan,
                            'category': int.tryParse(category),
                            'area': int.tryParse(area),
                            'lokasi': int.tryParse(lokasi),
                            'item': int.tryParse(item.split('////')[0]),
                            'masalah': int.tryParse(masalah),
                            'detailMasalah': detailMasalah.text,
                            // 'pic': int.tryParse(pic),
                            // 'dueDate': dueDate,
                            'status': 'OPEN',
                            'userVerifikasi': widget.idUser,
                            'dateVerifikasi': null,
                            'datePerbaikan': null,
                            'rating': 0,
                            'notePerbaikan': null,
                            'statusPerbaikan': 'OPEN'
                          }).then((doc) {
                            setState(() {
                              _isProccess = false;
                            });

                            DocumentReference documentReference =Firestore.instance.collection('dumper_perbaikan').document(indexPerbaikan);

                            documentReference.updateData({
                              'maxid_perbaikan':maxidPerbaikan
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
                          }).catchError((error) {
                            print(error);
                          });
                        } else {
                          setState(() {
                           _autoValidate = true;
                           _isProccess = false;
                          });
                        }
                      },
                    ),
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
