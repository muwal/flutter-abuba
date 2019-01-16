import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';

import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FormAuditReport extends StatefulWidget {
  @override
  _FormAuditReportState createState() => _FormAuditReportState();
}

class _FormAuditReportState extends State<FormAuditReport> {
  bool _note = false;
  double rating = 0.0;

  var ratingGrooming = 0.0;

  TextEditingController controllerNoteSatu = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: _appBar(),
          body: TabBarView(
            children: <Widget>[
              _buildApprovalForm(),
              _buildReportForm(),
              _buildHistoryForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildApprovalForm() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
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
                            style: TextStyle(color: Colors.grey[400]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 100.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Kamil',
                            style: TextStyle(
                              color: Colors.green,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  )
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
                          hintStyle: TextStyle(fontSize: 12.0)),
                      controller: controllerNoteSatu,
                      maxLines: 3,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  )
                : Container(),
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
                    'Approve',
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

Widget _buildReportForm() {
  return ListView(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(20.0),
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
                          'Dept / Process',
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
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
                          'Score / CAR',
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
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
                          'Date',
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
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
        padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 100.0,
              child: Row(
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
            Container(
              width: 100.0,
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: Text(
                      '80',
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
                      '17/09/2019',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 100.0,
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: Text(
                      'Outlet',
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
                      '3',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 100.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      'Detail',
                      style: TextStyle(
                        color: AbubaPallate.menuBluebird,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ],
  );
}

Widget _buildHistoryForm() {
  return ListView(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(20.0),
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
                          'Dept / Process',
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
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
                          'Score / CAR',
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
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
                          'Date',
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
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
        padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 100.0,
              child: Row(
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
            Container(
              width: 100.0,
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: Text(
                      '80',
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
                      '17/09/2019',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 100.0,
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: Text(
                      'Outlet',
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
                      '3',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 100.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      'Detail',
                      style: TextStyle(
                        color: AbubaPallate.menuBluebird,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ],
  );
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
          'assets/images/logo.png',
          height: 100.0,
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
    bottom: new TabBar(
      isScrollable: false,
      indicatorColor: AbubaPallate.greenabuba,
      tabs: <Widget>[
        new Tab(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Approval',
                style: TextStyle(color: Colors.grey[400]),
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.0),
                child: Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.brightness_1,
                        size: 25.0,
                        color: Colors.redAccent,
                      ),
                    ),
                    Positioned(
                      top: 8.0,
                      right: 8.0,
                      child: Text(
                        '2',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ), // 1st Tab
        new Tab(
          child: Text(
            'Report',
            style: TextStyle(color: Colors.grey[400]),
          ),
        ), // 1st Tab
        new Tab(
          child: Text(
            'History',
            style: TextStyle(color: Colors.grey[400]),
          ),
        ), // 1st Tab
      ],
    ),
  );
}
