import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';

import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:intl/intl.dart';

class FormKitchen extends StatefulWidget {
  @override
  _FormKitchenState createState() => _FormKitchenState();
}

class _FormKitchenState extends State<FormKitchen> {
  var ratingChiller = 0.0;
  var ratingFreezer = 0.0;
  var ratingVentilasi = 0.0;
  var ratingGrasetrap = 0.0;

  bool noteratingChiller = false;
  bool noteratingFreezer = false;
  bool noteratingVentilasi = false;
  bool noteratingGrasetrap = false;

  void _showDialogChiller() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Alert Dialog title"),
          content: new Text("Alert Dialog body"),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                'OK',
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AbubaAppBar(),
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: _buildFormMenu()),
      ),
    );
  }

  Widget _buildFormMenu() {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'BOH Daily Checklist',
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
                  'Kitchen',
                  style:
                      TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 42.0,
                child: Container(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Upright Chiller',
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.0),
                            textAlign: TextAlign.start,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 87.0),
                            child: ButtonTheme(
                              minWidth: 30.0,
                              height: 25.0,
                              child: OutlineButton(
                                child: Text(
                                  'NOTE',
                                  style: TextStyle(
                                      fontSize: 10.0, color: Colors.white),
                                ),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1.0),
                                highlightedBorderColor: Colors.white,
                                onPressed: () {
                                  setState(() {
                                    noteratingChiller = !noteratingChiller;
                                  });
                                },
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _showDialogChiller();
                            },
                            child: Text(
                              'STD',
                              style: TextStyle(
                                  color: AbubaPallate.yellow, fontSize: 12.0),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(color: Color(0xFF2F592F))),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Equipment',
                      style: TextStyle(color: Colors.grey, fontSize: 12.0),
                    ),
                    SmoothStarRating(
                      allowHalfRating: false,
                      onRatingChanged: (v) {
                        ratingChiller = v;
                        setState(() {});
                      },
                      starCount: 5,
                      rating: ratingChiller,
                      size: 30.0,
                      color: Colors.orangeAccent,
                      borderColor: Colors.grey,
                    ),
                  ],
                ),
              ),
              noteratingChiller
                  ? Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: TextField(
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                          maxLines: 3,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 42.0,
                child: Container(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Cheesse Freezer',
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.0),
                            textAlign: TextAlign.start,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 70.0),
                            child: ButtonTheme(
                              minWidth: 30.0,
                              height: 25.0,
                              child: OutlineButton(
                                child: Text(
                                  'NOTE',
                                  style: TextStyle(
                                      fontSize: 10.0, color: Colors.white),
                                ),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1.0),
                                highlightedBorderColor: Colors.white,
                                onPressed: () {
                                  setState(() {
                                    noteratingFreezer = !noteratingFreezer;
                                  });
                                },
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'STD',
                              style: TextStyle(
                                  color: AbubaPallate.yellow, fontSize: 12.0),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(color: Color(0xFF2F592F))),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Equipment',
                      style: TextStyle(color: Colors.grey, fontSize: 12.0),
                    ),
                    SmoothStarRating(
                      allowHalfRating: false,
                      onRatingChanged: (v) {
                        ratingFreezer = v;
                        setState(() {});
                      },
                      starCount: 5,
                      rating: ratingFreezer,
                      size: 30.0,
                      color: Colors.orangeAccent,
                      borderColor: Colors.grey,
                    ),
                  ],
                ),
              ),
              noteratingFreezer
                  ? Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: TextField(
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                          maxLines: 3,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 42.0,
                child: Container(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Ventilasi',
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.0),
                            textAlign: TextAlign.start,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 120.0),
                            child: ButtonTheme(
                              minWidth: 30.0,
                              height: 25.0,
                              child: OutlineButton(
                                child: Text(
                                  'NOTE',
                                  style: TextStyle(
                                      fontSize: 10.0, color: Colors.white),
                                ),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1.0),
                                highlightedBorderColor: Colors.white,
                                onPressed: () {
                                  setState(() {
                                    noteratingVentilasi = !noteratingVentilasi;
                                  });
                                },
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'STD',
                              style: TextStyle(
                                  color: AbubaPallate.yellow, fontSize: 12.0),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(color: Color(0xFF2F592F))),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Hiasan',
                      style: TextStyle(color: Colors.grey, fontSize: 12.0),
                    ),
                    SmoothStarRating(
                      allowHalfRating: false,
                      onRatingChanged: (v) {
                        ratingVentilasi = v;
                        setState(() {});
                      },
                      starCount: 5,
                      rating: ratingVentilasi,
                      size: 30.0,
                      color: Colors.orangeAccent,
                      borderColor: Colors.grey,
                    ),
                  ],
                ),
              ),
              noteratingVentilasi
                  ? Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: TextField(
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                          maxLines: 3,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 42.0,
                child: Container(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Grasetrap',
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.0),
                            textAlign: TextAlign.start,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 110.0),
                            child: ButtonTheme(
                              minWidth: 30.0,
                              height: 25.0,
                              child: OutlineButton(
                                child: Text(
                                  'NOTE',
                                  style: TextStyle(
                                      fontSize: 10.0, color: Colors.white),
                                ),
                                borderSide:
                                    BorderSide(color: Colors.white, width: 1.0),
                                highlightedBorderColor: Colors.white,
                                onPressed: () {
                                  setState(() {
                                    noteratingGrasetrap = !noteratingGrasetrap;
                                  });
                                },
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'STD',
                              style: TextStyle(
                                  color: AbubaPallate.yellow, fontSize: 12.0),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(color: Color(0xFF2F592F))),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Greasetrap',
                      style: TextStyle(color: Colors.grey, fontSize: 12.0),
                    ),
                    SmoothStarRating(
                      allowHalfRating: false,
                      onRatingChanged: (v) {
                        ratingGrasetrap = v;
                        setState(() {});
                      },
                      starCount: 5,
                      rating: ratingGrasetrap,
                      size: 30.0,
                      color: Colors.orangeAccent,
                      borderColor: Colors.grey,
                    ),
                  ],
                ),
              ),
              noteratingGrasetrap
                  ? Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: TextField(
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                          maxLines: 3,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(
                height: 5.0,
              ),
              ButtonTheme(
                minWidth: 50.0,
                height: 30.0,
                child: RaisedButton(
                  child: Text(
                    'SAVE',
                    style: TextStyle(fontSize: 13.0),
                  ),
                  textColor: Colors.white,
                  color: Colors.green,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
