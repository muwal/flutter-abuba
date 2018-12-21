import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';

import 'package:smooth_star_rating/smooth_star_rating.dart';

class FormJadwalStart extends StatefulWidget {
  @override
  _FormJadwalStartState createState() => _FormJadwalStartState();
}

class _FormJadwalStartState extends State<FormJadwalStart> {
  final _scaffoldState = GlobalKey<ScaffoldState>();
  bool _note = false;
  bool _notedua = false;

  var ratingGrooming = 0.0;
  double rating = 0.0;
  double ratingdua = 0.0;

  TextEditingController controllerNoteSatu = new TextEditingController();
  TextEditingController controllerNoteDua = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _scaffoldState,
        appBar: AbubaAppBar(),
        body: _buildStartMenu(),
      ),
    );
  }

  Widget _buildStartMenu() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Jadwal Audit',
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
                      'Start',
                      style: TextStyle(
                          color: AbubaPallate.greenabuba, fontSize: 12.0),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: 100.0,
                    height: 35.0,
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Process',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12.0),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFF2F592F),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100.0,
                    height: 35.0,
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Auditor',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12.0),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFF2F592F),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100.0,
                    height: 35.0,
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Auditee',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12.0),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFF2F592F),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      'HRD',
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 100.0,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Payroll',
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 100.0,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Bryan',
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 100.0,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Ridwan',
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 100.0,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            '17/09/2019',
                            style: TextStyle(color: Colors.grey[400]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 100.0,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            '',
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 100.0,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Yani',
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                      child: Text(
                    '1. Training analisis dibuat sesuai job description',
                    style: TextStyle(color: Colors.black54, fontSize: 12.0),
                  )),
                  ButtonTheme(
                    minWidth: 30.0,
                    height: 25.0,
                    child: RaisedButton(
                      color: AbubaPallate.menuBluebird,
                      child: Text(
                        'Note',
                        style: TextStyle(fontSize: 12.0, color: Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          _note = !_note;
                        });
                      },
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
                  StarRating(
                    rating: rating,
                    onRatingChanged: (rating) =>
                        setState(() => this.rating = rating),
                  )
                ],
              ),
            ),
            _note
                ? Container(
                    padding: const EdgeInsets.only(
                        right: 20.0, left: 20.0, top: 10.0),
                    width: 300.0,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Note',
                        hintStyle: TextStyle(
                          fontSize: 12.0
                        )
                      ),
                      controller: controllerNoteSatu,
                      maxLines: 3,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  )
                : Container(),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                      child: Text(
                    '2. Setelah training, dilakukan evaluasi',
                    style: TextStyle(color: Colors.black54, fontSize: 12.0),
                  )),
                  ButtonTheme(
                    minWidth: 30.0,
                    height: 25.0,
                    child: RaisedButton(
                      color: AbubaPallate.menuBluebird,
                      child: Text(
                        'Note',
                        style: TextStyle(fontSize: 12.0, color: Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          _notedua = !_notedua;
                        });
                      },
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
                  StarRating(
                    rating: ratingdua,
                    onRatingChanged: (rating) =>
                        setState(() => this.ratingdua = rating),
                  )
                ],
              ),
            ),
            _notedua
                ? Container(
                    padding: const EdgeInsets.only(
                        right: 20.0, left: 20.0, top: 10.0),
                    width: 300.0,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Note',
                        hintStyle: TextStyle(
                          fontSize: 12.0
                        )
                      ),
                      maxLines: 3,
                      controller: controllerNoteDua,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  )
                : Container()
          ],
        ),
         ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    width: 100.0,
                    margin: const EdgeInsets.only(right: 10.0),
                    decoration: new BoxDecoration(
                        border: new Border.all(color: Colors.grey)),
                    child: new Text(
                      "80 of 100",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    width: 100.0,
                    decoration: new BoxDecoration(
                        border: new Border.all(color: Colors.grey)),
                    child: new Text("3", textAlign: TextAlign.center),
                  ),
                ],
              ),
              ButtonTheme(
                minWidth: 30.0,
                height: 28.0,
                child: OutlineButton(
                  color: AbubaPallate.menuBluebird,
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        fontSize: 12.0, color: AbubaPallate.greenabuba),
                  ),
                  borderSide: BorderSide(color: AbubaPallate.greenabuba),
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

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final RatingChangeCallback onRatingChanged;
  final Color color;

  StarRating(
      {this.starCount = 5, this.rating = .0, this.onRatingChanged, this.color});

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = new Icon(
        MdiIcons.circleOutline,
        color: Theme.of(context).buttonColor,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = new Icon(
        MdiIcons.circleSlice4,
        color: color ?? Theme.of(context).primaryColor,
      );
    } else {
      icon = new Icon(
        MdiIcons.circleSlice8,
        color: color ?? Theme.of(context).primaryColor,
      );
    }
    return new InkResponse(
      onTap:
          onRatingChanged == null ? null : () => onRatingChanged(index + 1.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
        children:
            new List.generate(starCount, (index) => buildStar(context, index)));
  }
}
