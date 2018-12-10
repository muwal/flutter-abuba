import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:intl/intl.dart';

class FormLineCheck extends StatefulWidget {
  @override
  _FormLineCheckState createState() => _FormLineCheckState();
}

class _FormLineCheckState extends State<FormLineCheck> {
  var ratingGrooming = 0.0;
  var ratingSeragam = 0.0;
  var ratingAksesoris = 0.0;

  var ratingOperation = 0.0;
  var ratingLSM = 0.0;
  var ratingProgramKerja = 0.0;

  var ratingTukerShift = 0.0;
  var ratingTukarOff = 0.0;

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
                  'Line Check Shifting',
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
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Dinning Area',
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.0),
                            textAlign: TextAlign.start,
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
                    Flexible(
                      child: Text(
                        'AC, Langit-langit, lampu, ventilasi, exhaust',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SmoothStarRating(
                      allowHalfRating: false,
                      onRatingChanged: (v) {
                        ratingGrooming = v;
                        setState(() {});
                      },
                      starCount: 5,
                      rating: ratingGrooming,
                      size: 25.0,
                      color: Colors.orangeAccent,
                      borderColor: Colors.grey,
                    )
                  ],
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Dinding, pintu, jendela, kaca, hiasan dinding',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SmoothStarRating(
                      allowHalfRating: false,
                      onRatingChanged: (v) {
                        ratingSeragam = v;
                        setState(() {});
                      },
                      starCount: 5,
                      rating: ratingSeragam,
                      size: 25.0,
                      color: Colors.orangeAccent,
                      borderColor: Colors.grey,
                    )
                  ],
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Tempat sampah, insect killer',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SmoothStarRating(
                      allowHalfRating: false,
                      onRatingChanged: (v) {
                        ratingAksesoris = v;
                        setState(() {});
                      },
                      starCount: 5,
                      rating: ratingAksesoris,
                      size: 25.0,
                      color: Colors.orangeAccent,
                      borderColor: Colors.grey,
                    )
                  ],
                ),
              ),
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
                            'Bar Tender',
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.0),
                            textAlign: TextAlign.start,
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
                    Flexible(
                      child: Text(
                        'Glassware, silverware, chinaware, cutleries, napkin, container',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SmoothStarRating(
                      allowHalfRating: false,
                      onRatingChanged: (v) {
                        ratingOperation = v;
                        setState(() {});
                      },
                      starCount: 5,
                      rating: ratingOperation,
                      size: 25.0,
                      color: Colors.orangeAccent,
                      borderColor: Colors.grey,
                    )
                  ],
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Water boiler, blender, coffee urn,  igloo, chest freezer, undercounter chiller',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SmoothStarRating(
                      allowHalfRating: false,
                      onRatingChanged: (v) {
                        ratingLSM = v;
                        setState(() {});
                      },
                      starCount: 5,
                      rating: ratingLSM,
                      size: 25.0,
                      color: Colors.orangeAccent,
                      borderColor: Colors.grey,
                    )
                  ],
                ),
              ),
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
