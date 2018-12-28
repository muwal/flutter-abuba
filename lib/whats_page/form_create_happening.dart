import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:image_picker/image_picker.dart';

class FormCreateHappening extends StatefulWidget {
  @override
  _FormCreateHappeningState createState() => new _FormCreateHappeningState();
}

class _FormCreateHappeningState extends State<FormCreateHappening> {
  File _image;
  Future getImage() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = imageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AbubaAppBar(),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: _buildCreate(width),
        ),
      ),
    );
  }

  Widget _buildCreate(double width) {
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
                  'Pengumuman',
                  style:
                  TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: Text(
                  'Create New',
                  style: TextStyle(color: AbubaPallate.green),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          child: Container(
            width: width,
            child: TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(fontSize: 12.0),
                hintText: 'Title',
                hintStyle: TextStyle(fontSize: 12.0),
              ),
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
            child: TextField(
              maxLines: 3,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(fontSize: 12.0),
                hintText: 'Description',
                hintStyle: TextStyle(fontSize: 12.0),
              ),
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
            onTap: getImage,
            child: Container(
              width: width - 33,
              height: 150.0,
              decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Colors.black45)
              ),
              child: _image == null
                  ? Icon(Icons.image, color: Colors.black45, size: 40.0)
                  : Image.file(_image),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
          child: Container(
            alignment: Alignment.centerRight,
            child: ButtonTheme(
              height: 30.0,
              child: OutlineButton(
                child: Text(
                  'Umumkan',
                  style: TextStyle(
                      color: Colors.green[500]
                  ),
                ),
                borderSide: BorderSide(
                    color: Colors.green[500],
                    width: 1.0),
                highlightedBorderColor: Colors.green[500],
                onPressed: () {},
              ),
            ),
          ),
        ),
      ],
    );
  }
}