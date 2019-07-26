import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/beranda/beranda_view.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class FormCreateHappening extends StatefulWidget {
  final int idUser;
  FormCreateHappening({this.idUser});
  
  @override
  _FormCreateHappeningState createState() => new _FormCreateHappeningState();
}

class _FormCreateHappeningState extends State<FormCreateHappening> {
  File imageWhatsHappening;
  String filenameWhatsHappening;
  String imageSave = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  String _title;
  String _deskripsi;
  var selectedImage;
  bool _isProccess = false;

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
          child: _buildCreate(width, context),
        ),
      ),
    );
  }

  Widget _buildCreate(double width, context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'What\'s New',
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
        Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                child: Container(
                  width: width,
                  child: TextFormField(
                    maxLength: 50,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle: TextStyle(fontSize: 12.0),
                      hintText: 'Title',
                      hintStyle: TextStyle(fontSize: 12.0),
                    ),
                    validator: (value) {
                      if (value.length < 5) {
                        return 'Title must be more than 5 character';
                      } else if (value.length > 50) {
                        return 'Title must be less than 50 character';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      _title = value;
                    },
                    textCapitalization: TextCapitalization.sentences,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                child: Container(
                  width: width,
                  child: TextFormField(
                    maxLines: 3,
                    maxLength: 250,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: TextStyle(fontSize: 12.0),
                      hintText: 'Description',
                      hintStyle: TextStyle(fontSize: 12.0),
                    ),
                    validator: (value) {
                      if (value.length < 10) {
                        return 'Description must be more than 10 character';
                      } else if (value.length > 250) {
                        return 'Description must be less than 250 character';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      _deskripsi = value;
                    },
                    textCapitalization: TextCapitalization.sentences,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
                child: GestureDetector(
                  onTap: () async {
                    selectedImage = await ImagePicker.pickImage(source: ImageSource.gallery);
                    setState(() {
                      imageWhatsHappening = selectedImage;
                    });
                  },
                  child: Container(
                    width: width - 33,
                    height: 150.0,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.black45)
                    ),
                    child: imageWhatsHappening == null
                      ? Icon(Icons.image, color: Colors.black45, size: 40.0)
                      : Image.file(imageWhatsHappening)
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
          child: ButtonTheme(
            minWidth: 50.0,
            height: 40.0,
            child: RaisedButton(
              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
              child: _isProccess
                ? CircularProgressIndicator()
                : Text(
                    'UMUMKAN',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.white
                    ),
                  ),
              elevation: 0.0,
              color: _isProccess ? Colors.transparent : Colors.green[500],
              onPressed: () async {
                if (_formKey.currentState.validate() && imageWhatsHappening != null) {
                  setState(() {
                    _isProccess = true;
                  });
                  _formKey.currentState.save();
                  
                  filenameWhatsHappening = basename(imageWhatsHappening.path);

                  StorageReference strRef = FirebaseStorage.instance.ref().child(filenameWhatsHappening);
                  StorageUploadTask uploadTask = strRef.putFile(imageWhatsHappening);

                  var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
                  setState(() {
                    imageSave = downUrl.toString();
                  });

                  DocumentReference docReference = Firestore.instance.collection('whats-happening').document();

                  docReference.setData({
                    'userCreated': widget.idUser,
                    'title': _title,
                    'description': _deskripsi,
                    'dateCreated': DateTime.now(),
                    'image': imageSave,
                    'comments': [],
                    'likes': []
                  }).then((doc) {
                    setState(() {
                      _isProccess = false;
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
                                  'Data Successfully Saved',
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
                  });
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}