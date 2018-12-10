import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';

class FormAuditReport extends StatefulWidget {
  @override
  _FormAuditReportState createState() => _FormAuditReportState();
}

class _FormAuditReportState extends State<FormAuditReport> {
  bool _note = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: _appBar(),
          body: TabBarView(
            children: <Widget>[
              _buildApprovalForm(),
              _buildReportForm(),
              new Text("You've Selected Third"),
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
                                'Auditor',
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
                                'Auditee',
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
                  Flexible(
                    child: Text(
                      'HRD',
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      '80',
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      '17/09/2018',
                      style: TextStyle(color: Colors.grey[500]),
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
                  Flexible(
                    child: Text(
                      'Yani',
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      '18/09/2018',
                      style: TextStyle(color: Colors.grey[500]),
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
            _note
                ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              width: 300.0,
              child: TextField(
                decoration:
                InputDecoration(border: OutlineInputBorder()),
                maxLines: 3,
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
                        border: new Border.all(color: Colors.grey)
                    ),
                    child: new Text("80 of 100", textAlign: TextAlign.center,),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    width: 100.0,

                    decoration: new BoxDecoration(
                        border: new Border.all(color: Colors.grey)
                    ),
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
                    style: TextStyle(fontSize: 12.0, color: AbubaPallate.greenabuba),
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
            Flexible(
              child: Text(
                'HRD',
                style: TextStyle(color: Colors.grey[500]),
              ),
            ),
            Flexible(
              child: Text(
                '80',
                style: TextStyle(color: Colors.grey[500]),
              ),
            ),
            Flexible(
              child: Text(
                '17/09/2018',
                style: TextStyle(color: Colors.grey[500]),
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
            Flexible(
              child: Text(
                'Yani',
                style: TextStyle(color: Colors.grey[500]),
              ),
            ),
            Flexible(
              child: Text(
                '18/09/2018',
                style: TextStyle(color: Colors.grey[500]),
              ),
            ),
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
          child: Text(
            'Approval',
            style: TextStyle(color: Colors.grey[400]),
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
